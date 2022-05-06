/*
 * Copyright (C) 2019 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "VibratorService"

#include <log/log.h>
#include "Vibrator.h"

namespace android {
namespace hardware {
namespace vibrator {
namespace V1_3 {
namespace implementation {

static constexpr uint32_t MS_PER_S = 1000;
static constexpr uint32_t NS_PER_MS = 1000000;

static const char HAPTIC_DRIVERS[] = "/sys/bus/i2c/drivers/aw8624_haptic/6-005a";

int write_value(const char *file, const char *value) {
    int fd;
    int ret;

    fd = TEMP_FAILURE_RETRY(open(file, O_WRONLY));
    if (fd < 0) {
        ALOGE("open %s failed, errno = %d", file, errno);
        return -errno;
    }

    ret = TEMP_FAILURE_RETRY(write(fd, value, strlen(value) + 1));
    if (ret == -1) {
        ret = -errno;
    } else if (ret != strlen(value) + 1) {
        ret = -EAGAIN;
    } else {
        ret = 0;
    }

    errno = 0;
    close(fd);

    return ret;
}


Vibrator::Vibrator() {
    sigevent se{};
    se.sigev_notify = SIGEV_THREAD;
    se.sigev_value.sival_ptr = this;
    se.sigev_notify_function = timerCallback;
    se.sigev_notify_attributes = nullptr;

    if (timer_create(CLOCK_REALTIME, &se, &mTimer) < 0) {
        ALOGE("Can not create timer!%s", strerror(errno));
    }
}

Return<Status> Vibrator::on(uint32_t timeoutMs) {
    return activate(timeoutMs);
}

Return<Status> Vibrator::off() {
    return activate(0);
}

Return<bool> Vibrator::supportsAmplitudeControl() {
    return false;
}

Return<Status> Vibrator::setAmplitude(uint8_t amplitude) {
    return Status::UNSUPPORTED_OPERATION;
}

Return<bool> Vibrator::supportsExternalControl() {
    return false;
}

Return<Status> Vibrator::setExternalControl(bool enabled) {
    return Status::UNSUPPORTED_OPERATION;
}

Return<void> Vibrator::perform(V1_0::Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

Return<void> Vibrator::perform_1_1(V1_1::Effect_1_1 effect, EffectStrength strength,
                                   perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

Return<void> Vibrator::perform_1_2(V1_2::Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

Return<void> Vibrator::perform_1_3(V1_3::Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

Return<void> Vibrator::perform(Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

template <typename T>
Return<void> Vibrator::perform(T effect, EffectStrength strength, perform_cb _hidl_cb) {
    _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    return Void();
}

Status Vibrator::enable(bool enabled, uint32_t ms) {
    ALOGI("Enabled: %s -> %s\n", mEnabled ? "true" : "false", enabled ? "true" : "false");
    char file[PATH_MAX];
    char value[32];
    int ret;

    snprintf(file, sizeof(file), "%s/%s", HAPTIC_DRIVERS, "duration");
    snprintf(value, sizeof(value), "%u\n", ms);
    ret = write_value(file, value);

    if (ret < 0) {
        ALOGE("Failed to turn on vibrator!");
        return Status::UNKNOWN_ERROR;
    }

    snprintf(file, sizeof(file), "%s/%s", HAPTIC_DRIVERS, "activate");
    ret = write_value(file, "1");

    if (ret < 0) {
        ALOGE("Failed to turn on vibrator!");
        return Status::UNKNOWN_ERROR;
    }

    mEnabled = enabled;
    return Status::OK;
}

Status Vibrator::activate(uint32_t ms) {
    std::lock_guard<std::mutex> lock{mMutex};
    Status status = Status::OK;

    if (ms > 0) {
        status = enable(true, ms);
        if (status != Status::OK) {
            return status;
        }
    }

    itimerspec ts{};
    ts.it_value.tv_sec = ms / MS_PER_S;
    ts.it_value.tv_nsec = ms % MS_PER_S * NS_PER_MS;

    if (timer_settime(mTimer, 0, &ts, nullptr) < 0) {
        ALOGE("Can not set timer!");
        status = Status::UNKNOWN_ERROR;
    }

    if ((status != Status::OK) || !ms) {
        Status _status;

        _status = enable(false, ms);

        if (status == Status::OK) {
            status = _status;
        }
    }

    return status;
}

void Vibrator::timeout() {
    std::lock_guard<std::mutex> lock{mMutex};
    itimerspec ts{};

    if (timer_gettime(mTimer, &ts) < 0) {
        ALOGE("Can not read timer!");
    }

    if (ts.it_value.tv_sec == 0 && ts.it_value.tv_nsec == 0) {
        enable(false, 0);
    }
}

void Vibrator::timerCallback(union sigval sigval) {
    static_cast<Vibrator*>(sigval.sival_ptr)->timeout();
}

const std::string Vibrator::effectToName(Effect effect) {
    return toString(effect);
}

uint32_t Vibrator::effectToMs(Effect effect, Status* status) {
    switch (effect) {
        case Effect::CLICK:
            return 10;
        case Effect::DOUBLE_CLICK:
            return 15;
        case Effect::TICK:
        case Effect::TEXTURE_TICK:
            return 5;
        case Effect::THUD:
            return 5;
        case Effect::POP:
            return 5;
        case Effect::HEAVY_CLICK:
            return 10;
        case Effect::RINGTONE_1:
            return 30000;
        case Effect::RINGTONE_2:
            return 30000;
        case Effect::RINGTONE_3:
            return 30000;
        case Effect::RINGTONE_4:
            return 30000;
        case Effect::RINGTONE_5:
            return 30000;
        case Effect::RINGTONE_6:
            return 30000;
        case Effect::RINGTONE_7:
            return 30000;
        case Effect::RINGTONE_8:
            return 30000;
        case Effect::RINGTONE_9:
            return 30000;
        case Effect::RINGTONE_10:
            return 30000;
        case Effect::RINGTONE_11:
            return 30000;
        case Effect::RINGTONE_12:
            return 30000;
        case Effect::RINGTONE_13:
            return 30000;
        case Effect::RINGTONE_14:
            return 30000;
        case Effect::RINGTONE_15:
            return 30000;
    }
    *status = Status::UNSUPPORTED_OPERATION;
    return 0;
}

uint8_t Vibrator::strengthToAmplitude(EffectStrength strength, Status* status) {
    switch (strength) {
        case EffectStrength::LIGHT:
            return 128;
        case EffectStrength::MEDIUM:
            return 192;
        case EffectStrength::STRONG:
            return 255;
    }
    *status = Status::UNSUPPORTED_OPERATION;
    return 0;
}

}  // namespace implementation
}  // namespace V1_3
}  // namespace vibrator
}  // namespace hardware
}  // namespace android

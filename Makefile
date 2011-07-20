include theos/makefiles/common.mk

TWEAK_NAME = StartupSound
StartupSound_FILES = Tweak.xm SndDelegate.m donator.m
StartupSound_FRAMEWORKS = AVFoundation UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

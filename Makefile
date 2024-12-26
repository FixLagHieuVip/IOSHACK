# Thiết lập các biến
THEOS_DEVICE_IP = 192.168.1.6
THEOS = /var/mobile/theos

# Thiết lập biến cho ứng dụng
APPLICATION_NAME = Aimlock 
$(APPLICATION_NAME)_FILES = main.m CYAppDelegate.m CYRootViewController.mm
$(APPLICATION_NAME)_FRAMEWORKS = $(PROJ_COMMON_FRAMEWORKS)
$(APPLICATION_NAME)_CFLAGS = -fobjc-arc
PROJ_COMMON_FRAMEWORKS = \
    UIKit \
    Foundation \
    Security \
    QuartzCore \
    CoreGraphics \
    CoreText \
    CoreData \
    CoreLocation \
    CoreMotion \
    CoreBluetooth \
    CoreImage \
    CoreML \
    ARKit \
    Metal \
    WebKit \
    GameController \
    AdSupport \
    UserNotifications \
    StoreKit \
    GameKit \
    AVFoundation \
    MobileCoreServices \
    CoreTelephony \
    SystemConfiguration \
    MediaPlayer \
    AddressBook \
    MobileCoreServices \
    MessageUI \
    WebKit \
    ReplayKit \
    UserNotifications \
    AuthenticationServices \
    GameKit \
    LocalAuthentication \
    Accounts \
    MapKit \
    AppTrackingTransparency \
    MetricKit \
    SystemConfiguration \
    CoreLocation \
    Metal \
    CoreMotion \
    Security \
    MediaToolbox \
    CoreText \
    AudioToolbox \
    AVFoundation \
    CoreGraphics \
    CoreMedia \
    Foundation \
    OpenAL \
    OpenGLES

# Khai báo các mục tiêu và quy tắc biên dịch
include $(THEOS)/makefiles/common.mk

include $(THEOS_MAKE_PATH)/application.mk

after-all::
	mkdir -p $(THEOS_STAGING_DIR)/Payload
	cp -r $(THEOS_OBJ_DIR)/$(APPLICATION_NAME).app $(THEOS_STAGING_DIR)/Payload/
	$(FAKEROOT) $(THEOS_BIN_DIR)/ldid -S $(THEOS_STAGING_DIR)/Payload/$(APPLICATION_NAME).app/$(APPLICATION_NAME)
	cd $(THEOS_STAGING_DIR) && zip -r $(APPLICATION_NAME).ipa Payload
	mv $(THEOS_STAGING_DIR)/$(APPLICATION_NAME).ipa ./

clean::
	rm -rf $(APPLICATION_NAME).ipa

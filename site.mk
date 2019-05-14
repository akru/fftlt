##	GLUON_FEATURES
#		Specify Gluon features/packages to enable;
#		Gluon will automatically enable a set of packages
#		depending on the combination of features listed

GLUON_FEATURES := \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	web-private-wifi \
	web-advanced \
	status-page \
	autoupdater \
	web-wizard \
	radvd

##	GLUON_SITE_PACKAGES
#		Specify additional Gluon/LEDE packages to include here;
#		A minus sign may be prepended to remove a packages from the
#		selection that would be enabled by default or due to the
#		chosen feature flags

GLUON_SITE_PACKAGES := \
	respondd-module-airtime \
	haveged \
	iwinfo \
	cjdns 

USB_BASIC := \
	kmod-usb-core \
	kmod-usb2

USB_NIC := \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-rtl8150 \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-dm9601-ether

USB_WIFI := \
	ath9k-htc-firmware \
	kmod-ath9k-common \
	kmod-ath9k-htc \
	kmod-ath \
	kmod-rtl8192cu \
	kmod-rtl8187 \
	kmod-carl9170 \
	kmod-rt73-usb \
	kmod-brcmfmac

ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
GLUON_SITE_PACKAGES += \
	$(USB_BASIC) \
	$(USB_NIC) \
	$(USB_WIFI)
endif

ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
GLUON_SITE_PACKAGES += \
	$(USB_BASIC) \
	$(USB_NIC) \
	$(USB_WIFI)
endif

ifeq ($(GLUON_TARGET),ar71xx-tiny)
	GLUON_SITE_PACKAGES += -cjdns
endif

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := $(shell git rev-parse --short HEAD)

# Variables set with ?= can be overwritten from the command line

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en

# Default mesh type
GLUON_ATH10K_MESH := 11s

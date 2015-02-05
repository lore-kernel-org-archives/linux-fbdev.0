From: gyungoh@gmail.com
Date: Thu, 05 Feb 2015 06:31:11 +0000
Subject: [PATCH v11 0/6] Add Skyworks SKY81452 device drivers
Message-Id: <1423117877-30667-1-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, cooloney@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org
Cc: akpm@linux-foundation.org, jic23@kernel.org, thomas.petazzoni@free-electrons.com, ktsai@capellamicro.com, hs@denx.de, stwiss.opensource@diasemi.com, matti.vaittinen@nsn.com, broonie@kernel.org, jason@lakedaemon.net, heiko@sntech.de, shawn.guo@freescale.com, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

This patch set includes regulator and backlight driver for SKY81452.
Also it includes documents for device tree and module.
sky81452-regulator was already applied. So this series doesn't
include it.

v11:
Renamed 'skyworks,en-channels' property to led-sources.
Removed unused property 'skyworks,ovp-level'.

v10:
Removed trivial get_brightness implementations for sky81452-backlight

v9:
Removed the change to remove MODULE_VERSION() for sky81452-regulator

v8:
Renamed property names for backlight with vendor prefix
Modified gpio-enable property to generic property for GPIO
Made up the example for backlight DT
Changed the DT parsing of regulator using regulator_node and of_match

v7:
Modified licensing text to GPLv2
Splitted Kconfig renaming from DT patch

v6:
Added new line character at the end of line of dev_err()

v5:
Changed DT for regulator : 'lout' node should be defined under 'regulator'
Removed compatible string from sky81452-regulator driver
Modified sky81452-regulator to return EINVAL when of_node is NULL
Move sky81452-backlight.h to include/linux/platform_data

v4:
Removed MODULE_VERSION()
Modified license to GPLv2
Removed calling to backlight_device_unregister() in sky81452-backlight

v3:
Cleaned-up DBG messages
Cleaned-up DT
Fixed the backlight name from 'sky81452-bl' to 'sky81452-backlight'
Assigned mfd_cell.of_compatible for binding device node
Modified error messages
Modified sky81452-regulator to return ENODATA when of_node is NULL

v2:
Split the patches for each sub-system
Added 'reg' attribute for I2C address in device tree documents
Added 'compatible' attribute in child drivers
Renamed CONFIG_SKY81452 to CONFIG_MFD_SKY81452
Changed the dependency from I2C=y to I2C, for CONFIG_MFD_SKY81452
Added message for exception or errors.
Added vendor prefix for Skyworks Solutions, Inc.
Add SKY81452 to the Trivial Devices list

Gyungoh Yoo (6):
  mfd: Add support for Skyworks SKY81452 driver
  backlight: Add support Skyworks SKY81452 backlight driver
  devicetree: Add new SKY81452 mfd binding
  devicetree: Add new SKY81452 backlight binding
  devicetree: Add vendor prefix for Skyworks Solutions, Inc.
  devicetree: Add SKY81452 to the Trivial Devices list

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 Documentation/devicetree/bindings/mfd/sky81452.txt |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../video/backlight/sky81452-backlight.txt         |  29 ++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/sky81452.c                             | 108 +++++++
 drivers/video/backlight/Kconfig                    |  10 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sky81452-backlight.c       | 352 +++++++++++++++++++++
 include/linux/mfd/sky81452.h                       |  31 ++
 include/linux/platform_data/sky81452-backlight.h   |  46 +++
 12 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
 create mode 100644 Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
 create mode 100644 drivers/mfd/sky81452.c
 create mode 100644 drivers/video/backlight/sky81452-backlight.c
 create mode 100644 include/linux/mfd/sky81452.h
 create mode 100644 include/linux/platform_data/sky81452-backlight.h

-- 
1.9.1


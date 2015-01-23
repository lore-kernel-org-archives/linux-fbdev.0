From: gyungoh@gmail.com
Date: Fri, 23 Jan 2015 06:28:29 +0000
Subject: [PATCH v10 0/6] Add Skyworks SKY81452 device drivers
Message-Id: <1421994515-3070-1-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417590332-4912-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1417590332-4912-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, matti.vaittinen-OYasijW0DpE@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

This patch set includes regulator and backlight driver for SKY81452.
Also it includes documents for device tree and module.
sky81452-regulator was already applied. So this series doesn't
include it.

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
  devicetree: mfd: Add new SKY81452 mfd binding
  devicetree: backlight: Add new SKY81452 backlight binding
  devicetree: Add vendor prefix for Skyworks Solutions, Inc.
  devicetree: i2c: Add SKY81452 to the Trivial Devices list

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 Documentation/devicetree/bindings/mfd/sky81452.txt |  36 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../video/backlight/sky81452-backlight.txt         |  29 ++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/sky81452.c                             | 108 +++++++
 drivers/video/backlight/Kconfig                    |  10 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sky81452-backlight.c       | 334 +++++++++++++++++++++
 include/linux/mfd/sky81452.h                       |  31 ++
 include/linux/platform_data/sky81452-backlight.h   |  46 +++
 12 files changed, 610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
 create mode 100644 Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
 create mode 100644 drivers/mfd/sky81452.c
 create mode 100644 drivers/video/backlight/sky81452-backlight.c
 create mode 100644 include/linux/mfd/sky81452.h
 create mode 100644 include/linux/platform_data/sky81452-backlight.h

-- 
1.9.1


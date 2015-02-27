From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 27 Feb 2015 20:39:38 +0000
Subject: Re: [PATCH v11 0/6] Add Skyworks SKY81452 device drivers
Message-Id: <20150227203938.GA12821@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh@gmail.com
Cc: sameo@linux.intel.com, robh+dt@kernel.org, jg1.han@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, broonie@kernel.org, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, treding@nvidia.com, p.zabel@pengutronix.de, arno@natisbad.org, kuninori.morimoto.gx@renesas.com

On Fri, 27 Feb 2015, gyungoh@gmail.com wrote:

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> This patch set includes regulator and backlight driver for SKY81452.
> Also it includes documents for device tree and module.
> sky81452-regulator was already applied. So this series doesn't
> include it.
>=20
> v11:
> Renamed 'skyworks,en-channels' property to led-sources.
> Removed unused property 'skyworks,ovp-level'.
>=20
> v10:
> Removed trivial get_brightness implementations for sky81452-backlight
>=20
> v9:
> Removed the change to remove MODULE_VERSION() for sky81452-regulator
>=20
> v8:
> Renamed property names for backlight with vendor prefix
> Modified gpio-enable property to generic property for GPIO
> Made up the example for backlight DT
> Changed the DT parsing of regulator using regulator_node and of_match
>=20
> v7:
> Modified licensing text to GPLv2
> Split Kconfig renaming from DT patch
>=20
> v6:
> Added new line character at the end of line of dev_err()
>=20
> v5:
> Changed DT for regulator : 'lout' node should be defined under 'regulator'
> Removed compatible string from sky81452-regulator driver
> Modified sky81452-regulator to return EINVAL when of_node is NULL
> Move sky81452-backlight.h to include/linux/platform_data
>=20
> v4:
> Removed MODULE_VERSION()
> Modified license to GPLv2
> Removed calling to backlight_device_unregister() in sky81452-backlight
>=20
> v3:
> Cleaned-up DBG messages
> Cleaned-up DT
> Fixed the backlight name from 'sky81452-bl' to 'sky81452-backlight'
> Assigned mfd_cell.of_compatible for binding device node
> Modified error messages
> Modified sky81452-regulator to return ENODATA when of_node is NULL
>=20
> v2:
> Split the patches for each sub-system
> Added 'reg' attribute for I2C address in device tree documents
> Added 'compatible' attribute in child drivers
> Renamed CONFIG_SKY81452 to CONFIG_MFD_SKY81452
> Changed the dependency from I2C=3Dy to I2C, for CONFIG_MFD_SKY81452
> Added message for exception or errors.
> Added vendor prefix for Skyworks Solutions, Inc.
> Add SKY81452 to the Trivial Devices list
>=20
> Gyungoh Yoo (6):
>   mfd: Add support for Skyworks SKY81452 driver
>   backlight: Add support Skyworks SKY81452 backlight driver
>   devicetree: Add new SKY81452 mfd binding
>   devicetree: Add new SKY81452 backlight binding
>   devicetree: Add vendor prefix for Skyworks Solutions, Inc.
>   devicetree: Add SKY81452 to the Trivial Devices list
>=20
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  Documentation/devicetree/bindings/mfd/sky81452.txt |  35 ++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  .../video/backlight/sky81452-backlight.txt         |  29 ++
>  drivers/mfd/Kconfig                                |  12 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/sky81452.c                             | 108 +++++++
>  drivers/video/backlight/Kconfig                    |  10 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/sky81452-backlight.c       | 353 +++++++++++++++=
++++++
>  include/linux/mfd/sky81452.h                       |  31 ++
>  include/linux/platform_data/sky81452-backlight.h   |  46 +++
>  12 files changed, 628 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/sky=
81452-backlight.txt
>  create mode 100644 drivers/mfd/sky81452.c
>  create mode 100644 drivers/video/backlight/sky81452-backlight.c
>  create mode 100644 include/linux/mfd/sky81452.h
>  create mode 100644 include/linux/platform_data/sky81452-backlight.h

Correct me if I'm wrong, but I believe you have all of the relevant
Acks now.  If so, I plan to pick this up next week and take it
through the MFD tree.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

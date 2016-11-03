From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 03 Nov 2016 08:41:47 +0000
Subject: Re: [PATCH v4 1/6] Add Advantech iManager MFD core driver
Message-Id: <20161103084147.GY13127@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161102083751.6335-1-richard.dorsch@gmail.com>
 <20161102083751.6335-2-richard.dorsch@gmail.com>
In-Reply-To: <20161102083751.6335-2-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, jdelvare@suse.com, linux@roeck-us.net, wsa@the-dreams.de, jingoohan1@gmail.com, tomi.valkeinen@ti.com, wim@iguana.be, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, k.kozlowski@samsung.com, jo.sunga@advantech.com, weilun.huang@advantech.com, andrew.chou@advantech.com

On Wed, 02 Nov 2016, Richard Vidal-Dorsch wrote:

> This patch adds Advantech iManager Embedded Controller MFD core driver.
> This mfd core dirver provides an interface for GPIO, I2C, HWmon,
> Watchdog, and Backlight/Brightness control.
>=20
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  drivers/mfd/Kconfig             |  18 +
>  drivers/mfd/Makefile            |   1 +
>  drivers/mfd/imanager-core.c     | 941 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/imanager-ec.h | 228 ++++++++++
>  include/linux/mfd/imanager.h    | 221 ++++++++++
>  5 files changed, 1409 insertions(+)
>  create mode 100644 drivers/mfd/imanager-core.c
>  create mode 100644 include/linux/mfd/imanager-ec.h
>  create mode 100644 include/linux/mfd/imanager.h

After a brief review, it is my belief that this looks like a platform
driver, which should live in drivers/platform/.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

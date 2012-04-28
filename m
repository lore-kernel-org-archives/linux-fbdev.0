From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Sat, 28 Apr 2012 02:14:03 +0000
Subject: Re: [PATCH v2] backlight: Add LMS501KF03 LCD panel driver
Message-Id: <CAK9yfHxpPqnE=JdmtUG=UJ9pD7k7pOXBzm-2uQSXQiTw9g+Z6A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334835208-32055-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1334835208-32055-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Any comments on the revised patch?

On 19 April 2012 17:03, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> LMS501KF03 is a 480x800 LCD module with brightness control.
> The driver uses 3-wired SPI inteface.
>
> Signed-off-by: Ilho Lee <Ilho215.lee@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Changes since v1:
> Incorporated review comments from Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> - Simplied lms501kf03_ldi_enable and
> lms501kf03_ldi_disable function implementations.
> ---
> =A0drivers/video/backlight/Kconfig =A0 =A0 =A0| =A0 =A08 +
> =A0drivers/video/backlight/Makefile =A0 =A0 | =A0 =A01 +
> =A0drivers/video/backlight/lms501kf03.c | =A0525 ++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 534 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/video/backlight/lms501kf03.c
>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index af16884..e216f77 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -125,6 +125,14 @@ config LCD_AMS369FG06
> =A0 =A0 =A0 =A0 =A0If you have an AMS369FG06 AMOLED Panel, say Y to enabl=
e its
> =A0 =A0 =A0 =A0 =A0LCD control driver.
>
> +config LCD_LMS501KF03
> + =A0 =A0 =A0 tristate "LMS501KF03 AMOLED LCD Driver"
> + =A0 =A0 =A0 depends on SPI_GPIO && BACKLIGHT_CLASS_DEVICE
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you have an 5.01" LMS501KF03 AMOLED Panel, say Y to =
enable its
> + =A0 =A0 =A0 =A0 LCD control driver.
> +
> =A0endif # LCD_CLASS_DEVICE
>
> =A0#
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index 36855ae..1b1e62a 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_LCD_TOSA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 +=3D tosa_lcd.o
> =A0obj-$(CONFIG_LCD_S6E63M0) =A0 =A0 =A0+=3D s6e63m0.o
> =A0obj-$(CONFIG_LCD_LD9040) =A0 =A0 =A0 +=3D ld9040.o
> =A0obj-$(CONFIG_LCD_AMS369FG06) =A0 +=3D ams369fg06.o
> +obj-$(CONFIG_LCD_LMS501KF03) =A0 +=3D lms501kf03.o
>
> =A0obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) +=3D backlight.o
> =A0obj-$(CONFIG_BACKLIGHT_ATMEL_PWM) =A0 =A0+=3D atmel-pwm-bl.o
> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlig=
ht/lms501kf03.c
> new file mode 100644
> index 0000000..af25532
> --- /dev/null
> +++ b/drivers/video/backlight/lms501kf03.c
> @@ -0,0 +1,525 @@
> +/*
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + * =A0 =A0 =A0 =A0 =A0 =A0 http://www.samsung.com/
> + *
> + * LMS501KF03 5.01" LCD module driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +#include <linux/lcd.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +
> +#define ENDDEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xFF00
> +#define COMMAND_ONLY =A0 =A0 =A0 =A0 =A0 0x00
> +#define DATA_ONLY =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> +
> +#define MIN_BRIGHTNESS =A0 =A0 =A0 =A0 0
> +#define MAX_BRIGHTNESS =A0 =A0 =A0 =A0 255
> +#define DEFAULT_BRIGHTNESS =A0 =A0 150
> +
> +#define POWER_IS_ON(power) =A0 =A0 ((power) <=3D FB_BLANK_NORMAL)
> +
> +struct lms501kf03 {
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev;
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 *spi;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0power;
> + =A0 =A0 =A0 struct lcd_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ld;
> + =A0 =A0 =A0 struct backlight_device =A0 =A0 =A0 =A0 *bd;
> + =A0 =A0 =A0 struct lcd_platform_data =A0 =A0 =A0 =A0*lcd_pd;
> +};
> +
> +const unsigned short SEQ_PASSWORD[] =3D {
> + =A0 =A0 =A0 0xb9, 0xff, 0x83, 0x69,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_POWER[] =3D {
> + =A0 =A0 =A0 0xb1, 0x01, 0x00, 0x34, 0x06, 0x00, 0x14, 0x14, 0x20, 0x28,
> + =A0 =A0 =A0 0x12, 0x12, 0x17, 0x0a, 0x01, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_DISPLAY[] =3D {
> + =A0 =A0 =A0 0xb2, 0x00, 0x2b, 0x03, 0x03, 0x70, 0x00, 0xff, 0x00, 0x00,
> + =A0 =A0 =A0 0x00, 0x00, 0x03, 0x03, 0x00, 0x01,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_RGB_IF[] =3D {
> + =A0 =A0 =A0 0xb3, 0x09,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_DISPLAY_INV[] =3D {
> + =A0 =A0 =A0 0xb4, 0x01, 0x08, 0x77, 0x0e, 0x06,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_VCOM[] =3D {
> + =A0 =A0 =A0 0xb6, 0x4c, 0x2e,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_GATE[] =3D {
> + =A0 =A0 =A0 0xd5, 0x00, 0x05, 0x03, 0x29, 0x01, 0x07, 0x17, 0x68, 0x13,
> + =A0 =A0 =A0 0x37, 0x20, 0x31, 0x8a, 0x46, 0x9b, 0x57, 0x13, 0x02, 0x75,
> + =A0 =A0 =A0 0xb9, 0x64, 0xa8, 0x07, 0x0f, 0x04, 0x07,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_PANEL[] =3D {
> + =A0 =A0 =A0 0xcc, 0x02,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_COL_MOD[] =3D {
> + =A0 =A0 =A0 0x3a, 0x77,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_W_GAMMA[] =3D {
> + =A0 =A0 =A0 0xe0, 0x00, 0x04, 0x09, 0x0f, 0x1f, 0x3f, 0x1f, 0x2f, 0x0a,
> + =A0 =A0 =A0 0x0f, 0x10, 0x16, 0x18, 0x16, 0x17, 0x0d, 0x15, 0x00, 0x04,
> + =A0 =A0 =A0 0x09, 0x0f, 0x38, 0x3f, 0x20, 0x39, 0x0a, 0x0f, 0x10, 0x16,
> + =A0 =A0 =A0 0x18, 0x16, 0x17, 0x0d, 0x15,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_RGB_GAMMA[] =3D {
> + =A0 =A0 =A0 0xc1, 0x01, 0x03, 0x07, 0x0f, 0x1a, 0x22, 0x2c, 0x33, 0x3c,
> + =A0 =A0 =A0 0x46, 0x4f, 0x58, 0x60, 0x69, 0x71, 0x79, 0x82, 0x89, 0x92,
> + =A0 =A0 =A0 0x9a, 0xa1, 0xa9, 0xb1, 0xb9, 0xc1, 0xc9, 0xcf, 0xd6, 0xde,
> + =A0 =A0 =A0 0xe5, 0xec, 0xf3, 0xf9, 0xff, 0xdd, 0x39, 0x07, 0x1c, 0xcb,
> + =A0 =A0 =A0 0xab, 0x5f, 0x49, 0x80, 0x03, 0x07, 0x0f, 0x19, 0x20, 0x2a,
> + =A0 =A0 =A0 0x31, 0x39, 0x42, 0x4b, 0x53, 0x5b, 0x63, 0x6b, 0x73, 0x7b,
> + =A0 =A0 =A0 0x83, 0x8a, 0x92, 0x9b, 0xa2, 0xaa, 0xb2, 0xba, 0xc2, 0xca,
> + =A0 =A0 =A0 0xd0, 0xd8, 0xe1, 0xe8, 0xf0, 0xf8, 0xff, 0xf7, 0xd8, 0xbe,
> + =A0 =A0 =A0 0xa7, 0x39, 0x40, 0x85, 0x8c, 0xc0, 0x04, 0x07, 0x0c, 0x17,
> + =A0 =A0 =A0 0x1c, 0x23, 0x2b, 0x34, 0x3b, 0x43, 0x4c, 0x54, 0x5b, 0x63,
> + =A0 =A0 =A0 0x6a, 0x73, 0x7a, 0x82, 0x8a, 0x91, 0x98, 0xa1, 0xa8, 0xb0,
> + =A0 =A0 =A0 0xb7, 0xc1, 0xc9, 0xcf, 0xd9, 0xe3, 0xea, 0xf4, 0xff, 0x00,
> + =A0 =A0 =A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_UP_DN[] =3D {
> + =A0 =A0 =A0 0x36, 0x10,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_SLEEP_IN[] =3D {
> + =A0 =A0 =A0 0x10,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_SLEEP_OUT[] =3D {
> + =A0 =A0 =A0 0x11,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_DISPLAY_ON[] =3D {
> + =A0 =A0 =A0 0x29,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +const unsigned short SEQ_DISPLAY_OFF[] =3D {
> + =A0 =A0 =A0 0x10,
> + =A0 =A0 =A0 ENDDEF
> +};
> +
> +static int lms501kf03_spi_write_byte(struct lms501kf03 *lcd, int addr, i=
nt data)
> +{
> + =A0 =A0 =A0 u16 buf[1];
> + =A0 =A0 =A0 struct spi_message msg;
> +
> + =A0 =A0 =A0 struct spi_transfer xfer =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =A0 =A0=3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D buf,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 buf[0] =3D (addr << 8) | data;
> +
> + =A0 =A0 =A0 spi_message_init(&msg);
> + =A0 =A0 =A0 spi_message_add_tail(&xfer, &msg);
> +
> + =A0 =A0 =A0 return spi_sync(lcd->spi, &msg);
> +}
> +
> +static int lms501kf03_spi_write(struct lms501kf03 *lcd, unsigned char ad=
dress,
> + =A0 =A0 =A0 unsigned char command)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 ret =3D lms501kf03_spi_write_byte(lcd, address, command);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int lms501kf03_panel_send_sequence(struct lms501kf03 *lcd,
> + =A0 =A0 =A0 const unsigned short *wbuf)
> +{
> + =A0 =A0 =A0 int ret =3D 0, i =3D 0;
> +
> + =A0 =A0 =A0 while (wbuf[i] !=3D ENDDEF) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lms501kf03_spi_writ=
e(lcd, COMMAND_ONLY, wbuf[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lms501kf03_spi_writ=
e(lcd, DATA_ONLY, wbuf[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(100);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i +=3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int lms501kf03_ldi_init(struct lms501kf03 *lcd)
> +{
> + =A0 =A0 =A0 int ret, i;
> + =A0 =A0 =A0 const unsigned short *init_seq[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_PASSWORD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_POWER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_DISPLAY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_RGB_IF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_DISPLAY_INV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_VCOM,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_GATE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_PANEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_COL_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_W_GAMMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_RGB_GAMMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_SLEEP_OUT,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(init_seq); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lms501kf03_panel_send_sequence(lcd,=
 init_seq[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mdelay(120);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int lms501kf03_ldi_enable(struct lms501kf03 *lcd)
> +{
> + =A0 =A0 =A0 return lms501kf03_panel_send_sequence(lcd, SEQ_DISPLAY_ON);
> +}
> +
> +static int lms501kf03_ldi_disable(struct lms501kf03 *lcd)
> +{
> + =A0 =A0 =A0 return lms501kf03_panel_send_sequence(lcd, SEQ_DISPLAY_OFF);
> +}
> +
> +static int lms501kf03_power_on(struct lms501kf03 *lcd)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct lcd_platform_data *pd =3D NULL;
> + =A0 =A0 =A0 struct backlight_device *bd =3D NULL;
> +
> + =A0 =A0 =A0 pd =3D lcd->lcd_pd;
> + =A0 =A0 =A0 if (!pd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "platform data is NULL.\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bd =3D lcd->bd;
> + =A0 =A0 =A0 if (!bd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "backlight device is NULL=
.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!pd->power_on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "power_on is NULL.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->power_on(lcd->ld, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(pd->power_on_delay);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!pd->reset) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "reset is NULL.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->reset(lcd->ld);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(pd->reset_delay);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D lms501kf03_ldi_init(lcd);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "failed to initialize ldi=
.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D lms501kf03_ldi_enable(lcd);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "failed to enable ldi.\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int lms501kf03_power_off(struct lms501kf03 *lcd)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct lcd_platform_data *pd =3D NULL;
> +
> + =A0 =A0 =A0 pd =3D lcd->lcd_pd;
> + =A0 =A0 =A0 if (!pd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "platform data is NULL\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D lms501kf03_ldi_disable(lcd);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "lcd setting failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mdelay(pd->power_off_delay);
> +
> + =A0 =A0 =A0 if (!pd->power_on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "power_on is NULL.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->power_on(lcd->ld, 0);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int lms501kf03_power(struct lms501kf03 *lcd, int power)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (POWER_IS_ON(power) && !POWER_IS_ON(lcd->power))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lms501kf03_power_on(lcd);
> + =A0 =A0 =A0 else if (!POWER_IS_ON(power) && POWER_IS_ON(lcd->power))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lms501kf03_power_off(lcd);
> +
> + =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->power =3D power;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int lms501kf03_get_power(struct lcd_device *ld)
> +{
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D lcd_get_data(ld);
> +
> + =A0 =A0 =A0 return lcd->power;
> +}
> +
> +static int lms501kf03_set_power(struct lcd_device *ld, int power)
> +{
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D lcd_get_data(ld);
> +
> + =A0 =A0 =A0 if (power !=3D FB_BLANK_UNBLANK && power !=3D FB_BLANK_POWE=
RDOWN &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 power !=3D FB_BLANK_NORMAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "power value should be 0,=
 1 or 4.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return lms501kf03_power(lcd, power);
> +}
> +
> +static int lms501kf03_get_brightness(struct backlight_device *bd)
> +{
> + =A0 =A0 =A0 return bd->props.brightness;
> +}
> +
> +static int lms501kf03_set_brightness(struct backlight_device *bd)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int brightness =3D bd->props.brightness;
> +
> + =A0 =A0 =A0 if (brightness < MIN_BRIGHTNESS ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brightness > bd->props.max_brightness) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&bd->dev, "lcd brightness should be=
 %d to %d.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIN_BRIGHTNESS, MAX_BRIGHTN=
ESS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct lcd_ops lms501kf03_lcd_ops =3D {
> + =A0 =A0 =A0 .get_power =3D lms501kf03_get_power,
> + =A0 =A0 =A0 .set_power =3D lms501kf03_set_power,
> +};
> +
> +static const struct backlight_ops lms501kf03_backlight_ops =3D {
> + =A0 =A0 =A0 .get_brightness =3D lms501kf03_get_brightness,
> + =A0 =A0 =A0 .update_status =3D lms501kf03_set_brightness,
> +};
> +
> +static int __devinit lms501kf03_probe(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D NULL;
> + =A0 =A0 =A0 struct lcd_device *ld =3D NULL;
> + =A0 =A0 =A0 struct backlight_device *bd =3D NULL;
> + =A0 =A0 =A0 struct backlight_properties props;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 lcd =3D kzalloc(sizeof(struct lms501kf03), GFP_KERNEL);
> + =A0 =A0 =A0 if (!lcd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 /* lms501kf03 lcd panel uses 3-wire 9-bit SPI Mode. */
> + =A0 =A0 =A0 spi->bits_per_word =3D 9;
> +
> + =A0 =A0 =A0 ret =3D spi_setup(spi);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "spi setup failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_lcd;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 lcd->spi =3D spi;
> + =A0 =A0 =A0 lcd->dev =3D &spi->dev;
> +
> + =A0 =A0 =A0 lcd->lcd_pd =3D (struct lcd_platform_data *)spi->dev.platfo=
rm_data;
> + =A0 =A0 =A0 if (!lcd->lcd_pd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "platform data is NULL\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_lcd;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ld =3D lcd_device_register("lms501kf03", &spi->dev, lcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lms501kf03_lcd_ops);
> + =A0 =A0 =A0 if (IS_ERR(ld)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(ld);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_lcd;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 lcd->ld =3D ld;
> +
> + =A0 =A0 =A0 memset(&props, 0, sizeof(struct backlight_properties));
> + =A0 =A0 =A0 props.type =3D BACKLIGHT_RAW;
> + =A0 =A0 =A0 props.max_brightness =3D MAX_BRIGHTNESS;
> +
> + =A0 =A0 =A0 bd =3D backlight_device_register("lms501kf03-bl", &spi->dev=
, lcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lms501kf03_backlight_ops, &props);
> + =A0 =A0 =A0 if (IS_ERR(bd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_lcd_unregister;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bd->props.brightness =3D DEFAULT_BRIGHTNESS;
> + =A0 =A0 =A0 lcd->bd =3D bd;
> +
> + =A0 =A0 =A0 if (!lcd->lcd_pd->lcd_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if lcd panel was off from bootloader t=
hen
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* current lcd status is powerdown and th=
en
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it enables lcd panel.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->power =3D FB_BLANK_POWERDOWN;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lms501kf03_power(lcd, FB_BLANK_UNBLANK);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->power =3D FB_BLANK_UNBLANK;
> +
> + =A0 =A0 =A0 dev_set_drvdata(&spi->dev, lcd);
> +
> + =A0 =A0 =A0 dev_info(&spi->dev, "lms501kf03 panel driver has been probe=
d.\n");
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_lcd_unregister:
> + =A0 =A0 =A0 lcd_device_unregister(ld);
> +out_free_lcd:
> + =A0 =A0 =A0 kfree(lcd);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit lms501kf03_remove(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D dev_get_drvdata(&spi->dev);
> +
> + =A0 =A0 =A0 lms501kf03_power(lcd, FB_BLANK_POWERDOWN);
> + =A0 =A0 =A0 lcd_device_unregister(lcd->ld);
> + =A0 =A0 =A0 kfree(lcd);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#if defined(CONFIG_PM)
> +unsigned int before_power;
> +
> +static int lms501kf03_suspend(struct spi_device *spi, pm_message_t mesg)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D dev_get_drvdata(&spi->dev);
> +
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "lcd->power =3D %d\n", lcd->power);
> +
> + =A0 =A0 =A0 before_power =3D lcd->power;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* when lcd panel is suspend, lcd panel becomes off
> + =A0 =A0 =A0 =A0* regardless of status.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D lms501kf03_power(lcd, FB_BLANK_POWERDOWN);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int lms501kf03_resume(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D dev_get_drvdata(&spi->dev);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* after suspended, if lcd panel status is FB_BLANK_UNBLA=
NK
> + =A0 =A0 =A0 =A0* (at that time, before_power is FB_BLANK_UNBLANK) then
> + =A0 =A0 =A0 =A0* it changes that status to FB_BLANK_POWERDOWN to get lc=
d on.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (before_power =3D FB_BLANK_UNBLANK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd->power =3D FB_BLANK_POWERDOWN;
> +
> + =A0 =A0 =A0 dev_dbg(&spi->dev, "before_power =3D %d\n", before_power);
> +
> + =A0 =A0 =A0 ret =3D lms501kf03_power(lcd, before_power);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +#else
> +#define lms501kf03_suspend =A0 =A0 NULL
> +#define lms501kf03_resume =A0 =A0 =A0NULL
> +#endif
> +
> +void lms501kf03_shutdown(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct lms501kf03 *lcd =3D dev_get_drvdata(&spi->dev);
> +
> + =A0 =A0 =A0 lms501kf03_power(lcd, FB_BLANK_POWERDOWN);
> +}
> +
> +static struct spi_driver lms501kf03_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "lms501kf03",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus =A0 =A0=3D &spi_bus_type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D lms501kf03_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(lms501kf03_remove),
> + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D lms501kf03_shutdown,
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D lms501kf03_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D lms501kf03_resume,
> +};
> +
> +module_spi_driver(lms501kf03_driver);
> +
> +MODULE_AUTHOR("Ilho Lee <Ilho215.lee@samsung.com>");
> +MODULE_AUTHOR("Sachin Kamat <sachin.kamat@samsung.com>");
> +MODULE_DESCRIPTION("LMS501KF03 LCD Driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.4.1
>



--=20
With warm regards,
Sachin

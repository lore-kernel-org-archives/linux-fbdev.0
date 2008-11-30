From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 1/2] lcd: add support for Toppoly
 TDO35S series to tdo24m driver
Date: Sun, 30 Nov 2008 09:32:06 +0200
Message-ID: <49324176.8040904@compulab.co.il>
References: <492E8349.40309@compulab.co.il>
	<f17812d70811271713v7cc0e798pcd3c35bf2b3c84e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>) id 1L6gmz-0006jl-Sr
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 07:32:21 +0000
Received: from 89.6b.364a.static.theplanet.com ([74.54.107.137]
	helo=cathcart.site5.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L6gmv-0001id-Pk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 07:32:21 +0000
In-Reply-To: <f17812d70811271713v7cc0e798pcd3c35bf2b3c84e8@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, eric miao <eric.miao@marvell.com>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

Eric Miao wrote:
> Looks generally OK, yet I'd prefer
> 
>   1. tdo24m.h being placed in "include/linux/spi/"
>   2. when platform_data == NULL, default to TDO24M model?

Ok, no problem.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 drivers/video/backlight/Kconfig  |    4 +-
 drivers/video/backlight/tdo24m.c |   95 ++++++++++++++++++++++++++++++++++---
 include/linux/spi/tdo24m.h       |   13 +++++
 3 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4a4dd9a..7ee2313 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -52,11 +52,11 @@ config LCD_ILI9320
 	  then say y to include a power driver for it.

 config LCD_TDO24M
-	tristate "Toppoly TDO24M LCD Panels support"
+	tristate "Toppoly TDO24M  and TDO35S LCD Panels support"
 	depends on LCD_CLASS_DEVICE && SPI_MASTER
 	default n
 	help
-	  If you have a Toppoly TDO24M series LCD panel, say y here to
+	  If you have a Toppoly TDO24M/TDO35S series LCD panel, say y here to
 	  include the support for it.

 config LCD_VGG2432A4
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index 8427669..aa5111d 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -14,9 +14,11 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tdo24m.h>
 #include <linux/fb.h>
 #include <linux/lcd.h>

+
 #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)

 #define TDO24M_SPI_BUFF_SIZE	(4)
@@ -31,6 +33,9 @@ struct tdo24m {
 	struct spi_transfer	xfer;
 	uint8_t			*buf;

+	int (*adj_mode)(struct tdo24m *lcd, int mode);
+	int color_invert;
+
 	int			power;
 	int			mode;
 };
@@ -66,7 +71,7 @@ static uint32_t lcd_panel_off[] = {
 	CMD_NULL,
 };

-static uint32_t lcd_vga_pass_through[] = {
+static uint32_t lcd_vga_pass_through_tdo24m[] = {
 	CMD1(0xB0, 0x16),
 	CMD1(0xBC, 0x80),
 	CMD1(0xE1, 0x00),
@@ -75,7 +80,7 @@ static uint32_t lcd_vga_pass_through[] = {
 	CMD_NULL,
 };

-static uint32_t lcd_qvga_pass_through[] = {
+static uint32_t lcd_qvga_pass_through_tdo24m[] = {
 	CMD1(0xB0, 0x16),
 	CMD1(0xBC, 0x81),
 	CMD1(0xE1, 0x00),
@@ -84,7 +89,7 @@ static uint32_t lcd_qvga_pass_through[] = {
 	CMD_NULL,
 };

-static uint32_t lcd_vga_transfer[] = {
+static uint32_t lcd_vga_transfer_tdo24m[] = {
 	CMD1(0xcf, 0x02), 	/* Blanking period control (1) */
 	CMD2(0xd0, 0x08, 0x04),	/* Blanking period control (2) */
 	CMD1(0xd1, 0x01),	/* CKV timing control on/off */
@@ -110,6 +115,35 @@ static uint32_t lcd_qvga_transfer[] = {
 	CMD_NULL,
 };

+static uint32_t lcd_vga_pass_through_tdo35s[] = {
+	CMD1(0xB0, 0x16),
+	CMD1(0xBC, 0x80),
+	CMD1(0xE1, 0x00),
+	CMD1(0x3B, 0x00),
+	CMD_NULL,
+};
+
+static uint32_t lcd_qvga_pass_through_tdo35s[] = {
+	CMD1(0xB0, 0x16),
+	CMD1(0xBC, 0x81),
+	CMD1(0xE1, 0x00),
+	CMD1(0x3B, 0x22),
+	CMD_NULL,
+};
+
+static uint32_t lcd_vga_transfer_tdo35s[] = {
+	CMD1(0xcf, 0x02), 	/* Blanking period control (1) */
+	CMD2(0xd0, 0x08, 0x04),	/* Blanking period control (2) */
+	CMD1(0xd1, 0x01),	/* CKV timing control on/off */
+	CMD2(0xd2, 0x00, 0x1e),	/* CKV 1,2 timing control */
+	CMD2(0xd3, 0x14, 0x28),	/* OEV timing control */
+	CMD2(0xd4, 0x28, 0x64),	/* ASW timing control (1) */
+	CMD1(0xd5, 0x28),	/* ASW timing control (2) */
+	CMD0(0x21),		/* Invert for normally black display */
+	CMD0(0x29),		/* Display on */
+	CMD_NULL,
+};
+
 static uint32_t lcd_panel_config[] = {
 	CMD2(0xb8, 0xff, 0xf9),	/* Output control */
 	CMD0(0x11),		/* sleep out */
@@ -148,6 +182,8 @@ static int tdo24m_writes(struct tdo24m *lcd, uint32_t *array)
 	int nparams, err = 0;

 	for (; *p != CMD_NULL; p++) {
+		if (!lcd->color_invert && *p == CMD0(0x21))
+			continue;

 		nparams = (*p >> 30) & 0x3;

@@ -184,12 +220,33 @@ static int tdo24m_adj_mode(struct tdo24m *lcd, int mode)
 {
 	switch (mode) {
 	case MODE_VGA:
-		tdo24m_writes(lcd, lcd_vga_pass_through);
+		tdo24m_writes(lcd, lcd_vga_pass_through_tdo24m);
 		tdo24m_writes(lcd, lcd_panel_config);
-		tdo24m_writes(lcd, lcd_vga_transfer);
+		tdo24m_writes(lcd, lcd_vga_transfer_tdo24m);
 		break;
 	case MODE_QVGA:
-		tdo24m_writes(lcd, lcd_qvga_pass_through);
+		tdo24m_writes(lcd, lcd_qvga_pass_through_tdo24m);
+		tdo24m_writes(lcd, lcd_panel_config);
+		tdo24m_writes(lcd, lcd_qvga_transfer);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	lcd->mode = mode;
+	return 0;
+}
+
+static int tdo35s_adj_mode(struct tdo24m *lcd, int mode)
+{
+	switch (mode) {
+	case MODE_VGA:
+		tdo24m_writes(lcd, lcd_vga_pass_through_tdo35s);
+		tdo24m_writes(lcd, lcd_panel_config);
+		tdo24m_writes(lcd, lcd_vga_transfer_tdo35s);
+		break;
+	case MODE_QVGA:
+		tdo24m_writes(lcd, lcd_qvga_pass_through_tdo35s);
 		tdo24m_writes(lcd, lcd_panel_config);
 		tdo24m_writes(lcd, lcd_qvga_transfer);
 		break;
@@ -213,7 +270,7 @@ static int tdo24m_power_on(struct tdo24m *lcd)
 	if (err)
 		goto out;

-	err = tdo24m_adj_mode(lcd, lcd->mode);
+	err = lcd->adj_mode(lcd, lcd->mode);
 out:
 	return err;
 }
@@ -262,7 +319,7 @@ static int tdo24m_set_mode(struct lcd_device *ld, struct fb_videomode *m)
 	if (lcd->mode == mode)
 		return 0;

-	return tdo24m_adj_mode(lcd, mode);
+	return lcd->adj_mode(lcd, mode);
 }

 static struct lcd_ops tdo24m_ops = {
@@ -276,8 +333,16 @@ static int __devinit tdo24m_probe(struct spi_device *spi)
 	struct tdo24m *lcd;
 	struct spi_message *m;
 	struct spi_transfer *x;
+	struct tdo24m_platform_data *pdata;
+	enum tdo24m_model model;
 	int err;

+	pdata = spi->dev.platform_data;
+	if (pdata)
+		model = pdata->model;
+	else
+		model = TDO24M;
+
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_3;
 	err = spi_setup(spi);
@@ -306,6 +371,20 @@ static int __devinit tdo24m_probe(struct spi_device *spi)
 	x->tx_buf = &lcd->buf[0];
 	spi_message_add_tail(x, m);

+	switch (model) {
+	case TDO24M:
+		lcd->color_invert = 1;
+		lcd->adj_mode = tdo24m_adj_mode;
+		break;
+	case TDO35S:
+		lcd->adj_mode = tdo35s_adj_mode;
+		lcd->color_invert = 0;
+		break;
+	default:
+		dev_err(&spi->dev, "Unsupported model");
+		goto out_free;
+	}
+
 	lcd->lcd_dev = lcd_device_register("tdo24m", &spi->dev,
 					lcd, &tdo24m_ops);
 	if (IS_ERR(lcd->lcd_dev)) {
diff --git a/include/linux/spi/tdo24m.h b/include/linux/spi/tdo24m.h
new file mode 100644
index 0000000..7572d4e
--- /dev/null
+++ b/include/linux/spi/tdo24m.h
@@ -0,0 +1,13 @@
+#ifndef __TDO24M_H__
+#define __TDO24M_H__
+
+enum tdo24m_model {
+	TDO24M,
+	TDO35S,
+};
+
+struct tdo24m_platform_data {
+	enum tdo24m_model model;
+};
+
+#endif /* __TDO24M_H__ */


-- 
Sincerely yours,
Mike.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

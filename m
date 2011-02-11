From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Date: Fri, 11 Feb 2011 15:19:43 +0000
Subject: [PATCH 1/2] atmel_lcdfb: implement inverted contrast pwm
Message-Id: <1297437584-14048-1-git-send-email-biessmann@corscience.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: kernel@avr32linux.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>, "open list:ATMEL LCDFB DRIVER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

 This patch introduces lcdc->lcdcon_pol_negative which set CONTRAST_CTR
 register to inverted polarity.

Signed-off-by: Andreas Bie=C3=9Fmann <biessmann@corscience.de>
---
These are some older patches which are used in some of our systems. Heavy
merging pointed out these functionality was missed to push upstream.

 drivers/video/atmel_lcdfb.c |    7 ++++++-
 include/video/atmel_lcdc.h  |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index bac16345..16da8af 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -68,7 +68,7 @@ static void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_i=
nfo *sinfo,
 }
 #endif
=20
-static const u32 contrast_ctr =3D ATMEL_LCDC_PS_DIV8
+static u32 contrast_ctr =3D ATMEL_LCDC_PS_DIV8
 		| ATMEL_LCDC_POL_POSITIVE
 		| ATMEL_LCDC_ENA_PWMENABLE;
=20
@@ -163,6 +163,10 @@ static void exit_backlight(struct atmel_lcdfb_info *si=
nfo)
=20
 static void init_contrast(struct atmel_lcdfb_info *sinfo)
 {
+	/* contrast pwm can be 'inverted' */
+	if (sinfo->lcdcon_pol_negative)
+			contrast_ctr &=3D ~(ATMEL_LCDC_POL_POSITIVE);
+
 	/* have some default contrast/backlight settings */
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
@@ -816,6 +820,7 @@ static int __init atmel_lcdfb_probe(struct platform_dev=
ice *pdev)
 		sinfo->guard_time =3D pdata_sinfo->guard_time;
 		sinfo->smem_len =3D pdata_sinfo->smem_len;
 		sinfo->lcdcon_is_backlight =3D pdata_sinfo->lcdcon_is_backlight;
+		sinfo->lcdcon_pol_negative =3D pdata_sinfo->lcdcon_pol_negative;
 		sinfo->lcd_wiring_mode =3D pdata_sinfo->lcd_wiring_mode;
 	} else {
 		dev_err(dev, "cannot get default configuration\n");
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 0c864db..28447f1 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -52,6 +52,7 @@ struct atmel_lcdfb_info {
 	u8			bl_power;
 #endif
 	bool			lcdcon_is_backlight;
+	bool			lcdcon_pol_negative;
 	u8			saved_lcdcon;
=20
 	u8			default_bpp;
--=20
1.7.2.3


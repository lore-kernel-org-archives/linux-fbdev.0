From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: add TFT support
Date: Tue,  2 Sep 2008 13:24:55 +0200
Message-ID: <1220354697-13648-13-git-send-email-s.hauer@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaU6Z-0001JG-MF for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:31:27 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaU6X-0000cn-Ot
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:31:27 -0700
In-Reply-To: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Dyer <amdyer@gmail.com>

From: sascha Hauer <s.hauer@pengutronix.de>

With TFTs we can do 5/6/5 instead of 4/4/4. Add a bitfield for this
and use it with TFTs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 3d1db00..4757ec6 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -116,16 +116,10 @@ struct imxfb_rgb {
 	struct fb_bitfield	transp;
 };
 
-#define RGB_16	(0)
-#define RGB_8	(1)
-#define NR_RGB	2
-
 struct imxfb_info {
 	struct platform_device  *pdev;
 	void __iomem		*regs;
 
-	struct imxfb_rgb	*rgb[NR_RGB];
-
 	u_int			max_bpp;
 	u_int			max_xres;
 	u_int			max_yres;
@@ -165,7 +159,14 @@ struct imxfb_info {
 #define MIN_XRES	64
 #define MIN_YRES	64
 
-static struct imxfb_rgb def_rgb_16 = {
+static struct imxfb_rgb def_rgb_16_tft = {
+	.red	= {.offset = 11, .length = 5,},
+	.green	= {.offset = 5, .length = 6,},
+	.blue	= {.offset = 0, .length = 5,},
+	.transp = {.offset = 0, .length = 0,},
+};
+
+static struct imxfb_rgb def_rgb_16_stn = {
 	.red	= {.offset = 8, .length = 4,},
 	.green	= {.offset = 4, .length = 4,},
 	.blue	= {.offset = 0, .length = 4,},
@@ -270,7 +271,7 @@ static int imxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct imxfb_info *fbi = info->par;
-	int rgbidx;
+	struct imxfb_rgb *rgb;
 
 	if (var->xres < MIN_XRES)
 		var->xres = MIN_XRES;
@@ -286,23 +287,25 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	pr_debug("var->bits_per_pixel=%d\n", var->bits_per_pixel);
 	switch (var->bits_per_pixel) {
 	case 16:
-		rgbidx = RGB_16;
+	default:
+		if (ioread32(fbi->regs + LCDC_PCR) & PCR_TFT)
+			rgb = &def_rgb_16_tft;
+		else
+			rgb = &def_rgb_16_stn;
 		break;
 	case 8:
-		rgbidx = RGB_8;
+		rgb = &def_rgb_8;
 		break;
-	default:
-		rgbidx = RGB_16;
 	}
 
 	/*
 	 * Copy the RGB parameters for this display
 	 * from the machine specific parameters.
 	 */
-	var->red    = fbi->rgb[rgbidx]->red;
-	var->green  = fbi->rgb[rgbidx]->green;
-	var->blue   = fbi->rgb[rgbidx]->blue;
-	var->transp = fbi->rgb[rgbidx]->transp;
+	var->red    = rgb->red;
+	var->green  = rgb->green;
+	var->blue   = rgb->blue;
+	var->transp = rgb->transp;
 
 	pr_debug("RGBT length = %d:%d:%d:%d\n",
 		var->red.length, var->green.length, var->blue.length,
@@ -545,9 +548,6 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 	info->flags			= FBINFO_FLAG_DEFAULT |
 					  FBINFO_READS_FAST;
 
-	fbi->rgb[RGB_16]		= &def_rgb_16;
-	fbi->rgb[RGB_8]			= &def_rgb_8;
-
 	fbi->max_xres			= pdata->xres;
 	info->var.xres			= pdata->xres;
 	info->var.xres_virtual		= pdata->xres;
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

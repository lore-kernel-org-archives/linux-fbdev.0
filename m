From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: remove gpio setup
	function
Date: Tue,  2 Sep 2008 13:24:44 +0200
Message-ID: <1220354697-13648-2-git-send-email-s.hauer@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaU0g-0000eO-Mi for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:25:22 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaU0f-0000Et-Tu
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:25:22 -0700
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

Remove the gpio mux setup function from i.MX framebuffer driver.
This function is platform specific and thus should be done by
the board setup. As there are currently no in-kernel users
of this driver we do not break anything.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |   53 -------------------------------------------------
 1 files changed, 0 insertions(+), 53 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index ccd9861..a990d43 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -357,57 +357,6 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	return 0;
 }
 
-static void imxfb_setup_gpio(struct imxfb_info *fbi)
-{
-	int width;
-
-	LCDC_RMCR	&= ~(RMCR_LCDC_EN | RMCR_SELF_REF);
-
-	if( fbi->pcr & PCR_TFT )
-		width = 16;
-	else
-		width = 1 << ((fbi->pcr >> 28) & 0x3);
-
-	switch(width) {
-	case 16:
-		imx_gpio_mode(PD30_PF_LD15);
-		imx_gpio_mode(PD29_PF_LD14);
-		imx_gpio_mode(PD28_PF_LD13);
-		imx_gpio_mode(PD27_PF_LD12);
-		imx_gpio_mode(PD26_PF_LD11);
-		imx_gpio_mode(PD25_PF_LD10);
-		imx_gpio_mode(PD24_PF_LD9);
-		imx_gpio_mode(PD23_PF_LD8);
-	case 8:
-		imx_gpio_mode(PD22_PF_LD7);
-		imx_gpio_mode(PD21_PF_LD6);
-		imx_gpio_mode(PD20_PF_LD5);
-		imx_gpio_mode(PD19_PF_LD4);
-	case 4:
-		imx_gpio_mode(PD18_PF_LD3);
-		imx_gpio_mode(PD17_PF_LD2);
-	case 2:
-		imx_gpio_mode(PD16_PF_LD1);
-	case 1:
-		imx_gpio_mode(PD15_PF_LD0);
-	}
-
-	/* initialize GPIOs */
-	imx_gpio_mode(PD6_PF_LSCLK);
-	imx_gpio_mode(PD11_PF_CONTRAST);
-	imx_gpio_mode(PD14_PF_FLM_VSYNC);
-	imx_gpio_mode(PD13_PF_LP_HSYNC);
-	imx_gpio_mode(PD12_PF_ACD_OE);
-
-	/* These are only needed for Sharp HR TFT displays */
-	if (fbi->pcr & PCR_SHARP) {
-		imx_gpio_mode(PD7_PF_REV);
-		imx_gpio_mode(PD8_PF_CLS);
-		imx_gpio_mode(PD9_PF_PS);
-		imx_gpio_mode(PD10_PF_SPL_SPR);
-	}
-}
-
 #ifdef CONFIG_PM
 /*
  * Power management hooks.  Note that we won't be called from IRQ context,
@@ -594,8 +543,6 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto failed_cmap;
 
-	imxfb_setup_gpio(fbi);
-
 	imxfb_set_par(info);
 	ret = register_framebuffer(info);
 	if (ret < 0) {
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

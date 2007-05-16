From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/10] imxfb: remove ifdefs
Date: Thu, 17 May 2007 05:23:10 +0800
Message-ID: <464B763E.4070700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9o-0005w0-9A for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:40 -0700
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9n-0003Tr-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:40 -0700
Received: by wr-out-0506.google.com with SMTP id i20so716473wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:38 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Sascha Hauer <s.hauer@pengutronix.de>

Here are some small fixes for the imxfb framebuffer driver:

- remove ifndef for MX1FS2 platform which is not present in the kernel.
- REV, CLS, PS and SPL_SPR are only needed with some sharp displays.
  Only setup the corresponding io pins when such a display is connected.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/imxfb.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 267c1ff..6cdf269 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -394,26 +394,18 @@ static void imxfb_setup_gpio(struct imxf
 
 	/* initialize GPIOs */
 	imx_gpio_mode(PD6_PF_LSCLK);
-	imx_gpio_mode(PD10_PF_SPL_SPR);
 	imx_gpio_mode(PD11_PF_CONTRAST);
 	imx_gpio_mode(PD14_PF_FLM_VSYNC);
 	imx_gpio_mode(PD13_PF_LP_HSYNC);
-	imx_gpio_mode(PD7_PF_REV);
-	imx_gpio_mode(PD8_PF_CLS);
-
-#ifndef CONFIG_MACH_PIMX1
-	/* on PiMX1 used as buffers enable signal
-	 */
-	imx_gpio_mode(PD9_PF_PS);
-#endif
-
-#ifndef CONFIG_MACH_MX1FS2
-	/* on mx1fs2 this pin is used to (de)activate the display, so we need
-	 * it as a normal gpio
-	 */
 	imx_gpio_mode(PD12_PF_ACD_OE);
-#endif
 
+	/* These are only needed for Sharp HR TFT displays */
+	if (fbi->pcr & PCR_SHARP) {
+		imx_gpio_mode(PD7_PF_REV);
+		imx_gpio_mode(PD8_PF_CLS);
+		imx_gpio_mode(PD9_PF_PS);
+		imx_gpio_mode(PD10_PF_SPL_SPR);
+	}
 }
 
 #ifdef CONFIG_PM
@@ -499,6 +491,7 @@ static int __init imxfb_init_fbinfo(stru
 	info->var.sync			= inf->sync;
 	info->var.grayscale		= inf->cmap_greyscale;
 	fbi->cmap_inverse		= inf->cmap_inverse;
+	fbi->cmap_static		= inf->cmap_static;
 	fbi->pcr			= inf->pcr;
 	fbi->lscr1			= inf->lscr1;
 	fbi->dmacr			= inf->dmacr;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX framebuffer remove ifdefs
Date: Tue, 15 May 2007 11:21:20 +0200
Message-ID: <20070515092120.GL5967@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HntRK-000417-Um for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 02:35:31 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HntRJ-0000KR-9l
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 02:35:30 -0700
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1HntRI-0001qi-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 15 May 2007 11:35:28 +0200
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>) id 1HntRI-0007Kj-6Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 11:35:28 +0200
Resent-Message-ID: <20070515093528.GN5967@localhost.localdomain>
Resent-To: linux-fbdev-devel@lists.sourceforge.net
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Here are some small fixes for the imxfb framebuffer driver:

- remove ifndef for MX1FS2 platform which is not present in the kernel.
- REV, CLS, PS and SPL_SPR are only needed with some sharp displays.
  Only setup the corresponding io pins when such a display is connected.


Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 drivers/video/imxfb.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/video/imxfb.c
===================================================================
--- linux-2.6.orig/drivers/video/imxfb.c
+++ linux-2.6/drivers/video/imxfb.c
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

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

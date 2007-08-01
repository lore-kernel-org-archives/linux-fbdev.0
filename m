From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/11] matroxfb: rectify jitter
	(G450/G550)
Date: Wed, 01 Aug 2007 15:42:36 +0800
Message-ID: <46B0396C.1020407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9Ni-0003FX-VC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:35 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9Nh-0004jH-OU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:34 -0700
Received: by wa-out-1112.google.com with SMTP id k22so151532waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:33 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Paul A. Clarke" <pc@us.ibm.com>

From: Paul A. Clarke <pc@us.ibm.com>

This builds upon my previous attempts to resolve some jitter problems seen with
the Matrox G450 and G550 -based cards, including odd disparities observed
between x86 and Power -based machines in a somewhat less hackish way (removing
the hacked ifdefs).

Apparently, preference should be given to use the DVI PLL when frequencies
permit, the Standard PLL otherwise.  The max pixel clock for the panellink
interface is extracted from the PInS information on the card and used as a
limit to determine which PLL to use.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Acked-by: Petr Vandrovec <petr@vandrovec.name>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/matrox/g450_pll.c         |   23 +++++++++++++----------
 drivers/video/matrox/matroxfb_DAC1064.h |   15 +++++++++++++++
 drivers/video/matrox/matroxfb_base.h    |    1 +
 drivers/video/matrox/matroxfb_misc.c    |    1 +
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/video/matrox/g450_pll.c b/drivers/video/matrox/g450_pll.c
index 7c76e07..d42346e 100644
--- a/drivers/video/matrox/g450_pll.c
+++ b/drivers/video/matrox/g450_pll.c
@@ -331,16 +331,19 @@ static int __g450_setclk(WPMINFO unsigne
 					tmp |= M1064_XPIXCLKCTRL_PLL_UP;
 				}
 				matroxfb_DAC_out(PMINFO M1064_XPIXCLKCTRL, tmp);
-#ifdef __powerpc__
-				/* This is necessary to avoid jitter on PowerPC
-				 * (OpenFirmware) systems, but apparently
-				 * introduces jitter, at least on a x86-64
-				 * using DVI.
-				 * A simple workaround is disable for non-PPC.
-				 */
-				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL, 0);
-#endif /* __powerpc__ */
-				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl);
+				/* DVI PLL preferred for frequencies up to
+				   panel link max, standard PLL otherwise */
+				if (fout >= MINFO->max_pixel_clock_panellink)
+					tmp = 0;
+				else tmp =
+					M1064_XDVICLKCTRL_DVIDATAPATHSEL |
+					M1064_XDVICLKCTRL_C1DVICLKSEL |
+					M1064_XDVICLKCTRL_C1DVICLKEN |
+					M1064_XDVICLKCTRL_DVILOOPCTL |
+					M1064_XDVICLKCTRL_P1LOOPBWDTCTL;
+				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL,tmp);
+				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL,
+						 xpwrctrl);
 
 				matroxfb_DAC_unlock_irqrestore(flags);
 			}
diff --git a/drivers/video/matrox/matroxfb_DAC1064.h b/drivers/video/matrox/matroxfb_DAC1064.h
index df39c31..7a98ce8 100644
--- a/drivers/video/matrox/matroxfb_DAC1064.h
+++ b/drivers/video/matrox/matroxfb_DAC1064.h
@@ -33,6 +33,21 @@ #define     M1064_XCURCTRL_DIS		0x00	/* 
 #define     M1064_XCURCTRL_3COLOR	0x01	/* transparent, 0, 1, 2 */
 #define     M1064_XCURCTRL_XGA		0x02	/* 0, 1, transparent, complement */
 #define     M1064_XCURCTRL_XWIN		0x03	/* transparent, transparent, 0, 1 */
+	/* drive DVI by standard(0)/DVI(1) PLL */
+	/* if set(1), C?DVICLKEN and C?DVICLKSEL must be set(1) */
+#define      M1064_XDVICLKCTRL_DVIDATAPATHSEL   0x01
+	/* drive CRTC1 by standard(0)/DVI(1) PLL */
+#define      M1064_XDVICLKCTRL_C1DVICLKSEL      0x02
+	/* drive CRTC2 by standard(0)/DVI(1) PLL */
+#define      M1064_XDVICLKCTRL_C2DVICLKSEL      0x04
+	/* pixel clock allowed to(0)/blocked from(1) driving CRTC1 */
+#define      M1064_XDVICLKCTRL_C1DVICLKEN       0x08
+	/* DVI PLL loop filter bandwidth selection bits */
+#define      M1064_XDVICLKCTRL_DVILOOPCTL       0x30
+	/* CRTC2 pixel clock allowed to(0)/blocked from(1) driving CRTC2 */
+#define      M1064_XDVICLKCTRL_C2DVICLKEN       0x40
+	/* P1PLL loop filter bandwith selection */
+#define      M1064_XDVICLKCTRL_P1LOOPBWDTCTL    0x80
 #define M1064_XCURCOL0RED	0x08
 #define M1064_XCURCOL0GREEN	0x09
 #define M1064_XCURCOL0BLUE	0x0A
diff --git a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
index d59577c..f3107ad 100644
--- a/drivers/video/matrox/matroxfb_base.h
+++ b/drivers/video/matrox/matroxfb_base.h
@@ -424,6 +424,7 @@ #define MATROXFB_MAX_FB_DRIVERS		5
 		      } mmio;
 
 	unsigned int	max_pixel_clock;
+	unsigned int	max_pixel_clock_panellink;
 
 	struct matrox_switch*	hw_switch;
 
diff --git a/drivers/video/matrox/matroxfb_misc.c b/drivers/video/matrox/matroxfb_misc.c
index 5948e54..ab7fb50 100644
--- a/drivers/video/matrox/matroxfb_misc.c
+++ b/drivers/video/matrox/matroxfb_misc.c
@@ -658,6 +658,7 @@ static int parse_pins5(WPMINFO const str
 		MINFO->values.reg.mctlwtst_core = (MINFO->values.reg.mctlwtst & ~7) |
 		                                  wtst_xlat[MINFO->values.reg.mctlwtst & 7];
 	}
+	MINFO->max_pixel_clock_panellink = bd->pins[47] * 4000;
 	return 0;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

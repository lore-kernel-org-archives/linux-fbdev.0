From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH] matroxfb: another attempt to rectify
	jitter (G450/G550)
Date: Mon, 22 Jan 2007 18:17:38 -0600
Message-ID: <45B55422.4070401@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H99Mv-0000Ww-RT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 16:18:34 -0800
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H99Mu-0003bn-9c
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 16:18:33 -0800
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0N0IF8q022691
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Jan 2007 19:18:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0N0HcSX237488 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Jan 2007 19:17:38 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0N0HcXS030659 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Jan 2007 19:17:38 -0500
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

This builds upon my previous attempts to resolve some jitter problems seen with 
the Matrox G450 and G550 -based cards, including odd disparities observed 
between x86 and Power -based machines in a somewhat less hackish way (removing 
the hacked ifdefs).

Apparently, preference should be given to use the DVI PLL when frequencies 
permit, the Standard PLL otherwise.  The max pixel clock for the panellink 
interface is extracted from the PInS information on the card and used as a limit 
to determine which PLL to use.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
-- 

--- linux-2.6.19-rc6/drivers/video/matrox/matroxfb_base.h	2006-11-15 
22:03:40.000000000 -0600
+++ patched/drivers/video/matrox/matroxfb_base.h	2006-11-22 13:02:58.000000000 -0600
@@ -424,6 +424,7 @@
  		      } mmio;

  	unsigned int	max_pixel_clock;
+	unsigned int	max_pixel_clock_panellink;

  	struct matrox_switch*	hw_switch;


--- linux-2.6.19-rc6/drivers/video/matrox/matroxfb_DAC1064.h	2006-11-15 
22:03:40.000000000 -0600
+++ patched/drivers/video/matrox/matroxfb_DAC1064.h	2006-11-16 
08:43:33.000000000 -0600
@@ -40,6 +40,21 @@
  #define M1064_XCURCOL1GREEN	0x0D
  #define M1064_XCURCOL1BLUE	0x0E
  #define M1064_XDVICLKCTRL	0x0F
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
  #define M1064_XCURCOL2RED	0x10
  #define M1064_XCURCOL2GREEN	0x11
  #define M1064_XCURCOL2BLUE	0x12

--- linux-2.6.19-rc6/drivers/video/matrox/matroxfb_misc.c	2006-11-15 
22:03:40.000000000 -0600
+++ patched/drivers/video/matrox/matroxfb_misc.c	2006-11-22 13:03:46.000000000 -0600
@@ -658,6 +658,7 @@
  		MINFO->values.reg.mctlwtst_core = (MINFO->values.reg.mctlwtst & ~7) |
  		                                  wtst_xlat[MINFO->values.reg.mctlwtst & 7];
  	}
+	MINFO->max_pixel_clock_panellink = bd->pins[47] * 4000;
  	return 0;
  }


--- linux-2.6.19-rc6/drivers/video/matrox/g450_pll.c	2006-11-15 
22:03:40.000000000 -0600
+++ patched/drivers/video/matrox/g450_pll.c	2006-11-22 13:04:31.000000000 -0600
@@ -331,15 +331,15 @@
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
+				/* DVI PLL preferred for frequencies up to panellink max, standard PLL 
otherwise */
+				if (fout >= MINFO->max_pixel_clock_panellink) tmp = 0;
+				else tmp =
+					M1064_XDVICLKCTRL_DVIDATAPATHSEL |
+					M1064_XDVICLKCTRL_C1DVICLKSEL |
+					M1064_XDVICLKCTRL_C1DVICLKEN |
+					M1064_XDVICLKCTRL_DVILOOPCTL |
+					M1064_XDVICLKCTRL_P1LOOPBWDTCTL;
+				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL,tmp);
  				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl);

  				matroxfb_DAC_unlock_irqrestore(flags);

--
Regards,
Paul A. Clarke, IBM

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

From: Clint Adams <schizo@debian.org>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Tue, 30 Mar 2004 10:32:47 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040330153247.GB11287@scowler.net>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net> <20040114211643.GA6793@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8LET-0007CU-Lb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 07:32:53 -0800
Received: from acolyte.scowler.net ([216.254.112.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B8LES-0001SJ-P8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 07:32:53 -0800
Content-Disposition: inline
In-Reply-To: <20040114211643.GA6793@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

This patch helps, though the second head is still a bit fuzzy.
One other thing I've noticed is that the clock range is detected
by X as 16.25 to 110.00 MHz, though the board specs claim a max of
250MHz.

diff -ruN xc-old/programs/Xserver/hw/xfree86/drivers/glint/glint_regs.h xc/programs/Xserver/hw/xfree86/drivers/glint/glint_regs.h
--- xc-old/programs/Xserver/hw/xfree86/drivers/glint/glint_regs.h	2003-01-11 22:55:47.000000000 -0500
+++ xc/programs/Xserver/hw/xfree86/drivers/glint/glint_regs.h	2004-03-30 10:24:35.000000000 -0500
@@ -75,6 +75,10 @@
 			 ((pGlint->PciInfo->subsysCard == 0x0100) ||  \
 			  (pGlint->PciInfo->subsysCard == 0x0002)))
 
+/* Tech-Source Raptor GFX 8P (Permedia 2V) */
+#define IS_TSGFX8P	((pGlint->PciInfo->subsysVendor == 0x1227) && \
+                         (pGlint->PciInfo->subsysCard   == 0x0006))
+
 /**********************************************
 *  GLINT 500TX Configuration Region Registers *
 ***********************************************/
diff -ruN xc-old/programs/Xserver/hw/xfree86/drivers/glint/pm2v_dac.c xc/programs/Xserver/hw/xfree86/drivers/glint/pm2v_dac.c
--- xc-old/programs/Xserver/hw/xfree86/drivers/glint/pm2v_dac.c	2002-05-07 19:15:59.000000000 -0400
+++ xc/programs/Xserver/hw/xfree86/drivers/glint/pm2v_dac.c	2004-03-30 10:25:19.000000000 -0500
@@ -113,21 +113,21 @@
 	Permedia2VPreInitSecondary(pScrn);
     }
 
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__sparc__)
     /*
      * On Alpha, we have to init secondary PM2V cards, since
      * int10 cannot be run on the OEMed cards with VGA disable
      * jumpers.
      */
     if (!xf86IsPrimaryPci(pGlint->PciInfo)) {
-	if ( IS_QPM2V ) {
+	if ( (IS_QPM2V) || (IS_TSGFX8P) ) {
 
 	    xf86DrvMsg(pScrn->scrnIndex, X_INFO,
 		       "PM2V secondary: initializing\n");
 	    Permedia2VPreInitSecondary(pScrn);
 	}
     }
-#endif /* __alpha__ */
+#endif /* __alpha__ || __sparc__ */
 }
 
 Bool


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

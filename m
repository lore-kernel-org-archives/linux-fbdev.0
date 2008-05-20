From: Ben Dooks <ben-fbdev@fluff.org>
Subject: [patch 2/5] S3C2410: Ensure that
	FB_BLANK_POWERDOWN shuts down the controller
Date: Tue, 20 May 2008 13:49:56 +0100
Message-ID: <20080520125030.158169752@fluff.org.uk>
References: <20080520124954.001898813@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyRIo-0004TJ-OX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyRIm-0006Hv-Vv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-blankpowerdown.patch
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
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, arnaud.patard@rtp-net.org

When a blank level of FB_BLANK_POWERDOWN is used, we should
shut down the controller so that it no longer tries to produce
any panel signals or data, and shuts down the DMA which is not
needed.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.26-rc3-quilt1.orig/drivers/video/s3c2410fb.c	2008-05-19 23:04:05.000000000 +0100
+++ linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c	2008-05-19 23:38:20.000000000 +0100
@@ -580,6 +580,27 @@ static int s3c2410fb_setcolreg(unsigned 
 	return 0;
 }
 
+/* s3c2410fb_lcd_enable
+ *
+ * shutdown the lcd controller
+ */
+static void s3c2410fb_lcd_enable(struct s3c2410fb_info *fbi, int enable)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (enable)
+		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_ENVID;
+	else
+		fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
+
+	writel(fbi->regs.lcdcon1, fbi->io + S3C2410_LCDCON1);
+
+	local_irq_restore(flags);
+}
+
+
 /*
  *      s3c2410fb_blank
  *	@blank_mode: the blank mode we want.
@@ -589,9 +610,6 @@ static int s3c2410fb_setcolreg(unsigned 
  *	blanking succeeded, != 0 if un-/blanking failed due to e.g. a
  *	video mode which doesn't support it. Implements VESA suspend
  *	and powerdown modes on hardware that supports disabling hsync/vsync:
- *	blank_mode == 2: suspend vsync
- *	blank_mode == 3: suspend hsync
- *	blank_mode == 4: powerdown
  *
  *	Returns negative errno on error, or zero on success.
  *
@@ -605,6 +623,12 @@ static int s3c2410fb_blank(int blank_mod
 
 	tpal_reg += is_s3c2412(fbi) ? S3C2412_TPAL : S3C2410_TPAL;
 
+	if (blank_mode == FB_BLANK_POWERDOWN) {
+		s3c2410fb_lcd_enable(fbi, 0);
+	} else {
+		s3c2410fb_lcd_enable(fbi, 1);
+	}
+
 	if (blank_mode == FB_BLANK_UNBLANK)
 		writel(0x0, tpal_reg);
 	else {
@@ -983,21 +1007,6 @@ static int __init s3c2412fb_probe(struct
 	return s3c24xxfb_probe(pdev, DRV_S3C2412);
 }
 
-/* s3c2410fb_stop_lcd
- *
- * shutdown the lcd controller
- */
-static void s3c2410fb_stop_lcd(struct s3c2410fb_info *fbi)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
-	writel(fbi->regs.lcdcon1, fbi->io + S3C2410_LCDCON1);
-
-	local_irq_restore(flags);
-}
 
 /*
  *  Cleanup
@@ -1010,7 +1019,7 @@ static int s3c2410fb_remove(struct platf
 
 	unregister_framebuffer(fbinfo);
 
-	s3c2410fb_stop_lcd(info);
+	s3c2410fb_lcd_enable(info, 0);
 	msleep(1);
 
 	s3c2410fb_unmap_video_memory(fbinfo);
@@ -1043,7 +1052,7 @@ static int s3c2410fb_suspend(struct plat
 	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	s3c2410fb_stop_lcd(info);
+	s3c2410fb_lcd_enable(info, 0);
 
 	/* sleep before disabling the clock, we need to ensure
 	 * the LCD DMA engine is not going to get back on the bus

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

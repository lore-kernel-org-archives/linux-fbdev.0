From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/5] s3c2410fb: Fix resume
Date: Sun, 28 May 2006 08:39:27 +0800
Message-ID: <4478F13F.7040305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fk9NQ-0001pe-M7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:28 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fk9NQ-0008KM-H3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:28 -0700
Received: by py-out-1112.google.com with SMTP id b29so208814pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 17:43:28 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>

From: Arnaud Patard <arnaud.patard@rtp-net.org>

regs.lcdcon1 was not updated on suspend. The result was a garbaged display
on resume. This bug was first noticed by Christer Weinigel. This patch is a
modified version of the one he sent to me.

Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
---

 drivers/video/s3c2410fb.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 9451932..fbc4118 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -641,6 +641,7 @@ static int __init s3c2410fb_probe(struct
 	int ret;
 	int irq;
 	int i;
+	u32 lcdcon1;
 
 	mach_info = pdev->dev.platform_data;
 	if (mach_info == NULL) {
@@ -672,6 +673,11 @@ static int __init s3c2410fb_probe(struct
 
 	memcpy(&info->regs, &mach_info->regs, sizeof(info->regs));
 
+	/* Stop the video and unset ENVID if set */
+	info->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
+	lcdcon1 = readl(S3C2410_LCDCON1);
+	writel(lcdcon1 & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+
 	info->mach_info		    = pdev->dev.platform_data;
 
 	fbinfo->fix.type	    = FB_TYPE_PACKED_PIXELS;
@@ -794,15 +800,14 @@ dealloc_fb:
  * shutdown the lcd controller
 */
 
-static void s3c2410fb_stop_lcd(void)
+static void s3c2410fb_stop_lcd(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
-	unsigned long tmp;
 
 	local_irq_save(flags);
 
-	tmp = readl(S3C2410_LCDCON1);
-	writel(tmp & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
+	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
 
 	local_irq_restore(flags);
 }
@@ -816,7 +821,7 @@ static int s3c2410fb_remove(struct platf
 	struct s3c2410fb_info *info = fbinfo->par;
 	int irq;
 
-	s3c2410fb_stop_lcd();
+	s3c2410fb_stop_lcd(info);
 	msleep(1);
 
 	s3c2410fb_unmap_video_memory(info);
@@ -844,7 +849,7 @@ static int s3c2410fb_suspend(struct plat
 	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	s3c2410fb_stop_lcd();
+	s3c2410fb_stop_lcd(info);
 
 	/* sleep before disabling the clock, we need to ensure
 	 * the LCD DMA engine is not going to get back on the bus



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

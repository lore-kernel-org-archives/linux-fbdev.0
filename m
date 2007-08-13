From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/22] s3c2410fb: fix missing registers
	offset
Date: Mon, 13 Aug 2007 20:39:02 +0800
Message-ID: <46C050E6.1030206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKaHn-0002rd-9q for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 06:48:48 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZKs-0005O6-Pn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:47:56 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:47:54 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds missing virtual register offsets where
appropriate. This fixes crashes in the driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3c2410fb.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index e850f11..108d49e 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -123,6 +123,8 @@ static void s3c2410fb_set_lcdaddr(struct
 {
 	unsigned long saddr1, saddr2, saddr3;
 	int line_length = info->var.xres * info->var.bits_per_pixel;
+	struct s3c2410fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
 
 	saddr1  = info->fix.smem_start >> 1;
 	saddr2  = info->fix.smem_start;
@@ -136,9 +138,9 @@ static void s3c2410fb_set_lcdaddr(struct
 	dprintk("LCDSADDR2 = 0x%08lx\n", saddr2);
 	dprintk("LCDSADDR3 = 0x%08lx\n", saddr3);
 
-	writel(saddr1, S3C2410_LCDSADDR1);
-	writel(saddr2, S3C2410_LCDSADDR2);
-	writel(saddr3, S3C2410_LCDSADDR3);
+	writel(saddr1, regs + S3C2410_LCDSADDR1);
+	writel(saddr2, regs + S3C2410_LCDSADDR2);
+	writel(saddr3, regs + S3C2410_LCDSADDR3);
 }
 
 /* s3c2410fb_calc_pixclk()
@@ -409,6 +411,7 @@ static void s3c2410fb_calculate_tft_lcd_
 static void s3c2410fb_activate_var(struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
 	struct fb_var_screeninfo *var = &info->var;
 	struct s3c2410fb_mach_info *mach_info = fbi->mach_info;
 	struct s3c2410fb_display *display = mach_info->displays +
@@ -449,16 +452,17 @@ static void s3c2410fb_activate_var(struc
 	dprintk("lcdcon[4] = 0x%08lx\n", fbi->regs.lcdcon4);
 	dprintk("lcdcon[5] = 0x%08lx\n", fbi->regs.lcdcon5);
 
-	writel(fbi->regs.lcdcon1 & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
-	writel(fbi->regs.lcdcon2, S3C2410_LCDCON2);
-	writel(fbi->regs.lcdcon3, S3C2410_LCDCON3);
-	writel(fbi->regs.lcdcon4, S3C2410_LCDCON4);
-	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
+	writel(fbi->regs.lcdcon1 & ~S3C2410_LCDCON1_ENVID,
+		regs + S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon2, regs + S3C2410_LCDCON2);
+	writel(fbi->regs.lcdcon3, regs + S3C2410_LCDCON3);
+	writel(fbi->regs.lcdcon4, regs + S3C2410_LCDCON4);
+	writel(fbi->regs.lcdcon5, regs + S3C2410_LCDCON5);
 
 	/* set lcd address pointers */
 	s3c2410fb_set_lcdaddr(info);
 
-	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
+	writel(fbi->regs.lcdcon1, regs + S3C2410_LCDCON1);
 }
 
 /*
@@ -527,6 +531,7 @@ static int s3c2410fb_setcolreg(unsigned 
 			       unsigned transp, struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
 	unsigned int val;
 
 	/* dprintk("setcol: regno=%d, rgb=%d,%d,%d\n",
@@ -555,7 +560,7 @@ static int s3c2410fb_setcolreg(unsigned 
 			val |= ((green >>  5) & 0x07e0);
 			val |= ((blue  >> 11) & 0x001f);
 
-			writel(val, S3C2410_TFTPAL(regno));
+			writel(val, regs + S3C2410_TFTPAL(regno));
 			schedule_palette_update(fbi, regno, val);
 		}
 
@@ -586,16 +591,19 @@ static int s3c2410fb_setcolreg(unsigned 
  */
 static int s3c2410fb_blank(int blank_mode, struct fb_info *info)
 {
+	struct s3c2410fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
+
 	dprintk("blank(mode=%d, info=%p)\n", blank_mode, info);
 
 	if (mach_info == NULL)
 		return -EINVAL;
 
 	if (blank_mode == FB_BLANK_UNBLANK)
-		writel(0x0, S3C2410_TPAL);
+		writel(0x0, regs + S3C2410_TPAL);
 	else {
 		dprintk("setting TPAL to output 0x000000\n");
-		writel(S3C2410_TPAL_EN, S3C2410_TPAL);
+		writel(S3C2410_TPAL_EN, regs + S3C2410_TPAL);
 	}
 
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

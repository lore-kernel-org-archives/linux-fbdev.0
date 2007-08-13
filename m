From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/22] s3c2410fb: remove fb_info pointer
	from s3c2410fb_info
Date: Mon, 13 Aug 2007 20:30:21 +0800
Message-ID: <46C04EDD.6060203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZJd-0004PM-O0 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:39 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZJb-0005O6-3Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:35 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:46:34 -0700 (PDT)
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

This patch removes redundant fb field from
the s3c2410fb_info structure. This breaks circular
reference fb_info -> s3c2410fb_info -> fb_info again.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3c2410fb.c |   43 ++++++++++++++++++++++---------------------
 drivers/video/s3c2410fb.h |    1 -
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index f103101..f7a026f 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -119,15 +119,14 @@ #define dprintk(msg...)	if (debug) { pri
  *
  * initialise lcd controller address pointers
  */
-static void s3c2410fb_set_lcdaddr(struct s3c2410fb_info *fbi)
+static void s3c2410fb_set_lcdaddr(struct fb_info *info)
 {
-	struct fb_var_screeninfo *var = &fbi->fb->var;
 	unsigned long saddr1, saddr2, saddr3;
-	int line_length = var->xres * var->bits_per_pixel;
+	int line_length = info->var.xres * info->var.bits_per_pixel;
 
-	saddr1  = fbi->fb->fix.smem_start >> 1;
-	saddr2  = fbi->fb->fix.smem_start;
-	saddr2 += (line_length * var->yres) / 8;
+	saddr1  = info->fix.smem_start >> 1;
+	saddr2  = info->fix.smem_start;
+	saddr2 += (line_length * info->var.yres) / 8;
 	saddr2 >>= 1;
 
 	saddr3 = S3C2410_OFFSIZE(0) |
@@ -275,9 +274,10 @@ static int s3c2410fb_check_var(struct fb
  * activate (set) the controller from the given framebuffer
  * information
  */
-static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+static void s3c2410fb_activate_var(struct fb_info *info,
 				   struct fb_var_screeninfo *var)
 {
+	struct s3c2410fb_info *fbi = info->par;
 	int hs;
 
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
@@ -418,7 +418,7 @@ static void s3c2410fb_activate_var(struc
 	writel(fbi->regs.lcdcon5, S3C2410_LCDCON5);
 
 	/* set lcd address pointers */
-	s3c2410fb_set_lcdaddr(fbi);
+	s3c2410fb_set_lcdaddr(info);
 
 	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
 }
@@ -430,7 +430,6 @@ static void s3c2410fb_activate_var(struc
  */
 static int s3c2410fb_set_par(struct fb_info *info)
 {
-	struct s3c2410fb_info *fbi = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 
 	switch (var->bits_per_pixel) {
@@ -449,7 +448,7 @@ static int s3c2410fb_set_par(struct fb_i
 
 	/* activate this new configuration */
 
-	s3c2410fb_activate_var(fbi, var);
+	s3c2410fb_activate_var(info, var);
 	return 0;
 }
 
@@ -615,15 +614,17 @@ static struct fb_ops s3c2410fb_ops = {
  *	cache.  Once this area is remapped, all virtual memory
  *	access to the video memory should occur at the new region.
  */
-static int __init s3c2410fb_map_video_memory(struct s3c2410fb_info *fbi)
+static int __init s3c2410fb_map_video_memory(struct fb_info *info)
 {
+	struct s3c2410fb_info *fbi = info->par;
+
 	dprintk("map_video_memory(fbi=%p)\n", fbi);
 
-	fbi->map_size = PAGE_ALIGN(fbi->fb->fix.smem_len + PAGE_SIZE);
+	fbi->map_size = PAGE_ALIGN(info->fix.smem_len + PAGE_SIZE);
 	fbi->map_cpu  = dma_alloc_writecombine(fbi->dev, fbi->map_size,
 					       &fbi->map_dma, GFP_KERNEL);
 
-	fbi->map_size = fbi->fb->fix.smem_len;
+	fbi->map_size = info->fix.smem_len;
 
 	if (fbi->map_cpu) {
 		/* prevent initial garbage on screen */
@@ -632,11 +633,11 @@ static int __init s3c2410fb_map_video_me
 		memset(fbi->map_cpu, 0xf0, fbi->map_size);
 
 		fbi->screen_dma		= fbi->map_dma;
-		fbi->fb->screen_base	= fbi->map_cpu;
-		fbi->fb->fix.smem_start  = fbi->screen_dma;
+		info->screen_base	= fbi->map_cpu;
+		info->fix.smem_start	= fbi->screen_dma;
 
 		dprintk("map_video_memory: dma=%08x cpu=%p size=%08x\n",
-			fbi->map_dma, fbi->map_cpu, fbi->fb->fix.smem_len);
+			fbi->map_dma, fbi->map_cpu, info->fix.smem_len);
 	}
 
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -660,8 +661,9 @@ static inline void modify_gpio(void __io
 /*
  * s3c2410fb_init_registers - Initialise all LCD-related registers
  */
-static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
+static int s3c2410fb_init_registers(struct fb_info *info)
 {
+	struct s3c2410fb_info *fbi = info->par;
 	unsigned long flags;
 	void __iomem *regs = fbi->io;
 
@@ -684,7 +686,7 @@ static int s3c2410fb_init_registers(stru
 	writel(fbi->regs.lcdcon4, regs + S3C2410_LCDCON4);
 	writel(fbi->regs.lcdcon5, regs + S3C2410_LCDCON5);
 
-	s3c2410fb_set_lcdaddr(fbi);
+	s3c2410fb_set_lcdaddr(info);
 
 	dprintk("LPCSEL    = 0x%08lx\n", mach_info->lpcsel);
 	writel(mach_info->lpcsel, regs + S3C2410_LPCSEL);
@@ -777,7 +779,6 @@ static int __init s3c2410fb_probe(struct
 		return -ENOMEM;
 
 	info = fbinfo->par;
-	info->fb = fbinfo;
 	info->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -890,7 +891,7 @@ static int __init s3c2410fb_probe(struct
 	msleep(1);
 
 	/* Initialize video memory */
-	ret = s3c2410fb_map_video_memory(info);
+	ret = s3c2410fb_map_video_memory(fbinfo);
 	if (ret) {
 		printk(KERN_ERR "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
@@ -899,7 +900,7 @@ static int __init s3c2410fb_probe(struct
 
 	dprintk("got video memory\n");
 
-	s3c2410fb_init_registers(info);
+	s3c2410fb_init_registers(fbinfo);
 
 	s3c2410fb_check_var(&fbinfo->var, fbinfo);
 
diff --git a/drivers/video/s3c2410fb.h b/drivers/video/s3c2410fb.h
index 17c7915..eec7708 100644
--- a/drivers/video/s3c2410fb.h
+++ b/drivers/video/s3c2410fb.h
@@ -26,7 +26,6 @@ #ifndef __S3C2410FB_H
 #define __S3C2410FB_H
 
 struct s3c2410fb_info {
-	struct fb_info		*fb;
 	struct device		*dev;
 	struct clk		*clk;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

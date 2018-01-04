From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Thu, 04 Jan 2018 21:14:58 +0000
Subject: [RFC PATCH] fbdev: mxsfb: use framebuffer_alloc in the correct way
Message-Id: <1515100498-23066-1-git-send-email-michael@amarulasolutions.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

framebuffer_alloc allocated the fb_info struct plus the extra
par and set fb_info->par pointer equal to this extra par. We
can refer the mxcfb_info from fb_info->par

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/video/fbdev/mxsfb.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 79b1dc7..fa24ddc 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -169,7 +169,6 @@ struct mxsfb_devdata {
 };
 
 struct mxsfb_info {
-	struct fb_info fb_info;
 	struct platform_device *pdev;
 	struct clk *clk;
 	struct clk *clk_axi;
@@ -208,7 +207,7 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
 	},
 };
 
-#define to_imxfb_host(x) (container_of(x, struct mxsfb_info, fb_info))
+#define to_imxfb_host(x) (((struct fb_info *)(x))->par)
 
 /* mask and shift depends on architecture */
 static inline u32 set_hsync_pulse_width(struct mxsfb_info *host, unsigned val)
@@ -622,10 +621,10 @@ static struct fb_ops mxsfb_ops = {
 	.fb_imageblit = cfb_imageblit,
 };
 
-static int mxsfb_restore_mode(struct mxsfb_info *host,
+static int mxsfb_restore_mode(struct fb_info *fb_info,
 			struct fb_videomode *vmode)
 {
-	struct fb_info *fb_info = &host->fb_info;
+	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	unsigned line_count;
 	unsigned period;
 	unsigned long pa, fbsize;
@@ -726,10 +725,10 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
 	return ret;
 }
 
-static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
+static int mxsfb_init_fbinfo_dt(struct fb_info *fb_info,
 				struct fb_videomode *vmode)
 {
-	struct fb_info *fb_info = &host->fb_info;
+	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	struct fb_var_screeninfo *var = &fb_info->var;
 	struct device *dev = &host->pdev->dev;
 	struct device_node *np = host->pdev->dev.of_node;
@@ -805,12 +804,12 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
 	return ret;
 }
 
-static int mxsfb_init_fbinfo(struct mxsfb_info *host,
+static int mxsfb_init_fbinfo(struct fb_info *fb_info,
 			struct fb_videomode *vmode)
 {
 	int ret;
+	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	struct device *dev = &host->pdev->dev;
-	struct fb_info *fb_info = &host->fb_info;
 	struct fb_var_screeninfo *var = &fb_info->var;
 	dma_addr_t fb_phys;
 	void *fb_virt;
@@ -824,7 +823,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
 	fb_info->fix.visual = FB_VISUAL_TRUECOLOR,
 	fb_info->fix.accel = FB_ACCEL_NONE;
 
-	ret = mxsfb_init_fbinfo_dt(host, vmode);
+	ret = mxsfb_init_fbinfo_dt(fb_info, vmode);
 	if (ret)
 		return ret;
 
@@ -843,16 +842,16 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
 	fb_info->screen_base = fb_virt;
 	fb_info->screen_size = fb_info->fix.smem_len = fb_size;
 
-	if (mxsfb_restore_mode(host, vmode))
+	if (mxsfb_restore_mode(fb_info, vmode))
 		memset(fb_virt, 0, fb_size);
 
 	return 0;
 }
 
-static void mxsfb_free_videomem(struct mxsfb_info *host)
+static void mxsfb_free_videomem(struct fb_info *fb_info)
 {
+	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	struct device *dev = &host->pdev->dev;
-	struct fb_info *fb_info = &host->fb_info;
 
 	dma_free_wc(dev, fb_info->screen_size, fb_info->screen_base,
 		    fb_info->fix.smem_start);
@@ -941,7 +940,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
-	ret = mxsfb_init_fbinfo(host, mode);
+	ret = mxsfb_init_fbinfo(fb_info, mode);
 	if (ret != 0)
 		goto fb_release;
 
@@ -988,7 +987,7 @@ static int mxsfb_remove(struct platform_device *pdev)
 		mxsfb_disable_controller(fb_info);
 
 	unregister_framebuffer(fb_info);
-	mxsfb_free_videomem(host);
+	mxsfb_free_videomem(fb_info);
 
 	framebuffer_release(fb_info);
 
-- 
2.7.4


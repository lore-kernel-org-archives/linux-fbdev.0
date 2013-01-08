From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 08 Jan 2013 01:19:31 +0000
Subject: [PATCH] video: mxsfb: Fix build warnings with W=1
Message-Id: <1357607971-16988-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following warnings when building with W=1 option:

drivers/video/mxsfb.c: In function 'mxsfb_set_par':
drivers/video/mxsfb.c:389:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/video/mxsfb.c: In function 'mxsfb_restore_mode':
drivers/video/mxsfb.c:592:11: warning: variable 'line_count' set but not used [-Wunused-but-set-variable]
drivers/video/mxsfb.c: In function 'mxsfb_probe':
drivers/video/mxsfb.c:867:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/mxsfb.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index a45b37c..47c92a2 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -380,7 +380,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 {
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	u32 ctrl, vdctrl0, vdctrl4;
-	int line_size, fb_size;
+	u32 line_size, fb_size;
 	int reenable = 0;
 
 	line_size =  fb_info->var.xres * (fb_info->var.bits_per_pixel >> 3);
@@ -589,7 +589,6 @@ static struct fb_ops mxsfb_ops = {
 static int mxsfb_restore_mode(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
-	unsigned line_count;
 	unsigned period;
 	unsigned long pa, fbsize;
 	int bits_per_pixel, ofs;
@@ -668,7 +667,6 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 		writel(fb_info->fix.smem_start, host->base + host->devdata->next_buf);
 	}
 
-	line_count = fb_info->fix.smem_len / fb_info->fix.line_length;
 	fb_info->fix.ypanstep = 1;
 
 	clk_prepare_enable(host->clk);
@@ -784,7 +782,8 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	int panel_enable;
 	enum of_gpio_flags flags;
-	int i, ret;
+	int ret;
+	u32 i;
 
 	if (of_id)
 		pdev->id_entry = of_id->data;
-- 
1.7.9.5


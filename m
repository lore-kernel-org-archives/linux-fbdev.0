From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 07:17:16 +0000
Subject: [PATCH 1/4] simplefb: formalize pseudo palette handling
Message-Id: <1407914239-12054-2-git-send-email-libv@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
In-Reply-To: <1407914239-12054-1-git-send-email-libv@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Luc Verhaegen <libv@skynet.be>
---
 drivers/video/fbdev/simplefb.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 210f3a0..32be590 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -41,6 +41,8 @@ static struct fb_var_screeninfo simplefb_var = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
+#define PSEUDO_PALETTE_SIZE 16
+
 static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			      u_int transp, struct fb_info *info)
 {
@@ -50,7 +52,7 @@ static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u32 cb = blue >> (16 - info->var.blue.length);
 	u32 value;
 
-	if (regno >= 16)
+	if (regno >= PSEUDO_PALETTE_SIZE)
 		return -EINVAL;
 
 	value = (cr << info->var.red.offset) |
@@ -163,11 +165,16 @@ static int simplefb_parse_pd(struct platform_device *pdev,
 	return 0;
 }
 
+struct simplefb_par {
+	u32 palette[PSEUDO_PALETTE_SIZE];
+};
+
 static int simplefb_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct simplefb_params params;
 	struct fb_info *info;
+	struct simplefb_par *par;
 	struct resource *mem;
 
 	if (fb_get_options("simplefb", NULL))
@@ -188,11 +195,13 @@ static int simplefb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	info = framebuffer_alloc(sizeof(u32) * 16, &pdev->dev);
+	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
 	if (!info)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, info);
 
+	par = info->par;
+
 	info->fix = simplefb_fix;
 	info->fix.smem_start = mem->start;
 	info->fix.smem_len = resource_size(mem);
@@ -225,7 +234,7 @@ static int simplefb_probe(struct platform_device *pdev)
 		framebuffer_release(info);
 		return -ENODEV;
 	}
-	info->pseudo_palette = (void *)(info + 1);
+	info->pseudo_palette = (void *) par->palette;
 
 	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
 			     info->fix.smem_start, info->fix.smem_len,
-- 
1.7.7


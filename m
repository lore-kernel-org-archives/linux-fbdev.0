From: Andrei Epure <epure.andrei@gmail.com>
Date: Wed, 27 Mar 2013 23:43:25 +0000
Subject: [PATCH] video: fixed missing iounmap coccinelle errors
Message-Id: <1364427805-11972-1-git-send-email-epure.andrei@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Modified or added the necessary goto statements so that the ioremapped
regions get unmapped before return.

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/video/vt8500lcdfb.c |    7 ++++---
 drivers/video/wm8505fb.c    |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index aa2579c..b4ccca2 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -350,7 +350,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	if (!np) {
 		pr_err("%s: No display description in Device Tree\n", __func__);
 		ret = -EINVAL;
-		goto failed_free_res;
+		goto failed_free_io;
 	}
 
 	/*
@@ -369,7 +369,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	ret |= of_property_read_u32(np, "bpp", &bpp);
 	if (ret) {
 		pr_err("%s: Unable to read display properties\n", __func__);
-		goto failed_free_res;
+		goto failed_free_io;
 	}
 	of_mode.vmode = FB_VMODE_NONINTERLACED;
 
@@ -379,7 +379,8 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 				GFP_KERNEL);
 	if (!fb_mem_virt) {
 		pr_err("%s: Failed to allocate framebuffer\n", __func__);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto failed_free_io;
 	};
 
 	fbi->fb.fix.smem_start	= fb_mem_phys;
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 4dd0580..2e8298e 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -332,7 +332,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	if (!np) {
 		pr_err("%s: No display description in Device Tree\n", __func__);
 		ret = -EINVAL;
-		goto failed_free_res;
+		goto failed_free_io;
 	}
 
 	/*
@@ -351,7 +351,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	ret |= of_property_read_u32(np, "bpp", &bpp);
 	if (ret) {
 		pr_err("%s: Unable to read display properties\n", __func__);
-		goto failed_free_res;
+		goto failed_free_io;
 	}
 
 	of_mode.vmode = FB_VMODE_NONINTERLACED;
@@ -369,7 +369,8 @@ static int wm8505fb_probe(struct platform_device *pdev)
 				GFP_KERNEL);
 	if (!fb_mem_virt) {
 		pr_err("%s: Failed to allocate framebuffer\n", __func__);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto failed_free_io;
 	};
 
 	fbi->fb.var.xres_virtual	= of_mode.xres;
-- 
1.7.9.5


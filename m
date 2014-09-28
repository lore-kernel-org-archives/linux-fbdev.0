From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 28 Sep 2014 12:43:37 +0000
Subject: [PATCH 3/4] simplefb: add goto error path to probe
Message-Id: <1411908218-20947-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411908218-20947-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1411908218-20947-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Luc Verhaegen <libv@skynet.be>

Signed-off-by: Luc Verhaegen <libv@skynet.be>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/simplefb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index ec112c1..b7d5c08 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -220,8 +220,8 @@ static int simplefb_probe(struct platform_device *pdev)
 
 	info->apertures = alloc_apertures(1);
 	if (!info->apertures) {
-		framebuffer_release(info);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_fb_release;
 	}
 	info->apertures->ranges[0].base = info->fix.smem_start;
 	info->apertures->ranges[0].size = info->fix.smem_len;
@@ -231,8 +231,8 @@ static int simplefb_probe(struct platform_device *pdev)
 	info->screen_base = ioremap_wc(info->fix.smem_start,
 				       info->fix.smem_len);
 	if (!info->screen_base) {
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error_fb_release;
 	}
 	info->pseudo_palette = par->palette;
 
@@ -247,14 +247,20 @@ static int simplefb_probe(struct platform_device *pdev)
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-		iounmap(info->screen_base);
-		framebuffer_release(info);
-		return ret;
+		goto error_unmap;
 	}
 
 	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
 
 	return 0;
+
+ error_unmap:
+	iounmap(info->screen_base);
+
+ error_fb_release:
+	framebuffer_release(info);
+
+	return ret;
 }
 
 static int simplefb_remove(struct platform_device *pdev)
-- 
2.1.0


From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 22 Oct 2014 16:45:10 +0000
Subject: [PATCH v4 4/5] simplefb: add goto error path to probe
Message-Id: <1413996311-4287-5-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Luc Verhaegen <libv@skynet.be>

While at it update ioremap_wc error return from ENODEV to ENOMEM.

Signed-off-by: Luc Verhaegen <libv@skynet.be>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/video/fbdev/simplefb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index ec112c1..cdcf1fe 100644
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
+		ret = -ENOMEM;
+		goto error_fb_release;
 	}
 	info->pseudo_palette = par->palette;
 
@@ -247,14 +247,18 @@ static int simplefb_probe(struct platform_device *pdev)
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
+error_unmap:
+	iounmap(info->screen_base);
+error_fb_release:
+	framebuffer_release(info);
+	return ret;
 }
 
 static int simplefb_remove(struct platform_device *pdev)
-- 
2.1.0


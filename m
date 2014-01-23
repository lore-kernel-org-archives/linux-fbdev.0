From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 23 Jan 2014 14:14:55 +0000
Subject: [PATCH 03/11] fbdev: efifb: add dev->remove() callback
Message-Id: <1390486503-1504-4-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ingo Molnar <mingo@kernel.org>

If x86-sysfb platform-devices are removed from a system, we should
properly unload efifb. Otherwise, we end up releasing the parent while our
efi framebuffer is still running. This currently works just fine, but will
cause problems on handover to real hw. So add the ->remove() callback and
unregister efifb.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/video/efifb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index cd7c0df..ae9618f 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -73,7 +73,6 @@ static void efifb_destroy(struct fb_info *info)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
 	fb_dealloc_cmap(&info->cmap);
-	framebuffer_release(info);
 }
 
 static struct fb_ops efifb_ops = {
@@ -244,6 +243,7 @@ static int efifb_probe(struct platform_device *dev)
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
+	platform_set_drvdata(dev, info);
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 
@@ -337,12 +337,23 @@ err_release_mem:
 	return err;
 }
 
+static int efifb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	unregister_framebuffer(info);
+	framebuffer_release(info);
+
+	return 0;
+}
+
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
 		.owner = THIS_MODULE,
 	},
 	.probe = efifb_probe,
+	.remove = efifb_remove,
 };
 
 module_platform_driver(efifb_driver);
-- 
1.8.5.3


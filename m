From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 23 Jan 2014 14:14:56 +0000
Subject: [PATCH 04/11] fbdev: vesafb: add dev->remove() callback
Message-Id: <1390486503-1504-5-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ingo Molnar <mingo@kernel.org>

If x86-sysfb platform-devices are removed from a system, we should
properly unload vesafb. Otherwise, we end up releasing the parent while
our vesa framebuffer is still running. This currently works just fine, but
will cause problems on handover to real hw. So add the ->remove() callback
and unregister vesafb.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/video/vesafb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index 1c7da3b..6170e7f 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -179,7 +179,6 @@ static void vesafb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
-	framebuffer_release(info);
 }
 
 static struct fb_ops vesafb_ops = {
@@ -297,6 +296,7 @@ static int vesafb_probe(struct platform_device *dev)
 		release_mem_region(vesafb_fix.smem_start, size_total);
 		return -ENOMEM;
 	}
+	platform_set_drvdata(dev, info);
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 
@@ -499,12 +499,23 @@ err:
 	return err;
 }
 
+static int vesafb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	unregister_framebuffer(info);
+	framebuffer_release(info);
+
+	return 0;
+}
+
 static struct platform_driver vesafb_driver = {
 	.driver = {
 		.name = "vesa-framebuffer",
 		.owner = THIS_MODULE,
 	},
 	.probe = vesafb_probe,
+	.remove = vesafb_remove,
 };
 
 module_platform_driver(vesafb_driver);
-- 
1.8.5.3


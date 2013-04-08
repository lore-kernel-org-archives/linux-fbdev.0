From: Mohsin Kazmi <mohsin_kazmi@mentor.com>
Date: Mon, 08 Apr 2013 11:05:49 +0000
Subject: [PATCH] of: videomode: Fix module loading problem
Message-Id: <1365419149-29581-1-git-send-email-mohsin_kazmi@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds the support load as a module of_videomode.c which is required by parallel display.
I have encountered the following problem.

imx_parallel_display: Unknown symbol of_get_video_mode (err 0)
insmod: can't insert 'imx-parallel-display.ko': unknown symbol in module, or unknown parameter

of_get_video_mode() is available in of_videomode.c but it couldn't loaded and gave the following error.

of_videomode: Unknown symbol of_property_read_u32_array (err 0)
modprobe: can't load module of_videomode (kernel/drivers/of/of_videomode.ko): unknown symbol in module, or unknown parameter

I have discussed this with Dmitry Eremin-Solenikov. He told me to do so as in this patch and it works.

Signed-off-by: Mohsin Kazmi <mohsin_kazmi@mentor.com>
---
 drivers/of/of_videomode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_videomode.c b/drivers/of/of_videomode.c
index 859aefb..cd55f89 100644
--- a/drivers/of/of_videomode.c
+++ b/drivers/of/of_videomode.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <linux/module.h>
 
 int of_get_video_mode(struct device_node *np, struct drm_display_mode *dmode,
 		struct fb_videomode *fbmode)
@@ -106,3 +107,5 @@ int of_get_video_mode(struct device_node *np, struct drm_display_mode *dmode,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_video_mode);
+
+MODULE_LICENSE("GPL");
-- 
1.8.0


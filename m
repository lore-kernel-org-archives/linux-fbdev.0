From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Wed, 11 May 2016 15:59:23 +0000
Subject: [PATCH] fbdev: Use IS_ENABLED() instead of checking for built-in or module
Message-Id: <1462982363-25389-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/video/fbdev/via/accel.c    | 2 +-
 drivers/video/fbdev/via/via-core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/accel.c
index 4b67b8e6030a..eb3615c69987 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -358,7 +358,7 @@ int viafb_setup_engine(struct fb_info *info)
 	viapar->shared->vq_vram_addr = viapar->fbmem_free;
 	viapar->fbmem_used += VQ_SIZE;
 
-#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMERA_MODULE)
+#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
 	/*
 	 * Set aside a chunk of framebuffer memory for the camera
 	 * driver.  Someday this driver probably needs a proper allocator
diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index 6e274825fb31..1d28e16888e9 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(viafb_irq_disable);
  * most viafb systems will not need to have this extra code for a while.
  * As soon as another user comes long, the ifdef can be removed.
  */
-#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMERA_MODULE)
+#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
 /*
  * Access to the DMA engine.  This currently provides what the camera
  * driver needs (i.e. outgoing only) but is easily expandable if need
@@ -542,7 +542,7 @@ static struct viafb_subdev_info {
 	{
 		.name = "viafb-i2c",
 	},
-#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMERA_MODULE)
+#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
 	{
 		.name = "viafb-camera",
 	},
-- 
2.5.5


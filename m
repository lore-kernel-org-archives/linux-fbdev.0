From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Jul 2017 13:38:20 +0000
Subject: [PATCH 1/3] drm/msm: kick out firmware framebuffer
Message-Id: <20170711133822.31978-2-robdclark@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170711133822.31978-1-robdclark@gmail.com>
In-Reply-To: <20170711133822.31978-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Clark <robdclark@gmail.com>

Fixes a problem with console not appearing when booting with EFI that
has GOP support, because fb0 would end up being efifb, even after drm
has taken over the display.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h   |  2 ++
 drivers/gpu/drm/msm/msm_fbdev.c |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f49f6ac5585c..f487437fb9d0 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -286,6 +286,24 @@ static int get_mdp_ver(struct platform_device *pdev)
 
 #include <linux/of_address.h>
 
+static void kick_out_firmware_fb(void)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	/* Since msm is a UMA device, the simplefb or efifb node may
+	 * have been located anywhere in memory.
+	 */
+	ap->ranges[0].base = 0;
+	ap->ranges[0].size = MAX_RESOURCE;
+
+	drm_fb_helper_remove_conflicting_framebuffers(ap, FB_NAME, false);
+	kfree(ap);
+}
+
 static int msm_init_vram(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -416,6 +434,8 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	if (ret)
 		goto fail;
 
+	kick_out_firmware_fb();
+
 	msm_gem_shrinker_init(ddev);
 
 	switch (get_mdp_ver(pdev)) {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index e5d8cadfdb75..e69c029b428c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -55,6 +55,8 @@ struct msm_fence_cb;
 struct msm_gem_address_space;
 struct msm_gem_vma;
 
+#define FB_NAME "msm"
+
 struct msm_file_private {
 	/* currently we don't do anything useful with this.. but when
 	 * per-context address spaces are supported we'd keep track of
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 5ecf4ff9a059..794265225cda 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -146,7 +146,7 @@ static int msm_fbdev_create(struct drm_fb_helper *helper,
 	fbi->flags = FBINFO_DEFAULT;
 	fbi->fbops = &msm_fb_ops;
 
-	strcpy(fbi->fix.id, "msm");
+	strcpy(fbi->fix.id, FB_NAME);
 
 	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(fbi, helper, sizes->fb_width, sizes->fb_height);
-- 
2.13.0


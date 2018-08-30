From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:10 +0000
Subject: [PATCH v2 10/12] drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
Message-Id: <6bf2ab274713156b245e897154219055396aa017.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Use remove_conflicting_framebuffers(NULL) instead of open-coding it.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 94b99c90425a..96bb90325995 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -246,24 +246,6 @@ static void vc4_match_add_drivers(struct device *dev,
 	}
 }
 
-static void vc4_kick_out_firmware_fb(void)
-{
-	struct apertures_struct *ap;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return;
-
-	/* Since VC4 is a UMA device, the simplefb node may have been
-	 * located anywhere in memory.
-	 */
-	ap->ranges[0].base = 0;
-	ap->ranges[0].size = ~0;
-
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "vc4drmfb", false);
-	kfree(ap);
-}
-
 static int vc4_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -296,7 +278,7 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret)
 		goto gem_destroy;
 
-	vc4_kick_out_firmware_fb();
+	drm_fb_helper_remove_conflicting_framebuffers(NULL, "vc4drmfb", false);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
-- 
2.18.0

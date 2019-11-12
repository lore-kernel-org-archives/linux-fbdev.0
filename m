From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 12 Nov 2019 14:04:27 +0000
Subject: [PATCH v3 1/5] drm/udl: Set default color depth to 32 bpp
Message-Id: <20191112140431.7895-2-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191112140431.7895-1-tzimmermann@suse.de>
In-Reply-To: <20191112140431.7895-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The udl driver only supports color depths that are powers of two.
Change prefered default to 32 bpp.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index bc1ab6060dc6..1f8ebcc595de 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -437,7 +437,7 @@ int udl_modeset_init(struct drm_device *dev)
 	dev->mode_config.max_height = 2048;
 
 	dev->mode_config.prefer_shadow = 0;
-	dev->mode_config.preferred_depth = 24;
+	dev->mode_config.preferred_depth = 32;
 
 	dev->mode_config.funcs = &udl_mode_funcs;
 
-- 
2.23.0

From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 14 Nov 2019 12:51:05 +0000
Subject: [PATCH v5 2/3] drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
Message-Id: <20191114125106.28347-3-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191114125106.28347-1-tzimmermann@suse.de>
In-Reply-To: <20191114125106.28347-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

There are no callers of drm_fb_helper_unlink_fbi() left. Remove the
function.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 16 +---------------
 include/drm/drm_fb_helper.h     |  6 ------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 1038a2f0639e..eb97f34a15ea 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -563,8 +563,7 @@ EXPORT_SYMBOL(drm_fb_helper_unregister_fbi);
  * drm_fb_helper_fini - finialize a &struct drm_fb_helper
  * @fb_helper: driver-allocated fbdev helper, can be NULL
  *
- * This cleans up all remaining resources associated with @fb_helper. Must=
 be
- * called after drm_fb_helper_unlink_fbi() was called.
+ * This cleans up all remaining resources associated with @fb_helper.
  */
 void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
 {
@@ -604,19 +603,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helpe=
r)
 }
 EXPORT_SYMBOL(drm_fb_helper_fini);
=20
-/**
- * drm_fb_helper_unlink_fbi - wrapper around unlink_framebuffer
- * @fb_helper: driver-allocated fbdev helper, can be NULL
- *
- * A wrapper around unlink_framebuffer implemented by fbdev core
- */
-void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helper)
-{
-	if (fb_helper && fb_helper->fbdev)
-		unlink_framebuffer(fb_helper->fbdev);
-}
-EXPORT_SYMBOL(drm_fb_helper_unlink_fbi);
-
 static bool drm_fbdev_use_shadow_fb(struct drm_fb_helper *fb_helper)
 {
 	struct drm_device *dev =3D fb_helper->dev;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index e3a75ff07390..1c2e0c3cf857 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -231,8 +231,6 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
 			     struct drm_fb_helper_surface_size *sizes);
=20
-void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helper);
-
 void drm_fb_helper_deferred_io(struct fb_info *info,
 			       struct list_head *pagelist);
=20
@@ -356,10 +354,6 @@ static inline int drm_fb_helper_ioctl(struct fb_info *=
info, unsigned int cmd,
 	return 0;
 }
=20
-static inline void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helpe=
r)
-{
-}
-
 static inline void drm_fb_helper_deferred_io(struct fb_info *info,
 					     struct list_head *pagelist)
 {
--=20
2.23.0

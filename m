From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:32 +0000
Subject: [PATCH v2 02/14] drm/fb-helper: don't preserve fb_ops across deferred IO use
Message-Id: <1eae0b23d4724d5702b886b6a061ec8219eb9284.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

Deferred IO now preserves the fb_ops.

v2: Remove the no-op vfree, drop a local var  (Noralf)

Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 0c088ea70ad0..1751bb9ee8d8 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1954,7 +1954,6 @@ static int drm_fbdev_fb_release(struct fb_info *info,=
 int user)
 static void drm_fbdev_cleanup(struct drm_fb_helper *fb_helper)
 {
 	struct fb_info *fbi =3D fb_helper->fbdev;
-	struct fb_ops *fbops =3D NULL;
 	void *shadow =3D NULL;
=20
 	if (!fb_helper->dev)
@@ -1963,15 +1962,11 @@ static void drm_fbdev_cleanup(struct drm_fb_helper =
*fb_helper)
 	if (fbi && fbi->fbdefio) {
 		fb_deferred_io_cleanup(fbi);
 		shadow =3D fbi->screen_buffer;
-		fbops =3D fbi->fbops;
 	}
=20
 	drm_fb_helper_fini(fb_helper);
=20
-	if (shadow) {
-		vfree(shadow);
-		kfree(fbops);
-	}
+	vfree(shadow);
=20
 	drm_client_framebuffer_delete(fb_helper->buffer);
 }
@@ -2062,24 +2057,10 @@ static int drm_fb_helper_generic_probe(struct drm_f=
b_helper *fb_helper,
 	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
=20
 	if (drm_fbdev_use_shadow_fb(fb_helper)) {
-		struct fb_ops *fbops;
-		void *shadow;
-
-		/*
-		 * fb_deferred_io_cleanup() clears &fbops->fb_mmap so a per
-		 * instance version is necessary.
-		 */
-		fbops =3D kzalloc(sizeof(*fbops), GFP_KERNEL);
-		shadow =3D vzalloc(fbi->screen_size);
-		if (!fbops || !shadow) {
-			kfree(fbops);
-			vfree(shadow);
+		fbi->screen_buffer =3D vzalloc(fbi->screen_size);
+		if (!fbi->screen_buffer)
 			return -ENOMEM;
-		}
=20
-		*fbops =3D *fbi->fbops;
-		fbi->fbops =3D fbops;
-		fbi->screen_buffer =3D shadow;
 		fbi->fbdefio =3D &drm_fbdev_defio;
=20
 		fb_deferred_io_init(fbi);
--=20
2.20.1

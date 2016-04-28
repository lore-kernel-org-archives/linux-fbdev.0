From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Thu, 28 Apr 2016 15:18:31 +0000
Subject: [PATCH v4 1/7] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <1461856717-6476-2-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

Now that drm_fb_helper gets deferred io support, the
drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
a worker that will call the (struct drm_framebuffer *)->funcs->dirty()
function. This will break this driver so use the
sys_{fillrect,copyarea,imageblit} functions directly.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/udl/udl_fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index fd1eb9d..a52de2f 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -287,7 +287,7 @@ static void udl_fb_fillrect(struct fb_info *info, const=
 struct fb_fillrect *rect
 {
 	struct udl_fbdev *ufbdev =3D info->par;
=20
-	drm_fb_helper_sys_fillrect(info, rect);
+	sys_fillrect(info, rect);
=20
 	udl_handle_damage(&ufbdev->ufb, rect->dx, rect->dy, rect->width,
 			  rect->height);
@@ -297,7 +297,7 @@ static void udl_fb_copyarea(struct fb_info *info, const=
 struct fb_copyarea *regi
 {
 	struct udl_fbdev *ufbdev =3D info->par;
=20
-	drm_fb_helper_sys_copyarea(info, region);
+	sys_copyarea(info, region);
=20
 	udl_handle_damage(&ufbdev->ufb, region->dx, region->dy, region->width,
 			  region->height);
@@ -307,7 +307,7 @@ static void udl_fb_imageblit(struct fb_info *info, cons=
t struct fb_image *image)
 {
 	struct udl_fbdev *ufbdev =3D info->par;
=20
-	drm_fb_helper_sys_imageblit(info, image);
+	sys_imageblit(info, image);
=20
 	udl_handle_damage(&ufbdev->ufb, image->dx, image->dy, image->width,
 			  image->height);
--=20
2.2.2


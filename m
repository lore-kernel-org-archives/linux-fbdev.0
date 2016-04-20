From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Wed, 20 Apr 2016 15:25:24 +0000
Subject: [PATCH 3/8] drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <1461165929-11344-4-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

Now that drm_fb_helper gets deferred io support, the
drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
the worker that calls the deferred_io callback. This will break this
driver so use the sys_{fillrect,copyarea,imageblit} functions directly.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/qxl/qxl_fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 7136e52..06f032d 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -199,7 +199,7 @@ static void qxl_fb_fillrect(struct fb_info *info,
 {
 	struct qxl_fbdev *qfbdev =3D info->par;
=20
-	drm_fb_helper_sys_fillrect(info, rect);
+	sys_fillrect(info, rect);
 	qxl_dirty_update(qfbdev, rect->dx, rect->dy, rect->width,
 			 rect->height);
 }
@@ -209,7 +209,7 @@ static void qxl_fb_copyarea(struct fb_info *info,
 {
 	struct qxl_fbdev *qfbdev =3D info->par;
=20
-	drm_fb_helper_sys_copyarea(info, area);
+	sys_copyarea(info, area);
 	qxl_dirty_update(qfbdev, area->dx, area->dy, area->width,
 			 area->height);
 }
@@ -219,7 +219,7 @@ static void qxl_fb_imageblit(struct fb_info *info,
 {
 	struct qxl_fbdev *qfbdev =3D info->par;
=20
-	drm_fb_helper_sys_imageblit(info, image);
+	sys_imageblit(info, image);
 	qxl_dirty_update(qfbdev, image->dx, image->dy, image->width,
 			 image->height);
 }
--=20
2.2.2


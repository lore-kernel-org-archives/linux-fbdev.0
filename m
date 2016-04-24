From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Sun, 24 Apr 2016 20:48:55 +0000
Subject: [PATCH v2 1/8] drm/rect: Add some drm_clip_rect utility functions
Message-Id: <1461530942-22485-2-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

Add some utility functions for struct drm_clip_rect.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_rect.c | 67 ++++++++++++++++++++++++++++++++++++++++++=
++
 include/drm/drm_rect.h     | 69 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
index a8e2c86..a9fb1a8 100644
--- a/drivers/gpu/drm/drm_rect.c
+++ b/drivers/gpu/drm/drm_rect.c
@@ -434,3 +434,70 @@ void drm_rect_rotate_inv(struct drm_rect *r,
 	}
 }
 EXPORT_SYMBOL(drm_rect_rotate_inv);
+
+/**
+ * drm_clip_rect_intersect - intersect two clip rectangles
+ * @r1: first clip rectangle
+ * @r2: second clip rectangle
+ *
+ * Calculate the intersection of clip rectangles @r1 and @r2.
+ * @r1 will be overwritten with the intersection.
+ *
+ * RETURNS:
+ * %true if rectangle @r1 is still visible after the operation,
+ * %false otherwise.
+ */
+bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
+			     const struct drm_clip_rect *r2)
+{
+	r1->x1 =3D max(r1->x1, r2->x1);
+	r1->y1 =3D max(r1->y1, r2->y1);
+	r1->x2 =3D min(r1->x2, r2->x2);
+	r1->y2 =3D min(r1->y2, r2->y2);
+
+	return drm_clip_rect_visible(r1);
+}
+EXPORT_SYMBOL(drm_clip_rect_intersect);
+
+/**
+ * drm_clip_rect_merge - Merge clip rectangles
+ * @dst: destination clip rectangle
+ * @src: source clip rectangle(s), can be NULL
+ * @num_clips: number of source clip rectangles
+ * @flags: drm_mode_fb_dirty_cmd flags (DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
+ * @width: width of clip rectangle if @src is NULL
+ * @height: height of clip rectangle if @src is NULL
+ *
+ * The dirtyfb ioctl allows for a NULL clip rectangle to be passed in,
+ * so if @src is NULL, width and height is used to set a full clip rectang=
le.
+ * @dst takes part in the merge unless it is empty {0,0,0,0}.
+ */
+void drm_clip_rect_merge(struct drm_clip_rect *dst,
+			 struct drm_clip_rect *src, unsigned num_clips,
+			 unsigned flags, u32 width, u32 height)
+{
+	int i;
+
+	if (!src || !num_clips) {
+		dst->x1 =3D 0;
+		dst->x2 =3D width;
+		dst->y1 =3D 0;
+		dst->y2 =3D height;
+		return;
+	}
+
+	if (drm_clip_rect_is_empty(dst)) {
+		dst->x1 =3D ~0;
+		dst->y1 =3D ~0;
+	}
+
+	for (i =3D 0; i < num_clips; i++) {
+		if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
+			i++;
+		dst->x1 =3D min(dst->x1, src[i].x1);
+		dst->x2 =3D max(dst->x2, src[i].x2);
+		dst->y1 =3D min(dst->y1, src[i].y1);
+		dst->y2 =3D max(dst->y2, src[i].y2);
+	}
+}
+EXPORT_SYMBOL(drm_clip_rect_merge);
diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 83bb156..936ad8d 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -24,6 +24,8 @@
 #ifndef DRM_RECT_H
 #define DRM_RECT_H
=20
+#include <uapi/drm/drm.h>
+
 /**
  * DOC: rect utils
  *
@@ -171,4 +173,71 @@ void drm_rect_rotate_inv(struct drm_rect *r,
 			 int width, int height,
 			 unsigned int rotation);
=20
+/**
+ * drm_clip_rect_width - determine the clip rectangle width
+ * @r: clip rectangle whose width is returned
+ *
+ * RETURNS:
+ * The width of the clip rectangle.
+ */
+static inline int drm_clip_rect_width(const struct drm_clip_rect *r)
+{
+	return r->x2 - r->x1;
+}
+
+/**
+ * drm_clip_rect_height - determine the clip rectangle height
+ * @r: clip rectangle whose height is returned
+ *
+ * RETURNS:
+ * The height of the clip rectangle.
+ */
+static inline int drm_clip_rect_height(const struct drm_clip_rect *r)
+{
+	return r->y2 - r->y1;
+}
+
+/**
+ * drm_clip_rect_visible - determine if the the clip rectangle is visible
+ * @r: clip rectangle whose visibility is returned
+ *
+ * RETURNS:
+ * %true if the clip rectangle is visible, %false otherwise.
+ */
+static inline bool drm_clip_rect_visible(const struct drm_clip_rect *r)
+{
+	return drm_clip_rect_width(r) > 0 && drm_clip_rect_height(r) > 0;
+}
+
+/**
+ * drm_clip_rect_reset - Reset clip rectangle
+ * @clip: clip rectangle
+ *
+ * Sets clip rectangle to {0,0,0,0}.
+ */
+static inline void drm_clip_rect_reset(struct drm_clip_rect *clip)
+{
+	clip->x1 =3D 0;
+	clip->x2 =3D 0;
+	clip->y1 =3D 0;
+	clip->y2 =3D 0;
+}
+
+/**
+ * drm_clip_rect_is_empty - Is clip rectangle empty?
+ * @clip: clip rectangle
+ *
+ * Returns true if clip rectangle is {0,0,0,0}.
+ */
+static inline bool drm_clip_rect_is_empty(struct drm_clip_rect *clip)
+{
+	return (!clip->x1 && !clip->x2 && !clip->y1 && !clip->y2);
+}
+
+bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
+			     const struct drm_clip_rect *r2);
+void drm_clip_rect_merge(struct drm_clip_rect *dst,
+			 struct drm_clip_rect *src, unsigned num_clips,
+			 unsigned flags, u32 width, u32 height);
+
 #endif
--=20
2.2.2


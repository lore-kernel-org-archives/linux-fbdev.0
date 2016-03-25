From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:31 +0000
Subject: [PATCH 1/5] drm: add picture aspect ratio flags
Message-Id: <1458893855-3930-2-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
In-Reply-To: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

This patch adds drm flag bits for aspect ratio information

Currently drm flag bits don't have field for mode's picture
aspect ratio. This field will help the driver to pick mode with
right aspect ratio, and help in setting right VIC field in avi
infoframes.

Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
---
 include/uapi/drm/drm_mode.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index c021743..0dc9f6b 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -73,6 +73,19 @@
 #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM	(7<<14)
 #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF	(8<<14)
 
+/* Picture aspect ratio options */
+#define DRM_MODE_PICTURE_ASPECT_NONE		0
+#define DRM_MODE_PICTURE_ASPECT_4_3		1
+#define DRM_MODE_PICTURE_ASPECT_16_9		2
+
+/* Aspect ratio flag bitmask (4 bits 21:19) */
+#define	 DRM_MODE_FLAG_PARMASK		(0x0F<<19)
+#define  DRM_MODE_FLAG_PARNONE \
+		(DRM_MODE_PICTURE_ASPECT_NONE << 19)
+#define  DRM_MODE_FLAG_PAR4_3 \
+		(DRM_MODE_PICTURE_ASPECT_4_3 << 19)
+#define  DRM_MODE_FLAG_PAR16_9 \
+		(DRM_MODE_PICTURE_ASPECT_16_9 << 19)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
@@ -88,11 +101,6 @@
 #define DRM_MODE_SCALE_CENTER		2 /* Centered, no scaling */
 #define DRM_MODE_SCALE_ASPECT		3 /* Full screen, preserve aspect */
 
-/* Picture aspect ratio options */
-#define DRM_MODE_PICTURE_ASPECT_NONE	0
-#define DRM_MODE_PICTURE_ASPECT_4_3	1
-#define DRM_MODE_PICTURE_ASPECT_16_9	2
-
 /* Dithering mode options */
 #define DRM_MODE_DITHERING_OFF	0
 #define DRM_MODE_DITHERING_ON	1
-- 
1.9.1


From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:34 +0000
Subject: [PATCH 4/5] drm: Add flags for new aspect ratios
Message-Id: <1458893855-3930-5-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
In-Reply-To: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

HDMI 2.0/CEA-861-F introduces two new aspect ratios:
- 64:27
- 256:135

This patch adds DRM flags for the new aspect ratios
in the existing aspect ratio flags.

Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
---
 include/uapi/drm/drm_mode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 0dc9f6b..05a808d 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -77,6 +77,8 @@
 #define DRM_MODE_PICTURE_ASPECT_NONE		0
 #define DRM_MODE_PICTURE_ASPECT_4_3		1
 #define DRM_MODE_PICTURE_ASPECT_16_9		2
+#define DRM_MODE_PICTURE_ASPECT_64_27		3
+#define DRM_MODE_PICTURE_ASPECT_256_135	4
 
 /* Aspect ratio flag bitmask (4 bits 21:19) */
 #define	 DRM_MODE_FLAG_PARMASK		(0x0F<<19)
@@ -86,6 +88,10 @@
 		(DRM_MODE_PICTURE_ASPECT_4_3 << 19)
 #define  DRM_MODE_FLAG_PAR16_9 \
 		(DRM_MODE_PICTURE_ASPECT_16_9 << 19)
+#define  DRM_MODE_FLAG_PAR64_27 \
+		(DRM_MODE_PICTURE_ASPECT_64_27 << 19)
+#define  DRM_MODE_FLAG_PAR256_135 \
+		(DRM_MODE_PICTURE_ASPECT_256_135 << 19)
 
 /* DPMS flags */
 /* bit compatible with the xorg definitions. */
-- 
1.9.1


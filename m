From: Bernard Zhao <bernard@vivo.com>
Date: Mon, 27 Apr 2020 08:05:23 +0000
Subject: [PATCH] drivers/video: cleanup coding style in video a bit
Message-Id: <20200427080530.3234-1-bernard@vivo.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Uma Shankar <uma.shankar@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Shashank Sharma <shashank.sharma@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bernard Zhao <bernard@vivo.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com

Eliminate the magic numbers, add vender infoframe size macro
like other hdmi modules.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/video/hdmi.c | 2 +-
 include/linux/hdmi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 856a8c4e84a2..f693076f2e5f 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -495,7 +495,7 @@ int hdmi_vendor_infoframe_init(struct hdmi_vendor_infoframe *frame)
 	 * value
 	 */
 	frame->s3d_struct = HDMI_3D_STRUCTURE_INVALID;
-	frame->length = 4;
+	frame->length = HDMI_VENDOR_INFOFRAME_SIZE;
 
 	return 0;
 }
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 9613d796cfb1..ff25aeb95ee4 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -57,6 +57,7 @@ enum hdmi_infoframe_type {
 #define HDMI_SPD_INFOFRAME_SIZE    25
 #define HDMI_AUDIO_INFOFRAME_SIZE  10
 #define HDMI_DRM_INFOFRAME_SIZE    26
+#define HDMI_VENDOR_INFOFRAME_SIZE  4
 
 #define HDMI_INFOFRAME_SIZE(type)	\
 	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
-- 
2.26.2

From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 15 Sep 2016 18:04:11 +0000
Subject: [PATCH v5 1/2] gpu: ipu-v3: Add ipu_rot_mode_is_irt()
Message-Id: <1473962652-16820-2-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473962652-16820-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1473962652-16820-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, dri-devel@lists.freedesktop.org

Add a macro that returns boolean true if the given ipu_rotate_mode
requires the use of the Image Rotator.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-ic.c |  2 +-
 include/video/imx-ipu-v3.h  | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
index 1a37afc..321eb98 100644
--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -619,7 +619,7 @@ int ipu_ic_task_idma_init(struct ipu_ic *ic, struct ipuv3_channel *channel,
 	ipu_ic_write(ic, ic_idmac_2, IC_IDMAC_2);
 	ipu_ic_write(ic, ic_idmac_3, IC_IDMAC_3);
 
-	if (rot >= IPU_ROTATE_90_RIGHT)
+	if (ipu_rot_mode_is_irt(rot))
 		ic->rotation = true;
 
 unlock:
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index c3de740..fbbbecf 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -63,17 +63,25 @@ enum ipu_csi_dest {
 /*
  * Enumeration of IPU rotation modes
  */
+#define IPU_ROT_BIT_VFLIP (1 << 0)
+#define IPU_ROT_BIT_HFLIP (1 << 1)
+#define IPU_ROT_BIT_90    (1 << 2)
+
 enum ipu_rotate_mode {
 	IPU_ROTATE_NONE = 0,
-	IPU_ROTATE_VERT_FLIP,
-	IPU_ROTATE_HORIZ_FLIP,
-	IPU_ROTATE_180,
-	IPU_ROTATE_90_RIGHT,
-	IPU_ROTATE_90_RIGHT_VFLIP,
-	IPU_ROTATE_90_RIGHT_HFLIP,
-	IPU_ROTATE_90_LEFT,
+	IPU_ROTATE_VERT_FLIP = IPU_ROT_BIT_VFLIP,
+	IPU_ROTATE_HORIZ_FLIP = IPU_ROT_BIT_HFLIP,
+	IPU_ROTATE_180 = (IPU_ROT_BIT_VFLIP | IPU_ROT_BIT_HFLIP),
+	IPU_ROTATE_90_RIGHT = IPU_ROT_BIT_90,
+	IPU_ROTATE_90_RIGHT_VFLIP = (IPU_ROT_BIT_90 | IPU_ROT_BIT_VFLIP),
+	IPU_ROTATE_90_RIGHT_HFLIP = (IPU_ROT_BIT_90 | IPU_ROT_BIT_HFLIP),
+	IPU_ROTATE_90_LEFT = (IPU_ROT_BIT_90 |
+			      IPU_ROT_BIT_VFLIP | IPU_ROT_BIT_HFLIP),
 };
 
+/* 90-degree rotations require the IRT unit */
+#define ipu_rot_mode_is_irt(m) (((m) & IPU_ROT_BIT_90) != 0)
+
 enum ipu_color_space {
 	IPUV3_COLORSPACE_RGB,
 	IPUV3_COLORSPACE_YUV,
-- 
2.7.4


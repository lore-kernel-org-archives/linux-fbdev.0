From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 25 Feb 2014 11:43:41 +0000
Subject: [PATCH 1/3] imx-drm: Move IPU_PIX_FMT_GBR24 definition into imx-ipu-v3.h
Message-Id: <1393328624-28013-2-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The IPU display controller supports a non-standard green-red-blue ordered
format that is used on the connection between IPU display interface 1 and
the TV encoder on i.MX53.
In preparation for the move of IPU core code out of staging, place the
IPU_PIX_FMT_GBR24 definition in imx-ipu-v3.h, so that both the IPU
display interface driver and the TVE encoder driver can access it.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm.h           | 4 ----
 drivers/staging/imx-drm/imx-tve.c           | 1 +
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index aa21028..035ab62 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -1,10 +1,6 @@
 #ifndef _IMX_DRM_H_
 #define _IMX_DRM_H_
 
-#include <linux/videodev2.h>
-
-#define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
-
 struct device_node;
 struct drm_crtc;
 struct drm_connector;
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 702c0c3..50b25f1 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -31,6 +31,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
+#include "ipu-v3/imx-ipu-v3.h"
 #include "imx-drm.h"
 
 #define TVE_COM_CONF_REG	0x00
diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index 4826b5c..c4d14ea 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -25,6 +25,8 @@ enum ipuv3_type {
 	IPUV3H,
 };
 
+#define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
+
 /*
  * Bitfield of Display Interface signal polarities.
  */
-- 
1.8.5.3


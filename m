From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 08 Dec 2016 00:57:51 +0000
Subject: [PATCH 10/12] gpu: ipu-v3: Add ipu_unit_type enumeration
Message-Id: <1481158673-15937-11-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, tomi.valkeinen@ti.com, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds an enumeration of the major IPUv3 subunits. Provide that info
in struct ipu_client_platformdata to more easily determine the IPU
client type.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 include/video/imx-ipu-v3.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 53cd07c..7709af7 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -28,6 +28,23 @@ enum ipuv3_type {
 	IPUV3H,
 };
 
+/*
+ * Enumeration of the major IPU subunits
+ */
+enum ipu_unit_type {
+	IPU_IDMAC = 0,
+	IPU_CM,
+	IPU_CSI,
+	IPU_SMFC,
+	IPU_IC,
+	IPU_VDI,
+	IPU_IRT,
+	IPU_DC,
+	IPU_DI,
+	IPU_DP,
+	IPU_DMFC,
+};
+
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
 /*
@@ -399,6 +416,7 @@ int ipu_rot_mode_to_degrees(int *degrees, enum ipu_rotate_mode mode,
 			    bool hflip, bool vflip);
 
 struct ipu_client_platformdata {
+	enum ipu_unit_type type;
 	int csi;
 	int di;
 	int dc;
-- 
2.7.4


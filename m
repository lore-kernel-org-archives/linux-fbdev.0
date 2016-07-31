From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Sun, 31 Jul 2016 19:42:20 +0000
Subject: [PATCH v3 05/12] gpu: ipu-v3: set correct full sensor frame for PAL/NTSC
Message-Id: <1469994147-17549-6-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Set the sensor full frame based on whether the passed in mbus_fmt
is 720x480 (NTSC) or 720x576 (PAL).

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

---

v3: no changes
v2: no changes
---
 drivers/gpu/ipu-v3/ipu-csi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index 06631ac..641ed76 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -365,10 +365,14 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 {
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
-	u32 data = 0;
+	u32 width, height, data = 0;
 
 	fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
 
+	/* set default sensor frame width and height */
+	width = mbus_fmt->width;
+	height = mbus_fmt->height;
+
 	/* Set the CSI_SENS_CONF register remaining fields */
 	data |= cfg.data_width << CSI_SENS_CONF_DATA_WIDTH_SHIFT |
 		cfg.data_fmt << CSI_SENS_CONF_DATA_FMT_SHIFT |
@@ -386,11 +390,6 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 
 	ipu_csi_write(csi, data, CSI_SENS_CONF);
 
-	/* Setup sensor frame size */
-	ipu_csi_write(csi,
-		      (mbus_fmt->width - 1) | ((mbus_fmt->height - 1) << 16),
-		      CSI_SENS_FRM_SIZE);
-
 	/* Set CCIR registers */
 
 	switch (cfg.clk_mode) {
@@ -408,11 +407,12 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 			 * Field1BlankEnd = 0x7, Field1BlankStart = 0x3,
 			 * Field1ActiveEnd = 0x5, Field1ActiveStart = 0x1
 			 */
+			height = 625; /* framelines for PAL */
+
 			ipu_csi_write(csi, 0x40596 | CSI_CCIR_ERR_DET_EN,
 					  CSI_CCIR_CODE_1);
 			ipu_csi_write(csi, 0xD07DF, CSI_CCIR_CODE_2);
 			ipu_csi_write(csi, 0xFF0000, CSI_CCIR_CODE_3);
-
 		} else if (mbus_fmt->width = 720 && mbus_fmt->height = 480) {
 			/*
 			 * NTSC case
@@ -422,6 +422,8 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 			 * Field1BlankEnd = 0x6, Field1BlankStart = 0x2,
 			 * Field1ActiveEnd = 0x4, Field1ActiveStart = 0
 			 */
+			height = 525; /* framelines for NTSC */
+
 			ipu_csi_write(csi, 0xD07DF | CSI_CCIR_ERR_DET_EN,
 					  CSI_CCIR_CODE_1);
 			ipu_csi_write(csi, 0x40596, CSI_CCIR_CODE_2);
@@ -447,6 +449,10 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 		break;
 	}
 
+	/* Setup sensor frame size */
+	ipu_csi_write(csi, (width - 1) | ((height - 1) << 16),
+		      CSI_SENS_FRM_SIZE);
+
 	dev_dbg(csi->ipu->dev, "CSI_SENS_CONF = 0x%08X\n",
 		ipu_csi_read(csi, CSI_SENS_CONF));
 	dev_dbg(csi->ipu->dev, "CSI_ACT_FRM_SIZE = 0x%08X\n",
-- 
1.9.1


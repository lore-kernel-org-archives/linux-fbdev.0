From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 20 Dec 2013 17:52:46 +0000
Subject: [RFC PATCH 5/5] gpu: ipu-v3: Register the CSI modules
Message-Id: <1387561966-31758-6-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-common.c | 35 +++++++++++++++++++++++++++++++----
 include/video/imx-ipu-v3.h      |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index ad2639c..7535e7a 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1016,6 +1016,7 @@ static void platform_device_unregister_children(struct platform_device *pdev)
 struct ipu_platform_reg {
 	struct ipu_client_platformdata pdata;
 	const char *name;
+	int reg_offset;
 };
 
 static const struct ipu_platform_reg client_reg[] = {
@@ -1037,13 +1038,29 @@ static const struct ipu_platform_reg client_reg[] = {
 			.dma[1] = -EINVAL,
 		},
 		.name = "imx-ipuv3-crtc",
+	}, {
+		.pdata = {
+			.csi = 0,
+			.dma[0] = IPUV3_CHANNEL_CSI0,
+			.dma[1] = -EINVAL,
+		},
+		.reg_offset = IPU_CM_CSI0_REG_OFS,
+		.name = "imx-ipuv3-camera",
+	}, {
+		.pdata = {
+			.csi = 1,
+			.dma[0] = IPUV3_CHANNEL_CSI1,
+			.dma[1] = -EINVAL,
+		},
+		.reg_offset = IPU_CM_CSI1_REG_OFS,
+		.name = "imx-ipuv3-camera",
 	},
 };
 
 static DEFINE_MUTEX(ipu_client_id_mutex);
 static int ipu_client_id;
 
-static int ipu_add_client_devices(struct ipu_soc *ipu)
+static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 {
 	struct device *dev = ipu->dev;
 	unsigned i;
@@ -1062,11 +1079,21 @@ static int ipu_add_client_devices(struct ipu_soc *ipu)
 		const struct ipu_platform_reg *reg = &client_reg[i];
 		struct ipu_client_platformdata pdata = reg->pdata;
 		struct platform_device *pdev;
+		struct resource res;
 
 		pdata.ipu = ipu_id;
 
-		pdev = platform_device_register_data(dev, reg->name,
-			id++, &pdata, sizeof(pdata));
+		if (reg->reg_offset) {
+			memset(&res, 0, sizeof(res));
+			res.flags = IORESOURCE_MEM;
+			res.start = ipu_base + ipu->devtype->cm_ofs + reg->reg_offset;
+			res.end = res.start + PAGE_SIZE - 1;
+			pdev = platform_device_register_resndata(dev, reg->name,
+				id++, &res, 1, &pdata, sizeof(pdata));
+		} else {
+			pdev = platform_device_register_data(dev, reg->name,
+					id++, &pdata, sizeof(pdata));
+		}
 
 		if (IS_ERR(pdev))
 			goto err_register;
@@ -1262,7 +1289,7 @@ static int ipu_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_submodules_init;
 
-	ret = ipu_add_client_devices(ipu);
+	ret = ipu_add_client_devices(ipu, ipu_base);
 	if (ret) {
 		dev_err(&pdev->dev, "adding client devices failed with %d\n",
 				ret);
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 767302d..f5448d4 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -331,6 +331,7 @@ static inline void ipu_cpmem_set_burstsize(struct ipu_ch_param __iomem *p,
 };
 
 struct ipu_client_platformdata {
+	int csi;
 	int di;
 	int dc;
 	int dp;
-- 
1.8.5.1


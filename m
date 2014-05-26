From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:43 +0000
Subject: [PATCH v2 5/5] gpu: ipu-v3: Register the CSI modules
Message-Id: <1401113983-23132-6-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

This patch registers the two CSI platform devices per IPU.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since RFC:
 - Rebased onto current staging-next
---
 drivers/gpu/ipu-v3/ipu-common.c | 37 ++++++++++++++++++++++++++++++++-----
 include/video/imx-ipu-v3.h      |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 03f48b7..04e7b2e 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1044,6 +1044,7 @@ static void platform_device_unregister_children(struct platform_device *pdev)
 struct ipu_platform_reg {
 	struct ipu_client_platformdata pdata;
 	const char *name;
+	int reg_offset;
 };
 
 static const struct ipu_platform_reg client_reg[] = {
@@ -1065,13 +1066,29 @@ static const struct ipu_platform_reg client_reg[] = {
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
@@ -1085,9 +1102,19 @@ static int ipu_add_client_devices(struct ipu_soc *ipu)
 	for (i = 0; i < ARRAY_SIZE(client_reg); i++) {
 		const struct ipu_platform_reg *reg = &client_reg[i];
 		struct platform_device *pdev;
-
-		pdev = platform_device_register_data(dev, reg->name,
-			id++, &reg->pdata, sizeof(reg->pdata));
+		struct resource res;
+
+		if (reg->reg_offset) {
+			memset(&res, 0, sizeof(res));
+			res.flags = IORESOURCE_MEM;
+			res.start = ipu_base + ipu->devtype->cm_ofs + reg->reg_offset;
+			res.end = res.start + PAGE_SIZE - 1;
+			pdev = platform_device_register_resndata(dev, reg->name,
+				id++, &res, 1, &reg->pdata, sizeof(reg->pdata));
+		} else {
+			pdev = platform_device_register_data(dev, reg->name,
+				id++, &reg->pdata, sizeof(reg->pdata));
+		}
 
 		if (IS_ERR(pdev))
 			goto err_register;
@@ -1284,7 +1311,7 @@ static int ipu_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_submodules_init;
 
-	ret = ipu_add_client_devices(ipu);
+	ret = ipu_add_client_devices(ipu, ipu_base);
 	if (ret) {
 		dev_err(&pdev->dev, "adding client devices failed with %d\n",
 				ret);
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index ac7fbfa..3e43e22 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -336,6 +336,7 @@ static inline void ipu_cpmem_set_burstsize(struct ipu_ch_param __iomem *p,
 };
 
 struct ipu_client_platformdata {
+	int csi;
 	int di;
 	int dc;
 	int dp;
-- 
2.0.0.rc2


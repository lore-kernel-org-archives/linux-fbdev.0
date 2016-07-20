From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:02 +0000
Subject: [PATCH v2 04/13] gpu: ipu-v3: Add ipu_get_num()
Message-Id: <1468977071-29240-5-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds of-alias id to ipu_soc and retrieve with ipu_get_num().

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 8 ++++++++
 drivers/gpu/ipu-v3/ipu-prv.h    | 1 +
 include/video/imx-ipu-v3.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 30dc115..49af121 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -45,6 +45,12 @@ static inline void ipu_cm_write(struct ipu_soc *ipu, u32 value, unsigned offset)
 	writel(value, ipu->cm_reg + offset);
 }
 
+int ipu_get_num(struct ipu_soc *ipu)
+{
+	return ipu->id;
+}
+EXPORT_SYMBOL_GPL(ipu_get_num);
+
 void ipu_srm_dp_sync_update(struct ipu_soc *ipu)
 {
 	u32 val;
@@ -1220,6 +1226,7 @@ static int ipu_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id  			of_match_device(imx_ipu_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct ipu_soc *ipu;
 	struct resource *res;
 	unsigned long ipu_base;
@@ -1248,6 +1255,7 @@ static int ipu_probe(struct platform_device *pdev)
 		ipu->channel[i].ipu = ipu;
 	ipu->devtype = devtype;
 	ipu->ipu_type = devtype->type;
+	ipu->id = of_alias_get_id(np, "ipu");
 
 	spin_lock_init(&ipu->lock);
 	mutex_init(&ipu->channel_lock);
diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
index 845f64c..02057d8 100644
--- a/drivers/gpu/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -153,6 +153,7 @@ struct ipu_soc {
 	void __iomem		*cm_reg;
 	void __iomem		*idmac_reg;
 
+	int			id;
 	int			usecount;
 
 	struct clk		*clk;
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 5d59739..8a6ccaa 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -148,6 +148,7 @@ int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
 /*
  * IPU Common functions
  */
+int ipu_get_num(struct ipu_soc *ipu);
 void ipu_set_csi_src_mux(struct ipu_soc *ipu, int csi_id, bool mipi_csi2);
 void ipu_set_ic_src_mux(struct ipu_soc *ipu, int csi_id, bool vdi);
 void ipu_dump(struct ipu_soc *ipu);
-- 
1.9.1


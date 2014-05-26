From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:40 +0000
Subject: [PATCH v2 2/5] gpu: ipu-v3: Add SMFC code
Message-Id: <1401113983-23132-3-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

The Sensor Multi Fifo Controller (SMFC) is used as a buffer between
the two CSIs (writing simultaneously) and up to four IDMAC channels.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/Makefile     |  2 +-
 drivers/gpu/ipu-v3/ipu-common.c | 10 +++++
 drivers/gpu/ipu-v3/ipu-prv.h    |  6 +++
 drivers/gpu/ipu-v3/ipu-smfc.c   | 97 +++++++++++++++++++++++++++++++++++++++++
 include/video/imx-ipu-v3.h      |  6 +++
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-smfc.c

diff --git a/drivers/gpu/ipu-v3/Makefile b/drivers/gpu/ipu-v3/Makefile
index d21cc37..1887972b 100644
--- a/drivers/gpu/ipu-v3/Makefile
+++ b/drivers/gpu/ipu-v3/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_IMX_IPUV3_CORE) += imx-ipu-v3.o
 
-imx-ipu-v3-objs := ipu-common.o ipu-dc.o ipu-di.o ipu-dp.o ipu-dmfc.o
+imx-ipu-v3-objs := ipu-common.o ipu-dc.o ipu-di.o ipu-dp.o ipu-dmfc.o ipu-smfc.o
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index ad99477..6b3f4f1 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -896,8 +896,17 @@ static int ipu_submodules_init(struct ipu_soc *ipu,
 		goto err_dp;
 	}
 
+	ret = ipu_smfc_init(ipu, dev, ipu_base +
+			devtype->cm_ofs + IPU_CM_SMFC_REG_OFS);
+	if (ret) {
+		unit = "smfc";
+		goto err_smfc;
+	}
+
 	return 0;
 
+err_smfc:
+	ipu_dp_exit(ipu);
 err_dp:
 	ipu_dmfc_exit(ipu);
 err_dmfc:
@@ -977,6 +986,7 @@ EXPORT_SYMBOL_GPL(ipu_idmac_channel_irq);
 
 static void ipu_submodules_exit(struct ipu_soc *ipu)
 {
+	ipu_smfc_exit(ipu);
 	ipu_dp_exit(ipu);
 	ipu_dmfc_exit(ipu);
 	ipu_dc_exit(ipu);
diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
index 72e1158..c93f50e 100644
--- a/drivers/gpu/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -151,6 +151,8 @@ struct ipuv3_channel {
 struct ipu_dc_priv;
 struct ipu_dmfc_priv;
 struct ipu_di;
+struct ipu_smfc_priv;
+
 struct ipu_devtype;
 
 struct ipu_soc {
@@ -178,6 +180,7 @@ struct ipu_soc {
 	struct ipu_dp_priv	*dp_priv;
 	struct ipu_dmfc_priv	*dmfc_priv;
 	struct ipu_di		*di_priv[2];
+	struct ipu_smfc_priv	*smfc_priv;
 };
 
 void ipu_srm_dp_sync_update(struct ipu_soc *ipu);
@@ -206,4 +209,7 @@ void ipu_dc_exit(struct ipu_soc *ipu);
 int ipu_cpmem_init(struct ipu_soc *ipu, struct device *dev, unsigned long base);
 void ipu_cpmem_exit(struct ipu_soc *ipu);
 
+int ipu_smfc_init(struct ipu_soc *ipu, struct device *dev, unsigned long base);
+void ipu_smfc_exit(struct ipu_soc *ipu);
+
 #endif				/* __IPU_PRV_H__ */
diff --git a/drivers/gpu/ipu-v3/ipu-smfc.c b/drivers/gpu/ipu-v3/ipu-smfc.c
new file mode 100644
index 0000000..e4f85ad
--- /dev/null
+++ b/drivers/gpu/ipu-v3/ipu-smfc.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#define DEBUG
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+struct ipu_smfc_priv {
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+/*SMFC Registers */
+#define SMFC_MAP	0x0000
+#define SMFC_WMC	0x0004
+#define SMFC_BS		0x0008
+
+int ipu_smfc_set_burstsize(struct ipu_soc *ipu, int channel, int burstsize)
+{
+	struct ipu_smfc_priv *smfc = ipu->smfc_priv;
+	unsigned long flags;
+	u32 val, shift;
+
+	spin_lock_irqsave(&smfc->lock, flags);
+
+	shift = channel * 4;
+	val = readl(smfc->base + SMFC_BS);
+	val &= ~(0xf << shift);
+	val |= burstsize << shift;
+	writel(val, smfc->base + SMFC_BS);
+
+	spin_unlock_irqrestore(&smfc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_smfc_set_burstsize);
+
+int ipu_smfc_map_channel(struct ipu_soc *ipu, int channel, int csi_id, int mipi_id)
+{
+	struct ipu_smfc_priv *smfc = ipu->smfc_priv;
+	unsigned long flags;
+	u32 val, shift;
+
+	spin_lock_irqsave(&smfc->lock, flags);
+
+	shift = channel * 3;
+	val = readl(smfc->base + SMFC_MAP);
+	val &= ~(0x7 << shift);
+	val |= ((csi_id << 2) | mipi_id) << shift;
+	writel(val, smfc->base + SMFC_MAP);
+
+	spin_unlock_irqrestore(&smfc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_smfc_map_channel);
+
+int ipu_smfc_init(struct ipu_soc *ipu, struct device *dev,
+		  unsigned long base)
+{
+	struct ipu_smfc_priv *smfc;
+
+	smfc = devm_kzalloc(dev, sizeof(*smfc), GFP_KERNEL);
+	if (!smfc)
+		return -ENOMEM;
+
+	ipu->smfc_priv = smfc;
+	spin_lock_init(&smfc->lock);
+
+	smfc->base = devm_ioremap(dev, base, PAGE_SIZE);
+	if (!smfc->base)
+		return -ENOMEM;
+
+	pr_debug("%s: ioremap 0x%08lx -> %p\n", __func__, base, smfc->base);
+
+	return 0;
+}
+
+void ipu_smfc_exit(struct ipu_soc *ipu)
+{
+}
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index c2c6fab..2c71ba7 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -165,6 +165,12 @@ int ipu_dp_set_window_pos(struct ipu_dp *, u16 x_pos, u16 y_pos);
 int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable, u8 alpha,
 		bool bg_chan);
 
+/*
+ * IPU Sensor Multiple FIFO Controller (SMFC) functions
+ */
+int ipu_smfc_map_channel(struct ipu_soc *ipu, int channel, int csi_id, int mipi_id);
+int ipu_smfc_set_burstsize(struct ipu_soc *ipu, int channel, int burstsize);
+
 #define IPU_CPMEM_WORD(word, ofs, size) ((((word) * 160 + (ofs)) << 8) | (size))
 
 #define IPU_FIELD_UBO		IPU_CPMEM_WORD(0, 46, 22)
-- 
2.0.0.rc2


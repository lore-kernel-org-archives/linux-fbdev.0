From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:04 +0000
Subject: [PATCH v2 06/13] gpu: ipu-v3: Add ipu_set_vdi_src_mux()
Message-Id: <1468977071-29240-7-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds ipu_set_vdi_src_mux() that selects the VDIC input
(from CSI or memory).

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

---

v2:
- added macros for the VDI source select bits in register IPU_FS_PROC_FLOW1.
---
 drivers/gpu/ipu-v3/ipu-common.c | 20 ++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-prv.h    |  6 ++++++
 include/video/imx-ipu-v3.h      |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 1c5aff4..bb0377b 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -730,6 +730,26 @@ void ipu_set_ic_src_mux(struct ipu_soc *ipu, int csi_id, bool vdi)
 }
 EXPORT_SYMBOL_GPL(ipu_set_ic_src_mux);
 
+/*
+ * Set the source for the VDIC. Selects either from CSI[01] or memory.
+ */
+void ipu_set_vdi_src_mux(struct ipu_soc *ipu, bool csi)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	val = ipu_cm_read(ipu, IPU_FS_PROC_FLOW1);
+	val &= ~FS_VDI_SRC_SEL_MASK;
+	if (csi)
+		val |= FS_VDI_SRC_SEL_CSI_DIRECT;
+	ipu_cm_write(ipu, val, IPU_FS_PROC_FLOW1);
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_set_vdi_src_mux);
+
 
 /* IDMAC Channel Linking */
 
diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
index 02057d8..74445fb 100644
--- a/drivers/gpu/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -78,6 +78,12 @@ struct ipu_soc;
 #define IPU_DI0_COUNTER_RELEASE			(1 << 24)
 #define IPU_DI1_COUNTER_RELEASE			(1 << 25)
 
+/* IPU_FS_PROC_FLOW1 */
+#define FS_VDI_SRC_SEL_OFFSET			28
+#define FS_VDI_SRC_SEL_MASK			(0x3 << 28)
+#define FS_VDI_SRC_SEL_CSI_DIRECT		(0x1 << 28)
+#define FS_VDI_SRC_SEL_VDOA			(0x2 << 28)
+
 #define IPU_IDMAC_REG(offset)	(offset)
 
 #define IDMAC_CONF			IPU_IDMAC_REG(0x0000)
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index b252cb4..74d3059 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -152,6 +152,7 @@ int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
 int ipu_get_num(struct ipu_soc *ipu);
 void ipu_set_csi_src_mux(struct ipu_soc *ipu, int csi_id, bool mipi_csi2);
 void ipu_set_ic_src_mux(struct ipu_soc *ipu, int csi_id, bool vdi);
+void ipu_set_vdi_src_mux(struct ipu_soc *ipu, bool csi);
 void ipu_dump(struct ipu_soc *ipu);
 
 /*
-- 
1.9.1


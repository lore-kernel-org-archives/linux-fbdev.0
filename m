From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 18 Aug 2016 00:50:17 +0000
Subject: [PATCH v4 2/4] gpu: ipu-v3: Add FSU channel linking support
Message-Id: <1471481419-5917-3-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds functions to link and unlink source channels to sink
channels in the FSU:

int ipu_fsu_link(struct ipu_soc *ipu, int src_ch, int sink_ch);
int ipu_fsu_unlink(struct ipu_soc *ipu, int src_ch, int sink_ch);

The channels numbers are usually IDMAC channels, but they can also be
channels that do not transfer data to or from memory. The following
convenience functions can be used in place of ipu_fsu_link/unlink()
when both source and sink channels are IDMAC channels:

int ipu_idmac_link(struct ipuv3_channel *src, struct ipuv3_channel *sink);
int ipu_idmac_unlink(struct ipuv3_channel *src, struct ipuv3_channel *sink);

So far the following links are supported:

IPUV3_CHANNEL_IC_PRP_ENC_MEM -> IPUV3_CHANNEL_MEM_ROT_ENC
PUV3_CHANNEL_IC_PRP_VF_MEM   -> IPUV3_CHANNEL_MEM_ROT_VF
IPUV3_CHANNEL_IC_PP_MEM      -> IPUV3_CHANNEL_MEM_ROT_PP
IPUV3_CHANNEL_CSI_DIRECT     -> IPUV3_CHANNEL_CSI_VDI_PREV

More links can be added to the fsu_link_info[] array.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 131 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-prv.h    |  27 +++++++++
 include/video/imx-ipu-v3.h      |  13 ++++
 3 files changed, 171 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 9d3584b..891cbef 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -730,6 +730,137 @@ void ipu_set_ic_src_mux(struct ipu_soc *ipu, int csi_id, bool vdi)
 }
 EXPORT_SYMBOL_GPL(ipu_set_ic_src_mux);
 
+
+/* Frame Synchronization Unit Channel Linking */
+
+struct fsu_link_reg_info {
+	int chno;
+	u32 reg;
+	u32 mask;
+	u32 val;
+};
+
+struct fsu_link_info {
+	struct fsu_link_reg_info src;
+	struct fsu_link_reg_info sink;
+};
+
+static const struct fsu_link_info fsu_link_info[] = {
+	{
+		.src  = { IPUV3_CHANNEL_IC_PRP_ENC_MEM, IPU_FS_PROC_FLOW2,
+			  FS_PRP_ENC_DEST_SEL_MASK, FS_PRP_ENC_DEST_SEL_IRT_ENC },
+		.sink = { IPUV3_CHANNEL_MEM_ROT_ENC, IPU_FS_PROC_FLOW1,
+			  FS_PRPENC_ROT_SRC_SEL_MASK, FS_PRPENC_ROT_SRC_SEL_ENC },
+	}, {
+		.src =  { IPUV3_CHANNEL_IC_PRP_VF_MEM, IPU_FS_PROC_FLOW2,
+			  FS_PRPVF_DEST_SEL_MASK, FS_PRPVF_DEST_SEL_IRT_VF },
+		.sink = { IPUV3_CHANNEL_MEM_ROT_VF, IPU_FS_PROC_FLOW1,
+			  FS_PRPVF_ROT_SRC_SEL_MASK, FS_PRPVF_ROT_SRC_SEL_VF },
+	}, {
+		.src =  { IPUV3_CHANNEL_IC_PP_MEM, IPU_FS_PROC_FLOW2,
+			  FS_PP_DEST_SEL_MASK, FS_PP_DEST_SEL_IRT_PP },
+		.sink = { IPUV3_CHANNEL_MEM_ROT_PP, IPU_FS_PROC_FLOW1,
+			  FS_PP_ROT_SRC_SEL_MASK, FS_PP_ROT_SRC_SEL_PP },
+	}, {
+		.src =  { IPUV3_CHANNEL_CSI_DIRECT, 0 },
+		.sink = { IPUV3_CHANNEL_CSI_VDI_PREV, IPU_FS_PROC_FLOW1,
+			  FS_VDI_SRC_SEL_MASK, FS_VDI_SRC_SEL_CSI_DIRECT },
+	},
+};
+
+static const struct fsu_link_info *find_fsu_link_info(int src, int sink)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fsu_link_info); i++) {
+		if (src = fsu_link_info[i].src.chno &&
+		    sink = fsu_link_info[i].sink.chno)
+			return &fsu_link_info[i];
+	}
+
+	return NULL;
+}
+
+/*
+ * Links a source channel to a sink channel in the FSU.
+ */
+int ipu_fsu_link(struct ipu_soc *ipu, int src_ch, int sink_ch)
+{
+	const struct fsu_link_info *link;
+	u32 src_reg, sink_reg;
+	unsigned long flags;
+
+	link = find_fsu_link_info(src_ch, sink_ch);
+	if (!link)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	if (link->src.mask) {
+		src_reg = ipu_cm_read(ipu, link->src.reg);
+		src_reg &= ~link->src.mask;
+		src_reg |= link->src.val;
+		ipu_cm_write(ipu, src_reg, link->src.reg);
+	}
+
+	if (link->sink.mask) {
+		sink_reg = ipu_cm_read(ipu, link->sink.reg);
+		sink_reg &= ~link->sink.mask;
+		sink_reg |= link->sink.val;
+		ipu_cm_write(ipu, sink_reg, link->sink.reg);
+	}
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_fsu_link);
+
+/*
+ * Unlinks source and sink channels in the FSU.
+ */
+int ipu_fsu_unlink(struct ipu_soc *ipu, int src_ch, int sink_ch)
+{
+	const struct fsu_link_info *link;
+	u32 src_reg, sink_reg;
+	unsigned long flags;
+
+	link = find_fsu_link_info(src_ch, sink_ch);
+	if (!link)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	if (link->src.mask) {
+		src_reg = ipu_cm_read(ipu, link->src.reg);
+		src_reg &= ~link->src.mask;
+		ipu_cm_write(ipu, src_reg, link->src.reg);
+	}
+
+	if (link->sink.mask) {
+		sink_reg = ipu_cm_read(ipu, link->sink.reg);
+		sink_reg &= ~link->sink.mask;
+		ipu_cm_write(ipu, sink_reg, link->sink.reg);
+	}
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_fsu_unlink);
+
+/* Link IDMAC channels in the FSU */
+int ipu_idmac_link(struct ipuv3_channel *src, struct ipuv3_channel *sink)
+{
+	return ipu_fsu_link(src->ipu, src->num, sink->num);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_link);
+
+/* Unlink IDMAC channels in the FSU */
+int ipu_idmac_unlink(struct ipuv3_channel *src, struct ipuv3_channel *sink)
+{
+	return ipu_fsu_unlink(src->ipu, src->num, sink->num);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_unlink);
+
 struct ipu_devtype {
 	const char *name;
 	unsigned long cm_ofs;
diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
index 02057d8..dca2c3a 100644
--- a/drivers/gpu/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -75,6 +75,33 @@ struct ipu_soc;
 #define IPU_INT_CTRL(n)		IPU_CM_REG(0x003C + 4 * (n))
 #define IPU_INT_STAT(n)		IPU_CM_REG(0x0200 + 4 * (n))
 
+/* FS_PROC_FLOW1 */
+#define FS_PRPENC_ROT_SRC_SEL_MASK	(0xf << 0)
+#define FS_PRPENC_ROT_SRC_SEL_ENC		(0x7 << 0)
+#define FS_PRPVF_ROT_SRC_SEL_MASK	(0xf << 8)
+#define FS_PRPVF_ROT_SRC_SEL_VF			(0x8 << 8)
+#define FS_PP_SRC_SEL_MASK		(0xf << 12)
+#define FS_PP_ROT_SRC_SEL_MASK		(0xf << 16)
+#define FS_PP_ROT_SRC_SEL_PP			(0x5 << 16)
+#define FS_VDI1_SRC_SEL_MASK		(0x3 << 20)
+#define FS_VDI3_SRC_SEL_MASK		(0x3 << 20)
+#define FS_PRP_SRC_SEL_MASK		(0xf << 24)
+#define FS_VDI_SRC_SEL_MASK		(0x3 << 28)
+#define FS_VDI_SRC_SEL_CSI_DIRECT		(0x1 << 28)
+#define FS_VDI_SRC_SEL_VDOA			(0x2 << 28)
+
+/* FS_PROC_FLOW2 */
+#define FS_PRP_ENC_DEST_SEL_MASK	(0xf << 0)
+#define FS_PRP_ENC_DEST_SEL_IRT_ENC		(0x1 << 0)
+#define FS_PRPVF_DEST_SEL_MASK		(0xf << 4)
+#define FS_PRPVF_DEST_SEL_IRT_VF		(0x1 << 4)
+#define FS_PRPVF_ROT_DEST_SEL_MASK	(0xf << 8)
+#define FS_PP_DEST_SEL_MASK		(0xf << 12)
+#define FS_PP_DEST_SEL_IRT_PP			(0x3 << 12)
+#define FS_PP_ROT_DEST_SEL_MASK		(0xf << 16)
+#define FS_PRPENC_ROT_DEST_SEL_MASK	(0xf << 20)
+#define FS_PRP_DEST_SEL_MASK		(0xf << 24)
+
 #define IPU_DI0_COUNTER_RELEASE			(1 << 24)
 #define IPU_DI1_COUNTER_RELEASE			(1 << 25)
 
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 335d42e..1a3f7d4 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -107,6 +107,14 @@ enum ipu_channel_irq {
 #define IPUV3_CHANNEL_CSI2			 2
 #define IPUV3_CHANNEL_CSI3			 3
 #define IPUV3_CHANNEL_VDI_MEM_IC_VF		 5
+/*
+ * NOTE: channels 6,7 are unused in the IPU and are not IDMAC channels,
+ * but the direct CSI->VDI linking is handled the same way as IDMAC
+ * channel linking in the FSU via the IPU_FS_PROC_FLOW registers, so
+ * these channel names are used to support the direct CSI->VDI link.
+ */
+#define IPUV3_CHANNEL_CSI_DIRECT		 6
+#define IPUV3_CHANNEL_CSI_VDI_PREV		 7
 #define IPUV3_CHANNEL_MEM_VDI_PREV		 8
 #define IPUV3_CHANNEL_MEM_VDI_CUR		 9
 #define IPUV3_CHANNEL_MEM_VDI_NEXT		10
@@ -143,6 +151,7 @@ enum ipu_channel_irq {
 #define IPUV3_CHANNEL_ROT_PP_MEM		50
 #define IPUV3_CHANNEL_MEM_BG_SYNC_ALPHA		51
 #define IPUV3_CHANNEL_MEM_BG_ASYNC_ALPHA	52
+#define IPUV3_NUM_CHANNELS			64
 
 int ipu_map_irq(struct ipu_soc *ipu, int irq);
 int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
@@ -186,6 +195,10 @@ int ipu_idmac_get_current_buffer(struct ipuv3_channel *channel);
 bool ipu_idmac_buffer_is_ready(struct ipuv3_channel *channel, u32 buf_num);
 void ipu_idmac_select_buffer(struct ipuv3_channel *channel, u32 buf_num);
 void ipu_idmac_clear_buffer(struct ipuv3_channel *channel, u32 buf_num);
+int ipu_fsu_link(struct ipu_soc *ipu, int src_ch, int sink_ch);
+int ipu_fsu_unlink(struct ipu_soc *ipu, int src_ch, int sink_ch);
+int ipu_idmac_link(struct ipuv3_channel *src, struct ipuv3_channel *sink);
+int ipu_idmac_unlink(struct ipuv3_channel *src, struct ipuv3_channel *sink);
 
 /*
  * IPU Channel Parameter Memory (cpmem) functions
-- 
1.9.1


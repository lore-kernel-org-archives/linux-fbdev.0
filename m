From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:42 +0000
Subject: [PATCH v2 4/5] gpu: ipu-v3: Add CSI and SMFC module enable wrappers
Message-Id: <1401113983-23132-5-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

IPU_CONF_..._EN bits are implementation details, not to be made public.
Add wrappers around ipu_module_enable/disable, so the CSI V4L2 driver
can enable/disable the CSI and SMFC modules.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-common.c | 24 ++++++++++++++++++++++++
 include/video/imx-ipu-v3.h      |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 706a6f2..03f48b7 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -661,6 +661,30 @@ int ipu_module_disable(struct ipu_soc *ipu, u32 mask)
 }
 EXPORT_SYMBOL_GPL(ipu_module_disable);
 
+int ipu_csi_enable(struct ipu_soc *ipu, int csi)
+{
+	return ipu_module_enable(ipu, csi ? IPU_CONF_CSI1_EN : IPU_CONF_CSI0_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_csi_enable);
+
+int ipu_csi_disable(struct ipu_soc *ipu, int csi)
+{
+	return ipu_module_disable(ipu, csi ? IPU_CONF_CSI1_EN : IPU_CONF_CSI0_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_csi_disable);
+
+int ipu_smfc_enable(struct ipu_soc *ipu)
+{
+	return ipu_module_enable(ipu, IPU_CONF_SMFC_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_smfc_enable);
+
+int ipu_smfc_disable(struct ipu_soc *ipu)
+{
+	return ipu_module_disable(ipu, IPU_CONF_SMFC_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_smfc_disable);
+
 int ipu_idmac_get_current_buffer(struct ipuv3_channel *channel)
 {
 	struct ipu_soc *ipu = channel->ipu;
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index a7edf6a..ac7fbfa 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -167,8 +167,16 @@ int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable, u8 alpha,
 		bool bg_chan);
 
 /*
+ * IPU CMOS Sensor Interface (csi) functions
+ */
+int ipu_csi_enable(struct ipu_soc *ipu, int csi);
+int ipu_csi_disable(struct ipu_soc *ipu, int csi);
+
+/*
  * IPU Sensor Multiple FIFO Controller (SMFC) functions
  */
+int ipu_smfc_enable(struct ipu_soc *ipu);
+int ipu_smfc_disable(struct ipu_soc *ipu);
 int ipu_smfc_map_channel(struct ipu_soc *ipu, int channel, int csi_id, int mipi_id);
 int ipu_smfc_set_burstsize(struct ipu_soc *ipu, int channel, int burstsize);
 
-- 
2.0.0.rc2


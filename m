From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 20 Dec 2013 17:52:44 +0000
Subject: [RFC PATCH 3/5] gpu: ipu-v3: Add ipu_idmac_get_current_buffer function
Message-Id: <1387561966-31758-4-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This function returns the currently active buffer (0 or 1)
of a double buffered IDMAC channel. It is to be used by the
CSI driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-common.c | 9 +++++++++
 include/video/imx-ipu-v3.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 8f98719..29c89f2 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -663,6 +663,15 @@ int ipu_module_disable(struct ipu_soc *ipu, u32 mask)
 }
 EXPORT_SYMBOL_GPL(ipu_module_disable);
 
+int ipu_idmac_get_current_buffer(struct ipuv3_channel *channel)
+{
+	struct ipu_soc *ipu = channel->ipu;
+	unsigned int chno = channel->num;
+
+	return (ipu_cm_read(ipu, IPU_CHA_CUR_BUF(chno)) & idma_mask(chno)) ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_get_current_buffer);
+
 void ipu_idmac_select_buffer(struct ipuv3_channel *channel, u32 buf_num)
 {
 	struct ipu_soc *ipu = channel->ipu;
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 274da71..78ea31b 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -103,6 +103,7 @@ int ipu_idmac_wait_busy(struct ipuv3_channel *channel, int ms);
 
 void ipu_idmac_set_double_buffer(struct ipuv3_channel *channel,
 		bool doublebuffer);
+int ipu_idmac_get_current_buffer(struct ipuv3_channel *channel);
 void ipu_idmac_select_buffer(struct ipuv3_channel *channel, u32 buf_num);
 
 /*
-- 
1.8.5.1


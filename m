From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:41 +0000
Subject: [PATCH v2 3/5] gpu: ipu-v3: Add ipu_idmac_get_current_buffer function
Message-Id: <1401113983-23132-4-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

This function returns the currently active buffer (0 or 1)
of a double buffered IDMAC channel. It is to be used by the
CSI driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-common.c | 9 +++++++++
 include/video/imx-ipu-v3.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 6b3f4f1..706a6f2 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -661,6 +661,15 @@ int ipu_module_disable(struct ipu_soc *ipu, u32 mask)
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
index 2c71ba7..a7edf6a 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -104,6 +104,7 @@ int ipu_idmac_wait_busy(struct ipuv3_channel *channel, int ms);
 
 void ipu_idmac_set_double_buffer(struct ipuv3_channel *channel,
 		bool doublebuffer);
+int ipu_idmac_get_current_buffer(struct ipuv3_channel *channel);
 void ipu_idmac_select_buffer(struct ipuv3_channel *channel, u32 buf_num);
 
 /*
-- 
2.0.0.rc2


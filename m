From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 09 Jan 2019 00:15:42 +0000
Subject: [PATCH v6 03/12] gpu: ipu-v3: Add planar support to interlaced scan
Message-Id: <20190109001551.16113-4-slongerbeam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190109001551.16113-1-slongerbeam@gmail.com>
In-Reply-To: <20190109001551.16113-1-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>

To support interlaced scan with planar formats, cpmem SLUV must
be programmed with the correct chroma line stride. For full and
partial planar 4:2:2 (YUV422P, NV16), chroma line stride must
be doubled. For full and partial planar 4:2:0 (YUV420, YVU420, NV12),
chroma line stride must _not_ be doubled, since a single chroma line
is shared by two luma lines.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c              | 26 +++++++++++++++++++--
 drivers/staging/media/imx/imx-ic-prpencvf.c |  3 ++-
 drivers/staging/media/imx/imx-media-csi.c   |  3 ++-
 include/video/imx-ipu-v3.h                  |  3 ++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index 163fadb8a33a..d047a6867c59 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -277,9 +277,10 @@ void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
 }
 EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
 
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat)
 {
-	u32 ilo, sly;
+	u32 ilo, sly, sluv;
 
 	if (stride < 0) {
 		stride = -stride;
@@ -290,9 +291,30 @@ void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
 
 	sly = (stride * 2) - 1;
 
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		sluv = stride / 2 - 1;
+		break;
+	case V4L2_PIX_FMT_NV12:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_NV16:
+		sluv = stride * 2 - 1;
+		break;
+	default:
+		sluv = 0;
+		break;
+	}
+
 	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
 	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
 	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
+	if (sluv)
+		ipu_ch_param_write_field(ch, IPU_FIELD_SLUV, sluv);
 };
 EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
 
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 28f41caba05d..af7224846bd5 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -412,7 +412,8 @@ static int prp_setup_channel(struct prp_priv *priv,
 	if (image.pix.field = V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field) &&
 	    channel = priv->out_ch)
-		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline);
+		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ret = ipu_ic_task_idma_init(priv->ic, channel,
 				    image.pix.width, image.pix.height,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index c2a8d9cd31b7..da4808348845 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -512,7 +512,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	if (image.pix.field = V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field))
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
-					  image.pix.bytesperline);
+					  image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ipu_idmac_set_double_buffer(priv->idmac_ch, true);
 
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index bbc8481f567d..c887f4bee5f8 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -258,7 +258,8 @@ void ipu_cpmem_set_stride(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_high_priority(struct ipuv3_channel *ch);
 void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
 void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
 int ipu_cpmem_get_burstsize(struct ipuv3_channel *ch);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
-- 
2.17.1

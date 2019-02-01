From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:48:00 +0000
Subject: [PATCH 17/18] ALSA: hal2: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-18-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/mips/hal2.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index a4ed54aeaf1d..d63e1565b62b 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -454,21 +454,22 @@ static inline void hal2_stop_adc(struct snd_hal2 *hal2)
 	hal2->adc.pbus.pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
 }
 
-static int hal2_alloc_dmabuf(struct hal2_codec *codec)
+static int hal2_alloc_dmabuf(struct snd_hal2 *hal2, struct hal2_codec *codec)
 {
+	struct device *dev = hal2->card->dev;
 	struct hal2_desc *desc;
 	dma_addr_t desc_dma, buffer_dma;
 	int count = H2_BUF_SIZE / H2_BLOCK_SIZE;
 	int i;
 
-	codec->buffer = dma_alloc_attrs(NULL, H2_BUF_SIZE, &buffer_dma,
+	codec->buffer = dma_alloc_attrs(dev, H2_BUF_SIZE, &buffer_dma,
 					GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if (!codec->buffer)
 		return -ENOMEM;
-	desc = dma_alloc_attrs(NULL, count * sizeof(struct hal2_desc),
+	desc = dma_alloc_attrs(dev, count * sizeof(struct hal2_desc),
 			       &desc_dma, GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if (!desc) {
-		dma_free_attrs(NULL, H2_BUF_SIZE, codec->buffer, buffer_dma,
+		dma_free_attrs(dev, H2_BUF_SIZE, codec->buffer, buffer_dma,
 			       DMA_ATTR_NON_CONSISTENT);
 		return -ENOMEM;
 	}
@@ -482,17 +483,19 @@ static int hal2_alloc_dmabuf(struct hal2_codec *codec)
 		      desc_dma : desc_dma + (i + 1) * sizeof(struct hal2_desc);
 		desc++;
 	}
-	dma_cache_sync(NULL, codec->desc, count * sizeof(struct hal2_desc),
+	dma_cache_sync(dev, codec->desc, count * sizeof(struct hal2_desc),
 		       DMA_TO_DEVICE);
 	codec->desc_count = count;
 	return 0;
 }
 
-static void hal2_free_dmabuf(struct hal2_codec *codec)
+static void hal2_free_dmabuf(struct snd_hal2 *hal2, struct hal2_codec *codec)
 {
-	dma_free_attrs(NULL, codec->desc_count * sizeof(struct hal2_desc),
+	struct device *dev = hal2->card->dev;
+
+	dma_free_attrs(dev, codec->desc_count * sizeof(struct hal2_desc),
 		       codec->desc, codec->desc_dma, DMA_ATTR_NON_CONSISTENT);
-	dma_free_attrs(NULL, H2_BUF_SIZE, codec->buffer, codec->buffer_dma,
+	dma_free_attrs(dev, H2_BUF_SIZE, codec->buffer, codec->buffer_dma,
 		       DMA_ATTR_NON_CONSISTENT);
 }
 
@@ -540,7 +543,7 @@ static int hal2_playback_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hal2_pcm_hw;
 
-	err = hal2_alloc_dmabuf(&hal2->dac);
+	err = hal2_alloc_dmabuf(hal2, &hal2->dac);
 	if (err)
 		return err;
 	return 0;
@@ -550,7 +553,7 @@ static int hal2_playback_close(struct snd_pcm_substream *substream)
 {
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 
-	hal2_free_dmabuf(&hal2->dac);
+	hal2_free_dmabuf(hal2, &hal2->dac);
 	return 0;
 }
 
@@ -606,7 +609,7 @@ static void hal2_playback_transfer(struct snd_pcm_substream *substream,
 	unsigned char *buf = hal2->dac.buffer + rec->hw_data;
 
 	memcpy(buf, substream->runtime->dma_area + rec->sw_data, bytes);
-	dma_cache_sync(NULL, buf, bytes, DMA_TO_DEVICE);
+	dma_cache_sync(hal2->card->dev, buf, bytes, DMA_TO_DEVICE);
 
 }
 
@@ -629,7 +632,7 @@ static int hal2_capture_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hal2_pcm_hw;
 
-	err = hal2_alloc_dmabuf(adc);
+	err = hal2_alloc_dmabuf(hal2, adc);
 	if (err)
 		return err;
 	return 0;
@@ -639,7 +642,7 @@ static int hal2_capture_close(struct snd_pcm_substream *substream)
 {
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 
-	hal2_free_dmabuf(&hal2->adc);
+	hal2_free_dmabuf(hal2, &hal2->adc);
 	return 0;
 }
 
@@ -694,7 +697,7 @@ static void hal2_capture_transfer(struct snd_pcm_substream *substream,
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 	unsigned char *buf = hal2->adc.buffer + rec->hw_data;
 
-	dma_cache_sync(NULL, buf, bytes, DMA_FROM_DEVICE);
+	dma_cache_sync(hal2->card->dev, buf, bytes, DMA_FROM_DEVICE);
 	memcpy(substream->runtime->dma_area + rec->sw_data, buf, bytes);
 }
 
-- 
2.20.1

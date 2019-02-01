From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:48:01 +0000
Subject: [PATCH 18/18] ALSA: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-19-hch@lst.de>
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

Also use GFP_KERNEL instead of GFP_USER as the gfp_t for the memory
allocation, as we should treat this allocation as a normal kernel one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/mips/sgio2audio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 3ec9391a4736..53a4ee01c522 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -805,7 +805,7 @@ static int snd_sgio2audio_free(struct snd_sgio2audio *chip)
 		free_irq(snd_sgio2_isr_table[i].irq,
 			 &chip->channel[snd_sgio2_isr_table[i].idx]);
 
-	dma_free_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
+	dma_free_coherent(chip->card->dev, MACEISA_RINGBUFFERS_SIZE,
 			  chip->ring_base, chip->ring_base_dma);
 
 	/* release card data */
@@ -843,8 +843,9 @@ static int snd_sgio2audio_create(struct snd_card *card,
 
 	chip->card = card;
 
-	chip->ring_base = dma_alloc_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
-					     &chip->ring_base_dma, GFP_USER);
+	chip->ring_base = dma_alloc_coherent(card->dev,
+					     MACEISA_RINGBUFFERS_SIZE,
+					     &chip->ring_base_dma, GFP_KERNEL);
 	if (chip->ring_base = NULL) {
 		printk(KERN_ERR
 		       "sgio2audio: could not allocate ring buffers\n");
-- 
2.20.1

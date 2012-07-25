From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Jul 2012 16:01:00 +0000
Subject: [PATCH] ALSA: pcm - Don't define ARCH_HAS_DMA_MMAP_COHERENT privately for ARM
Message-Id: <1343232060-17851-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The ARM architecture now defines ARCH_HAS_DMA_MMAP_COHERENT, there's no
need to define it privately anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 sound/core/pcm_native.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

Hi Eiraku-san,

Could you please add this cleanup patch to your "Use dma_mmap_coherent to
support IOMMU mapper" series ?

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..84ead60 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3156,13 +3156,6 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 	.fault =	snd_pcm_mmap_data_fault,
 };
 
-#ifndef ARCH_HAS_DMA_MMAP_COHERENT
-/* This should be defined / handled globally! */
-#ifdef CONFIG_ARM
-#define ARCH_HAS_DMA_MMAP_COHERENT
-#endif
-#endif
-
 /*
  * mmap the DMA buffer on RAM
  */
-- 
Regards,

Laurent Pinchart


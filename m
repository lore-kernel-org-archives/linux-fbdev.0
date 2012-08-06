From: Hideki EIRAKU <hdk@igel.co.jp>
Date: Mon, 06 Aug 2012 09:55:22 +0000
Subject: [PATCH v3 2/4] ALSA: pcm - Don't define ARCH_HAS_DMA_MMAP_COHERENT privately for ARM
Message-Id: <1344246924-32620-3-git-send-email-hdk@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Katsuya MATSUBARA <matsu@igel.co.jp>, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The ARM architecture now defines ARCH_HAS_DMA_MMAP_COHERENT, there's no
need to define it privately anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 sound/core/pcm_native.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

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
1.7.0.4


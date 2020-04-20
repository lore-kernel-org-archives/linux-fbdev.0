From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Mon, 20 Apr 2020 18:36:34 +0000
Subject: [PATCH 1/5] drivers/powerpc: Replace _ALIGN_UP() by ALIGN()
Message-Id: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

_ALIGN_UP() is specific to powerpc
ALIGN() is generic and does the same

Replace _ALIGN_UP() by ALIGN()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/ps3/ps3-lpm.c               | 6 +++---
 drivers/vfio/pci/vfio_pci_nvlink2.c | 2 +-
 drivers/video/fbdev/ps3fb.c         | 4 ++--
 sound/ppc/snd_ps3.c                 | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index 83c45659bc9d..064b5884ba13 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -1096,8 +1096,8 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
 		lpm_priv->tb_cache_internal = NULL;
 		lpm_priv->tb_cache = NULL;
 	} else if (tb_cache) {
-		if (tb_cache != (void *)_ALIGN_UP((unsigned long)tb_cache, 128)
-			|| tb_cache_size != _ALIGN_UP(tb_cache_size, 128)) {
+		if (tb_cache != (void *)ALIGN((unsigned long)tb_cache, 128)
+			|| tb_cache_size != ALIGN(tb_cache_size, 128)) {
 			dev_err(sbd_core(), "%s:%u: unaligned tb_cache\n",
 				__func__, __LINE__);
 			result = -EINVAL;
@@ -1116,7 +1116,7 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
 			result = -ENOMEM;
 			goto fail_malloc;
 		}
-		lpm_priv->tb_cache = (void *)_ALIGN_UP(
+		lpm_priv->tb_cache = (void *)ALIGN(
 			(unsigned long)lpm_priv->tb_cache_internal, 128);
 	}
 
diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index ed20d73cc27c..65c61710c0e9 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -67,7 +67,7 @@ static size_t vfio_pci_nvgpu_rw(struct vfio_pci_device *vdev,
 	 *
 	 * This is not fast path anyway.
 	 */
-	sizealigned = _ALIGN_UP(posoff + count, PAGE_SIZE);
+	sizealigned = ALIGN(posoff + count, PAGE_SIZE);
 	ptr = ioremap_cache(data->gpu_hpa + posaligned, sizealigned);
 	if (!ptr)
 		return -EFAULT;
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index 834f63edf700..9df78fb77267 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -44,7 +44,7 @@
 #define GPU_CMD_BUF_SIZE			(2 * 1024 * 1024)
 #define GPU_FB_START				(64 * 1024)
 #define GPU_IOIF				(0x0d000000UL)
-#define GPU_ALIGN_UP(x)				_ALIGN_UP((x), 64)
+#define GPU_ALIGN_UP(x)				ALIGN((x), 64)
 #define GPU_MAX_LINE_LENGTH			(65536 - 64)
 
 #define GPU_INTR_STATUS_VSYNC_0			0	/* vsync on head A */
@@ -1015,7 +1015,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
 	}
 #endif
 
-	max_ps3fb_size = _ALIGN_UP(GPU_IOIF, 256*1024*1024) - GPU_IOIF;
+	max_ps3fb_size = ALIGN(GPU_IOIF, 256*1024*1024) - GPU_IOIF;
 	if (ps3fb_videomemory.size > max_ps3fb_size) {
 		dev_info(&dev->core, "Limiting ps3fb mem size to %lu bytes\n",
 			 max_ps3fb_size);
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 6d2a33b8faa0..b8161a08f2ca 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -926,7 +926,7 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 			    PAGE_SHIFT, /* use system page size */
 			    0, /* dma type; not used */
 			    NULL,
-			    _ALIGN_UP(SND_PS3_DMA_REGION_SIZE, PAGE_SIZE));
+			    ALIGN(SND_PS3_DMA_REGION_SIZE, PAGE_SIZE));
 	dev->d_region->ioid = PS3_AUDIO_IOID;
 
 	ret = ps3_dma_region_create(dev->d_region);
-- 
2.25.0

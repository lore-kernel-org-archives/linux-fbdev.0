From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Date: Mon, 23 Aug 2010 09:59:41 +0000
Subject: [PATCH 1/2] drivers/video: Removing dead FB_VIA_CAMERA config
Message-Id: <896537c6f9bd2e4babcb9ff4681bb4db72daf544.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
In-Reply-To: <cover.1282554255.git.qy03fugy@stud.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph Chan <JosephChan@via.com.tw>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Erik-Jan Post <ej.lfs@xs4all.nl>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vamos-dev@i4.informatik.uni-erlangen.de

CONFIG_FB_VIA_CAMERA doesn't exist in Kconfig, therefore removing
all references to it from the source.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
---
 drivers/video/via/accel.c |   16 ----------------
 include/linux/via-core.h  |    5 +----
 2 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index e44893e..43d4f30 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -370,22 +370,6 @@ int viafb_init_engine(struct fb_info *info)
 	viapar->shared->vq_vram_addr = viapar->fbmem_free;
 	viapar->fbmem_used += VQ_SIZE;
 
-#if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)
-	/*
-	 * Set aside a chunk of framebuffer memory for the camera
-	 * driver.  Someday this driver probably needs a proper allocator
-	 * for fbmem; for now, we just have to do this before the
-	 * framebuffer initializes itself.
-	 *
-	 * As for the size: the engine can handle three frames,
-	 * 16 bits deep, up to VGA resolution.
-	 */
-	viapar->shared->vdev->camera_fbmem_size = 3*VGA_HEIGHT*VGA_WIDTH*2;
-	viapar->fbmem_free -= viapar->shared->vdev->camera_fbmem_size;
-	viapar->fbmem_used += viapar->shared->vdev->camera_fbmem_size;
-	viapar->shared->vdev->camera_fbmem_offset = viapar->fbmem_free;
-#endif
-
 	/* Init AGP and VQ regs */
 	switch (chip_name) {
 	case UNICHROME_K8M890:
diff --git a/include/linux/via-core.h b/include/linux/via-core.h
index 7ffb521..7fc611e 100644
--- a/include/linux/via-core.h
+++ b/include/linux/via-core.h
@@ -81,10 +81,7 @@ struct viafb_dev {
 	unsigned long fbmem_start;
 	long fbmem_len;
 	void __iomem *fbmem;
-#if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)
-	long camera_fbmem_offset;
-	long camera_fbmem_size;
-#endif
+
 	/*
 	 * The MMIO region for device registers.
 	 */
-- 
1.7.0.4


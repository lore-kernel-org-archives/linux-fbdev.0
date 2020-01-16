From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:08:57 +0000
Subject: [PATCH 3/6] video: fbdev: controlfb: add COMPILE_TEST support
Message-Id: <20200116140900.26363-4-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200116140900.26363-1-b.zolnierkie@samsung.com>
 <CGME20200116140915eucas1p28dfeecf8a58cecb00262fe86fd19c4f5@eucas1p2.samsung.com>
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: b.zolnierkie@samsung.com

Add COMPILE_TEST support to controlfb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig     |  2 +-
 drivers/video/fbdev/controlfb.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..91c872457863 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -472,7 +472,7 @@ config FB_OF
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on (FB = y) && PPC_PMAC && PPC32
+	depends on (FB = y) && ((PPC_PMAC && PPC32) || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index bd0f61d8bdb5..87cd817ad4c6 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -47,12 +47,25 @@
 #include <linux/nvram.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
+#ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
 #include <asm/btext.h>
+#endif
 
 #include "macmodes.h"
 #include "controlfb.h"
 
+#ifndef CONFIG_PPC_PMAC
+#undef in_8
+#undef out_8
+#undef in_le32
+#undef out_le32
+#define in_8(addr)		0
+#define out_8(addr, val)
+#define in_le32(addr)		0
+#define out_le32(addr, val)
+#endif
+
 struct fb_par_control {
 	int	vmode, cmode;
 	int	xres, yres;
@@ -278,7 +291,9 @@ static int controlfb_mmap(struct fb_info *info,
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	} else {
 		/* framebuffer */
+#ifdef CONFIG_PPC_PMAC
 		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
+#endif
 	}
 
 	return vm_iomap_memory(vma, start, len);
@@ -582,13 +597,14 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0x600000], 0xb3);
 	out_8(&p->frame_buffer[0x600001], 0x71);
+#ifdef CONFIG_PPC_PMAC
 	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0x600000])
 					: "memory" );
 	mb();
 	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000])
 					: "memory" );
 	mb();
-
+#endif
 	bank2 = (in_8(&p->frame_buffer[0x600000]) = 0xb3)
 		&& (in_8(&p->frame_buffer[0x600001]) = 0x71);
 
@@ -601,13 +617,14 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0], 0x5a);
 	out_8(&p->frame_buffer[1], 0xc7);
+#ifdef CONFIG_PPC_PMAC
 	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0])
 					: "memory" );
 	mb();
 	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0])
 					: "memory" );
 	mb();
-
+#endif
 	bank1 = (in_8(&p->frame_buffer[0]) = 0x5a)
 		&& (in_8(&p->frame_buffer[1]) = 0xc7);
 
-- 
2.24.1

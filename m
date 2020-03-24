From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Mar 2020 13:45:04 +0000
Subject: [PATCH v2 2/6] video: fbdev: controlfb: add COMPILE_TEST support
Message-Id: <20200324134508.25120-3-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
 <CGME20200324134518eucas1p2441fc1b4d095d4320afe5e8a86e3430f@eucas1p2.samsung.com>
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com

Add COMPILE_TEST support to controlfb driver for better compile
testing coverage.

While at it:
- convert driver to use eieio() and dcbf() helpers instead of
  open-coding them
- add invalid_vram_cache() helper to avoid code duplication

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig     |  2 +-
 drivers/video/fbdev/controlfb.c | 41 ++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 91b0a719d221..fa88e8b9a83d 100644
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
index 9625792f4413..b347bc78bc4a 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -48,12 +48,37 @@
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
+#define invalid_vram_cache(addr)
+#undef in_8
+#undef out_8
+#undef in_le32
+#undef out_le32
+#define in_8(addr)		0
+#define out_8(addr, val)
+#define in_le32(addr)		0
+#define out_le32(addr, val)
+#define pgprot_cached_wthru(prot) (prot)
+#else
+static void invalid_vram_cache(void __force *addr)
+{
+	eieio();
+	dcbf(addr);
+	mb();
+	eieio();
+	dcbf(addr);
+	mb();
+}
+#endif
+
 struct fb_par_control {
 	int	vmode, cmode;
 	int	xres, yres;
@@ -309,7 +334,7 @@ static int controlfb_mmap(struct fb_info *info,
 
 static int controlfb_blank(int blank_mode, struct fb_info *info)
 {
-	struct fb_info_control *p +	struct fb_info_control __maybe_unused *p  		container_of(info, struct fb_info_control, info);
 	unsigned ctrl;
 
@@ -605,12 +630,7 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0x600000], 0xb3);
 	out_8(&p->frame_buffer[0x600001], 0x71);
-	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0x600000])
-					: "memory" );
-	mb();
-	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000])
-					: "memory" );
-	mb();
+	invalid_vram_cache(&p->frame_buffer[0x600000]);
 
 	bank2 = (in_8(&p->frame_buffer[0x600000]) = 0xb3)
 		&& (in_8(&p->frame_buffer[0x600001]) = 0x71);
@@ -624,12 +644,7 @@ static void __init find_vram_size(struct fb_info_control *p)
 
 	out_8(&p->frame_buffer[0], 0x5a);
 	out_8(&p->frame_buffer[1], 0xc7);
-	asm volatile("eieio; dcbf 0,%0" : : "r" (&p->frame_buffer[0])
-					: "memory" );
-	mb();
-	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0])
-					: "memory" );
-	mb();
+	invalid_vram_cache(&p->frame_buffer[0]);
 
 	bank1 = (in_8(&p->frame_buffer[0]) = 0x5a)
 		&& (in_8(&p->frame_buffer[1]) = 0xc7);
-- 
2.24.1

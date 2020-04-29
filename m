From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 29 Apr 2020 08:04:04 +0000
Subject: [PATCH] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <ba50c26a-d69b-d88d-b34d-3194971b1018@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429080406eucas1p21147ed99ad98332729c2a2aff2a33fb2@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <lkp@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


powerpc allyesconfig fails like this:

drivers/video/fbdev/controlfb.c: In function 'controlfb_mmap':
drivers/video/fbdev/controlfb.c:756:23: error: implicit declaration of function 'pgprot_cached_wthru'; did you mean 'pgprot_cached'? [-Werror=implicit-function-declaration]
  756 |   vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
      |                       ^~~~~~~~~~~~~~~~~~~
      |                       pgprot_cached
drivers/video/fbdev/controlfb.c:756:23: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'

Fix it by adding missing PPC32 dependency.

Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/video/fbdev/controlfb.c
=================================--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -47,7 +47,7 @@
 #include <linux/nvram.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
-#ifdef CONFIG_PPC_PMAC
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
 #include <asm/prom.h>
 #include <asm/btext.h>
 #endif
@@ -55,7 +55,7 @@
 #include "macmodes.h"
 #include "controlfb.h"
 
-#ifndef CONFIG_PPC_PMAC
+#if !defined(CONFIG_PPC_PMAC) || !defined(CONFIG_PPC32)
 #define invalid_vram_cache(addr)
 #undef in_8
 #undef out_8

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Aug 2019 03:55:14 +0000
Subject: [PATCH 2/4] video/logo: fix unneeded generation of font C files
Message-Id: <20190821035517.21671-3-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821035517.21671-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190821035517.21671-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Currently, all the font C files are generated irrespective of CONFIG
options. Adding them to extra-y is wrong. What we need to do here is
to add them to 'targets' so that if_changed works properly.

All files listed in 'targets' are cleaned, so clean-files is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/video/logo/Makefile | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 10b75ce3ce09..16f60c1e1766 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -18,23 +18,6 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-# Use logo-cfiles to retrieve list of .c files to be built
-logo-cfiles = $(notdir $(patsubst %.$(2), %.c, \
-              $(wildcard $(srctree)/$(src)/*$(1).$(2))))
-
-
-# Mono logos
-extra-y += $(call logo-cfiles,_mono,pbm)
-
-# VGA16 logos
-extra-y += $(call logo-cfiles,_vga16,ppm)
-
-# 224 Logos
-extra-y += $(call logo-cfiles,_clut224,ppm)
-
-# Gray 256
-extra-y += $(call logo-cfiles,_gray256,pgm)
-
 pnmtologo := scripts/pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
@@ -55,5 +38,5 @@ $(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
 $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-# Files generated that shall be removed upon make clean
-clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
+# generated C files
+targets += *_mono.c *_vga16.c *_clut224.c *_gray256.c
-- 
2.17.1

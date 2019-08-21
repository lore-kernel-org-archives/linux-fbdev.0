From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Aug 2019 03:55:16 +0000
Subject: [PATCH 4/4] video/logo: move pnmtologo tool to drivers/video/logo/ from scripts/
Message-Id: <20190821035517.21671-5-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821035517.21671-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190821035517.21671-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

This tool is only used by drivers/video/logo/Makefile. No reason to
keep it in scripts/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/video/logo/.gitignore               |  1 +
 drivers/video/logo/Makefile                 | 10 +++++-----
 {scripts => drivers/video/logo}/pnmtologo.c |  0
 scripts/.gitignore                          |  1 -
 scripts/Makefile                            |  2 --
 5 files changed, 6 insertions(+), 8 deletions(-)
 rename {scripts => drivers/video/logo}/pnmtologo.c (100%)

diff --git a/drivers/video/logo/.gitignore b/drivers/video/logo/.gitignore
index e48355f538fa..9dda1b26b2e4 100644
--- a/drivers/video/logo/.gitignore
+++ b/drivers/video/logo/.gitignore
@@ -5,3 +5,4 @@
 *_vga16.c
 *_clut224.c
 *_gray256.c
+pnmtologo
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 7d672d40bf01..bcda657493a4 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -18,19 +18,19 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-pnmtologo := scripts/pnmtologo
+hostprogs-y := pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-      cmd_logo = $(pnmtologo) -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
+      cmd_logo = $(obj)/pnmtologo -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
 
-$(obj)/%.c: $(src)/%.pbm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pbm $(obj)/pnmtologo FORCE
 	$(call if_changed,logo)
 
-$(obj)/%.c: $(src)/%.ppm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.ppm $(obj)/pnmtologo FORCE
 	$(call if_changed,logo)
 
-$(obj)/%.c: $(src)/%.pgm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pgm $(obj)/pnmtologo FORCE
 	$(call if_changed,logo)
 
 # generated C files
diff --git a/scripts/pnmtologo.c b/drivers/video/logo/pnmtologo.c
similarity index 100%
rename from scripts/pnmtologo.c
rename to drivers/video/logo/pnmtologo.c
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 17f8cef88fa8..4aa1806c59c2 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -4,7 +4,6 @@
 bin2c
 conmakehash
 kallsyms
-pnmtologo
 unifdef
 recordmcount
 sortextable
diff --git a/scripts/Makefile b/scripts/Makefile
index 16bcb8087899..709df809f892 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -4,7 +4,6 @@
 # the kernel for the build process.
 # ---------------------------------------------------------------------------
 # kallsyms:      Find all symbols in vmlinux
-# pnmttologo:    Convert pnm files to logo files
 # conmakehash:   Create chartable
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
@@ -12,7 +11,6 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
 hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
-hostprogs-$(CONFIG_LOGO)         += pnmtologo
 hostprogs-$(CONFIG_VT)           += conmakehash
 hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 hostprogs-$(CONFIG_BUILDTIME_EXTABLE_SORT) += sortextable
-- 
2.17.1

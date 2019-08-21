From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Aug 2019 04:12:36 +0000
Subject: [PATCH v2 3/4] video/logo: simplify cmd_logo
Message-Id: <20190821041237.23197-4-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821041237.23197-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190821041237.23197-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Shorten the code. It still works in the same way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/video/logo/Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 16f60c1e1766..7d672d40bf01 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -22,20 +22,15 @@ pnmtologo := scripts/pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-	cmd_logo = $(pnmtologo) \
-			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
-			-n $(notdir $(basename $<)) -o $@ $<
+      cmd_logo = $(pnmtologo) -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
 
-$(obj)/%_mono.c: $(src)/%_mono.pbm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pbm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.ppm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
-	$(call if_changed,logo)
-
-$(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # generated C files
-- 
2.17.1

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Aug 2019 04:12:34 +0000
Subject: [PATCH v2 1/4] video/logo: remove unneeded *.o pattern from clean-files
Message-Id: <20190821041237.23197-2-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821041237.23197-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190821041237.23197-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

The pattern *.o is cleaned up globally by the top Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/video/logo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 228a89b9bdd1..10b75ce3ce09 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -56,4 +56,4 @@ $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # Files generated that shall be removed upon make clean
-clean-files := *.o *_mono.c *_vga16.c *_clut224.c *_gray256.c
+clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
-- 
2.17.1

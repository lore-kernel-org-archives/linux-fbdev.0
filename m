From: Wang YanQing <udknight@gmail.com>
Date: Mon, 30 Dec 2013 06:53:03 +0000
Subject: [PATCH] fonts:Kconfig: fix default enable FONT_8x8 and FONT_8x16 at the same time
Message-Id: <20131230065303.GA6640@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

FONT_8x8 and FONT_8x16 have the same default value line:
"default y if !SPARC && !FONTS"

I test run "make defconfig" for x86 will enable FONT_8x8 and FONT_8x16 at
the same time.

This patch fix it, because FONT_AUTOSELECT choice FONT_8x16, so
I decide to disable FONT_8x8, this patch will reduce size of kernel.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 lib/fonts/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
index 34fd931..11d3758 100644
--- a/lib/fonts/Kconfig
+++ b/lib/fonts/Kconfig
@@ -23,7 +23,6 @@ config FONTS
 config FONT_8x8
 	bool "VGA 8x8 font" if FONTS
 	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
-	default y if !SPARC && !FONTS
 	help
 	  This is the "high resolution" font for the VGA frame buffer (the one
 	  provided by the text console 80x50 (and higher) modes).
-- 
1.8.3.4.8.g69490f3.dirty

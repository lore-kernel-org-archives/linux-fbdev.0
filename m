From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 18 Aug 2014 21:13:42 +0000
Subject: [PATCH] powerpc: Fix build error for vga16fb
Message-Id: <1408396422-32658-2-git-send-email-bobby.prani@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408396422-32658-1-git-send-email-bobby.prani@gmail.com>
In-Reply-To: <1408396422-32658-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene.kim@samsung.com>, Mark Brown <broonie@linaro.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>

Fix a build error caused by

drivers/built-in.o: In function `vga16fb_probe':
drivers/video/fbdev/vga16fb.c:1326: undefined reference to `vgacon_remap_base' 
drivers/video/fbdev/vga16fb.c:1326: undefined reference to `vgacon_remap_base'
make: *** [vmlinux] Error 1

This is occuring as vgacon_remap_base is exported only when
CONFIG_VGA_CONSOLE=y. Fix the error by making FB_VBA16 depend on
CONFIG_VGA_CONSOLE.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e911b9c..09df564 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -547,7 +547,7 @@ config FB_IMSTT
 
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
-	depends on FB && (X86 || PPC)
+	depends on FB && (X86 || PPC) && CONFIG_VGA_CONSOLE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.9.1


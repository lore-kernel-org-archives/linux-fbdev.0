From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 18 Aug 2014 21:40:39 +0000
Subject: [PATCH] powerpc: Fix build error caused by vga16fb
Message-Id: <1408398042-18241-1-git-send-email-bobby.prani@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Jean Delvare <jdelvare@suse.de>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Kukjin Kim <kgene.kim@samsung.com>, Pawel Moll <pawel.moll@arm.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>

vga16fb causes a build failure on PPC 32 as follows

drivers/built-in.o: In function `vga16fb_probe':
drivers/video/fbdev/vga16fb.c:1326: undefined reference to `vgacon_remap_base'
drivers/video/fbdev/vga16fb.c:1326: undefined reference to `vgacon_remap_base'
make: *** [vmlinux] Error 1

It was noted by Geert that in PPC, no one is setting vgacon_remap_base because
of which it working on PPC is suspect.

Fix the build failure by disabling vga16fb on PPC.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e911b9c..d236fe4 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -547,7 +547,7 @@ config FB_IMSTT
 
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
-	depends on FB && (X86 || PPC)
+	depends on FB && X86
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.9.1


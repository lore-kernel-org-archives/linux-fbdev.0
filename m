From: Nicolai Stange <nicstange@gmail.com>
Date: Wed, 17 Jun 2015 19:40:33 +0000
Subject: [PATCH] framebuffer: disable vgacon on microblaze arch
Message-Id: <87d20u5dji.fsf@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Fix an allmodconfig link failer on microblaze:
  drivers/built-in.o: In function `vgacon_save_screen':
  drivers/video/console/.tmp_vgacon.o:(.text+0x8fc10):
    undefined reference to `screen_info'

Disable vgacon on microblaze because the symbol
  struct screen_info screen_info;
is not defined for the microblaze arch.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 Note that this patch does not apply to the framebuffer maintainer repo
   kernel/git/plagnioj/linux-fbdev.git
 listed in MAINTAINERS since that one has not got
 ee23794b8668 ("video: vgacon: Don't build on arm64").
 This prerequisite patch has been merged from
   kernel/git/tomba/linux.git  fbdev-3.14
 into mainline in b788769e0641.

 The attached diff applies to both, the mainline tree and
 Tomi Valkeinen's tree (branch baseline-2015).

 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index ba97efc..e0dc0fe 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64
+		!ARM64 && !MICROBLAZE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.4.3


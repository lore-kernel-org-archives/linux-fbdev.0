From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 28 Jun 2014 06:34:05 +0000
Subject: [PATCH 1/2] video: clps711x: Fix driver build for CONFIG_FB=m
Message-Id: <1403937246-14506-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes building CLPS711X FB driver if the framebuffer
core is used as a module.

LD      init/built-in.o
  drivers/built-in.o: In function `clps711x_fb_remove':
  :(.text+0x44a8): undefined reference to `unregister_framebuffer'
  drivers/built-in.o: In function `clps711x_fb_probe':
  :(.text+0x44cc): undefined reference to `fb_get_options'
  :(.text+0x45d8): undefined reference to `fb_alloc_cmap'
  :(.text+0x45e4): undefined reference to `register_framebuffer'
make: *** [vmlinux] Error 1

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 06e1ff8..4a7098f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -302,7 +302,7 @@ config FB_ACORN
 	  unsure, say N.
 
 config FB_CLPS711X_OLD
-	bool
+	tristate
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.8.5.5


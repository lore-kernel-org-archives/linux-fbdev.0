From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Nov 2015 14:33:11 +0000
Subject: [PATCH] fbdev: sis: enforce selection of at least one backend
Message-Id: <2902419.SMzMybotxA@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The sis framebuffer driver complains with a compile-time warning
if neither the FB_SIS_300 nor FB_SIS_315 symbols are selected:

drivers/video/fbdev/sis/sis_main.c:61:2: warning: #warning Neither CONFIG_FB_SIS_300 nor CONFIG_FB_SIS_315 is se

This is reasonable because it doesn't work in that case, but it's
also annoying for randconfig builds and is one of the most common
warnings I'm seeing on ARM now.

This changes the Kconfig logic to prevent the silly configuration,
by always selecting the FB_SIS_300 variant if the other one is
not set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sorry for sending this twice, it looks like I forgot the fbdev list and
Tomi as recipients the first time

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e6d16d65e4e6..8a27c1443d01 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1506,6 +1506,7 @@ config FB_SIS
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_BOOT_VESA_SUPPORT if FB_SIS = y
+	select FB_SIS_300 if !FB_SIS_315
 	help
 	  This is the frame buffer device driver for the SiS 300, 315, 330
 	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.

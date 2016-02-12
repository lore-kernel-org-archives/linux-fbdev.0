From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Feb 2016 12:04:40 +0000
Subject: [PATCH] xen kconfig: clarify INPUT_XEN_KBDDEV_FRONTEND select
Message-Id: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Xen framebuffer driver selects the xen keyboard driver, so the latter
will be built-in if XEN_FBDEV_FRONTEND=y. However, when CONFIG_INPUT
is a loadable module, this configuration cannot work. On mainline kernels,
the symbol will be enabled but not used, while in combination with
a patch I have to detect such useless configurations, we get the
expected link failure:

drivers/input/built-in.o: In function `xenkbd_remove':
xen-kbdfront.c:(.text+0x2f0): undefined reference to `input_unregister_device'
xen-kbdfront.c:(.text+0x30e): undefined reference to `input_unregister_device'

This changes the dependencies of XEN_FBDEV_FRONTEND so it cannot be
built-in if CONFIG_INPUT=m && CONFIG_INPUT_MISC=y, as that would result
in the broken select.

As usual, we would be much better off without the 'select', but removing
it now would likely break existing user configurations that depend on
it, so this adds another hack on top to get it working.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 36c1132e34bd ("xen kconfig: fix select INPUT_XEN_KBDDEV_FRONTEND")
---
 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8ea45a5cd806..fd3d6fd290a9 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2241,6 +2241,7 @@ config FB_VIRTUAL
 config XEN_FBDEV_FRONTEND
 	tristate "Xen virtual frame buffer support"
 	depends on FB && XEN
+	depends on INPUT || !INPUT_MISC
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
-- 
2.7.0


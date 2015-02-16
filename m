From: Harald Geyer <harald@ccbib.org>
Date: Mon, 16 Feb 2015 18:34:04 +0000
Subject: [PATCH] framebuffer: don't link fb_devio into kernel image unconditionally
Message-Id: <E1YNQUe-0001Dc-KX@stardust.g4.wien.funkfeuer.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_FB_DEFERRED_IO is defined as bool while CONFIG_FB is defined as
tristate. Currently fb_defio.o is linked into the kernel image even if
CONFIG_FB=m. 

I fix this by updating the Makefile to link fb_defio.o into fb.o and thus
go into one place with the other core framebuffer code.

This has been tested on arm/sunxi.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/video/fbdev/core/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 67f28e2..23d86a8 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_FB_CMDLINE)          += fb_cmdline.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
+fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
 fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
@@ -14,4 +15,3 @@ obj-$(CONFIG_FB_SYS_IMAGEBLIT) += sysimgblt.o
 obj-$(CONFIG_FB_SYS_FOPS)      += fb_sys_fops.o
 obj-$(CONFIG_FB_SVGALIB)       += svgalib.o
 obj-$(CONFIG_FB_DDC)           += fb_ddc.o
-obj-$(CONFIG_FB_DEFERRED_IO)   += fb_defio.o
-- 
2.1.4


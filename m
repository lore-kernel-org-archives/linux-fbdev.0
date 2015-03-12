From: Harald Geyer <harald@ccbib.org>
Date: Thu, 12 Mar 2015 13:43:17 +0000
Subject: Re: [PATCHv2] framebuffer: don't link fb_devio into kernel image unconditionally
Message-Id: <E1YW3OP-000183-PZ@stardust.g4.wien.funkfeuer.at>
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

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1:
remove MODULE_LICENSE("GPL"); line from fb_defio.c

 drivers/video/fbdev/core/Makefile   |    2 +-
 drivers/video/fbdev/core/fb_defio.c |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

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
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 900aa4e..2082c37 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -241,5 +241,3 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
-
-MODULE_LICENSE("GPL");
-- 
1.7.2.5


From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/7] drivers/video/: possible cleanups
Date: Mon, 07 Nov 2005 19:22:51 +0800
Message-ID: <436F390B.3000402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5uL-0006Mg-Bo
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 04:15:29 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Bu-0006Hq-SS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:35 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:34 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

This patch contains the possible cleanups including the following:
- every file should #include the headers containing the prototypes for
it's global functions
- make needlessly global functions static
- kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
instead of a manual "struct pci_dev"
- i810_main.{c,h}: prototypes for static functions belong to the
C file

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 arcfb.c                     |    8 +++---
 console/softcursor.c        |    2 +
 i810/i810-i2c.c             |    1 
 i810/i810_accel.c           |    1 
 i810/i810_gtf.c             |    1 
 i810/i810_main.c            |   51 ++++++++++++++++++++++++++++++++++++----
 i810/i810_main.h            |   56 +++-----------------------------------------
 kyro/STG4000InitDevice.c    |    1 
 kyro/STG4000Interface.h     |    3 +-
 kyro/STG4000OverlayDevice.c |    1 
 matrox/matroxfb_g450.c      |    2 +
 nvidia/nv_hw.c              |    1 
 tdfxfb.c                    |    2 -
 13 files changed, 68 insertions(+), 62 deletions(-)


diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index a1fc8bb..35a3394 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -366,7 +366,8 @@ static void arcfb_lcd_update(struct arcf
 	}
 }
 
-void arcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void arcfb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
 {
 	struct arcfb_par *par = info->par;
 
@@ -376,7 +377,8 @@ void arcfb_fillrect(struct fb_info *info
 	arcfb_lcd_update(par, rect->dx, rect->dy, rect->width, rect->height);
 }
 
-void arcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void arcfb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *area)
 {
 	struct arcfb_par *par = info->par;
 
@@ -386,7 +388,7 @@ void arcfb_copyarea(struct fb_info *info
 	arcfb_lcd_update(par, area->dx, area->dy, area->width, area->height);
 }
 
-void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct arcfb_par *par = info->par;
 
diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 8529bf0..3957fc7 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -17,6 +17,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#include "fbcon.h"
+
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	unsigned int scan_align = info->pixmap.scan_align - 1;
diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index c61bad0..277b51a 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -17,6 +17,7 @@
 #include <linux/fb.h>
 #include "i810.h"
 #include "i810_regs.h"
+#include "i810_main.h"
 #include "../edid.h"
 
 #define I810_DDC 0x50
diff --git a/drivers/video/i810/i810_accel.c b/drivers/video/i810/i810_accel.c
index 64cd1c8..1ba6567 100644
--- a/drivers/video/i810/i810_accel.c
+++ b/drivers/video/i810/i810_accel.c
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 static u32 i810fb_rop[] = {
 	COLOR_COPY_ROP, /* ROP_COPY */
diff --git a/drivers/video/i810/i810_gtf.c b/drivers/video/i810/i810_gtf.c
index 64f087a..9743d51 100644
--- a/drivers/video/i810/i810_gtf.c
+++ b/drivers/video/i810/i810_gtf.c
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 /*
  * FIFO and Watermark tables - based almost wholly on i810_wmark.c in 
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index c0c974b..9310ae9 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -45,17 +45,58 @@
 
 #include <asm/io.h>
 #include <asm/div64.h>
-
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif 
-
 #include <asm/page.h>
 
 #include "i810_regs.h"
 #include "i810.h"
 #include "i810_main.h"
 
+/*
+ * voffset - framebuffer offset in MiB from aperture start address.  In order for
+ * the driver to work with X, we must try to use memory holes left untouched by X. The
+ * following table lists where X's different surfaces start at.
+ *
+ * ---------------------------------------------
+ * :                :  64 MiB     : 32 MiB      :
+ * ----------------------------------------------
+ * : FrontBuffer    :   0         :  0          :
+ * : DepthBuffer    :   48        :  16         :
+ * : BackBuffer     :   56        :  24         :
+ * ----------------------------------------------
+ *
+ * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
+ * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
+ * work, allowing 7 + 1 MiB of Framebuffer memory.
+ * Note, the size of the hole may change depending on how much memory you allocate to X,
+ * and how the memory is split up between these surfaces.
+ *
+ * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
+ * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
+ *
+ * Experiment with v_offset to find out which works best for you.
+ */
+static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
+static u32 voffset          __initdata = 0;
+
+static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
+static int  __devinit i810fb_init_pci (struct pci_dev *dev,
+				       const struct pci_device_id *entry);
+static void __exit i810fb_remove_pci(struct pci_dev *dev);
+static int i810fb_resume(struct pci_dev *dev);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
+
+/* Chipset Specific Functions */
+static int i810fb_set_par    (struct fb_info *info);
+static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
+			      u8 *transp, struct fb_info *info);
+static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
+			      unsigned transp, struct fb_info *info);
+static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
+static int i810fb_blank      (int blank_mode, struct fb_info *info);
+
+/* Initialization */
+static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
+
 /* PCI */
 static const char *i810_pci_list[] __devinitdata = {
 	"Intel(R) 810 Framebuffer Device"                                 ,
diff --git a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
index 06072a6..51d4f3d 100644
--- a/drivers/video/i810/i810_main.h
+++ b/drivers/video/i810/i810_main.h
@@ -14,55 +14,6 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
 
-static int  __devinit i810fb_init_pci (struct pci_dev *dev, 
-				       const struct pci_device_id *entry);
-static void __exit i810fb_remove_pci(struct pci_dev *dev);
-static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
-
-/*
- * voffset - framebuffer offset in MiB from aperture start address.  In order for
- * the driver to work with X, we must try to use memory holes left untouched by X. The 
- * following table lists where X's different surfaces start at.  
- * 
- * ---------------------------------------------
- * :                :  64 MiB     : 32 MiB      :
- * ----------------------------------------------
- * : FrontBuffer    :   0         :  0          :
- * : DepthBuffer    :   48        :  16         :
- * : BackBuffer     :   56        :  24         :
- * ----------------------------------------------
- *
- * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
- * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
- * work, allowing 7 + 1 MiB of Framebuffer memory.
- * Note, the size of the hole may change depending on how much memory you allocate to X,
- * and how the memory is split up between these surfaces.  
- *
- * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
- * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
- * 
- * Experiment with v_offset to find out which works best for you.
- */
-static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
-static u32 voffset          __initdata = 0;
-
-static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
-
-/* Chipset Specific Functions */
-static int i810fb_set_par    (struct fb_info *info);
-static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
-			      u8 *transp, struct fb_info *info);
-static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
-			      unsigned transp, struct fb_info *info);
-static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
-static int i810fb_blank      (int blank_mode, struct fb_info *info);
-
-/* Initialization */
-static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
-extern int __init agp_intel_init(void);
-
-
 /* Video Timings */
 extern void round_off_xres         (u32 *xres);
 extern void round_off_yres         (u32 *xres, u32 *yres);
@@ -101,7 +52,7 @@ static inline void i810_delete_i2c_busse
 
 /* Conditionals */
 #ifdef CONFIG_X86
-inline void flush_cache(void)
+static inline void flush_cache(void)
 {
 	asm volatile ("wbinvd":::"memory");
 }
@@ -110,7 +61,9 @@ inline void flush_cache(void)
 #endif 
 
 #ifdef CONFIG_MTRR
-#define KERNEL_HAS_MTRR 1
+
+#include <asm/mtrr.h>
+
 static inline void __devinit set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
@@ -128,7 +81,6 @@ static inline void unset_mtrr(struct i81
 			 par->aperture.size); 
 }
 #else
-#define KERNEL_HAS_MTRR 0
 #define set_mtrr(x) printk("set_mtrr: MTRR is disabled in the kernel\n")
 
 #define unset_mtrr(x) do { } while (0)
diff --git a/drivers/video/kyro/STG4000InitDevice.c b/drivers/video/kyro/STG4000InitDevice.c
index 7e33cd3..ab5285a 100644
--- a/drivers/video/kyro/STG4000InitDevice.c
+++ b/drivers/video/kyro/STG4000InitDevice.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* SDRAM fixed settings */
 #define SDRAM_CFG_0   0x49A1
diff --git a/drivers/video/kyro/STG4000Interface.h b/drivers/video/kyro/STG4000Interface.h
index e75b3b4..b7c83d5 100644
--- a/drivers/video/kyro/STG4000Interface.h
+++ b/drivers/video/kyro/STG4000Interface.h
@@ -11,7 +11,8 @@
 #ifndef _STG4000INTERFACE_H
 #define _STG4000INTERFACE_H
 
-struct pci_dev;
+#include <linux/pci.h>
+#include <video/kyro.h>
 
 /*
  * Ramdac Setup
diff --git a/drivers/video/kyro/STG4000OverlayDevice.c b/drivers/video/kyro/STG4000OverlayDevice.c
index 2ae9baf..a8c9713 100644
--- a/drivers/video/kyro/STG4000OverlayDevice.cFrom: Adrian Bunk <bunk@stusta.de>

This patch contains the possible cleanups including the following:
- every file should #include the headers containing the prototypes for
it's global functions
- make needlessly global functions static
- kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
instead of a manual "struct pci_dev"
- i810_main.{c,h}: prototypes for static functions belong to the
C file

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 arcfb.c                     |    8 +++---
 console/softcursor.c        |    2 +
 i810/i810-i2c.c             |    1 
 i810/i810_accel.c           |    1 
 i810/i810_gtf.c             |    1 
 i810/i810_main.c            |   51 ++++++++++++++++++++++++++++++++++++----
 i810/i810_main.h            |   56 +++-----------------------------------------
 kyro/STG4000InitDevice.c    |    1 
 kyro/STG4000Interface.h     |    3 +-
 kyro/STG4000OverlayDevice.c |    1 
 matrox/matroxfb_g450.c      |    2 +
 nvidia/nv_hw.c              |    1 
 tdfxfb.c                    |    2 -
 13 files changed, 68 insertions(+), 62 deletions(-)


diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index a1fc8bb..35a3394 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -366,7 +366,8 @@ static void arcfb_lcd_update(struct arcf
 	}
 }
 
-void arcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void arcfb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
 {
 	struct arcfb_par *par = info->par;
 
@@ -376,7 +377,8 @@ void arcfb_fillrect(struct fb_info *info
 	arcfb_lcd_update(par, rect->dx, rect->dy, rect->width, rect->height);
 }
 
-void arcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void arcfb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *area)
 {
 	struct arcfb_par *par = info->par;
 
@@ -386,7 +388,7 @@ void arcfb_copyarea(struct fb_info *info
 	arcfb_lcd_update(par, area->dx, area->dy, area->width, area->height);
 }
 
-void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct arcfb_par *par = info->par;
 
diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 8529bf0..3957fc7 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -17,6 +17,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#include "fbcon.h"
+
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	unsigned int scan_align = info->pixmap.scan_align - 1;
diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index c61bad0..277b51a 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -17,6 +17,7 @@
 #include <linux/fb.h>
 #include "i810.h"
 #include "i810_regs.h"
+#include "i810_main.h"
 #include "../edid.h"
 
 #define I810_DDC 0x50
diff --git a/drivers/video/i810/i810_accel.c b/drivers/video/i810/i810_accel.c
index 64cd1c8..1ba6567 100644
--- a/drivers/video/i810/i810_accel.c
+++ b/drivers/video/i810/i810_accel.c
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 static u32 i810fb_rop[] = {
 	COLOR_COPY_ROP, /* ROP_COPY */
diff --git a/drivers/video/i810/i810_gtf.c b/drivers/video/i810/i810_gtf.c
index 64f087a..9743d51 100644
--- a/drivers/video/i810/i810_gtf.c
+++ b/drivers/video/i810/i810_gtf.c
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 /*
  * FIFO and Watermark tables - based almost wholly on i810_wmark.c in 
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index c0c974b..9310ae9 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -45,17 +45,58 @@
 
 #include <asm/io.h>
 #include <asm/div64.h>
-
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif 
-
 #include <asm/page.h>
 
 #include "i810_regs.h"
 #include "i810.h"
 #include "i810_main.h"
 
+/*
+ * voffset - framebuffer offset in MiB from aperture start address.  In order for
+ * the driver to work with X, we must try to use memory holes left untouched by X. The
+ * following table lists where X's different surfaces start at.
+ *
+ * ---------------------------------------------
+ * :                :  64 MiB     : 32 MiB      :
+ * ----------------------------------------------
+ * : FrontBuffer    :   0         :  0          :
+ * : DepthBuffer    :   48        :  16         :
+ * : BackBuffer     :   56        :  24         :
+ * ----------------------------------------------
+ *
+ * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
+ * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
+ * work, allowing 7 + 1 MiB of Framebuffer memory.
+ * Note, the size of the hole may change depending on how much memory you allocate to X,
+ * and how the memory is split up between these surfaces.
+ *
+ * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
+ * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
+ *
+ * Experiment with v_offset to find out which works best for you.
+ */
+static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
+static u32 voffset          __initdata = 0;
+
+static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
+static int  __devinit i810fb_init_pci (struct pci_dev *dev,
+				       const struct pci_device_id *entry);
+static void __exit i810fb_remove_pci(struct pci_dev *dev);
+static int i810fb_resume(struct pci_dev *dev);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
+
+/* Chipset Specific Functions */
+static int i810fb_set_par    (struct fb_info *info);
+static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
+			      u8 *transp, struct fb_info *info);
+static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
+			      unsigned transp, struct fb_info *info);
+static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
+static int i810fb_blank      (int blank_mode, struct fb_info *info);
+
+/* Initialization */
+static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
+
 /* PCI */
 static const char *i810_pci_list[] __devinitdata = {
 	"Intel(R) 810 Framebuffer Device"                                 ,
diff --git a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
index 06072a6..51d4f3d 100644
--- a/drivers/video/i810/i810_main.h
+++ b/drivers/video/i810/i810_main.h
@@ -14,55 +14,6 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
 
-static int  __devinit i810fb_init_pci (struct pci_dev *dev, 
-				       const struct pci_device_id *entry);
-static void __exit i810fb_remove_pci(struct pci_dev *dev);
-static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
-
-/*
- * voffset - framebuffer offset in MiB from aperture start address.  In order for
- * the driver to work with X, we must try to use memory holes left untouched by X. The 
- * following table lists where X's different surfaces start at.  
- * 
- * ---------------------------------------------
- * :                :  64 MiB     : 32 MiB      :
- * ----------------------------------------------
- * : FrontBuffer    :   0         :  0          :
- * : DepthBuffer    :   48        :  16         :
- * : BackBuffer     :   56        :  24         :
- * ----------------------------------------------
- *
- * So for chipsets with 64 MiB Aperture sizes, 32 MiB for v_offset is okay, allowing up to
- * 15 + 1 MiB of Framebuffer memory.  For 32 MiB Aperture sizes, a v_offset of 8 MiB should
- * work, allowing 7 + 1 MiB of Framebuffer memory.
- * Note, the size of the hole may change depending on how much memory you allocate to X,
- * and how the memory is split up between these surfaces.  
- *
- * Note: Anytime the DepthBuffer or FrontBuffer is overlapped, X would still run but with
- * DRI disabled.  But if the Frontbuffer is overlapped, X will fail to load.
- * 
- * Experiment with v_offset to find out which works best for you.
- */
-static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should be the default */
-static u32 voffset          __initdata = 0;
-
-static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
-
-/* Chipset Specific Functions */
-static int i810fb_set_par    (struct fb_info *info);
-static int i810fb_getcolreg  (u8 regno, u8 *red, u8 *green, u8 *blue,
-			      u8 *transp, struct fb_info *info);
-static int i810fb_setcolreg  (unsigned regno, unsigned red, unsigned green, unsigned blue,
-			      unsigned transp, struct fb_info *info);
-static int i810fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
-static int i810fb_blank      (int blank_mode, struct fb_info *info);
-
-/* Initialization */
-static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
-extern int __init agp_intel_init(void);
-
-
 /* Video Timings */
 extern void round_off_xres         (u32 *xres);
 extern void round_off_yres         (u32 *xres, u32 *yres);
@@ -101,7 +52,7 @@ static inline void i810_delete_i2c_busse
 
 /* Conditionals */
 #ifdef CONFIG_X86
-inline void flush_cache(void)
+static inline void flush_cache(void)
 {
 	asm volatile ("wbinvd":::"memory");
 }
@@ -110,7 +61,9 @@ inline void flush_cache(void)
 #endif 
 
 #ifdef CONFIG_MTRR
-#define KERNEL_HAS_MTRR 1
+
+#include <asm/mtrr.h>
+
 static inline void __devinit set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
@@ -128,7 +81,6 @@ static inline void unset_mtrr(struct i81
 			 par->aperture.size); 
 }
 #else
-#define KERNEL_HAS_MTRR 0
 #define set_mtrr(x) printk("set_mtrr: MTRR is disabled in the kernel\n")
 
 #define unset_mtrr(x) do { } while (0)
diff --git a/drivers/video/kyro/STG4000InitDevice.c b/drivers/video/kyro/STG4000InitDevice.c
index 7e33cd3..ab5285a 100644
--- a/drivers/video/kyro/STG4000InitDevice.c
+++ b/drivers/video/kyro/STG4000InitDevice.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* SDRAM fixed settings */
 #define SDRAM_CFG_0   0x49A1
diff --git a/drivers/video/kyro/STG4000Interface.h b/drivers/video/kyro/STG4000Interface.h
index e75b3b4..b7c83d5 100644
--- a/drivers/video/kyro/STG4000Interface.h
+++ b/drivers/video/kyro/STG4000Interface.h
@@ -11,7 +11,8 @@
 #ifndef _STG4000INTERFACE_H
 #define _STG4000INTERFACE_H
 
-struct pci_dev;
+#include <linux/pci.h>
+#include <video/kyro.h>
 
 /*
  * Ramdac Setup
diff --git a/drivers/video/kyro/STG4000OverlayDevice.c b/drivers/video/kyro/STG4000OverlayDevice.c
index 2ae9baf..a8c9713 100644
--- a/drivers/video/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/kyro/STG4000OverlayDevice.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* HW Defines */
 
diff --git a/drivers/video/matrox/matroxfb_g450.c b/drivers/video/matrox/matroxfb_g450.c
index 35008af..c122d87 100644
--- a/drivers/video/matrox/matroxfb_g450.c
+++ b/drivers/video/matrox/matroxfb_g450.c
@@ -20,6 +20,8 @@
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 
+#include "matroxfb_g450.h"
+
 /* Definition of the various controls */
 struct mctl {
 	struct v4l2_queryctrl desc;
diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index b989358..9940bc0 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -52,6 +52,7 @@
 #include <linux/pci.h>
 #include "nv_type.h"
 #include "nv_local.h"
+#include "nv_proto.h"
 
 void NVLockUnlock(struct nvidia_par *par, int Lock)
 {
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 9d53387..60bc890 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -1307,7 +1307,7 @@ out_err:
 }
 
 #ifndef MODULE
-void tdfxfb_setup(char *options)
+static void tdfxfb_setup(char *options)
 {
 	char* this_opt;
 

+++ b/drivers/video/kyro/STG4000OverlayDevice.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include "STG4000Reg.h"
+#include "STG4000Interface.h"
 
 /* HW Defines */
 
diff --git a/drivers/video/matrox/matroxfb_g450.c b/drivers/video/matrox/matroxfb_g450.c
index 35008af..c122d87 100644
--- a/drivers/video/matrox/matroxfb_g450.c
+++ b/drivers/video/matrox/matroxfb_g450.c
@@ -20,6 +20,8 @@
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 
+#include "matroxfb_g450.h"
+
 /* Definition of the various controls */
 struct mctl {
 	struct v4l2_queryctrl desc;
diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index b989358..9940bc0 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -52,6 +52,7 @@
 #include <linux/pci.h>
 #include "nv_type.h"
 #include "nv_local.h"
+#include "nv_proto.h"
 
 void NVLockUnlock(struct nvidia_par *par, int Lock)
 {
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 9d53387..60bc890 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -1307,7 +1307,7 @@ out_err:
 }
 
 #ifndef MODULE
-void tdfxfb_setup(char *options)
+static void tdfxfb_setup(char *options)
 {
 	char* this_opt;
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

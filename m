From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: New radeonfb, mostly untested
Date: Sun, 07 Sep 2003 18:37:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062952639.655.6.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-m+GI2G6Nn/nYjyiXbFnO"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w2ZB-0006Os-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 09:39:09 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19w2Yv-0006tb-Un
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 09:38:54 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Jon Smirl <jonsmirl@yahoo.com>, kronos <kronos@kronoz.cjb.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-m+GI2G6Nn/nYjyiXbFnO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi !

Ok, enough for today, my head hurts, it builds, it detects my
PowerBook's internal panel properly, I didn't test anything else
yet nor x86, let me know what you think...

No dual head nor mirror yet, though I try hard to detect properly
both monitors.

Ben.


--=-m+GI2G6Nn/nYjyiXbFnO
Content-Disposition: attachment; filename=patch1-radeonfb.diff
Content-Type: text/x-patch; name=patch1-radeonfb.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.5-mesa/drivers/video/Kconfig linuxppc-2.5-benh/drivers/video/Kconfig
--- linux-2.5-mesa/drivers/video/Kconfig	2003-09-07 18:25:20.000000000 +0200
+++ linuxppc-2.5-benh/drivers/video/Kconfig	2003-09-07 15:07:45.000000000 +0200
@@ -659,8 +659,18 @@
 	  There is no need for enabling 'Matrox multihead support' if you have
 	  only one Matrox card in the box.
 
+config FB_RADEON_OLD
+	tristate "ATI Radeon display support (Old driver)"
+	depends on FB && PCI
+	help
+	  Choose this option if you want to use an ATI Radeon graphics card as
+	  a framebuffer device.  There are both PCI and AGP versions.  You
+	  don't need to choose this to run the Radeon in plain VGA mode.
+	  There is a product page at
+	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
+
 config FB_RADEON
-	tristate "ATI Radeon display support"
+	tristate "ATI Radeon display support (New driver)"
 	depends on FB && PCI
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -673,7 +683,7 @@
 
 	  If you say M here then "I2C support" and "I2C bit-banging support" 
 	  can be build either as modules or built-in.
-	  
+
 	  There is a product page at
 	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
 
diff -urN linux-2.5-mesa/drivers/video/Makefile linuxppc-2.5-benh/drivers/video/Makefile
--- linux-2.5-mesa/drivers/video/Makefile	2003-09-07 18:25:20.000000000 +0200
+++ linuxppc-2.5-benh/drivers/video/Makefile	2003-09-07 15:09:05.000000000 +0200
@@ -21,7 +21,7 @@
 obj-$(CONFIG_FB_Q40)              += q40fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o
 obj-$(CONFIG_FB_68328)            += 68328fb.o
-obj-$(CONFIG_FB_RADEON)		  += radeonfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_IGA)              += igafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CONTROL)          += controlfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
@@ -54,12 +54,14 @@
 obj-$(CONFIG_FB_PMAGB_B)          += pmagb-b-fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_MAXINE)           += maxinefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_TX3912)           += tx3912fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_IBMLCDC)	  += ibmlcdfb.o
 
 obj-$(CONFIG_FB_MATROX)		  += matrox/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
 obj-$(CONFIG_FB_SIS)		  += sis/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_ATY)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_ATY128)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
+obj-$(CONFIG_FB_RADEON)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o vgastate.o
 
diff -urN linux-2.5-mesa/drivers/video/aty/radeon_base.c linuxppc-2.5-benh/drivers/video/aty/radeon_base.c
--- linux-2.5-mesa/drivers/video/aty/radeon_base.c	Thu Jan 01 01:00:00 1970
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_base.c	Sun Sep 07 18:02:53 2003
@@ -0,0 +1,2168 @@
+/*
+ *	drivers/video/radeonfb.c
+ *	framebuffer driver for ATI Radeon chipset video boards
+ *
+ *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
+ *	Copyright 2000	Ani Joshi <ajoshi@kernel.crashing.org>
+ *
+ *	i2c bits from Luca Tettamanti <kronos@kronoz.cjb.net>
+ *	
+ *	Special thanks to ATI DevRel team for their hardware donations.
+ *
+ *	...Insert GPL boilerplate here...
+ *
+ *	TODO: - Bring a couple of cleanups from 2.4 to the mode setting code,
+ *	      - Split CRT vs. FP register calc/setting
+ *	      - Add CRTC2 support for mirror at least, dual head then
+ *	      - Add back some accel
+ *
+ */
+
+
+#define RADEON_VERSION	"0.2.0"
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#if CONFIG_PPC_OF
+
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include "../macmodes.h"
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/backlight.h>
+#endif
+
+#ifdef CONFIG_BOOTX_TEXT
+#include <asm/btext.h>
+#endif
+
+#endif /* CONFIG_PPC_OF */
+
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+
+#include <video/radeon.h>
+#include <linux/radeonfb.h>
+
+#include "../edid.h" // MOVE THAT TO include/video
+#include "radeonfb.h"
+
+/* Must match above enum */
+static const char *radeon_family[] __devinitdata = {
+	"R100",
+	"VE RV100",
+	"8500 R200",
+	"7500 RV200",
+	"9000 RV250",
+	"9200 RV280",
+	"9700 R300",
+	"9700 RS300",
+	"9800 R350",
+	"Mobility M6",
+	"Mobility M7",
+	"Mobility M9",
+};
+		    
+
+
+static struct pci_device_id radeonfb_pci_table[] = {
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_A6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_A7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ad, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_B7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_BB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_C6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_C7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_D7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV250},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ie, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV250},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_If, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV250},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ig, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV250},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_In, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV250_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_LW, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M7},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_LX, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M7},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M6},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M6},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ld, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M9},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Le, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M9},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Lf, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M9},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Lg, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M9},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ln, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_M9_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_ND, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NH, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R350},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Nd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ne, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Nf, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ng, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R300_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Nh, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R350_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QH, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QI, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QJ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QK, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QL, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QN, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QO, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QW, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QX, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV200},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV100},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Qh, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Qi, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Qj, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Qk, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ql, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_R200_SEC},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_X7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RS300},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Y_, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_RV280},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
+
+
+typedef struct {
+	u16 reg;
+	u32 val;
+} reg_val;
+
+
+/* these common regs are cleared before mode setting so they do not
+ * interfere with anything
+ */
+reg_val common_regs[] = {
+	{ OVR_CLR, 0 },	
+	{ OVR_WID_LEFT_RIGHT, 0 },
+	{ OVR_WID_TOP_BOTTOM, 0 },
+	{ OV0_SCALE_CNTL, 0 },
+	{ SUBPIC_CNTL, 0 },
+	{ VIPH_CONTROL, 0 },
+	{ I2C_CNTL_1, 0 },
+	{ GEN_INT_CNTL, 0 },
+	{ CAP0_TRIG_CNTL, 0 },
+};
+
+reg_val common_regs_m6[] = {
+	{ OVR_CLR,      0 },
+	{ OVR_WID_LEFT_RIGHT,   0 },
+	{ OVR_WID_TOP_BOTTOM,   0 },
+	{ OV0_SCALE_CNTL,   0 },
+	{ SUBPIC_CNTL,      0 },
+	{ GEN_INT_CNTL,     0 },
+	{ CAP0_TRIG_CNTL,   0 } 
+};
+
+/*
+ * globals
+ */
+        
+static char *mode_option __initdata;
+static char *monitor_layout __initdata;
+static int noaccel = 0;
+static int nomodeset = 0;
+static int ignore_edid = 0;
+static int mirror = 0;
+static int panel_yres __initdata = 0;
+static int force_dfp __initdata = 0;
+static struct radeonfb_info *board_list = NULL;
+#ifdef CONFIG_MTRR
+static int nomtrr __initdata = 0;
+#endif
+
+/*
+ * prototypes
+ */
+
+static void radeon_save_state (struct radeonfb_info *rinfo,
+                               struct radeon_regs *save);
+static void radeon_engine_init (struct radeonfb_info *rinfo);
+static void radeon_write_mode (struct radeonfb_info *rinfo,
+                               struct radeon_regs *mode);
+static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo);
+
+#ifdef CONFIG_PPC_OF
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+static int radeon_set_backlight_enable(int on, int level, void *data);
+static int radeon_set_backlight_level(int level, void *data);
+static struct backlight_controller radeon_backlight_controller = {
+	radeon_set_backlight_enable,
+	radeon_set_backlight_level
+};
+#endif /* CONFIG_PMAC_BACKLIGHT */
+
+#endif /* CONFIG_PPC_OF */
+
+/* Wrapper for external files */
+int radeon_accel_disabled(void)
+{
+	return noaccel;
+}
+
+void _radeon_engine_reset(struct radeonfb_info *rinfo)
+{
+	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
+
+	radeon_engine_flush (rinfo);
+
+	clock_cntl_index = INREG(CLOCK_CNTL_INDEX);
+	mclk_cntl = INPLL(MCLK_CNTL);
+
+	OUTPLL(MCLK_CNTL, (mclk_cntl |
+			   FORCEON_MCLKA |
+			   FORCEON_MCLKB |
+			   FORCEON_YCLKA |
+			   FORCEON_YCLKB |
+			   FORCEON_MC |
+			   FORCEON_AIC));
+	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
+
+	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset |
+				SOFT_RESET_CP |
+				SOFT_RESET_HI |
+				SOFT_RESET_SE |
+				SOFT_RESET_RE |
+				SOFT_RESET_PP |
+				SOFT_RESET_E2 |
+				SOFT_RESET_RB);
+	INREG(RBBM_SOFT_RESET);
+	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset & (u32)
+				~(SOFT_RESET_CP |
+				  SOFT_RESET_HI |
+				  SOFT_RESET_SE |
+				  SOFT_RESET_RE |
+				  SOFT_RESET_PP |
+				  SOFT_RESET_E2 |
+				  SOFT_RESET_RB));
+	INREG(RBBM_SOFT_RESET);
+
+	OUTPLL(MCLK_CNTL, mclk_cntl);
+	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
+	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
+
+	return;
+}
+
+static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
+{
+	// leave it disabled and unassigned
+	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	
+	if (!rinfo->bios_seg)
+		return;
+	iounmap(rinfo->bios_seg);
+	
+	if (r->parent) {
+		release_resource(r);
+		r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+		r->end -= r->start;
+		r->start = 0;
+	}
+	/* This will disable and set address to unassigned */
+	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+}
+
+static void * __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
+{
+	/* If this is a primary card, there is a shadow copy of the
+	 * ROM somewhere in the first meg. We will just ignore the copy
+	 * and use the ROM directly.
+	 */
+    
+    	/* Fix from ATI for problem with Radeon hardware not leaving ROM enabled */
+    	unsigned int temp;
+	temp = INREG(MPP_TB_CONFIG);
+	temp &= 0x00ffffffu;
+	temp |= 0x04 << 24;
+	OUTREG(MPP_TB_CONFIG, temp);
+	temp = INREG(MPP_TB_CONFIG);
+                                                                                                          
+	/* no need to search for the ROM, just ask the card where it is. */
+	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	void *rom;
+	
+	/* assign the ROM an address if it doesn't have one */
+	if (r->parent == NULL)
+		pci_assign_resource(dev, PCI_ROM_RESOURCE);
+	
+	/* enable if needed */
+	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		pci_write_config_dword(dev, dev->rom_base_reg, r->start | PCI_ROM_ADDRESS_ENABLE);
+		r->flags |= PCI_ROM_ADDRESS_ENABLE;
+	}
+	
+	rom = ioremap(r->start, r->end - r->start + 1);
+	if (!rom) {
+		printk(KERN_ERR "radeonfb: ROM failed to map\n");
+		return NULL;
+	}
+	
+	rinfo->bios_seg = rom;
+
+	/* Very simple test to make sure it appeared */
+	if (BIOS_IN16(0) != 0xaa55) {
+		printk(KERN_ERR "radeonfb: Invalid ROM signature %x should be 0xaa55\n", BIOS_IN16(0));
+		rinfo->bios_seg = NULL;
+		radeon_unmap_ROM(rinfo, dev);
+		return NULL;
+	}
+	/* Locate the flat panel infos */
+	rinfo->fp_bios_start = BIOS_IN16(0x48);
+
+	return rom;
+}
+
+#ifdef CONFIG_PPC_OF
+static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+{
+	struct device_node *dp;
+	unsigned int *xtal;
+
+	dp = pci_device_to_OF_node(rinfo->pdev);
+
+	xtal = (unsigned int *) get_property(dp, "ATY,RefCLK", 0);
+	if (!xtal || !*xtal)
+		return 0;
+
+	rinfo->pll.ref_clk = *xtal / 10;
+
+       	return 1;
+}
+#endif /* CONFIG_PPC_OF */
+
+static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo, char *bios_seg)
+{
+        void *bios_header;
+        void *header_ptr;
+        u16 bios_header_offset, pll_info_offset;
+        PLL_BLOCK pll;
+
+	if (bios_seg) {
+		// XXX FIXME: Use BIOS_INx accessors
+
+	        bios_header = bios_seg + 0x48L;
+       		header_ptr  = bios_header;
+        
+        	bios_header_offset = readw(header_ptr);
+	        bios_header = bios_seg + bios_header_offset;
+        	bios_header += 0x30;
+        
+        	header_ptr = bios_header;
+        	pll_info_offset = readw(header_ptr);
+        	header_ptr = bios_seg + pll_info_offset;
+        
+        	memcpy_fromio(&pll, header_ptr, 50);
+		
+        	rinfo->pll.xclk = (u32)pll.XCLK;
+        	rinfo->pll.ref_clk = (u32)pll.PCLK_ref_freq;
+        	rinfo->pll.ref_div = (u32)pll.PCLK_ref_divider;
+        	rinfo->pll.ppll_min = pll.PCLK_min_freq;
+        	rinfo->pll.ppll_max = pll.PCLK_max_freq;
+
+		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from BIOS\n",
+			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
+	} else {
+#ifdef CONFIG_PPC_OF
+		if (radeon_read_xtal_OF(rinfo)) {
+			unsigned int tmp, Nx, M, ref_div, xclk;
+
+			tmp = INPLL(M_SPLL_REF_FB_DIV);
+			ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
+
+			Nx = (tmp & 0xff00) >> 8;
+			M = (tmp & 0xff);
+			xclk = ((((2 * Nx * rinfo->pll.ref_clk) + (M)) /
+				(2 * M)));
+
+			rinfo->pll.xclk = xclk;
+			rinfo->pll.ref_div = ref_div;
+			rinfo->pll.ppll_min = 12000;
+			rinfo->pll.ppll_max = 35000;
+
+			printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from OF\n",
+				rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
+
+			return;
+		}
+#endif /* CONFIG_PPC_OF */
+		/* no BIOS or BIOS not found, use defaults */
+		switch (rinfo->chipset) {
+			case PCI_DEVICE_ID_ATI_RADEON_QW:
+			case PCI_DEVICE_ID_ATI_RADEON_QX:
+				rinfo->pll.ppll_max = 35000;
+				rinfo->pll.ppll_min = 12000;
+				rinfo->pll.xclk = 23000;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
+			case PCI_DEVICE_ID_ATI_RADEON_QL:
+			case PCI_DEVICE_ID_ATI_RADEON_QN:
+			case PCI_DEVICE_ID_ATI_RADEON_QO:
+			case PCI_DEVICE_ID_ATI_RADEON_Ql:
+			case PCI_DEVICE_ID_ATI_RADEON_BB:
+				rinfo->pll.ppll_max = 35000;
+				rinfo->pll.ppll_min = 12000;
+				rinfo->pll.xclk = 27500;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
+			case PCI_DEVICE_ID_ATI_RADEON_Id:
+			case PCI_DEVICE_ID_ATI_RADEON_Ie:
+			case PCI_DEVICE_ID_ATI_RADEON_If:
+			case PCI_DEVICE_ID_ATI_RADEON_Ig:
+				rinfo->pll.ppll_max = 35000;
+				rinfo->pll.ppll_min = 12000;
+				rinfo->pll.xclk = 25000;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
+			case PCI_DEVICE_ID_ATI_RADEON_ND:
+			case PCI_DEVICE_ID_ATI_RADEON_NE:
+			case PCI_DEVICE_ID_ATI_RADEON_NF:
+			case PCI_DEVICE_ID_ATI_RADEON_NG:
+				rinfo->pll.ppll_max = 40000;
+				rinfo->pll.ppll_min = 20000;
+				rinfo->pll.xclk = 27000;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
+			case PCI_DEVICE_ID_ATI_RADEON_QD:
+			case PCI_DEVICE_ID_ATI_RADEON_QE:
+			case PCI_DEVICE_ID_ATI_RADEON_QF:
+			case PCI_DEVICE_ID_ATI_RADEON_QG:
+			default:
+				rinfo->pll.ppll_max = 35000;
+				rinfo->pll.ppll_min = 12000;
+				rinfo->pll.xclk = 16600;
+				rinfo->pll.ref_div = 67;
+				rinfo->pll.ref_clk = 2700;
+				break;
+		}
+
+		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d defaults\n",
+			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
+	}
+}
+
+
+#if 0
+static int __devinit radeon_get_dfpinfo (struct radeonfb_info *rinfo)
+{
+	unsigned int tmp;
+	unsigned short a, b;
+
+	if (radeon_get_dfpinfo_BIOS(rinfo))
+		radeon_update_default_var(rinfo);
+
+	if (radeon_dfp_parse_EDID(rinfo))
+		radeon_update_default_var(rinfo);
+
+	if (!rinfo->got_dfpinfo) {
+		/*
+		 * it seems all else has failed now and we
+		 * resort to probing registers for our DFP info
+	         */
+		if (panel_yres) {
+			rinfo->panel_yres = panel_yres;
+		} else {
+			tmp = INREG(FP_VERT_STRETCH);
+			tmp &= 0x00fff000;
+			rinfo->panel_yres = (unsigned short)(tmp >> 0x0c) + 1;
+		}
+
+		switch (rinfo->panel_yres) {
+			case 480:
+				rinfo->panel_xres = 640;
+				break;
+			case 600:
+				rinfo->panel_xres = 800;
+				break;
+			case 768:
+#if defined(__powerpc__)
+				if (rinfo->dviDisp_type == MT_LCD)
+					rinfo->panel_xres = 1152;
+				else
+#endif
+				rinfo->panel_xres = 1024;
+				break;
+			case 1024:
+				rinfo->panel_xres = 1280;
+				break;
+			case 1050:
+				rinfo->panel_xres = 1400;
+				break;
+			case 1200:
+				rinfo->panel_xres = 1600;
+				break;
+			default:
+				printk(KERN_ERR "radeonfb: Failed to detect DFP panel size\n");
+				return 0;
+		}
+
+		printk("radeonfb: detected DFP panel size from registers: %dx%d\n",
+			rinfo->panel_xres, rinfo->panel_yres);
+
+		tmp = INREG(FP_CRTC_H_TOTAL_DISP);
+		a = (tmp & FP_CRTC_H_TOTAL_MASK) + 4;
+		b = (tmp & 0x01ff0000) >> FP_CRTC_H_DISP_SHIFT;
+		rinfo->hblank = (a - b + 1) * 8;
+
+		tmp = INREG(FP_H_SYNC_STRT_WID);
+		rinfo->hOver_plus = (unsigned short) ((tmp & FP_H_SYNC_STRT_CHAR_MASK) >>
+					FP_H_SYNC_STRT_CHAR_SHIFT) - b - 1;
+		rinfo->hOver_plus *= 8;
+		rinfo->hSync_width = (unsigned short) ((tmp & FP_H_SYNC_WID_MASK) >>
+					FP_H_SYNC_WID_SHIFT);
+		rinfo->hSync_width *= 8;
+		tmp = INREG(FP_CRTC_V_TOTAL_DISP);
+		a = (tmp & FP_CRTC_V_TOTAL_MASK) + 1;
+		b = (tmp & FP_CRTC_V_DISP_MASK) >> FP_CRTC_V_DISP_SHIFT;
+		rinfo->vblank = a - b /* + 24 */ ;
+
+		tmp = INREG(FP_V_SYNC_STRT_WID);
+		rinfo->vOver_plus = (unsigned short) (tmp & FP_V_SYNC_STRT_MASK)
+					- b + 1;
+		rinfo->vSync_width = (unsigned short) ((tmp & FP_V_SYNC_WID_MASK) >>
+					FP_V_SYNC_WID_SHIFT);
+
+		return 1;
+	}
+
+	return 1;
+}
+#endif
+
+static void radeon_engine_init (struct radeonfb_info *rinfo)
+{
+	u32 temp;
+
+	/* disable 3D engine */
+	OUTREG(RB3D_CNTL, 0);
+
+	radeon_engine_reset ();
+
+	radeon_fifo_wait (1);
+	OUTREG(RB2D_DSTCACHE_MODE, 0);
+
+	/* XXX */
+	rinfo->pitch = ((rinfo->xres_virtual * (rinfo->bpp / 8) + 0x3f)) >> 6;
+
+	radeon_fifo_wait (1);
+	temp = INREG(DEFAULT_PITCH_OFFSET);
+	OUTREG(DEFAULT_PITCH_OFFSET, ((temp & 0xc0000000) | 
+				      (rinfo->pitch << 0x16)));
+
+	radeon_fifo_wait (1);
+	OUTREGP(DP_DATATYPE, 0, ~HOST_BIG_ENDIAN_EN);
+
+	radeon_fifo_wait (1);
+	OUTREG(DEFAULT_SC_BOTTOM_RIGHT, (DEFAULT_SC_RIGHT_MAX |
+					 DEFAULT_SC_BOTTOM_MAX));
+
+	temp = radeon_get_dstbpp(rinfo->depth);
+	rinfo->dp_gui_master_cntl = ((temp << 8) | GMC_CLR_CMP_CNTL_DIS);
+	radeon_fifo_wait (1);
+	OUTREG(DP_GUI_MASTER_CNTL, (rinfo->dp_gui_master_cntl |
+				    GMC_BRUSH_SOLID_COLOR |
+				    GMC_SRC_DATATYPE_COLOR));
+
+	radeon_fifo_wait (7);
+
+	/* clear line drawing regs */
+	OUTREG(DST_LINE_START, 0);
+	OUTREG(DST_LINE_END, 0);
+
+	/* set brush color regs */
+	OUTREG(DP_BRUSH_FRGD_CLR, 0xffffffff);
+	OUTREG(DP_BRUSH_BKGD_CLR, 0x00000000);
+
+	/* set source color regs */
+	OUTREG(DP_SRC_FRGD_CLR, 0xffffffff);
+	OUTREG(DP_SRC_BKGD_CLR, 0x00000000);
+
+	/* default write mask */
+	OUTREG(DP_WRITE_MSK, 0xffffffff);
+
+	radeon_engine_idle ();
+}
+
+static int radeon_do_maximize(struct radeonfb_info *rinfo,
+                                struct fb_var_screeninfo *var,
+                                struct fb_var_screeninfo *v,
+                                int nom, int den)
+{
+        static struct {
+                int xres, yres;
+        } modes[] = {
+                {1600, 1280},
+                {1280, 1024},
+                {1024, 768},
+                {800, 600},
+                {640, 480},
+                {-1, -1}
+        };
+        int i;
+  
+        /* use highest possible virtual resolution */
+        if (v->xres_virtual == -1 && v->yres_virtual == -1) {
+                printk("radeonfb: using max available virtual resolution\n");
+                for (i=0; modes[i].xres != -1; i++) {
+                        if (modes[i].xres * nom / den * modes[i].yres <
+                            rinfo->video_ram / 2)
+                                break;
+                }
+                if (modes[i].xres == -1) {
+                        printk("radeonfb: could not find virtual resolution that fits into video memory!\n");
+                        return -EINVAL;
+                }
+                v->xres_virtual = modes[i].xres;  
+                v->yres_virtual = modes[i].yres;
+                
+                printk("radeonfb: virtual resolution set to max of %dx%d\n",
+                        v->xres_virtual, v->yres_virtual);
+        } else if (v->xres_virtual == -1) {
+                v->xres_virtual = (rinfo->video_ram * den /   
+                                (nom * v->yres_virtual * 2)) & ~15;
+        } else if (v->yres_virtual == -1) {
+                v->xres_virtual = (v->xres_virtual + 15) & ~15;
+                v->yres_virtual = rinfo->video_ram * den /
+                        (nom * v->xres_virtual *2);
+        } else {
+                if (v->xres_virtual * nom / den * v->yres_virtual >
+                        rinfo->video_ram) {
+                        return -EINVAL;
+                }
+        }
+                
+        if (v->xres_virtual * nom / den >= 8192) {
+                v->xres_virtual = 8192 * den / nom - 16;
+        }       
+        
+        if (v->xres_virtual < v->xres)
+                return -EINVAL;
+                
+        if (v->yres_virtual < v->yres)
+                return -EINVAL;
+                                
+        return 0;
+}
+
+
+static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+        struct fb_var_screeninfo v;
+        int nom, den;
+
+        memcpy (&v, var, sizeof (v));
+
+        switch (v.bits_per_pixel) {
+		case 0 ... 8:
+			v.bits_per_pixel = 8;
+			break;
+		case 9 ... 16:
+			v.bits_per_pixel = 16;
+			break;
+		case 17 ... 24:
+#if 0 /* Doesn't seem to work */
+			v.bits_per_pixel = 24;
+			break;
+#endif			
+			return -EINVAL;
+		case 25 ... 32:
+			v.bits_per_pixel = 32;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (var_to_depth(&v)) {
+                case 8:
+                        nom = den = 1;
+                        v.red.offset = v.green.offset = v.blue.offset = 0;
+                        v.red.length = v.green.length = v.blue.length = 8;
+                        v.transp.offset = v.transp.length = 0;
+                        break;
+		case 15:
+			nom = 2;
+			den = 1;
+			v.red.offset = 10;
+			v.green.offset = 5;
+			v.red.offset = 0;
+			v.red.length = v.green.length = v.blue.length = 5;
+			v.transp.offset = v.transp.length = 0;
+			break;
+                case 16:
+                        nom = 2;
+                        den = 1;
+                        v.red.offset = 11;
+                        v.green.offset = 5;
+                        v.blue.offset = 0;
+                        v.red.length = 5;
+                        v.green.length = 6;
+                        v.blue.length = 5;
+                        v.transp.offset = v.transp.length = 0;
+                        break;                          
+                case 24:
+                        nom = 4;
+                        den = 1;
+                        v.red.offset = 16;
+                        v.green.offset = 8;
+                        v.blue.offset = 0;
+                        v.red.length = v.blue.length = v.green.length = 8;
+                        v.transp.offset = v.transp.length = 0;
+                        break;
+                case 32:
+                        nom = 4;
+                        den = 1;
+                        v.red.offset = 16;
+                        v.green.offset = 8;
+                        v.blue.offset = 0;
+                        v.red.length = v.blue.length = v.green.length = 8;
+                        v.transp.offset = 24;
+                        v.transp.length = 8;
+                        break;
+                default:
+                        printk ("radeonfb: mode %dx%dx%d rejected, color depth invalid\n",
+                                var->xres, var->yres, var->bits_per_pixel);
+                        return -EINVAL;
+        }
+
+        if (radeon_do_maximize(rinfo, var, &v, nom, den) < 0)
+                return -EINVAL;  
+                
+        if (v.xoffset < 0)
+                v.xoffset = 0;
+        if (v.yoffset < 0)
+                v.yoffset = 0;
+         
+        if (v.xoffset > v.xres_virtual - v.xres)
+                v.xoffset = v.xres_virtual - v.xres - 1;
+                        
+        if (v.yoffset > v.yres_virtual - v.yres)
+                v.yoffset = v.yres_virtual - v.yres - 1;
+         
+        v.red.msb_right = v.green.msb_right = v.blue.msb_right =
+                          v.transp.offset = v.transp.length =
+                          v.transp.msb_right = 0;
+
+	if (noaccel)
+		v.accel_flags = 0;
+			
+        memcpy(var, &v, sizeof(v));
+        
+        return 0;
+}
+
+
+static int radeonfb_pan_display (struct fb_var_screeninfo *var,
+                                 struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+
+        if ((var->xoffset + var->xres > var->xres_virtual)
+	    || (var->yoffset + var->yres > var->yres_virtual))
+               return -EINVAL;
+                
+        if (rinfo->asleep)
+        	return 0;
+
+        OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
+			     * var->bits_per_pixel / 8) & ~7);
+        return 0;
+}
+
+
+static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
+                           unsigned long arg, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+	unsigned int tmp;
+	u32 value = 0;
+	int rc;
+
+	switch (cmd) {
+		/*
+		 * TODO:  set mirror accordingly for non-Mobility chipsets with 2 CRTC's
+		 */
+		case FBIO_RADEON_SET_MIRROR:
+			switch (rinfo->arch) {
+				case RADEON_R100:
+				case RADEON_RV100:
+				case RADEON_R200:
+				case RADEON_RV200:
+				case RADEON_RV250:
+				case RADEON_R300:
+					return -EINVAL;
+				default:
+					/* RADEON M6, RADEON_M7, RADEON_M9 */
+					break;
+			}
+
+			rc = get_user(value, (__u32*)arg);
+
+			if (rc)
+				return rc;
+
+			if (value & 0x01) {
+				tmp = INREG(LVDS_GEN_CNTL);
+
+				tmp |= (LVDS_ON | LVDS_BLON);
+			} else {
+				tmp = INREG(LVDS_GEN_CNTL);
+
+				tmp &= ~(LVDS_ON | LVDS_BLON);
+			}
+
+			OUTREG(LVDS_GEN_CNTL, tmp);
+
+			if (value & 0x02) {
+				tmp = INREG(CRTC_EXT_CNTL);
+				tmp |= CRTC_CRT_ON;
+
+				mirror = 1;
+			} else {
+				tmp = INREG(CRTC_EXT_CNTL);
+				tmp &= ~CRTC_CRT_ON;
+
+				mirror = 0;
+			}
+
+			OUTREG(CRTC_EXT_CNTL, tmp);
+
+			break;
+		case FBIO_RADEON_GET_MIRROR:
+			switch (rinfo->arch) {
+				case RADEON_R100:
+				case RADEON_RV100:
+				case RADEON_R200:
+				case RADEON_RV200:
+				case RADEON_RV250:
+				case RADEON_R300:
+					return -EINVAL;
+				default:
+					/* RADEON M6, RADEON_M7, RADEON_M9 */
+					break;
+			}
+
+			tmp = INREG(LVDS_GEN_CNTL);
+			if ((LVDS_ON | LVDS_BLON) & tmp)
+				value |= 0x01;
+
+			tmp = INREG(CRTC_EXT_CNTL);
+			if (CRTC_CRT_ON & tmp)
+				value |= 0x02;
+
+			return put_user(value, (__u32*)arg);
+		default:
+			return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+
+int radeonfb_blank (int blank, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        u32 val = INREG(CRTC_EXT_CNTL);
+	u32 val2 = INREG(LVDS_GEN_CNTL);
+
+	if (rinfo->asleep)
+		return 0;
+		
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (rinfo->mon1_type == MT_LCD && _machine == _MACH_Pmac) {
+		set_backlight_enable(!blank);
+		return 0;
+	}
+#endif
+                        
+        /* reset it */
+        val &= ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
+                 CRTC_VSYNC_DIS);
+	val2 &= ~(LVDS_DISPLAY_DIS);
+
+        switch (blank) {
+                case VESA_NO_BLANKING:
+                        break;
+                case VESA_VSYNC_SUSPEND:
+                        val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
+                        break;
+                case VESA_HSYNC_SUSPEND:
+                        val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
+                        break;
+                case VESA_POWERDOWN:
+                        val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | 
+                                CRTC_HSYNC_DIS);
+			val2 |= (LVDS_DISPLAY_DIS);
+                        break;
+        }
+
+	switch (rinfo->mon1_type) {
+		case MT_LCD:
+			OUTREG(LVDS_GEN_CNTL, val2);
+			break;
+		case MT_CRT:
+		default:
+		        OUTREG(CRTC_EXT_CNTL, val);
+			break;
+	}
+
+	return 0;
+}
+
+
+static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+                             unsigned blue, unsigned transp, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+	u32 pindex, vclk_cntl;
+	unsigned int i;
+	
+	if (regno > 255)
+		return 1;
+
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+	rinfo->palette[regno].red = red;
+	rinfo->palette[regno].green = green;
+	rinfo->palette[regno].blue = blue;
+
+        /* default */
+        pindex = regno;
+
+        if (!rinfo->asleep) {
+		vclk_cntl = INPLL(VCLK_ECP_CNTL);
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+
+		if (rinfo->bpp == 16) {
+			pindex = regno * 8;
+
+			if (rinfo->depth == 16 && regno > 63)
+				return 1;
+			if (rinfo->depth == 15 && regno > 31)
+				return 1;
+
+			/* For 565, the green component is mixed one order below */
+			if (rinfo->depth == 16) {
+		                OUTREG(PALETTE_INDEX, pindex>>1);
+	       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
+	                        	(green << 8) | (rinfo->palette[regno>>1].blue));
+	                	green = rinfo->palette[regno<<1].green;
+	        	}
+		}
+
+		if (rinfo->depth != 16 || regno < 32) {
+			OUTREG(PALETTE_INDEX, pindex);
+			OUTREG(PALETTE_DATA, (red << 16) | (green << 8) | blue);
+		}
+
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+	}
+ 	if (regno < 16) {
+        	switch (rinfo->depth) {
+		case 15:
+			((u16 *) (info->pseudo_palette))[regno] =
+			    (regno << 10) | (regno << 5) | regno;
+			break;
+		case 16:
+			((u16 *) (info->pseudo_palette))[regno] =
+			    (regno << 11) | (regno << 6) | regno;
+			break;
+		case 24:
+			((u32 *) (info->pseudo_palette))[regno] =
+			    (regno << 16) | (regno << 8) | regno;
+			break;
+		case 32:
+			i = (regno << 8) | regno;
+			((u32 *) (info->pseudo_palette))[regno] =
+			    (i << 16) | i;
+			break;
+		}
+        }
+	return 0;
+}
+
+
+static void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
+{
+	/* CRTC regs */
+	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
+	save->crtc_ext_cntl = INREG(CRTC_EXT_CNTL);
+	save->crtc_more_cntl = INREG(CRTC_MORE_CNTL);
+	save->dac_cntl = INREG(DAC_CNTL);
+        save->crtc_h_total_disp = INREG(CRTC_H_TOTAL_DISP);
+        save->crtc_h_sync_strt_wid = INREG(CRTC_H_SYNC_STRT_WID);
+        save->crtc_v_total_disp = INREG(CRTC_V_TOTAL_DISP);
+        save->crtc_v_sync_strt_wid = INREG(CRTC_V_SYNC_STRT_WID);
+	save->crtc_pitch = INREG(CRTC_PITCH);
+	save->surface_cntl = INREG(SURFACE_CNTL);
+
+	/* FP regs */
+	save->fp_crtc_h_total_disp = INREG(FP_CRTC_H_TOTAL_DISP);
+	save->fp_crtc_v_total_disp = INREG(FP_CRTC_V_TOTAL_DISP);
+	save->fp_gen_cntl = INREG(FP_GEN_CNTL);
+	save->fp_h_sync_strt_wid = INREG(FP_H_SYNC_STRT_WID);
+	save->fp_horz_stretch = INREG(FP_HORZ_STRETCH);
+	save->fp_v_sync_strt_wid = INREG(FP_V_SYNC_STRT_WID);
+	save->fp_vert_stretch = INREG(FP_VERT_STRETCH);
+	save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
+	save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
+	save->tmds_crc = INREG(TMDS_CRC);
+	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
+	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
+}
+
+
+static void radeon_calc_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs, unsigned long freq)
+{
+	const struct {
+		int divider;
+		int bitvalue;
+	} *post_div,
+	  post_divs[] = {
+		{ 1,  0 },
+		{ 2,  1 },
+		{ 4,  2 },
+		{ 8,  3 },
+		{ 3,  4 },
+		{ 16, 5 },
+		{ 6,  6 },
+		{ 12, 7 },
+		{ 0,  0 },
+	};
+
+	if (freq > rinfo->pll.ppll_max)
+		freq = rinfo->pll.ppll_max;
+	if (freq*12 < rinfo->pll.ppll_min)
+		freq = rinfo->pll.ppll_min / 12;
+
+
+	for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
+		rinfo->pll_output_freq = post_div->divider * freq;
+		if (rinfo->pll_output_freq >= rinfo->pll.ppll_min  &&
+		    rinfo->pll_output_freq <= rinfo->pll.ppll_max)
+			break;
+	}
+
+	/* Why do we have those in rinfo at this point ? --BenH */
+	rinfo->post_div = post_div->divider;
+	rinfo->fb_div = round_div(rinfo->pll.ref_div*rinfo->pll_output_freq,
+				  rinfo->pll.ref_clk);
+	regs->ppll_ref_div = rinfo->pll.ref_div;
+	regs->ppll_div_3 = rinfo->fb_div | (post_div->bitvalue << 16);
+
+#ifdef CONFIG_ALL_PPC
+	/* Gross hack for iBook with M7 until I find out a proper fix */
+	if (machine_is_compatible("PowerBook4,3") && rinfo->arch == RADEON_M7)
+		regs->ppll_div_3 = 0x000600ad;
+#endif /* CONFIG_ALL_PPC */
+
+	RTRACE("post div = 0x%x\n", rinfo->post_div);
+	RTRACE("fb_div = 0x%x\n", rinfo->fb_div);
+	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
+}
+
+
+int radeonfb_set_par (struct fb_info *info)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *)info->par;
+	struct fb_var_screeninfo *mode = &info->var;
+	struct radeon_regs newmode;
+	int hTotal, vTotal, hSyncStart, hSyncEnd,
+	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
+	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
+	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
+	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
+	int freq;
+        int format = 0;
+	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
+	int primary_mon = PRIMARY_MONITOR(rinfo);
+	int depth = var_to_depth(mode);
+        int accel = (mode->accel_flags & FB_ACCELF_TEXT) != 0;
+
+	rinfo->xres = mode->xres;
+	rinfo->yres = mode->yres;
+	rinfo->xres_virtual = mode->xres_virtual;
+	rinfo->yres_virtual = mode->yres_virtual;
+	rinfo->pixclock = mode->pixclock;
+
+	hSyncStart = mode->xres + mode->right_margin;
+	hSyncEnd = hSyncStart + mode->hsync_len;
+	hTotal = hSyncEnd + mode->left_margin;
+
+	vSyncStart = mode->yres + mode->lower_margin;
+	vSyncEnd = vSyncStart + mode->vsync_len;
+	vTotal = vSyncEnd + mode->upper_margin;
+	pixClock = mode->pixclock;
+
+	sync = mode->sync;
+	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+
+	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
+		if (rinfo->panel_info.xres < mode->xres)
+			rinfo->xres = mode->xres = rinfo->panel_info.xres;
+		if (rinfo->panel_info.yres < mode->yres)
+			rinfo->yres = mode->yres = rinfo->panel_info.yres;
+
+		hTotal = mode->xres + rinfo->panel_info.hblank;
+		hSyncStart = mode->xres + rinfo->panel_info.hOver_plus;
+		hSyncEnd = hSyncStart + rinfo->panel_info.hSync_width;
+
+		vTotal = mode->yres + rinfo->panel_info.vblank;
+		vSyncStart = mode->yres + rinfo->panel_info.vOver_plus;
+		vSyncEnd = vSyncStart + rinfo->panel_info.vSync_width;
+
+		h_sync_pol = !rinfo->panel_info.hAct_high;
+		v_sync_pol = !rinfo->panel_info.vAct_high;
+
+		pixClock = 100000000 / rinfo->panel_info.clock;
+	}
+	dotClock = 1000000000 / pixClock;
+	freq = dotClock / 10; /* x100 */
+
+	RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
+		hSyncStart, hSyncEnd, hTotal);
+	RTRACE("vStart = %d, vEnd = %d, vTotal = %d\n",
+		vSyncStart, vSyncEnd, vTotal);
+
+	hsync_wid = (hSyncEnd - hSyncStart) / 8;
+	vsync_wid = vSyncEnd - vSyncStart;
+	if (hsync_wid == 0)
+		hsync_wid = 1;
+	else if (hsync_wid > 0x3f)	/* max */
+		hsync_wid = 0x3f;
+
+	if (vsync_wid == 0)
+		vsync_wid = 1;
+	else if (vsync_wid > 0x1f)	/* max */
+		vsync_wid = 0x1f;
+
+	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+
+	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
+
+	format = radeon_get_dstbpp(depth);
+	bytpp = mode->bits_per_pixel >> 3;
+
+	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD))
+		hsync_fudge = hsync_fudge_fp[format-1];
+	else
+		hsync_fudge = hsync_adj_tab[format-1];
+
+	hsync_start = hSyncStart - 8 + hsync_fudge;
+
+	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
+				(format << 8);
+
+	/* Clear auto-center etc... */
+	newmode.crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
+	newmode.crtc_more_cntl &= 0xfffffff0;
+	
+	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
+		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
+		if (mirror)
+			newmode.crtc_ext_cntl |= CRTC_CRT_ON;
+
+		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
+					   CRTC_INTERLACE_EN);
+	} else {
+		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
+					CRTC_CRT_ON;
+	}
+
+	newmode.dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
+			   DAC_8BIT_EN;
+
+	newmode.crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
+				     (((mode->xres / 8) - 1) << 16));
+
+	newmode.crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
+					(hsync_wid << 16) | (h_sync_pol << 23));
+
+	newmode.crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
+				    ((mode->yres - 1) << 16);
+
+	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
+					 (vsync_wid << 16) | (v_sync_pol  << 23));
+
+	if (accel) {
+		/* We first calculate the engine pitch */
+		rinfo->pitch = ((mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8) + 0x3f)
+ 				& ~(0x3f)) >> 6;
+
+		/* Then, re-multiply it to get the CRTC pitch */
+		newmode.crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
+	} else
+		newmode.crtc_pitch = (mode->xres_virtual >> 3);
+
+	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
+
+	/*
+	 * It looks like recent chips have a problem with SURFACE_CNTL,
+	 * setting SURF_TRANSLATION_DIS completely disables the
+	 * swapper as well, so we leave it unset now.
+	 */
+	newmode.surface_cntl = 0;
+
+#if defined(__BIG_ENDIAN)
+
+	/* Setup swapping on both apertures, though we currently
+	 * only use aperture 0, enabling swapper on aperture 1
+	 * won't harm
+	 */
+	switch (mode->bits_per_pixel) {
+		case 16:
+			newmode.surface_cntl |= NONSURF_AP0_SWP_16BPP;
+			newmode.surface_cntl |= NONSURF_AP1_SWP_16BPP;
+			break;
+		case 24:	
+		case 32:
+			newmode.surface_cntl |= NONSURF_AP0_SWP_32BPP;
+			newmode.surface_cntl |= NONSURF_AP1_SWP_32BPP;
+			break;
+	}
+#endif
+
+	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
+		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
+	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
+		newmode.crtc_v_total_disp, newmode.crtc_v_sync_strt_wid);
+
+	newmode.xres = mode->xres;
+	newmode.yres = mode->yres;
+
+	rinfo->bpp = mode->bits_per_pixel;
+	rinfo->depth = depth;
+
+	RTRACE("pixclock = %lu\n", (unsigned long)pixClock);
+	RTRACE("freq = %lu\n", (unsigned long)freq);
+	radeon_calc_pll_regs(rinfo, &newmode, freq);
+
+	newmode.vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
+
+	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
+		unsigned int hRatio, vRatio;
+
+		if (mode->xres > rinfo->panel_info.xres)
+			mode->xres = rinfo->panel_info.xres;
+		if (mode->yres > rinfo->panel_info.yres)
+			mode->yres = rinfo->panel_info.yres;
+
+		newmode.fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
+					   << HORZ_PANEL_SHIFT);
+		newmode.fp_vert_stretch = ((rinfo->panel_info.yres - 1)
+					   << VERT_PANEL_SHIFT);
+
+		if (mode->xres != rinfo->panel_info.xres) {
+			hRatio = round_div(mode->xres * HORZ_STRETCH_RATIO_MAX,
+					   rinfo->panel_info.xres);
+			newmode.fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
+						   (newmode.fp_horz_stretch &
+						    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
+						     HORZ_AUTO_RATIO_INC)));
+			newmode.fp_horz_stretch |= (HORZ_STRETCH_BLEND |
+						    HORZ_STRETCH_ENABLE);
+		}
+		newmode.fp_horz_stretch &= ~HORZ_AUTO_RATIO;
+
+		if (mode->yres != rinfo->panel_info.yres) {
+			vRatio = round_div(mode->yres * VERT_STRETCH_RATIO_MAX,
+					   rinfo->panel_info.yres);
+			newmode.fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
+						   (newmode.fp_vert_stretch &
+						   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
+			newmode.fp_vert_stretch |= (VERT_STRETCH_BLEND |
+						    VERT_STRETCH_ENABLE);
+		}
+		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+
+		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
+				       ~(FP_SEL_CRTC2 |
+					 FP_RMX_HVSYNC_CONTROL_EN |
+					 FP_DFP_SYNC_SEL |
+					 FP_CRT_SYNC_SEL |
+					 FP_CRTC_LOCK_8DOT |
+					 FP_USE_SHADOW_EN |
+					 FP_CRTC_USE_SHADOW_VEND |
+					 FP_CRT_SYNC_ALT));
+
+		newmode.fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
+					FP_CRTC_DONT_SHADOW_HEND);
+
+		newmode.lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
+		newmode.lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
+		newmode.tmds_crc = rinfo->init_state.tmds_crc;
+		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
+
+		if (primary_mon == MT_LCD) {
+			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
+			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
+		} else {
+			/* DFP */
+			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
+			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
+							 ~(TMDS_PLLRST);
+			/* TMDS_PLL_EN bit is reversed on RV (and mobility) chips */
+			if (rinfo->arch == RADEON_R100 ||
+			    rinfo->arch == RADEON_R200 ||
+			    rinfo->arch == RADEON_R300 ||
+			    rinfo->arch == RADEON_R350)
+				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
+			else
+				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
+			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+		}
+
+		newmode.fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
+				(((mode->xres / 8) - 1) << 16));
+		newmode.fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
+				((mode->yres - 1) << 16);
+		newmode.fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
+				(hsync_wid << 16) | (h_sync_pol << 23));
+		newmode.fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
+				(vsync_wid << 16) | (v_sync_pol  << 23));
+	}
+
+	/* do it! */
+	if (!rinfo->asleep) {
+		radeon_write_mode (rinfo, &newmode);
+		/* (re)initialize the engine */
+		if (accel)
+			radeon_engine_init (rinfo);
+	
+	}
+	/* Update fix */
+	if (accel)
+        	info->fix.line_length = rinfo->pitch*64;
+        else
+		info->fix.line_length = mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8);
+        info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+
+#ifdef CONFIG_BOOTX_TEXT
+	/* Update debug text engine */
+	btext_update_display(rinfo->fb_base_phys, mode->xres, mode->yres,
+			     rinfo->depth, info->fix.line_length);
+#endif
+
+	return 0;
+}
+
+
+static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *mode)
+{
+	/* Workaround from XFree */
+	if (rinfo->arch < RADEON_R300) {
+	        /* A temporal workaround for the occational blanking on certain laptop panels. 
+	           This appears to related to the PLL divider registers (fail to lock?).  
+		   It occurs even when all dividers are the same with their old settings.  
+	           In this case we really don't need to fiddle with PLL registers. 
+	           By doing this we can avoid the blanking problem with some panels.
+	        */
+		if ((mode->ppll_ref_div == (INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK)) &&
+		    (mode->ppll_div_3 == (INPLL(PPLL_DIV_3) &
+		    		(PPLL_POST3_DIV_MASK | PPLL_FB3_DIV_MASK))))
+            		return;
+	}
+
+	while ((INREG(CLOCK_CNTL_INDEX) & PPLL_DIV_SEL_MASK) !=
+	       PPLL_DIV_SEL_MASK) {
+		OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, 0xffff);
+	}
+
+	OUTPLLP(PPLL_CNTL, PPLL_RESET, 0xffff);
+
+	while ((INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK) !=
+	       (mode->ppll_ref_div & PPLL_REF_DIV_MASK)) {
+		OUTPLLP(PPLL_REF_DIV, mode->ppll_ref_div, ~PPLL_REF_DIV_MASK);
+	}
+
+	while ((INPLL(PPLL_DIV_3) & PPLL_FB3_DIV_MASK) !=
+	       (mode->ppll_div_3 & PPLL_FB3_DIV_MASK)) {
+		OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_FB3_DIV_MASK);
+	}
+
+	while ((INPLL(PPLL_DIV_3) & PPLL_POST3_DIV_MASK) !=
+	       (mode->ppll_div_3 & PPLL_POST3_DIV_MASK)) {
+		OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_POST3_DIV_MASK);
+	}
+
+	OUTPLL(HTOTAL_CNTL, 0);
+
+	OUTPLLP(PPLL_CNTL, 0, ~PPLL_RESET);
+}
+
+static void radeon_write_mode (struct radeonfb_info *rinfo,
+                               struct radeon_regs *mode)
+{
+	int i;
+	int primary_mon = PRIMARY_MONITOR(rinfo);
+
+	if (nomodeset)
+		return;
+
+	radeonfb_blank(VESA_POWERDOWN, (struct fb_info *)rinfo);
+
+	if (rinfo->arch == RADEON_M6) {
+		for (i=0; i<8; i++)
+			OUTREG(common_regs_m6[i].reg, common_regs_m6[i].val);
+	} else {
+		for (i=0; i<9; i++)
+			OUTREG(common_regs[i].reg, common_regs[i].val);
+	}
+
+	OUTREG(CRTC_GEN_CNTL, mode->crtc_gen_cntl);
+	OUTREGP(CRTC_EXT_CNTL, mode->crtc_ext_cntl,
+		CRTC_HSYNC_DIS | CRTC_VSYNC_DIS | CRTC_DISPLAY_DIS);
+	OUTREG(CRTC_MORE_CNTL, mode->crtc_more_cntl);
+	OUTREGP(DAC_CNTL, mode->dac_cntl, DAC_RANGE_CNTL | DAC_BLANKING);
+	OUTREG(CRTC_H_TOTAL_DISP, mode->crtc_h_total_disp);
+	OUTREG(CRTC_H_SYNC_STRT_WID, mode->crtc_h_sync_strt_wid);
+	OUTREG(CRTC_V_TOTAL_DISP, mode->crtc_v_total_disp);
+	OUTREG(CRTC_V_SYNC_STRT_WID, mode->crtc_v_sync_strt_wid);
+	OUTREG(CRTC_OFFSET, 0);
+	OUTREG(CRTC_OFFSET_CNTL, 0);
+	OUTREG(CRTC_PITCH, mode->crtc_pitch);
+	OUTREG(SURFACE_CNTL, mode->surface_cntl);
+
+	radeon_write_pll_regs(rinfo, mode);
+
+#if 0
+	/* Those don't seem to actually exist in radeon's, despite some drivers still
+	 * apparently trying to fill them, including some ATI sample codes ...
+	 * Can someone confirm what's up ? --BenH.
+	 */
+	OUTREG(DDA_CONFIG, mode->dda_config);
+	OUTREG(DDA_ON_OFF, mode->dda_on_off);
+#endif
+
+	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
+		OUTREG(FP_CRTC_H_TOTAL_DISP, mode->fp_crtc_h_total_disp);
+		OUTREG(FP_CRTC_V_TOTAL_DISP, mode->fp_crtc_v_total_disp);
+		OUTREG(FP_H_SYNC_STRT_WID, mode->fp_h_sync_strt_wid);
+		OUTREG(FP_V_SYNC_STRT_WID, mode->fp_v_sync_strt_wid);
+		OUTREG(FP_HORZ_STRETCH, mode->fp_horz_stretch);
+		OUTREG(FP_VERT_STRETCH, mode->fp_vert_stretch);
+		OUTREG(FP_GEN_CNTL, mode->fp_gen_cntl);
+		OUTREG(TMDS_CRC, mode->tmds_crc);
+		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
+
+		if (primary_mon == MT_LCD) {
+			unsigned int tmp = INREG(LVDS_GEN_CNTL);
+
+			mode->lvds_gen_cntl &= ~LVDS_STATE_MASK;
+			mode->lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_STATE_MASK);
+
+			if ((tmp & (LVDS_ON | LVDS_BLON)) ==
+			    (mode->lvds_gen_cntl & (LVDS_ON | LVDS_BLON))) {
+				OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl);
+			} else {
+				if (mode->lvds_gen_cntl & (LVDS_ON | LVDS_BLON)) {
+					udelay(1000);
+					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl);
+				} else {
+					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl |
+					       LVDS_BLON);
+					udelay(1000);
+					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl);
+				}
+			}
+		}
+	}
+
+	radeonfb_blank(VESA_NO_BLANKING, (struct fb_info *)rinfo);
+
+	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
+	
+	return;
+}
+
+
+static struct fb_ops radeonfb_ops = {
+	.owner			= THIS_MODULE,
+	.fb_check_var		= radeonfb_check_var,
+	.fb_set_par		= radeonfb_set_par,
+	.fb_setcolreg		= radeonfb_setcolreg,
+	.fb_pan_display 	= radeonfb_pan_display,
+	.fb_blank		= radeonfb_blank,
+	.fb_ioctl		= radeonfb_ioctl,
+#if 0
+	.fb_fillrect	= radeonfb_fillrect,
+	.fb_copyarea	= radeonfb_copyarea,
+	.fb_imageblit	= radeonfb_imageblit,
+	.fb_rasterimg	= radeonfb_rasterimg,
+#else
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+#endif
+	.fb_cursor	= soft_cursor,
+};
+
+
+static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
+{
+	struct fb_info *info;
+
+	info = &rinfo->info;
+
+	info->currcon = -1;
+	info->par = rinfo;
+	info->pseudo_palette = rinfo->pseudo_palette;
+        info->flags = FBINFO_FLAG_DEFAULT;
+        info->fbops = &radeonfb_ops;
+        info->display_fg = NULL;
+        info->screen_base = (char *)rinfo->fb_base;
+
+	/* Fill fix common fields */
+	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
+        info->fix.smem_start = rinfo->fb_base_phys;
+        info->fix.smem_len = rinfo->video_ram;
+        info->fix.type = FB_TYPE_PACKED_PIXELS;
+        info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+        info->fix.xpanstep = 8;
+        info->fix.ypanstep = 1;
+        info->fix.ywrapstep = 0;
+        info->fix.type_aux = 0;
+        info->fix.mmio_start = rinfo->mmio_base_phys;
+        info->fix.mmio_len = RADEON_REGSIZE;
+	if (noaccel)
+	        info->fix.accel = FB_ACCEL_NONE;
+	else
+		info->fix.accel = FB_ACCEL_ATI_RADEON;
+
+	rinfo->depth = var_to_depth(&info->var);
+	rinfo->bpp = info->var.bits_per_pixel;
+        
+	fb_alloc_cmap(&info->cmap, 256, 0);
+
+	if (noaccel)
+		info->var.accel_flags &= ~FB_ACCELF_TEXT;
+	else
+		info->var.accel_flags |= FB_ACCELF_TEXT;
+
+        return 0;
+}
+
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+
+/* TODO: Dbl check these tables, we don't go up to full ON backlight
+ * in these, possibly because we noticed MacOS doesn't, but I'd prefer
+ * having some more official numbers from ATI
+ */
+static int backlight_conv_m6[] = {
+	0xff, 0xc0, 0xb5, 0xaa, 0x9f, 0x94, 0x89, 0x7e,
+	0x73, 0x68, 0x5d, 0x52, 0x47, 0x3c, 0x31, 0x24
+};
+static int backlight_conv_m7[] = {
+	0x00, 0x3f, 0x4a, 0x55, 0x60, 0x6b, 0x76, 0x81,
+	0x8c, 0x97, 0xa2, 0xad, 0xb8, 0xc3, 0xce, 0xd9
+};
+
+#define BACKLIGHT_LVDS_OFF
+#undef BACKLIGHT_DAC_OFF
+
+/* We turn off the LCD completely instead of just dimming the backlight.
+ * This provides some greater power saving and the display is useless
+ * without backlight anyway.
+ */
+static int radeon_set_backlight_enable(int on, int level, void *data)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
+	unsigned int lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
+	int* conv_table;
+
+	/* Pardon me for that hack... maybe some day we can figure
+	 * out in what direction backlight should work on a given
+	 * panel ?
+	 */
+	if ((rinfo->arch == RADEON_M7 || rinfo->arch == RADEON_M9)
+		&& !machine_is_compatible("PowerBook4,3"))
+		conv_table = backlight_conv_m7;
+	else
+		conv_table = backlight_conv_m6;
+
+	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
+	if (on && (level > BACKLIGHT_OFF)) {
+		lvds_gen_cntl |= LVDS_DIGON;
+		if (!lvds_gen_cntl & LVDS_ON) {
+			lvds_gen_cntl &= ~LVDS_BLON;
+			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+			(void)INREG(LVDS_GEN_CNTL);
+			mdelay(10);
+			lvds_gen_cntl |= LVDS_BLON;
+			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+		}
+		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+		lvds_gen_cntl |= (conv_table[level] <<
+				  LVDS_BL_MOD_LEVEL_SHIFT);
+		lvds_gen_cntl |= (LVDS_ON | LVDS_EN);
+		lvds_gen_cntl &= ~LVDS_DISPLAY_DIS;
+	} else {
+		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+		lvds_gen_cntl |= (conv_table[0] <<
+				  LVDS_BL_MOD_LEVEL_SHIFT);
+		lvds_gen_cntl |= LVDS_DISPLAY_DIS;
+		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+		udelay(10);
+		lvds_gen_cntl &= ~(LVDS_ON | LVDS_EN | LVDS_BLON | LVDS_DIGON);
+	}
+
+	OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+	rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+	rinfo->init_state.lvds_gen_cntl |= (lvds_gen_cntl & LVDS_STATE_MASK);
+
+	return 0;
+}
+
+
+static int radeon_set_backlight_level(int level, void *data)
+{
+	return radeon_set_backlight_enable(1, level, data);
+}
+#endif /* CONFIG_PMAC_BACKLIGHT */
+
+
+/*
+ * This reconfigure the card's internal memory map. In theory, we'd like
+ * to setup the card's memory at the same address as it's PCI bus address,
+ * and the AGP aperture right after that so that system RAM on 32 bits
+ * machines at least, is directly accessible. However, doing so would
+ * conflict with the current XFree drivers...
+ * Ultimately, I hope XFree, GATOS and ATI binary drivers will all agree
+ * on the proper way to set this up and duplicate this here. In the meantime,
+ * I put the card's memory at 0 in card space and AGP at some random high
+ * local (0xe0000000 for now) that will be changed by XFree/DRI anyway
+ */
+#ifdef CONFIG_PPC_OF
+#undef SET_MC_FB_FROM_APERTURE
+static void fixup_memory_mappings(struct radeonfb_info *rinfo)
+{
+	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl;
+	u32 save_crtc_ext_cntl;
+	u32 aper_base, aper_size;
+	u32 agp_base;
+
+	/* First, we disable display to avoid interfering */
+	if (rinfo->has_CRTC2) {
+		save_crtc2_gen_cntl = INREG(CRTC2_GEN_CNTL);
+		OUTREG(CRTC2_GEN_CNTL, save_crtc2_gen_cntl | CRTC2_DISP_REQ_EN_B);
+	}
+	save_crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
+	save_crtc_ext_cntl = INREG(CRTC_EXT_CNTL);
+	
+	OUTREG(CRTC_EXT_CNTL, save_crtc_ext_cntl | CRTC_DISPLAY_DIS);
+	OUTREG(CRTC_GEN_CNTL, save_crtc_gen_cntl | CRTC_DISP_REQ_EN_B);
+	mdelay(100);
+
+	aper_base = INREG(CONFIG_APER_0_BASE);
+	aper_size = INREG(CONFIG_APER_SIZE);
+
+#ifdef SET_MC_FB_FROM_APERTURE
+	/* Set framebuffer to be at the same address as set in PCI BAR */
+	OUTREG(MC_FB_LOCATION, 
+		((aper_base + aper_size - 1) & 0xffff0000) | (aper_base >> 16));
+	rinfo->fb_local_base = aper_base;
+#else
+	OUTREG(MC_FB_LOCATION, 0x7fff0000);
+	rinfo->fb_local_base = 0;
+#endif
+	agp_base = aper_base + aper_size;
+	if (agp_base & 0xf0000000)
+		agp_base = (aper_base | 0x0fffffff) + 1;
+
+	/* Set AGP to be just after the framebuffer on a 256Mb boundary. This
+	 * assumes the FB isn't mapped to 0xf0000000 or above, but this is
+	 * always the case on PPCs afaik.
+	 */
+#ifdef SET_MC_FB_FROM_APERTURE
+	OUTREG(MC_AGP_LOCATION, 0xffff0000 | (agp_base >> 16));
+#else
+	OUTREG(MC_AGP_LOCATION, 0xffffe000);
+#endif
+
+	/* Fixup the display base addresses & engine offsets while we
+	 * are at it as well
+	 */
+#ifdef SET_MC_FB_FROM_APERTURE
+	OUTREG(DISPLAY_BASE_ADDR, aper_base);
+	if (rinfo->has_CRTC2)
+		OUTREG(CRTC2_DISPLAY_BASE_ADDR, aper_base);
+#else
+	OUTREG(DISPLAY_BASE_ADDR, 0);
+	if (rinfo->has_CRTC2)
+		OUTREG(CRTC2_DISPLAY_BASE_ADDR, 0);
+#endif
+	mdelay(100);
+
+	/* Restore display settings */
+	OUTREG(CRTC_GEN_CNTL, save_crtc_gen_cntl);
+	OUTREG(CRTC_EXT_CNTL, save_crtc_ext_cntl);
+	if (rinfo->has_CRTC2)
+		OUTREG(CRTC2_GEN_CNTL, save_crtc2_gen_cntl);	
+
+	RTRACE("aper_base: %08x MC_FB_LOC to: %08x, MC_AGP_LOC to: %08x\n",
+		aper_base,
+		((aper_base + aper_size - 1) & 0xffff0000) | (aper_base >> 16),
+		0xffff0000 | (agp_base >> 16));
+}
+#endif /* CONFIG_PPC_OF */
+
+
+/*
+ * Sysfs
+ */
+
+static ssize_t radeon_show_one_edid(char *buf, loff_t off, size_t count, const u8 *edid)
+{
+	if (off > EDID_LENGTH)
+		return 0;
+
+	if (off + count > EDID_LENGTH)
+		count = EDID_LENGTH - off;
+
+	memcpy(buf, edid + off, count);
+
+	return count;
+}
+
+
+static ssize_t radeon_show_edid1(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+
+	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
+}
+
+
+static ssize_t radeon_show_edid2(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+
+	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
+}
+
+static struct bin_attribute edid1_attr = {
+	.attr   = {
+		.name	= "edid1",
+		.owner	= THIS_MODULE,
+		.mode	= 0444,
+	},
+	.size	= EDID_LENGTH,
+	.read	= radeon_show_edid1,
+};
+
+static struct bin_attribute edid2_attr = {
+	.attr   = {
+		.name	= "edid2",
+		.owner	= THIS_MODULE,
+		.mode	= 0444,
+	},
+	.size	= EDID_LENGTH,
+	.read	= radeon_show_edid2,
+};
+
+
+static int radeonfb_pci_register (struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
+{
+	struct radeonfb_info *rinfo;
+	u32 tmp;
+
+	RTRACE("radeonfb_pci_register BEGIN\n");
+	
+	/*
+	 * The driver acknowledges owning secondary devices but they are handled
+	 * by primary
+	 */
+	switch (ent->driver_data) {
+	case RADEON_R200_SEC:
+	case RADEON_RV250_SEC:
+	case RADEON_R300_SEC:
+	case RADEON_R350_SEC:
+	case RADEON_M9_SEC:
+		return 0;
+	default:
+		break;
+	}
+
+	/* Enable device in PCI config */
+	if (pci_enable_device(pdev) != 0) {
+		printk(KERN_ERR "radeonfb: Cannot enable PCI device\n");
+		return -ENODEV;
+	}
+
+	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);
+	if (!rinfo) {
+		printk (KERN_ERR "radeonfb: could not allocate memory\n");
+		return -ENODEV;
+	}
+
+	memset (rinfo, 0, sizeof (struct radeonfb_info));
+	rinfo->pdev = pdev;
+	
+	strcpy(rinfo->name, "ATI Radeon XX ");
+	rinfo->name[11] = ent->device >> 8;
+	rinfo->name[12] = ent->device & 0xFF;
+	rinfo->arch = ent->driver_data;
+		
+	/* range check to make sure */
+	if (ent->driver_data < (sizeof(radeon_family)/sizeof(char *)))
+	    strncat(rinfo->name, radeon_family[ent->driver_data], sizeof(rinfo->name));	
+
+	/* Set base addrs */
+	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
+	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
+
+	/* request the mem regions */
+	if (!request_mem_region (rinfo->fb_base_phys,
+				 pci_resource_len(pdev, 0), "radeonfb")) {
+		printk (KERN_ERR "radeonfb: cannot reserve FB region\n");
+		goto free_rinfo;
+	}
+
+	if (!request_mem_region (rinfo->mmio_base_phys,
+				 pci_resource_len(pdev, 2), "radeonfb")) {
+		printk (KERN_ERR "radeonfb: cannot reserve MMIO region\n");
+		goto release_fb;
+	}
+
+	/* map the regions */
+	rinfo->mmio_base = (unsigned long) ioremap (rinfo->mmio_base_phys, RADEON_REGSIZE);
+	if (!rinfo->mmio_base) {
+		printk (KERN_ERR "radeonfb: cannot map MMIO\n");
+		goto release_mmio;
+	}
+
+	rinfo->chipset = pdev->device;
+
+	/* fill some arch-specific flags, could be done via a separate
+	 * table though
+	 */
+	switch (rinfo->arch) {
+	case RADEON_R100:
+	       	rinfo->has_CRTC2 = 0;
+		break;
+	case RADEON_M6:
+	case RADEON_M7:
+	case RADEON_M9:
+		rinfo->is_mobility = 1;
+		/* fall through */
+	default:
+	       	/* all the rest have it */
+	       	rinfo->has_CRTC2 = 1;
+	       	break;
+	}
+
+	/* On PPC, the firmware sets up a memory mapping that tends
+	 * to cause lockups when enabling the engine. We reconfigure
+	 * the card internal memory mappings properly
+	 */
+#ifdef CONFIG_PPC_OF
+	fixup_memory_mappings(rinfo);
+#else	
+	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
+#endif /* CONFIG_PPC_OF */
+
+	/* framebuffer size */
+	tmp = INREG(CONFIG_MEMSIZE);
+
+	/* mem size is bits [28:0], mask off the rest */
+	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
+
+	/* ram type */
+	tmp = INREG(MEM_SDRAM_MODE_REG);
+	switch ((MEM_CFG_TYPE & tmp) >> 30) {
+       	case 0:
+       		/* SDR SGRAM (2:1) */
+       		strcpy(rinfo->ram_type, "SDR SGRAM");
+       		rinfo->ram.ml = 4;
+       		rinfo->ram.mb = 4;
+       		rinfo->ram.trcd = 1;
+       		rinfo->ram.trp = 2;
+       		rinfo->ram.twr = 1;
+       		rinfo->ram.cl = 2;
+       		rinfo->ram.loop_latency = 16;
+       		rinfo->ram.rloop = 16;
+       		break;
+       	case 1:
+       		/* DDR SGRAM */
+       		strcpy(rinfo->ram_type, "DDR SGRAM");
+       		rinfo->ram.ml = 4;
+       		rinfo->ram.mb = 4;
+       		rinfo->ram.trcd = 3;
+       		rinfo->ram.trp = 3;
+       		rinfo->ram.twr = 2;
+       		rinfo->ram.cl = 3;
+       		rinfo->ram.tr2w = 1;
+       		rinfo->ram.loop_latency = 16;
+       		rinfo->ram.rloop = 16;
+		break;
+       	default:
+       		/* 64-bit SDR SGRAM */
+       		strcpy(rinfo->ram_type, "SDR SGRAM 64");
+       		rinfo->ram.ml = 4;
+       		rinfo->ram.mb = 8;
+       		rinfo->ram.trcd = 3;
+       		rinfo->ram.trp = 3;
+       		rinfo->ram.twr = 1;
+       		rinfo->ram.cl = 3;
+       		rinfo->ram.tr2w = 1;
+       		rinfo->ram.loop_latency = 17;
+       		rinfo->ram.rloop = 17;
+		break;
+	}
+
+	/*
+	 * Hack to get around some busted production M6's
+	 * reporting no ram
+	 */
+	if (rinfo->video_ram == 0) {
+		switch (pdev->device) {
+	       	case PCI_DEVICE_ID_ATI_RADEON_LY:
+	       	case PCI_DEVICE_ID_ATI_RADEON_LZ:
+	       		rinfo->video_ram = 8192 * 1024;
+	       		break;
+	       	default:
+	       		break;
+		}
+	}
+
+	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
+
+	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys, rinfo->video_ram);
+	if (!rinfo->fb_base) {
+		printk (KERN_ERR "radeonfb: cannot map FB\n");
+		goto unmap_rom;
+	}
+
+	/*
+	 * Map the BIOS ROM if any and retreive PLL parameters from
+	 * either BIOS or Open Firmware
+	 */
+	rinfo->bios_seg = radeon_map_ROM(rinfo, pdev);
+	radeon_get_pllinfo(rinfo, rinfo->bios_seg);
+
+#ifdef CONFIG_FB_RADEON_I2C
+	/* Register I2C bus */
+	radeon_create_i2c_busses(rinfo);
+#endif
+
+	/* Probe screen types */
+	radeon_probe_screens(rinfo, monitor_layout, ignore_edid);
+
+	/* Build mode list, check out panel native model */
+	radeon_check_modes(rinfo, mode_option);
+
+	/* Register some sysfs stuff (should be done better) */
+	if (rinfo->mon1_EDID)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
+	if (rinfo->mon2_EDID)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+
+	/* save current mode regs before we switch into the new one
+	 * so we can restore this upon __exit
+	 */
+	radeon_save_state (rinfo, &rinfo->init_state);
+
+	if (!noaccel) {
+		/* initialize the engine */
+		radeon_engine_init (rinfo);
+	}
+
+	/* set all the vital stuff */
+	radeon_set_fbinfo (rinfo);
+
+	pci_set_drvdata(pdev, rinfo);
+	rinfo->next = board_list;
+	board_list = rinfo;
+
+	/* Enable PM on mobility chips */
+	if (rinfo->is_mobility)
+		radeon_pm_enable_dynamic_mode(rinfo);
+
+	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
+		goto unmap_fb;
+	}
+
+#ifdef CONFIG_MTRR
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys,
+						 rinfo->video_ram,
+						 MTRR_TYPE_WRCOMB, 1);
+#endif
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (rinfo->mon1_type == MT_LCD)
+		register_backlight_controller(&radeon_backlight_controller,
+					      rinfo, "ati");
+#endif
+
+	printk ("radeonfb: %s %s %ld MB\n", rinfo->name, rinfo->ram_type,
+		(rinfo->video_ram/(1024*1024)));
+
+	if (rinfo->bios_seg)
+		radeon_unmap_ROM(rinfo, pdev);
+	RTRACE("radeonfb_pci_register END\n");
+
+	return 0;
+unmap_fb:
+	iounmap ((void*)rinfo->fb_base);
+unmap_rom:	
+	if (rinfo->mon1_EDID)
+	    kfree(rinfo->mon1_EDID);
+	if (rinfo->mon2_EDID)
+	    kfree(rinfo->mon2_EDID);
+	if (rinfo->mon1_modedb)
+		fb_destroy_modedb(rinfo->mon1_modedb);
+	radeon_delete_i2c_busses(rinfo);
+	if (rinfo->bios_seg)
+		radeon_unmap_ROM(rinfo, pdev);
+	iounmap ((void*)rinfo->mmio_base);
+release_mmio:
+	release_mem_region (rinfo->mmio_base_phys,
+			    pci_resource_len(pdev, 2));
+release_fb:	
+	release_mem_region (rinfo->fb_base_phys,
+			    pci_resource_len(pdev, 0));
+free_rinfo:	
+	kfree (rinfo);
+	return -ENODEV;
+}
+
+
+
+static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+{
+        struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+ 
+        if (!rinfo)
+                return;
+ 
+	/* restore original state
+	 * 
+	 * Doesn't quite work yet, possibly because of the PPC hacking
+	 * I do on startup, disable for now. --BenH
+	 */
+        radeon_write_mode (rinfo, &rinfo->init_state);
+ 
+#ifdef CONFIG_MTRR
+	if (rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
+        unregister_framebuffer ((struct fb_info *) rinfo);
+
+        iounmap ((void*)rinfo->mmio_base);
+        iounmap ((void*)rinfo->fb_base);
+ 
+	release_mem_region (rinfo->mmio_base_phys,
+			    pci_resource_len(pdev, 2));
+	release_mem_region (rinfo->fb_base_phys,
+			    pci_resource_len(pdev, 0));
+
+	if (rinfo->mon1_EDID)
+		kfree(rinfo->mon1_EDID);
+	if (rinfo->mon2_EDID)
+		kfree(rinfo->mon2_EDID);
+	if (rinfo->mon1_modedb)
+		fb_destroy_modedb(rinfo->mon1_modedb);
+	radeon_delete_i2c_busses(rinfo);
+        
+        kfree (rinfo);
+}
+
+
+static struct pci_driver radeonfb_driver = {
+	.name		= "radeonfb",
+	.id_table	= radeonfb_pci_table,
+	.probe		= radeonfb_pci_register,
+	.remove		= __devexit_p(radeonfb_pci_unregister),
+};
+
+
+int __init radeonfb_init (void)
+{
+	return pci_module_init (&radeonfb_driver);
+}
+
+
+void __exit radeonfb_exit (void)
+{
+	pci_unregister_driver (&radeonfb_driver);
+}
+
+#ifdef MODULE
+module_init(radeonfb_init);
+module_exit(radeonfb_exit);
+#endif
+
+MODULE_AUTHOR("Ani Joshi");
+MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
+MODULE_LICENSE("GPL");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
+module_param(nomodeset, bool, 0);
+MODULE_PARM_DESC(nomodeset, "bool: disable actual setting of video mode");
+module_param(mirror, bool, 0);
+MODULE_PARM_DESC(mirror, "bool: mirror the display to both monitors");
+module_param(force_dfp, bool, 0);
+MODULE_PARM_DESC(force_dfp, "bool: force display to dfp");
+module_param(ignore_edid, bool, 0);
+MODULE_PARM_DESC(ignore_edid, "bool: Ignore EDID data when doing DDC probe");
+module_param(monitor_layout, charp, 0);
+MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
+#endif
+module_param(panel_yres, int, 0);
+MODULE_PARM_DESC(force_dfp, "int: set panel yres");
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
diff -urN linux-2.5-mesa/drivers/video/aty/radeon_i2c.c linuxppc-2.5-benh/drivers/video/aty/radeon_i2c.c
--- linux-2.5-mesa/drivers/video/aty/radeon_i2c.c	Thu Jan 01 01:00:00 1970
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_i2c.c	Sun Sep 07 17:25:50 2003
@@ -0,0 +1,245 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+#include <video/radeon.h>
+#include "radeonfb.h"
+#include "../edid.h"
+
+#define RADEON_DDC 	0x50
+
+static void radeon_gpio_setscl(void* data, int state)
+{
+	struct radeon_i2c_chan 	*chan = data;
+	struct radeonfb_info	*rinfo = chan->rinfo;
+	u32			val;
+	
+	val = INREG(chan->ddc_reg) & ~(VGA_DDC_CLK_OUT_EN);
+	if (!state)
+		val |= VGA_DDC_CLK_OUT_EN;
+
+	OUTREG(chan->ddc_reg, val);
+}
+
+static void radeon_gpio_setsda(void* data, int state)
+{
+	struct radeon_i2c_chan 	*chan = data;
+	struct radeonfb_info	*rinfo = chan->rinfo;
+	u32			val;
+	
+	val = INREG(chan->ddc_reg) & ~(VGA_DDC_DATA_OUT_EN);
+	if (!state)
+		val |= VGA_DDC_DATA_OUT_EN;
+
+	OUTREG(chan->ddc_reg, val);
+}
+
+static int radeon_gpio_getscl(void* data)
+{
+	struct radeon_i2c_chan 	*chan = data;
+	struct radeonfb_info	*rinfo = chan->rinfo;
+	u32			val;
+	
+	val = INREG(chan->ddc_reg);
+
+	return (val & VGA_DDC_CLK_INPUT) ? 1 : 0;
+}
+
+static int radeon_gpio_getsda(void* data)
+{
+	struct radeon_i2c_chan 	*chan = data;
+	struct radeonfb_info	*rinfo = chan->rinfo;
+	u32			val;
+	
+	val = INREG(chan->ddc_reg);
+
+	return (val & VGA_DDC_DATA_INPUT) ? 1 : 0;
+}
+
+static int radeon_setup_i2c_bus(struct radeon_i2c_chan *chan, const char *name)
+{
+	int rc;
+
+	strcpy(chan->adapter.name, name);
+	chan->adapter.owner		= THIS_MODULE;
+	chan->adapter.id		= I2C_ALGO_ATI;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
+	chan->algo.setsda		= radeon_gpio_setsda;
+	chan->algo.setscl		= radeon_gpio_setscl;
+	chan->algo.getsda		= radeon_gpio_getsda;
+	chan->algo.getscl		= radeon_gpio_getscl;
+	chan->algo.udelay		= 40;
+	chan->algo.timeout		= 20;
+	chan->algo.data 		= chan;	
+	
+	i2c_set_adapdata(&chan->adapter, chan);
+	
+	/* Raise SCL and SDA */
+	radeon_gpio_setsda(chan, 1);
+	radeon_gpio_setscl(chan, 1);
+	udelay(20);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+	if (rc == 0)
+		dev_dbg(&chan->rinfo->pdev->dev, "I2C bus %s registered.\n", name);
+	else
+		dev_warn(&chan->rinfo->pdev->dev, "Failed to register I2C bus %s.\n", name);
+	return rc;
+}
+
+void radeon_create_i2c_busses(struct radeonfb_info *rinfo)
+{
+	rinfo->i2c[0].rinfo	= rinfo;
+	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
+	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");
+
+	rinfo->i2c[1].rinfo	= rinfo;
+	rinfo->i2c[1].ddc_reg	= GPIO_DVI_DDC;
+	radeon_setup_i2c_bus(&rinfo->i2c[1], "dvi");
+
+	rinfo->i2c[2].rinfo	= rinfo;
+	rinfo->i2c[2].ddc_reg	= GPIO_VGA_DDC;
+	radeon_setup_i2c_bus(&rinfo->i2c[2], "vga");
+
+	rinfo->i2c[3].rinfo	= rinfo;
+	rinfo->i2c[3].ddc_reg	= GPIO_CRT2_DDC;
+	radeon_setup_i2c_bus(&rinfo->i2c[3], "crt2");
+}
+
+void radeon_delete_i2c_busses(struct radeonfb_info *rinfo)
+{
+	if (rinfo->i2c[0].rinfo)
+		i2c_bit_del_bus(&rinfo->i2c[0].adapter);
+	rinfo->i2c[0].rinfo = NULL;
+
+	if (rinfo->i2c[1].rinfo)
+		i2c_bit_del_bus(&rinfo->i2c[1].adapter);
+	rinfo->i2c[1].rinfo = NULL;
+
+	if (rinfo->i2c[2].rinfo)
+		i2c_bit_del_bus(&rinfo->i2c[2].adapter);
+	rinfo->i2c[2].rinfo = NULL;
+
+	if (rinfo->i2c[3].rinfo)
+		i2c_bit_del_bus(&rinfo->i2c[3].adapter);
+	rinfo->i2c[3].rinfo = NULL;
+}
+
+
+static u8 *radeon_do_probe_i2c_edid(struct radeon_i2c_chan *chan)
+{
+	u8 start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= RADEON_DDC,
+			.len	= 1,
+			.buf	= &start,
+		}, {
+			.addr	= RADEON_DDC,
+			.flags	= I2C_M_RD,
+			.len	= EDID_LENGTH,
+		},
+	};
+	u8 *buf;
+
+	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(&chan->rinfo->pdev->dev, "Out of memory!\n");
+		return NULL;
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
+		return buf;
+	dev_dbg(&chan->rinfo->pdev->dev, "Unable to read EDID block.\n");
+	kfree(buf);
+	return NULL;
+}
+
+
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
+{
+	u32 reg = rinfo->i2c[conn-1].ddc_reg;
+	u8 *edid = NULL;
+	int i, j;
+
+	OUTREG(reg, INREG(reg) & 
+			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
+
+	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
+	for (i = 0; i < 3; i++) {
+		/* For some old monitors we need the
+		 * following process to initialize/stop DDC
+		 */
+		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
+		wait_ms(13);
+
+		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
+		for (j = 0; j < 5; j++) {
+			wait_ms(10);
+			if (INREG(reg) & VGA_DDC_CLK_INPUT)
+				break;
+		}
+		if (j == 5)
+			continue;
+
+		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
+		wait_ms(15);
+		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
+		wait_ms(15);
+		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
+		wait_ms(15);
+
+		/* Do the real work */
+		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
+
+		OUTREG(reg, INREG(reg) | 
+				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
+		wait_ms(15);
+		
+		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
+		for (j = 0; j < 10; j++) {
+			wait_ms(10);
+			if (INREG(reg) & VGA_DDC_CLK_INPUT)
+				break;
+		}
+
+		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
+		wait_ms(15);
+		OUTREG(reg, INREG(reg) |
+				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
+		if (edid)
+			break;
+	}
+	if (out_edid)
+		*out_edid = edid;
+	if (!edid) {
+		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
+		return MT_NONE;
+	}
+	if (edid[0x14] & 0x80) {
+		if (rinfo->is_mobility && conn == ddc_dvi &&
+		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
+			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
+			return MT_LCD;
+		} else {
+			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
+			return MT_DFP;
+		}
+	}
+       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
+	return MT_CRT;
+}
+
diff -urN linux-2.5-mesa/drivers/video/aty/radeon_monitor.c linuxppc-2.5-benh/drivers/video/aty/radeon_monitor.c
--- linux-2.5-mesa/drivers/video/aty/radeon_monitor.c	Thu Jan 01 01:00:00 1970
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_monitor.c	Sun Sep 07 17:25:25 2003
@@ -0,0 +1,677 @@
+#include "radeonfb.h"
+#include "../edid.h"
+
+#ifdef CONFIG_PPC_OF
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#endif /* CONFIG_PPC_OF */
+
+static struct fb_var_screeninfo radeonfb_default_var = {
+        640, 480, 640, 480, 0, 0, 8, 0,
+        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
+        0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
+        0, FB_VMODE_NONINTERLACED
+};
+
+static char *radeon_get_mon_name(int type)
+{
+	char *pret = NULL;
+
+	switch (type) {
+		case MT_NONE:
+			pret = "no";
+			break;
+		case MT_CRT:
+			pret = "CRT";
+			break;
+		case MT_DFP:
+			pret = "DFP";
+			break;
+		case MT_LCD:
+			pret = "LCD";
+			break;
+		case MT_CTV:
+			pret = "CTV";
+			break;
+		case MT_STV:
+			pret = "STV";
+			break;
+	}
+
+	return pret;
+}
+
+
+#ifdef CONFIG_PPC_OF
+/*
+ * Try to find monitor informations & EDID data out of the Open Firmware
+ * device-tree. This also contains some "hacks" to work around a few machine
+ * models with broken OF probing by hard-coding known EDIDs for some Mac
+ * laptops internal LVDS panel.
+ */
+static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID)
+{
+        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID2",  NULL };
+	u8 *pedid = NULL;
+	u8 *pmt = NULL;
+        int i, mt;  
+	
+	pmt = (u8 *)get_property(dp, "display-type", NULL);
+	if (!pmt)
+		return MT_NONE;
+	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP"))
+		mt = MT_DFP;
+	else if (!strcmp(pmt, "CRT"))
+		mt = MT_CRT;
+	else if (strcmp(pmt, "NONE")) {
+		printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n", pmt);
+		return MT_NONE;
+	}
+	for (i = 0; propnames[i] != NULL; ++i) {
+		pedid = (u8 *)get_property(dp, propnames[i], NULL);
+		if (pedid != NULL) {
+			u8 *tmp = (u8 *)kmalloc(EDID_LENGTH, GFP_KERNEL);
+			if (tmp)
+				return mt;
+			memcpy(tmp, pedid, EDID_LENGTH);
+			*out_EDID = tmp;
+			break;
+		}
+	}
+	return mt;
+}
+
+static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no, u8 **out_EDID)
+{
+        struct device_node *dp;
+
+        dp = pci_device_to_OF_node(rinfo->pdev);
+        while (dp == NULL)
+		return MT_NONE;
+
+	if (rinfo->has_CRTC2) {
+		char *pname;
+		int len, second = 0;
+
+		dp = dp->child;
+		do {
+			if (!dp)
+				return MT_NONE;
+			pname = (char *)get_property(dp, "name", NULL);
+			if (!pname)
+				return MT_NONE;
+			len = strlen(pname);
+			if (pname[len-1] == 'A' && head_no == 0) {
+				int mt = radeon_parse_montype_prop(dp, out_EDID);
+				/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
+				 * what OF does when booting with lid closed
+				 */
+				if (mt == MT_DFP && rinfo->is_mobility)
+					mt = MT_LCD;
+			} else if (pname[len-1] == 'B' && head_no == 1)
+				return radeon_parse_montype_prop(dp, out_EDID);
+			second = 1;
+			dp = dp->sibling;
+		} while(!second);
+	} else {
+		if (head_no > 0)
+			return MT_NONE;
+		return radeon_parse_montype_prop(dp, out_EDID);
+	}
+        return MT_NONE;
+}
+#endif /* CONFIG_PPC_OF */
+
+
+static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
+{
+	unsigned long tmp, tmp0;
+	char stmp[30];
+	int i;
+
+	if (!rinfo->bios_seg)
+		return 0;
+
+	if (!(tmp = BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
+		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n");
+		return 0;
+	}
+
+	for(i=0; i<24; i++)
+		stmp[i] = BIOS_IN8(tmp+i+1);
+	stmp[24] = 0;
+	printk("radeonfb: panel ID string: %s\n", stmp);
+	rinfo->panel_info.xres = BIOS_IN16(tmp + 25);
+	rinfo->panel_info.yres = BIOS_IN16(tmp + 27);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+		rinfo->panel_info.xres, rinfo->panel_info.yres);
+
+	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp + 44);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay < 0)
+		rinfo->panel_info.pwr_delay = 2000;
+
+	/*
+	 * Some panels only work properly with some divider combinations
+	 */
+	rinfo->panel_info.ref_divider = BIOS_IN16(tmp + 46);
+	rinfo->panel_info.post_divider = BIOS_IN8(tmp + 48);
+	rinfo->panel_info.fbk_divider = BIOS_IN16(tmp + 49);
+	if (rinfo->panel_info.ref_divider != 0 &&
+	    rinfo->panel_info.fbk_divider > 3) {
+		rinfo->panel_info.use_bios_dividers = 1;
+		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
+	}
+	for(i=0; i<20; i++) {
+		tmp0 = BIOS_IN16(tmp+64+i*2);
+		if (tmp0 == 0)
+			break;
+		if ((BIOS_IN16(tmp0) == rinfo->panel_info.xres) &&
+		    (BIOS_IN16(tmp0+2) == rinfo->panel_info.yres)) {
+			rinfo->panel_info.hblank = (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) * 8;
+			rinfo->panel_info.hOver_plus = ((BIOS_IN16(tmp0+21) -
+							 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
+			rinfo->panel_info.hSync_width = BIOS_IN8(tmp0+23) * 8;
+			rinfo->panel_info.vblank = BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
+			rinfo->panel_info.vOver_plus = (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_IN16(tmp0+26);
+			rinfo->panel_info.vSync_width = (BIOS_IN16(tmp0+28) & 0xf800) >> 11;
+			rinfo->panel_info.clock = BIOS_IN16(tmp0+9);
+			/* Assume high active syncs for now until ATI tells me more... maybe we
+			 * can probe register values here ?
+			 */
+			rinfo->panel_info.hAct_high = 1;
+			rinfo->panel_info.vAct_high = 1;
+			/* Mark panel infos valid */
+			rinfo->panel_info.valid = 1;
+
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Probe physical connection of a CRT. This code comes from XFree
+ * as well and currently is only implemented for the CRT DAC, the
+ * code for the TVDAC is commented out in XFree as "non working"
+ */
+static int __devinit radeon_crt_is_connected(struct radeonfb_info *rinfo, int is_crt_dac)
+{
+    int	          connected = 0;
+
+    /* the monitor either wasn't connected or it is a non-DDC CRT.
+     * try to probe it
+     */
+    if(is_crt_dac) {
+	unsigned long ulOrigVCLK_ECP_CNTL;
+	unsigned long ulOrigDAC_CNTL;
+	unsigned long ulOrigDAC_EXT_CNTL;
+	unsigned long ulOrigCRTC_EXT_CNTL;
+	unsigned long ulData;
+	unsigned long ulMask;
+
+	ulOrigVCLK_ECP_CNTL = INPLL(VCLK_ECP_CNTL);
+
+	ulData              = ulOrigVCLK_ECP_CNTL;
+	ulData             &= ~(PIXCLK_ALWAYS_ONb
+				| PIXCLK_DAC_ALWAYS_ONb);
+	ulMask              = ~(PIXCLK_ALWAYS_ONb
+				| PIXCLK_DAC_ALWAYS_ONb);
+	OUTPLLP(VCLK_ECP_CNTL, ulData, ulMask);
+
+	ulOrigCRTC_EXT_CNTL = INREG(CRTC_EXT_CNTL);
+	ulData              = ulOrigCRTC_EXT_CNTL;
+	ulData             |= CRTC_CRT_ON;
+	OUTREG(CRTC_EXT_CNTL, ulData);
+   
+	ulOrigDAC_EXT_CNTL = INREG(DAC_EXT_CNTL);
+	ulData             = ulOrigDAC_EXT_CNTL;
+	ulData            &= ~DAC_FORCE_DATA_MASK;
+	ulData            |=  (DAC_FORCE_BLANK_OFF_EN
+			       |DAC_FORCE_DATA_EN
+			       |DAC_FORCE_DATA_SEL_MASK);
+	if ((rinfo->arch == RADEON_RV250) ||
+	    (rinfo->arch == RADEON_RV280))
+	    ulData |= (0x01b6 << DAC_FORCE_DATA_SHIFT);
+	else
+	    ulData |= (0x01ac << DAC_FORCE_DATA_SHIFT);
+
+	OUTREG(DAC_EXT_CNTL, ulData);
+
+	ulOrigDAC_CNTL     = INREG(DAC_CNTL);
+	ulData             = ulOrigDAC_CNTL;
+	ulData            |= DAC_CMP_EN;
+	ulData            &= ~(DAC_RANGE_CNTL_MASK
+			       | DAC_PDWN);
+	ulData            |= 0x2;
+	OUTREG(DAC_CNTL, ulData);
+
+	mdelay(1);
+
+	ulData     = INREG(DAC_CNTL);
+	connected =  (DAC_CMP_OUTPUT & ulData) ? 1 : 0;
+  
+	ulData    = ulOrigVCLK_ECP_CNTL;
+	ulMask    = 0xFFFFFFFFL;
+	OUTPLLP(VCLK_ECP_CNTL, ulData, ulMask);
+
+	OUTREG(DAC_CNTL,      ulOrigDAC_CNTL     );
+	OUTREG(DAC_EXT_CNTL,  ulOrigDAC_EXT_CNTL );
+	OUTREG(CRTC_EXT_CNTL, ulOrigCRTC_EXT_CNTL);
+    }
+
+    return connected ? MT_CRT : MT_NONE;
+}
+
+/*
+ * Parse the "monitor_layout" string if any. This code is mostly
+ * copied from XFree's radeon driver
+ */
+static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo, const char *monitor_layout)
+{
+	char s1[5], s2[5];
+	int i = 0, second = 0;
+	const char *s;
+
+	if (!monitor_layout)
+		return 0;
+
+	s = monitor_layout;
+	do {
+		switch(*s) {
+		case ',':
+			s1[i] = '\0';
+			i = 0;
+			second = 1;
+			break;
+		case ' ':
+		case '\0':
+			break;
+		default:
+			if (i > 4)
+				break;
+			if (second)
+				s2[i] = *s;
+			else
+				s1[i] = *s;
+			i++;
+		}
+	} while (*s++);
+	if (second)
+		s2[i] = 0;
+	else {
+		s1[i] = 0;
+		s2[0] = 0;
+	}
+	if (strcmp(s1, "CRT") == 0)
+		rinfo->mon1_type = MT_CRT;
+	else if (strcmp(s1, "TMDS") == 0)
+		rinfo->mon1_type = MT_DFP;
+	else if (strcmp(s1, "LVDS") == 0)
+		rinfo->mon1_type = MT_LCD;
+
+	if (strcmp(s2, "CRT") == 0)
+		rinfo->mon2_type = MT_CRT;
+	else if (strcmp(s2, "TMDS") == 0)
+		rinfo->mon2_type = MT_DFP;
+	else if (strcmp(s2, "LVDS") == 0)
+		rinfo->mon2_type = MT_LCD;
+
+	return 1;
+}
+
+/*
+ * Probe display on both primary and secondary card's connector (if any)
+ * by various available techniques (i2c, OF device tree, BIOS, ...) and
+ * try to retreive EDID. The algorithm here comes from XFree's radeon
+ * driver
+ */
+void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
+				    const char *monitor_layout, int ignore_edid)
+{
+	int ddc_crt2_used = 0;
+	int tmp, i;
+
+	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
+
+		/*
+		 * If user specified a monitor_layout option, use it instead
+		 * of auto-detecting. Maybe we should only use this argument
+		 * on the first radeon card probed or provide a way to specify
+		 * a layout for each card ?
+		 */
+
+		RTRACE("Using specified monitor layout: %s", monitor_layout);
+#ifdef CONFIG_FB_RADEON_I2C
+		if (!ignore_edid) {
+			if (rinfo->mon1_type != MT_NONE)
+				if (!radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID)) {
+					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);
+					ddc_crt2_used = 1;
+				}
+			if (rinfo->mon2_type != MT_NONE)
+				if (!radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon2_EDID) &&
+				    !ddc_crt2_used)
+					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon2_EDID);
+		}
+#endif /* CONFIG_FB_RADEON_I2C */
+		if (rinfo->mon1_type == MT_NONE) {
+			if (rinfo->mon2_type != MT_NONE) {
+				rinfo->mon1_type = rinfo->mon2_type;
+				rinfo->mon1_EDID = rinfo->mon2_EDID;
+			} else {
+				rinfo->mon1_type = MT_CRT;
+				printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first port\n");
+			}
+			rinfo->mon2_type = MT_NONE;
+			rinfo->mon2_EDID = NULL;
+		}
+	} else {
+
+		/*
+		 * Auto-detecting display type (well... trying to ...)
+		 */
+		
+		RTRACE("Starting monitor auto detection...\n");
+
+		/*
+		 * Old single head cards
+		 */
+		if (!rinfo->has_CRTC2) {
+#ifdef CONFIG_FB_RADEON_I2C
+			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID);
+			if (rinfo->mon1_type == MT_NONE)
+				rinfo->mon1_type =
+					radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon1_EDID);
+			if (rinfo->mon1_type == MT_NONE)
+				rinfo->mon1_type =
+					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);	
+#endif /* CONFIG_FB_RADEON_I2C */
+#ifdef CONFIG_PPC_OF
+			if (rinfo->mon1_type == MT_NONE)
+				rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0, &rinfo->mon1_EDID);
+#endif /* CONFIG_PPC_OF */
+			if (rinfo->mon1_type == MT_NONE)
+				rinfo->mon1_type = MT_CRT;
+			goto bail;
+		}
+
+		/*
+		 * Check for cards with reversed DACs or TMDS controllers using BIOS
+		 */
+		if (rinfo->bios_seg &&
+		    (tmp = BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
+			for (i = 1; i < 4; i++) {
+				unsigned int tmp0;
+
+				if (!BIOS_IN8(tmp + i*2) && i > 1)
+					break;
+				tmp0 = BIOS_IN16(tmp + i*2);
+				if ((!(tmp0 & 0x01)) && (((tmp0 >> 8) & 0x0f) == ddc_dvi)) {
+					rinfo->reversed_DAC = 1;
+					printk(KERN_INFO "radeonfb: Reversed DACs detected\n");
+				}
+				if ((((tmp0 >> 8) & 0x0f) == ddc_dvi) && ((tmp0 >> 4) & 0x01)) {
+					rinfo->reversed_TMDS = 1;
+					printk(KERN_INFO "radeonfb: Reversed TMDS detected\n");
+				}
+			}
+		}
+
+		/*
+		 * Probe primary head (DVI or laptop internal panel)
+		 */
+#ifdef CONFIG_FB_RADEON_I2C
+		rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID);
+		if (rinfo->mon1_type == MT_NONE) {
+			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);
+			if (rinfo->mon1_type != MT_NONE)
+				ddc_crt2_used = 1;
+		}
+#endif /* CONFIG_FB_RADEON_I2C */
+#ifdef CONFIG_PPC_OF
+		if (rinfo->mon1_type == MT_NONE)
+			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0, &rinfo->mon1_EDID);
+#endif /* CONFIG_PPC_OF */
+		if (rinfo->mon1_type == MT_NONE && rinfo->is_mobility &&
+		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
+		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
+			rinfo->mon1_type = MT_LCD;
+			printk("Non-DDC laptop panel detected\n");
+		}
+		if (rinfo->mon1_type == MT_NONE)
+			rinfo->mon1_type = radeon_crt_is_connected(rinfo, rinfo->reversed_DAC);
+
+		/*
+		 * Probe secondary head (mostly VGA, can be DVI)
+		 */
+#ifdef CONFIG_FB_RADEON_I2C
+		rinfo->mon2_type = radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon2_EDID);
+		if (rinfo->mon2_type == MT_NONE && !ddc_crt2_used)
+			rinfo->mon2_type = radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon2_EDID);
+#endif /* CONFIG_FB_RADEON_I2C */
+#ifdef CONFIG_PPC_OF
+		if (rinfo->mon2_type == MT_NONE)
+			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1, &rinfo->mon2_EDID);
+#endif /* CONFIG_PPC_OF */
+		if (rinfo->mon2_type == MT_NONE)
+			rinfo->mon2_type = radeon_crt_is_connected(rinfo, !rinfo->reversed_DAC);
+
+		/*
+		 * If we only detected port 2, we swap them, if none detected,
+		 * assume CRT (maybe fallback to old BIOS_SCRATCH stuff ? or look
+		 * at FP registers ?)
+		 */
+		if (rinfo->mon1_type == MT_NONE) {
+			if (rinfo->mon2_type != MT_NONE) {
+				rinfo->mon1_type = rinfo->mon2_type;
+				rinfo->mon1_EDID = rinfo->mon2_EDID;
+			} else
+				rinfo->mon1_type = MT_CRT;
+			rinfo->mon2_type = MT_NONE;
+			rinfo->mon2_EDID = NULL;
+		}
+
+		/*
+		 * Deal with reversed TMDS
+		 */
+		if (rinfo->reversed_TMDS) {
+			/* Always keep internal TMDS as primary head */
+			if (rinfo->mon1_type == MT_DFP || rinfo->mon2_type == MT_DFP) {
+				int tmp_type = rinfo->mon1_type;
+				u8 *tmp_EDID = rinfo->mon1_EDID;
+				rinfo->mon1_type = rinfo->mon2_type;
+				rinfo->mon1_EDID = rinfo->mon2_EDID;
+				rinfo->mon2_type = tmp_type;
+				rinfo->mon2_EDID = tmp_EDID;
+				if (rinfo->mon1_type == MT_CRT || rinfo->mon2_type == MT_CRT)
+					rinfo->reversed_DAC ^= 1;
+			}
+		}
+	}
+	if (ignore_edid) {
+		if (rinfo->mon1_EDID)
+			kfree(rinfo->mon1_EDID);
+		rinfo->mon1_EDID = NULL;
+		if (rinfo->mon2_EDID)
+			kfree(rinfo->mon2_EDID);
+		rinfo->mon2_EDID = NULL;
+	}
+
+ bail:
+	printk(KERN_INFO "radeonfb: Monitor 1 type %s found\n",
+	       radeon_get_mon_name(rinfo->mon1_type));
+	if (rinfo->mon1_EDID) {
+		printk(KERN_INFO "radeonfb: EDID probed\n");
+		show_edid(rinfo->mon1_EDID);
+	}
+	if (!rinfo->has_CRTC2)
+		return;
+	printk(KERN_INFO "radeonfb: Monitor 2 type %s found\n",
+	       radeon_get_mon_name(rinfo->mon2_type));
+	if (rinfo->mon2_EDID) {
+		printk(KERN_INFO "radeonfb: EDID probed\n");
+		show_edid(rinfo->mon2_EDID);
+	}
+}
+
+
+static void radeon_var_to_panel_info(struct radeonfb_info *rinfo, struct fb_var_screeninfo *var)
+{
+	rinfo->panel_info.xres = var->xres;
+	rinfo->panel_info.yres = var->yres;
+	rinfo->panel_info.clock = 100000000 / var->pixclock;
+	rinfo->panel_info.hOver_plus = var->right_margin;
+	rinfo->panel_info.hSync_width = var->hsync_len;
+       	rinfo->panel_info.hblank = var->left_margin +
+		(var->right_margin + var->hsync_len);
+	rinfo->panel_info.vOver_plus = var->lower_margin;
+	rinfo->panel_info.vSync_width = var->vsync_len;
+       	rinfo->panel_info.vblank = var->upper_margin +
+		(var->lower_margin + var->vsync_len);
+	rinfo->panel_info.hAct_high =
+		(var->sync & FB_SYNC_HOR_HIGH_ACT) != 0;
+	rinfo->panel_info.vAct_high =
+		(var->sync & FB_SYNC_VERT_HIGH_ACT) != 0;
+	rinfo->panel_info.valid = 1;
+}
+
+static void radeon_var_to_videomode(struct fb_videomode *mode,
+				    const struct fb_var_screeninfo *var)
+{
+    mode->xres = var->xres;
+    mode->yres = var->yres;
+    mode->pixclock = var->pixclock;
+    mode->left_margin = var->left_margin;
+    mode->right_margin = var->right_margin;
+    mode->upper_margin = var->upper_margin;
+    mode->lower_margin = var->lower_margin;
+    mode->hsync_len = var->hsync_len;
+    mode->vsync_len = var->vsync_len;
+    mode->sync = var->sync;
+    mode->vmode = var->vmode;
+}
+
+/*
+ * Build the modedb for head 1 (head 2 will come later), check panel infos
+ * from either BIOS or EDID, and pick up the default mode
+ */
+void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option)
+{
+	int has_default_mode = 0;
+
+	/*
+	 * Fill default var first
+	 */
+	rinfo->info.var = radeonfb_default_var;
+
+	/*
+	 * First check out what BIOS has to say
+	 */
+	if (rinfo->mon1_type == MT_LCD)
+		radeon_get_panel_info_BIOS(rinfo);
+
+	/*
+	 * Parse EDID detailed timings and deduce panel infos if any. Right now
+	 * we only deal with first entry returned by parse_EDID, we may do better
+	 * some day...
+	 */
+	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type != MT_CRT
+	    && rinfo->mon1_EDID) {
+		struct fb_var_screeninfo var;
+		if (parse_edid(rinfo->mon1_EDID, &var) == 0) {
+			if (var.xres >= rinfo->panel_info.xres &&
+			    var.yres >= rinfo->panel_info.yres)
+				radeon_var_to_panel_info(rinfo, &var);
+		}
+	}
+
+	/*
+	 * If we have some valid panel infos, we setup the default mode based on
+	 * those
+	 */
+	if (rinfo->mon1_type != MT_CRT && rinfo->panel_info.valid) {
+		struct fb_var_screeninfo *var = &rinfo->info.var;
+
+		var->xres = rinfo->panel_info.xres;
+		var->yres = rinfo->panel_info.yres;
+		var->xres_virtual = rinfo->panel_info.xres;
+		var->yres_virtual = rinfo->panel_info.yres;
+		var->xoffset = var->yoffset = 0;
+		var->bits_per_pixel = 8;
+		var->pixclock = 100000000 / rinfo->panel_info.clock;
+		var->left_margin = (rinfo->panel_info.hblank - rinfo->panel_info.hOver_plus
+				    - rinfo->panel_info.hSync_width);
+		var->right_margin = rinfo->panel_info.hOver_plus;
+		var->upper_margin = (rinfo->panel_info.vblank - rinfo->panel_info.vOver_plus
+				     - rinfo->panel_info.vSync_width);
+		var->lower_margin = rinfo->panel_info.vOver_plus;
+		var->hsync_len = rinfo->panel_info.hSync_width;
+		var->vsync_len = rinfo->panel_info.vSync_width;
+		var->sync = 0;
+		if (rinfo->panel_info.hAct_high)
+			var->sync |= FB_SYNC_HOR_HIGH_ACT;
+		if (rinfo->panel_info.vAct_high)
+			var->sync |= FB_SYNC_VERT_HIGH_ACT;
+		var->vmode = 0;
+		has_default_mode = 1;
+	}
+
+	/*
+	 * Now build modedb from EDID
+	 */
+	if (rinfo->mon1_EDID)
+		rinfo->mon1_modedb = fb_create_modedb(rinfo->mon1_EDID, &rinfo->mon1_dbsize);
+	
+	/*
+	 * Finally, if we don't have panel infos we need to figure some (or
+	 * we try to read it from card), we try to pick a default mode
+	 * and create some panel infos. Whatever...
+	 */
+	if (rinfo->mon1_type != MT_CRT && !rinfo->panel_info.valid) {
+		struct fb_videomode	*modedb;
+		int			dbsize;
+		char			modename[32];
+
+		if (rinfo->panel_info.xres == 0 || rinfo->panel_info.yres == 0) {
+			u32 tmp = INREG(FP_HORZ_STRETCH) & HORZ_PANEL_SIZE;
+			rinfo->panel_info.xres = ((tmp >> HORZ_PANEL_SHIFT) + 1) * 8;
+			tmp = INREG(FP_VERT_STRETCH) & VERT_PANEL_SIZE;
+			rinfo->panel_info.yres = (tmp >> VERT_PANEL_SHIFT) + 1;
+		}
+		if (rinfo->panel_info.xres == 0 || rinfo->panel_info.yres == 0) {
+			printk(KERN_WARNING "radeonfb: Can't find panel size, going back to CRT\n");
+			rinfo->mon1_type = MT_CRT;
+			goto pickup_default;
+		}
+		printk(KERN_WARNING "radeonfb: Asssuming panel size %dx%d\n",
+		       rinfo->panel_info.xres, rinfo->panel_info.yres);
+		modedb = rinfo->mon1_modedb;
+		dbsize = rinfo->mon1_dbsize;
+		snprintf(modename, 31, "%dx%d", rinfo->panel_info.xres, rinfo->panel_info.yres);
+		if (fb_find_mode(&rinfo->info.var, &rinfo->info, modename,
+				 modedb, dbsize, NULL, 8) == 0) {
+			printk(KERN_WARNING "radeonfb: Can't find mode for panel size, going back to CRT\n");
+			rinfo->mon1_type = MT_CRT;
+			goto pickup_default;
+		}
+		has_default_mode = 1;
+		radeon_var_to_panel_info(rinfo, &rinfo->info.var);
+	}
+
+ pickup_default:
+	/*
+	 * Pick up a random default mode
+	 */
+	if (!has_default_mode || mode_option) {
+		struct fb_videomode default_mode;
+		if (has_default_mode)
+			radeon_var_to_videomode(&default_mode, &rinfo->info.var);
+		else
+			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
+		if (fb_find_mode(&rinfo->info.var, &rinfo->info, mode_option,
+			     rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8) == 0)
+			rinfo->info.var = radeonfb_default_var;
+	}
+
+}
diff -urN linux-2.5-mesa/drivers/video/aty/radeon_pm.c linuxppc-2.5-benh/drivers/video/aty/radeon_pm.c
--- linux-2.5-mesa/drivers/video/aty/radeon_pm.c	Thu Jan 01 01:00:00 1970
+++ linuxppc-2.5-benh/drivers/video/aty/radeon_pm.c	Sun Sep 07 17:29:50 2003
@@ -0,0 +1,908 @@
+#include "radeonfb.h"
+
+#include <linux/console.h>
+
+/*
+ * Radeon M6, M7 and M9 Power Management code. This code currently
+ * only supports the mobile chips in D2 mode, that is typically what
+ * is used on Apple laptops, it's based from some informations provided
+ * by ATI along with hours of tracing of MacOS drivers.
+ * 
+ * New version of this code almost totally rewritten by ATI, many thanks
+ * for their support.
+ */
+
+void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
+{
+
+	u32 sclk_cntl;
+	u32 mclk_cntl;
+	u32 sclk_more_cntl;
+	
+	u32 vclk_ecp_cntl;
+	u32 pixclks_cntl;
+
+	/* Mobility chips only */
+	if ((rinfo->arch != RADEON_M6) && (rinfo->arch != RADEON_M7) && (rinfo->arch != RADEON_M9))
+		return;
+	
+	/* Force Core Clocks */
+	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
+	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
+			SCLK_CNTL_M6__FORCE_HDP|
+			SCLK_CNTL_M6__FORCE_DISP1|
+			SCLK_CNTL_M6__FORCE_DISP2|
+			SCLK_CNTL_M6__FORCE_TOP|
+			SCLK_CNTL_M6__FORCE_E2|
+			SCLK_CNTL_M6__FORCE_SE|
+			SCLK_CNTL_M6__FORCE_IDCT|
+			SCLK_CNTL_M6__FORCE_VIP|
+			SCLK_CNTL_M6__FORCE_RE|
+			SCLK_CNTL_M6__FORCE_PB|
+			SCLK_CNTL_M6__FORCE_TAM|
+			SCLK_CNTL_M6__FORCE_TDM|
+			SCLK_CNTL_M6__FORCE_RB|
+			SCLK_CNTL_M6__FORCE_TV_SCLK|
+			SCLK_CNTL_M6__FORCE_SUBPIC|
+			SCLK_CNTL_M6__FORCE_OV0;
+    	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+	
+	
+	
+	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
+	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
+				SCLK_MORE_CNTL__FORCE_MC_GUI|
+				SCLK_MORE_CNTL__FORCE_MC_HOST;	
+	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
+	
+	/* Force Display clocks	*/
+	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
+	vclk_ecp_cntl &= ~(	VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |
+			 	VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+
+	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
+	
+	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
+	pixclks_cntl &= ~(	PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb |
+			 	PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
+				PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
+						
+ 	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+
+	/* Force Memory Clocks */
+	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
+	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
+			MCLK_CNTL_M6__FORCE_MCLKB |
+			MCLK_CNTL_M6__FORCE_YCLKA |
+			MCLK_CNTL_M6__FORCE_YCLKB );
+    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+}
+
+void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
+{
+	u32 clk_pwrmgt_cntl;
+	u32 sclk_cntl;
+	u32 sclk_more_cntl;
+	u32 clk_pin_cntl;
+	u32 pixclks_cntl;
+	u32 vclk_ecp_cntl;
+	u32 mclk_cntl;
+	u32 mclk_misc;
+
+	/* Mobility chips only */
+	if ((rinfo->arch != RADEON_M6) && (rinfo->arch != RADEON_M7) && (rinfo->arch != RADEON_M9))
+		return;
+	
+	/* Set Latencies */
+	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	
+	clk_pwrmgt_cntl &= ~(	 CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK|
+				 CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
+				 CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK|
+				 CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK);
+	/* Mode 1 */
+	clk_pwrmgt_cntl = 	CLK_PWRMGT_CNTL_M6__MC_CH_MODE|
+				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE | 
+				(1<<CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT) |
+				(0<<CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT)|
+				(0<<CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT);
+
+	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
+						
+
+	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
+	clk_pin_cntl |= CLK_PIN_CNTL__SCLK_DYN_START_CNTL;
+	 
+	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
+
+	/* Enable Dyanmic mode for SCLK */
+
+	sclk_cntl = INPLL( pllSCLK_CNTL_M6);	
+	sclk_cntl &= SCLK_CNTL_M6__SCLK_SRC_SEL_MASK;
+	sclk_cntl |= SCLK_CNTL_M6__FORCE_VIP;		
+
+	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+
+
+	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
+	sclk_more_cntl &= ~(SCLK_MORE_CNTL__FORCE_DISPREGS);
+				                    
+	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);
+
+	
+	/* Enable Dynamic mode for PIXCLK & PIX2CLK */
+
+	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
+	
+	pixclks_cntl|=  PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb | 
+			PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb|
+			PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+			PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb|
+			PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb|
+			PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+			PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb;
+
+	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+		
+		
+	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
+	
+	vclk_ecp_cntl|=  VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb | 
+			 VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb;
+
+	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
+
+
+	/* Enable Dynamic mode for MCLK	*/
+
+	mclk_cntl  = INPLL( pllMCLK_CNTL_M6);
+	mclk_cntl |= 	MCLK_CNTL_M6__FORCE_MCLKA|  
+			MCLK_CNTL_M6__FORCE_MCLKB|	
+			MCLK_CNTL_M6__FORCE_YCLKA|
+			MCLK_CNTL_M6__FORCE_YCLKB;
+			
+    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+
+	mclk_misc = INPLL(pllMCLK_MISC);
+	mclk_misc |= 	MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT|
+			MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT|
+			MCLK_MISC__MC_MCLK_DYN_ENABLE|
+			MCLK_MISC__IO_MCLK_DYN_ENABLE;	
+	
+	OUTPLL(pllMCLK_MISC, mclk_misc);
+}
+
+#ifdef CONFIG_PM
+
+static void OUTMC( struct radeonfb_info *rinfo, u8 indx, u32 value)
+{
+	OUTREG( MC_IND_INDEX, indx | MC_IND_INDEX__MC_IND_WR_EN);	
+	OUTREG( MC_IND_DATA, value);		
+}
+
+static u32 INMC(struct radeonfb_info *rinfo, u8 indx)
+{
+	OUTREG( MC_IND_INDEX, indx);					
+	return INREG( MC_IND_DATA);
+}
+
+static void radeon_pm_save_regs(struct radeonfb_info *rinfo)
+{
+	rinfo->save_regs[0] = INPLL(PLL_PWRMGT_CNTL);
+	rinfo->save_regs[1] = INPLL(CLK_PWRMGT_CNTL);
+	rinfo->save_regs[2] = INPLL(MCLK_CNTL);
+	rinfo->save_regs[3] = INPLL(SCLK_CNTL);
+	rinfo->save_regs[4] = INPLL(CLK_PIN_CNTL);
+	rinfo->save_regs[5] = INPLL(VCLK_ECP_CNTL);
+	rinfo->save_regs[6] = INPLL(PIXCLKS_CNTL);
+	rinfo->save_regs[7] = INPLL(MCLK_MISC);
+	rinfo->save_regs[8] = INPLL(P2PLL_CNTL);
+	
+	rinfo->save_regs[9] = INREG(DISP_MISC_CNTL);
+	rinfo->save_regs[10] = INREG(DISP_PWR_MAN);
+	rinfo->save_regs[11] = INREG(LVDS_GEN_CNTL);
+	rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
+	rinfo->save_regs[13] = INREG(TV_DAC_CNTL);
+	rinfo->save_regs[14] = INREG(BUS_CNTL1);
+	rinfo->save_regs[15] = INREG(CRTC_OFFSET_CNTL);
+	rinfo->save_regs[16] = INREG(AGP_CNTL);
+	rinfo->save_regs[17] = (INREG(CRTC_GEN_CNTL) & 0xfdffffff) | 0x04000000;
+	rinfo->save_regs[18] = (INREG(CRTC2_GEN_CNTL) & 0xfdffffff) | 0x04000000;
+	rinfo->save_regs[19] = INREG(GPIOPAD_A);
+	rinfo->save_regs[20] = INREG(GPIOPAD_EN);
+	rinfo->save_regs[21] = INREG(GPIOPAD_MASK);
+	rinfo->save_regs[22] = INREG(ZV_LCDPAD_A);
+	rinfo->save_regs[23] = INREG(ZV_LCDPAD_EN);
+	rinfo->save_regs[24] = INREG(ZV_LCDPAD_MASK);
+	rinfo->save_regs[25] = INREG(GPIO_VGA_DDC);
+	rinfo->save_regs[26] = INREG(GPIO_DVI_DDC);
+	rinfo->save_regs[27] = INREG(GPIO_MONID);
+	rinfo->save_regs[28] = INREG(GPIO_CRT2_DDC);
+
+	rinfo->save_regs[29] = INREG(SURFACE_CNTL);
+	rinfo->save_regs[30] = INREG(MC_FB_LOCATION);
+	rinfo->save_regs[31] = INREG(DISPLAY_BASE_ADDR);
+	rinfo->save_regs[32] = INREG(MC_AGP_LOCATION);
+	rinfo->save_regs[33] = INREG(CRTC2_DISPLAY_BASE_ADDR);
+}
+
+static void radeon_pm_restore_regs(struct radeonfb_info *rinfo)
+{
+	OUTPLL(P2PLL_CNTL, rinfo->save_regs[8] & 0xFFFFFFFE); /* First */
+	
+	OUTPLL(PLL_PWRMGT_CNTL, rinfo->save_regs[0]);
+	OUTPLL(CLK_PWRMGT_CNTL, rinfo->save_regs[1]);
+	OUTPLL(MCLK_CNTL, rinfo->save_regs[2]);
+	OUTPLL(SCLK_CNTL, rinfo->save_regs[3]);
+	OUTPLL(CLK_PIN_CNTL, rinfo->save_regs[4]);
+	OUTPLL(VCLK_ECP_CNTL, rinfo->save_regs[5]);
+	OUTPLL(PIXCLKS_CNTL, rinfo->save_regs[6]);
+	OUTPLL(MCLK_MISC, rinfo->save_regs[7]);
+	
+	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
+	OUTREG(MC_FB_LOCATION, rinfo->save_regs[30]);
+	OUTREG(DISPLAY_BASE_ADDR, rinfo->save_regs[31]);
+	OUTREG(MC_AGP_LOCATION, rinfo->save_regs[32]);
+	OUTREG(CRTC2_DISPLAY_BASE_ADDR, rinfo->save_regs[33]);
+
+	OUTREG(DISP_MISC_CNTL, rinfo->save_regs[9]);
+	OUTREG(DISP_PWR_MAN, rinfo->save_regs[10]);
+	OUTREG(LVDS_GEN_CNTL, rinfo->save_regs[11]);
+	OUTREG(LVDS_PLL_CNTL,rinfo->save_regs[12]);
+	OUTREG(TV_DAC_CNTL, rinfo->save_regs[13]);
+	OUTREG(BUS_CNTL1, rinfo->save_regs[14]);
+	OUTREG(CRTC_OFFSET_CNTL, rinfo->save_regs[15]);
+	OUTREG(AGP_CNTL, rinfo->save_regs[16]);
+	OUTREG(CRTC_GEN_CNTL, rinfo->save_regs[17]);
+	OUTREG(CRTC2_GEN_CNTL, rinfo->save_regs[18]);
+
+	// wait VBL before that one  ?
+	OUTPLL(P2PLL_CNTL, rinfo->save_regs[8]);
+	
+	OUTREG(GPIOPAD_A, rinfo->save_regs[19]);
+	OUTREG(GPIOPAD_EN, rinfo->save_regs[20]);
+	OUTREG(GPIOPAD_MASK, rinfo->save_regs[21]);
+	OUTREG(ZV_LCDPAD_A, rinfo->save_regs[22]);
+	OUTREG(ZV_LCDPAD_EN, rinfo->save_regs[23]);
+	OUTREG(ZV_LCDPAD_MASK, rinfo->save_regs[24]);
+	OUTREG(GPIO_VGA_DDC, rinfo->save_regs[25]);
+	OUTREG(GPIO_DVI_DDC, rinfo->save_regs[26]);
+	OUTREG(GPIO_MONID, rinfo->save_regs[27]);
+	OUTREG(GPIO_CRT2_DDC, rinfo->save_regs[28]);
+}
+
+static void radeon_pm_disable_iopad(struct radeonfb_info *rinfo)
+{		
+	OUTREG(GPIOPAD_MASK, 0x0001ffff);
+	OUTREG(GPIOPAD_EN, 0x00000400);
+	OUTREG(GPIOPAD_A, 0x00000000);		
+        OUTREG(ZV_LCDPAD_MASK, 0x00000000);
+        OUTREG(ZV_LCDPAD_EN, 0x00000000);
+      	OUTREG(ZV_LCDPAD_A, 0x00000000); 	
+	OUTREG(GPIO_VGA_DDC, 0x00030000);
+	OUTREG(GPIO_DVI_DDC, 0x00000000);
+	OUTREG(GPIO_MONID, 0x00030000);
+	OUTREG(GPIO_CRT2_DDC, 0x00000000);
+}
+
+static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
+{
+	/* Set v2clk to 65MHz */
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
+	 
+  	OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+	OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
+	OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
+	
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
+	mdelay(1);
+
+	OUTPLL(pllP2PLL_CNTL, INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET); 	
+	mdelay( 1);
+
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		(INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
+  		| (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
+	mdelay( 1);	
+}
+
+static void radeon_pm_low_current(struct radeonfb_info *rinfo)
+{
+	u32 reg;
+
+	reg  = INREG(BUS_CNTL1);
+	reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
+	reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
+	OUTREG(BUS_CNTL1, reg);
+	
+	reg  = INPLL(PLL_PWRMGT_CNTL);
+	reg |= PLL_PWRMGT_CNTL_SPLL_TURNOFF | PLL_PWRMGT_CNTL_PPLL_TURNOFF |
+		PLL_PWRMGT_CNTL_P2PLL_TURNOFF | PLL_PWRMGT_CNTL_TVPLL_TURNOFF;
+	reg &= ~PLL_PWRMGT_CNTL_SU_MCLK_USE_BCLK;
+	reg &= ~PLL_PWRMGT_CNTL_MOBILE_SU;
+	OUTPLL(PLL_PWRMGT_CNTL, reg);
+	
+	reg  = INREG(TV_DAC_CNTL);
+	reg &= ~(TV_DAC_CNTL_BGADJ_MASK |TV_DAC_CNTL_DACADJ_MASK);
+	reg |=TV_DAC_CNTL_BGSLEEP | TV_DAC_CNTL_RDACPD | TV_DAC_CNTL_GDACPD |
+		TV_DAC_CNTL_BDACPD |
+		(8<<TV_DAC_CNTL_BGADJ__SHIFT) | (8<<TV_DAC_CNTL_DACADJ__SHIFT);
+	OUTREG(TV_DAC_CNTL, reg);
+	
+	reg  = INREG(TMDS_TRANSMITTER_CNTL);
+	reg &= ~(TMDS_PLL_EN | TMDS_PLLRST);
+	OUTREG(TMDS_TRANSMITTER_CNTL, reg);
+
+	reg = INREG(DAC_CNTL);
+	reg &= ~DAC_CMP_EN;
+	OUTREG(DAC_CNTL, reg);
+
+	reg = INREG(DAC_CNTL2);
+	reg &= ~DAC2_CMP_EN;
+	OUTREG(DAC_CNTL2, reg);
+	
+	reg  = INREG(TV_DAC_CNTL);
+	reg &= ~TV_DAC_CNTL_DETECT;
+	OUTREG(TV_DAC_CNTL, reg);
+}
+
+static void radeon_pm_setup_for_suspend(struct radeonfb_info *rinfo)
+{
+
+	u32 sclk_cntl, mclk_cntl, sclk_more_cntl;
+
+	u32 pll_pwrmgt_cntl;
+	u32 clk_pwrmgt_cntl;
+	u32 clk_pin_cntl;
+	u32 vclk_ecp_cntl; 
+	u32 pixclks_cntl;
+	u32 disp_mis_cntl;
+	u32 disp_pwr_man;
+
+	
+	/* Force Core Clocks */
+	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
+	sclk_cntl |= 	SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT|
+			SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT|
+			
+			SCLK_CNTL_M6__FORCE_DISP2|
+			SCLK_CNTL_M6__FORCE_CP|
+			SCLK_CNTL_M6__FORCE_HDP|
+			SCLK_CNTL_M6__FORCE_DISP1|
+			SCLK_CNTL_M6__FORCE_TOP|
+			SCLK_CNTL_M6__FORCE_E2|
+			SCLK_CNTL_M6__FORCE_SE|
+			SCLK_CNTL_M6__FORCE_IDCT|
+			SCLK_CNTL_M6__FORCE_VIP|
+			
+			SCLK_CNTL_M6__FORCE_RE|
+			SCLK_CNTL_M6__FORCE_PB|
+			SCLK_CNTL_M6__FORCE_TAM|
+			SCLK_CNTL_M6__FORCE_TDM|
+			SCLK_CNTL_M6__FORCE_RB|
+			SCLK_CNTL_M6__FORCE_TV_SCLK|
+			SCLK_CNTL_M6__FORCE_SUBPIC|
+			SCLK_CNTL_M6__FORCE_OV0;
+
+	OUTPLL( pllSCLK_CNTL_M6, sclk_cntl);
+
+	sclk_more_cntl = INPLL(pllSCLK_MORE_CNTL);
+	sclk_more_cntl |= 	SCLK_MORE_CNTL__FORCE_DISPREGS |
+				SCLK_MORE_CNTL__FORCE_MC_GUI |
+				SCLK_MORE_CNTL__FORCE_MC_HOST;
+
+	OUTPLL(pllSCLK_MORE_CNTL, sclk_more_cntl);		
+
+	
+	mclk_cntl = INPLL( pllMCLK_CNTL_M6);
+	mclk_cntl &= ~(	MCLK_CNTL_M6__FORCE_MCLKA |  
+			MCLK_CNTL_M6__FORCE_MCLKB |
+			MCLK_CNTL_M6__FORCE_YCLKA | 
+			MCLK_CNTL_M6__FORCE_YCLKB | 
+			MCLK_CNTL_M6__FORCE_MC
+		      );	
+    	OUTPLL( pllMCLK_CNTL_M6, mclk_cntl);
+	
+	/* Force Display clocks	*/
+	vclk_ecp_cntl = INPLL( pllVCLK_ECP_CNTL);
+	vclk_ecp_cntl &= ~(VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb |VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb);
+	vclk_ecp_cntl |= VCLK_ECP_CNTL__ECP_FORCE_ON;
+	OUTPLL( pllVCLK_ECP_CNTL, vclk_ecp_cntl);
+	
+	
+	pixclks_cntl = INPLL( pllPIXCLKS_CNTL);
+	pixclks_cntl &= ~(	PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb | 
+				PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb |
+				PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb|
+				PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb);
+						
+ 	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
+
+
+
+	/* Enable System power management */
+	pll_pwrmgt_cntl = INPLL( pllPLL_PWRMGT_CNTL);
+	
+	pll_pwrmgt_cntl |= 	PLL_PWRMGT_CNTL__SPLL_TURNOFF |
+				PLL_PWRMGT_CNTL__MPLL_TURNOFF|
+				PLL_PWRMGT_CNTL__PPLL_TURNOFF|
+				PLL_PWRMGT_CNTL__P2PLL_TURNOFF|
+				PLL_PWRMGT_CNTL__TVPLL_TURNOFF;
+						
+	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
+	
+	clk_pwrmgt_cntl	 = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	
+	clk_pwrmgt_cntl &= ~(	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF|
+				CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF|
+				CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF|
+				CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF|
+				CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF|
+				CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN|
+				CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE|
+				CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK|
+				CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK			
+			);
+						
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN | CLK_PWRMGT_CNTL_M6__DISP_PM;
+	
+	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);	
+	
+	clk_pin_cntl = INPLL( pllCLK_PIN_CNTL);
+	
+	clk_pin_cntl &= ~CLK_PIN_CNTL__ACCESS_REGS_IN_SUSPEND;
+	OUTPLL( pllMCLK_MISC, INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND);	
+	
+	/* AGP PLL control */
+	OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
+
+	OUTREG(BUS_CNTL1,
+		(INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
+		| (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));	// 440BX
+	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL) & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
+	
+	clk_pin_cntl &= ~CLK_PIN_CNTL__CG_CLK_TO_OUTPIN;
+	clk_pin_cntl |= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;	
+	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
+
+	/* Solano2M */
+	OUTREG(AGP_CNTL,
+		(INREG(AGP_CNTL) & ~(AGP_CNTL__MAX_IDLE_CLK_MASK))
+		| (0x20<<AGP_CNTL__MAX_IDLE_CLK__SHIFT));
+
+	/* ACPI mode */
+	OUTPLL( pllPLL_PWRMGT_CNTL, INPLL( pllPLL_PWRMGT_CNTL) & ~PLL_PWRMGT_CNTL__PM_MODE_SEL);					
+
+
+	disp_mis_cntl = INREG(DISP_MISC_CNTL);
+	
+	disp_mis_cntl &= ~(	DISP_MISC_CNTL__SOFT_RESET_GRPH_PP | 
+				DISP_MISC_CNTL__SOFT_RESET_SUBPIC_PP | 
+				DISP_MISC_CNTL__SOFT_RESET_OV0_PP |
+				DISP_MISC_CNTL__SOFT_RESET_GRPH_SCLK|
+				DISP_MISC_CNTL__SOFT_RESET_SUBPIC_SCLK|
+				DISP_MISC_CNTL__SOFT_RESET_OV0_SCLK|
+				DISP_MISC_CNTL__SOFT_RESET_GRPH2_PP|
+				DISP_MISC_CNTL__SOFT_RESET_GRPH2_SCLK|
+				DISP_MISC_CNTL__SOFT_RESET_LVDS|
+				DISP_MISC_CNTL__SOFT_RESET_TMDS|
+				DISP_MISC_CNTL__SOFT_RESET_DIG_TMDS|
+				DISP_MISC_CNTL__SOFT_RESET_TV);
+	
+	OUTREG(DISP_MISC_CNTL, disp_mis_cntl);					
+						
+	disp_pwr_man = INREG(DISP_PWR_MAN);
+	
+	disp_pwr_man &= ~(	DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN	| 
+						DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN |
+						DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK|		
+						DISP_PWR_MAN__DISP_D3_RST|
+						DISP_PWR_MAN__DISP_D3_REG_RST
+					);
+	
+	disp_pwr_man |= DISP_PWR_MAN__DISP_D3_GRPH_RST|
+					DISP_PWR_MAN__DISP_D3_SUBPIC_RST|
+					DISP_PWR_MAN__DISP_D3_OV0_RST|
+					DISP_PWR_MAN__DISP_D1D2_GRPH_RST|
+					DISP_PWR_MAN__DISP_D1D2_SUBPIC_RST|
+					DISP_PWR_MAN__DISP_D1D2_OV0_RST|
+					DISP_PWR_MAN__DIG_TMDS_ENABLE_RST|
+					DISP_PWR_MAN__TV_ENABLE_RST| 
+//					DISP_PWR_MAN__AUTO_PWRUP_EN|
+					0;
+	
+	OUTREG(DISP_PWR_MAN, disp_pwr_man);					
+							
+	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
+	pll_pwrmgt_cntl = INPLL( pllPLL_PWRMGT_CNTL) ;
+	clk_pin_cntl 	= INPLL( pllCLK_PIN_CNTL);
+	disp_pwr_man	= INREG(DISP_PWR_MAN);
+		
+	
+	/* D2 */
+	clk_pwrmgt_cntl |= CLK_PWRMGT_CNTL_M6__DISP_PM;
+	pll_pwrmgt_cntl |= PLL_PWRMGT_CNTL__MOBILE_SU | PLL_PWRMGT_CNTL__SU_SCLK_USE_BCLK;
+	clk_pin_cntl	|= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;
+	disp_pwr_man 	&= ~(DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK | DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK);							
+						
+
+	OUTPLL( pllCLK_PWRMGT_CNTL_M6, clk_pwrmgt_cntl);
+	OUTPLL( pllPLL_PWRMGT_CNTL, pll_pwrmgt_cntl);
+	OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);
+	OUTREG(DISP_PWR_MAN, disp_pwr_man);
+
+	/* disable display request & disable display */
+	OUTREG( CRTC_GEN_CNTL, (INREG( CRTC_GEN_CNTL) & ~CRTC_GEN_CNTL__CRTC_EN) | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B);
+	OUTREG( CRTC2_GEN_CNTL, (INREG( CRTC2_GEN_CNTL) & ~CRTC2_GEN_CNTL__CRTC2_EN) | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B);
+
+	mdelay(17);				   
+
+}
+
+static void radeon_pm_yclk_mclk_sync(struct radeonfb_info *rinfo)
+{
+	u32 mc_chp_io_cntl_a1, mc_chp_io_cntl_b1;
+
+	mc_chp_io_cntl_a1 = INMC( rinfo, ixMC_CHP_IO_CNTL_A1) & ~MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK;
+	mc_chp_io_cntl_b1 = INMC( rinfo, ixMC_CHP_IO_CNTL_B1) & ~MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK;
+
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1 | (1<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT));
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1 | (1<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT));
+
+	/* Wassup ? This doesn't seem to be defined, let's hope we are ok this way --BenH */
+#ifdef MCLK_YCLK_SYNC_ENABLE
+	mc_chp_io_cntl_a1 |= (2<<MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT);
+	mc_chp_io_cntl_b1 |= (2<<MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT);
+#endif
+
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_A1, mc_chp_io_cntl_a1);
+	OUTMC( rinfo, ixMC_CHP_IO_CNTL_B1, mc_chp_io_cntl_b1);
+
+	mdelay( 1);
+}
+
+static void radeon_pm_program_mode_reg(struct radeonfb_info *rinfo, u16 value, u8 delay_required)
+{  
+	u32 mem_sdram_mode;
+
+	mem_sdram_mode  = INREG( MEM_SDRAM_MODE_REG);
+
+	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK;
+	mem_sdram_mode |= (value<<MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT) | MEM_SDRAM_MODE_REG__MEM_CFG_TYPE;
+	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+
+	mem_sdram_mode |=  MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
+	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+
+	mem_sdram_mode &= ~MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET;
+	OUTREG( MEM_SDRAM_MODE_REG, mem_sdram_mode);
+
+	if (delay_required == 1)
+		while( (INREG( MC_STATUS) & (MC_STATUS__MEM_PWRUP_COMPL_A | MC_STATUS__MEM_PWRUP_COMPL_B) ) == 0 )
+			{ }; 	
+}
+
+
+static void radeon_pm_enable_dll(struct radeonfb_info *rinfo)
+{  
+#define DLL_RESET_DELAY 	5
+#define DLL_SLEEP_DELAY		1
+
+	u32 DLL_CKO_Value = INPLL(pllMDLL_CKO)   | MDLL_CKO__MCKOA_SLEEP |  MDLL_CKO__MCKOA_RESET;
+	u32 DLL_CKA_Value = INPLL(pllMDLL_RDCKA) | MDLL_RDCKA__MRDCKA0_SLEEP | MDLL_RDCKA__MRDCKA1_SLEEP | MDLL_RDCKA__MRDCKA0_RESET | MDLL_RDCKA__MRDCKA1_RESET;
+	u32 DLL_CKB_Value = INPLL(pllMDLL_RDCKB) | MDLL_RDCKB__MRDCKB0_SLEEP | MDLL_RDCKB__MRDCKB1_SLEEP | MDLL_RDCKB__MRDCKB0_RESET | MDLL_RDCKB__MRDCKB1_RESET;
+
+	/* Setting up the DLL range for write */
+	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
+	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
+	OUTPLL(pllMDLL_RDCKB,	DLL_CKB_Value);
+
+	mdelay( DLL_RESET_DELAY);
+
+	/* Channel A */
+
+	/* Power Up */
+	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_SLEEP );
+	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+   
+	DLL_CKO_Value &= ~(MDLL_CKO__MCKOA_RESET );
+	OUTPLL(pllMDLL_CKO,	DLL_CKO_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+	/* Power Up */
+	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_SLEEP );
+	OUTPLL(pllMDLL_RDCKA,  	DLL_CKA_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+
+	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA0_RESET );
+	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+	/* Power Up */
+	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_SLEEP);
+	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+
+	DLL_CKA_Value &= ~(MDLL_RDCKA__MRDCKA1_RESET);
+	OUTPLL(pllMDLL_RDCKA,	DLL_CKA_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+
+	/* Channel B */
+
+	/* Power Up */
+	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_SLEEP );
+	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+   
+	DLL_CKO_Value &= ~(MDLL_CKO__MCKOB_RESET );
+	OUTPLL(pllMDLL_CKO,   	DLL_CKO_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+	/* Power Up */
+	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_SLEEP);
+	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+
+	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB0_RESET);
+	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+	/* Power Up */
+	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_SLEEP);
+	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	mdelay( DLL_SLEEP_DELAY);  		
+
+	DLL_CKB_Value &= ~(MDLL_RDCKB__MRDCKB1_RESET);
+	OUTPLL(pllMDLL_RDCKB,   DLL_CKB_Value);
+	mdelay( DLL_RESET_DELAY);  		
+
+#undef DLL_RESET_DELAY 
+#undef DLL_SLEEP_DELAY
+}
+
+static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
+{
+	u32 crtcGenCntl, crtcGenCntl2, memRefreshCntl, crtc_more_cntl, fp_gen_cntl, fp2_gen_cntl;
+ 
+	crtcGenCntl  = INREG( CRTC_GEN_CNTL);
+	crtcGenCntl2 = INREG( CRTC2_GEN_CNTL);
+
+	memRefreshCntl 	= INREG( MEM_REFRESH_CNTL);
+	crtc_more_cntl 	= INREG( CRTC_MORE_CNTL);
+	fp_gen_cntl 	= INREG( FP_GEN_CNTL);
+	fp2_gen_cntl 	= INREG( FP2_GEN_CNTL);
+ 
+
+	OUTREG( CRTC_MORE_CNTL, 	0);
+	OUTREG( FP_GEN_CNTL, 	0);
+	OUTREG( FP2_GEN_CNTL, 	0);
+ 
+	OUTREG( CRTC_GEN_CNTL,  (crtcGenCntl | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B) );
+	OUTREG( CRTC2_GEN_CNTL, (crtcGenCntl2 | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B) );
+  
+	/* Disable refresh */
+	OUTREG( MEM_REFRESH_CNTL, memRefreshCntl | MEM_REFRESH_CNTL__MEM_REFRESH_DIS);
+ 
+	/* Reset memory */
+	OUTREG( MEM_SDRAM_MODE_REG,
+		INREG( MEM_SDRAM_MODE_REG) & ~MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init  Not Complete
+
+	/* DLL */
+	radeon_pm_enable_dll(rinfo);
+
+	// MLCK /YCLK sync 
+	radeon_pm_yclk_mclk_sync(rinfo);
+
+	if ((rinfo->arch == RADEON_M6) || (rinfo->arch == RADEON_M7) || (rinfo->arch == RADEON_M9)) {
+		radeon_pm_program_mode_reg(rinfo, 0x2000, 1);   
+		radeon_pm_program_mode_reg(rinfo, 0x2001, 1);   
+		radeon_pm_program_mode_reg(rinfo, 0x2002, 1);   
+		radeon_pm_program_mode_reg(rinfo, 0x0132, 1);   
+		radeon_pm_program_mode_reg(rinfo, 0x0032, 1); 
+	}	
+
+	OUTREG( MEM_SDRAM_MODE_REG,
+		INREG( MEM_SDRAM_MODE_REG) |  MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE); // Init Complete
+
+	OUTREG( MEM_REFRESH_CNTL, 	memRefreshCntl);
+
+	OUTREG( CRTC_GEN_CNTL, 		crtcGenCntl);
+	OUTREG( CRTC2_GEN_CNTL, 	crtcGenCntl2);
+	OUTREG( FP_GEN_CNTL, 		fp_gen_cntl);
+	OUTREG( FP2_GEN_CNTL, 		fp2_gen_cntl);
+
+	OUTREG( CRTC_MORE_CNTL, 	crtc_more_cntl);
+
+	mdelay( 15);
+}
+
+static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
+{
+	u16 pwr_cmd;
+
+	if (!rinfo->pm_reg)
+		return;
+
+	/* Set the chip into appropriate suspend mode (we use D2,
+	 * D3 would require a compete re-initialization of the chip,
+	 * including PCI config registers, clocks, AGP conf, ...)
+	 */
+	if (suspend) {
+		/* Disable dynamic power management of clocks for the
+		 * duration of the suspend/resume process
+		 */
+		radeon_pm_disable_dynamic_mode(rinfo);
+		/* Save some registers */
+		radeon_pm_save_regs(rinfo);
+
+		/* Prepare mobility chips for suspend
+		 */
+		if (rinfo->arch == RADEON_M6 || rinfo->arch == RADEON_M7 || rinfo->arch == RADEON_M9) {
+			/* Program V2CLK */
+			radeon_pm_program_v2clk(rinfo);
+		
+			/* Disable IO PADs */
+			radeon_pm_disable_iopad(rinfo);
+
+			/* Set low current */
+			radeon_pm_low_current(rinfo);
+
+			/* Prepare chip for power management */
+			radeon_pm_setup_for_suspend(rinfo);
+
+			/* Reset the MDLL */
+			OUTPLL( pllMDLL_CKO, INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
+		}
+
+		/* Switch PCI power managment to D2. */
+		for (;;) {
+			pci_read_config_word(
+				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
+				&pwr_cmd);
+			if (pwr_cmd & 2)
+				break;			
+			pci_write_config_word(
+				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
+				(pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | 2);
+			mdelay(500);
+		}
+	} else {
+		/* Switch back PCI powermanagment to D0 */
+		mdelay(200);
+		pci_write_config_word(rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL, 0);
+		mdelay(500);
+
+		/* Reset the SDRAM controller */
+		if (rinfo->arch == RADEON_M6 || rinfo->arch == RADEON_M7 || rinfo->arch == RADEON_M9)
+			radeon_pm_full_reset_sdram(rinfo);
+		
+		/* Restore some registers */
+		radeon_pm_restore_regs(rinfo);
+		radeon_pm_enable_dynamic_mode(rinfo);
+	}
+}
+
+int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+
+	/* We don't do anything but D2, for now we return 0, but
+	 * we may want to change that. How do we know if the BIOS
+	 * can properly take care of D3 ? Also, with swsusp, we
+	 * know we'll be rebooted, ...
+	 */
+#ifdef CONFIG_PPC_PMAC
+	/* HACK ALERT ! Once I find a proper way to say to each driver
+	 * individually what will happen with it's PCI slot, I'll change
+	 * that. On laptops, the AGP slot is just unclocked, so D2 is
+	 * expected, while on desktops, the card is powered off
+	 */
+	if (state >= 3)
+		state = 2;
+#endif /* CONFIG_PPC_PMAC */
+	 
+	if (state != 2 || state == pdev->dev.power_state)
+		return 0;
+
+	printk(KERN_DEBUG "radeonfb: suspending...\n");
+	
+	acquire_console_sem();
+
+	fb_set_suspend(&rinfo->info, 1);
+
+	/* Setup dummy fb raster ops */
+	rinfo->info.fbops->fb_fillrect 	= fb_dummy_fillrect;
+	rinfo->info.fbops->fb_copyarea 	= fb_dummy_copyarea;
+	rinfo->info.fbops->fb_imageblit	= fb_dummy_imageblit;
+	rinfo->info.fbops->fb_cursor   	= fb_dummy_cursor;
+
+	if (!radeon_accel_disabled()) {
+		/* Make sure engine is reset */
+		radeon_engine_idle();
+		radeon_engine_reset();
+		radeon_engine_idle();
+	}
+
+	/* Blank display and LCD */
+	radeonfb_blank(VESA_POWERDOWN+1, (struct fb_info *)rinfo);
+
+	/* Sleep */
+	rinfo->asleep = 1;
+	rinfo->lock_blank = 1;
+
+	/* We need a way to make sure the fbdev layer will _not_ touch the
+	 * framebuffer before we put the chip to suspend state. On 2.4, I
+	 * used dummy fb ops, 2.5 need proper support for this at the
+	 * fbdev level
+	 */
+	if (state == 2)
+		radeon_set_suspend(rinfo, 1);
+
+	release_console_sem();
+
+	pdev->dev.power_state = state;
+
+	return 0;
+}
+
+int radeonfb_pci_resume(struct pci_dev *pdev)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+
+	if (pdev->dev.power_state == 0)
+		return 0;
+
+	acquire_console_sem();
+
+	/* Wakeup chip */
+	if (pdev->dev.power_state == 2)
+		radeon_set_suspend(rinfo, 0);
+	rinfo->asleep = 0;
+
+	/* Restore display & engine */
+	radeonfb_set_par(&rinfo->info);
+	fb_pan_display(&rinfo->info, &rinfo->info.var);
+	fb_set_cmap(&rinfo->info.cmap, 1, &rinfo->info);
+
+	/* Restore fb raster ops */
+	rinfo->info.fbops->fb_fillrect	= cfb_fillrect;
+	rinfo->info.fbops->fb_copyarea	= cfb_copyarea;
+	rinfo->info.fbops->fb_imageblit = cfb_imageblit;
+	rinfo->info.fbops->fb_cursor   	= soft_cursor;
+
+	/* Refresh */
+	fb_set_suspend(&rinfo->info, 0);
+
+	/* Unblank */
+	rinfo->lock_blank = 0;
+	radeonfb_blank(0, (struct fb_info *)rinfo);
+
+	release_console_sem();
+
+	pdev->dev.power_state = 0;
+
+	printk(KERN_DEBUG "radeonfb: resumed !\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
diff -urN linux-2.5-mesa/drivers/video/aty/radeonfb.h linuxppc-2.5-benh/drivers/video/aty/radeonfb.h
--- linux-2.5-mesa/drivers/video/aty/radeonfb.h	Thu Jan 01 01:00:00 1970
+++ linuxppc-2.5-benh/drivers/video/aty/radeonfb.h	Sun Sep 07 17:32:14 2003
@@ -0,0 +1,420 @@
+#ifndef __RADEONFB_H__
+#define __RADEONFB_H__
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+#include <video/radeon.h>
+
+
+enum radeon_arch {
+	RADEON_R100,
+	RADEON_RV100,
+	RADEON_R200,
+	RADEON_RV200,
+	RADEON_RV250,
+	RADEON_RV280,
+	RADEON_R300,
+	RADEON_RS300,
+	RADEON_R350,
+	RADEON_M6,
+	RADEON_M7,
+	RADEON_M9,
+	RADEON_R200_SEC,
+	RADEON_RV250_SEC,
+	RADEON_R300_SEC,
+	RADEON_R350_SEC,
+	RADEON_M9_SEC,
+};
+
+enum radeon_montype
+{
+	MT_NONE = 0,
+	MT_CRT,		/* CRT */
+	MT_LCD,		/* LCD */
+	MT_DFP,		/* DVI */
+	MT_CTV,		/* composite TV */
+	MT_STV		/* S-Video out */
+};
+
+
+typedef struct {
+        u8 clock_chip_type;
+        u8 struct_size;
+        u8 accelerator_entry;
+        u8 VGA_entry;
+        u16 VGA_table_offset;
+        u16 POST_table_offset;
+        u16 XCLK;
+        u16 MCLK;
+        u8 num_PLL_blocks;
+        u8 size_PLL_blocks;
+        u16 PCLK_ref_freq;
+        u16 PCLK_ref_divider;
+        u32 PCLK_min_freq;
+        u32 PCLK_max_freq;
+        u16 MCLK_ref_freq;
+        u16 MCLK_ref_divider;
+        u32 MCLK_min_freq;
+        u32 MCLK_max_freq;
+        u16 XCLK_ref_freq;
+        u16 XCLK_ref_divider;
+        u32 XCLK_min_freq;
+        u32 XCLK_max_freq;
+} __attribute__ ((packed)) PLL_BLOCK;
+
+
+struct pll_info {
+	int ppll_max;
+	int ppll_min;
+	int xclk;
+	int ref_div;
+	int ref_clk;
+};
+
+
+struct ram_info {
+	int ml;
+	int mb;
+	int trcd;
+	int trp;
+	int twr;
+	int cl;
+	int tr2w;
+	int loop_latency;
+	int rloop;
+};
+
+
+struct radeon_regs {
+	/* CRTC regs */
+	u32 crtc_h_total_disp;
+	u32 crtc_h_sync_strt_wid;
+	u32 crtc_v_total_disp;
+	u32 crtc_v_sync_strt_wid;
+	u32 crtc_pitch;
+	u32 crtc_gen_cntl;
+	u32 crtc_ext_cntl;
+	u32 crtc_more_cntl;
+	u32 dac_cntl;
+
+	u32 flags;
+	u32 pix_clock;
+	int xres, yres;
+
+	/* PLL regs */
+	u32 ppll_div_3;
+	u32 ppll_ref_div;
+	u32 vclk_ecp_cntl;
+	
+	/* Flat panel regs */
+	u32 fp_crtc_h_total_disp;
+	u32 fp_crtc_v_total_disp;
+	u32 fp_gen_cntl;
+	u32 fp_h_sync_strt_wid;
+	u32 fp_horz_stretch;
+	u32 fp_panel_cntl;
+	u32 fp_v_sync_strt_wid;
+	u32 fp_vert_stretch;
+	u32 lvds_gen_cntl;
+	u32 lvds_pll_cntl;
+	u32 tmds_crc;
+	u32 tmds_transmitter_cntl;
+
+	/* Aperture access control */
+	u32 surface_cntl;
+};
+
+struct panel_info {
+	int xres, yres;
+	int valid;
+	int clock;
+	int hOver_plus, hSync_width, hblank;
+	int vOver_plus, vSync_width, vblank;
+	int hAct_high, vAct_high, interlaced;
+	int pwr_delay;
+	int use_bios_dividers;
+	int ref_divider;
+	int post_divider;
+	int fbk_divider;
+};
+
+struct radeonfb_info;
+
+enum ddc_type {
+	ddc_none,
+	ddc_monid,
+	ddc_dvi,
+	ddc_vga,
+	ddc_crt2,
+};
+
+#ifdef CONFIG_FB_RADEON_I2C
+struct radeon_i2c_chan {
+	struct radeonfb_info		*rinfo;
+	u32		 		ddc_reg;
+	struct i2c_adapter		adapter;
+	struct i2c_algo_bit_data	algo;
+};
+#endif
+
+struct radeonfb_info {
+	struct fb_info 		info;
+
+	struct radeon_regs 	state;
+	struct radeon_regs	init_state;
+
+	char			name[DEVICE_NAME_SIZE];
+	char			ram_type[12];
+
+	unsigned long		mmio_base_phys;
+	unsigned long		fb_base_phys;
+
+	unsigned long		mmio_base;
+	unsigned long		fb_base;
+
+	unsigned long 		fb_local_base;
+
+	struct pci_dev		*pdev;
+
+	u8			*bios_seg;
+	int			fp_bios_start;
+
+	u32			pseudo_palette[17];
+	struct { u8 red, green, blue, pad; }
+				palette[256];
+
+	int			chipset;
+	u8			arch;
+	u8			rev;
+	unsigned long		video_ram;
+
+	int			pitch, bpp, depth;
+	int			xres, yres, pixclock;
+	int			xres_virtual, yres_virtual;
+	u32			accel_flags;
+
+	// KILL THOSE
+	int use_default_var;
+	int got_dfpinfo;
+
+	int			has_CRTC2 : 1;
+	int			is_mobility : 1;
+	int			reversed_DAC : 1;
+	int			reversed_TMDS : 1;
+	struct panel_info	panel_info;
+	int			mon1_type;
+	u8			*mon1_EDID;
+	struct fb_videomode	*mon1_modedb;
+	int			mon1_dbsize;
+	int			mon2_type;
+	u8		        *mon2_EDID;
+
+	u32			dp_gui_master_cntl;
+
+	struct pll_info		pll;
+	int			pll_output_freq, post_div, fb_div;
+
+	struct ram_info		ram;
+
+	int			mtrr_hdl;
+
+	int			pm_reg;
+	u32			save_regs[64];
+	int			asleep;
+	int			lock_blank;
+
+#ifdef CONFIG_FB_RADEON_I2C
+	struct radeon_i2c_chan 	i2c[4];
+#endif
+	
+	struct radeonfb_info *next;
+};
+
+
+#define PRIMARY_MONITOR(rinfo)	(rinfo->mon1_type)
+
+
+/*
+ * Debugging stuffs
+ */
+#define DEBUG		1
+
+#if DEBUG
+#define RTRACE		printk
+#else
+#define RTRACE		if(0) printk
+#endif
+
+
+/*
+ * IO macros
+ */
+
+#define INREG8(addr)		readb((rinfo->mmio_base)+addr)
+#define OUTREG8(addr,val)	writeb(val, (rinfo->mmio_base)+addr)
+#define INREG(addr)		readl((rinfo->mmio_base)+addr)
+#define OUTREG(addr,val)	writel(val, (rinfo->mmio_base)+addr)
+
+#define OUTPLL(addr,val)	\
+	do {	\
+		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
+		OUTREG(CLOCK_CNTL_DATA, val); \
+	} while(0)
+
+#define OUTPLLP(addr,val,mask)  					\
+	do {								\
+		unsigned int _tmp = INPLL(addr);			\
+		_tmp &= (mask);						\
+		_tmp |= (val);						\
+		OUTPLL(addr, _tmp);					\
+	} while (0)
+
+#define OUTREGP(addr,val,mask)  					\
+	do {								\
+		unsigned int _tmp = INREG(addr);			\
+		_tmp &= (mask);						\
+		_tmp |= (val);						\
+		OUTREG(addr, _tmp);					\
+	} while (0)
+
+
+static __inline__ u32 _INPLL(struct radeonfb_info *rinfo, u32 addr)
+{
+	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
+	return (INREG(CLOCK_CNTL_DATA));
+}
+
+#define INPLL(addr)		_INPLL(rinfo, addr)
+
+#define BIOS_IN8(v)  	(readb(rinfo->bios_seg + (v)))
+#define BIOS_IN16(v) 	(readb(rinfo->bios_seg + (v)) | \
+			  (readb(rinfo->bios_seg + (v) + 1) << 8))
+#define BIOS_IN32(v) 	(readb(rinfo->bios_seg + (v)) | \
+			  (readb(rinfo->bios_seg + (v) + 1) << 8) | \
+			  (readb(rinfo->bios_seg + (v) + 2) << 16) | \
+			  (readb(rinfo->bios_seg + (v) + 3) << 24))
+
+/*
+ * Inline utilities
+ */
+
+static inline void wait_ms(unsigned long ms)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout((ms * HZ + 999) / 1000);
+}
+
+
+
+static inline int round_div(int num, int den)
+{
+        return (num + (den / 2)) / den;
+}
+
+static inline int var_to_depth(const struct fb_var_screeninfo *var)
+{
+	if (var->bits_per_pixel != 16)
+		return var->bits_per_pixel;
+	return (var->green.length == 6) ? 16 : 15;
+}
+
+static inline u32 radeon_get_dstbpp(u16 depth)
+{
+	switch (depth) {
+       	case 8:
+       		return DST_8BPP;
+       	case 15:
+       		return DST_15BPP;
+       	case 16:
+       		return DST_16BPP;
+       	case 32:
+       		return DST_32BPP;
+       	default:
+       		return 0;
+	}
+}
+
+/*
+ * 2D Engine helper routines
+ */
+static inline void radeon_engine_flush (struct radeonfb_info *rinfo)
+{
+	int i;
+
+	/* initiate flush */
+	OUTREGP(RB2D_DSTCACHE_CTLSTAT, RB2D_DC_FLUSH_ALL,
+	        ~RB2D_DC_FLUSH_ALL);
+
+	for (i=0; i < 2000000; i++) {
+		if (!(INREG(RB2D_DSTCACHE_CTLSTAT) & RB2D_DC_BUSY))
+			break;
+	}
+}
+
+
+static inline void _radeon_fifo_wait (struct radeonfb_info *rinfo, int entries)
+{
+	int i;
+
+	for (i=0; i<2000000; i++)
+		if ((INREG(RBBM_STATUS) & 0x7f) >= entries)
+			return;
+}
+
+
+static inline void _radeon_engine_idle (struct radeonfb_info *rinfo)
+{
+	int i;
+
+	/* ensure FIFO is empty before waiting for idle */
+	_radeon_fifo_wait (rinfo, 64);
+
+	for (i=0; i<2000000; i++) {
+		if (((INREG(RBBM_STATUS) & GUI_ACTIVE)) == 0) {
+			radeon_engine_flush (rinfo);
+			return;
+		}
+	}
+}
+
+#define radeon_engine_idle()		_radeon_engine_idle(rinfo)
+#define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
+
+
+/* I2C Functions */
+extern void radeon_create_i2c_busses(struct radeonfb_info *rinfo);
+extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
+extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
+
+/* PM Functions */
+extern void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo);
+extern void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo);
+extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
+extern int radeonfb_pci_resume(struct pci_dev *pdev);
+
+/* Monitor probe functions */
+extern void radeon_probe_screens(struct radeonfb_info *rinfo,
+				 const char *monitor_layout, int ignore_edid);
+extern void radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option);
+
+/* Other functions */
+#define radeon_engine_reset()		_radeon_engine_reset(rinfo)
+extern void _radeon_engine_reset(struct radeonfb_info *rinfo);
+extern int radeonfb_blank(int blank, struct fb_info *info);
+extern int radeonfb_set_par(struct fb_info *info);
+extern int radeon_accel_disabled(void);
+
+#endif /* __RADEONFB_H__ */
diff -urN linux-2.5-mesa/include/linux/pci_ids.h linuxppc-2.5-benh/include/linux/pci_ids.h
--- linux-2.5-mesa/include/linux/pci_ids.h	2003-09-07 18:25:48.000000000 +0200
+++ linuxppc-2.5-benh/include/linux/pci_ids.h	2003-09-07 15:59:07.000000000 +0200
@@ -182,21 +182,8 @@
 #define PCI_DEVICE_ID_LSI_63C815	0x1000
 
 #define PCI_VENDOR_ID_ATI		0x1002
-/* Radeon */
-#define PCI_DEVICE_ID_ATI_RADEON_A6	0x4136
-#define PCI_DEVICE_ID_ATI_RADEON_A7	0x4137
-#define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144
-#define PCI_DEVICE_ID_ATI_RADEON_AE	0x4145
-#define PCI_DEVICE_ID_ATI_RADEON_AF	0x4146
-#define PCI_DEVICE_ID_ATI_RADEON_AG	0x4147
-#define PCI_DEVICE_ID_ATI_68800		0x4158
-#define PCI_DEVICE_ID_ATI_RADEON_Ad	0x4164
-#define PCI_DEVICE_ID_ATI_RADEON_B7	0x4237
-#define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
-#define PCI_DEVICE_ID_ATI_RADEON_C6	0x4336
-#define PCI_DEVICE_ID_ATI_RADEON_C7	0x4337
-#define PCI_DEVICE_ID_ATI_RADEON_D7	0x4337
 /* Mach64 */
+#define PCI_DEVICE_ID_ATI_68800		0x4158
 #define PCI_DEVICE_ID_ATI_215CT222	0x4354
 #define PCI_DEVICE_ID_ATI_210888CX	0x4358
 #define PCI_DEVICE_ID_ATI_215ET222	0x4554
@@ -213,13 +200,6 @@
 #define PCI_DEVICE_ID_ATI_215_IW	0x4757
 #define PCI_DEVICE_ID_ATI_215_IZ	0x475A
 #define PCI_DEVICE_ID_ATI_210888GX	0x4758
-/* Radeon RV250 (9000) */
-#define PCI_DEVICE_ID_ATI_RADEON_Id	0x4964
-#define PCI_DEVICE_ID_ATI_RADEON_Ie	0x4965
-#define PCI_DEVICE_ID_ATI_RADEON_If	0x4966
-#define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
-#define PCI_DEVICE_ID_ATI_RADEON_In	0x496e
-/* Mach64 / Rage */
 #define PCI_DEVICE_ID_ATI_215_LB	0x4c42
 #define PCI_DEVICE_ID_ATI_215_LD	0x4c44
 #define PCI_DEVICE_ID_ATI_215_LG	0x4c47
@@ -229,40 +209,35 @@
 #define PCI_DEVICE_ID_ATI_215_LR	0x4c52
 #define PCI_DEVICE_ID_ATI_215_LS	0x4c53
 #define PCI_DEVICE_ID_ATI_264_LT	0x4c54
-/* Radeon M7 */
-#define PCI_DEVICE_ID_ATI_RADEON_LW	0x4c57
-#define PCI_DEVICE_ID_ATI_RADEON_LX	0x4c58
-/* Radeon M6 */
-#define PCI_DEVICE_ID_ATI_RADEON_LY	0x4c59
-#define PCI_DEVICE_ID_ATI_RADEON_LZ	0x4c5a
-#define PCI_DEVICE_ID_ATI_RADEON_Ld	0x4c64
-#define PCI_DEVICE_ID_ATI_RADEON_Le	0x4c65
-#define PCI_DEVICE_ID_ATI_RADEON_Lf	0x4c66
-#define PCI_DEVICE_ID_ATI_RADEON_Lg	0x4c67
-#define PCI_DEVICE_ID_ATI_RADEON_Ln	0x4c6e
+/* Mach64 VT */
+#define PCI_DEVICE_ID_ATI_264VT		0x5654
+#define PCI_DEVICE_ID_ATI_264VU		0x5655
+#define PCI_DEVICE_ID_ATI_264VV		0x5656
+/* Rage128 GL */
+#define PCI_DEVICE_ID_ATI_RAGE128_RE	0x5245
+#define PCI_DEVICE_ID_ATI_RAGE128_RF	0x5246
+#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x534b
+#define PCI_DEVICE_ID_ATI_RAGE128_RH	0x534c
+#define PCI_DEVICE_ID_ATI_RAGE128_RI	0x534d
+/* Rage128 VR */
+#define PCI_DEVICE_ID_ATI_RAGE128_RK	0x524b
+#define PCI_DEVICE_ID_ATI_RAGE128_RL	0x524c
+#define PCI_DEVICE_ID_ATI_RAGE128_RM	0x5345
+#define PCI_DEVICE_ID_ATI_RAGE128_RN	0x5346
+#define PCI_DEVICE_ID_ATI_RAGE128_RO	0x5347
 /* Rage128 M3 */
 #define PCI_DEVICE_ID_ATI_RAGE128_LE	0x4c45
 #define PCI_DEVICE_ID_ATI_RAGE128_LF	0x4c46
-/* Rage128 M4 */
-#define PCI_DEVICE_ID_ATI_RAGE128_MF	0x4d46
-#define PCI_DEVICE_ID_ATI_RAGE128_ML	0x4d4c
-/* Radeon R300 (9700) */
-#define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
-#define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45
-#define PCI_DEVICE_ID_ATI_RADEON_NF	0x4e46
-#define PCI_DEVICE_ID_ATI_RADEON_NG	0x4e47
-#define PCI_DEVICE_ID_ATI_RADEON_NH	0x4e48
-#define PCI_DEVICE_ID_ATI_RADEON_Nd	0x4e64
-#define PCI_DEVICE_ID_ATI_RADEON_Ne	0x4e65
-#define PCI_DEVICE_ID_ATI_RADEON_Nf	0x4e66
-#define PCI_DEVICE_ID_ATI_RADEON_Ng	0x4e67
-#define PCI_DEVICE_ID_ATI_RADEON_Nh	0x4e68
+/* Rage128 Pro Ultra */
+#define PCI_DEVICE_ID_ATI_RAGE128_U1	0x5446
+#define PCI_DEVICE_ID_ATI_RAGE128_U2	0x544C
+#define PCI_DEVICE_ID_ATI_RAGE128_U3	0x5452
 /* Rage128 Pro GL */
-#define PCI_DEVICE_ID_ATI_RAGE128_PA	0x5041
-#define PCI_DEVICE_ID_ATI_RAGE128_PB	0x5042
-#define PCI_DEVICE_ID_ATI_RAGE128_PC	0x5043
-#define PCI_DEVICE_ID_ATI_RAGE128_PD	0x5044
-#define PCI_DEVICE_ID_ATI_RAGE128_PE	0x5045
+#define PCI_DEVICE_ID_ATI_Rage128_PA	0x5041
+#define PCI_DEVICE_ID_ATI_Rage128_PB	0x5042
+#define PCI_DEVICE_ID_ATI_Rage128_PC	0x5043
+#define PCI_DEVICE_ID_ATI_Rage128_PD	0x5044
+#define PCI_DEVICE_ID_ATI_Rage128_PE	0x5045
 #define PCI_DEVICE_ID_ATI_RAGE128_PF	0x5046
 /* Rage128 Pro VR */
 #define PCI_DEVICE_ID_ATI_RAGE128_PG	0x5047
@@ -296,49 +271,59 @@
 #define PCI_DEVICE_ID_ATI_RADEON_QI	0x5149
 #define PCI_DEVICE_ID_ATI_RADEON_QJ	0x514a
 #define PCI_DEVICE_ID_ATI_RADEON_QK	0x514b
+/* Radeon RV100 (VE) */
+#define PCI_DEVICE_ID_ATI_RADEON_QY	0x5159
+#define PCI_DEVICE_ID_ATI_RADEON_QZ	0x515a
+#define PCI_DEVICE_ID_ATI_RADEON_Qh	0x5168
+#define PCI_DEVICE_ID_ATI_RADEON_Qi	0x5169
+#define PCI_DEVICE_ID_ATI_RADEON_Qj	0x516a
+#define PCI_DEVICE_ID_ATI_RADEON_Qk	0x516b
+#define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
 /* Radeon R200 (8500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QL	0x514c
-#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d
 #define PCI_DEVICE_ID_ATI_RADEON_QN	0x514e
 #define PCI_DEVICE_ID_ATI_RADEON_QO	0x514f
+#define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
+#define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
+/* Radeon R200 (9100) */
+#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d
 /* Radeon RV200 (7500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QW	0x5157
 #define PCI_DEVICE_ID_ATI_RADEON_QX	0x5158
+/* Radeon NV-100 */
+#define PCI_DEVICE_ID_ATI_RADEON_N1	0x5159
+#define PCI_DEVICE_ID_ATI_RADEON_N2	0x515a
+/* Radeon RV250 (9000) */
+#define PCI_DEVICE_ID_ATI_RADEON_Id	0x4964
+#define PCI_DEVICE_ID_ATI_RADEON_Ie	0x4965
+#define PCI_DEVICE_ID_ATI_RADEON_If	0x4966
+#define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
+#define PCI_DEVICE_ID_ATI_RADEON_In	0x496e
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
-/* Radeon RV100 (VE) */
-#define PCI_DEVICE_ID_ATI_RADEON_QY	0x5159
-#define PCI_DEVICE_ID_ATI_RADEON_QZ	0x515a
-#define PCI_DEVICE_ID_ATI_RADEON_Qh	0x5168
-#define PCI_DEVICE_ID_ATI_RADEON_Qi	0x5169
-#define PCI_DEVICE_ID_ATI_RADEON_Qj	0x516a
-#define PCI_DEVICE_ID_ATI_RADEON_Qk	0x516b
-#define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
-/* Rage128 VR */
-#define PCI_DEVICE_ID_ATI_RAGE128_RE	0x5245
-#define PCI_DEVICE_ID_ATI_RAGE128_RF	0x5246
-#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x5247
-#define PCI_DEVICE_ID_ATI_RAGE128_RK	0x524b
-#define PCI_DEVICE_ID_ATI_RAGE128_RL	0x524c
-#define PCI_DEVICE_ID_ATI_RAGE128_SE	0x5345
-#define PCI_DEVICE_ID_ATI_RAGE128_SF	0x5346
-#define PCI_DEVICE_ID_ATI_RAGE128_SG	0x5347
-#define PCI_DEVICE_ID_ATI_RAGE128_SH	0x5348
-#define PCI_DEVICE_ID_ATI_RAGE128_SK	0x534b
-#define PCI_DEVICE_ID_ATI_RAGE128_SL	0x534c
-#define PCI_DEVICE_ID_ATI_RAGE128_SM	0x534d
-#define PCI_DEVICE_ID_ATI_RAGE128_SN	0x534e
-/* Rage128 Pro Ultra */
-#define PCI_DEVICE_ID_ATI_RAGE128_TF	0x5446
-#define PCI_DEVICE_ID_ATI_RAGE128_TL	0x544C
-#define PCI_DEVICE_ID_ATI_RAGE128_TR	0x5452
-#define PCI_DEVICE_ID_ATI_RAGE128_TS	0x5453
-#define PCI_DEVICE_ID_ATI_RAGE128_TT	0x5454
-#define PCI_DEVICE_ID_ATI_RAGE128_TU	0x5455
-/* Mach64 VT */
-#define PCI_DEVICE_ID_ATI_264VT		0x5654
-#define PCI_DEVICE_ID_ATI_264VU		0x5655
-#define PCI_DEIVCE_ID_ATI_264VV		0x5656
+/* Radeon R300 (9500) */
+#define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144
+/* Radeon R300 (9700) */
+#define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
+#define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45
+#define PCI_DEVICE_ID_ATI_RADEON_NF	0x4e46
+#define PCI_DEVICE_ID_ATI_RADEON_NG	0x4e47
+#define PCI_DEVICE_ID_ATI_RADEON_Nd	0x4e64
+#define PCI_DEVICE_ID_ATI_RADEON_Ne	0x4e65
+#define PCI_DEVICE_ID_ATI_RADEON_Nf	0x4e66
+#define PCI_DEVICE_ID_ATI_RADEON_Ng	0x4e67
+#define PCI_DEVICE_ID_ATI_RADEON_A6	0x4136
+#define PCI_DEVICE_ID_ATI_RADEON_A7	0x4137
+#define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144
+#define PCI_DEVICE_ID_ATI_RADEON_AE	0x4145
+#define PCI_DEVICE_ID_ATI_RADEON_AF	0x4146
+#define PCI_DEVICE_ID_ATI_RADEON_AG	0x4147
+#define PCI_DEVICE_ID_ATI_RADEON_Ad	0x4164
+#define PCI_DEVICE_ID_ATI_RADEON_B7	0x4237
+#define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
+#define PCI_DEVICE_ID_ATI_RADEON_C6	0x4336
+#define PCI_DEVICE_ID_ATI_RADEON_C7	0x4337
+#define PCI_DEVICE_ID_ATI_RADEON_D7	0x4337
 /* Radeon RS300 */
 #define PCI_DEVICE_ID_ATI_RADEON_X0	0x5830
 #define PCI_DEVICE_ID_ATI_RADEON_X1	0x5831
@@ -348,6 +333,31 @@
 #define PCI_DEVICE_ID_ATI_RADEON_X5	0x5835
 #define PCI_DEVICE_ID_ATI_RADEON_X6	0x5836
 #define PCI_DEVICE_ID_ATI_RADEON_X7	0x5837
+/* Radeon R350 (9800) */
+#define PCI_DEVICE_ID_ATI_RADEON_NH	0x4e48
+#define PCI_DEVICE_ID_ATI_RADEON_Nh	0x4e68
+#define PCI_DEVICE_ID_ATI_RADEON_NI	0x4e49
+#define PCI_DEVICE_ID_ATI_RADEON_Ni	0x4e69
+/* Radeon RV350 (9600) */
+#define PCI_DEVICE_ID_ATI_RADEON_AP	0x4150
+#define PCI_DEVICE_ID_ATI_RADEON_AR	0x4152
+/* Radeon M6 */
+#define PCI_DEVICE_ID_ATI_RADEON_LY	0x4c59
+#define PCI_DEVICE_ID_ATI_RADEON_LZ	0x4c5a
+/* Radeon M7 */
+#define PCI_DEVICE_ID_ATI_RADEON_LW	0x4c57
+#define PCI_DEVICE_ID_ATI_RADEON_LX	0x4c58
+/* Radeon M9 */
+#define PCI_DEVICE_ID_ATI_RADEON_Ld	0x4c64
+#define PCI_DEVICE_ID_ATI_RADEON_Le	0x4c65
+#define PCI_DEVICE_ID_ATI_RADEON_Lf	0x4c66
+#define PCI_DEVICE_ID_ATI_RADEON_Lg	0x4c67
+#define PCI_DEVICE_ID_ATI_RADEON_Ln	0x4c6e
+/* Radeon */
+#define PCI_DEVICE_ID_ATI_RADEON_RA	0x5144
+#define PCI_DEVICE_ID_ATI_RADEON_RB	0x5145
+#define PCI_DEVICE_ID_ATI_RADEON_RC	0x5146
+#define PCI_DEVICE_ID_ATI_RADEON_RD	0x5147
 /* RadeonIGP */
 #define PCI_DEVICE_ID_ATI_RS100		0xcab0
 #define PCI_DEVICE_ID_ATI_RS200		0xcab2
@@ -724,6 +734,7 @@
 #define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
 #define PCI_DEVICE_ID_TI_1520		0xac55
+#define PCI_DEVICE_ID_TI_1510		0xac56
 
 #define PCI_VENDOR_ID_SONY		0x104d
 #define PCI_DEVICE_ID_SONY_CXD3222	0x8039
diff -urN linux-2.5-mesa/include/video/radeon.h linuxppc-2.5-benh/include/video/radeon.h
--- linux-2.5-mesa/include/video/radeon.h	2003-09-07 18:25:51.000000000 +0200
+++ linuxppc-2.5-benh/include/video/radeon.h	2003-09-07 17:13:53.000000000 +0200
@@ -365,6 +365,8 @@
 #define DSTCACHE_CTLSTAT                       0x1714  
 #define DEFAULT_PITCH_OFFSET                   0x16E0  
 #define DEFAULT_SC_BOTTOM_RIGHT                0x16E8  
+#define SRC_PITCH_OFFSET                       0x1428
+#define DST_PITCH_OFFSET                       0x142C
 #define DP_GUI_MASTER_CNTL                     0x146C  
 #define SC_TOP_LEFT                            0x16EC  
 #define SC_BOTTOM_RIGHT                        0x16F0  
@@ -373,18 +375,23 @@
 #define RB2D_DSTCACHE_CTLSTAT		       0x342C
 #define LVDS_GEN_CNTL			       0x02d0
 #define LVDS_PLL_CNTL			       0x02d4
+#define FP2_GEN_CNTL                           0x0288
+#define TMDS_CNTL                              0x0294
 #define TMDS_CRC			       0x02a0
 #define TMDS_TRANSMITTER_CNTL		       0x02a4
+#define MPP_TB_CONFIG            	       0x01c0
 
-#define RADEON_BASE_CODE		       0x0f0b
-#define RADEON_BIOS_0_SCRATCH		       0x0010
-#define RADEON_BIOS_1_SCRATCH		       0x0014
-#define RADEON_BIOS_2_SCRATCH		       0x0018
-#define RADEON_BIOS_3_SCRATCH		       0x001c
-#define RADEON_BIOS_4_SCRATCH		       0x0020
-#define RADEON_BIOS_5_SCRATCH		       0x0024
-#define RADEON_BIOS_6_SCRATCH		       0x0028
-#define RADEON_BIOS_7_SCRATCH		       0x002c
+//#define BASE_CODE			       0x0f0b
+#define BIOS_0_SCRATCH			       0x0010
+#define BIOS_1_SCRATCH			       0x0014
+#define BIOS_2_SCRATCH			       0x0018
+#define BIOS_3_SCRATCH			       0x001c
+#define BIOS_4_SCRATCH			       0x0020
+#define BIOS_5_SCRATCH			       0x0024
+#define BIOS_6_SCRATCH			       0x0028
+#define BIOS_7_SCRATCH			       0x002c
+
+#define HDP_SOFT_RESET                         (1 << 26)
 
 #define TV_DAC_CNTL                            0x088c
 #define GPIOPAD_MASK                           0x0198
@@ -484,6 +491,7 @@
 #define CRTC_DBL_SCAN_EN                           0x00000001
 #define CRTC_CUR_EN                                0x00010000
 #define CRTC_INTERLACE_EN			   (1 << 1)
+#define CRTC_BYPASS_LUT_EN     			   (1 << 14)
 #define CRTC_EXT_DISP_EN      			   (1 << 24)
 #define CRTC_EN					   (1 << 25)
 #define CRTC_DISP_REQ_EN_B                         (1 << 26)
@@ -500,6 +508,22 @@
 /* CUR_OFFSET, CUR_HORZ_VERT_POSN, CUR_HORZ_VERT_OFF bit constants */
 #define CUR_LOCK                                   0x80000000
 
+/* GPIO bit constants */
+#define GPIO_A_0		(1 <<  0)
+#define GPIO_A_1		(1 <<  1)
+#define GPIO_Y_0		(1 <<  8)
+#define GPIO_Y_1		(1 <<  9)
+#define GPIO_EN_0		(1 << 16)
+#define GPIO_EN_1		(1 << 17)
+#define GPIO_MASK_0		(1 << 24)
+#define GPIO_MASK_1		(1 << 25)
+#define VGA_DDC_DATA_OUTPUT	GPIO_A_0
+#define VGA_DDC_CLK_OUTPUT	GPIO_A_1
+#define VGA_DDC_DATA_INPUT	GPIO_Y_0
+#define VGA_DDC_CLK_INPUT	GPIO_Y_1
+#define VGA_DDC_DATA_OUT_EN	GPIO_EN_0
+#define VGA_DDC_CLK_OUT_EN	GPIO_EN_1
+
 
 /* FP bit constants */
 #define FP_CRTC_H_TOTAL_MASK			   0x000003ff
@@ -560,7 +584,7 @@
 #define TMDS_PLL_EN				   (1 << 0)
 #define TMDS_PLLRST				   (1 << 1)
 #define TMDS_RAN_PAT_RST			   (1 << 7)
-#define ICHCSEL					   (1 << 28)
+#define TMDS_ICHCSEL				   (1 << 28)
 
 /* FP_HORZ_STRETCH bit constants */
 #define HORZ_STRETCH_RATIO_MASK			   0xffff
@@ -592,14 +616,25 @@
 #define DAC_4BPP_PIX_ORDER                         0x00000200
 #define DAC_CRC_EN                                 0x00080000
 #define DAC_MASK_ALL				   (0xff << 24)
+#define DAC_PDWN                                   (1 << 15)
 #define DAC_EXPAND_MODE				   (1 << 14)
 #define DAC_VGA_ADR_EN				   (1 << 13)
-#define DAC_RANGE_CNTL				   (3 << 0)
-#define DAC_BLANKING				   (1 << 2)
-#define DAC_CMP_EN                                 (1 << 3)
+#define DAC_RANGE_CNTL				   (3 <<  0)
+#define DAC_RANGE_CNTL_MASK    			   0x03
+#define DAC_BLANKING				   (1 <<  2)
+#define DAC_CMP_EN                                 (1 <<  3)
+#define DAC_CMP_OUTPUT                             (1 <<  7)
 
 /* DAC_CNTL2 bit constants */   
 #define DAC2_CMP_EN                                (1 << 7)
+#define DAC2_PALETTE_ACCESS_CNTL                   (1 << 5)
+
+/* DAC_EXT_CNTL bit constants */
+#define DAC_FORCE_BLANK_OFF_EN                     (1 << 4)
+#define DAC_FORCE_DATA_EN                          (1 << 5)
+#define DAC_FORCE_DATA_SEL_MASK                    (3 << 6)
+#define DAC_FORCE_DATA_MASK                        0x0003ff00
+#define DAC_FORCE_DATA_SHIFT                       8
 
 /* GEN_RESET_CNTL bit constants */
 #define SOFT_RESET_GUI                             0x00000001
@@ -872,16 +907,994 @@
 
 #define GUI_ACTIVE			0x80000000
 
-/* DDC */
-#define RADEON_VGA_DDC_DATA_OUTPUT	0x00000001
-#define RADEON_VGA_DDC_CLK_OUTPUT	0x00000002
-#define RADEON_VGA_DDC_DATA_INPUT	0x00000100
-#define RADEON_VGA_DDC_CLK_INPUT	0x00000200
-#define RADEON_VGA_DDC_DATA_OUT_EN	0x00010000
-#define RADEON_VGA_DDC_CLK_OUT_EN	0x00020000
 
-/* used by ATI bug fix for hardware ROM */
-#define RADEON_MPP_TB_CONFIG            0x01c0
+#define MC_IND_INDEX                           0x01F8
+#define MC_IND_DATA                            0x01FC
+#define MEM_REFRESH_CNTL                       0x0178
+
+// CLK_PIN_CNTL
+#define CLK_PIN_CNTL__OSC_EN_MASK                          0x00000001L
+#define CLK_PIN_CNTL__OSC_EN                               0x00000001L
+#define CLK_PIN_CNTL__XTL_LOW_GAIN_MASK                    0x00000004L
+#define CLK_PIN_CNTL__XTL_LOW_GAIN                         0x00000004L
+#define CLK_PIN_CNTL__DONT_USE_XTALIN_MASK                 0x00000010L
+#define CLK_PIN_CNTL__DONT_USE_XTALIN                      0x00000010L
+#define CLK_PIN_CNTL__SLOW_CLOCK_SOURCE_MASK               0x00000020L
+#define CLK_PIN_CNTL__SLOW_CLOCK_SOURCE                    0x00000020L
+#define CLK_PIN_CNTL__CG_CLK_TO_OUTPIN_MASK                0x00000800L
+#define CLK_PIN_CNTL__CG_CLK_TO_OUTPIN                     0x00000800L
+#define CLK_PIN_CNTL__CG_COUNT_UP_TO_OUTPIN_MASK           0x00001000L
+#define CLK_PIN_CNTL__CG_COUNT_UP_TO_OUTPIN                0x00001000L
+#define CLK_PIN_CNTL__ACCESS_REGS_IN_SUSPEND_MASK          0x00002000L
+#define CLK_PIN_CNTL__ACCESS_REGS_IN_SUSPEND               0x00002000L
+#define CLK_PIN_CNTL__CG_SPARE_MASK                        0x00004000L
+#define CLK_PIN_CNTL__CG_SPARE                             0x00004000L
+#define CLK_PIN_CNTL__SCLK_DYN_START_CNTL_MASK             0x00008000L
+#define CLK_PIN_CNTL__SCLK_DYN_START_CNTL                  0x00008000L
+#define CLK_PIN_CNTL__CP_CLK_RUNNING_MASK                  0x00010000L
+#define CLK_PIN_CNTL__CP_CLK_RUNNING                       0x00010000L
+#define CLK_PIN_CNTL__CG_SPARE_RD_MASK                     0x00060000L
+#define CLK_PIN_CNTL__XTALIN_ALWAYS_ONb_MASK               0x00080000L
+#define CLK_PIN_CNTL__XTALIN_ALWAYS_ONb                    0x00080000L
+#define CLK_PIN_CNTL__PWRSEQ_DELAY_MASK                    0xff000000L
+
+// CLK_PWRMGT_CNTL_M6
+#define	CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF__SHIFT         0x00000000
+#define	CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF__SHIFT         0x00000001
+#define	CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF__SHIFT         0x00000002
+#define	CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF__SHIFT        0x00000003
+#define	CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF__SHIFT            0x00000004
+#define	CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF__SHIFT            0x00000005
+#define	CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF__SHIFT            0x00000006
+#define	CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF__SHIFT           0x00000007
+#define	CLK_PWRMGT_CNTL_M6__MC_CH_MODE__SHIFT              0x00000008
+#define	CLK_PWRMGT_CNTL_M6__TEST_MODE__SHIFT               0x00000009
+#define	CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN__SHIFT          0x0000000a
+#define	CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE__SHIFT      0x0000000c
+#define	CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT__SHIFT         0x0000000d
+#define	CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT__SHIFT       0x0000000f
+#define	CLK_PWRMGT_CNTL_M6__MC_BUSY__SHIFT                 0x00000010
+#define	CLK_PWRMGT_CNTL_M6__MC_INT_CNTL__SHIFT             0x00000011
+#define	CLK_PWRMGT_CNTL_M6__MC_SWITCH__SHIFT               0x00000012
+#define	CLK_PWRMGT_CNTL_M6__DLL_READY__SHIFT               0x00000013
+#define	CLK_PWRMGT_CNTL_M6__DISP_PM__SHIFT                 0x00000014
+#define	CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE__SHIFT           0x00000015
+#define	CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG__SHIFT            0x00000018
+#define	CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF__SHIFT        0x0000001e
+#define	CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF__SHIFT           0x0000001f
+
+// P2PLL_CNTL
+#define P2PLL_CNTL__P2PLL_RESET_MASK                       0x00000001L
+#define P2PLL_CNTL__P2PLL_RESET                            0x00000001L
+#define P2PLL_CNTL__P2PLL_SLEEP_MASK                       0x00000002L
+#define P2PLL_CNTL__P2PLL_SLEEP                            0x00000002L
+#define P2PLL_CNTL__P2PLL_TST_EN_MASK                      0x00000004L
+#define P2PLL_CNTL__P2PLL_TST_EN                           0x00000004L
+#define P2PLL_CNTL__P2PLL_REFCLK_SEL_MASK                  0x00000010L
+#define P2PLL_CNTL__P2PLL_REFCLK_SEL                       0x00000010L
+#define P2PLL_CNTL__P2PLL_FBCLK_SEL_MASK                   0x00000020L
+#define P2PLL_CNTL__P2PLL_FBCLK_SEL                        0x00000020L
+#define P2PLL_CNTL__P2PLL_TCPOFF_MASK                      0x00000040L
+#define P2PLL_CNTL__P2PLL_TCPOFF                           0x00000040L
+#define P2PLL_CNTL__P2PLL_TVCOMAX_MASK                     0x00000080L
+#define P2PLL_CNTL__P2PLL_TVCOMAX                          0x00000080L
+#define P2PLL_CNTL__P2PLL_PCP_MASK                         0x00000700L
+#define P2PLL_CNTL__P2PLL_PVG_MASK                         0x00003800L
+#define P2PLL_CNTL__P2PLL_PDC_MASK                         0x0000c000L
+#define P2PLL_CNTL__P2PLL_ATOMIC_UPDATE_EN_MASK            0x00010000L
+#define P2PLL_CNTL__P2PLL_ATOMIC_UPDATE_EN                 0x00010000L
+#define P2PLL_CNTL__P2PLL_ATOMIC_UPDATE_SYNC_MASK          0x00040000L
+#define P2PLL_CNTL__P2PLL_ATOMIC_UPDATE_SYNC               0x00040000L
+#define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET_MASK          0x00080000L
+#define P2PLL_CNTL__P2PLL_DISABLE_AUTO_RESET               0x00080000L
+
+// PIXCLKS_CNTL
+#define	PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT               0x00000000
+#define	PIXCLKS_CNTL__PIX2CLK_INVERT__SHIFT                0x00000004
+#define	PIXCLKS_CNTL__PIX2CLK_SRC_INVERT__SHIFT            0x00000005
+#define	PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb__SHIFT            0x00000006
+#define	PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb__SHIFT        0x00000007
+#define	PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL__SHIFT             0x00000008
+#define	PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb__SHIFT       0x0000000b
+#define	PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb__SHIFT          0x0000000c
+#define	PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb__SHIFT    0x0000000d
+#define	PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb__SHIFT        0x0000000e
+#define	PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb__SHIFT        0x0000000f
+
+
+// PIXCLKS_CNTL
+#define PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK                 0x00000003L
+#define PIXCLKS_CNTL__PIX2CLK_INVERT_MASK                  0x00000010L
+#define PIXCLKS_CNTL__PIX2CLK_INVERT                       0x00000010L
+#define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT_MASK              0x00000020L
+#define PIXCLKS_CNTL__PIX2CLK_SRC_INVERT                   0x00000020L
+#define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb_MASK              0x00000040L
+#define PIXCLKS_CNTL__PIX2CLK_ALWAYS_ONb                   0x00000040L
+#define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb_MASK          0x00000080L
+#define PIXCLKS_CNTL__PIX2CLK_DAC_ALWAYS_ONb               0x00000080L
+#define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL_MASK               0x00000100L
+#define PIXCLKS_CNTL__PIXCLK_TV_SRC_SEL                    0x00000100L
+#define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb_MASK         0x00000800L
+#define PIXCLKS_CNTL__PIXCLK_BLEND_ALWAYS_ONb              0x00000800L
+#define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb_MASK            0x00001000L
+#define PIXCLKS_CNTL__PIXCLK_GV_ALWAYS_ONb                 0x00001000L
+#define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb_MASK      0x00002000L
+#define PIXCLKS_CNTL__PIXCLK_DIG_TMDS_ALWAYS_ONb           0x00002000L
+#define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb_MASK          0x00004000L
+#define PIXCLKS_CNTL__PIXCLK_LVDS_ALWAYS_ONb               0x00004000L
+#define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb_MASK          0x00008000L
+#define PIXCLKS_CNTL__PIXCLK_TMDS_ALWAYS_ONb               0x00008000L
+
+
+// P2PLL_DIV_0
+#define P2PLL_DIV_0__P2PLL_FB_DIV_MASK                     0x000007ffL
+#define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W_MASK            0x00008000L
+#define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W                 0x00008000L
+#define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_R_MASK            0x00008000L
+#define P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_R                 0x00008000L
+#define P2PLL_DIV_0__P2PLL_POST_DIV_MASK                   0x00070000L
+
+// SCLK_CNTL_M6
+#define SCLK_CNTL_M6__SCLK_SRC_SEL_MASK                    0x00000007L
+#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT_MASK             0x00000008L
+#define SCLK_CNTL_M6__CP_MAX_DYN_STOP_LAT                  0x00000008L
+#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT_MASK            0x00000010L
+#define SCLK_CNTL_M6__HDP_MAX_DYN_STOP_LAT                 0x00000010L
+#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT_MASK             0x00000020L
+#define SCLK_CNTL_M6__TV_MAX_DYN_STOP_LAT                  0x00000020L
+#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT_MASK             0x00000040L
+#define SCLK_CNTL_M6__E2_MAX_DYN_STOP_LAT                  0x00000040L
+#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT_MASK             0x00000080L
+#define SCLK_CNTL_M6__SE_MAX_DYN_STOP_LAT                  0x00000080L
+#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT_MASK           0x00000100L
+#define SCLK_CNTL_M6__IDCT_MAX_DYN_STOP_LAT                0x00000100L
+#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT_MASK            0x00000200L
+#define SCLK_CNTL_M6__VIP_MAX_DYN_STOP_LAT                 0x00000200L
+#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT_MASK             0x00000400L
+#define SCLK_CNTL_M6__RE_MAX_DYN_STOP_LAT                  0x00000400L
+#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT_MASK             0x00000800L
+#define SCLK_CNTL_M6__PB_MAX_DYN_STOP_LAT                  0x00000800L
+#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT_MASK            0x00001000L
+#define SCLK_CNTL_M6__TAM_MAX_DYN_STOP_LAT                 0x00001000L
+#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT_MASK            0x00002000L
+#define SCLK_CNTL_M6__TDM_MAX_DYN_STOP_LAT                 0x00002000L
+#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT_MASK             0x00004000L
+#define SCLK_CNTL_M6__RB_MAX_DYN_STOP_LAT                  0x00004000L
+#define SCLK_CNTL_M6__FORCE_DISP2_MASK                     0x00008000L
+#define SCLK_CNTL_M6__FORCE_DISP2                          0x00008000L
+#define SCLK_CNTL_M6__FORCE_CP_MASK                        0x00010000L
+#define SCLK_CNTL_M6__FORCE_CP                             0x00010000L
+#define SCLK_CNTL_M6__FORCE_HDP_MASK                       0x00020000L
+#define SCLK_CNTL_M6__FORCE_HDP                            0x00020000L
+#define SCLK_CNTL_M6__FORCE_DISP1_MASK                     0x00040000L
+#define SCLK_CNTL_M6__FORCE_DISP1                          0x00040000L
+#define SCLK_CNTL_M6__FORCE_TOP_MASK                       0x00080000L
+#define SCLK_CNTL_M6__FORCE_TOP                            0x00080000L
+#define SCLK_CNTL_M6__FORCE_E2_MASK                        0x00100000L
+#define SCLK_CNTL_M6__FORCE_E2                             0x00100000L
+#define SCLK_CNTL_M6__FORCE_SE_MASK                        0x00200000L
+#define SCLK_CNTL_M6__FORCE_SE                             0x00200000L
+#define SCLK_CNTL_M6__FORCE_IDCT_MASK                      0x00400000L
+#define SCLK_CNTL_M6__FORCE_IDCT                           0x00400000L
+#define SCLK_CNTL_M6__FORCE_VIP_MASK                       0x00800000L
+#define SCLK_CNTL_M6__FORCE_VIP                            0x00800000L
+#define SCLK_CNTL_M6__FORCE_RE_MASK                        0x01000000L
+#define SCLK_CNTL_M6__FORCE_RE                             0x01000000L
+#define SCLK_CNTL_M6__FORCE_PB_MASK                        0x02000000L
+#define SCLK_CNTL_M6__FORCE_PB                             0x02000000L
+#define SCLK_CNTL_M6__FORCE_TAM_MASK                       0x04000000L
+#define SCLK_CNTL_M6__FORCE_TAM                            0x04000000L
+#define SCLK_CNTL_M6__FORCE_TDM_MASK                       0x08000000L
+#define SCLK_CNTL_M6__FORCE_TDM                            0x08000000L
+#define SCLK_CNTL_M6__FORCE_RB_MASK                        0x10000000L
+#define SCLK_CNTL_M6__FORCE_RB                             0x10000000L
+#define SCLK_CNTL_M6__FORCE_TV_SCLK_MASK                   0x20000000L
+#define SCLK_CNTL_M6__FORCE_TV_SCLK                        0x20000000L
+#define SCLK_CNTL_M6__FORCE_SUBPIC_MASK                    0x40000000L
+#define SCLK_CNTL_M6__FORCE_SUBPIC                         0x40000000L
+#define SCLK_CNTL_M6__FORCE_OV0_MASK                       0x80000000L
+#define SCLK_CNTL_M6__FORCE_OV0                            0x80000000L
+
+// SCLK_MORE_CNTL
+#define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT_MASK     0x00000001L
+#define SCLK_MORE_CNTL__DISPREGS_MAX_DYN_STOP_LAT          0x00000001L
+#define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT_MASK       0x00000002L
+#define SCLK_MORE_CNTL__MC_GUI_MAX_DYN_STOP_LAT            0x00000002L
+#define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT_MASK      0x00000004L
+#define SCLK_MORE_CNTL__MC_HOST_MAX_DYN_STOP_LAT           0x00000004L
+#define SCLK_MORE_CNTL__FORCE_DISPREGS_MASK                0x00000100L
+#define SCLK_MORE_CNTL__FORCE_DISPREGS                     0x00000100L
+#define SCLK_MORE_CNTL__FORCE_MC_GUI_MASK                  0x00000200L
+#define SCLK_MORE_CNTL__FORCE_MC_GUI                       0x00000200L
+#define SCLK_MORE_CNTL__FORCE_MC_HOST_MASK                 0x00000400L
+#define SCLK_MORE_CNTL__FORCE_MC_HOST                      0x00000400L
+#define SCLK_MORE_CNTL__STOP_SCLK_EN_MASK                  0x00001000L
+#define SCLK_MORE_CNTL__STOP_SCLK_EN                       0x00001000L
+#define SCLK_MORE_CNTL__STOP_SCLK_A_MASK                   0x00002000L
+#define SCLK_MORE_CNTL__STOP_SCLK_A                        0x00002000L
+#define SCLK_MORE_CNTL__STOP_SCLK_B_MASK                   0x00004000L
+#define SCLK_MORE_CNTL__STOP_SCLK_B                        0x00004000L
+#define SCLK_MORE_CNTL__STOP_SCLK_C_MASK                   0x00008000L
+#define SCLK_MORE_CNTL__STOP_SCLK_C                        0x00008000L
+#define SCLK_MORE_CNTL__HALF_SPEED_SCLK_MASK               0x00010000L
+#define SCLK_MORE_CNTL__HALF_SPEED_SCLK                    0x00010000L
+#define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP_MASK            0x00020000L
+#define SCLK_MORE_CNTL__IO_CG_VOLTAGE_DROP                 0x00020000L
+#define SCLK_MORE_CNTL__TVFB_SOFT_RESET_MASK               0x00040000L
+#define SCLK_MORE_CNTL__TVFB_SOFT_RESET                    0x00040000L
+#define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC_MASK             0x00080000L
+#define SCLK_MORE_CNTL__VOLTAGE_DROP_SYNC                  0x00080000L
+#define SCLK_MORE_CNTL__VOLTAGE_DELAY_SEL_MASK             0x00300000L
+#define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK_MASK          0x00400000L
+#define SCLK_MORE_CNTL__IDLE_DELAY_HALF_SCLK               0x00400000L
+#define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK_MASK            0x00800000L
+#define SCLK_MORE_CNTL__AGP_BUSY_HALF_SCLK                 0x00800000L
+#define SCLK_MORE_CNTL__CG_SPARE_RD_C_MASK                 0xff000000L
+
+// MCLK_CNTL_M6
+#define MCLK_CNTL_M6__MCLKA_SRC_SEL_MASK                   0x00000007L
+#define MCLK_CNTL_M6__YCLKA_SRC_SEL_MASK                   0x00000070L
+#define MCLK_CNTL_M6__MCLKB_SRC_SEL_MASK                   0x00000700L
+#define MCLK_CNTL_M6__YCLKB_SRC_SEL_MASK                   0x00007000L
+#define MCLK_CNTL_M6__FORCE_MCLKA_MASK                     0x00010000L
+#define MCLK_CNTL_M6__FORCE_MCLKA                          0x00010000L
+#define MCLK_CNTL_M6__FORCE_MCLKB_MASK                     0x00020000L
+#define MCLK_CNTL_M6__FORCE_MCLKB                          0x00020000L
+#define MCLK_CNTL_M6__FORCE_YCLKA_MASK                     0x00040000L
+#define MCLK_CNTL_M6__FORCE_YCLKA                          0x00040000L
+#define MCLK_CNTL_M6__FORCE_YCLKB_MASK                     0x00080000L
+#define MCLK_CNTL_M6__FORCE_YCLKB                          0x00080000L
+#define MCLK_CNTL_M6__FORCE_MC_MASK                        0x00100000L
+#define MCLK_CNTL_M6__FORCE_MC                             0x00100000L
+#define MCLK_CNTL_M6__FORCE_AIC_MASK                       0x00200000L
+#define MCLK_CNTL_M6__FORCE_AIC                            0x00200000L
+#define MCLK_CNTL_M6__MRDCKA0_SOUTSEL_MASK                 0x03000000L
+#define MCLK_CNTL_M6__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
+#define MCLK_CNTL_M6__MRDCKB0_SOUTSEL_MASK                 0x30000000L
+#define MCLK_CNTL_M6__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
+
+// MCLK_MISC
+#define MCLK_MISC__SCLK_SOURCED_FROM_MPLL_SEL_MASK         0x00000003L
+#define MCLK_MISC__MCLK_FROM_SPLL_DIV_SEL_MASK             0x00000004L
+#define MCLK_MISC__MCLK_FROM_SPLL_DIV_SEL                  0x00000004L
+#define MCLK_MISC__ENABLE_SCLK_FROM_MPLL_MASK              0x00000008L
+#define MCLK_MISC__ENABLE_SCLK_FROM_MPLL                   0x00000008L
+#define MCLK_MISC__MPLL_MODEA_MODEC_HW_SEL_EN_MASK         0x00000010L
+#define MCLK_MISC__MPLL_MODEA_MODEC_HW_SEL_EN              0x00000010L
+#define MCLK_MISC__DLL_READY_LAT_MASK                      0x00000100L
+#define MCLK_MISC__DLL_READY_LAT                           0x00000100L
+#define MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT_MASK           0x00001000L
+#define MCLK_MISC__MC_MCLK_MAX_DYN_STOP_LAT                0x00001000L
+#define MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT_MASK           0x00002000L
+#define MCLK_MISC__IO_MCLK_MAX_DYN_STOP_LAT                0x00002000L
+#define MCLK_MISC__MC_MCLK_DYN_ENABLE_MASK                 0x00004000L
+#define MCLK_MISC__MC_MCLK_DYN_ENABLE                      0x00004000L
+#define MCLK_MISC__IO_MCLK_DYN_ENABLE_MASK                 0x00008000L
+#define MCLK_MISC__IO_MCLK_DYN_ENABLE                      0x00008000L
+#define MCLK_MISC__CGM_CLK_TO_OUTPIN_MASK                  0x00010000L
+#define MCLK_MISC__CGM_CLK_TO_OUTPIN                       0x00010000L
+#define MCLK_MISC__CLK_OR_COUNT_SEL_MASK                   0x00020000L
+#define MCLK_MISC__CLK_OR_COUNT_SEL                        0x00020000L
+#define MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND_MASK        0x00040000L
+#define MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND             0x00040000L
+#define MCLK_MISC__CGM_SPARE_RD_MASK                       0x00300000L
+#define MCLK_MISC__CGM_SPARE_A_RD_MASK                     0x00c00000L
+#define MCLK_MISC__TCLK_TO_YCLKB_EN_MASK                   0x01000000L
+#define MCLK_MISC__TCLK_TO_YCLKB_EN                        0x01000000L
+#define MCLK_MISC__CGM_SPARE_A_MASK                        0x0e000000L
+
+// VCLK_ECP_CNTL
+#define VCLK_ECP_CNTL__VCLK_SRC_SEL_MASK                   0x00000003L
+#define VCLK_ECP_CNTL__VCLK_INVERT_MASK                    0x00000010L
+#define VCLK_ECP_CNTL__VCLK_INVERT                         0x00000010L
+#define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT_MASK              0x00000020L
+#define VCLK_ECP_CNTL__PIXCLK_SRC_INVERT                   0x00000020L
+#define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb_MASK              0x00000040L
+#define VCLK_ECP_CNTL__PIXCLK_ALWAYS_ONb                   0x00000040L
+#define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb_MASK          0x00000080L
+#define VCLK_ECP_CNTL__PIXCLK_DAC_ALWAYS_ONb               0x00000080L
+#define VCLK_ECP_CNTL__ECP_DIV_MASK                        0x00000300L
+#define VCLK_ECP_CNTL__ECP_FORCE_ON_MASK                   0x00040000L
+#define VCLK_ECP_CNTL__ECP_FORCE_ON                        0x00040000L
+#define VCLK_ECP_CNTL__SUBCLK_FORCE_ON_MASK                0x00080000L
+#define VCLK_ECP_CNTL__SUBCLK_FORCE_ON                     0x00080000L
+
+// PLL_PWRMGT_CNTL
+#define PLL_PWRMGT_CNTL__MPLL_TURNOFF_MASK                 0x00000001L
+#define PLL_PWRMGT_CNTL__MPLL_TURNOFF                      0x00000001L
+#define PLL_PWRMGT_CNTL__SPLL_TURNOFF_MASK                 0x00000002L
+#define PLL_PWRMGT_CNTL__SPLL_TURNOFF                      0x00000002L
+#define PLL_PWRMGT_CNTL__PPLL_TURNOFF_MASK                 0x00000004L
+#define PLL_PWRMGT_CNTL__PPLL_TURNOFF                      0x00000004L
+#define PLL_PWRMGT_CNTL__P2PLL_TURNOFF_MASK                0x00000008L
+#define PLL_PWRMGT_CNTL__P2PLL_TURNOFF                     0x00000008L
+#define PLL_PWRMGT_CNTL__TVPLL_TURNOFF_MASK                0x00000010L
+#define PLL_PWRMGT_CNTL__TVPLL_TURNOFF                     0x00000010L
+#define PLL_PWRMGT_CNTL__AGPCLK_DYN_STOP_LAT_MASK          0x000001e0L
+#define PLL_PWRMGT_CNTL__APM_POWER_STATE_MASK              0x00000600L
+#define PLL_PWRMGT_CNTL__APM_PWRSTATE_RD_MASK              0x00001800L
+#define PLL_PWRMGT_CNTL__PM_MODE_SEL_MASK                  0x00002000L
+#define PLL_PWRMGT_CNTL__PM_MODE_SEL                       0x00002000L
+#define PLL_PWRMGT_CNTL__EN_PWRSEQ_DONE_COND_MASK          0x00004000L
+#define PLL_PWRMGT_CNTL__EN_PWRSEQ_DONE_COND               0x00004000L
+#define PLL_PWRMGT_CNTL__EN_DISP_PARKED_COND_MASK          0x00008000L
+#define PLL_PWRMGT_CNTL__EN_DISP_PARKED_COND               0x00008000L
+#define PLL_PWRMGT_CNTL__MOBILE_SU_MASK                    0x00010000L
+#define PLL_PWRMGT_CNTL__MOBILE_SU                         0x00010000L
+#define PLL_PWRMGT_CNTL__SU_SCLK_USE_BCLK_MASK             0x00020000L
+#define PLL_PWRMGT_CNTL__SU_SCLK_USE_BCLK                  0x00020000L
+#define PLL_PWRMGT_CNTL__SU_MCLK_USE_BCLK_MASK             0x00040000L
+#define PLL_PWRMGT_CNTL__SU_MCLK_USE_BCLK                  0x00040000L
+#define PLL_PWRMGT_CNTL__SU_SUSTAIN_DISABLE_MASK           0x00080000L
+#define PLL_PWRMGT_CNTL__SU_SUSTAIN_DISABLE                0x00080000L
+#define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE_MASK           0x00100000L
+#define PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE                0x00100000L
+#define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD_MASK          0x00200000L
+#define PLL_PWRMGT_CNTL__TCL_CLOCK_ACTIVE_RD               0x00200000L
+#define PLL_PWRMGT_CNTL__CG_NO2_DEBUG_MASK                 0xff000000L
+
+// CLK_PWRMGT_CNTL_M6
+#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF_MASK           0x00000001L
+#define CLK_PWRMGT_CNTL_M6__MPLL_PWRMGT_OFF                0x00000001L
+#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF_MASK           0x00000002L
+#define CLK_PWRMGT_CNTL_M6__SPLL_PWRMGT_OFF                0x00000002L
+#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF_MASK           0x00000004L
+#define CLK_PWRMGT_CNTL_M6__PPLL_PWRMGT_OFF                0x00000004L
+#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF_MASK          0x00000008L
+#define CLK_PWRMGT_CNTL_M6__P2PLL_PWRMGT_OFF               0x00000008L
+#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF_MASK              0x00000010L
+#define CLK_PWRMGT_CNTL_M6__MCLK_TURNOFF                   0x00000010L
+#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF_MASK              0x00000020L
+#define CLK_PWRMGT_CNTL_M6__SCLK_TURNOFF                   0x00000020L
+#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF_MASK              0x00000040L
+#define CLK_PWRMGT_CNTL_M6__PCLK_TURNOFF                   0x00000040L
+#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF_MASK             0x00000080L
+#define CLK_PWRMGT_CNTL_M6__P2CLK_TURNOFF                  0x00000080L
+#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE_MASK                0x00000100L
+#define CLK_PWRMGT_CNTL_M6__MC_CH_MODE                     0x00000100L
+#define CLK_PWRMGT_CNTL_M6__TEST_MODE_MASK                 0x00000200L
+#define CLK_PWRMGT_CNTL_M6__TEST_MODE                      0x00000200L
+#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN_MASK            0x00000400L
+#define CLK_PWRMGT_CNTL_M6__GLOBAL_PMAN_EN                 0x00000400L
+#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE_MASK        0x00001000L
+#define CLK_PWRMGT_CNTL_M6__ENGINE_DYNCLK_MODE             0x00001000L
+#define CLK_PWRMGT_CNTL_M6__ACTIVE_HILO_LAT_MASK           0x00006000L
+#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT_MASK         0x00008000L
+#define CLK_PWRMGT_CNTL_M6__DISP_DYN_STOP_LAT              0x00008000L
+#define CLK_PWRMGT_CNTL_M6__MC_BUSY_MASK                   0x00010000L
+#define CLK_PWRMGT_CNTL_M6__MC_BUSY                        0x00010000L
+#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL_MASK               0x00020000L
+#define CLK_PWRMGT_CNTL_M6__MC_INT_CNTL                    0x00020000L
+#define CLK_PWRMGT_CNTL_M6__MC_SWITCH_MASK                 0x00040000L
+#define CLK_PWRMGT_CNTL_M6__MC_SWITCH                      0x00040000L
+#define CLK_PWRMGT_CNTL_M6__DLL_READY_MASK                 0x00080000L
+#define CLK_PWRMGT_CNTL_M6__DLL_READY                      0x00080000L
+#define CLK_PWRMGT_CNTL_M6__DISP_PM_MASK                   0x00100000L
+#define CLK_PWRMGT_CNTL_M6__DISP_PM                        0x00100000L
+#define CLK_PWRMGT_CNTL_M6__DYN_STOP_MODE_MASK             0x00e00000L
+#define CLK_PWRMGT_CNTL_M6__CG_NO1_DEBUG_MASK              0x3f000000L
+#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF_MASK          0x40000000L
+#define CLK_PWRMGT_CNTL_M6__TVPLL_PWRMGT_OFF               0x40000000L
+#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF_MASK             0x80000000L
+#define CLK_PWRMGT_CNTL_M6__TVCLK_TURNOFF                  0x80000000L
+
+// BUS_CNTL1
+#define BUS_CNTL1__PMI_IO_DISABLE_MASK                     0x00000001L
+#define BUS_CNTL1__PMI_IO_DISABLE                          0x00000001L
+#define BUS_CNTL1__PMI_MEM_DISABLE_MASK                    0x00000002L
+#define BUS_CNTL1__PMI_MEM_DISABLE                         0x00000002L
+#define BUS_CNTL1__PMI_BM_DISABLE_MASK                     0x00000004L
+#define BUS_CNTL1__PMI_BM_DISABLE                          0x00000004L
+#define BUS_CNTL1__PMI_INT_DISABLE_MASK                    0x00000008L
+#define BUS_CNTL1__PMI_INT_DISABLE                         0x00000008L
+#define BUS_CNTL1__BUS2_IMMEDIATE_PMI_DISABLE_MASK         0x00000020L
+#define BUS_CNTL1__BUS2_IMMEDIATE_PMI_DISABLE              0x00000020L
+#define BUS_CNTL1__BUS2_VGA_REG_COHERENCY_DIS_MASK         0x00000100L
+#define BUS_CNTL1__BUS2_VGA_REG_COHERENCY_DIS              0x00000100L
+#define BUS_CNTL1__BUS2_VGA_MEM_COHERENCY_DIS_MASK         0x00000200L
+#define BUS_CNTL1__BUS2_VGA_MEM_COHERENCY_DIS              0x00000200L
+#define BUS_CNTL1__BUS2_HDP_REG_COHERENCY_DIS_MASK         0x00000400L
+#define BUS_CNTL1__BUS2_HDP_REG_COHERENCY_DIS              0x00000400L
+#define BUS_CNTL1__BUS2_GUI_INITIATOR_COHERENCY_DIS_MASK   0x00000800L
+#define BUS_CNTL1__BUS2_GUI_INITIATOR_COHERENCY_DIS        0x00000800L
+#define BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK                0x0c000000L
+#define BUS_CNTL1__SEND_SBA_LATENCY_MASK                   0x70000000L
+#define BUS_CNTL1__AGPCLK_VALID_MASK                       0x80000000L
+#define BUS_CNTL1__AGPCLK_VALID                            0x80000000L
+
+// BUS_CNTL1
+#define	BUS_CNTL1__PMI_IO_DISABLE__SHIFT                   0x00000000
+#define	BUS_CNTL1__PMI_MEM_DISABLE__SHIFT                  0x00000001
+#define	BUS_CNTL1__PMI_BM_DISABLE__SHIFT                   0x00000002
+#define	BUS_CNTL1__PMI_INT_DISABLE__SHIFT                  0x00000003
+#define	BUS_CNTL1__BUS2_IMMEDIATE_PMI_DISABLE__SHIFT       0x00000005
+#define	BUS_CNTL1__BUS2_VGA_REG_COHERENCY_DIS__SHIFT       0x00000008
+#define	BUS_CNTL1__BUS2_VGA_MEM_COHERENCY_DIS__SHIFT       0x00000009
+#define	BUS_CNTL1__BUS2_HDP_REG_COHERENCY_DIS__SHIFT       0x0000000a
+#define	BUS_CNTL1__BUS2_GUI_INITIATOR_COHERENCY_DIS__SHIFT 0x0000000b
+#define	BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT              0x0000001a
+#define	BUS_CNTL1__SEND_SBA_LATENCY__SHIFT                 0x0000001c
+#define	BUS_CNTL1__AGPCLK_VALID__SHIFT                     0x0000001f
+
+// CRTC_OFFSET_CNTL
+#define CRTC_OFFSET_CNTL__CRTC_TILE_LINE_MASK              0x0000000fL
+#define CRTC_OFFSET_CNTL__CRTC_TILE_LINE_RIGHT_MASK        0x000000f0L
+#define CRTC_OFFSET_CNTL__CRTC_TILE_EN_RIGHT_MASK          0x00004000L
+#define CRTC_OFFSET_CNTL__CRTC_TILE_EN_RIGHT               0x00004000L
+#define CRTC_OFFSET_CNTL__CRTC_TILE_EN_MASK                0x00008000L
+#define CRTC_OFFSET_CNTL__CRTC_TILE_EN                     0x00008000L
+#define CRTC_OFFSET_CNTL__CRTC_OFFSET_FLIP_CNTL_MASK       0x00010000L
+#define CRTC_OFFSET_CNTL__CRTC_OFFSET_FLIP_CNTL            0x00010000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_OFFSET_EN_MASK       0x00020000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_OFFSET_EN            0x00020000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_EN_MASK         0x000c0000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN_MASK     0x00100000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN          0x00100000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_MASK            0x00200000L
+#define CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC                 0x00200000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET_LEFT_EN_MASK 0x10000000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET_LEFT_EN     0x10000000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET_RIGHT_EN_MASK 0x20000000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET_RIGHT_EN    0x20000000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET_MASK        0x40000000L
+#define CRTC_OFFSET_CNTL__CRTC_GUI_TRIG_OFFSET             0x40000000L
+#define CRTC_OFFSET_CNTL__CRTC_OFFSET_LOCK_MASK            0x80000000L
+#define CRTC_OFFSET_CNTL__CRTC_OFFSET_LOCK                 0x80000000L
+
+// CRTC_GEN_CNTL
+#define CRTC_GEN_CNTL__CRTC_DBL_SCAN_EN_MASK               0x00000001L
+#define CRTC_GEN_CNTL__CRTC_DBL_SCAN_EN                    0x00000001L
+#define CRTC_GEN_CNTL__CRTC_INTERLACE_EN_MASK              0x00000002L
+#define CRTC_GEN_CNTL__CRTC_INTERLACE_EN                   0x00000002L
+#define CRTC_GEN_CNTL__CRTC_C_SYNC_EN_MASK                 0x00000010L
+#define CRTC_GEN_CNTL__CRTC_C_SYNC_EN                      0x00000010L
+#define CRTC_GEN_CNTL__CRTC_PIX_WIDTH_MASK                 0x00000f00L
+#define CRTC_GEN_CNTL__CRTC_ICON_EN_MASK                   0x00008000L
+#define CRTC_GEN_CNTL__CRTC_ICON_EN                        0x00008000L
+#define CRTC_GEN_CNTL__CRTC_CUR_EN_MASK                    0x00010000L
+#define CRTC_GEN_CNTL__CRTC_CUR_EN                         0x00010000L
+#define CRTC_GEN_CNTL__CRTC_VSTAT_MODE_MASK                0x00060000L
+#define CRTC_GEN_CNTL__CRTC_CUR_MODE_MASK                  0x00700000L
+#define CRTC_GEN_CNTL__CRTC_EXT_DISP_EN_MASK               0x01000000L
+#define CRTC_GEN_CNTL__CRTC_EXT_DISP_EN                    0x01000000L
+#define CRTC_GEN_CNTL__CRTC_EN_MASK                        0x02000000L
+#define CRTC_GEN_CNTL__CRTC_EN                             0x02000000L
+#define CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B_MASK             0x04000000L
+#define CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B                  0x04000000L
+
+// CRTC2_GEN_CNTL
+#define CRTC2_GEN_CNTL__CRTC2_DBL_SCAN_EN_MASK             0x00000001L
+#define CRTC2_GEN_CNTL__CRTC2_DBL_SCAN_EN                  0x00000001L
+#define CRTC2_GEN_CNTL__CRTC2_INTERLACE_EN_MASK            0x00000002L
+#define CRTC2_GEN_CNTL__CRTC2_INTERLACE_EN                 0x00000002L
+#define CRTC2_GEN_CNTL__CRTC2_SYNC_TRISTATE_MASK           0x00000010L
+#define CRTC2_GEN_CNTL__CRTC2_SYNC_TRISTATE                0x00000010L
+#define CRTC2_GEN_CNTL__CRTC2_HSYNC_TRISTATE_MASK          0x00000020L
+#define CRTC2_GEN_CNTL__CRTC2_HSYNC_TRISTATE               0x00000020L
+#define CRTC2_GEN_CNTL__CRTC2_VSYNC_TRISTATE_MASK          0x00000040L
+#define CRTC2_GEN_CNTL__CRTC2_VSYNC_TRISTATE               0x00000040L
+#define CRTC2_GEN_CNTL__CRT2_ON_MASK                       0x00000080L
+#define CRTC2_GEN_CNTL__CRT2_ON                            0x00000080L
+#define CRTC2_GEN_CNTL__CRTC2_PIX_WIDTH_MASK               0x00000f00L
+#define CRTC2_GEN_CNTL__CRTC2_ICON_EN_MASK                 0x00008000L
+#define CRTC2_GEN_CNTL__CRTC2_ICON_EN                      0x00008000L
+#define CRTC2_GEN_CNTL__CRTC2_CUR_EN_MASK                  0x00010000L
+#define CRTC2_GEN_CNTL__CRTC2_CUR_EN                       0x00010000L
+#define CRTC2_GEN_CNTL__CRTC2_CUR_MODE_MASK                0x00700000L
+#define CRTC2_GEN_CNTL__CRTC2_DISPLAY_DIS_MASK             0x00800000L
+#define CRTC2_GEN_CNTL__CRTC2_DISPLAY_DIS                  0x00800000L
+#define CRTC2_GEN_CNTL__CRTC2_EN_MASK                      0x02000000L
+#define CRTC2_GEN_CNTL__CRTC2_EN                           0x02000000L
+#define CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B_MASK           0x04000000L
+#define CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B                0x04000000L
+#define CRTC2_GEN_CNTL__CRTC2_C_SYNC_EN_MASK               0x08000000L
+#define CRTC2_GEN_CNTL__CRTC2_C_SYNC_EN                    0x08000000L
+#define CRTC2_GEN_CNTL__CRTC2_HSYNC_DIS_MASK               0x10000000L
+#define CRTC2_GEN_CNTL__CRTC2_HSYNC_DIS                    0x10000000L
+#define CRTC2_GEN_CNTL__CRTC2_VSYNC_DIS_MASK               0x20000000L
+#define CRTC2_GEN_CNTL__CRTC2_VSYNC_DIS                    0x20000000L
+
+// AGP_CNTL
+#define AGP_CNTL__MAX_IDLE_CLK_MASK                        0x000000ffL
+#define AGP_CNTL__HOLD_RD_FIFO_MASK                        0x00000100L
+#define AGP_CNTL__HOLD_RD_FIFO                             0x00000100L
+#define AGP_CNTL__HOLD_RQ_FIFO_MASK                        0x00000200L
+#define AGP_CNTL__HOLD_RQ_FIFO                             0x00000200L
+#define AGP_CNTL__EN_2X_STBB_MASK                          0x00000400L
+#define AGP_CNTL__EN_2X_STBB                               0x00000400L
+#define AGP_CNTL__FORCE_FULL_SBA_MASK                      0x00000800L
+#define AGP_CNTL__FORCE_FULL_SBA                           0x00000800L
+#define AGP_CNTL__SBA_DIS_MASK                             0x00001000L
+#define AGP_CNTL__SBA_DIS                                  0x00001000L
+#define AGP_CNTL__AGP_REV_ID_MASK                          0x00002000L
+#define AGP_CNTL__AGP_REV_ID                               0x00002000L
+#define AGP_CNTL__REG_CRIPPLE_AGP4X_MASK                   0x00004000L
+#define AGP_CNTL__REG_CRIPPLE_AGP4X                        0x00004000L
+#define AGP_CNTL__REG_CRIPPLE_AGP2X4X_MASK                 0x00008000L
+#define AGP_CNTL__REG_CRIPPLE_AGP2X4X                      0x00008000L
+#define AGP_CNTL__FORCE_INT_VREF_MASK                      0x00010000L
+#define AGP_CNTL__FORCE_INT_VREF                           0x00010000L
+#define AGP_CNTL__PENDING_SLOTS_VAL_MASK                   0x00060000L
+#define AGP_CNTL__PENDING_SLOTS_SEL_MASK                   0x00080000L
+#define AGP_CNTL__PENDING_SLOTS_SEL                        0x00080000L
+#define AGP_CNTL__EN_EXTENDED_AD_STB_2X_MASK               0x00100000L
+#define AGP_CNTL__EN_EXTENDED_AD_STB_2X                    0x00100000L
+#define AGP_CNTL__DIS_QUEUED_GNT_FIX_MASK                  0x00200000L
+#define AGP_CNTL__DIS_QUEUED_GNT_FIX                       0x00200000L
+#define AGP_CNTL__EN_RDATA2X4X_MULTIRESET_MASK             0x00400000L
+#define AGP_CNTL__EN_RDATA2X4X_MULTIRESET                  0x00400000L
+#define AGP_CNTL__EN_RBFCALM_MASK                          0x00800000L
+#define AGP_CNTL__EN_RBFCALM                               0x00800000L
+#define AGP_CNTL__FORCE_EXT_VREF_MASK                      0x01000000L
+#define AGP_CNTL__FORCE_EXT_VREF                           0x01000000L
+#define AGP_CNTL__DIS_RBF_MASK                             0x02000000L
+#define AGP_CNTL__DIS_RBF                                  0x02000000L
+#define AGP_CNTL__DELAY_FIRST_SBA_EN_MASK                  0x04000000L
+#define AGP_CNTL__DELAY_FIRST_SBA_EN                       0x04000000L
+#define AGP_CNTL__DELAY_FIRST_SBA_VAL_MASK                 0x38000000L
+#define AGP_CNTL__AGP_MISC_MASK                            0xc0000000L
+
+// AGP_CNTL
+#define	AGP_CNTL__MAX_IDLE_CLK__SHIFT                      0x00000000
+#define	AGP_CNTL__HOLD_RD_FIFO__SHIFT                      0x00000008
+#define	AGP_CNTL__HOLD_RQ_FIFO__SHIFT                      0x00000009
+#define	AGP_CNTL__EN_2X_STBB__SHIFT                        0x0000000a
+#define	AGP_CNTL__FORCE_FULL_SBA__SHIFT                    0x0000000b
+#define	AGP_CNTL__SBA_DIS__SHIFT                           0x0000000c
+#define	AGP_CNTL__AGP_REV_ID__SHIFT                        0x0000000d
+#define	AGP_CNTL__REG_CRIPPLE_AGP4X__SHIFT                 0x0000000e
+#define	AGP_CNTL__REG_CRIPPLE_AGP2X4X__SHIFT               0x0000000f
+#define	AGP_CNTL__FORCE_INT_VREF__SHIFT                    0x00000010
+#define	AGP_CNTL__PENDING_SLOTS_VAL__SHIFT                 0x00000011
+#define	AGP_CNTL__PENDING_SLOTS_SEL__SHIFT                 0x00000013
+#define	AGP_CNTL__EN_EXTENDED_AD_STB_2X__SHIFT             0x00000014
+#define	AGP_CNTL__DIS_QUEUED_GNT_FIX__SHIFT                0x00000015
+#define	AGP_CNTL__EN_RDATA2X4X_MULTIRESET__SHIFT           0x00000016
+#define	AGP_CNTL__EN_RBFCALM__SHIFT                        0x00000017
+#define	AGP_CNTL__FORCE_EXT_VREF__SHIFT                    0x00000018
+#define	AGP_CNTL__DIS_RBF__SHIFT                           0x00000019
+#define	AGP_CNTL__DELAY_FIRST_SBA_EN__SHIFT                0x0000001a
+#define	AGP_CNTL__DELAY_FIRST_SBA_VAL__SHIFT               0x0000001b
+#define	AGP_CNTL__AGP_MISC__SHIFT                          0x0000001e
+
+// DISP_MISC_CNTL
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH_PP_MASK            0x00000001L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH_PP                 0x00000001L
+#define DISP_MISC_CNTL__SOFT_RESET_SUBPIC_PP_MASK          0x00000002L
+#define DISP_MISC_CNTL__SOFT_RESET_SUBPIC_PP               0x00000002L
+#define DISP_MISC_CNTL__SOFT_RESET_OV0_PP_MASK             0x00000004L
+#define DISP_MISC_CNTL__SOFT_RESET_OV0_PP                  0x00000004L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH_SCLK_MASK          0x00000010L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH_SCLK               0x00000010L
+#define DISP_MISC_CNTL__SOFT_RESET_SUBPIC_SCLK_MASK        0x00000020L
+#define DISP_MISC_CNTL__SOFT_RESET_SUBPIC_SCLK             0x00000020L
+#define DISP_MISC_CNTL__SOFT_RESET_OV0_SCLK_MASK           0x00000040L
+#define DISP_MISC_CNTL__SOFT_RESET_OV0_SCLK                0x00000040L
+#define DISP_MISC_CNTL__SYNC_STRENGTH_MASK                 0x00000300L
+#define DISP_MISC_CNTL__SYNC_PAD_FLOP_EN_MASK              0x00000400L
+#define DISP_MISC_CNTL__SYNC_PAD_FLOP_EN                   0x00000400L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH2_PP_MASK           0x00001000L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH2_PP                0x00001000L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH2_SCLK_MASK         0x00008000L
+#define DISP_MISC_CNTL__SOFT_RESET_GRPH2_SCLK              0x00008000L
+#define DISP_MISC_CNTL__SOFT_RESET_LVDS_MASK               0x00010000L
+#define DISP_MISC_CNTL__SOFT_RESET_LVDS                    0x00010000L
+#define DISP_MISC_CNTL__SOFT_RESET_TMDS_MASK               0x00020000L
+#define DISP_MISC_CNTL__SOFT_RESET_TMDS                    0x00020000L
+#define DISP_MISC_CNTL__SOFT_RESET_DIG_TMDS_MASK           0x00040000L
+#define DISP_MISC_CNTL__SOFT_RESET_DIG_TMDS                0x00040000L
+#define DISP_MISC_CNTL__SOFT_RESET_TV_MASK                 0x00080000L
+#define DISP_MISC_CNTL__SOFT_RESET_TV                      0x00080000L
+#define DISP_MISC_CNTL__PALETTE2_MEM_RD_MARGIN_MASK        0x00f00000L
+#define DISP_MISC_CNTL__PALETTE_MEM_RD_MARGIN_MASK         0x0f000000L
+#define DISP_MISC_CNTL__RMX_BUF_MEM_RD_MARGIN_MASK         0xf0000000L
+
+// DISP_PWR_MAN
+#define DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN_MASK         0x00000001L
+#define DISP_PWR_MAN__DISP_PWR_MAN_D3_CRTC_EN              0x00000001L
+#define DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN_MASK       0x00000010L
+#define DISP_PWR_MAN__DISP2_PWR_MAN_D3_CRTC2_EN            0x00000010L
+#define DISP_PWR_MAN__DISP_PWR_MAN_DPMS_MASK               0x00000300L
+#define DISP_PWR_MAN__DISP_D3_RST_MASK                     0x00010000L
+#define DISP_PWR_MAN__DISP_D3_RST                          0x00010000L
+#define DISP_PWR_MAN__DISP_D3_REG_RST_MASK                 0x00020000L
+#define DISP_PWR_MAN__DISP_D3_REG_RST                      0x00020000L
+#define DISP_PWR_MAN__DISP_D3_GRPH_RST_MASK                0x00040000L
+#define DISP_PWR_MAN__DISP_D3_GRPH_RST                     0x00040000L
+#define DISP_PWR_MAN__DISP_D3_SUBPIC_RST_MASK              0x00080000L
+#define DISP_PWR_MAN__DISP_D3_SUBPIC_RST                   0x00080000L
+#define DISP_PWR_MAN__DISP_D3_OV0_RST_MASK                 0x00100000L
+#define DISP_PWR_MAN__DISP_D3_OV0_RST                      0x00100000L
+#define DISP_PWR_MAN__DISP_D1D2_GRPH_RST_MASK              0x00200000L
+#define DISP_PWR_MAN__DISP_D1D2_GRPH_RST                   0x00200000L
+#define DISP_PWR_MAN__DISP_D1D2_SUBPIC_RST_MASK            0x00400000L
+#define DISP_PWR_MAN__DISP_D1D2_SUBPIC_RST                 0x00400000L
+#define DISP_PWR_MAN__DISP_D1D2_OV0_RST_MASK               0x00800000L
+#define DISP_PWR_MAN__DISP_D1D2_OV0_RST                    0x00800000L
+#define DISP_PWR_MAN__DIG_TMDS_ENABLE_RST_MASK             0x01000000L
+#define DISP_PWR_MAN__DIG_TMDS_ENABLE_RST                  0x01000000L
+#define DISP_PWR_MAN__TV_ENABLE_RST_MASK                   0x02000000L
+#define DISP_PWR_MAN__TV_ENABLE_RST                        0x02000000L
+#define DISP_PWR_MAN__AUTO_PWRUP_EN_MASK                   0x04000000L
+#define DISP_PWR_MAN__AUTO_PWRUP_EN                        0x04000000L
+
+// MC_IND_INDEX
+#define MC_IND_INDEX__MC_IND_ADDR_MASK                     0x0000001fL
+#define MC_IND_INDEX__MC_IND_WR_EN_MASK                    0x00000100L
+#define MC_IND_INDEX__MC_IND_WR_EN                         0x00000100L
+
+// MC_IND_DATA
+#define MC_IND_DATA__MC_IND_DATA_MASK                      0xffffffffL
+
+// MC_CHP_IO_CNTL_A1
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWN_CKA__SHIFT            0x00000000
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWN_AA__SHIFT             0x00000001
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQMA__SHIFT           0x00000002
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQSA__SHIFT           0x00000003
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWP_CKA__SHIFT            0x00000004
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWP_AA__SHIFT             0x00000005
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQMA__SHIFT           0x00000006
+#define	MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQSA__SHIFT           0x00000007
+#define	MC_CHP_IO_CNTL_A1__MEM_PREAMP_AA__SHIFT            0x00000008
+#define	MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQMA__SHIFT          0x00000009
+#define	MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQSA__SHIFT          0x0000000a
+#define	MC_CHP_IO_CNTL_A1__MEM_IO_MODEA__SHIFT             0x0000000c
+#define	MC_CHP_IO_CNTL_A1__MEM_REC_CKA__SHIFT              0x0000000e
+#define	MC_CHP_IO_CNTL_A1__MEM_REC_AA__SHIFT               0x00000010
+#define	MC_CHP_IO_CNTL_A1__MEM_REC_DQMA__SHIFT             0x00000012
+#define	MC_CHP_IO_CNTL_A1__MEM_REC_DQSA__SHIFT             0x00000014
+#define	MC_CHP_IO_CNTL_A1__MEM_SYNC_PHASEA__SHIFT          0x00000016
+#define	MC_CHP_IO_CNTL_A1__MEM_SYNC_CENTERA__SHIFT         0x00000017
+#define	MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA__SHIFT             0x00000018
+#define	MC_CHP_IO_CNTL_A1__MEM_CLK_SELA__SHIFT             0x0000001a
+#define	MC_CHP_IO_CNTL_A1__MEM_CLK_INVA__SHIFT             0x0000001c
+#define	MC_CHP_IO_CNTL_A1__MEM_DATA_ENIMP_A__SHIFT         0x0000001e
+#define	MC_CHP_IO_CNTL_A1__MEM_CNTL_ENIMP_A__SHIFT         0x0000001f
+
+// MC_CHP_IO_CNTL_B1
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWN_CKB__SHIFT            0x00000000
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWN_AB__SHIFT             0x00000001
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQMB__SHIFT           0x00000002
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQSB__SHIFT           0x00000003
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWP_CKB__SHIFT            0x00000004
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWP_AB__SHIFT             0x00000005
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQMB__SHIFT           0x00000006
+#define	MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQSB__SHIFT           0x00000007
+#define	MC_CHP_IO_CNTL_B1__MEM_PREAMP_AB__SHIFT            0x00000008
+#define	MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQMB__SHIFT          0x00000009
+#define	MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQSB__SHIFT          0x0000000a
+#define	MC_CHP_IO_CNTL_B1__MEM_IO_MODEB__SHIFT             0x0000000c
+#define	MC_CHP_IO_CNTL_B1__MEM_REC_CKB__SHIFT              0x0000000e
+#define	MC_CHP_IO_CNTL_B1__MEM_REC_AB__SHIFT               0x00000010
+#define	MC_CHP_IO_CNTL_B1__MEM_REC_DQMB__SHIFT             0x00000012
+#define	MC_CHP_IO_CNTL_B1__MEM_REC_DQSB__SHIFT             0x00000014
+#define	MC_CHP_IO_CNTL_B1__MEM_SYNC_PHASEB__SHIFT          0x00000016
+#define	MC_CHP_IO_CNTL_B1__MEM_SYNC_CENTERB__SHIFT         0x00000017
+#define	MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB__SHIFT             0x00000018
+#define	MC_CHP_IO_CNTL_B1__MEM_CLK_SELB__SHIFT             0x0000001a
+#define	MC_CHP_IO_CNTL_B1__MEM_CLK_INVB__SHIFT             0x0000001c
+#define	MC_CHP_IO_CNTL_B1__MEM_DATA_ENIMP_B__SHIFT         0x0000001e
+#define	MC_CHP_IO_CNTL_B1__MEM_CNTL_ENIMP_B__SHIFT         0x0000001f
+
+// MC_CHP_IO_CNTL_A1
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_CKA_MASK              0x00000001L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_CKA                   0x00000001L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_AA_MASK               0x00000002L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_AA                    0x00000002L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQMA_MASK             0x00000004L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQMA                  0x00000004L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQSA_MASK             0x00000008L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWN_DQSA                  0x00000008L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_CKA_MASK              0x00000010L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_CKA                   0x00000010L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_AA_MASK               0x00000020L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_AA                    0x00000020L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQMA_MASK             0x00000040L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQMA                  0x00000040L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQSA_MASK             0x00000080L
+#define MC_CHP_IO_CNTL_A1__MEM_SLEWP_DQSA                  0x00000080L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_AA_MASK              0x00000100L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_AA                   0x00000100L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQMA_MASK            0x00000200L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQMA                 0x00000200L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQSA_MASK            0x00000400L
+#define MC_CHP_IO_CNTL_A1__MEM_PREAMP_DQSA                 0x00000400L
+#define MC_CHP_IO_CNTL_A1__MEM_IO_MODEA_MASK               0x00003000L
+#define MC_CHP_IO_CNTL_A1__MEM_REC_CKA_MASK                0x0000c000L
+#define MC_CHP_IO_CNTL_A1__MEM_REC_AA_MASK                 0x00030000L
+#define MC_CHP_IO_CNTL_A1__MEM_REC_DQMA_MASK               0x000c0000L
+#define MC_CHP_IO_CNTL_A1__MEM_REC_DQSA_MASK               0x00300000L
+#define MC_CHP_IO_CNTL_A1__MEM_SYNC_PHASEA_MASK            0x00400000L
+#define MC_CHP_IO_CNTL_A1__MEM_SYNC_PHASEA                 0x00400000L
+#define MC_CHP_IO_CNTL_A1__MEM_SYNC_CENTERA_MASK           0x00800000L
+#define MC_CHP_IO_CNTL_A1__MEM_SYNC_CENTERA                0x00800000L
+#define MC_CHP_IO_CNTL_A1__MEM_SYNC_ENA_MASK               0x03000000L
+#define MC_CHP_IO_CNTL_A1__MEM_CLK_SELA_MASK               0x0c000000L
+#define MC_CHP_IO_CNTL_A1__MEM_CLK_INVA_MASK               0x10000000L
+#define MC_CHP_IO_CNTL_A1__MEM_CLK_INVA                    0x10000000L
+#define MC_CHP_IO_CNTL_A1__MEM_DATA_ENIMP_A_MASK           0x40000000L
+#define MC_CHP_IO_CNTL_A1__MEM_DATA_ENIMP_A                0x40000000L
+#define MC_CHP_IO_CNTL_A1__MEM_CNTL_ENIMP_A_MASK           0x80000000L
+#define MC_CHP_IO_CNTL_A1__MEM_CNTL_ENIMP_A                0x80000000L
+
+// MC_CHP_IO_CNTL_B1
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_CKB_MASK              0x00000001L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_CKB                   0x00000001L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_AB_MASK               0x00000002L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_AB                    0x00000002L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQMB_MASK             0x00000004L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQMB                  0x00000004L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQSB_MASK             0x00000008L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWN_DQSB                  0x00000008L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_CKB_MASK              0x00000010L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_CKB                   0x00000010L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_AB_MASK               0x00000020L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_AB                    0x00000020L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQMB_MASK             0x00000040L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQMB                  0x00000040L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQSB_MASK             0x00000080L
+#define MC_CHP_IO_CNTL_B1__MEM_SLEWP_DQSB                  0x00000080L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_AB_MASK              0x00000100L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_AB                   0x00000100L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQMB_MASK            0x00000200L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQMB                 0x00000200L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQSB_MASK            0x00000400L
+#define MC_CHP_IO_CNTL_B1__MEM_PREAMP_DQSB                 0x00000400L
+#define MC_CHP_IO_CNTL_B1__MEM_IO_MODEB_MASK               0x00003000L
+#define MC_CHP_IO_CNTL_B1__MEM_REC_CKB_MASK                0x0000c000L
+#define MC_CHP_IO_CNTL_B1__MEM_REC_AB_MASK                 0x00030000L
+#define MC_CHP_IO_CNTL_B1__MEM_REC_DQMB_MASK               0x000c0000L
+#define MC_CHP_IO_CNTL_B1__MEM_REC_DQSB_MASK               0x00300000L
+#define MC_CHP_IO_CNTL_B1__MEM_SYNC_PHASEB_MASK            0x00400000L
+#define MC_CHP_IO_CNTL_B1__MEM_SYNC_PHASEB                 0x00400000L
+#define MC_CHP_IO_CNTL_B1__MEM_SYNC_CENTERB_MASK           0x00800000L
+#define MC_CHP_IO_CNTL_B1__MEM_SYNC_CENTERB                0x00800000L
+#define MC_CHP_IO_CNTL_B1__MEM_SYNC_ENB_MASK               0x03000000L
+#define MC_CHP_IO_CNTL_B1__MEM_CLK_SELB_MASK               0x0c000000L
+#define MC_CHP_IO_CNTL_B1__MEM_CLK_INVB_MASK               0x10000000L
+#define MC_CHP_IO_CNTL_B1__MEM_CLK_INVB                    0x10000000L
+#define MC_CHP_IO_CNTL_B1__MEM_DATA_ENIMP_B_MASK           0x40000000L
+#define MC_CHP_IO_CNTL_B1__MEM_DATA_ENIMP_B                0x40000000L
+#define MC_CHP_IO_CNTL_B1__MEM_CNTL_ENIMP_B_MASK           0x80000000L
+#define MC_CHP_IO_CNTL_B1__MEM_CNTL_ENIMP_B                0x80000000L
+
+// MEM_SDRAM_MODE_REG
+#define MEM_SDRAM_MODE_REG__MEM_MODE_REG_MASK              0x00007fffL
+#define MEM_SDRAM_MODE_REG__MEM_WR_LATENCY_MASK            0x000f0000L
+#define MEM_SDRAM_MODE_REG__MEM_CAS_LATENCY_MASK           0x00700000L
+#define MEM_SDRAM_MODE_REG__MEM_CMD_LATENCY_MASK           0x00800000L
+#define MEM_SDRAM_MODE_REG__MEM_CMD_LATENCY                0x00800000L
+#define MEM_SDRAM_MODE_REG__MEM_STR_LATENCY_MASK           0x01000000L
+#define MEM_SDRAM_MODE_REG__MEM_STR_LATENCY                0x01000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_CMD_MASK          0x02000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_CMD               0x02000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_DATA_MASK         0x04000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_DATA              0x04000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_STR_MASK          0x08000000L
+#define MEM_SDRAM_MODE_REG__MEM_FALL_OUT_STR               0x08000000L
+#define MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE_MASK          0x10000000L
+#define MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE               0x10000000L
+#define MEM_SDRAM_MODE_REG__MEM_DDR_DLL_MASK               0x20000000L
+#define MEM_SDRAM_MODE_REG__MEM_DDR_DLL                    0x20000000L
+#define MEM_SDRAM_MODE_REG__MEM_CFG_TYPE_MASK              0x40000000L
+#define MEM_SDRAM_MODE_REG__MEM_CFG_TYPE                   0x40000000L
+#define MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET_MASK           0x80000000L
+#define MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET                0x80000000L
+
+// MEM_SDRAM_MODE_REG
+#define	MEM_SDRAM_MODE_REG__MEM_MODE_REG__SHIFT            0x00000000
+#define	MEM_SDRAM_MODE_REG__MEM_WR_LATENCY__SHIFT          0x00000010
+#define	MEM_SDRAM_MODE_REG__MEM_CAS_LATENCY__SHIFT         0x00000014
+#define	MEM_SDRAM_MODE_REG__MEM_CMD_LATENCY__SHIFT         0x00000017
+#define	MEM_SDRAM_MODE_REG__MEM_STR_LATENCY__SHIFT         0x00000018
+#define	MEM_SDRAM_MODE_REG__MEM_FALL_OUT_CMD__SHIFT        0x00000019
+#define	MEM_SDRAM_MODE_REG__MEM_FALL_OUT_DATA__SHIFT       0x0000001a
+#define	MEM_SDRAM_MODE_REG__MEM_FALL_OUT_STR__SHIFT        0x0000001b
+#define	MEM_SDRAM_MODE_REG__MC_INIT_COMPLETE__SHIFT        0x0000001c
+#define	MEM_SDRAM_MODE_REG__MEM_DDR_DLL__SHIFT             0x0000001d
+#define	MEM_SDRAM_MODE_REG__MEM_CFG_TYPE__SHIFT            0x0000001e
+#define	MEM_SDRAM_MODE_REG__MEM_SDRAM_RESET__SHIFT         0x0000001f
+
+// MEM_REFRESH_CNTL
+#define MEM_REFRESH_CNTL__MEM_REFRESH_RATE_MASK            0x000000ffL
+#define MEM_REFRESH_CNTL__MEM_REFRESH_DIS_MASK             0x00000100L
+#define MEM_REFRESH_CNTL__MEM_REFRESH_DIS                  0x00000100L
+#define MEM_REFRESH_CNTL__MEM_DYNAMIC_CKE_MASK             0x00000200L
+#define MEM_REFRESH_CNTL__MEM_DYNAMIC_CKE                  0x00000200L
+#define MEM_REFRESH_CNTL__MEM_TRFC_MASK                    0x0000f000L
+#define MEM_REFRESH_CNTL__MEM_CLKA0_ENABLE_MASK            0x00010000L
+#define MEM_REFRESH_CNTL__MEM_CLKA0_ENABLE                 0x00010000L
+#define MEM_REFRESH_CNTL__MEM_CLKA0b_ENABLE_MASK           0x00020000L
+#define MEM_REFRESH_CNTL__MEM_CLKA0b_ENABLE                0x00020000L
+#define MEM_REFRESH_CNTL__MEM_CLKA1_ENABLE_MASK            0x00040000L
+#define MEM_REFRESH_CNTL__MEM_CLKA1_ENABLE                 0x00040000L
+#define MEM_REFRESH_CNTL__MEM_CLKA1b_ENABLE_MASK           0x00080000L
+#define MEM_REFRESH_CNTL__MEM_CLKA1b_ENABLE                0x00080000L
+#define MEM_REFRESH_CNTL__MEM_CLKAFB_ENABLE_MASK           0x00100000L
+#define MEM_REFRESH_CNTL__MEM_CLKAFB_ENABLE                0x00100000L
+#define MEM_REFRESH_CNTL__DLL_FB_SLCT_CKA_MASK             0x00c00000L
+#define MEM_REFRESH_CNTL__MEM_CLKB0_ENABLE_MASK            0x01000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB0_ENABLE                 0x01000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB0b_ENABLE_MASK           0x02000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB0b_ENABLE                0x02000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB1_ENABLE_MASK            0x04000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB1_ENABLE                 0x04000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB1b_ENABLE_MASK           0x08000000L
+#define MEM_REFRESH_CNTL__MEM_CLKB1b_ENABLE                0x08000000L
+#define MEM_REFRESH_CNTL__MEM_CLKBFB_ENABLE_MASK           0x10000000L
+#define MEM_REFRESH_CNTL__MEM_CLKBFB_ENABLE                0x10000000L
+#define MEM_REFRESH_CNTL__DLL_FB_SLCT_CKB_MASK             0xc0000000L
+
+// MC_STATUS
+#define MC_STATUS__MEM_PWRUP_COMPL_A_MASK                  0x00000001L
+#define MC_STATUS__MEM_PWRUP_COMPL_A                       0x00000001L
+#define MC_STATUS__MEM_PWRUP_COMPL_B_MASK                  0x00000002L
+#define MC_STATUS__MEM_PWRUP_COMPL_B                       0x00000002L
+#define MC_STATUS__MC_IDLE_MASK                            0x00000004L
+#define MC_STATUS__MC_IDLE                                 0x00000004L
+#define MC_STATUS__IMP_N_VALUE_R_BACK_MASK                 0x00000078L
+#define MC_STATUS__IMP_P_VALUE_R_BACK_MASK                 0x00000780L
+#define MC_STATUS__TEST_OUT_R_BACK_MASK                    0x00000800L
+#define MC_STATUS__TEST_OUT_R_BACK                         0x00000800L
+#define MC_STATUS__DUMMY_OUT_R_BACK_MASK                   0x00001000L
+#define MC_STATUS__DUMMY_OUT_R_BACK                        0x00001000L
+#define MC_STATUS__IMP_N_VALUE_A_R_BACK_MASK               0x0001e000L
+#define MC_STATUS__IMP_P_VALUE_A_R_BACK_MASK               0x001e0000L
+#define MC_STATUS__IMP_N_VALUE_CK_R_BACK_MASK              0x01e00000L
+#define MC_STATUS__IMP_P_VALUE_CK_R_BACK_MASK              0x1e000000L
+
+// MDLL_CKO
+#define MDLL_CKO__MCKOA_SLEEP_MASK                         0x00000001L
+#define MDLL_CKO__MCKOA_SLEEP                              0x00000001L
+#define MDLL_CKO__MCKOA_RESET_MASK                         0x00000002L
+#define MDLL_CKO__MCKOA_RESET                              0x00000002L
+#define MDLL_CKO__MCKOA_RANGE_MASK                         0x0000000cL
+#define MDLL_CKO__ERSTA_SOUTSEL_MASK                       0x00000030L
+#define MDLL_CKO__MCKOA_FB_SEL_MASK                        0x000000c0L
+#define MDLL_CKO__MCKOA_REF_SKEW_MASK                      0x00000700L
+#define MDLL_CKO__MCKOA_FB_SKEW_MASK                       0x00007000L
+#define MDLL_CKO__MCKOA_BP_SEL_MASK                        0x00008000L
+#define MDLL_CKO__MCKOA_BP_SEL                             0x00008000L
+#define MDLL_CKO__MCKOB_SLEEP_MASK                         0x00010000L
+#define MDLL_CKO__MCKOB_SLEEP                              0x00010000L
+#define MDLL_CKO__MCKOB_RESET_MASK                         0x00020000L
+#define MDLL_CKO__MCKOB_RESET                              0x00020000L
+#define MDLL_CKO__MCKOB_RANGE_MASK                         0x000c0000L
+#define MDLL_CKO__ERSTB_SOUTSEL_MASK                       0x00300000L
+#define MDLL_CKO__MCKOB_FB_SEL_MASK                        0x00c00000L
+#define MDLL_CKO__MCKOB_REF_SKEW_MASK                      0x07000000L
+#define MDLL_CKO__MCKOB_FB_SKEW_MASK                       0x70000000L
+#define MDLL_CKO__MCKOB_BP_SEL_MASK                        0x80000000L
+#define MDLL_CKO__MCKOB_BP_SEL                             0x80000000L
+
+// MDLL_RDCKA
+#define MDLL_RDCKA__MRDCKA0_SLEEP_MASK                     0x00000001L
+#define MDLL_RDCKA__MRDCKA0_SLEEP                          0x00000001L
+#define MDLL_RDCKA__MRDCKA0_RESET_MASK                     0x00000002L
+#define MDLL_RDCKA__MRDCKA0_RESET                          0x00000002L
+#define MDLL_RDCKA__MRDCKA0_RANGE_MASK                     0x0000000cL
+#define MDLL_RDCKA__MRDCKA0_REF_SEL_MASK                   0x00000030L
+#define MDLL_RDCKA__MRDCKA0_FB_SEL_MASK                    0x000000c0L
+#define MDLL_RDCKA__MRDCKA0_REF_SKEW_MASK                  0x00000700L
+#define MDLL_RDCKA__MRDCKA0_SINSEL_MASK                    0x00000800L
+#define MDLL_RDCKA__MRDCKA0_SINSEL                         0x00000800L
+#define MDLL_RDCKA__MRDCKA0_FB_SKEW_MASK                   0x00007000L
+#define MDLL_RDCKA__MRDCKA0_BP_SEL_MASK                    0x00008000L
+#define MDLL_RDCKA__MRDCKA0_BP_SEL                         0x00008000L
+#define MDLL_RDCKA__MRDCKA1_SLEEP_MASK                     0x00010000L
+#define MDLL_RDCKA__MRDCKA1_SLEEP                          0x00010000L
+#define MDLL_RDCKA__MRDCKA1_RESET_MASK                     0x00020000L
+#define MDLL_RDCKA__MRDCKA1_RESET                          0x00020000L
+#define MDLL_RDCKA__MRDCKA1_RANGE_MASK                     0x000c0000L
+#define MDLL_RDCKA__MRDCKA1_REF_SEL_MASK                   0x00300000L
+#define MDLL_RDCKA__MRDCKA1_FB_SEL_MASK                    0x00c00000L
+#define MDLL_RDCKA__MRDCKA1_REF_SKEW_MASK                  0x07000000L
+#define MDLL_RDCKA__MRDCKA1_SINSEL_MASK                    0x08000000L
+#define MDLL_RDCKA__MRDCKA1_SINSEL                         0x08000000L
+#define MDLL_RDCKA__MRDCKA1_FB_SKEW_MASK                   0x70000000L
+#define MDLL_RDCKA__MRDCKA1_BP_SEL_MASK                    0x80000000L
+#define MDLL_RDCKA__MRDCKA1_BP_SEL                         0x80000000L
+
+// MDLL_RDCKB
+#define MDLL_RDCKB__MRDCKB0_SLEEP_MASK                     0x00000001L
+#define MDLL_RDCKB__MRDCKB0_SLEEP                          0x00000001L
+#define MDLL_RDCKB__MRDCKB0_RESET_MASK                     0x00000002L
+#define MDLL_RDCKB__MRDCKB0_RESET                          0x00000002L
+#define MDLL_RDCKB__MRDCKB0_RANGE_MASK                     0x0000000cL
+#define MDLL_RDCKB__MRDCKB0_REF_SEL_MASK                   0x00000030L
+#define MDLL_RDCKB__MRDCKB0_FB_SEL_MASK                    0x000000c0L
+#define MDLL_RDCKB__MRDCKB0_REF_SKEW_MASK                  0x00000700L
+#define MDLL_RDCKB__MRDCKB0_SINSEL_MASK                    0x00000800L
+#define MDLL_RDCKB__MRDCKB0_SINSEL                         0x00000800L
+#define MDLL_RDCKB__MRDCKB0_FB_SKEW_MASK                   0x00007000L
+#define MDLL_RDCKB__MRDCKB0_BP_SEL_MASK                    0x00008000L
+#define MDLL_RDCKB__MRDCKB0_BP_SEL                         0x00008000L
+#define MDLL_RDCKB__MRDCKB1_SLEEP_MASK                     0x00010000L
+#define MDLL_RDCKB__MRDCKB1_SLEEP                          0x00010000L
+#define MDLL_RDCKB__MRDCKB1_RESET_MASK                     0x00020000L
+#define MDLL_RDCKB__MRDCKB1_RESET                          0x00020000L
+#define MDLL_RDCKB__MRDCKB1_RANGE_MASK                     0x000c0000L
+#define MDLL_RDCKB__MRDCKB1_REF_SEL_MASK                   0x00300000L
+#define MDLL_RDCKB__MRDCKB1_FB_SEL_MASK                    0x00c00000L
+#define MDLL_RDCKB__MRDCKB1_REF_SKEW_MASK                  0x07000000L
+#define MDLL_RDCKB__MRDCKB1_SINSEL_MASK                    0x08000000L
+#define MDLL_RDCKB__MRDCKB1_SINSEL                         0x08000000L
+#define MDLL_RDCKB__MRDCKB1_FB_SKEW_MASK                   0x70000000L
+#define MDLL_RDCKB__MRDCKB1_BP_SEL_MASK                    0x80000000L
+#define MDLL_RDCKB__MRDCKB1_BP_SEL                         0x80000000L
+
+#define pllVCLK_ECP_CNTL                            0x0008
+#define pllDISP_TEST_MACRO_RW_WRITE                 0x001A
+#define pllDISP_TEST_MACRO_RW_READ                  0x001B
+#define pllDISP_TEST_MACRO_RW_DATA                  0x001C
+#define pllDISP_TEST_MACRO_RW_CNTL                  0x001D
+#define pllPIXCLKS_CNTL                             0x002D
+#define pllPPLL_DIV_0                               0x0004
+#define pllPPLL_DIV_1                               0x0005
+#define pllPPLL_DIV_2                               0x0006
+#define pllPPLL_DIV_3                               0x0007
+#define pllHTOTAL_CNTL                              0x0009
+#define pllPLL_TEST_CNTL_M6                         0x0013
+#define pllP2PLL_DIV_0                              0x002C
+#define pllHTOTAL2_CNTL                             0x002E
+#define pllCLK_PIN_CNTL                             0x0001
+#define pllPPLL_CNTL                                0x0002
+#define pllPPLL_REF_DIV                             0x0003
+#define pllSPLL_CNTL                                0x000C
+#define pllSPLL_AUX_CNTL                            0x0024
+#define pllSCLK_CNTL_M6                             0x000D
+#define pllAGP_PLL_CNTL                             0x000B
+#define pllTV_PLL_FINE_CNTL                         0x0020
+#define pllTV_PLL_CNTL                              0x0021
+#define pllTV_PLL_CNTL1                             0x0022
+#define pllTV_DTO_INCREMENTS                        0x0023
+#define pllP2PLL_CNTL                               0x002A
+#define pllP2PLL_REF_DIV                            0x002B
+#define pllSSPLL_CNTL                               0x0030
+#define pllSSPLL_REF_DIV                            0x0031
+#define pllSSPLL_DIV_0                              0x0032
+#define pllSS_INT_CNTL                              0x0033
+#define pllSS_TST_CNTL                              0x0034
+#define pllSCLK_MORE_CNTL                           0x0035
+#define pllCLK_PWRMGT_CNTL_M6                       0x0014
+#define pllPLL_PWRMGT_CNTL                          0x0015
+#define pllM_SPLL_REF_FB_DIV                        0x000A
+#define pllMPLL_CNTL                                0x000E
+#define pllMPLL_AUX_CNTL                            0x0025
+#define pllMDLL_CKO                                 0x000F
+#define pllMDLL_RDCKA                               0x0010
+#define pllMDLL_RDCKB                               0x0011
+#define pllMCLK_CNTL_M6                             0x0012
+#define pllMCLK_MISC                                0x001F
+#define pllCG_TEST_MACRO_RW_WRITE                   0x0016
+#define pllCG_TEST_MACRO_RW_READ                    0x0017
+#define pllCG_TEST_MACRO_RW_DATA                    0x0018
+#define pllCG_TEST_MACRO_RW_CNTL                    0x0019
+
+#define ixMC_PERF_CNTL                             0x0000
+#define ixMC_PERF_SEL                              0x0001
+#define ixMC_PERF_REGION_0                         0x0002
+#define ixMC_PERF_REGION_1                         0x0003
+#define ixMC_PERF_COUNT_0                          0x0004
+#define ixMC_PERF_COUNT_1                          0x0005
+#define ixMC_PERF_COUNT_2                          0x0006
+#define ixMC_PERF_COUNT_3                          0x0007
+#define ixMC_PERF_COUNT_MEMCH_A                    0x0008
+#define ixMC_PERF_COUNT_MEMCH_B                    0x0009
+#define ixMC_IMP_CNTL                              0x000A
+#define ixMC_CHP_IO_CNTL_A0                        0x000B
+#define ixMC_CHP_IO_CNTL_A1                        0x000C
+#define ixMC_CHP_IO_CNTL_B0                        0x000D
+#define ixMC_CHP_IO_CNTL_B1                        0x000E
+#define ixMC_IMP_CNTL_0                            0x000F
+#define ixTC_MISMATCH_1                            0x0010
+#define ixTC_MISMATCH_2                            0x0011
+#define ixMC_BIST_CTRL                             0x0012
+#define ixREG_COLLAR_WRITE                         0x0013
+#define ixREG_COLLAR_READ                          0x0014
+
+
+
 
 #endif	/* _RADEON_H */
 

--=-m+GI2G6Nn/nYjyiXbFnO--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

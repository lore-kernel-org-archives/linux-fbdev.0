From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][I810FB]: Updates to Intel 810/815 Framebuffer Driver
Date: Tue, 15 Jun 2004 13:05:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406151304.42980.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba68r-0008Ng-V7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 22:05:49 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba68q-0001Jt-QC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 22:05:48 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 4B6175FD789
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Jun 2004 04:28:12 +0000 (UTC)
Content-Disposition: inline
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

The patch adds/fixes the following to i810fb:

1. Fix hardware cursor corruption.  

2. Preliminary I2C/DDC support.

3. Rounds up xres and yres in i810fb_check_var()  instead of rounding down.
This allows bootsplash (www.bootsplash.org) to work with i810fb.

4. Added myself to MAINTAINERS file.

The diff is against linux-2.6.6.  Please apply.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

Tony

diff -Naur linux-2.6.6-orig/MAINTAINERS linux-2.6.6/MAINTAINERS
--- linux-2.6.6-orig/MAINTAINERS	2004-05-10 02:32:39.000000000 +0000
+++ linux-2.6.6/MAINTAINERS	2004-06-15 03:40:59.000000000 +0000
@@ -1044,6 +1044,12 @@
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
+INTEL 810/815 FRAMEBUFFER DRIVER
+P:      Antonino Daplas
+M:      adaplas@pol.net
+L:      linux-fbdev-devel@lists.sourceforge.net
+S:      Maintained
+
 INTEL APIC/IOAPIC, LOWLEVEL X86 SMP SUPPORT
 P:	Ingo Molnar
 M:	mingo@redhat.com
diff -Naur linux-2.6.6-orig/drivers/video/Kconfig linux-2.6.6/drivers/video/Kconfig
--- linux-2.6.6-orig/drivers/video/Kconfig	2004-05-10 02:31:59.000000000 +0000
+++ linux-2.6.6/drivers/video/Kconfig	2004-06-15 03:36:48.000000000 +0000
@@ -441,6 +441,11 @@
   
           If unsure, say N.
 
+config FB_I810_I2C
+	bool "Enable DDC Support"
+	depends on FB_I810 && I2C
+	help
+
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
diff -Naur linux-2.6.6-orig/drivers/video/fbmon.c linux-2.6.6/drivers/video/fbmon.c
--- linux-2.6.6-orig/drivers/video/fbmon.c	2004-05-10 02:33:19.000000000 +0000
+++ linux-2.6.6/drivers/video/fbmon.c	2004-06-15 04:00:46.804251968 +0000
@@ -786,7 +786,7 @@
 {
 	unsigned char *pedid = NULL;
 
-#if defined(CONFIG_EDID_FIRMWARE) && defined(CONFIG_X86)
+#if defined(CONFIG_X86)
 	pedid = edid_info.dummy;
 	if (!pedid)
 		return NULL;
diff -Naur linux-2.6.6-orig/drivers/video/i810/Makefile linux-2.6.6/drivers/video/i810/Makefile
--- linux-2.6.6-orig/drivers/video/i810/Makefile	2004-05-10 02:32:27.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/Makefile	2004-06-15 03:36:48.000000000 +0000
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_FB_I810)		+= i810fb.o
-
+obj-$(CONFIG_FB_I810_I2C)       += i810-i2c.o
 
 i810fb-objs                     := i810_main.o i810_accel.o
 
diff -Naur linux-2.6.6-orig/drivers/video/i810/i810-i2c.c linux-2.6.6/drivers/video/i810/i810-i2c.c
--- linux-2.6.6-orig/drivers/video/i810/i810-i2c.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/i810-i2c.c	2004-06-15 03:37:17.000000000 +0000
@@ -0,0 +1,243 @@
+ /*-*- linux-c -*-
+ *  linux/drivers/video/i810-i2c.c -- Intel 810/815 I2C support 
+ *
+ *      Copyright (C) 2004 Antonino Daplas<adaplas@pol.net>
+ *      All Rights Reserved      
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+#include "i810.h"
+#include "i810_regs.h"
+#include "../edid.h"
+
+#define I810_DDC 0x51
+/* bit locations in the registers */
+#define SCL_DIR_MASK		0x0001
+#define SCL_DIR			0x0002
+#define SCL_VAL_MASK		0x0004
+#define SCL_VAL_OUT		0x0008
+#define SCL_VAL_IN		0x0010
+#define SDA_DIR_MASK		0x0100
+#define SDA_DIR			0x0200
+#define SDA_VAL_MASK		0x0400
+#define SDA_VAL_OUT		0x0800
+#define SDA_VAL_IN		0x1000
+
+#define DEBUG  /* define this for verbose EDID parsing output */
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...) printk(fmt,## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+static void i810i2c_setscl(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                        *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOB, (state ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
+	i810_readl(mmio, GPIOB);	/* flush posted write */
+}
+
+static void i810i2c_setsda(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                        *mmio = par->mmio_start_virtual;
+	
+ 	i810_writel(mmio, GPIOB, (state ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
+	i810_readl(mmio, GPIOB);	/* flush posted write */
+}
+
+static int i810i2c_getscl(void *data)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                        *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOB, SCL_DIR_MASK);
+	i810_writel(mmio, GPIOB, 0);
+	return (0 != (i810_readl(mmio, GPIOB) & SCL_VAL_IN));
+}
+
+static int i810i2c_getsda(void *data)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                        *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOB, SDA_DIR_MASK);
+	i810_writel(mmio, GPIOB, 0);
+	return (0 != (i810_readl(mmio, GPIOB) & SDA_VAL_IN));
+}
+
+static void i810ddc_setscl(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par       *par = chan->par;
+	u8                      *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOA, (state ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
+	i810_readl(mmio, GPIOA);	/* flush posted write */
+}
+
+static void i810ddc_setsda(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                      *mmio = par->mmio_start_virtual;
+	
+ 	i810_writel(mmio, GPIOA, (state ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
+	i810_readl(mmio, GPIOA);	/* flush posted write */
+}
+
+static int i810ddc_getscl(void *data)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                      *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOA, SCL_DIR_MASK);
+	i810_writel(mmio, GPIOA, 0);
+	return (0 != (i810_readl(mmio, GPIOA) & SCL_VAL_IN));
+}
+
+static int i810ddc_getsda(void *data)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                      *mmio = par->mmio_start_virtual;
+	
+	i810_writel(mmio, GPIOA, SDA_DIR_MASK);
+	i810_writel(mmio, GPIOA, 0);
+	return (0 != (i810_readl(mmio, GPIOA) & SDA_VAL_IN));
+}
+
+#define I2C_ALGO_DDC_I810   0x0e0000
+#define I2C_ALGO_I2C_I810   0x0f0000
+static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name, int conn)
+{
+        int rc;
+
+        strcpy(chan->adapter.name, name);
+        chan->adapter.owner             = THIS_MODULE;
+        chan->adapter.algo_data         = &chan->algo;
+        chan->adapter.dev.parent        = &chan->par->dev->dev;
+	switch (conn) {
+	case 1:
+		chan->adapter.id                = I2C_ALGO_DDC_I810;
+		chan->algo.setsda               = i810ddc_setsda;
+		chan->algo.setscl               = i810ddc_setscl;
+		chan->algo.getsda               = i810ddc_getsda;
+		chan->algo.getscl               = i810ddc_getscl;
+		break;
+	case 2:
+		chan->adapter.id                = I2C_ALGO_I2C_I810;
+		chan->algo.setsda               = i810i2c_setsda;
+		chan->algo.setscl               = i810i2c_setscl;
+		chan->algo.getsda               = i810i2c_getsda;
+		chan->algo.getscl               = i810i2c_getscl;
+		break;
+	}
+	chan->algo.udelay               = 40;
+	chan->algo.mdelay               = 40;
+        chan->algo.timeout              = 20;
+        chan->algo.data                 = chan;
+        
+        i2c_set_adapdata(&chan->adapter, chan);
+        
+        /* Raise SCL and SDA */
+        chan->algo.setsda(chan, 1);
+        chan->algo.setscl(chan, 1);
+        udelay(20);
+
+        rc = i2c_bit_add_bus(&chan->adapter);
+        if (rc == 0) 
+                dev_dbg(&chan->par->dev->dev, "I2C bus %s registered.\n", name);
+        else
+                dev_warn(&chan->par->dev->dev, "Failed to register I2C bus %s.\n", name);
+        return rc;
+}
+
+void i810_create_i2c_busses(struct i810fb_par *par)
+{
+        par->chan[0].par        = par;
+	par->chan[1].par        = par;
+	i810_setup_i2c_bus(&par->chan[0], "I810-DDC", 1);
+	i810_setup_i2c_bus(&par->chan[1], "I810-I2C", 2);
+}
+
+void i810_delete_i2c_busses(struct i810fb_par *par)
+{
+        if (par->chan[0].par)
+                i2c_bit_del_bus(&par->chan[0].adapter);
+        par->chan[0].par = NULL;
+	if (par->chan[1].par)
+		i2c_bit_del_bus(&par->chan[1].adapter);
+	par->chan[1].par = NULL;
+}
+
+static u8 *i810_do_probe_i2c_edid(struct i810fb_i2c_chan *chan)
+{
+        u8 start = 0x0;
+        struct i2c_msg msgs[] = {
+                {
+                        .addr   = I810_DDC,
+                        .len    = 1,
+                        .buf    = &start,
+                }, {
+                        .addr   = I810_DDC,
+                        .flags  = I2C_M_RD,
+                        .len    = EDID_LENGTH,
+                },
+        };
+        u8 *buf;
+
+        buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+        if (!buf) {
+		DPRINTK("i810-i2c: Failed to allocate memory\n");
+                return NULL;
+        }
+        msgs[1].buf = buf;
+
+        if (i2c_transfer(&chan->adapter, msgs, 2) == 2) {
+		DPRINTK("i810-i2c: I2C Transfer successful\n");
+                return buf;
+	}
+        DPRINTK("i810-i2c: Unable to read EDID block.\n");
+        kfree(buf);
+        return NULL;
+}
+
+int i810_probe_i2c_connector(struct i810fb_par *par, u8 **out_edid, int conn)
+{
+        u8 *edid = NULL;
+        int i;
+
+	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn);
+        for (i = 0; i < 3; i++) {
+                /* Do the real work */
+                edid = i810_do_probe_i2c_edid(&par->chan[conn-1]);
+                if (edid) 
+                        break;
+        }
+        if (out_edid)
+                *out_edid = edid;
+        if (!edid) 
+                return 1;
+
+        return 0;
+}
+
+
diff -Naur linux-2.6.6-orig/drivers/video/i810/i810.h linux-2.6.6/drivers/video/i810/i810.h
--- linux-2.6.6-orig/drivers/video/i810/i810.h	2004-05-10 02:33:19.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/i810.h	2004-06-15 03:37:17.000000000 +0000
@@ -16,6 +16,9 @@
 #include <linux/list.h>
 #include <linux/agp_backend.h>
 #include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
 #include <video/vga.h>
 
 /* Fence */
@@ -240,6 +243,14 @@
 	u8 cr39, cr41, cr70, sr01, msr;
 };
 
+struct i810fb_par;
+
+struct i810fb_i2c_chan {
+	struct i810fb_par *par;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo;
+};
+
 struct i810fb_par {
 	struct mode_registers    regs;
 	struct state_registers   hw_state;
@@ -251,12 +262,14 @@
 	struct heap_data         iring;
 	struct heap_data         cursor_heap;
 	struct vgastate          state;
+	struct i810fb_i2c_chan   chan[2];
 	drm_agp_t                *drm_agp;
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
 	u32 pci_state[16];
 	unsigned long mmio_start_phys;
 	u8 *mmio_start_virtual;
+	u8 *edid;
 	u32 pitch;
 	u32 pixconf;
 	u32 watermark;
diff -Naur linux-2.6.6-orig/drivers/video/i810/i810_dvt.c linux-2.6.6/drivers/video/i810/i810_dvt.c
--- linux-2.6.6-orig/drivers/video/i810/i810_dvt.c	2004-05-10 02:33:13.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/i810_dvt.c	2004-06-15 03:37:17.000000000 +0000
@@ -193,19 +193,19 @@
 
 void round_off_xres(u32 *xres) 
 {
-	if (*xres < 800) 
+	if (*xres <= 640)
 		*xres = 640;
-	if (*xres < 1024 && *xres >= 800) 
+	else if (*xres <= 800)
 		*xres = 800;
-	if (*xres < 1152 && *xres >= 1024)
+	else if (*xres <= 1024)
 		*xres = 1024;
-	if (*xres < 1280 && *xres >= 1152)
+	else if (*xres <= 1152)
 		*xres = 1152;
-	if (*xres < 1600 && *xres >= 1280)
+	else if (*xres <= 1280)
 		*xres = 1280;
-	if (*xres >= 1600)
+	else 
 		*xres = 1600;
-}		
+}
 
 inline void round_off_yres(u32 *xres, u32 *yres)
 {
diff -Naur linux-2.6.6-orig/drivers/video/i810/i810_main.c linux-2.6.6/drivers/video/i810/i810_main.c
--- linux-2.6.6-orig/drivers/video/i810/i810_main.c	2004-05-10 02:32:27.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/i810_main.c	2004-06-15 03:37:17.000000000 +0000
@@ -1388,16 +1388,17 @@
 {
 	struct i810fb_par *par = (struct i810fb_par *)info->par;
 	u8 *mmio = par->mmio_start_virtual;	
-	u8 data[64 * 8];
-	
+
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP) 
 		return soft_cursor(info, cursor);
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
 		return -ENXIO;
 
-	if ((i810_readl(CURBASE, mmio) & 0xf) != par->cursor_heap.physical)
+	if ((i810_readl(CURBASE, mmio) & 0xf) != par->cursor_heap.physical) {
 		i810_init_cursor(par);
+		cursor->set |= FB_CUR_SETALL;
+	}
 
 	i810_enable_cursor(mmio, OFF);
 
@@ -1409,50 +1410,56 @@
 
 		info->cursor.image.dx = cursor->image.dx;
 		info->cursor.image.dy = cursor->image.dy;
-		
-		tmp = cursor->image.dx - info->var.xoffset;
-		tmp |= (cursor->image.dy - info->var.yoffset) << 16;
-	    
+		tmp = (info->cursor.image.dx - info->var.xoffset) & 0xffff;
+		tmp |= (info->cursor.image.dy - info->var.yoffset) << 16;
 		i810_writel(CURPOS, mmio, tmp);
 	}
 
 	if (cursor->set & FB_CUR_SETSIZE) {
+		i810_reset_cursor_image(par);
 		info->cursor.image.height = cursor->image.height;
 		info->cursor.image.width = cursor->image.width;
-		i810_reset_cursor_image(par);
 	}
 
 	if (cursor->set & FB_CUR_SETCMAP) {
-		info->cursor.image.fg_color = cursor->image.fg_color;
-		info->cursor.image.bg_color = cursor->image.bg_color;
 		i810_load_cursor_colors(cursor->image.fg_color,
 					cursor->image.bg_color,
 					info);
+		info->cursor.image.fg_color = cursor->image.fg_color;
+		info->cursor.image.bg_color = cursor->image.bg_color;
+
 	}
 
-	if (cursor->set & FB_CUR_SETSHAPE) {
+	if (cursor->set & (FB_CUR_SETSHAPE)) {
 		int size = ((info->cursor.image.width + 7) >> 3) * 
-			     info->cursor.image.height;
+			info->cursor.image.height;
 		int i;
+		u8 *data = kmalloc(64 * 8, GFP_KERNEL);
+
+		if (data == NULL)
+			return -ENOMEM;
+		info->cursor.image.data = cursor->image.data;
 
 		switch (info->cursor.rop) {
 		case ROP_XOR:
 			for (i = 0; i < size; i++)
-				data[i] = cursor->image.data[i] ^ info->cursor.mask[i]; 
+				data[i] = info->cursor.image.data[i] ^ info->cursor.mask[i]; 
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < size; i++)
-				data[i] = cursor->image.data[i] & info->cursor.mask[i]; 
+				data[i] = info->cursor.image.data[i] & info->cursor.mask[i]; 
 			break;
 		}
 		i810_load_cursor_image(info->cursor.image.width, 
 				       info->cursor.image.height, data,
 				       par);
+		kfree(data);
 	}
-
-	if (info->cursor.enable)
+	
+	if (info->cursor.enable) 
 		i810_enable_cursor(mmio, ON);
+
 	return 0;
 }
 
@@ -1641,9 +1648,11 @@
 		hsync1 = HFMIN;
 	if (!hsync2) 
 		hsync2 = HFMAX;
-	info->monspecs.hfmax = hsync2;
-	info->monspecs.hfmin = hsync1;
-	if (hsync2 < hsync1) 
+	if (!info->monspecs.hfmax)
+		info->monspecs.hfmax = hsync2;
+	if (!info->monspecs.hfmin)
+		info->monspecs.hfmin = hsync1;
+	if (hsync1 < hsync2) 
 		info->monspecs.hfmin = hsync2;
 
 	if (!vsync1)
@@ -1652,8 +1661,10 @@
 		vsync2 = VFMAX;
 	if (IS_DVT && vsync1 < 60)
 		vsync1 = 60;
-	info->monspecs.vfmax = vsync2;
-	info->monspecs.vfmin = vsync1;		
+	if (!info->monspecs.vfmax)
+		info->monspecs.vfmax = vsync2;
+	if (!info->monspecs.vfmin)
+		info->monspecs.vfmin = vsync1;		
 	if (vsync2 < vsync1) 
 		info->monspecs.vfmin = vsync2;
 }
@@ -1724,6 +1735,7 @@
 	pci_read_config_byte(par->dev, 0x50, &reg);
 	reg &= FREQ_MASK;
 	par->mem_freq = (reg) ? 133 : 100;
+
 }
 
 static int __devinit 
@@ -1836,8 +1848,9 @@
 {
 	struct fb_info    *info;
 	struct i810fb_par *par = NULL;
-	int err, vfreq, hfreq, pixclock;
+	int i, err = -1, vfreq, hfreq, pixclock;
 
+	i = 0;
 	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
 		return -ENOMEM;
@@ -1867,6 +1880,27 @@
 		return err;
 	}
 
+#ifdef CONFIG_FB_I810_I2C
+	i810_create_i2c_busses(par);
+	for (i = 0; i < 2; i++) {
+		err = i810_probe_i2c_connector(par, &par->edid, i+1);
+		if (!err)
+			break;
+	}
+	i810_delete_i2c_busses(par);
+	if (err) {
+		printk("i810fb_init_pci: I2C bus probing failed...\n");
+		printk("i810fb_init_pci: getting EDID from BIOS\n");
+		par->edid = kmalloc(128, GFP_KERNEL);
+		if(par->edid) 
+			memcpy(par->edid, (char *) get_EDID_from_firmware(NULL), 128);
+	} else { 
+		printk("i810fb_init_pci: DDC probe successful\n");
+	}
+	fb_edid_to_monspecs(par->edid, &info->monspecs);
+	if (info->monspecs.modedb == NULL)
+		printk("i810fb_init_pci: Unable to get Mode Database\n");
+#endif
 	i810_init_defaults(par, info);
 
 	if ((err = i810_alloc_agp_mem(info))) {
@@ -1941,6 +1975,8 @@
 			par->drm_agp = NULL;
 		}
 
+		if (par->edid)
+			kfree(par->edid);
 		if (par->mmio_start_virtual) 
 			iounmap(par->mmio_start_virtual);
 		if (par->aperture.virtual) 
@@ -1957,8 +1993,10 @@
 
 		kfree(par);
 	}
-	if (info) 
+	if (info) {
+		fb_destroy_modedb(info->monspecs.modedb);
 		kfree(info);
+	}
 }
 
 static void __exit i810fb_remove_pci(struct pci_dev *dev)
diff -Naur linux-2.6.6-orig/drivers/video/i810/i810_main.h linux-2.6.6/drivers/video/i810/i810_main.h
--- linux-2.6.6-orig/drivers/video/i810/i810_main.h	2004-05-10 02:32:52.000000000 +0000
+++ linux-2.6.6/drivers/video/i810/i810_main.h	2004-06-15 03:37:17.000000000 +0000
@@ -83,6 +83,12 @@
 extern void i810fb_init_ringbuffer(struct fb_info *info);
 extern void i810fb_load_front     (u32 offset, struct fb_info *info);
 
+/* I2C */
+extern int i810_probe_i2c_connector(struct i810fb_par *par, u8 **out_edid, int conn);
+extern void i810_create_i2c_busses(struct i810fb_par *par);
+extern void i810_delete_i2c_busses(struct i810fb_par *par);
+
+
 /* Conditionals */
 #ifdef CONFIG_X86
 inline void flush_cache(void)




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND

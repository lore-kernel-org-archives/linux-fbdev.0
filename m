From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/10] i810fb: Add i2c/DDC support
Date: Fri, 02 Sep 2005 05:44:21 +0800
Message-ID: <43177635.8020005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2t-0004mD-Hz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:31 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2r-0004SZ-RR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:31 -0700
Received: by wproxy.gmail.com with SMTP id i22so261051wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:24 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Add ddc/i2c support for i810fb.  This will allow the driver to
    get display information, especially for monitors with fickle timings.
    The i2c support depends on CONFIG_FB_I810_GTF.
    
    Changed __init* to __devinit*
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 Kconfig          |    5 +
 i810/Makefile    |    2 
 i810/i810-i2c.c  |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 i810/i810.h      |   13 ++
 i810/i810_main.c |  175 +++++++++++++++++++++++++++----------
 i810/i810_main.h |    7 +
 6 files changed, 413 insertions(+), 46 deletions(-)


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -751,6 +751,11 @@ config FB_I810_GTF
   
           If unsure, say N.
 
+config FB_I810_I2C
+	bool "Enable DDC Support"
+	depends on FB_I810 && I2C && FB_I810_GTF
+	help
+
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
 	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
diff --git a/drivers/video/i810/Makefile b/drivers/video/i810/Makefile
--- a/drivers/video/i810/Makefile
+++ b/drivers/video/i810/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_FB_I810)		+= i810fb.o
-
+obj-$(CONFIG_FB_I810_I2C)       += i810-i2c.o
 
 i810fb-objs                     := i810_main.o i810_accel.o
 
diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/i810/i810-i2c.c
@@ -0,0 +1,257 @@
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
+#define I810_DDC 0x50
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
+	i810_writel(mmio, GPIOB, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
+		    SCL_DIR_MASK | SCL_VAL_MASK);
+	i810_readl(mmio, GPIOB);	/* flush posted write */
+}
+
+static void i810i2c_setsda(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                        *mmio = par->mmio_start_virtual;
+	
+ 	i810_writel(mmio, GPIOB, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
+		    SDA_DIR_MASK | SDA_VAL_MASK);
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
+	i810_writel(mmio, GPIOA, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
+		    SCL_DIR_MASK | SCL_VAL_MASK);
+	i810_readl(mmio, GPIOA);	/* flush posted write */
+}
+
+static void i810ddc_setsda(void *data, int state)
+{
+        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_par         *par = chan->par;
+	u8                      *mmio = par->mmio_start_virtual;
+	
+ 	i810_writel(mmio, GPIOA, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
+		    SDA_DIR_MASK | SDA_VAL_MASK);
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
+static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name,
+			      int conn)
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
+	chan->algo.udelay               = 10;
+	chan->algo.mdelay               = 10;
+        chan->algo.timeout              = (HZ/2);
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
+                dev_dbg(&chan->par->dev->dev, "I2C bus %s registered.\n",name);
+        else
+                dev_warn(&chan->par->dev->dev, "Failed to register I2C bus "
+			 "%s.\n", name);
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
+int i810_probe_i2c_connector(struct fb_info *info, u8 **out_edid, int conn)
+{
+	struct i810fb_par *par = info->par;
+        u8 *edid = NULL;
+        int i;
+
+	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn);
+	if (conn < 3) {
+		for (i = 0; i < 3; i++) {
+			/* Do the real work */
+			edid = i810_do_probe_i2c_edid(&par->chan[conn-1]);
+			if (edid) 
+				break;
+		}
+	} else {
+		DPRINTK("i810-i2c: Getting EDID from BIOS\n");
+		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		if (edid)
+			memcpy(edid, fb_firmware_edid(info->device),
+			       EDID_LENGTH);
+	}
+
+        if (out_edid)
+                *out_edid = edid;
+
+        return (edid) ? 0 : 1;
+}
+
+
diff --git a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
--- a/drivers/video/i810/i810.h
+++ b/drivers/video/i810/i810.h
@@ -16,6 +16,9 @@
 #include <linux/list.h>
 #include <linux/agp_backend.h>
 #include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
 #include <video/vga.h>
 
 /* Fence */
@@ -240,6 +243,14 @@ struct state_registers {
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
@@ -251,10 +262,12 @@ struct i810fb_par {
 	struct heap_data         iring;
 	struct heap_data         cursor_heap;
 	struct vgastate          state;
+	struct i810fb_i2c_chan   chan[2];
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
 	unsigned long mmio_start_phys;
 	u8 __iomem *mmio_start_virtual;
+	u8 *edid;
 	u32 pitch;
 	u32 pixconf;
 	u32 watermark;
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -92,20 +92,21 @@ static struct pci_driver i810fb_driver =
 	.resume   =     i810fb_resume,
 };
 
-static int vram       __initdata = 4;
-static int bpp        __initdata = 8;
-static int mtrr       __initdata = 0;
-static int accel      __initdata = 0;
-static int hsync1     __initdata = 0;
-static int hsync2     __initdata = 0;
-static int vsync1     __initdata = 0;
-static int vsync2     __initdata = 0;
-static int xres       __initdata = 640;
-static int yres       __initdata = 480;
-static int vyres      __initdata = 0;
-static int sync       __initdata = 0;
-static int ext_vga    __initdata = 0;
-static int dcolor     __initdata = 0;
+static char *mode_option __devinitdata = NULL;
+static int vram       __devinitdata = 4;
+static int bpp        __devinitdata = 8;
+static int mtrr       __devinitdata = 0;
+static int accel      __devinitdata = 0;
+static int hsync1     __devinitdata = 0;
+static int hsync2     __devinitdata = 0;
+static int vsync1     __devinitdata = 0;
+static int vsync2     __devinitdata = 0;
+static int xres       __devinitdata = 640;
+static int yres       __devinitdata = 480;
+static int vyres      __devinitdata = 0;
+static int sync       __devinitdata = 0;
+static int ext_vga    __devinitdata = 0;
+static int dcolor     __devinitdata = 0;
 
 /*------------------------------------------------------------*/
 
@@ -947,31 +948,24 @@ static int i810_check_params(struct fb_v
 			     struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	int line_length, vidmem;
-	u32 xres, yres, vxres, vyres;
-
-	xres = var->xres;
-	yres = var->yres;
-	vxres = var->xres_virtual;
-	vyres = var->yres_virtual;
-
+	int line_length, vidmem, mode_valid = 0;
+	u32 vyres = var->yres_virtual, vxres = var->xres_virtual;
 	/*
 	 *  Memory limit
 	 */
-	line_length = get_line_length(par, vxres, 
-				      var->bits_per_pixel);
-
+	line_length = get_line_length(par, vxres, var->bits_per_pixel);
 	vidmem = line_length*vyres;
+
 	if (vidmem > par->fb.size) {
 		vyres = par->fb.size/line_length;
-		if (vyres < yres) {
+		if (vyres < var->yres) {
 			vyres = yres;
 			vxres = par->fb.size/vyres;
 			vxres /= var->bits_per_pixel >> 3;
 			line_length = get_line_length(par, vxres, 
 						      var->bits_per_pixel);
 			vidmem = line_length * yres;
-			if (vxres < xres) {
+			if (vxres < var->xres) {
 				printk("i810fb: required video memory, "
 				       "%d bytes, for %dx%d-%d (virtual) "
 				       "is out of range\n", 
@@ -981,6 +975,10 @@ static int i810_check_params(struct fb_v
 			}
 		}
 	}
+
+	var->xres_virtual = vxres;
+	var->yres_virtual = vyres;
+
 	/*
 	 * Monitor limit
 	 */
@@ -996,25 +994,39 @@ static int i810_check_params(struct fb_v
 		info->monspecs.dclkmax = 204000000;
 		break;
 	}
+
 	info->monspecs.dclkmin = 15000000;
 
-	if (fb_validate_mode(var, info)) {
+	if (!fb_validate_mode(var, info))
+		mode_valid = 1;
+
+#ifdef CONFIG_FB_I810_I2C
+	if (!mode_valid && info->monspecs.gtf &&
+	    !fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+		mode_valid = 1;
+	
+	if (!mode_valid && info->monspecs.modedb_len) {
+		struct fb_videomode *mode;
+
+		mode = fb_find_best_mode(var, &info->modelist);
+		if (mode) {
+			fb_videomode_to_var(var, mode);
+			mode_valid = 1;
+		}
+	}
+#endif	
+	if (!mode_valid && info->monspecs.modedb_len == 0) {
 		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info)) {
 			int default_sync = (info->monspecs.hfmin-HFMIN)
-						|(info->monspecs.hfmax-HFMAX)
-						|(info->monspecs.vfmin-VFMIN)
-						|(info->monspecs.vfmax-VFMAX);
+				|(info->monspecs.hfmax-HFMAX)
+				|(info->monspecs.vfmin-VFMIN)
+				|(info->monspecs.vfmax-VFMAX);
 			printk("i810fb: invalid video mode%s\n",
-			    default_sync ? "" :
-			    ". Specifying vsyncN/hsyncN parameters may help");
-			return -EINVAL;
+			       default_sync ? "" : ". Specifying "
+			       "vsyncN/hsyncN parameters may help");
 		}
-	}
-	
-	var->xres = xres;
-	var->yres = yres;
-	var->xres_virtual = vxres;
-	var->yres_virtual = vyres;
+	}		
+
 	return 0;
 }	
 
@@ -1812,8 +1824,68 @@ i810_allocate_pci_resource(struct i810fb
 	return 0;
 }
 
+static void __devinit i810fb_find_init_mode(struct fb_info *info)
+{
+	struct fb_videomode mode;
+	struct fb_var_screeninfo var;
+	struct i810fb_par *par = info->par;
+	struct fb_monspecs *specs = NULL;
+	int i, err, found = 0;
+
+	INIT_LIST_HEAD(&info->modelist);
+	memset(&mode, 0, sizeof(struct fb_videomode));
+	var = info->var;
+#ifdef CONFIG_FB_I810_I2C
+	i810_create_i2c_busses(par);
+
+	for (i = 0; i < 3; i++) {
+		err = i810_probe_i2c_connector(info, &par->edid, i+1);
+		if (!err)
+			break;
+	}
+
+	if (!err)
+		printk("i810fb_init_pci: DDC probe successful\n");
+
+	fb_edid_to_monspecs(par->edid, &info->monspecs);
+
+	if (info->monspecs.modedb == NULL)
+		printk("i810fb_init_pci: Unable to get Mode Database\n");
+	
+	specs = &info->monspecs;
+	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
+				 &info->modelist);
+	if (specs->modedb != NULL) {
+		if (specs->misc & FB_MISC_1ST_DETAIL) {
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
+					mode = specs->modedb[i];
+					found = 1;
+					break;
+				}
+			}
+		}
+		
+		if (!found) { 
+			mode = specs->modedb[0];
+			found = 1;
+		}		
+
+		fb_videomode_to_var(&var, &mode);
+	}
+#endif
+	if (mode_option)
+		fb_find_mode(&var, info, mode_option, specs->modedb,
+			     specs->modedb_len, (found) ? &mode : NULL, 
+			     info->var.bits_per_pixel);
+
+	info->var = var;
+	fb_destroy_modedb(specs->modedb);
+	specs->modedb = NULL;
+}
+
 #ifndef MODULE
-static int __init i810fb_setup(char *options)
+static int __devinit i810fb_setup(char *options)
 {
 	char *this_opt, *suffix = NULL;
 
@@ -1855,6 +1927,8 @@ static int __init i810fb_setup(char *opt
 			vsync2 = simple_strtoul(this_opt+7, NULL, 0);
 		else if (!strncmp(this_opt, "dcolor", 6))
 			dcolor = 1;
+		else 
+			mode_option = this_opt;
 	}
 	return 0;
 }
@@ -1865,6 +1939,7 @@ static int __devinit i810fb_init_pci (st
 {
 	struct fb_info    *info;
 	struct i810fb_par *par = NULL;
+	struct fb_videomode mode;
 	int i, err = -1, vfreq, hfreq, pixclock;
 
 	i = 0;
@@ -1873,7 +1948,7 @@ static int __devinit i810fb_init_pci (st
 	if (!info)
 		return -ENOMEM;
 
-	par = (struct i810fb_par *) info->par;
+	par = info->par;
 	par->dev = dev;
 
 	if (!(info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL))) {
@@ -1904,15 +1979,20 @@ static int __devinit i810fb_init_pci (st
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
 	fb_alloc_cmap(&info->cmap, 256, 0);
+	i810fb_find_init_mode(info);
 
 	if ((err = info->fbops->fb_check_var(&info->var, info))) {
 		i810fb_release_resource(info, par);
 		return err;
 	}
+	
+	fb_var_to_videomode(&mode, &info->var);
+	fb_add_videomode(&mode, &info->modelist);
 	encode_fix(&info->fix, info); 
 	 	    
 	i810fb_init_ringbuffer(info);
 	err = register_framebuffer(info);
+
 	if (err < 0) {
     		i810fb_release_resource(info, par); 
 		printk("i810fb_init: cannot register framebuffer device\n");
@@ -1951,6 +2031,8 @@ static void i810fb_release_resource(stru
 	struct gtt_data *gtt = &par->i810_gtt;
 	unset_mtrr(par);
 
+	i810_delete_i2c_busses(par);
+
 	if (par->i810_gtt.i810_cursor_memory)
 		agp_free_memory(gtt->i810_cursor_memory);
 	if (par->i810_gtt.i810_fb_memory)
@@ -1960,7 +2042,8 @@ static void i810fb_release_resource(stru
 		iounmap(par->mmio_start_virtual);
 	if (par->aperture.virtual)
 		iounmap(par->aperture.virtual);
-
+	if (par->edid)
+		kfree(par->edid);
 	if (par->res_flags & FRAMEBUFFER_REQ)
 		release_mem_region(par->aperture.physical,
 				   par->aperture.size);
@@ -1986,7 +2069,7 @@ static void __exit i810fb_remove_pci(str
 }                                                	
 
 #ifndef MODULE
-static int __init i810fb_init(void)
+static int __devinit i810fb_init(void)
 {
 	char *option = NULL;
 
@@ -2004,7 +2087,7 @@ static int __init i810fb_init(void)
 
 #ifdef MODULE
 
-static int __init i810fb_init(void)
+static int __devinit i810fb_init(void)
 {
 	hsync1 *= 1000;
 	hsync2 *= 1000;
@@ -2052,6 +2135,8 @@ MODULE_PARM_DESC(sync, "wait for accel e
 module_param(dcolor, bool, 0);
 MODULE_PARM_DESC(dcolor, "use DirectColor visuals"
 		 " (default = 0 = TrueColor)");
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Specify initial video mode");
 
 MODULE_AUTHOR("Tony A. Daplas");
 MODULE_DESCRIPTION("Framebuffer device for the Intel 810/815 and"
diff --git a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
--- a/drivers/video/i810/i810_main.h
+++ b/drivers/video/i810/i810_main.h
@@ -83,6 +83,13 @@ extern int  i810fb_sync     (struct fb_i
 extern void i810fb_init_ringbuffer(struct fb_info *info);
 extern void i810fb_load_front     (u32 offset, struct fb_info *info);
 
+/* I2C */
+extern int i810_probe_i2c_connector(struct fb_info *info, u8 **out_edid,
+				    int conn);
+extern void i810_create_i2c_busses(struct i810fb_par *par);
+extern void i810_delete_i2c_busses(struct i810fb_par *par);
+
+
 /* Conditionals */
 #ifdef CONFIG_X86
 inline void flush_cache(void)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

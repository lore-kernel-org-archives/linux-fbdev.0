From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] aty128fb: ddc support
Date: Wed, 16 Mar 2005 14:53:18 +0100 (CET)
Message-ID: <20050316132625.316.60402.76665@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBYy0-0003oV-Sv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 05:53:44 -0800
Received: from ns3.dataphone.se ([212.37.0.170] helo=mail-slave.dataphone.se)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBYxx-0005hr-UC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 05:53:44 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <damm@opensource.se>, brad@neruo.com

This patch adds DDC support to the ATI Rage 128 driver. The code is tested on
my Apple G4 Cube and detects the 1600x1024 resolution of my SGI SW1600 monitor.
The patch breaks out the i2c code from the radeon driver and puts it in a
shared file called aty_ddc.c. There are some issues, please comment:

1) The new file aty_ddc.c should be used by both the radeon and the rage code.
   The Makefile-patch works for built-in drivers, but that's all.

2) The code affects the radeon code, but I have not tested it on a radeon.

3) I got the register definitions from the gatos code, but that code only had
   one I2C channel. And that channel did not detect my monitor. So I did some
   guess work and figured out that another channel existed. I suspect that 
   channel 0 is mapped to the ADC port and channel 1 is mapped to the VGA port
   on my board. And I have not idea how this affects other Rage-based boards.

4) The DDC support is default off, and when enabled it currently overrides the
   selected video mode if a DDC-monitor is connected.

5) I saw that some patches float around that improves the radeon ddc code.
   These patches should be ported to this patch.

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urNp linux-2.6.11.4/drivers/video/aty/aty128fb.c linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty128fb.c
--- linux-2.6.11.4/drivers/video/aty/aty128fb.c	2005-03-16 10:56:18.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty128fb.c	2005-03-16 11:15:10.960979816 +0100
@@ -29,10 +29,12 @@
  * 			- PCI ID update
  * 			- replace ROM BIOS search
  *
+ *		  Magnus Damm <damm@opensource.se> 
+ *		  	- I2C/DDC probe support
+ *
  *  Based off of Geert's atyfb.c and vfb.c.
  *
  *  TODO:
- *		- monitor sensing (DDC)
  *              - virtual display
  *		- other platform support (only ppc/x86 supported)
  *		- hardware cursor support
@@ -87,6 +89,11 @@
 
 #include <video/aty128.h>
 
+#ifdef CONFIG_FB_ATY128_I2C
+#include "aty_ddc.h"
+#include "../edid.h"
+#endif
+
 /* Debug flag */
 #undef DEBUG
 
@@ -1702,6 +1709,75 @@ int __init aty128fb_setup(char *options)
 	return 0;
 }
 
+#ifdef CONFIG_FB_ATY128_I2C
+
+static u32 aty128fb_read_ddc(void *vp)
+{
+	struct aty128fb_par *par = vp;
+	return aty_ld_le32(GPIO_MONID);
+}
+
+static void aty128fb_write_ddc(void *vp, u32 data)
+{
+	struct aty128fb_par *par = vp;
+	aty_st_le32(GPIO_MONID, data);
+}
+
+static void aty128fb_init_ddc(struct aty128fb_par *par, int channel, struct aty_ddc_i2c_chan *ch)
+{
+	/* different bits... */
+
+	if (channel == 0) {
+		ch->clk_out_en = GPIO_MONID_EN_3;
+		ch->data_out_en = GPIO_MONID_EN_0;
+		ch->clk_input = GPIO_MONID_Y_3;
+		ch->data_input = GPIO_MONID_Y_0;
+		ch->clk_output = GPIO_MONID_A_3;
+		ch->data_output = GPIO_MONID_A_0;
+	}
+	else {
+		ch->clk_out_en = GPIO_MONID_EN_2;
+		ch->data_out_en = GPIO_MONID_EN_1;
+		ch->clk_input = GPIO_MONID_Y_2;
+		ch->data_input = GPIO_MONID_Y_1;
+		ch->clk_output = GPIO_MONID_A_2;
+		ch->data_output = GPIO_MONID_A_1;
+	}
+
+	ch->data = par;
+
+	/* ... same registers */
+
+	ch->read = aty128fb_read_ddc;
+	ch->write = aty128fb_write_ddc;
+
+	aty_ddc_init(ch, "monid", par->pdev);
+}
+
+void aty128fb_probe_ddc(struct aty128fb_par *par, struct fb_var_screeninfo *vp)
+{
+	char edid[EDID_LENGTH];
+	int k, ret = -1;
+	struct aty_ddc_i2c_chan ch;
+
+	for (k = 0; k < 2; k++) {
+		memset(&ch, 0, sizeof(ch));
+		memset(&edid, 0, sizeof(edid));
+
+		aty128fb_init_ddc(par, k, &ch);
+
+		ret = aty_ddc_probe(&ch, edid, sizeof(edid));
+
+		aty_ddc_cleanup(&ch);
+
+		if (ret == 0 && fb_parse_edid(edid, vp) == 0) {
+			printk(KERN_INFO "aty128fb: ddc monitor present at channel %d\n", k);
+			return;
+		}
+	}
+}
+
+#endif /* CONFIG_FB_ATY128_I2C */
 
 /*
  *  Initialisation
@@ -1819,6 +1895,11 @@ static int __init aty128_init(struct pci
 				var = default_var;
 	}
 
+#ifdef CONFIG_FB_ATY128_I2C
+	par->pdev = pdev;
+	aty128fb_probe_ddc(par, &var);
+#endif /* CONFIG_FB_ATY128_I2C */
+
 	var.accel_flags &= ~FB_ACCELF_TEXT;
 //	var.accel_flags |= FB_ACCELF_TEXT;/* FIXME Will add accel later */
 
diff -urNp linux-2.6.11.4/drivers/video/aty/aty_ddc.c linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty_ddc.c
--- linux-2.6.11.4/drivers/video/aty/aty_ddc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty_ddc.c	2005-03-16 11:15:10.962979512 +0100
@@ -0,0 +1,208 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+#include "aty_ddc.h"
+
+#define ATY_DDC_ADDRESS 	0x50
+
+static void aty_ddc_gpio_setscl(void* data, int state)
+{
+	struct aty_ddc_i2c_chan 	*ch = data;
+	u32			val;
+	
+	val = ch->read(ch->data) & ~ch->clk_out_en;
+	if (!state)
+		val |= ch->clk_out_en;
+
+	ch->write(ch->data, val);
+	(void)ch->read(ch->data);
+}
+
+static void aty_ddc_gpio_setsda(void* data, int state)
+{
+	struct aty_ddc_i2c_chan 	*ch = data;
+	u32			val;
+	
+	val = ch->read(ch->data) & ~ch->data_out_en;
+	if (!state)
+		val |= ch->data_out_en;
+
+	ch->write(ch->data, val);
+	(void)ch->read(ch->data);
+}
+
+static int aty_ddc_gpio_getscl(void* data)
+{
+	struct aty_ddc_i2c_chan 	*ch = data;
+	u32			val;
+	
+	val = ch->read(ch->data);
+
+	return (val & ch->clk_input) ? 1 : 0;
+}
+
+static int aty_ddc_gpio_getsda(void* data)
+{
+	struct aty_ddc_i2c_chan 	*ch = data;
+	u32			val;
+	
+	val = ch->read(ch->data);
+
+	return (val & ch->data_input) ? 1 : 0;
+}
+
+int aty_ddc_init(struct aty_ddc_i2c_chan *chan, const char *name, struct pci_dev *pdev)
+{
+	int rc;
+
+	strcpy(chan->adapter.name, name);
+	chan->adapter.owner		= THIS_MODULE;
+	chan->adapter.id		= I2C_ALGO_ATI;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= &pdev->dev;
+	chan->algo.setsda		= aty_ddc_gpio_setsda;
+	chan->algo.setscl		= aty_ddc_gpio_setscl;
+	chan->algo.getsda		= aty_ddc_gpio_getsda;
+	chan->algo.getscl		= aty_ddc_gpio_getscl;
+	chan->algo.udelay		= 40;
+	chan->algo.timeout		= 20;
+	chan->algo.data 		= chan;	
+	
+	i2c_set_adapdata(&chan->adapter, chan);
+	
+	/* Raise SCL and SDA */
+	aty_ddc_gpio_setsda(chan, 1);
+	aty_ddc_gpio_setscl(chan, 1);
+	udelay(20);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+
+	if (rc == 0)
+		dev_dbg(&pdev->dev, "I2C bus %s registered.\n", name);
+	else
+		dev_warn(&pdev->dev, "Failed to register I2C bus %s.\n", name);
+
+	return rc;
+}
+
+
+void aty_ddc_cleanup(struct aty_ddc_i2c_chan *ch)
+{
+	i2c_bit_del_bus(&ch->adapter);
+}
+
+
+static int aty_ddc_do_probe_i2c_edid(struct aty_ddc_i2c_chan *chan,
+u8 *buf, int len)
+{
+	u8 start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= ATY_DDC_ADDRESS,
+			.len	= 1,
+			.buf	= &start,
+		}, {
+			.addr	= ATY_DDC_ADDRESS,
+			.flags	= I2C_M_RD,
+			.len	= len,
+			.buf	= buf,
+		},
+	};
+
+	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
+		return 0;
+
+	return -1;
+}
+
+
+int aty_ddc_probe(struct aty_ddc_i2c_chan *ch, u8 *edid, int len)
+{
+	int i, j;
+	int ret = -1;
+
+	ch->write(ch->data, ch->read(ch->data) & 
+			~(ch->data_output | ch->clk_output));
+
+	ch->write(ch->data, ch->read(ch->data) & ~(ch->clk_out_en));
+	(void)ch->read(ch->data);
+
+	for (i = 0; i < 3; i++) {
+		/* For some old monitors we need the
+		 * following process to initialize/stop DDC
+		 */
+		ch->write(ch->data, ch->read(ch->data) & ~(ch->data_out_en));
+		(void)ch->read(ch->data);
+
+		msleep(13);
+
+		ch->write(ch->data, ch->read(ch->data) & ~(ch->clk_out_en));
+		(void)ch->read(ch->data);
+
+		for (j = 0; j < 5; j++) {
+			msleep(10);
+			if (ch->read(ch->data) & ch->clk_input)
+				break;
+		}
+		if (j == 5)
+			continue;
+
+		ch->write(ch->data, ch->read(ch->data) | ch->data_out_en);
+		(void)ch->read(ch->data);
+
+		msleep(15);
+
+		ch->write(ch->data, ch->read(ch->data) | ch->clk_out_en);
+		(void)ch->read(ch->data);
+
+		msleep(15);
+
+		ch->write(ch->data, ch->read(ch->data) & ~(ch->data_out_en));
+		(void)ch->read(ch->data);
+
+		msleep(15);
+
+		/* Do the real work */
+		ret = aty_ddc_do_probe_i2c_edid(ch, edid, len);
+
+		ch->write(ch->data, ch->read(ch->data) | 
+				(ch->data_out_en | ch->clk_out_en));
+		(void)ch->read(ch->data);
+
+		msleep(15);
+		
+		ch->write(ch->data, ch->read(ch->data) & ~(ch->clk_out_en));
+		(void)ch->read(ch->data);
+
+		for (j = 0; j < 10; j++) {
+			msleep(10);
+			if (ch->read(ch->data) & ch->clk_input)
+				break;
+		}
+
+		ch->write(ch->data, ch->read(ch->data) & ~(ch->data_out_en));
+		(void)ch->read(ch->data);
+
+		msleep(15);
+
+		ch->write(ch->data, ch->read(ch->data) | 
+				(ch->data_out_en | ch->clk_out_en));
+		(void)ch->read(ch->data);
+
+		if (ret == 0)
+			break;
+	}
+
+	return ret;
+}
diff -urNp linux-2.6.11.4/drivers/video/aty/aty_ddc.h linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty_ddc.h
--- linux-2.6.11.4/drivers/video/aty/aty_ddc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/aty_ddc.h	2005-03-16 11:15:10.962979512 +0100
@@ -0,0 +1,30 @@
+#ifndef __ATY_DDC_H__
+#define __ATY_DDC_H__
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
+struct aty_ddc_i2c_chan {
+	struct i2c_adapter		adapter;
+	struct i2c_algo_bit_data	algo;
+
+	u32		 		clk_out_en;
+	u32		 		data_out_en;
+	u32		 		clk_input;
+	u32		 		data_input;
+	u32		 		clk_output;
+	u32		 		data_output;
+
+        void *data;
+
+        u32 (*read)(void *vp);
+        void (*write)(void *vp, u32 data);
+};
+
+int aty_ddc_init(struct aty_ddc_i2c_chan *chan, const char *name, struct pci_dev *pdev);
+void aty_ddc_cleanup(struct aty_ddc_i2c_chan *ch);
+
+int aty_ddc_probe(struct aty_ddc_i2c_chan *ch, u8 *edid, int len);
+
+#endif /* ATY_DDC_H__ */
diff -urNp linux-2.6.11.4/drivers/video/aty/Makefile linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/Makefile
--- linux-2.6.11.4/drivers/video/aty/Makefile	2005-03-16 10:56:18.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/Makefile	2005-03-16 11:15:10.963979360 +0100
@@ -1,6 +1,6 @@
 obj-$(CONFIG_FB_ATY) += atyfb.o
-obj-$(CONFIG_FB_ATY128) += aty128fb.o
-obj-$(CONFIG_FB_RADEON) += radeonfb.o
+obj-$(CONFIG_FB_ATY128) += aty128fb.o aty_ddc.o
+obj-$(CONFIG_FB_RADEON) += radeonfb.o aty_ddc.o
 
 atyfb-y				:= atyfb_base.o mach64_accel.o mach64_cursor.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
diff -urNp linux-2.6.11.4/drivers/video/aty/radeonfb.h linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/radeonfb.h
--- linux-2.6.11.4/drivers/video/aty/radeonfb.h	2005-03-16 10:56:19.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/radeonfb.h	2005-03-16 11:15:10.964979208 +0100
@@ -255,12 +255,7 @@ struct panel_info {
 struct radeonfb_info;
 
 #ifdef CONFIG_FB_RADEON_I2C
-struct radeon_i2c_chan {
-	struct radeonfb_info		*rinfo;
-	u32		 		ddc_reg;
-	struct i2c_adapter		adapter;
-	struct i2c_algo_bit_data	algo;
-};
+#include "aty_ddc.h"
 #endif
 
 enum radeon_pm_mode {
@@ -345,7 +340,7 @@ struct radeonfb_info {
 	u32			pending_lvds_gen_cntl;
 
 #ifdef CONFIG_FB_RADEON_I2C
-	struct radeon_i2c_chan 	i2c[4];
+	struct aty_ddc_i2c_chan 	i2c[4];
 #endif
 
 	u32			cfg_save[64];
diff -urNp linux-2.6.11.4/drivers/video/aty/radeon_i2c.c linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/radeon_i2c.c
--- linux-2.6.11.4/drivers/video/aty/radeon_i2c.c	2004-12-24 22:34:48.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/aty/radeon_i2c.c	2005-03-16 11:15:10.966978904 +0100
@@ -6,242 +6,147 @@
 #include <linux/pci.h>
 #include <linux/fb.h>
 
-
-#include <linux/i2c.h>
-#include <linux/i2c-id.h>
-#include <linux/i2c-algo-bit.h>
-
 #include <asm/io.h>
 
 #include <video/radeon.h>
 #include "radeonfb.h"
 #include "../edid.h"
+#include "aty_ddc.h"
 
-#define RADEON_DDC 	0x50
+static u32 radeon_read_ddc_monid(void *vp)
+{
+	struct radeonfb_info	*rinfo = vp;
+	return INREG(GPIO_MONID);
+}
 
-static void radeon_gpio_setscl(void* data, int state)
+static void radeon_write_ddc_monid(void *vp, u32 data)
 {
-	struct radeon_i2c_chan 	*chan = data;
-	struct radeonfb_info	*rinfo = chan->rinfo;
-	u32			val;
-	
-	val = INREG(chan->ddc_reg) & ~(VGA_DDC_CLK_OUT_EN);
-	if (!state)
-		val |= VGA_DDC_CLK_OUT_EN;
-
-	OUTREG(chan->ddc_reg, val);
-	(void)INREG(chan->ddc_reg);
-}
-
-static void radeon_gpio_setsda(void* data, int state)
-{
-	struct radeon_i2c_chan 	*chan = data;
-	struct radeonfb_info	*rinfo = chan->rinfo;
-	u32			val;
-	
-	val = INREG(chan->ddc_reg) & ~(VGA_DDC_DATA_OUT_EN);
-	if (!state)
-		val |= VGA_DDC_DATA_OUT_EN;
-
-	OUTREG(chan->ddc_reg, val);
-	(void)INREG(chan->ddc_reg);
-}
-
-static int radeon_gpio_getscl(void* data)
-{
-	struct radeon_i2c_chan 	*chan = data;
-	struct radeonfb_info	*rinfo = chan->rinfo;
-	u32			val;
-	
-	val = INREG(chan->ddc_reg);
-
-	return (val & VGA_DDC_CLK_INPUT) ? 1 : 0;
-}
-
-static int radeon_gpio_getsda(void* data)
-{
-	struct radeon_i2c_chan 	*chan = data;
-	struct radeonfb_info	*rinfo = chan->rinfo;
-	u32			val;
-	
-	val = INREG(chan->ddc_reg);
-
-	return (val & VGA_DDC_DATA_INPUT) ? 1 : 0;
-}
-
-static int radeon_setup_i2c_bus(struct radeon_i2c_chan *chan, const char *name)
-{
-	int rc;
-
-	strcpy(chan->adapter.name, name);
-	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_ATI;
-	chan->adapter.algo_data		= &chan->algo;
-	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
-	chan->algo.setsda		= radeon_gpio_setsda;
-	chan->algo.setscl		= radeon_gpio_setscl;
-	chan->algo.getsda		= radeon_gpio_getsda;
-	chan->algo.getscl		= radeon_gpio_getscl;
-	chan->algo.udelay		= 40;
-	chan->algo.timeout		= 20;
-	chan->algo.data 		= chan;	
-	
-	i2c_set_adapdata(&chan->adapter, chan);
-	
-	/* Raise SCL and SDA */
-	radeon_gpio_setsda(chan, 1);
-	radeon_gpio_setscl(chan, 1);
-	udelay(20);
-
-	rc = i2c_bit_add_bus(&chan->adapter);
-	if (rc == 0)
-		dev_dbg(&chan->rinfo->pdev->dev, "I2C bus %s registered.\n", name);
-	else
-		dev_warn(&chan->rinfo->pdev->dev, "Failed to register I2C bus %s.\n", name);
-	return rc;
+	struct radeonfb_info	*rinfo = vp;
+	OUTREG(GPIO_MONID, data);
 }
 
-void radeon_create_i2c_busses(struct radeonfb_info *rinfo)
+static u32 radeon_read_ddc_dvi(void *vp)
 {
-	rinfo->i2c[0].rinfo	= rinfo;
-	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
-	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");
-
-	rinfo->i2c[1].rinfo	= rinfo;
-	rinfo->i2c[1].ddc_reg	= GPIO_DVI_DDC;
-	radeon_setup_i2c_bus(&rinfo->i2c[1], "dvi");
-
-	rinfo->i2c[2].rinfo	= rinfo;
-	rinfo->i2c[2].ddc_reg	= GPIO_VGA_DDC;
-	radeon_setup_i2c_bus(&rinfo->i2c[2], "vga");
-
-	rinfo->i2c[3].rinfo	= rinfo;
-	rinfo->i2c[3].ddc_reg	= GPIO_CRT2_DDC;
-	radeon_setup_i2c_bus(&rinfo->i2c[3], "crt2");
+	struct radeonfb_info	*rinfo = vp;
+	return INREG(GPIO_DVI_DDC);
 }
 
-void radeon_delete_i2c_busses(struct radeonfb_info *rinfo)
+static void radeon_write_ddc_dvi(void *vp, u32 data)
 {
-	if (rinfo->i2c[0].rinfo)
-		i2c_bit_del_bus(&rinfo->i2c[0].adapter);
-	rinfo->i2c[0].rinfo = NULL;
-
-	if (rinfo->i2c[1].rinfo)
-		i2c_bit_del_bus(&rinfo->i2c[1].adapter);
-	rinfo->i2c[1].rinfo = NULL;
-
-	if (rinfo->i2c[2].rinfo)
-		i2c_bit_del_bus(&rinfo->i2c[2].adapter);
-	rinfo->i2c[2].rinfo = NULL;
-
-	if (rinfo->i2c[3].rinfo)
-		i2c_bit_del_bus(&rinfo->i2c[3].adapter);
-	rinfo->i2c[3].rinfo = NULL;
+	struct radeonfb_info	*rinfo = vp;
+	OUTREG(GPIO_DVI_DDC, data);
 }
 
+static u32 radeon_read_ddc_vga(void *vp)
+{
+	struct radeonfb_info	*rinfo = vp;
+	return INREG(GPIO_VGA_DDC);
+}
 
-static u8 *radeon_do_probe_i2c_edid(struct radeon_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= RADEON_DDC,
-			.len	= 1,
-			.buf	= &start,
-		}, {
-			.addr	= RADEON_DDC,
-			.flags	= I2C_M_RD,
-			.len	= EDID_LENGTH,
-		},
-	};
-	u8 *buf;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->rinfo->pdev->dev, "Out of memory!\n");
-		return NULL;
-	}
-	msgs[1].buf = buf;
+static void radeon_write_ddc_vga(void *vp, u32 data)
+{
+	struct radeonfb_info	*rinfo = vp;
+	OUTREG(GPIO_VGA_DDC, data);
+}
 
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->rinfo->pdev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
+static u32 radeon_read_ddc_crt2(void *vp)
+{
+	struct radeonfb_info	*rinfo = vp;
+	return INREG(GPIO_CRT2_DDC);
 }
 
+static void radeon_write_ddc_crt2(void *vp, u32 data)
+{
+	struct radeonfb_info	*rinfo = vp;
+	OUTREG(GPIO_CRT2_DDC, data);
+}
 
-int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
+void radeon_init_ddc(struct radeonfb_info *rinfo, int channel, struct aty_ddc_i2c_chan *ch)
 {
-	u32 reg = rinfo->i2c[conn-1].ddc_reg;
-	u8 *edid = NULL;
-	int i, j;
-
-	OUTREG(reg, INREG(reg) & 
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
-
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-	(void)INREG(reg);
-
-	for (i = 0; i < 3; i++) {
-		/* For some old monitors we need the
-		 * following process to initialize/stop DDC
-		 */
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(13);
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 5; j++) {
-			msleep(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
-		if (j == 5)
-			continue;
+	char *str = NULL;
 
-		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-
-		/* Do the real work */
-		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
-
-		OUTREG(reg, INREG(reg) | 
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-		
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 10; j++) {
-			msleep(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
+	/* same bits... */
+
+	ch->clk_out_en = VGA_DDC_CLK_OUT_EN;
+	ch->data_out_en = VGA_DDC_DATA_OUT_EN;
+	ch->clk_input = VGA_DDC_CLK_INPUT;
+	ch->data_input = VGA_DDC_DATA_INPUT;
+	ch->clk_output = VGA_DDC_CLK_OUTPUT;
+	ch->data_output = VGA_DDC_DATA_OUTPUT;
 
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) |
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		if (edid)
-			break;
+	ch->data = rinfo;
+
+	/* .. different registers */
+
+	switch(channel) {
+	case 0:
+		ch->read = radeon_read_ddc_monid;
+		ch->write = radeon_write_ddc_monid;
+		str = "monid";
+		break;
+
+	case 1:
+		ch->read = radeon_read_ddc_dvi;
+		ch->write = radeon_write_ddc_dvi;
+		str = "dvi";
+		break;
+
+	case 2:
+		ch->read = radeon_read_ddc_vga;
+		ch->write = radeon_write_ddc_vga;
+		str = "vga";
+		break;
+
+	case 3:
+		ch->read = radeon_read_ddc_crt2;
+		ch->write = radeon_write_ddc_crt2;
+		str = "crt2";
+		break;
 	}
-	if (out_edid)
-		*out_edid = edid;
+
+	if (str)
+		aty_ddc_init(ch, str, rinfo->pdev);
+}
+
+
+void radeon_create_i2c_busses(struct radeonfb_info *rinfo)
+{
+	radeon_init_ddc(rinfo, 0, &rinfo->i2c[0]);
+	radeon_init_ddc(rinfo, 1, &rinfo->i2c[1]);
+	radeon_init_ddc(rinfo, 2, &rinfo->i2c[2]);
+	radeon_init_ddc(rinfo, 3, &rinfo->i2c[3]);
+}
+
+void radeon_delete_i2c_busses(struct radeonfb_info *rinfo)
+{
+	aty_ddc_cleanup(&rinfo->i2c[0]);
+	aty_ddc_cleanup(&rinfo->i2c[1]);
+	aty_ddc_cleanup(&rinfo->i2c[2]);
+	aty_ddc_cleanup(&rinfo->i2c[3]);
+}
+
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
+{
+	int i;
+	u8 *edid;
+
+	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!edid) {
+		dev_warn(&rinfo->pdev->dev, "Out of memory!\n");
+		return MT_NONE;
+	}
+
+	i = aty_ddc_probe(&rinfo->i2c[conn-1], edid, EDID_LENGTH);
+
+	if (i != 0) {
 		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
+		kfree(edid);
 		return MT_NONE;
 	}
+
+	if (out_edid)
+		*out_edid = edid;
+
 	if (edid[0x14] & 0x80) {
 		/* Fix detection using BIOS tables */
 		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
diff -urNp linux-2.6.11.4/drivers/video/Kconfig linux-2.6.11.4-aty128fb_ddc/drivers/video/Kconfig
--- linux-2.6.11.4/drivers/video/Kconfig	2005-03-16 10:56:18.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/drivers/video/Kconfig	2005-03-16 11:15:10.987975712 +0100
@@ -723,6 +723,9 @@ config FB_RADEON_DEBUG
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
+	select I2C_ALGOBIT if FB_ATY128_I2C
+	select I2C if FB_ATY128_I2C
+	select FB_MODE_HELPERS
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
 	  Say Y if you have such a graphics board and read
@@ -731,6 +734,13 @@ config FB_ATY128
 	  To compile this driver as a module, choose M here: the
 	  module will be called aty128fb.
 
+config FB_ATY128_I2C
+	bool "DDC/I2C for ATI Rage128 support"
+	depends on FB_ATY128
+	default n
+	help
+	  Say Y here if you want DDC/I2C support for your Rage128 board. 
+
 config FB_ATY
 	tristate "ATI Mach64 display support" if PCI || ATARI
 	depends on FB
diff -urNp linux-2.6.11.4/include/video/aty128.h linux-2.6.11.4-aty128fb_ddc/include/video/aty128.h
--- linux-2.6.11.4/include/video/aty128.h	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.11.4-aty128fb_ddc/include/video/aty128.h	2005-03-16 11:15:10.989975408 +0100
@@ -4,6 +4,7 @@
  *
  *  Anthony Tong <atong@uiuc.edu>, 1999
  *  Brad Douglas <brad@neruo.com>, 2000
+ *  Magnus Damm <damm@opensource.se>, 2005
  */
 
 #ifndef REG_RAGE128_H
@@ -18,6 +19,7 @@
 #define CRTC_GEN_CNTL				0x0050
 #define CRTC_EXT_CNTL				0x0054
 #define DAC_CNTL				0x0058
+#define GPIO_MONID				0x0068
 #define I2C_CNTL_1				0x0094
 #define PALETTE_INDEX				0x00b0
 #define PALETTE_DATA				0x00b4
@@ -415,7 +417,26 @@
 #define PWR_MGT_SLOWDOWN_MCLK			0x00002000
 
 #define PMI_PMSCR_REG				0x60
-                                                                                
+
+/* MONID constants - used for ddc/edid probing */
+
+#define GPIO_MONID_A_0				(1 <<  0)
+#define GPIO_MONID_A_1				(1 <<  1)
+#define GPIO_MONID_A_2				(1 <<  2)
+#define GPIO_MONID_A_3				(1 <<  3)
+#define GPIO_MONID_Y_0				(1 <<  8)
+#define GPIO_MONID_Y_1				(1 <<  9)
+#define GPIO_MONID_Y_2				(1 << 10)
+#define GPIO_MONID_Y_3				(1 << 11)
+#define GPIO_MONID_EN_0				(1 << 16)
+#define GPIO_MONID_EN_1				(1 << 17)
+#define GPIO_MONID_EN_2				(1 << 18)
+#define GPIO_MONID_EN_3				(1 << 19)
+#define GPIO_MONID_MASK_0			(1 << 24)
+#define GPIO_MONID_MASK_1			(1 << 25)
+#define GPIO_MONID_MASK_2			(1 << 26)
+#define GPIO_MONID_MASK_3			(1 << 27)
+
 /* used by ATI bug fix for hardware ROM */
 #define RAGE128_MPP_TB_CONFIG                   0x01c0
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

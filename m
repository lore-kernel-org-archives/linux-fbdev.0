From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] 1/3 Add I2C/DDC support to radeonfb
Date: Fri, 22 Aug 2003 18:24:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030822162441.GB4279@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qEjl-0007C9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 09:26:05 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>

Put i2c stuff in place. New driverid for i2c-id.h. Update Kconfig.
Update radeon.h.

--- linux-2.6.vanilla/include/linux/i2c-id.h	Tue Jul 15 14:27:55 2003
+++ linux-2.6/include/linux/i2c-id.h	Wed Aug 20 19:22:58 2003
@@ -99,6 +99,7 @@
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
+#define I2C_DRIVERID_RADEON	54	/* I2C bus on Radeon boards	*/
 
 
 
--- linux-2.6.vanilla/drivers/video/Kconfig	Tue Jul 15 14:27:54 2003
+++ linux-2.6/drivers/video/Kconfig	Fri Aug 22 17:13:16 2003
@@ -669,6 +669,12 @@
 	  There is a product page at
 	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
 
+config FB_RADEON_I2C
+	bool "DDC/I2C for ATI Radeon support"
+	depends on FB_RADEON && I2C_ALGOBIT=y
+	help
+	  Say Y here if you want DDC/I2C support for your Radeon board. 
+
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
--- linux-2.6.vanilla/drivers/video/radeonfb.c	Tue Aug 12 17:02:31 2003
+++ linux-2.6/drivers/video/radeonfb.c	Fri Aug 22 17:33:45 2003
@@ -23,6 +23,10 @@
  *	2002-06-03	MTRR support, Peter Horton, 0.1.5
  *	2002-09-21	rv250, r300, m9 initial support,
  *			added mirror option, 0.1.6
+ *			
+ *	Other changes (Luca Tettamanti <kronos@kronoz.cjb.net>):
+ *	
+ *	2003-08-20	support for DDC2b via I2C
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
@@ -31,6 +35,7 @@
 
 #define RADEON_VERSION	"0.1.6"
 
+#define DEBUG	1
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -46,6 +51,10 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -80,7 +89,7 @@
 #include <video/radeon.h>
 #include <linux/radeonfb.h>
 
-#define DEBUG	1
+#include "edid.h"
 
 #if DEBUG
 #define RTRACE		printk
@@ -405,7 +414,10 @@
 	u32 mdll, mdll2;
 #endif /* CONFIG_PMAC_PBOOK */
 	int asleep;
-	
+
+#ifdef CONFIG_FB_RADEON_I2C
+	u32 DDCReg;
+#endif
 	struct radeonfb_info *next;
 };
 
@@ -490,6 +502,227 @@
 	return pret;
 }
 
+static int i2c_ready;
+#ifdef CONFIG_FB_RADEON_I2C
+
+#define RADEON_DDC 0x50
+
+/* I2C Stuff */
+
+static void radeonfb_gpio_setscl(void* data, int state) {
+	struct radeonfb_info *rinfo = data;
+	u32 val;
+	
+	val = INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_CLK_OUT_EN);
+	if (!state)
+		val |= RADEON_VGA_DDC_CLK_OUT_EN;
+
+	OUTREG(rinfo->DDCReg, val);
+}
+
+static void radeonfb_gpio_setsda(void* data, int state) {
+	struct radeonfb_info *rinfo = data;
+	u32 val;
+	
+	val = INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_DATA_OUT_EN);
+	if (!state)
+		val |= RADEON_VGA_DDC_DATA_OUT_EN;
+
+	OUTREG(rinfo->DDCReg, val);
+}
+
+static int radeonfb_gpio_getscl(void* data) {
+	struct radeonfb_info *rinfo = data;
+	u32 val;
+	
+	val = INREG(rinfo->DDCReg);
+
+	return (val & RADEON_VGA_DDC_CLK_INPUT) ? 1 : 0;
+}
+
+static int radeonfb_gpio_getsda(void* data) {
+	struct radeonfb_info *rinfo = data;
+	u32 val;
+	
+	val = INREG(rinfo->DDCReg);
+
+	return (val & RADEON_VGA_DDC_DATA_INPUT) ? 1 : 0;
+}
+
+static unsigned short normal_i2c[] = { RADEON_DDC, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { RADEON_DDC, RADEON_DDC, I2C_CLIENT_END };
+static unsigned short empty[] = { I2C_CLIENT_END, };
+
+static struct i2c_client_address_data addr_data = {
+	.normal_i2c		= normal_i2c,
+	.normal_i2c_range	= normal_i2c_range,
+	.probe			= empty,
+	.probe_range		= empty,
+	.ignore			= empty,
+	.ignore_range		= empty,
+	.force			= empty,
+};
+
+static struct i2c_algo_bit_data radeon_i2c_algo = {
+	.setsda		= radeonfb_gpio_setsda,
+	.setscl		= radeonfb_gpio_setscl,
+	.getsda		= radeonfb_gpio_getsda,
+	.getscl		= radeonfb_gpio_getscl,
+	.udelay		= 40,
+	.timeout	= 20,
+};
+
+static struct i2c_adapter radeon_i2c_adapter = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_ATI,
+	.algo_data	= &radeon_i2c_algo,
+};
+
+static struct i2c_driver radeon_i2c_driver;
+
+static int radeonfb_detect_client(struct i2c_adapter* adapter, int address, int kind) {
+	struct i2c_client *new_client;
+	int err;
+
+	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
+	if (!new_client) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(new_client, 0, sizeof(*new_client));
+
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &radeon_i2c_driver;
+	snprintf(new_client->name, DEVICE_NAME_SIZE, "radeon_i2c");
+	if ((err = i2c_attach_client(new_client)))
+		kfree(new_client);
+
+out:
+	return err;
+}
+
+static int radeonfb_attach_adapter(struct i2c_adapter* adapter) {
+	int err = -ENODEV;
+	
+	if (adapter->id == (I2C_ALGO_BIT | I2C_ALGO_ATI)) {
+		err = i2c_probe(adapter, &addr_data, &radeonfb_detect_client);
+		if (err == 0)
+			dev_dbg(&adapter->dev, "Client detected.\n");
+
+	}
+	
+	return err;
+}
+
+static int radeonfb_detach_client(struct i2c_client* client) {
+	/* FIXME: kfree(client)? maybe we need a release */
+	return i2c_detach_client(client);
+}
+
+static int radeonfb_command(struct i2c_client* client, unsigned int cmd, void* arg) {
+	return -EINVAL;
+}
+
+static struct i2c_driver radeon_i2c_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "radeon_i2c",
+	.id		= I2C_DRIVERID_RADEON,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= radeonfb_attach_adapter,
+	.detach_client	= radeonfb_detach_client,
+	.command	= radeonfb_command,
+};
+
+
+static int radeonfb_i2c_bus_reg(struct radeonfb_info *rinfo) {
+	int err;
+
+	/* FIXME: we must detect connector type */
+	rinfo->DDCReg = RADEON_GPIO_VGA_DDC;
+	
+	i2c_set_adapdata(&radeon_i2c_adapter, rinfo);
+	radeon_i2c_algo.data = rinfo;	
+	
+	err = i2c_bit_add_bus(&radeon_i2c_adapter);
+	if (err == 0)
+		dev_dbg(&rinfo->pdev->dev, "I2C bus registered.\n");
+	else {
+		dev_warn(&rinfo->pdev->dev, "Failed to register I2C bus.\n");
+
+		goto out;
+	}
+
+	/* Raise SCL and SDA */
+	radeonfb_gpio_setsda(rinfo, 1);
+	radeonfb_gpio_setscl(rinfo, 1);
+	udelay(20);
+
+	err = i2c_add_driver(&radeon_i2c_driver);
+	if (err == 0)
+		dev_dbg(&rinfo->pdev->dev, "I2C driver registered.\n");
+	else {
+		dev_warn(&rinfo->pdev->dev, "Failed to register I2C driver.\n");
+		i2c_bit_del_bus(&radeon_i2c_adapter);
+
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+static void radeonfb_i2c_bus_del(void) {
+	if (!i2c_ready)
+		return;
+
+	i2c_ready = 0;
+	i2c_del_driver(&radeon_i2c_driver);
+	i2c_bit_del_bus(&radeon_i2c_adapter);
+}
+
+static void radeon_get_EDID_i2c(struct radeonfb_info *rinfo) {
+	u8 start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= 0x50,
+			.len	= 1,
+			.buf	= &start,
+		}, {
+			.addr	= 0x50,
+			.flags	= I2C_M_RD,
+			.len	= EDID_LENGTH,
+		},
+	};
+	u8 *buf;
+
+	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(&rinfo->pdev->dev, "Out of memory!\n");
+		return;
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(&radeon_i2c_adapter, msgs, 2) == 2) {
+		/* Got it! */
+		rinfo->EDID = buf;
+
+		return;
+	}
+
+	dev_dbg(&rinfo->pdev->dev, "Unable to read EDID block.\n");
+	kfree(buf);
+}
+
+#else /* CONFIG_FB_RADEON_I2C */
+
+static inline int radeonfb_i2c_bus_reg(struct radeonfb_info *rinfo) {
+	return -1;
+}
+
+static inline void radeonfb_i2c_bus_del(void) { }
+
+#endif /* CONFIG_FB_RADEON_I2C */
 
 /*
  * 2D engine routines
@@ -968,8 +1201,62 @@
 #ifdef CONFIG_PPC_OF
 	if (!radeon_get_EDID_OF(rinfo))
 		RTRACE("radeonfb: could not retrieve EDID from OF\n");
-#else
-	/* XXX use other methods later */
+#elif defined (CONFIG_FB_RADEON_I2C)
+	int i, j;
+	
+	if (!i2c_ready)
+		return;
+
+	OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & 
+			~(RADEON_VGA_DDC_DATA_OUTPUT | RADEON_VGA_DDC_CLK_OUTPUT));
+
+	OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_CLK_OUT_EN));
+	for (i = 0; i < 3; i++) {
+		/* For some old monitors we need the
+		 * following process to initialize/stop DDC
+		 */
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_DATA_OUT_EN));
+		schedule_timeout(13000);
+
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_CLK_OUT_EN));
+		for (j = 0; j < 5; j++) {
+			schedule_timeout(10000);
+			if (INREG(rinfo->DDCReg) & RADEON_VGA_DDC_CLK_INPUT)
+				break;
+		}
+
+		if (j == 5)
+			continue;
+
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) | RADEON_VGA_DDC_DATA_OUT_EN);
+		schedule_timeout(15000);
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) | RADEON_VGA_DDC_CLK_OUT_EN);
+		schedule_timeout(15000);
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_DATA_OUT_EN));
+		schedule_timeout(15000);
+
+		/* Do the real work */
+		radeon_get_EDID_i2c(rinfo);
+
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) | 
+				(RADEON_VGA_DDC_DATA_OUT_EN | RADEON_VGA_DDC_CLK_OUT_EN));
+		schedule_timeout(15000);
+		
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_CLK_OUT_EN));
+		for (j = 0; j < 10; j++) {
+			schedule_timeout(10000);
+			if (INREG(rinfo->DDCReg) & RADEON_VGA_DDC_CLK_INPUT)
+				break;
+		}
+
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) & ~(RADEON_VGA_DDC_DATA_OUT_EN));
+		schedule_timeout(15000);
+		OUTREG(rinfo->DDCReg, INREG(rinfo->DDCReg) |
+				(RADEON_VGA_DDC_DATA_OUT_EN | RADEON_VGA_DDC_CLK_OUT_EN));
+
+		if (rinfo->EDID)
+			break;
+	}
 #endif
 }
 
--- linux-2.6.vanilla/include/video/radeon.h	Tue Jul 15 14:25:20 2003
+++ linux-2.6/include/video/radeon.h	Wed Aug 20 19:07:48 2003
@@ -872,5 +872,19 @@
 
 #define GUI_ACTIVE			0x80000000
 
+/* DDC */
+#define RADEON_VGA_DDC_DATA_OUTPUT	0x00000001
+#define RADEON_VGA_DDC_CLK_OUTPUT	0x00000002
+#define RADEON_VGA_DDC_DATA_INPUT	0x00000100
+#define RADEON_VGA_DDC_CLK_INPUT	0x00000200
+#define RADEON_VGA_DDC_DATA_OUT_EN	0x00010000
+#define RADEON_VGA_DDC_CLK_OUT_EN	0x00020000
+
+#define RADEON_GPIO_VGA_DDC		0x0060
+#define RADEON_GPIO_DVI_DDC		0x0064
+#define RADEON_GPIO_MONID		0x0068
+#define RADEON_GPIO_MONIDB		0x006c
+#define RADEON_GPIO_CRT2_DDC		0x006c
+
 #endif	/* _RADEON_H */
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0

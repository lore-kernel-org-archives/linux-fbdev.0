From: Deepak Saxena <dsaxena@laptop.org>
Subject: [PATCH] viafb: update driver to use both I2C Channels
Date: Wed, 15 Jul 2009 12:01:58 -0700
Message-ID: <20090715190158.GA9699@plexity.net>
Reply-To: dsaxena@laptop.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: JosephChan@via.com.tw, ScottFang@viatech.com.cn
Cc: OLPC SW Development List <devel@lists.laptop.org>, linux-fbdev-devel@lists.sourceforge.net


The Chrome chip has two serial I2C channels and the
driver currently only exposes one of them. This patch
exposes both of them and also cleans up some structure
naming to be be less confusing.

This is specifically needed on the XO-1.5 platform as
the DCON chip is connected via Chrome I2C channel 0
and the current driver only exploses channel 1.

Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
---

This patch is not the cleanest way to export the second port, but 
in my opinion the whole via_i2c code and its users need a rewrite 
to use the driver model instead of what we're doing right now, 
which is to have the chip drivers directly call the I2C read/write 
functions after poking at the adapter's I/O address. This patch is 
meant as a stop gap until that happens since I don't currently have 
time to do a full cleanup and I need the both ports working ASAP. :)

Patch is against top of Linus' tree (e9e961)

 drivers/video/via/chip.h     |    4 +-
 drivers/video/via/dvi.c      |   20 ++++----
 drivers/video/via/lcd.c      |   10 ++--
 drivers/video/via/via_i2c.c  |  120 ++++++++++++++++++++++++++---------------
 drivers/video/via/via_i2c.h  |    7 ++-
 drivers/video/via/viafbdev.h |    3 +-
 drivers/video/via/vt1636.c   |    4 +-
 7 files changed, 101 insertions(+), 67 deletions(-)

diff --git a/drivers/video/via/chip.h b/drivers/video/via/chip.h
index dde95ed..442cd8a 100644
--- a/drivers/video/via/chip.h
+++ b/drivers/video/via/chip.h
@@ -107,7 +107,7 @@ struct tmds_chip_information {
 	int dvi_panel_id;
 	int data_mode;
 	int output_interface;
-	int i2c_port;
+	int i2c_ioport;
 	int device_type;
 };
 
@@ -116,7 +116,7 @@ struct lvds_chip_information {
 	int lvds_chip_slave_addr;
 	int data_mode;
 	int output_interface;
-	int i2c_port;
+	int i2c_ioport;
 };
 
 struct chip_information {
diff --git a/drivers/video/via/dvi.c b/drivers/video/via/dvi.c
index d696544..f826aaf 100644
--- a/drivers/video/via/dvi.c
+++ b/drivers/video/via/dvi.c
@@ -96,7 +96,7 @@ int viafb_tmds_trasmitter_identify(void)
 	viaparinfo->chip_info->tmds_chip_info.tmds_chip_name = VT1632_TMDS;
 	viaparinfo->chip_info->
 		tmds_chip_info.tmds_chip_slave_addr = VT1632_TMDS_I2C_ADDR;
-	viaparinfo->chip_info->tmds_chip_info.i2c_port = I2CPORTINDEX;
+	viaparinfo->chip_info->tmds_chip_info.i2c_ioport = I2CPORT1INDEX;
 	if (check_tmds_chip(VT1632_DEVICE_ID_REG, VT1632_DEVICE_ID) != FAIL) {
 		/*
 		 * Currently only support 12bits,dual edge,add 24bits mode later
@@ -107,10 +107,10 @@ int viafb_tmds_trasmitter_identify(void)
 		DEBUG_MSG(KERN_INFO "\n %2d",
 			  viaparinfo->chip_info->tmds_chip_info.tmds_chip_name);
 		DEBUG_MSG(KERN_INFO "\n %2d",
-			  viaparinfo->chip_info->tmds_chip_info.i2c_port);
+			  viaparinfo->chip_info->tmds_chip_info.i2c_ioport);
 		return OK;
 	} else {
-		viaparinfo->chip_info->tmds_chip_info.i2c_port = GPIOPORTINDEX;
+		viaparinfo->chip_info->tmds_chip_info.i2c_ioport = GPIOPORTINDEX;
 		if (check_tmds_chip(VT1632_DEVICE_ID_REG, VT1632_DEVICE_ID)
 		    != FAIL) {
 			tmds_register_write(0x08, 0x3b);
@@ -120,7 +120,7 @@ int viafb_tmds_trasmitter_identify(void)
 				  tmds_chip_info.tmds_chip_name);
 			DEBUG_MSG(KERN_INFO "\n %2d",
 				  viaparinfo->chip_info->
-				  tmds_chip_info.i2c_port);
+				  tmds_chip_info.i2c_ioport);
 			return OK;
 		}
 	}
@@ -160,8 +160,8 @@ int viafb_tmds_trasmitter_identify(void)
 
 static void tmds_register_write(int index, u8 data)
 {
-	viaparinfo->i2c_stuff.i2c_port =
-		viaparinfo->chip_info->tmds_chip_info.i2c_port;
+	viaparinfo->i2c_port1.i2c_ioport =
+		viaparinfo->chip_info->tmds_chip_info.i2c_ioport;
 
 	viafb_i2c_writebyte(viaparinfo->chip_info->tmds_chip_info.
 		tmds_chip_slave_addr, index,
@@ -172,8 +172,8 @@ static int tmds_register_read(int index)
 {
 	u8 data;
 
-	viaparinfo->i2c_stuff.i2c_port =
-		viaparinfo->chip_info->tmds_chip_info.i2c_port;
+	viaparinfo->i2c_port1.i2c_ioport =
+		viaparinfo->chip_info->tmds_chip_info.i2c_ioport;
 	viafb_i2c_readbyte((u8) viaparinfo->chip_info->
 	    tmds_chip_info.tmds_chip_slave_addr,
 			(u8) index, &data);
@@ -182,8 +182,8 @@ static int tmds_register_read(int index)
 
 static int tmds_register_read_bytes(int index, u8 *buff, int buff_len)
 {
-	viaparinfo->i2c_stuff.i2c_port =
-		viaparinfo->chip_info->tmds_chip_info.i2c_port;
+	viaparinfo->i2c_port1.i2c_ioport =
+		viaparinfo->chip_info->tmds_chip_info.i2c_ioport;
 	viafb_i2c_readbytes((u8) viaparinfo->chip_info->tmds_chip_info.
 			 tmds_chip_slave_addr, (u8) index, buff, buff_len);
 	return 0;
diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
index 6c7290a..15620bd 100644
--- a/drivers/video/via/lcd.c
+++ b/drivers/video/via/lcd.c
@@ -207,15 +207,15 @@ static bool lvds_identify_integratedlvds(void)
 
 int viafb_lvds_trasmitter_identify(void)
 {
-	viaparinfo->i2c_stuff.i2c_port = I2CPORTINDEX;
+ 	viaparinfo->i2c_port1.i2c_ioport = I2CPORT1INDEX;
 	if (viafb_lvds_identify_vt1636()) {
-		viaparinfo->chip_info->lvds_chip_info.i2c_port = I2CPORTINDEX;
+ 		viaparinfo->chip_info->lvds_chip_info.i2c_ioport = I2CPORT1INDEX;
 		DEBUG_MSG(KERN_INFO
 			  "Found VIA VT1636 LVDS on port i2c 0x31 \n");
 	} else {
-		viaparinfo->i2c_stuff.i2c_port = GPIOPORTINDEX;
+ 		viaparinfo->i2c_port1.i2c_ioport = GPIOPORTINDEX;
 		if (viafb_lvds_identify_vt1636()) {
-			viaparinfo->chip_info->lvds_chip_info.i2c_port =
+ 			viaparinfo->chip_info->lvds_chip_info.i2c_ioport =
 				GPIOPORTINDEX;
 			DEBUG_MSG(KERN_INFO
 				  "Found VIA VT1636 LVDS on port gpio 0x2c \n");
@@ -470,7 +470,7 @@ static int lvds_register_read(int index)
 {
 	u8 data;
 
-	viaparinfo->i2c_stuff.i2c_port = GPIOPORTINDEX;
+	viaparinfo->i2c_port1.i2c_ioport = GPIOPORTINDEX;
 	viafb_i2c_readbyte((u8) viaparinfo->chip_info->
 	    lvds_chip_info.lvds_chip_slave_addr,
 			(u8) index, &data);
diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index 0f3ed4e..4ed4410 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -24,15 +24,16 @@
 static void via_i2c_setscl(void *data, int state)
 {
 	u8 val;
-	struct via_i2c_stuff *via_i2c_chan = (struct via_i2c_stuff *)data;
+	struct via_i2c_port *via_i2c_chan = (struct via_i2c_port *)data;
 
-	val = viafb_read_reg(VIASR, via_i2c_chan->i2c_port) & 0xF0;
+	val = viafb_read_reg(VIASR, via_i2c_chan->i2c_ioport) & 0xF0;
 	if (state)
 		val |= 0x20;
 	else
 		val &= ~0x20;
-	switch (via_i2c_chan->i2c_port) {
-	case I2CPORTINDEX:
+	switch (via_i2c_chan->i2c_ioport) {
+	case I2CPORT0INDEX:
+	case I2CPORT1INDEX:
 		val |= 0x01;
 		break;
 	case GPIOPORTINDEX:
@@ -41,23 +42,23 @@ static void via_i2c_setscl(void *data, int state)
 	default:
 		DEBUG_MSG("via_i2c: specify wrong i2c port.\n");
 	}
-	viafb_write_reg(via_i2c_chan->i2c_port, VIASR, val);
+	viafb_write_reg(via_i2c_chan->i2c_ioport, VIASR, val);
 }
 
 static int via_i2c_getscl(void *data)
 {
-	struct via_i2c_stuff *via_i2c_chan = (struct via_i2c_stuff *)data;
+	struct via_i2c_port *via_i2c_chan = (struct via_i2c_port *)data;
 
-	if (viafb_read_reg(VIASR, via_i2c_chan->i2c_port) & 0x08)
+	if (viafb_read_reg(VIASR, via_i2c_chan->i2c_ioport) & 0x08)
 		return 1;
 	return 0;
 }
 
 static int via_i2c_getsda(void *data)
 {
-	struct via_i2c_stuff *via_i2c_chan = (struct via_i2c_stuff *)data;
+	struct via_i2c_port *via_i2c_chan = (struct via_i2c_port *)data;
 
-	if (viafb_read_reg(VIASR, via_i2c_chan->i2c_port) & 0x04)
+	if (viafb_read_reg(VIASR, via_i2c_chan->i2c_ioport) & 0x04)
 		return 1;
 	return 0;
 }
@@ -65,15 +66,16 @@ static int via_i2c_getsda(void *data)
 static void via_i2c_setsda(void *data, int state)
 {
 	u8 val;
-	struct via_i2c_stuff *via_i2c_chan = (struct via_i2c_stuff *)data;
+	struct via_i2c_port *via_i2c_chan = (struct via_i2c_port *)data;
 
-	val = viafb_read_reg(VIASR, via_i2c_chan->i2c_port) & 0xF0;
+	val = viafb_read_reg(VIASR, via_i2c_chan->i2c_ioport) & 0xF0;
 	if (state)
 		val |= 0x10;
 	else
 		val &= ~0x10;
-	switch (via_i2c_chan->i2c_port) {
-	case I2CPORTINDEX:
+	switch (via_i2c_chan->i2c_ioport) {
+	case I2CPORT0INDEX:
+	case I2CPORT1INDEX:
 		val |= 0x01;
 		break;
 	case GPIOPORTINDEX:
@@ -82,7 +84,7 @@ static void via_i2c_setsda(void *data, int state)
 	default:
 		DEBUG_MSG("via_i2c: specify wrong i2c port.\n");
 	}
-	viafb_write_reg(via_i2c_chan->i2c_port, VIASR, val);
+	viafb_write_reg(via_i2c_chan->i2c_ioport, VIASR, val);
 }
 
 int viafb_i2c_readbyte(u8 slave_addr, u8 index, u8 *pdata)
@@ -97,7 +99,7 @@ int viafb_i2c_readbyte(u8 slave_addr, u8 index, u8 *pdata)
 	mm1[0] = index;
 	msgs[0].len = 1; msgs[1].len = 1;
 	msgs[0].buf = mm1; msgs[1].buf = pdata;
-	i2c_transfer(&viaparinfo->i2c_stuff.adapter, msgs, 2);
+	i2c_transfer(&viaparinfo->i2c_port1.adapter, msgs, 2);
 
 	return 0;
 }
@@ -111,7 +113,7 @@ int viafb_i2c_writebyte(u8 slave_addr, u8 index, u8 data)
 	msgs.addr = slave_addr / 2;
 	msgs.len = 2;
 	msgs.buf = msg;
-	return i2c_transfer(&viaparinfo->i2c_stuff.adapter, &msgs, 1);
+	return i2c_transfer(&viaparinfo->i2c_port1.adapter, &msgs, 1);
 }
 
 int viafb_i2c_readbytes(u8 slave_addr, u8 index, u8 *buff, int buff_len)
@@ -125,7 +127,7 @@ int viafb_i2c_readbytes(u8 slave_addr, u8 index, u8 *buff, int buff_len)
 	mm1[0] = index;
 	msgs[0].len = 1; msgs[1].len = buff_len;
 	msgs[0].buf = mm1; msgs[1].buf = buff;
-	i2c_transfer(&viaparinfo->i2c_stuff.adapter, msgs, 2);
+	i2c_transfer(&viaparinfo->i2c_port1.adapter, msgs, 2);
 	return 0;
 }
 
@@ -134,44 +136,74 @@ int viafb_create_i2c_bus(void *viapar)
 	int ret;
 	struct viafb_par *par = (struct viafb_par *)viapar;
 
-	strcpy(par->i2c_stuff.adapter.name, "via_i2c");
-	par->i2c_stuff.i2c_port = 0x0;
-	par->i2c_stuff.adapter.owner = THIS_MODULE;
-	par->i2c_stuff.adapter.id = 0x01FFFF;
-	par->i2c_stuff.adapter.class = 0;
-	par->i2c_stuff.adapter.algo_data = &par->i2c_stuff.algo;
-	par->i2c_stuff.adapter.dev.parent = NULL;
-	par->i2c_stuff.algo.setsda = via_i2c_setsda;
-	par->i2c_stuff.algo.setscl = via_i2c_setscl;
-	par->i2c_stuff.algo.getsda = via_i2c_getsda;
-	par->i2c_stuff.algo.getscl = via_i2c_getscl;
-	par->i2c_stuff.algo.udelay = 40;
-	par->i2c_stuff.algo.timeout = 20;
-	par->i2c_stuff.algo.data = &par->i2c_stuff;
-
-	i2c_set_adapdata(&par->i2c_stuff.adapter, &par->i2c_stuff);
+ 	/*
+ 	 * CRT serial port
+ 	 */
+ 	strcpy(par->i2c_port0.adapter.name, "via_i2c_port0");
+ 	par->i2c_port0.i2c_ioport = I2CPORT0INDEX;
+ 	par->i2c_port0.adapter.owner = THIS_MODULE;
+ 	par->i2c_port0.adapter.id = 0x01FFFF;
+ 	par->i2c_port0.adapter.class = 0;
+ 	par->i2c_port0.adapter.algo_data = &par->i2c_port0.algo;
+ 	par->i2c_port0.adapter.dev.parent = NULL;
+ 	par->i2c_port0.algo.setsda = via_i2c_setsda;
+ 	par->i2c_port0.algo.setscl = via_i2c_setscl;
+ 	par->i2c_port0.algo.getsda = via_i2c_getsda;
+ 	par->i2c_port0.algo.getscl = via_i2c_getscl;
+ 	par->i2c_port0.algo.udelay = 40;
+ 	par->i2c_port0.algo.timeout = 20;
+ 	par->i2c_port0.algo.data = &par->i2c_port0;
+ 
+ 	i2c_set_adapdata(&par->i2c_port0.adapter, &par->i2c_port0);
+ 	ret = i2c_bit_add_bus(&par->i2c_port0.adapter);
+ 	if (ret == 0) {
+ 		printk("I2C bus %s registered as i2c-%d.\n",
+ 		par->i2c_port0.adapter.name, par->i2c_port0.adapter.nr);
+ 	}
+ 
+ 	/*
+ 	 * LCD Serial port
+ 	 */
+ 	strcpy(par->i2c_port1.adapter.name, "via_i2c_port1");
+ 	par->i2c_port1.i2c_ioport = 0x0;
+ 	par->i2c_port1.adapter.owner = THIS_MODULE;
+ 	par->i2c_port1.adapter.id = 0x01FFFF;
+ 	par->i2c_port1.adapter.class = 0;
+ 	par->i2c_port1.adapter.algo_data = &par->i2c_port1.algo;
+ 	par->i2c_port1.adapter.dev.parent = NULL;
+ 	par->i2c_port1.algo.setsda = via_i2c_setsda;
+ 	par->i2c_port1.algo.setscl = via_i2c_setscl;
+ 	par->i2c_port1.algo.getsda = via_i2c_getsda;
+ 	par->i2c_port1.algo.getscl = via_i2c_getscl;
+ 	par->i2c_port1.algo.udelay = 40;
+ 	par->i2c_port1.algo.timeout = 20;
+ 	par->i2c_port1.algo.data = &par->i2c_port1;
+ 
+ 	i2c_set_adapdata(&par->i2c_port1.adapter, &par->i2c_port1);
 
 	/* Raise SCL and SDA */
-	par->i2c_stuff.i2c_port = I2CPORTINDEX;
-	via_i2c_setsda(&par->i2c_stuff, 1);
-	via_i2c_setscl(&par->i2c_stuff, 1);
-
-	par->i2c_stuff.i2c_port = GPIOPORTINDEX;
-	via_i2c_setsda(&par->i2c_stuff, 1);
-	via_i2c_setscl(&par->i2c_stuff, 1);
+ 	par->i2c_port1.i2c_ioport = I2CPORT1INDEX;
+ 	via_i2c_setsda(&par->i2c_port1, 1);
+ 	via_i2c_setscl(&par->i2c_port1, 1);
+  
+ 	par->i2c_port1.i2c_ioport = GPIOPORTINDEX;
+ 	via_i2c_setsda(&par->i2c_port1, 1);
+ 	via_i2c_setscl(&par->i2c_port1, 1);
 	udelay(20);
 
-	ret = i2c_bit_add_bus(&par->i2c_stuff.adapter);
+ 	ret = i2c_bit_add_bus(&par->i2c_port1.adapter);
 	if (ret == 0)
 		DEBUG_MSG("I2C bus %s registered.\n",
-		par->i2c_stuff.adapter.name);
+ 		par->i2c_port1.adapter.name, par->i2c_port1.adapter.nr);
 	else
 		DEBUG_MSG("Failed to register I2C bus %s.\n",
-			par->i2c_stuff.adapter.name);
+ 			par->i2c_port1.adapter.name);
+
 	return ret;
 }
 
 void viafb_delete_i2c_buss(void *par)
 {
-	i2c_del_adapter(&((struct viafb_par *)par)->i2c_stuff.adapter);
+ 	i2c_del_adapter(&((struct viafb_par *)par)->i2c_port0.adapter);
+ 	i2c_del_adapter(&((struct viafb_par *)par)->i2c_port1.adapter);
 }
diff --git a/drivers/video/via/via_i2c.h b/drivers/video/via/via_i2c.h
index 3a13242..5792ff6 100644
--- a/drivers/video/via/via_i2c.h
+++ b/drivers/video/via/via_i2c.h
@@ -24,14 +24,15 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-struct via_i2c_stuff {
-	u16 i2c_port;			/* GPIO or I2C port */
+struct via_i2c_port {
+	u16 i2c_ioport;			/* GPIO or I2C port */
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data algo;
 };
 
 #define I2CPORT           0x3c4
-#define I2CPORTINDEX      0x31
+#define I2CPORT0INDEX      0x26
+#define I2CPORT1INDEX      0x31
 #define GPIOPORT          0x3C4
 #define GPIOPORTINDEX     0x2C
 #define I2C_BUS             1
diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
index a4158e8..3583451 100644
--- a/drivers/video/via/viafbdev.h
+++ b/drivers/video/via/viafbdev.h
@@ -62,7 +62,8 @@ struct viafb_par {
 	u8 duoview;		/*Is working in duoview mode? */
 
 	/* I2C stuff */
-	struct via_i2c_stuff i2c_stuff;
+	struct via_i2c_port i2c_port0; 
+	struct via_i2c_port i2c_port1;
 
 	/* All the information will be needed to set engine */
 	struct tmds_setting_information *tmds_setting_info;
diff --git a/drivers/video/via/vt1636.c b/drivers/video/via/vt1636.c
index 322a9f9..e757aa8 100644
--- a/drivers/video/via/vt1636.c
+++ b/drivers/video/via/vt1636.c
@@ -27,7 +27,7 @@ u8 viafb_gpio_i2c_read_lvds(struct lvds_setting_information
 {
 	u8 data;
 
-	viaparinfo->i2c_stuff.i2c_port = plvds_chip_info->i2c_port;
+	viaparinfo->i2c_port1.i2c_ioport = plvds_chip_info->i2c_ioport;
 	viafb_i2c_readbyte(plvds_chip_info->lvds_chip_slave_addr, index, &data);
 
 	return data;
@@ -39,7 +39,7 @@ void viafb_gpio_i2c_write_mask_lvds(struct lvds_setting_information
 {
 	int index, data;
 
-	viaparinfo->i2c_stuff.i2c_port = plvds_chip_info->i2c_port;
+	viaparinfo->i2c_port1.i2c_ioport = plvds_chip_info->i2c_ioport;
 
 	index = io_data.Index;
 	data = viafb_gpio_i2c_read_lvds(plvds_setting_info, plvds_chip_info,
-- 
1.5.5.1.29.gcbf75.dirty

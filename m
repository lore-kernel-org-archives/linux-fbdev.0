From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 1/3] i2c: Let framebuffer drivers set
 their I2C bus class to DDC
Date: Tue, 3 Jun 2008 13:00:47 +0200
Message-ID: <20080603130047.15a9da3c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3UGT-0007QL-Jb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 04:01:17 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3UGS-00025x-Mq
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 04:01:17 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux I2C <i2c@lm-sensors.org>
Cc: David Brownell <david-b@pacbell.net>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

Let framebuffer drivers set their I2C bus class to DDC. Once this is
done, we will be able to tell the eeprom driver to only probe for
EDID EEPROMs on these buses.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/fb_ddc.c              |    1 +
 drivers/video/intelfb/intelfb_i2c.c |   12 +++++++-----
 drivers/video/matrox/i2c-matroxfb.c |   20 +++++++++++++++-----
 include/linux/i2c.h                 |    2 +-
 4 files changed, 24 insertions(+), 11 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/video/fb_ddc.c	2008-06-03 10:02:28.000000000 +0200
+++ linux-2.6.26-rc4/drivers/video/fb_ddc.c	2008-06-03 10:03:37.000000000 +0200
@@ -106,6 +106,7 @@ unsigned char *fb_ddc_read(struct i2c_ad
 	algo_data->setsda(algo_data->data, 1);
 	algo_data->setscl(algo_data->data, 1);
 
+	adapter->class |= I2C_CLASS_DDC;
 	return edid;
 }
 
--- linux-2.6.26-rc4.orig/include/linux/i2c.h	2008-06-03 10:02:28.000000000 +0200
+++ linux-2.6.26-rc4/include/linux/i2c.h	2008-06-03 10:03:37.000000000 +0200
@@ -349,7 +349,7 @@ static inline void i2c_set_adapdata (str
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
-#define I2C_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
+#define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
 #define I2C_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
 #define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 #define I2C_CLASS_SOUND		(1<<6)	/* sound devices */
--- linux-2.6.26-rc4.orig/drivers/video/intelfb/intelfb_i2c.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/video/intelfb/intelfb_i2c.c	2008-06-03 10:03:37.000000000 +0200
@@ -100,7 +100,8 @@ static int intelfb_gpio_getsda(void *dat
 
 static int intelfb_setup_i2c_bus(struct intelfb_info *dinfo,
 				 struct intelfb_i2c_chan *chan,
-				 const u32 reg, const char *name)
+				 const u32 reg, const char *name,
+				 int class)
 {
 	int rc;
 
@@ -108,6 +109,7 @@ static int intelfb_setup_i2c_bus(struct 
 	chan->reg			= reg;
 	snprintf(chan->adapter.name, sizeof(chan->adapter.name),
 		 "intelfb %s", name);
+	chan->adapter.class		= class;
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.id		= I2C_HW_B_INTELFB;
 	chan->adapter.algo_data		= &chan->algo;
@@ -145,7 +147,7 @@ void intelfb_create_i2c_busses(struct in
 
 	/* setup the DDC bus for analog output */
 	intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOA,
-			      "CRTDDC_A");
+			      "CRTDDC_A", I2C_CLASS_DDC);
 	i++;
 
 	/* need to add the output busses for each device
@@ -159,9 +161,9 @@ void intelfb_create_i2c_busses(struct in
 	case INTEL_865G:
 		dinfo->output[i].type = INTELFB_OUTPUT_DVO;
 		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus,
-				      GPIOD, "DVODDC_D");
+				      GPIOD, "DVODDC_D", I2C_CLASS_DDC);
 		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus,
-				      GPIOE, "DVOI2C_E");
+				      GPIOE, "DVOI2C_E", 0);
 		i++;
 		break;
 	case INTEL_915G:
@@ -174,7 +176,7 @@ void intelfb_create_i2c_busses(struct in
 		/* SDVO ports have a single control bus - 2 devices */
 		dinfo->output[i].type = INTELFB_OUTPUT_SDVO;
 		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus,
-				      GPIOE, "SDVOCTRL_E");
+				      GPIOE, "SDVOCTRL_E", 0);
 		/* TODO: initialize the SDVO */
 		/* I830SDVOInit(pScrn, i, DVOB); */
 		i++;
--- linux-2.6.26-rc4.orig/drivers/video/matrox/i2c-matroxfb.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/video/matrox/i2c-matroxfb.c	2008-06-03 10:05:32.000000000 +0200
@@ -104,7 +104,9 @@ static struct i2c_algo_bit_data matrox_i
 };
 
 static int i2c_bus_reg(struct i2c_bit_adapter* b, struct matrox_fb_info* minfo, 
-		unsigned int data, unsigned int clock, const char* name) {
+		unsigned int data, unsigned int clock, const char *name,
+		int class)
+{
 	int err;
 
 	b->minfo = minfo;
@@ -114,6 +116,7 @@ static int i2c_bus_reg(struct i2c_bit_ad
 	snprintf(b->adapter.name, sizeof(b->adapter.name), name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
+	b->adapter.class = class;
 	b->adapter.algo_data = &b->bac;
 	b->adapter.dev.parent = &ACCESS_FBINFO(pcidev)->dev;
 	b->bac = matrox_i2c_algo_template;
@@ -159,22 +162,29 @@ static void* i2c_matroxfb_probe(struct m
 	switch (ACCESS_FBINFO(chip)) {
 		case MGA_2064:
 		case MGA_2164:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1B_DATA, DDC1B_CLK, "DDC:fb%u #0");
+			err = i2c_bus_reg(&m2info->ddc1, minfo,
+					  DDC1B_DATA, DDC1B_CLK,
+					  "DDC:fb%u #0", I2C_CLASS_DDC);
 			break;
 		default:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1_DATA, DDC1_CLK, "DDC:fb%u #0");
+			err = i2c_bus_reg(&m2info->ddc1, minfo,
+					  DDC1_DATA, DDC1_CLK,
+					  "DDC:fb%u #0", I2C_CLASS_DDC);
 			break;
 	}
 	if (err)
 		goto fail_ddc1;
 	if (ACCESS_FBINFO(devflags.dualhead)) {
-		err = i2c_bus_reg(&m2info->ddc2, minfo, DDC2_DATA, DDC2_CLK, "DDC:fb%u #1");
+		err = i2c_bus_reg(&m2info->ddc2, minfo,
+				  DDC2_DATA, DDC2_CLK,
+				  "DDC:fb%u #1", I2C_CLASS_DDC);
 		if (err == -ENODEV) {
 			printk(KERN_INFO "i2c-matroxfb: VGA->TV plug detected, DDC unavailable.\n");
 		} else if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register secondary output i2c bus. Continuing anyway.\n");
 		/* Register maven bus even on G450/G550 */
-		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u");
+		err = i2c_bus_reg(&m2info->maven, minfo,
+				  MAT_DATA, MAT_CLK, "MAVEN:fb%u", 0);
 		if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register Maven i2c bus. Continuing anyway.\n");
 	}


-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

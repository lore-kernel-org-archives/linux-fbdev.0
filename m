From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 3/3] matrox maven: Convert to a
	new-style i2c driver
Date: Tue, 17 Jun 2008 20:08:27 +0200
Message-ID: <20080617200827.48e8d163@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K8fbl-00036Q-O7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 11:08:41 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K8fbi-0000T9-NE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 11:08:41 -0700
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

The legacy i2c model is going away soon, so switch to the new model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This needs testing! I don't have any dual-head Matrox card so I
couldn't test it myself.

Petr, do we know in advance which adapters have the Maven chip and
which don't? If we did, we could use i2c_new_device() instead of
i2c_new_probed_device(), for slightly more simple code.

 drivers/video/matrox/i2c-matroxfb.c   |   12 +++-
 drivers/video/matrox/matroxfb_maven.c |   95 +++++++++++++--------------------
 include/linux/i2c-id.h                |    2 
 3 files changed, 50 insertions(+), 59 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 18:53:08.000000000 +0200
+++ linux-2.6.26-rc6/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 18:53:41.000000000 +0200
@@ -105,7 +105,6 @@ static int i2c_bus_reg(struct i2c_bit_ad
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter.owner = THIS_MODULE;
-	b->adapter.id = I2C_HW_B_G400;
 	snprintf(b->adapter.name, sizeof(b->adapter.name), name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
@@ -172,6 +171,17 @@ static void* i2c_matroxfb_probe(struct m
 		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u");
 		if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register Maven i2c bus. Continuing anyway.\n");
+		else {
+			struct i2c_board_info maven_info = {
+				I2C_BOARD_INFO("maven", 0x1b),
+			};
+			unsigned short const addr_list[2] = {
+				0x1b, I2C_CLIENT_END
+			};
+
+			i2c_new_probed_device(&m2info->maven.adapter,
+					      &maven_info, addr_list);
+		}
 	}
 	return m2info;
 fail_ddc1:;
--- linux-2.6.26-rc6.orig/drivers/video/matrox/matroxfb_maven.c	2008-06-17 18:52:31.000000000 +0200
+++ linux-2.6.26-rc6/drivers/video/matrox/matroxfb_maven.c	2008-06-17 20:06:36.000000000 +0200
@@ -19,8 +19,6 @@
 #include <linux/matroxfb.h>
 #include <asm/div64.h>
 
-#define MAVEN_I2CID	(0x1B)
-
 #define MGATVO_B	1
 #define MGATVO_C	2
 
@@ -128,7 +126,7 @@ static int get_ctrl_id(__u32 v4l2_id) {
 
 struct maven_data {
 	struct matrox_fb_info*		primary_head;
-	struct i2c_client		client;
+	struct i2c_client		*client;
 	int				version;
 };
 
@@ -974,7 +972,7 @@ static inline int maven_compute_timming(
 
 static int maven_program_timming(struct maven_data* md,
 		const struct mavenregs* m) {
-	struct i2c_client* c = &md->client;
+	struct i2c_client *c = md->client;
 
 	if (m->mode == MATROXFB_OUTPUT_MODE_MONITOR) {
 		LR(0x80);
@@ -1011,7 +1009,7 @@ static int maven_program_timming(struct 
 }
 
 static inline int maven_resync(struct maven_data* md) {
-	struct i2c_client* c = &md->client;
+	struct i2c_client *c = md->client;
 	maven_set_reg(c, 0x95, 0x20);	/* start whole thing */
 	return 0;
 }
@@ -1069,48 +1067,48 @@ static int maven_set_control (struct mav
 		  maven_compute_bwlevel(md, &blacklevel, &whitelevel);
 		  blacklevel = (blacklevel >> 2) | ((blacklevel & 3) << 8);
 		  whitelevel = (whitelevel >> 2) | ((whitelevel & 3) << 8);
-		  maven_set_reg_pair(&md->client, 0x0e, blacklevel);
-		  maven_set_reg_pair(&md->client, 0x1e, whitelevel);
+		  maven_set_reg_pair(md->client, 0x0e, blacklevel);
+		  maven_set_reg_pair(md->client, 0x1e, whitelevel);
 		}
 		break;
 		case V4L2_CID_SATURATION:
 		{
-		  maven_set_reg(&md->client, 0x20, p->value);
-		  maven_set_reg(&md->client, 0x22, p->value);
+		  maven_set_reg(md->client, 0x20, p->value);
+		  maven_set_reg(md->client, 0x22, p->value);
 		}
 		break;
 		case V4L2_CID_HUE:
 		{
-		  maven_set_reg(&md->client, 0x25, p->value);
+		  maven_set_reg(md->client, 0x25, p->value);
 		}
 		break;
 		case V4L2_CID_GAMMA:
 		{
 		  const struct maven_gamma* g;
 		  g = maven_compute_gamma(md);
-		  maven_set_reg(&md->client, 0x83, g->reg83);
-		  maven_set_reg(&md->client, 0x84, g->reg84);
-		  maven_set_reg(&md->client, 0x85, g->reg85);
-		  maven_set_reg(&md->client, 0x86, g->reg86);
-		  maven_set_reg(&md->client, 0x87, g->reg87);
-		  maven_set_reg(&md->client, 0x88, g->reg88);
-		  maven_set_reg(&md->client, 0x89, g->reg89);
-		  maven_set_reg(&md->client, 0x8a, g->reg8a);
-		  maven_set_reg(&md->client, 0x8b, g->reg8b);
+		  maven_set_reg(md->client, 0x83, g->reg83);
+		  maven_set_reg(md->client, 0x84, g->reg84);
+		  maven_set_reg(md->client, 0x85, g->reg85);
+		  maven_set_reg(md->client, 0x86, g->reg86);
+		  maven_set_reg(md->client, 0x87, g->reg87);
+		  maven_set_reg(md->client, 0x88, g->reg88);
+		  maven_set_reg(md->client, 0x89, g->reg89);
+		  maven_set_reg(md->client, 0x8a, g->reg8a);
+		  maven_set_reg(md->client, 0x8b, g->reg8b);
 		}
 		break;
 		case MATROXFB_CID_TESTOUT:
 		{
 			unsigned char val 
-			  = maven_get_reg(&md->client,0x8d);
+			  = maven_get_reg(md->client, 0x8d);
 			if (p->value) val |= 0x10;
 			else          val &= ~0x10;
-			maven_set_reg(&md->client, 0x8d, val);
+			maven_set_reg(md->client, 0x8d, val);
 		}
 		break;
 		case MATROXFB_CID_DEFLICKER:
 		{
-		  maven_set_reg(&md->client, 0x93, maven_compute_deflicker(md));
+		  maven_set_reg(md->client, 0x93, maven_compute_deflicker(md));
 		}
 		break;
 	}
@@ -1189,6 +1187,7 @@ static int maven_init_client(struct i2c_
 	MINFO_FROM(container_of(clnt->adapter, struct i2c_bit_adapter, adapter)->minfo);
 
 	md->primary_head = MINFO;
+	md->client = clnt;
 	down_write(&ACCESS_FBINFO(altout.lock));
 	ACCESS_FBINFO(outputs[1]).output = &maven_altout;
 	ACCESS_FBINFO(outputs[1]).src = ACCESS_FBINFO(outputs[1]).default_src;
@@ -1232,14 +1231,11 @@ static int maven_shutdown_client(struct 
 	return 0;
 }
 
-static const unsigned short normal_i2c[] = { MAVEN_I2CID, I2C_CLIENT_END };
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver maven_driver;
-
-static int maven_detect_client(struct i2c_adapter* adapter, int address, int kind) {
-	int err = 0;
-	struct i2c_client* new_client;
+static int maven_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int err = -ENODEV;
 	struct maven_data* data;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_WORD_DATA |
@@ -1250,50 +1246,37 @@ static int maven_detect_client(struct i2
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &maven_driver;
-	new_client->flags = 0;
-	strlcpy(new_client->name, "maven", I2C_NAME_SIZE);
-	if ((err = i2c_attach_client(new_client)))
-		goto ERROR3;
-	err = maven_init_client(new_client);
+	i2c_set_clientdata(client, data);
+	err = maven_init_client(client);
 	if (err)
 		goto ERROR4;
 	return 0;
 ERROR4:;
-	i2c_detach_client(new_client);
-ERROR3:;
 	kfree(data);
 ERROR0:;
 	return err;
 }
 
-static int maven_attach_adapter(struct i2c_adapter* adapter) {
-	if (adapter->id == I2C_HW_B_G400)
-		return i2c_probe(adapter, &addr_data, &maven_detect_client);
-	return 0;
-}
-
-static int maven_detach_client(struct i2c_client* client) {
-	int err;
-
-	if ((err = i2c_detach_client(client)))
-		return err;
+static int maven_remove(struct i2c_client *client)
+{
 	maven_shutdown_client(client);
 	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
+static struct i2c_device_id maven_id[] = {
+	{ "maven", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, maven_id);
+
 static struct i2c_driver maven_driver={
 	.driver = {
 		.name	= "maven",
 	},
-	.id		= I2C_DRIVERID_MGATVO,
-	.attach_adapter	= maven_attach_adapter,
-	.detach_client	= maven_detach_client,
+	.probe		= maven_probe,
+	.remove		= maven_remove,
+	.id_table	= maven_id,
 };
 
 static int __init matroxfb_maven_init(void)
--- linux-2.6.26-rc6.orig/include/linux/i2c-id.h	2008-06-17 18:41:54.000000000 +0200
+++ linux-2.6.26-rc6/include/linux/i2c-id.h	2008-06-17 18:53:41.000000000 +0200
@@ -39,7 +39,6 @@
 #define I2C_DRIVERID_SAA7111A	 8	/* video input processor	*/
 #define I2C_DRIVERID_SAA7185B	13	/* video encoder		*/
 #define I2C_DRIVERID_SAA7110	22	/* video decoder		*/
-#define I2C_DRIVERID_MGATVO	23	/* Matrox TVOut			*/
 #define I2C_DRIVERID_SAA5249	24	/* SAA5249 and compatibles	*/
 #define I2C_DRIVERID_PCF8583	25	/* real time clock		*/
 #define I2C_DRIVERID_SAB3036	26	/* SAB3036 tuner		*/
@@ -97,7 +96,6 @@
 #define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
 #define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */
 #define I2C_HW_B_HYDRA		0x010008 /* Apple Hydra Mac I/O */
-#define I2C_HW_B_G400		0x010009 /* Matrox G400 */
 #define I2C_HW_B_I810		0x01000a /* Intel I810 */
 #define I2C_HW_B_VOO		0x01000b /* 3dfx Voodoo 3 / Banshee */
 #define I2C_HW_B_SCX200		0x01000e /* Nat'l Semi SCx200 I2C */

-- 
Jean Delvare

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] cleanups to matroxfb_maven
Date: Wed, 14 Dec 2005 22:31:32 +0100
Message-ID: <20051214223132.35365ce1.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmeBh-00050z-0f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 13:29:25 -0800
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmeBg-0008Ri-AK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 13:29:25 -0800
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Petr, all,

[Untested, as I do not have supported hardware.]

A few cleanups which were done to almost all i2c drivers some times
ago, but matroxfb_maven was forgotten:
* Don't allocate two different structures at once.
* Use kzalloc instead of kmalloc+memset.
* Use strlcpy instead of strcpy.
* Drop duplicate error message on client deregistration failure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/matroxfb_maven.c |   55 +++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/video/matrox/matroxfb_maven.c	2005-12-14 21:06:21.000000000 +0100
+++ linux-2.6.15-rc5/drivers/video/matrox/matroxfb_maven.c	2005-12-14 21:36:35.000000000 +0100
@@ -129,7 +129,7 @@
 
 struct maven_data {
 	struct matrox_fb_info*		primary_head;
-	struct i2c_client*		client;
+	struct i2c_client		client;
 	int				version;
 };
 
@@ -970,7 +970,7 @@
 
 static inline int maven_program_timming(struct maven_data* md,
 		const struct mavenregs* m) {
-	struct i2c_client* c = md->client;
+	struct i2c_client* c = &md->client;
 
 	if (m->mode == MATROXFB_OUTPUT_MODE_MONITOR) {
 		LR(0x80);
@@ -1007,7 +1007,7 @@
 }
 
 static inline int maven_resync(struct maven_data* md) {
-	struct i2c_client* c = md->client;
+	struct i2c_client* c = &md->client;
 	maven_set_reg(c, 0x95, 0x20);	/* start whole thing */
 	return 0;
 }
@@ -1065,48 +1065,48 @@
 		  maven_compute_bwlevel(md, &blacklevel, &whitelevel);
 		  blacklevel = (blacklevel >> 2) | ((blacklevel & 3) << 8);
 		  whitelevel = (whitelevel >> 2) | ((whitelevel & 3) << 8);
-		  maven_set_reg_pair(md->client, 0x0e, blacklevel);
-		  maven_set_reg_pair(md->client, 0x1e, whitelevel);
+		  maven_set_reg_pair(&md->client, 0x0e, blacklevel);
+		  maven_set_reg_pair(&md->client, 0x1e, whitelevel);
 		}
 		break;
 		case V4L2_CID_SATURATION:
 		{
-		  maven_set_reg(md->client, 0x20, p->value);
-		  maven_set_reg(md->client, 0x22, p->value);
+		  maven_set_reg(&md->client, 0x20, p->value);
+		  maven_set_reg(&md->client, 0x22, p->value);
 		}
 		break;
 		case V4L2_CID_HUE:
 		{
-		  maven_set_reg(md->client, 0x25, p->value);
+		  maven_set_reg(&md->client, 0x25, p->value);
 		}
 		break;
 		case V4L2_CID_GAMMA:
 		{
 		  const struct maven_gamma* g;
 		  g = maven_compute_gamma(md);
-		  maven_set_reg(md->client, 0x83, g->reg83);
-		  maven_set_reg(md->client, 0x84, g->reg84);
-		  maven_set_reg(md->client, 0x85, g->reg85);
-		  maven_set_reg(md->client, 0x86, g->reg86);
-		  maven_set_reg(md->client, 0x87, g->reg87);
-		  maven_set_reg(md->client, 0x88, g->reg88);
-		  maven_set_reg(md->client, 0x89, g->reg89);
-		  maven_set_reg(md->client, 0x8a, g->reg8a);
-		  maven_set_reg(md->client, 0x8b, g->reg8b);
+		  maven_set_reg(&md->client, 0x83, g->reg83);
+		  maven_set_reg(&md->client, 0x84, g->reg84);
+		  maven_set_reg(&md->client, 0x85, g->reg85);
+		  maven_set_reg(&md->client, 0x86, g->reg86);
+		  maven_set_reg(&md->client, 0x87, g->reg87);
+		  maven_set_reg(&md->client, 0x88, g->reg88);
+		  maven_set_reg(&md->client, 0x89, g->reg89);
+		  maven_set_reg(&md->client, 0x8a, g->reg8a);
+		  maven_set_reg(&md->client, 0x8b, g->reg8b);
 		}
 		break;
 		case MATROXFB_CID_TESTOUT:
 		{
 			unsigned char val 
-			  = maven_get_reg (md->client,0x8d);
+			  = maven_get_reg(&md->client,0x8d);
 			if (p->value) val |= 0x10;
 			else          val &= ~0x10;
-			maven_set_reg (md->client, 0x8d, val);
+			maven_set_reg(&md->client, 0x8d, val);
 		}
 		break;
 		case MATROXFB_CID_DEFLICKER:
 		{
-		  maven_set_reg(md->client, 0x93, maven_compute_deflicker(md));
+		  maven_set_reg(&md->client, 0x93, maven_compute_deflicker(md));
 		}
 		break;
 	}
@@ -1185,7 +1185,6 @@
 	MINFO_FROM(container_of(clnt->adapter, struct i2c_bit_adapter, adapter)->minfo);
 
 	md->primary_head = MINFO;
-	md->client = clnt;
 	down_write(&ACCESS_FBINFO(altout.lock));
 	ACCESS_FBINFO(outputs[1]).output = &maven_altout;
 	ACCESS_FBINFO(outputs[1]).src = ACCESS_FBINFO(outputs[1]).default_src;
@@ -1243,19 +1242,17 @@
 					      I2C_FUNC_SMBUS_BYTE_DATA |
 					      I2C_FUNC_PROTOCOL_MANGLING))
 		goto ERROR0;
-	if (!(new_client = (struct i2c_client*)kmalloc(sizeof(*new_client) + sizeof(*data),
-			GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
-	data = (struct maven_data*)(new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
 	new_client->driver = &maven_driver;
 	new_client->flags = 0;
-	strcpy(new_client->name, "maven client");
+	strlcpy(new_client->name, "maven client", I2C_NAME_SIZE);
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 	err = maven_init_client(new_client);
@@ -1279,12 +1276,10 @@
 static int maven_detach_client(struct i2c_client* client) {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		printk(KERN_ERR "maven: Cannot deregister client\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 	maven_shutdown_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 


-- 
Jean Delvare


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

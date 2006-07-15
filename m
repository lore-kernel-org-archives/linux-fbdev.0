From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 2.6.17-1] fbmon: add generic
	ddc	read functionality
Date: Sat, 15 Jul 2006 09:29:16 -0400
Message-ID: <A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
References: <CCAD6957-F582-48B5-AD3F-E93330489913@cecropia.com>
	<04D28BB4-A610-486B-B314-9D6D44E0B09B@cecropia.com>
	<44B8EA8E.3070808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-716781000
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1kD3-0004hu-OW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 06:29:29 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1kD0-000257-Eq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 06:29:29 -0700
Received: from pool-71-126-243-234.bstnma.fios.verizon.net (HELO
	[192.168.0.100]) (dmunsie@cecropia.com@[71.126.243.234])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Jul 2006 13:29:20 -0000
In-Reply-To: <44B8EA8E.3070808@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


--Apple-Mail-1-716781000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I've attached both patches -- the fb-ddc-read.patch adds the generic  
ddc functionality, and the other patches the radeonfb driver to use  
the generic functionality instead.

There are other drivers that should be patched to use the generic  
functionality as well, but since I didn't have any other cards to  
test with, I just did the patch for the radeon (and intelfb as well,  
but that's not ready yet).

dennis

--Apple-Mail-1-716781000
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name=fb-ddc-read.patch
Content-Disposition: attachment;
	filename=fb-ddc-read.patch

From: Dennis Munsie <dmunsie@cecropia.com>

Adds functionality to read the EDID information over the DDC bus in a
generic way.  This code is based on the DDC implementation in the radeon
driver.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/fbmon.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h    |    2 
 2 files changed, 112 insertions(+)

diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff linux-2.6.17.1-patched/drivers/video/fbmon.c linux/drivers/video/fbmon.c
--- linux-2.6.17.1-patched/drivers/video/fbmon.c	2006-06-21 12:03:41.000000000 -0500
+++ linux/drivers/video/fbmon.c	2006-06-21 14:45:43.000000000 -0500
@@ -1314,6 +1314,116 @@ const unsigned char *fb_firmware_edid(st
 #endif
 EXPORT_SYMBOL(fb_firmware_edid);
 
+/*
+ * DDC/EDID read support.
+ *
+ * You must pass in an i2c_adapter that uses the bit algorithm, or
+ * there will be a panic.
+ */
+#if defined(CONFIG_I2C) && defined(CONFIG_I2C_ALGOBIT)
+#include <linux/i2c-algo-bit.h>
+#include <linux/delay.h>
+
+#define DDC_ADDR	0x50
+
+static unsigned char *fb_do_probe_ddc_edid(struct i2c_adapter *adapter)
+{
+	unsigned char start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= DDC_ADDR,
+			.len	= 1,
+			.buf	= &start,
+		}, {
+			.addr	= DDC_ADDR,
+			.flags	= I2C_M_RD,
+			.len	= EDID_LENGTH,
+		}
+	};
+	unsigned char *buf;
+
+	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_ERR "fbmon: unable to allocate memory for EDID block.\n");
+		return NULL;		
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(adapter, msgs, 2) == 2)
+		return buf;
+
+	printk(KERN_WARNING "fbmon: unable to read EDID block.\n");
+	kfree(buf);
+	return NULL;
+}
+
+unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
+{
+	struct i2c_algo_bit_data *algo_data = adapter->algo_data;
+	unsigned char *edid = NULL;
+	int i, j;
+	
+	algo_data->setscl(algo_data->data, 1);
+	algo_data->setscl(algo_data->data, 0);
+
+	for (i = 0; i < 3; i++) {
+		/* For some old monitors we need the
+		 * following process to initialize/stop DDC
+		 */
+		algo_data->setsda(algo_data->data, 0);
+		msleep(13);
+
+		algo_data->setscl(algo_data->data, 1);
+		for (j = 0; j < 5; j++) {
+			msleep(10);
+			if (algo_data->getscl(algo_data->data))
+				break;
+		}
+		if (j == 5)
+			continue;
+
+		algo_data->setsda(algo_data->data, 0);
+		msleep(15);
+		algo_data->setscl(algo_data->data, 0);
+		msleep(15);
+		algo_data->setsda(algo_data->data, 1);
+		msleep(15);
+
+		/* Do the real work */
+		edid = fb_do_probe_ddc_edid(adapter);
+		algo_data->setsda(algo_data->data, 0);
+		algo_data->setscl(algo_data->data, 0);
+		msleep(15);
+
+		algo_data->setscl(algo_data->data, 1);
+		for (j = 0; j < 10; j++) {
+			msleep(10);
+			if (algo_data->getscl(algo_data->data))
+				break;
+		}
+
+		algo_data->setsda(algo_data->data, 1);
+		msleep(15);
+		algo_data->setscl(algo_data->data, 0);
+		if (edid)
+			break;
+	}
+	/* Release the DDC lines when done or the Apple Cinema HD display
+	 * will switch off
+	 */
+	algo_data->setsda(algo_data->data, 0);
+	algo_data->setscl(algo_data->data, 0);
+
+	return edid;
+}
+#else
+unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
+{
+	return NULL;
+}
+#endif
+EXPORT_SYMBOL(fb_ddc_read);
+
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
 EXPORT_SYMBOL(fb_get_mode);
diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff linux-2.6.17.1-patched/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.6.17.1-patched/include/linux/fb.h	2006-06-21 12:03:42.000000000 -0500
+++ linux/include/linux/fb.h	2006-06-21 14:46:06.000000000 -0500
@@ -2,6 +2,7 @@
 #define _LINUX_FB_H
 
 #include <asm/types.h>
+#include <linux/i2c.h>
 
 /* Definitions of frame buffers						*/
 
@@ -924,6 +925,7 @@ extern void fb_edid_to_monspecs(unsigned
 				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
+extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34

--Apple-Mail-1-716781000
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name=radeonfb-use-generic-ddc-read.patch
Content-Disposition: attachment; filename=radeonfb-use-generic-ddc-read.patch

From: Dennis Munsie <dmunsie@cecropia.com>

Uses the generic ddc read functionality in fbmon.c instead of the
previous functionality.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/aty/radeon_i2c.c |  104 -----------------------------------------
 1 file changed, 1 insertion(+), 103 deletions(-)

diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff linux-2.6.17.1-patched/drivers/video/aty/radeon_i2c.c linux/drivers/video/aty/radeon_i2c.c
--- linux-2.6.17.1-patched/drivers/video/aty/radeon_i2c.c	2006-03-20 00:53:29.000000000 -0500
+++ linux/drivers/video/aty/radeon_i2c.c	2006-06-21 15:45:53.000000000 -0500
@@ -17,8 +17,6 @@
 #include "radeonfb.h"
 #include "../edid.h"
 
-#define RADEON_DDC 	0x50
-
 static void radeon_gpio_setscl(void* data, int state)
 {
 	struct radeon_i2c_chan 	*chan = data;
@@ -139,109 +137,9 @@ void radeon_delete_i2c_busses(struct rad
 	rinfo->i2c[3].rinfo = NULL;
 }
 
-
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
-
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->rinfo->pdev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
-}
-
-
 int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
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
-
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
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) |
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		if (edid)
-			break;
-	}
-	/* Release the DDC lines when done or the Apple Cinema HD display
-	 * will switch off
-	 */
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN | VGA_DDC_DATA_OUT_EN));
-	(void)INREG(reg);
-
+	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
 	if (out_edid)
 		*out_edid = edid;
 	if (!edid) {

--Apple-Mail-1-716781000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Jul 15, 2006, at 9:15 AM, Antonino A. Daplas wrote:

> Dennis Munsie wrote:
>> did anyone have any problems with this patch?  Just wondering if it
>> was going to be flipped upstream or if I need to make some changes to
>> it.
>
> Can you resend? I'm getting "malformed patch". An attachment is fine.
>
> Tony


--Apple-Mail-1-716781000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--Apple-Mail-1-716781000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Apple-Mail-1-716781000--

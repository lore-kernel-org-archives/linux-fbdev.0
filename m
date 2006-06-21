From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-1] fbmon: add generic ddc read
	functionality
Date: Wed, 21 Jun 2006 15:57:44 -0400
Message-ID: <CCAD6957-F582-48B5-AD3F-E93330489913@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ft8mF-00012a-7s for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 12:54:15 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ft8mE-0008KG-TV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 12:54:15 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Luca <kronos@people.it>, Eric Hustvedt <ehustvedt@cecropia.com>

hello,

another day, another patch... this one adds generic ddc/edid read  
functionality to fbmon.c.

I'm not convinced that this is the final version of this patch -- it  
works for me, but I would like to see it get some heavier testing.   
It's based on the radeon code, but that code twiddled some of the  
registers directly, where this patch uses the existing setsda,  
getsda, setscl, and getscl functions to do it's dirty work.  One  
possible side effect is that the original code could set both sda and  
scl at the same time, where this code can only set one after the  
other.  I don't know if this will be a factor or not.

Another minor issue is that the stubbed out function still requires  
the i2c.h file to be included since I use struct i2c_adapter as the  
parameter.  I thought of a few possible ways around this, but I left  
it the way it is right now because I figured that nothing was to be  
gained by not having that struct... if anyone feels otherwise, please  
let me know.

I'll put together a patch for the radeon driver today so that it will  
be easier to test.  I haven't worked out everything in the intelfb  
driver yet to post up a patch.

dennis

---

From: Dennis Munsie <dmunsie@cecropia.com>

Adds functionality to read the EDID information over the DDC bus in a
generic way.  This code is based on the DDC implementation in the radeon
driver.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/fbmon.c |  110 +++++++++++++++++++++++++++++++++++++++++ 
+++++++++
include/linux/fb.h    |    2
2 files changed, 112 insertions(+)

diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff  
linux-2.6.17.1-patched/drivers/video/fbmon.c linux/drivers/video/fbmon.c
--- linux-2.6.17.1-patched/drivers/video/fbmon.c	2006-06-21  
12:03:41.000000000 -0500
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
+		printk(KERN_ERR "fbmon: unable to allocate memory for EDID block. 
\n");
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
diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff  
linux-2.6.17.1-patched/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.6.17.1-patched/include/linux/fb.h	2006-06-21  
12:03:42.000000000 -0500
+++ linux/include/linux/fb.h	2006-06-21 14:46:06.000000000 -0500
@@ -2,6 +2,7 @@
#define _LINUX_FB_H
#include <asm/types.h>
+#include <linux/i2c.h>
/* Definitions of frame buffers						*/
@@ -924,6 +925,7 @@ extern void fb_edid_to_monspecs(unsigned
				struct fb_monspecs *specs);
extern void fb_destroy_modedb(struct fb_videomode *modedb);
extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins,  
int rb);
+extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
/* drivers/video/modedb.c */
#define VESA_MODEDB_SIZE 34


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

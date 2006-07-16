From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.17-1] fbmon: add generic
 ddc	read functionality
Date: Sun, 16 Jul 2006 11:23:44 +0800
Message-ID: <44B9B140.5090701@gmail.com>
References: <CCAD6957-F582-48B5-AD3F-E93330489913@cecropia.com>
	<04D28BB4-A610-486B-B314-9D6D44E0B09B@cecropia.com>
	<44B8EA8E.3070808@gmail.com>
	<A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1xF4-0002kn-LV for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:24:26 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G1xF3-00053H-FI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 20:24:26 -0700
Received: by py-out-1112.google.com with SMTP id c31so1817057pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Jul 2006 20:23:51 -0700 (PDT)
In-Reply-To: <A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
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
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dennis Munsie wrote:
> I've attached both patches -- the fb-ddc-read.patch adds the generic ddc
> functionality, and the other patches the radeonfb driver to use the
> generic functionality instead.
> 
> There are other drivers that should be patched to use the generic
> functionality as well, but since I didn't have any other cards to test
> with, I just did the patch for the radeon (and intelfb as well, but
> that's not ready yet).
> 
> dennis
> 
> On Jul 15, 2006, at 9:15 AM, Antonino A. Daplas wrote:
> 
>> Dennis Munsie wrote:
>>> did anyone have any problems with this patch?  Just wondering if it
>>> was going to be flipped upstream or if I need to make some changes to
>>> it.

Okay, just tested it. At least fb_ddc_read works() also with nvidiafb, and I'm
assuming it would also work with savage and i810, so I'll begin converting
them to that.

A few problems:

This:

+#if defined(CONFIG_I2C) && defined(CONFIG_I2C_ALGOBIT)

will compile the dummy version fb_ddc_read() if i2c support is enabled as
a module (CONFIG_I2C will not be defined, CONFIG_I2C_MODULE will be defined
instead).

So, I removed this particular line from the code. Also, I created a new file
for it (fb_ddc.c) instead of placing it in fbmon.c. I also created a Kconfig
option for it, so drivers that need it will need to have a 'select FB_DDC'
line in Kconfig.

I'm attaching an update patch. The authorship will be in your name (so people
can hunt you down when they have problems :-)). Anyway, check the version,
and let me know of any changes you want.

Now for a wishlist. Perhaps we can make the creation and deletion of the
i2c bus generic also, so we can maximize the size reduction and make it much
simpler for driver writers to add i2c support.

Tony 


fbdev: Add generic ddc read functionality

From: Dennis Munsie <dmunsie@cecropia.com>

Adds functionality to read the EDID information over the DDC bus in a
generic way.  This code is based on the DDC implementation in the radeon
driver.

[adaplas]
- separate from fbmon.c and place in new file fb_ddc.c
- remove dependency to CONFIG_I2C and CONFIG_I2C_ALGOBIT, otherwise, feature
  will not compile if i2c support is compiled as a module
- feature is selectable only by drivers needing it. It must have a
  'select FB_DDC if xxx' in Kconfig
- change printk's to dev_*, the i2c people prefers it

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig  |    5 ++
 drivers/video/Makefile |    1 
 drivers/video/fb_ddc.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h     |    2 +
 4 files changed, 124 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index be4b50a..8846262 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -53,6 +53,11 @@ config FB
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FB_DDC
+       tristate
+       depends on FB && I2C && I2C_ALGOBIT
+       default n
+
 config FB_CFB_FILLRECT
 	tristate
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 481c6c9..a6980e9 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfil
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
+obj-$(CONFIG_FB_DDC)           += fb_ddc.o
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
diff --git a/drivers/video/fb_ddc.c b/drivers/video/fb_ddc.c
new file mode 100644
index 0000000..3aa6ebf
--- /dev/null
+++ b/drivers/video/fb_ddc.c
@@ -0,0 +1,116 @@
+/*
+ * driver/vide/fb_ddc.c - DDC/EDID read support.
+ *
+ *  Copyright (C) 2006 Dennis Munsie <dmunsie@cecropia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/i2c-algo-bit.h>
+
+#include "edid.h"
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
+		dev_warn(&adapter->dev, "unable to allocate memory for EDID "
+			 "block.\n");
+		return NULL;
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(adapter, msgs, 2) == 2)
+		return buf;
+
+	dev_warn(&adapter->dev, "unable to read EDID block.\n");
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
+
+EXPORT_SYMBOL_GPL(fb_ddc_read);
+
+MODULE_AUTHOR("Dennis Munsie <dmunsie@cecropia.com>");
+MODULE_DESCRIPTION("DDC/EDID reading support");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 4ad0673..a49ba06 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -3,6 +3,7 @@ #define _LINUX_FB_H
 
 #include <linux/backlight.h>
 #include <asm/types.h>
+#include <linux/i2c.h>
 
 /* Definitions of frame buffers						*/
 
@@ -940,6 +941,7 @@ extern void fb_edid_to_monspecs(unsigned
 				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
+extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

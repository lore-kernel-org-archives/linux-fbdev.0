From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 03/41] savagefb: Rework i2c bit access
Date: Wed, 25 Apr 2007 14:18:03 +0800
Message-ID: <462EF29B.6090105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc4V-0000j1-0T for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:51 -0700
Received: from wx-out-0506.google.com ([66.249.82.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc4U-0005O7-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:50 -0700
Received: by wx-out-0506.google.com with SMTP id i30so293585wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:37:50 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Use already defined VGAwCR/VGArCR functions to access the i2c bus.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/savage/savagefb-i2c.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
index 8db066c..35c1ce6 100644
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -41,10 +41,6 @@ #define SAVAGE4_I2C_SDA_OUT	0x00000002
 #define SAVAGE4_I2C_SCL_IN	0x00000008
 #define SAVAGE4_I2C_SDA_IN	0x00000010
 
-#define SET_CR_IX(base, val)	writeb((val), base + 0x8000 + VGA_CR_IX)
-#define SET_CR_DATA(base, val)	writeb((val), base + 0x8000 + VGA_CR_DATA)
-#define GET_CR_DATA(base)	readb(base + 0x8000 + VGA_CR_DATA)
-
 static void savage4_gpio_setscl(void *data, int val)
 {
 	struct savagefb_i2c_chan *chan = data;
@@ -92,15 +88,15 @@ static void prosavage_gpio_setscl(void* 
 	struct savagefb_i2c_chan *chan = data;
 	u32			  r;
 
-	SET_CR_IX(chan->ioaddr, chan->reg);
-	r = GET_CR_DATA(chan->ioaddr);
+	r = VGArCR(chan->reg, chan->par);
 	r |= PROSAVAGE_I2C_ENAB;
 	if (val) {
 		r |= PROSAVAGE_I2C_SCL_OUT;
 	} else {
 		r &= ~PROSAVAGE_I2C_SCL_OUT;
 	}
-	SET_CR_DATA(chan->ioaddr, r);
+
+	VGAwCR(chan->reg, r, chan->par);
 }
 
 static void prosavage_gpio_setsda(void* data, int val)
@@ -108,31 +104,29 @@ static void prosavage_gpio_setsda(void* 
 	struct savagefb_i2c_chan *chan = data;
 	unsigned int r;
 
-	SET_CR_IX(chan->ioaddr, chan->reg);
-	r = GET_CR_DATA(chan->ioaddr);
+	r = VGArCR(chan->reg, chan->par);
 	r |= PROSAVAGE_I2C_ENAB;
 	if (val) {
 		r |= PROSAVAGE_I2C_SDA_OUT;
 	} else {
 		r &= ~PROSAVAGE_I2C_SDA_OUT;
 	}
-	SET_CR_DATA(chan->ioaddr, r);
+
+	VGAwCR(chan->reg, r, chan->par);
 }
 
 static int prosavage_gpio_getscl(void* data)
 {
 	struct savagefb_i2c_chan *chan = data;
 
-	SET_CR_IX(chan->ioaddr, chan->reg);
-	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SCL_IN));
+	return (VGArCR(chan->reg, chan->par) & PROSAVAGE_I2C_SCL_IN) ? 1 : 0;
 }
 
 static int prosavage_gpio_getsda(void* data)
 {
 	struct savagefb_i2c_chan *chan = data;
 
-	SET_CR_IX(chan->ioaddr, chan->reg);
-	return (0 != (GET_CR_DATA(chan->ioaddr) & PROSAVAGE_I2C_SDA_IN));
+	return (VGArCR(chan->reg, chan->par) & PROSAVAGE_I2C_SDA_IN) ? 1 : 0;
 }
 
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

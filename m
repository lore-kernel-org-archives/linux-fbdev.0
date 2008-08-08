From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2/3] matroxfb: i2c structure templates clean-up
Date: Fri, 8 Aug 2008 17:02:08 +0200
Message-ID: <20080808170208.6c76ff46@hyperion.delvare>
References: <20080808164937.141a95e0@hyperion.delvare>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754576AbYHHPC3@vger.kernel.org>
In-Reply-To: <20080808164937.141a95e0@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>

Clean up the use of structure templates in i2c-matroxfb. In this case
it's more efficient to initialize the few fields we need individually.
This makes i2c-matroxfb.ko 16% smaller on my system.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/i2c-matroxfb.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 20:23:41.000000000 +0200
+++ linux-2.6.26-rc6/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 20:27:36.000000000 +0200
@@ -87,13 +87,7 @@ static int matroxfb_gpio_getscl(void* da
 	return (matroxfb_read_gpio(b->minfo) & b->mask.clock) ? 1 : 0;
 }
 
-static struct i2c_adapter matrox_i2c_adapter_template =
-{
-	.owner =	THIS_MODULE,
-	.id =		I2C_HW_B_G400,
-};
-
-static struct i2c_algo_bit_data matrox_i2c_algo_template =
+static const struct i2c_algo_bit_data matrox_i2c_algo_template =
 {
 	.setsda		= matroxfb_gpio_setsda,
 	.setscl		= matroxfb_gpio_setscl,
@@ -112,7 +106,8 @@ static int i2c_bus_reg(struct i2c_bit_ad
 	b->minfo = minfo;
 	b->mask.data = data;
 	b->mask.clock = clock;
-	b->adapter = matrox_i2c_adapter_template;
+	b->adapter.owner = THIS_MODULE;
+	b->adapter.id = I2C_HW_B_G400;
 	snprintf(b->adapter.name, sizeof(b->adapter.name), name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);

-- 
Jean Delvare

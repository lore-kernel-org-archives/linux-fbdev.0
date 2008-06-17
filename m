From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2/3] matroxfb: i2c structure templates
	clean-up
Date: Tue, 17 Jun 2008 20:03:14 +0200
Message-ID: <20080617200314.5031dd04@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K8fWf-0002d8-Tm for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 11:03:25 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K8fWf-0006iy-BS
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 11:03:25 -0700
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

Clean up the use of structure templates in i2c-matroxfb. For one
thing, a real template is supposed to be read-only. And in some cases
it's more efficient to initialize the few fields we need individually.
This makes i2c-matroxfb.ko 16% smaller on my system.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/i2c-matroxfb.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 18:41:52.000000000 +0200
+++ linux-2.6.26-rc6/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 18:53:08.000000000 +0200
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
@@ -110,7 +104,8 @@ static int i2c_bus_reg(struct i2c_bit_ad
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

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

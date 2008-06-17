From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] radeonfb: Give i2c buses nicer names
Date: Tue, 17 Jun 2008 14:46:15 +0200
Message-ID: <20080617144615.6574fc83@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K8aa7-0007j9-FT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 05:46:39 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K8aa5-0005nD-2b
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 05:46:39 -0700
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

The name of the i2c buses shows in the output of "i2cdetect -l", so
it's important to give informative names.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Antonino, can you please push this upstream? Thanks.

 drivers/video/aty/radeon_i2c.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.26-rc5.orig/drivers/video/aty/radeon_i2c.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc5/drivers/video/aty/radeon_i2c.c	2008-06-06 08:43:51.000000000 +0200
@@ -69,7 +69,8 @@ static int radeon_setup_i2c_bus(struct r
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	snprintf(chan->adapter.name, sizeof(chan->adapter.name),
+		 "radeonfb %s", name);
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.id		= I2C_HW_B_RADEON;
 	chan->adapter.algo_data		= &chan->algo;


-- 
Jean Delvare

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

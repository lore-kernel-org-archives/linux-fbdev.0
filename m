From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 1/3] radeonfb: Speed up the I2C buses
Date: Tue, 12 Feb 2008 10:19:15 +0100
Message-ID: <20080212101915.1dce8475@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOrIV-0000mc-Of for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 01:19:27 -0800
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JOrIU-0001cY-B7
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 01:19:27 -0800
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

There is no reason to drive the radeon I2C buses at such a low
speed, so bump it from 12.5 kbps to 50 kbps. The Intel (i810) and
Matrox framebuffer drivers already run their I2C bus at this speed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This patch was already sent on:
 * 2007-03-08
 * 2007-09-09

 drivers/video/aty/radeon_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.21-git.orig/drivers/video/aty/radeon_i2c.c	2007-05-09 10:52:26.000000000 +0200
+++ linux-2.6.21-git/drivers/video/aty/radeon_i2c.c	2007-05-09 10:55:51.000000000 +0200
@@ -77,7 +77,7 @@ static int radeon_setup_i2c_bus(struct r
 	chan->algo.setscl		= radeon_gpio_setscl;
 	chan->algo.getsda		= radeon_gpio_getsda;
 	chan->algo.getscl		= radeon_gpio_getscl;
-	chan->algo.udelay		= 40;
+	chan->algo.udelay		= 10;
 	chan->algo.timeout		= 20;
 	chan->algo.data 		= chan;	
 	


-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: rivafb I2C timings too fast
Date: Wed, 15 Sep 2004 05:53:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409150553.20272.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7LFW-000160-5z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 14:54:06 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7LFV-0000nh-FC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 14:54:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 093C9720EF
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Sep 2004 21:53:51 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Nicolas Boichat <nicolas@boichat.ch>

The timings in rivafb's i2c, although enough for EDID reading, are too fast
for some user applications. Reported by Nicolas Boichat
<nicolas@boichat.ch>.

This patch increases the timeouts.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 rivafb-i2c.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -uprN linux-2.6.9-rc1-mm5-orig/drivers/video/riva/rivafb-i2c.c linux-2.6.9-rc1-mm5/drivers/video/riva/rivafb-i2c.c
--- linux-2.6.9-rc1-mm5-orig/drivers/video/riva/rivafb-i2c.c	2004-09-13 19:50:17.000000000 +0800
+++ linux-2.6.9-rc1-mm5/drivers/video/riva/rivafb-i2c.c	2004-09-15 05:38:19.307344544 +0800
@@ -105,9 +105,8 @@ static int riva_setup_i2c_bus(struct riv
 	chan->algo.setscl		= riva_gpio_setscl;
 	chan->algo.getsda		= riva_gpio_getsda;
 	chan->algo.getscl		= riva_gpio_getscl;
-	chan->algo.udelay		= 5;
-	chan->algo.mdelay               = 5;
-	chan->algo.timeout		= 10;
+	chan->algo.udelay		= 40;
+	chan->algo.timeout		= 20;
 	chan->algo.data 		= chan;
 
 	i2c_set_adapdata(&chan->adapter, chan);




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m

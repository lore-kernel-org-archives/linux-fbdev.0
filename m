From: Nicolas Boichat <nicolas@boichat.ch>
Subject: rivafb / DDC/CI problem
Date: Tue, 14 Sep 2004 17:57:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1095177461.7045.24.camel@tom>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Fi2-00008g-7I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 08:59:10 -0700
Received: from b1.ovh.net ([213.186.33.51] helo=mail44.ha.ovh.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1C7Fi1-0000IV-Af
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 08:59:10 -0700
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
To: adaplas@pol.net
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fbdev-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>

Hello,

I have a problem with this patch :
rivafb-directcolor-mode-and-miscellaneous-fixes.patch

It has been included in 2.6.8.1-mm1, and in 2.6.9-rc1.

The following part of the patch breaks DDC/CI implementation (monitor
control by software, see http://sourceforge.net/projects/ddccontrol/),
as bits are sent too fast to the monitor on the I2C bus:

diff -puN
drivers/video/riva/rivafb-i2c.c~rivafb-directcolor-mode-and-miscellaneous-fixes drivers/video/riva/rivafb-i2c.c
--- 25/drivers/video/riva/rivafb-i2c.c~rivafb-directcolor-mode-and-miscellaneous-fixes	2004-08-21 13:47:37.761874856 -0700
+++ 25-akpm/drivers/video/riva/rivafb-i2c.c	2004-08-21 13:47:37.774872880 -0700
@@ -105,8 +105,9 @@ static int riva_setup_i2c_bus(struct riv
 	chan->algo.setscl		= riva_gpio_setscl;
 	chan->algo.getsda		= riva_gpio_getsda;
 	chan->algo.getscl		= riva_gpio_getscl;
-	chan->algo.udelay		= 40;
-	chan->algo.timeout		= 20;
+	chan->algo.udelay		= 5;
+	chan->algo.mdelay               = 5;
+	chan->algo.timeout		= 10;
 	chan->algo.data 		= chan;
 
 	i2c_set_adapdata(&chan->adapter, chan);

Antonino, could you explain why you changed these values, as both works for EDID reading?
(atyfb use 40 as udelay, and 20 as timeout, the original values)

Is it possible to remove this part of the patch from the current kernel version?

Best regards,

Nicolas Boichat



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: New radeonfb, mostly untested
Date: Sun, 07 Sep 2003 20:23:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062959005.638.29.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907174802.GA5945@dreamland.darkstar.lan>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w4DE-0002FR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 11:24:36 -0700
Received: from smtp3.wanadoo.fr ([193.252.22.25] helo=mwinf0601.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19w4DD-0004MF-Bh
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 11:24:35 -0700
In-Reply-To: <20030907174802.GA5945@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: kronos@kronoz.cjb.net
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

>  
> There's a problem here: sysfs attributes are unregistered after
> radeonfb_pci_unregister returns, so we have a small windows where
> mon1_EDID and mon2_EDID are invalid and edid1 and edid2 are still
> there in sysfs. Ditto for pci_register.

Yup, there is much "polish" still needed on the exit/cleanup path,
though I'm waiting to see what you come up with putting class_device
in there :)

> Oh, you didn't update aty/Makefile ;)
> 
> obj-$(CONFIG_FB_RADEON) += radeonfb.o
> radeonfb-y += radeon_base.o radeon_monitor.o radeon_pm.o
> radeonfb-$(CONFIG_FB_RADEON_I2C) += radeon_i2c.o

It's here, not in the patch, sorry.

I won't have time to work more on this until later next week, so feel
free to send your own patches/fixes/etc... If you feel it's ready to
push to the mesa bk tree, let me know.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: New radeonfb, mostly untested
Date: Sun, 07 Sep 2003 20:49:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062960554.647.34.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907174802.GA5945@dreamland.darkstar.lan>
	 <1062959005.638.29.camel@gaston>
	 <20030907184343.GA9078@dreamland.darkstar.lan>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w4bp-0004q4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 11:50:01 -0700
Received: from smtp4.wanadoo.fr ([193.252.22.26] helo=mwinf0504.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19w4bo-0003ZN-JT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 11:50:00 -0700
In-Reply-To: <20030907184343.GA9078@dreamland.darkstar.lan>
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

On Sun, 2003-09-07 at 20:43, Kronos wrote:
> Il Sun, Sep 07, 2003 at 08:23:48PM +0200, Benjamin Herrenschmidt ha scritto: 
> > > There's a problem here: sysfs attributes are unregistered after
> > > radeonfb_pci_unregister returns, so we have a small windows where
> > > mon1_EDID and mon2_EDID are invalid and edid1 and edid2 are still
> > > there in sysfs. Ditto for pci_register.
> > 
> > Yup, there is much "polish" still needed on the exit/cleanup path,
> > though I'm waiting to see what you come up with putting class_device
> > in there :)
> 
> edid1  and edid2  will be  attached to  the class_device,  they will  be
> unregistered before the "release". The problem will go away.
> 
> Btw, the class_device stuff won't go in, it's too late. I'll maintain it
> off tree and submit around 2.6.2.

I don't think it's too late... on the other hand, James is still sitting
on a bunch of patches (hey James !) that should get in asap now...

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Generic framebuffer driver
Date: Sat, 21 Aug 2004 11:02:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41270FBE.88832BF8@orpatec.ch>
References: <41261BF3.19B87A64@orpatec.ch> <Pine.GSO.4.58.0408201805270.6741@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByRmC-0006nh-R9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 02:03:04 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1ByRmA-0001mk-WC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 02:03:04 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 11:07:49 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> 
> On Fri, 20 Aug 2004, Otto Wyss wrote:
> > I guess this is a common feature of the digital interface and might be
> > available for any graphic card/monitor with DVI. Does anyone know for
> > sure? If yes this feature would allow to create a generic framebuffer
> 
> It can work for normal monitors as well, using DDC.
> 
Maybe, but then I'm wondering why it only works with DVI in the
radeonfb. Has anyone tried a DVI cable with other cards and can post information?

> > driver which could be built into the kernel and used right from the
> > start. How nice would it be to have a shiny startup screen right from
> > the start of Linux! All the startup messages could be shown in a decent
> > font (maybe even configurable) and might be surrounded by a nice window.
> > What a difference would it make against the current DOS-like look.
> 
> Like what e.g. SUSE does?
> 
Unfortunately I don't have Suse, is there link to an image? Anyway I
though more like the Mac, besides the Mac shows that such a solution is possible.

> > Do you also think such a generic driver should exist? Is anyone able to
> > create it, maybe simply extract it from the radeonfb?
> 
> This generic driver does not exist. And it's not simple to write, since it's
> hardware dependent.
> 
> The closest thing to such a generic driver is the existing vesafb. Perhaps on
> some cards the BIOS uses DDC as well to find a nice video mode?
> 
The vesafb proves that there is a common base for framebuffer driver.
IMO any card having a DVI plug also has to have a common protocol which
can be used for a generic driver without being too hardware dependent
and also without using BIOS calls. It might be possible to create such a
driver for all cards but it shouldn't be too difficult to create it for
i.e. 80%.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Generic framebuffer driver
Date: Sat, 21 Aug 2004 12:27:21 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408211225320.16715@waterleaf.sonytel.be>
References: <41261BF3.19B87A64@orpatec.ch> <Pine.GSO.4.58.0408201805270.6741@waterleaf.sonytel.be>
 <41270FBE.88832BF8@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByT62-0001hf-3V
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 03:27:38 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByT5v-0006ff-Ob
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 03:27:37 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7LARLn1010812
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 12:27:26 +0200 (MEST)
In-Reply-To: <41270FBE.88832BF8@orpatec.ch>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 21 Aug 2004, Otto Wyss wrote:
> Geert Uytterhoeven wrote:
> > On Fri, 20 Aug 2004, Otto Wyss wrote:
> > > Do you also think such a generic driver should exist? Is anyone able to
> > > create it, maybe simply extract it from the radeonfb?
> >
> > This generic driver does not exist. And it's not simple to write, since it's
> > hardware dependent.
> >
> > The closest thing to such a generic driver is the existing vesafb. Perhaps on
> > some cards the BIOS uses DDC as well to find a nice video mode?
> >
> The vesafb proves that there is a common base for framebuffer driver.
> IMO any card having a DVI plug also has to have a common protocol which
> can be used for a generic driver without being too hardware dependent
> and also without using BIOS calls. It might be possible to create such a
> driver for all cards but it shouldn't be too difficult to create it for
> i.e. 80%.

DVI is just the transport protocol to talk to the TFT. Graphics chips are still
initialized by the BIOS to VGA text mode.

You still need software to:
  - initialize the graphics chip to the video mode you want
  - program the DVI controller

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Generic framebuffer driver
Date: Fri, 20 Aug 2004 18:09:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408201805270.6741@waterleaf.sonytel.be>
References: <41261BF3.19B87A64@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByBxX-0007kJ-T3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 09:09:43 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByBxX-0000YO-7c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 09:09:43 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7KG9Zn1005491
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Aug 2004 18:09:35 +0200 (MEST)
In-Reply-To: <41261BF3.19B87A64@orpatec.ch>
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
To: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 20 Aug 2004, Otto Wyss wrote:
> Since I never could acceptable align my monitor screen between Windows,
> Linux console and Linux X-server I bought a DVI cable and switch to
> digital mode. Immediately I discovered a fantastic feature of the radeon
> framebuffer driver, it's able to discover the correct resolution of my
> LCD monitor.
>
> I guess this is a common feature of the digital interface and might be
> available for any graphic card/monitor with DVI. Does anyone know for
> sure? If yes this feature would allow to create a generic framebuffer

It can work for normal monitors as well, using DDC.

> driver which could be built into the kernel and used right from the
> start. How nice would it be to have a shiny startup screen right from
> the start of Linux! All the startup messages could be shown in a decent
> font (maybe even configurable) and might be surrounded by a nice window.
> What a difference would it make against the current DOS-like look.

Like what e.g. SUSE does?

> The main task of this generic driver is to detect and switch to the
> correct resolution and may only handle simple 2D drawing. It should only
> support common features. It needs only be useful during startup and in
> cases no specific framebuffer driver exists. And of course it has to
> stop working and yield any resources when a card specific driver is loaded.
>
> Do you also think such a generic driver should exist? Is anyone able to
> create it, maybe simply extract it from the radeonfb?

This generic driver does not exist. And it's not simple to write, since it's
hardware dependent.

The closest thing to such a generic driver is the existing vesafb. Perhaps on
some cards the BIOS uses DDC as well to find a nice video mode?

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

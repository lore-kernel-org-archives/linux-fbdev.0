From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer
 Splash
Date: Sun, 13 Mar 2005 19:53:55 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503131953090.3876@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
 <1110408049.9942.275.camel@localhost.localdomain>
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be> <20050310145419.GD632@openzaurus.ucw.cz>
 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
 <20050313182032.GA1427@elf.ucw.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAYET-0007sR-VU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 10:54:33 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAYES-0002fz-9r
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 10:54:33 -0800
In-Reply-To: <20050313182032.GA1427@elf.ucw.cz>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Pavel Machek <pavel@ucw.cz>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Sun, 13 Mar 2005, Pavel Machek wrote:
> > > > > Thats why moving the eye candy console into user space is such a good
> > > > > idea. You don't have to run it 8) It also means that the console
> > > > > development is accessible to all the crazy rasterman types.
> > > > 
> > > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > > from basic console to user space console in early userspace.
> > > > 
> > > 
> > > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > > simply applies broken patch to their kernel... unless their distribution applied one
> > > already.
> > > 
> > > Situation where we have one working eye-candy patch would certainly
> > > be an improvement.
> > 
> > Why do we need patches in the kernel. Just set you config to 
> > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or 
> > vgacon. Then have a userspace app using /dev/fb and /dev/input create a 
> > userland console. There is no need to do special hacks in the kernel.
> 
> Except that I'll not get usefull reports from Oopsen and panic's,
> right? Ideally I'd also like high-priority kernel messages to be
> displayed during boot.

Indeed. I thought the idea was to use the existing fbcon support to draw
emergency messages to the screen.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

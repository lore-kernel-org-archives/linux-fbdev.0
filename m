From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer Splash
Date: Thu, 10 Mar 2005 15:54:20 +0100
Message-ID: <20050310145419.GD632@openzaurus.ucw.cz>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com> <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be> <1110392212.3116.215.camel@localhost.localdomain> <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> <1110408049.9942.275.camel@localhost.localdomain> <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9V5H-0005Dj-83
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 13:20:43 -0800
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9V5F-0004s7-OX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 13:20:43 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

Hi!

> > > Thank you. We need some kind of basic console in the kernel. I'm not the 
> > > biggest fan of eye candy. So moving the console to userspace for eye candy 
> > > is a dumb idea.
> > 
> > Thats why moving the eye candy console into user space is such a good
> > idea. You don't have to run it 8) It also means that the console
> > development is accessible to all the crazy rasterman types.
> 
> Yep. The basic console we already have. Everyone who wants eye candy can switch
> from basic console to user space console in early userspace.
> 

Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
simply applies broken patch to their kernel... unless their distribution applied one
already.

Situation where we have one working eye-candy patch would certainly
be an improvement.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

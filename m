From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer
 Splash
Date: Thu, 10 Mar 2005 10:12:03 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
References: <20050308015731.GA26249@spock.one.pl> <200503091301.15832.adaplas@hotpop.com>
 <9e473391050308220218cc26a3@mail.gmail.com> <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
 <1110392212.3116.215.camel@localhost.localdomain>
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
 <1110408049.9942.275.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9JjG-0002Gh-MJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 01:13:14 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9JjD-0006LW-16
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 01:13:14 -0800
In-Reply-To: <1110408049.9942.275.camel@localhost.localdomain>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Michal Januszewski <spock@gentoo.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Wed, 9 Mar 2005, Alan Cox wrote:
> On Mer, 2005-03-09 at 20:45, James Simmons wrote:
> > Thank you. We need some kind of basic console in the kernel. I'm not the 
> > biggest fan of eye candy. So moving the console to userspace for eye candy 
> > is a dumb idea.
> 
> Thats why moving the eye candy console into user space is such a good
> idea. You don't have to run it 8) It also means that the console
> development is accessible to all the crazy rasterman types.

Yep. The basic console we already have. Everyone who wants eye candy can switch
from basic console to user space console in early userspace.

Gr{oetje,eeting}s,

						Geert

P.S. Many years ago, when I discussed integrating the so-called `abstract
     console driver', which allowed to have vgacon and fbcon in the kernel, I
     also pondered to make the console a simple tty in response to a `KISS'
     request. Now it's time to make that happen ;-)
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

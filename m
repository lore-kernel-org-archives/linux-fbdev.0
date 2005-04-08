From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Resource management for fbdev.
Date: Fri, 8 Apr 2005 10:10:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0504081008380.30996@numbat.sonytel.be>
References: <Pine.LNX.4.56.0503260019020.20306@pentafluge.infradead.org>
 <1112925171.9517.358.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJoaA-00048e-5y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 08 Apr 2005 01:11:14 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJoa7-0004Yc-Gv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 08 Apr 2005 01:11:14 -0700
In-Reply-To: <1112925171.9517.358.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On Fri, 8 Apr 2005, Benjamin Herrenschmidt wrote:
> Also, we need to properly deal with the fact that real soon now, not all
                                                    ^^^^^^^^^^^^^
> of the video memory will be accessible from the CPU (not only from the
> kernel, but from the CPU in general). There are already cards whose PCI
> aperture is too small to enclose the entire video memory, and some funky
> issues with aperture control on radeons might make me also limit the
> amount of video memory accessible.

Ah, finally the PC world is catching up? :-)

This has existed since ages, cfr. TMS34010 and '020 graphics on Amiga (e.g.
A2410 and DMI Resolver) and Tektronix X-terminals, and many SGI machines.

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

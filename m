From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.6][RESEND] fbcon margins colour
 fix
Date: Thu, 18 Mar 2004 10:42:33 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403181041230.10688@waterleaf.sonytel.be>
References: <20040317233135.GB3510@satan.blackhosts>
 <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
 <20040318093715.GB17838@gruby.cs.net.pl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3u2x-00030B-Sr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:42:39 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B3u2t-0003Tf-3J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:42:35 -0800
In-Reply-To: <20040318093715.GB17838@gruby.cs.net.pl>
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
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> On Thu, Mar 18, 2004 at 10:21:31AM +0100, Geert Uytterhoeven wrote:
> > On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> > > I sent it a few times to linux-kernel and at least one to
> > > linux-fbdev-devel, but haven't seen any comments - and this annoying
> > > changing margins colour seems to be still there in 2.6.4 (at least on
> > > tdfxfb).
> >
> > What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
> > In that case the overscan color is white.
>
> Uhm. What is palette entry for this white?

0, on pseudocolor displays. So probably it's OK.

> Or, more generally, how to find (palette colour number of) overscan
> colour for current console?
> Video erase character colour is not proper one as it may be different
> even from background colour at the moment of vt switch.

There's no standardized way for that. So it may depend on the driver. I know
ATI Mach64 has a special register for the overscan color, which is always set
to black, IIRC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

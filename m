From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Tue, 26 Jul 2005 09:13:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507260912210.3470@numbat.sonytel.be>
References: <200507172043.41473.jesper.juhl@gmail.com> 
 <9e473391050717132233347d25@mail.gmail.com>  <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
 <9e47339105071715322c558403@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxJdl-0002Xn-6O
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 00:14:13 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DxJdj-000106-J9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 00:14:13 -0700
In-Reply-To: <9e47339105071715322c558403@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 17 Jul 2005, Jon Smirl wrote:
> On 7/17/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > struct fb_super_cmap {
> > >    struct fb_cmap cmap;
> > >    __u16 red[255];
> > >    __u16 blue[255];
> > >    __u16 green[255];
> > >    __u16 transp[255];
> >                   ^^^
> > I assume you meant 256?
> > 
> > > }
> > >
> > > Then adjust the code as need. Have the embedded cmap struct point to
> > > the fields in the super_cmap and the drivers don't have to be changed.
> > 
> > What if your colormap has more than 256 entries?
> 
> I meant 256. Does any hardware exist that takes more that 256 entries? 

1024 was quite common on high-end graphics hardware.

> They are __u16 values but I have never seen hardware that take more
> that __u8 either.

10 bit was quite common on high-end graphics hardware.

IIRC, DEC TGA can do at least one of them.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

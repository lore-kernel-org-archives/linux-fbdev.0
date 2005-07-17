From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Sun, 17 Jul 2005 23:14:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
References: <200507172043.41473.jesper.juhl@gmail.com>
 <9e473391050717132233347d25@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DuGTT-0002Q1-Pn
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Jul 2005 14:14:59 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DuGTR-0003BZ-A6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Jul 2005 14:14:59 -0700
In-Reply-To: <9e473391050717132233347d25@mail.gmail.com>
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
> On 7/17/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Resource freeing functions should generally be safe to call with NULL pointers.
> > Why?
> >  - there is some precedence in the kernel for this for deallocation functions.
> >  - removes the need for callers to check pointers for NULL.
> >  - space is saved overall by less code to test pointers for NULL all over the place.
> >  - removes possible NULL pointer dereferences when a caller forgot to check.
> > 
> > This patch makes  fb_dealloc_cmap()  safe to call with a NULL pointer argument.
> 
> The fb cmap copde would be a lot simpler if it did everything with a
> single allocation instead of five. Make a super cmap struct:
> 
> struct fb_super_cmap {
>    struct fb_cmap cmap;
>    __u16 red[255];
>    __u16 blue[255];
>    __u16 green[255];
>    __u16 transp[255];
                  ^^^
I assume you meant 256?

> }
> 
> Then adjust the code as need. Have the embedded cmap struct point to
> the fields in the super_cmap and the drivers don't have to be changed.

What if your colormap has more than 256 entries?

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

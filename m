From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Tue, 15 Mar 2005 18:26:42 +0800
Message-ID: <200503151826.42957.adaplas@hotpop.com>
References: <20050314130014.55A073658E8@mail.esiee.fr> <200503142306.00236.adaplas@hotpop.com> <20050315071735.GA5037@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB9GO-0004aD-IQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 02:27:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DB9GO-0007Hm-0M
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 02:27:00 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E2EBFFBBCD0
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 10:26:39 +0000 (UTC)
In-Reply-To: <20050315071735.GA5037@linux-sh.org>
Content-Disposition: inline
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
To: Paul Mundt <lethal@linux-sh.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 15 March 2005 15:17, Paul Mundt wrote:
> On Mon, Mar 14, 2005 at 11:06:00PM +0800, Antonino A. Daplas wrote:
> > In the case of hitfb, fillrect and copyarea are both accelerated.  So the
> > proper flags would be:
> >
> > FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_COPYAREA |
> > FBINFO_HWACCEL_FILLRECT.
>
> Should this not be implied by having something other then the cfb_
> routines for these?

Yes.

> On the other hand, will this affect performance
> negatively if these flags remain and we end up wrapping to the cfb_
> routines in certain cases?

Yes, if cfb_copyarea is used and FBINFO_HWACCEL_COPYAREA is set,  fbcon
will use SCROLL_MOVE. And SCROLL_MOVE is magnitudes slower than
SCROLL_REDRAW especially for unaccelerated PCI/AGP cards.

>
> If we consider the case of FBINFO_HWACCEL_COPYAREA:
>
>         if ((cap & FBINFO_HWACCEL_COPYAREA) &&
>             !(cap & FBINFO_HWACCEL_DISABLED))
>                 p->scrollmode = SCROLL_MOVE;
>         else /* default to something safe */
>                 p->scrollmode = SCROLL_REDRAW;
>
>
> This doesn't seem like it will work out well if we end up having
> something like (using neofb as an example):
>
> static void
> neofb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
> {
>         switch (info->fix.accel) {
>                 case FB_ACCEL_NEOMAGIC_NM2200:
>                 case FB_ACCEL_NEOMAGIC_NM2230:
>                 case FB_ACCEL_NEOMAGIC_NM2360:
>                 case FB_ACCEL_NEOMAGIC_NM2380:
>                         neo2200_copyarea(info, area);
>                         break;
>                 default:
>                         cfb_copyarea(info, area);
>                         break;
>         }
> }
>
> The behaviour in this case will be to use SCROLL_MOVE with regards to
> cfb_copyarea() instead of SCROLL_REDRAW as it would normally. If we trust
> the comment, then this seems unsafe or broken.

Yes.

>
> In this case it would seem to be more sensible to fix neo_alloc_fb_info()
> to only set these flags for those devices where an optimization exists.
> In the case of where using the optimized method depends on a fixed bit
> depth, this issue becomes a bit more problematic.

Yes, the hwaccel flags should be fixed for neofb.  Also drivers can always
reset these flags during the set_par() part, if for example accel is only
available at depth 8, 16, 24,  but not 32 (i810fb).

Fortunately, SCROLL_REDRAW  is an acceptable default, accelerated or not.
It's not very fast, but is not that slow either. It's just that setting the
wrong flags can lead to significant performance loss, and not setting any
flags at all may underutilize the driver's capability.

So driver maintainers may need to try out which flags work best for them.
This is the algo used to choose the scrolling mode (in fbcon.c):

	if (good_wrap || good_pan) {
		if (reading_fast || fast_copyarea)
			p->scrollmode = good_wrap ? SCROLL_WRAP_MOVE : SCROLL_PAN_MOVE;
		else
			p->scrollmode = good_wrap ? SCROLL_REDRAW :
				SCROLL_PAN_REDRAW;
	} else {
		if (reading_fast || (fast_copyarea && !fast_imageblit))
			p->scrollmode = SCROLL_MOVE;
		else
			p->scrollmode = SCROLL_REDRAW;
	}


Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 23:06:00 +0800
Message-ID: <200503142306.00236.adaplas@hotpop.com>
References: <20050314130014.55A073658E8@mail.esiee.fr> <200503142207.57074.adaplas@hotpop.com> <20050314143509.GD2695@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAr95-0005is-Bs
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:06:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAr93-0001L6-RO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:06:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A57C5FAE736
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 15:06:04 +0000 (UTC)
In-Reply-To: <20050314143509.GD2695@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net

On Monday 14 March 2005 22:35, Paul Mundt wrote:
> On Mon, Mar 14, 2005 at 10:10:35PM +0800, Antonino A. Daplas wrote:
> > BTW, I would guess that scrolling is slow in this driver.  Since this
> > driver can do pan_display, If this:
> >
> > info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> >
> > is added somewhere before register_framebuffer(), and var->xres_virtual >
> > var->xres, you might get a several-fold increase in scrolling speed
> > (since scrolling mode will be SCROLL_PAN_REDRAW instead of
> > SCROLL_REDRAW).
>
> This is interesting. When FBINFO_HWACCEL_YPAN was added to hitfb, it slowed
> down scrolling by several orders of magnitude. Perhaps it was something
> relating to how the pan_display was implemented, but it's definitely not
> a general win for everyone..

In the case of hitfb, fillrect and copyarea are both accelerated.  So the proper flags would
be:

FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_COPYAREA |
FBINFO_HWACCEL_FILLRECT.

If you think that ypan has problems, then you can remove the
FBINFO_HWACCEL_YPAN part.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH 8/10] fbdev: Allow core fb to be
 built as a module
Date: Tue, 8 Mar 2005 22:50:28 -0800
Message-ID: <20050308225028.2b1015b4.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
	<9e47339105030720507cc34a68@mail.gmail.com>
	<20050307205808.60301d30.akpm@osdl.org>
	<200503091348.35322.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8v27-0007Xw-Rq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 22:51:03 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8v22-0003pz-Qf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 22:51:03 -0800
In-Reply-To: <200503091348.35322.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, jonsmirl@gmail.com

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> On Tuesday 08 March 2005 12:58, Andrew Morton wrote:
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > Did you fix this or do I need to send another patch?
> >
> > I fixed it.
> >
> >
> >
> > We seem to have a few newish fbdev bugs btw:
> >
> > From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > To: linux-kernel@vger.kernel.org, jim.hague@acm.org,
> > linux-fbdev-devel@lists.sourceforge.net Subject: [2.6.11 Permedia-2
> > Framebuffer] driver broken (?).
> >
> 
> Resolved by Jim Hague in another thread.  If you haven't seen it yet,
> here's the patch.
> 
> --- drivers/video/pm2fb.c.orig  2005-03-07 15:35:28.000000000 +0000
> +++ drivers/video/pm2fb.c       2005-03-07 18:34:13.000000000 +0000
> @@ -747,7 +747,7 @@
>         }
>         if ((info->var.vmode & FB_VMODE_MASK)==FB_VMODE_DOUBLE)
>                 video |= PM2F_LINE_DOUBLE;
> -       if (info->var.activate==FB_ACTIVATE_NOW)
> +       if ((info->var.activate & FB_ACTIVATE_MASK)==FB_ACTIVATE_NOW)
>                 video |= PM2F_VIDEO_ENABLE;
>         par->video = video;

OK, thanks.  I'll wait until your next patch drop for this.

> 
> >
> > From: Henrik Persson <root@fulhack.info>
> > To: unlisted-recipients:;;@localhost.localdomain (no To-header on input)
> > Cc: dtor@mail.ru, linux-kernel@vger.kernel.org
> > Subject: Re: Touchpad "tapping" changes in 2.6.11?
> >
> > 	("Well, -mm1 didn't quite agree with my savage gfx drivers")
> 
> Any details on this?
> 

Yeah, it was just a compile error due to the support-multiple-AGP-bridges
API change.  No doubt the devleopers will fix that up soon.  

Henrik said he's using drivers from:

 CVS (from mesa, xorg and dri cvs all-in-one) snapshots at 
 http://dri.freedesktop.org/snapshots/

 I don't really know why it isn't merged. It's under pretty heavy 
 development right now, but maybe it could get into -mm anyway?

 Felix Khling <fxkuehl@gmx.de> is the driver hacker. He should know more.

A DRI driver, I guess.  Are we planning on merging that in?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

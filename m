From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 Feb 2011 13:47:48 +0000
Subject: Re: [PATCH] mx3fb: Fix parameter to sdc_init_panel
Message-Id: <Pine.LNX.4.64.1102161443530.20711@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297332330-21964-1-git-send-email-alexander.stein@systec-electronic.com>
	<201102140846.47249.alexander.stein@systec-electronic.com>
	<Pine.LNX.4.64.1102140856070.7331@axis700.grange>
	<201102141306.43739.alexander.stein@systec-electronic.com>
In-Reply-To: <201102141306.43739.alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Alexander Stein wrote:

> On Monday 14 February 2011, 08:57:04 Guennadi Liakhovetski wrote:
> > On Mon, 14 Feb 2011, Alexander Stein wrote:
> > > On Thursday 10 February 2011, 14:01:17 Alexander Stein wrote:
> > > > On Thursday 10 February 2011, 13:48:23 Guennadi Liakhovetski wrote:
> > > > > > I don't know which display you used, but I guess your right_margin
> > > > > > (and lower_margin) needs to be adjusted.
> > > > > 
> > > > > Ok, agree. But then you need to adjust all current users and have
> > > > > them tested... Otherwise, of course, you can just adjust your
> > > > > platform panel data to work with the current calculations, even
> > > > > though in principle your patch seems to be doing the right thing
> > > > > (tm), according to the manual. But if applied as is without fixing
> > > > > all the users, it can very well break them...
> > > > 
> > > > Ok, I've just seen there are some model defines in mx3fb.c which would
> > > > also be affected.
> > > > I'll try to find all mx3fb users and fix their videomodes and repost a
> > > > new patch.
> > > 
> > > Uh, this seems next to impossible for me to handle it my own. I checked
> > > some users of the mx3fb but I cant say which ones will be affected and
> > > which ones not (e.g. without any hsync/vsync, on data enable).
> > > I've not idea how to fix it then.
> > 
> > Well, you can, of course, adjust parameters for your platform to be able
> > to run with this incorrect parameter definition...
> 
> This is just an ugly work-around. Depending on the settings you may even get 
> an overflow resulting in a not-working display at all.

Sure, I know, that this is a work-around. But I don't see options apart 
from

1. fix the driver and maybe a couple of platforms, that we have at hand 
and hope, that others will fix theirs or shout loud enough, when they 
discover, that their platforms are broken

2. fix the driver and all users and try to get as many of them as we can 
to test our fixes

3. leave the driver and work around the bug in all new platforms

Choose your poison;)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

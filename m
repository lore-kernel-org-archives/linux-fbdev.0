From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 16 Dec 2011 10:17:47 +0000
Subject: Re: [PATCH 34/57] fbdev: sh_mobile_lcdc: Store the format in struct sh_mobile_lcdc_chan
Message-Id: <201112161117.47924.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-35-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-35-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Thursday 15 December 2011 23:29:29 Guennadi Liakhovetski wrote:
> On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > Store the active format in the channel structure, and use it instead of
> > parsing info->var all over the place when the format is needed.
> 
> Right, this is what I was wondering about, while looking at the previous
> patch:-)

So I'll consider your comment to patch 33/57 to be addressed :-)

> But:
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/video/sh_mobile_lcdcfb.c |   21 ++++++++++-----------
> >  drivers/video/sh_mobile_lcdcfb.h |    4 +++-
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > b/drivers/video/sh_mobile_lcdcfb.c index c6b6b9d..9829e01 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> 
> [snip]
> 
> > @@ -1350,6 +1345,8 @@ static int sh_mobile_set_par(struct fb_info *info)
> > 
> >  		info->fix.line_length = info->var.xres
> >  		
> >  				      * info->var.bits_per_pixel / 8;
> > 
> > +	ch->format > > sh_mobile_format_info(sh_mobile_format_fourcc(&info->var));
> 
> Cannot this be NULL? As far as I could trace it back, I'm not sure with
> hotplug bits_per_pixel would be initialised correctly along the lines of
> sh_mobile_fb_reconfig().

You're right, sh_mobile_fb_reconfig() doesn't set the bits_per_pixel (and 
other format-related) field. I'll fix this by initializing those fields from 
the current var in sh_mobile_fb_reconfig() in patch 30/57, as that's the one 
that introduces the problem.

-- 
Regards,

Laurent Pinchart

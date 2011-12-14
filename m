From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 14 Dec 2011 12:30:54 +0000
Subject: Re: [PATCH 02/57] fbdev: sh_mobile_lcdc: Mark init-only symbols with __devinit(const)
Message-Id: <201112141330.54493.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-3-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-3-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Wednesday 14 December 2011 12:07:26 Guennadi Liakhovetski wrote:
> On Wed, 14 Dec 2011, Laurent Pinchart wrote:
> > On Tuesday 13 December 2011 23:23:32 Guennadi Liakhovetski wrote:
> > > On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > > > default_720p and sh_mobile_lcdc_check_interface are used at device
> > > > initialization time only. Mark them as __devinitconst and __devinit
> > > > respectively.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > 
> > > >  drivers/video/sh_mobile_lcdcfb.c |    5 +++--
> > > >  1 files changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > > > b/drivers/video/sh_mobile_lcdcfb.c index 8b18360..a6bf4fb 100644
> > > > --- a/drivers/video/sh_mobile_lcdcfb.c
> > > > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > > > @@ -1459,7 +1459,7 @@ static int sh_mobile_lcdc_notify(struct
> > > > notifier_block *nb,
> > > > 
> > > >   * Probe/remove and driver init/exit
> > > >   */
> > > > 
> > > > -static const struct fb_videomode default_720p = {
> > > > +static const struct fb_videomode default_720p __devinitconst = {
> > > > 
> > > >  	.name = "HDMI 720p",
> > > >  	.xres = 1280,
> > > >  	.yres = 720,
> > > > 
> > > > @@ -1528,7 +1528,8 @@ static int sh_mobile_lcdc_remove(struct
> > > > platform_device *pdev)
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > > 
> > > > -static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan
> > > > *ch) +static int __devinit
> > > > +sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
> > > 
> > > Personally, I don't like this type of line splitting very much, I
> > > prefer the grep output to show the function type and all attributes,
> > > but this, certainly, would not be the reason to change this specific
> > > hunk:-) But this might be: the whole file so far has all function
> > > definitions at least up to and including the first parameter on one
> > > line, so, I find, this change would introduce an inconsistency in the
> > > file style. The line would __only__ be 83 characters long if you put
> > > it all on one line. I think, it would look better then:-)
> > 
> > It's a matter of limits, as usual... I find 80 to be a nice limit,
> > although in some cases I'm fine with exceeding it (one example is a long
> > list of #defines with a small comment describing each macro, as in the
> > list of FOURCCs in linux/videodev2.h for instance). For code I try to
> > respect the 80 characters limit. Another reason is that it produces
> > checkpatch.pl warnings, which force me to manually look at all the
> > warnings to check which ones are acceptable.
> > 
> > Regarding consistency, other patches in this series use the same style,
> > so that function won't feel alone anymore ;-)
> > 
> > I can change this (and other instances of the same coding style) if you
> > insist. BTW, a possible improvement would be to shorten the
> > sh_mobile_lcdc_ prefix. I find it too long, and I was thinking about
> > reducing it to shm_lcdc_ (although shm reffers to shared memory, so that
> > might not be the best idea).
> 
> How about sh_lcdc?

Sounds good to me. Does anyone have an objection ?

-- 
Regards,

Laurent Pinchart

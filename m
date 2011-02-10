From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 10 Feb 2011 11:00:09 +0000
Subject: Re: [PATCH] mx3fb: Fix parameter to sdc_init_panel
Message-Id: <Pine.LNX.4.64.1102101158510.17898@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297332330-21964-1-git-send-email-alexander.stein@systec-electronic.com>
	<Pine.LNX.4.64.1102101136320.15087@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102101136320.15087@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Guennadi Liakhovetski wrote:

> On Thu, 10 Feb 2011, Alexander Stein wrote:
> 
> > h_end_width and v_end_width should only contain the front porches.
> > Otherwise, SCREEN_WIDTH (pixel clocks between HSYNC) in SDC_HOR_CONF
> > and SCREEN_HEIGHT (rows between VSYNC) in SDC_VER_CONF get false values.
> 
> Hm, no, this corrupts image on my pcm990 test-board. What makes you think 
> this patch is needed? How do you see, that current values are "false?"
> 
> Thanks
> Guennadi
> 
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> >  drivers/video/mx3fb.c |    7 +++----
> >  1 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> > index ef71e56..9040833 100644
> > --- a/drivers/video/mx3fb.c
> > +++ b/drivers/video/mx3fb.c
> > @@ -881,12 +881,11 @@ static int __set_par(struct fb_info *fbi, bool lock)

Also just occurred to me - your offset of 881 lines is 100 lines below my 
offset for the same code - against what tree is this patch, or do you have 
some local changes there? Can it be, that that's the reason for your 
problem?

Thanks
Guennadi

> >  				   IPU_PIX_FMT_BGR666 : IPU_PIX_FMT_RGB666,
> >  				   fbi->var.left_margin,
> >  				   fbi->var.hsync_len,
> > -				   fbi->var.right_margin +
> > -				   fbi->var.hsync_len,
> > +				   fbi->var.right_margin,
> >  				   fbi->var.upper_margin,
> >  				   fbi->var.vsync_len,
> > -				   fbi->var.lower_margin +
> > -				   fbi->var.vsync_len, sig_cfg) != 0) {
> > +				   fbi->var.lower_margin,
> > +				   sig_cfg) != 0) {
> >  			dev_err(fbi->device,
> >  				"mx3fb: Error initializing panel.\n");
> >  			return -EINVAL;
> > -- 
> > 1.7.3.4
> > 
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

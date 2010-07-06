From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 16:16:02 +0000
Subject: Re: [PATCH v3 01/12] s3c-fb: Fix various null references on framebuffer
Message-Id: <alpine.LFD.2.00.1007061714570.3285@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-2-git-send-email-p.osciak@samsung.com>
	<4C2DB6A2.2040005@simtec.co.uk>
In-Reply-To: <4C2DB6A2.2040005@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


> On 28/06/10 09:08, Pawel Osciak wrote:
> > The following problems were found in the above situation:
> > 
> > sfb->windows[win] was being assigned at the end of s3c_fb_probe_win only.
> > This resulted in passing a NULL to s3c_fb_release_win if probe_win returned
> > early and a memory leak.
> > 
> > dma_free_writecombine does not allow its third argument to be NULL.
> > 
> > fb_dealloc_cmap does not verify whether its argument is not NULL.
> > 
> > Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/video/s3c-fb.c |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> > index b00c064..d998324 100644
> > --- a/drivers/video/s3c-fb.c
> > +++ b/drivers/video/s3c-fb.c
> > @@ -804,7 +804,8 @@ static void s3c_fb_free_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
> >  {
> >  	struct fb_info *fbi = win->fbinfo;
> >  
> > -	dma_free_writecombine(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
> > +	if (fbi->screen_base)
> > +		dma_free_writecombine(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
> >  			      fbi->screen_base, fbi->fix.smem_start);
> >  }
> >  
> > @@ -819,7 +820,8 @@ static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
> >  {
> >  	if (win->fbinfo) {
> >  		unregister_framebuffer(win->fbinfo);
> > -		fb_dealloc_cmap(&win->fbinfo->cmap);
> > +		if (&win->fbinfo->cmap)
> > +			fb_dealloc_cmap(&win->fbinfo->cmap);
> 
> did you really mean &win->fbinfo->cmap? surely that will end up
> always evaluating to true?

Ouch. If you fail to allocate a color map at boot time no fbdev apps will 
work. Including fbcon.
 
> >  		s3c_fb_free_memory(sfb, win);
> >  		framebuffer_release(win->fbinfo);
> >  	}
> > @@ -865,6 +867,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
> >  	WARN_ON(windata->win_mode.yres = 0);
> >  
> >  	win = fbinfo->par;
> > +	*res = win;
> >  	var = &fbinfo->var;
> >  	win->variant = *variant;
> >  	win->fbinfo = fbinfo;
> > @@ -939,7 +942,6 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
> >  		return ret;
> >  	}
> >  
> > -	*res = win;
> >  	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
> >  
> >  	return 0;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

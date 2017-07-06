From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 06 Jul 2017 10:04:28 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: use after free in imxfb_remove()
Message-Id: <1955130.RvGiQGmOcs@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170630080242.emnw7l53f52pvzeo@mwanda>
In-Reply-To: <20170630080242.emnw7l53f52pvzeo@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, July 05, 2017 03:02:47 PM Dan Carpenter wrote:
> On Tue, Jul 04, 2017 at 05:44:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Friday, June 30, 2017 11:02:42 AM Dan Carpenter wrote:
> > > We free "info" then dereference it on the next line.  I've moved the
> > > call to framebuffer_release() down a line to avoid this problem.
> > > 
> > > Fixes: b7d2d37276c1 ("video: imxfb: Remove unused fields from platform data structure")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > > index c166e0725be5..1d0c3592b290 100644
> > > --- a/drivers/video/fbdev/imxfb.c
> > > +++ b/drivers/video/fbdev/imxfb.c
> > > @@ -1080,10 +1080,9 @@ static int imxfb_remove(struct platform_device *pdev)
> > >  
> > >  	fb_dealloc_cmap(&info->cmap);
> > >  	kfree(info->pseudo_palette);
> > > -	framebuffer_release(info);
> > > -
> > >  	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
> > >  		    fbi->map_dma);
> > > +	framebuffer_release(info);
> > >  
> > >  	iounmap(fbi->regs);
> > 
> > Good catch.
> > 
> > While you are at it, please:
> > 
> > - move framebuffer_release() after iounmap() (memory occupied by
> >   fbi will also be freed by framebuffer_release() call, please see
> >   framebuffer_alloc() for details)
> > 
> 
> I'm still recovering from an illness so I might not be thinking
> straight.  I don't see a bug here.  But I agree that it should mirror

Please take a look at the imxfb_probe():

...
	struct imxfb_info *fbi;
...
	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
	if (!info)
		return -ENOMEM;

	fbi = info->par;
...

and framebuffer_alloc():

struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
...
	int fb_info_size = sizeof(struct fb_info);
...
	p = kzalloc(fb_info_size + size, GFP_KERNEL);

	if (!p)
		return NULL;

	info = (struct fb_info *) p;

	if (size)
		info->par = p + fb_info_size;
...

> the probe function so I'll re-write the patch.

Great!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


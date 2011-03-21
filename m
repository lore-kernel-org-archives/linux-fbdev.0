From: Dan Carpenter <error27@gmail.com>
Date: Mon, 21 Mar 2011 04:39:25 +0000
Subject: Re: [patch] fbdev: sh_mobile_lcdc: checking NULL instead of
Message-Id: <20110321043925.GO2008@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110319043647.GZ2008@bicker>
In-Reply-To: <20110319043647.GZ2008@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 21, 2011 at 09:47:50AM +0530, Janorkar, Mayuresh wrote:
> > backlight_device_register() returns an ERR_PTR.  It doesn't return NULL.
> 
> The patch is not applying on the master branch of fbdev tree.
> I could find another branch: 	fbdev/shmobile on the tree.
> It is a good idea to mention this in the description of the patch.
> 

Sorry, I'm working against linux-next so I wasn't aware.

> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > 
> > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > b/drivers/video/sh_mobile_lcdcfb.c
> > index bf2629f..a53abe1 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > @@ -1088,7 +1088,7 @@ static struct backlight_device
> > *sh_mobile_lcdc_bl_probe(struct device *parent,
> > 
> >  	bl = backlight_device_register(ch->cfg.bl_info.name, parent, ch,
> >  				       &sh_mobile_lcdc_bl_ops, NULL);
> > -	if (!bl) {
> > +	if (IS_ERR(bl)) {
> >  		dev_err(parent, "unable to register backlight device\n");
> 
> 
> How about printing the error number here?
> 

Ok.  That's a good idea.

> >  		return NULL;
> 
> Code is not checking for return value where this function is called.
> 
> A code snippet where this function is called:
> /* probe the backlight is there is one defined */
>                  if (ch->cfg.bl_info.max_brightness)
>                        ch->bl = sh_mobile_lcdc_bl_probe(&pdev->dev, ch);
> 
> If the return value is not checked then whats the use of return value?
> 

It is checked actually.  Look at the places which would dereference
->bl.

> >  	}
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

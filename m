From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 21 Sep 2012 15:45:43 +0000
Subject: RE: [PATCH] da8xx-fb: add pm_runtime support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9BFFAC@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <79CD15C6BA57404B839C016229A409A83EABE8E3@DBDE01.ent.ti.com>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EABE8E3@DBDE01.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Vaibhav,

On Fri, Sep 21, 2012 at 21:03:15, Hiremath, Vaibhav wrote:
> On Fri, Sep 21, 2012 at 20:54:48, Manjunathappa, Prakash wrote:
> > Add pm_runtime support to the da8xx-fb frame buffer driver.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > ---
> > Applies on top of patch "da8xx-fb: enable LCDC if FB is unblanked" under review.
> > 
> >  drivers/video/da8xx-fb.c |   24 +++++++++++++-----------
> >  1 files changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > index af2aa38..17c00b2 100644
> > --- a/drivers/video/da8xx-fb.c
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/wait.h>
> >  #include <linux/clk.h>
> > @@ -1037,8 +1038,8 @@ static int __devexit fb_remove(struct platform_device *dev)
> >  		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
> >  				  par->vram_phys);
> >  		free_irq(par->irq, par);
> > -		clk_disable(par->lcdc_clk);
> > -		clk_put(par->lcdc_clk);
> > +		pm_runtime_put_sync(&dev->dev);
> > +		pm_runtime_disable(&dev->dev);
> >  		framebuffer_release(info);
> >  		iounmap((void __iomem *)da8xx_fb_reg_base);
> >  		release_mem_region(lcdc_regs->start, resource_size(lcdc_regs));
> > @@ -1272,9 +1273,9 @@ static int __devinit fb_probe(struct platform_device *device)
> >  		ret = -ENODEV;
> >  		goto err_ioremap;
> >  	}
> > -	ret = clk_enable(fb_clk);
> > -	if (ret)
> > -		goto err_clk_put;
> > +
> > +	pm_runtime_enable(&device->dev);
> > +	pm_runtime_get_sync(&device->dev);
> >  
> >  	/* Determine LCD IP Version */
> >  	switch (lcdc_read(LCD_PID_REG)) {
> > @@ -1302,7 +1303,7 @@ static int __devinit fb_probe(struct platform_device *device)
> >  	if (i = ARRAY_SIZE(known_lcd_panels)) {
> >  		dev_err(&device->dev, "GLCD: No valid panel found\n");
> >  		ret = -ENODEV;
> > -		goto err_clk_disable;
> > +		goto err_pm_runtime_disable;
> >  	} else
> >  		dev_info(&device->dev, "GLCD: Found %s panel\n",
> >  					fb_pdata->type);
> > @@ -1314,7 +1315,7 @@ static int __devinit fb_probe(struct platform_device *device)
> >  	if (!da8xx_fb_info) {
> >  		dev_dbg(&device->dev, "Memory allocation failed for fb_info\n");
> >  		ret = -ENOMEM;
> > -		goto err_clk_disable;
> > +		goto err_pm_runtime_disable;
> >  	}
> >  
> >  	par = da8xx_fb_info->par;
> > @@ -1476,8 +1477,9 @@ err_release_fb_mem:
> >  err_release_fb:
> >  	framebuffer_release(da8xx_fb_info);
> >  
> > -err_clk_disable:
> > -	clk_disable(fb_clk);
> > +err_pm_runtime_disable:
> > +	pm_runtime_put_sync(&device->dev);
> > +	pm_runtime_disable(&device->dev);
> >  
> >  err_clk_put:
> >  	clk_put(fb_clk);
> > @@ -1503,7 +1505,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
> >  
> >  	fb_set_suspend(info, 1);
> >  	lcd_disable_raster(true);
> > -	clk_disable(par->lcdc_clk);
> > +	pm_runtime_put(&dev->dev);
> 
> Isn't here you should use pm_runtime_put_sync()??
> 

Yes, I will correct it send next version.

Thanks,
Prakash

> Thanks,
> Vaibhv
> 
> >  	console_unlock();
> >  
> >  	return 0;
> > @@ -1514,7 +1516,7 @@ static int fb_resume(struct platform_device *dev)
> >  	struct da8xx_fb_par *par = info->par;
> >  
> >  	console_lock();
> > -	clk_enable(par->lcdc_clk);
> > +	pm_runtime_get_sync(&dev->dev);
> >  	if (par->blank = FB_BLANK_UNBLANK) {
> >  		lcd_enable_raster();
> >  
> > -- 
> > 1.7.0.4
> > 
> > _______________________________________________
> > Davinci-linux-open-source mailing list
> > Davinci-linux-open-source@linux.davincidsp.com
> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> > 
> 
> 


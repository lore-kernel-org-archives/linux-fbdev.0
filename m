From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 19 Dec 2011 02:19:37 +0000
Subject: Re: Re: [PATCH V2] video: s3c-fb: modify runtime pm functions
Message-Id: <003d01ccbdf4$a859d070$f90d7150$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002801ccb2f7$926c0240$b74406c0$%han@samsung.com>
In-Reply-To: <002801ccb2f7$926c0240$b74406c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Florian Tobias Schandinat wrote:
> -----Original Message-----
> Subject: Re: [PATCH V2] video: s3c-fb: modify runtime pm functions
> 
> Hi Jingoo,
> 
> On 12/05/2011 02:42 AM, Jingoo Han wrote:
> > Runtime suspend and runtime resume are modified in order to
> > reduce the complexity and improve the usability of runtime pm.
> > After probe function, s3c-fb driver is not suspended until
> > suspend or remove is called.
> >
> > The scheme is changed as follows:
> >  runtime_get is only called in probe and resume.
> >  runtime_put is only called in remove and suspend.
> >  open/close cannot call the runtime_get/put.
> >
> > Also, runtime_susepnd/resume are just called by runtime pm,
> > not doing suspend/resume routine any longer. This is because
> > open/close cannot call the runtime_get/put; the suspend/resume
> > routine in runtime_suspend/resume were previously used when
> > open and close were called.
> >
> > The name of s3c-fb dev_pm_ops is changed from s3cfb_pm_ops to
> > s3c_fb_pm_ops in order to use more consistent naming.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> the patch itself looks okay to me, but I'm wondering what changes will be
> visible to the user, if any?
> Does the behavior change for example, when no one has called open?
Previously, in order to display framebuffer to LCD panel, user should call
open after booting, because runtime_pm_put is called after prove function.

However, now, after booting, framebuffer can be displayed to LCD panel
without calling open.

Best regards,
Jingoo Han
> 
> 
> Best regards,
> 
> Florian Tobias Schandinat
> 
> > ---
> > v2: fix unaligned lines
> >
> >  drivers/video/s3c-fb.c |   51 ++++++++++++++++++-----------------------------
> >  1 files changed, 20 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> > index e84677e..91e629a 100644
> > --- a/drivers/video/s3c-fb.c
> > +++ b/drivers/video/s3c-fb.c
> > @@ -1028,30 +1028,8 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >  	return ret;
> >  }
> >
> > -static int s3c_fb_open(struct fb_info *info, int user)
> > -{
> > -	struct s3c_fb_win *win = info->par;
> > -	struct s3c_fb *sfb = win->parent;
> > -
> > -	pm_runtime_get_sync(sfb->dev);
> > -
> > -	return 0;
> > -}
> > -
> > -static int s3c_fb_release(struct fb_info *info, int user)
> > -{
> > -	struct s3c_fb_win *win = info->par;
> > -	struct s3c_fb *sfb = win->parent;
> > -
> > -	pm_runtime_put_sync(sfb->dev);
> > -
> > -	return 0;
> > -}
> > -
> >  static struct fb_ops s3c_fb_ops = {
> >  	.owner		= THIS_MODULE,
> > -	.fb_open	= s3c_fb_open,
> > -	.fb_release	= s3c_fb_release,
> >  	.fb_check_var	= s3c_fb_check_var,
> >  	.fb_set_par	= s3c_fb_set_par,
> >  	.fb_blank	= s3c_fb_blank,
> > @@ -1458,7 +1436,6 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
> >  	}
> >
> >  	platform_set_drvdata(pdev, sfb);
> > -	pm_runtime_put_sync(sfb->dev);
> >
> >  	return 0;
> >
> > @@ -1498,8 +1475,6 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
> >  	struct s3c_fb *sfb = platform_get_drvdata(pdev);
> >  	int win;
> >
> > -	pm_runtime_get_sync(sfb->dev);
> > -
> >  	for (win = 0; win < S3C_FB_MAX_WIN; win++)
> >  		if (sfb->windows[win])
> >  			s3c_fb_release_win(sfb, sfb->windows[win]);
> > @@ -1525,7 +1500,7 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> >  static int s3c_fb_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > @@ -1546,6 +1521,8 @@ static int s3c_fb_suspend(struct device *dev)
> >  		clk_disable(sfb->lcd_clk);
> >
> >  	clk_disable(sfb->bus_clk);
> > +	pm_runtime_put_sync(sfb->dev);
> > +
> >  	return 0;
> >  }
> >
> > @@ -1557,6 +1534,7 @@ static int s3c_fb_resume(struct device *dev)
> >  	struct s3c_fb_win *win;
> >  	int win_no;
> >
> > +	pm_runtime_get_sync(sfb->dev);
> >  	clk_enable(sfb->bus_clk);
> >
> >  	if (!sfb->variant.has_clksel)
> > @@ -1590,11 +1568,19 @@ static int s3c_fb_resume(struct device *dev)
> >
> >  	return 0;
> >  }
> > -#else
> > -#define s3c_fb_suspend NULL
> > -#define s3c_fb_resume  NULL
> >  #endif
> >
> > +#ifdef CONFIG_PM_RUNTIME
> > +static int s3c_fb_runtime_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int s3c_fb_runtime_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >
> >  #define VALID_BPP124 (VALID_BPP(1) | VALID_BPP(2) | VALID_BPP(4))
> >  #define VALID_BPP1248 (VALID_BPP124 | VALID_BPP(8))
> > @@ -1917,7 +1903,10 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(platform, s3c_fb_driver_ids);
> >
> > -static UNIVERSAL_DEV_PM_OPS(s3cfb_pm_ops, s3c_fb_suspend, s3c_fb_resume, NULL);
> > +static const struct dev_pm_ops s3c_fb_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(s3c_fb_suspend, s3c_fb_resume)
> > +	SET_RUNTIME_PM_OPS(s3c_fb_runtime_suspend, s3c_fb_runtime_resume, NULL)
> > +};
> >
> >  static struct platform_driver s3c_fb_driver = {
> >  	.probe		= s3c_fb_probe,
> > @@ -1926,7 +1915,7 @@ static struct platform_driver s3c_fb_driver = {
> >  	.driver		= {
> >  		.name	= "s3c-fb",
> >  		.owner	= THIS_MODULE,
> > -		.pm	= &s3cfb_pm_ops,
> > +		.pm	= &s3c_fb_pm_ops,
> >  	},
> >  };
> >


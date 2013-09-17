From: Kristoffer Eriksson <kristoffer.ericson@gmail.com>
Date: Tue, 17 Sep 2013 14:19:54 +0000
Subject: Re: [PATCH 15/19] video: s1d13xxxfb: use dev_get_platdata()
Message-Id: <5238650A.2010203@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501ceb364$340fdf40$9c2f9dc0$%han@samsung.com>
In-Reply-To: <001501ceb364$340fdf40$9c2f9dc0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

Jingoo Han skrev 2013-09-17 07:10:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly. This is a cosmetic change
> to make the code simpler and enhance the readability.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/video/s1d13xxxfb.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
> index 05c2dc3..1399a46 100644
> --- a/drivers/video/s1d13xxxfb.c
> +++ b/drivers/video/s1d13xxxfb.c
> @@ -777,8 +777,8 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>   	printk(KERN_INFO "Epson S1D13XXX FB Driver\n");
>   
>   	/* enable platform-dependent hardware glue, if any */
> -	if (pdev->dev.platform_data)
> -		pdata = pdev->dev.platform_data;
> +	if (dev_get_platdata(&pdev->dev))
> +		pdata = dev_get_platdata(&pdev->dev);
>   
>   	if (pdata && pdata->platform_init_video)
>   		pdata->platform_init_video();
> @@ -923,8 +923,8 @@ static int s1d13xxxfb_suspend(struct platform_device *dev, pm_message_t state)
>   	lcd_enable(s1dfb, 0);
>   	crt_enable(s1dfb, 0);
>   
> -	if (dev->dev.platform_data)
> -		pdata = dev->dev.platform_data;
> +	if (dev_get_platdata(&dev->dev))
> +		pdata = dev_get_platdata(&dev->dev);
>   
>   #if 0
>   	if (!s1dfb->disp_save)
> @@ -973,8 +973,8 @@ static int s1d13xxxfb_resume(struct platform_device *dev)
>   	while ((s1d13xxxfb_readreg(s1dfb, S1DREG_PS_STATUS) & 0x01))
>   		udelay(10);
>   
> -	if (dev->dev.platform_data)
> -		pdata = dev->dev.platform_data;
> +	if (dev_get_platdata(&dev->dev))
> +		pdata = dev_get_platdata(&dev->dev);
>   
>   	if (s1dfb->regs_save) {
>   		/* will write RO regs, *should* get away with it :) */


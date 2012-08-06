From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 Aug 2012 01:20:50 +0000
Subject: Re: [PATCH 5/6] drivers/video/backlight/da9052_bl.c: drop devm_kfree of devm_kzalloc'd data
Message-Id: <000b01cd7371$b7331790$259946b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344099049-15212-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1344099049-15212-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Julia Lawall' <Julia.Lawall@lip6.fr>, 'Richard Purdie' <rpurdie@rpsys.net>
Cc: kernel-janitors@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Sunday, August 05, 2012 1:51 AM Julia Lawall wrote:
> 
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> devm_kfree should not have to be explicitly used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,d;
> @@
> 
> x = devm_kzalloc(...)
> ...
> ?-devm_kfree(d,x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>


Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good.

Best regard,
Jingoo Han


> 
> ---
>  drivers/video/backlight/da9052_bl.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
> index b628d68..7c8626a 100644
> --- a/drivers/video/backlight/da9052_bl.c
> +++ b/drivers/video/backlight/da9052_bl.c
> @@ -129,7 +129,6 @@ static int da9052_backlight_probe(struct platform_device *pdev)
>  				       &da9052_backlight_ops, &props);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "Failed to register backlight\n");
> -		devm_kfree(&pdev->dev, wleds);
>  		return PTR_ERR(bl);
>  	}
> 
> @@ -149,7 +148,6 @@ static int da9052_backlight_remove(struct platform_device *pdev)
>  	wleds->state = DA9052_WLEDS_OFF;
>  	da9052_adjust_wled_brightness(wleds);
>  	backlight_device_unregister(bl);
> -	devm_kfree(&pdev->dev, wleds);
> 
>  	return 0;
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


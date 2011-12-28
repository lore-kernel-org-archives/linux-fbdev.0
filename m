From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 28 Dec 2011 23:54:35 +0000
Subject: RE: [PATCH 3/6] video: s3c-fb: Disable runtime PM in error paths from
Message-Id: <000801ccc5bc$0dcf8890$296e99b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111227141550.GA3331@opensource.wolfsonmicro.com>
 <1324995372-3410-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1324995372-3410-3-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1324995372-3410-3-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Tuesday, December 27, 2011 11:16 PM
> To: Jingoo Han; Florian Tobias Schandinat
> Cc: linux-fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; Mark Brown
> Subject: [PATCH 3/6] video: s3c-fb: Disable runtime PM in error paths from probe
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

		Acked-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  drivers/video/s3c-fb.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index be4c218..2e0eef0 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1464,7 +1464,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
>  			dev_err(dev, "failed to create window %d\n", win);
>  			for (; win >= 0; win--)
>  				s3c_fb_release_win(sfb, sfb->windows[win]);
> -			goto err_irq;
> +			goto err_pm_runtime;
>  		}
>  	}
> 
> @@ -1473,7 +1473,8 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
> 
>  	return 0;
> 
> -err_irq:
> +err_pm_runtime:
> +	pm_runtime_put_sync(sfb->dev);
>  	free_irq(sfb->irq_no, sfb);
> 
>  err_ioremap:
> @@ -1483,6 +1484,8 @@ err_req_region:
>  	release_mem_region(sfb->regs_res->start, resource_size(sfb->regs_res));
> 
>  err_lcd_clk:
> +	pm_runtime_disable(sfb->dev);
> +
>  	if (!sfb->variant.has_clksel) {
>  		clk_disable(sfb->lcd_clk);
>  		clk_put(sfb->lcd_clk);
> --
> 1.7.7.3


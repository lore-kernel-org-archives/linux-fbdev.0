From: Anatolij Gustschin <agust@denx.de>
Date: Sat, 21 Sep 2013 08:37:11 +0000
Subject: Re: [PATCH 04/15] video: mb862xx: Remove redundant dev_set_drvdata
Message-Id: <20130921103711.24e8f147@crub>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379658744-17113-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379658744-17113-5-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 20 Sep 2013 12:02:13 +0530
Sachin Kamat <sachin.kamat@linaro.org> wrote:

> Driver core sets driver data to NULL upon failure or remove.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Anatolij Gustschin <agust@denx.de>

Acked-by: Anatolij Gustschin <agust@denx.de>

> ---
>  drivers/video/mb862xx/mb862xxfbdrv.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
> index 98d2f8c..0cd4c33 100644
> --- a/drivers/video/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/mb862xx/mb862xxfbdrv.c
> @@ -781,7 +781,6 @@ rel_reg:
>  irqdisp:
>  	irq_dispose_mapping(par->irq);
>  fbrel:
> -	dev_set_drvdata(dev, NULL);
>  	framebuffer_release(info);
>  	return ret;
>  }
> @@ -814,7 +813,6 @@ static int of_platform_mb862xx_remove(struct platform_device *ofdev)
>  	iounmap(par->mmio_base);
>  	iounmap(par->fb_base);
>  
> -	dev_set_drvdata(&ofdev->dev, NULL);
>  	release_mem_region(par->res->start, res_size);
>  	framebuffer_release(fbi);
>  	return 0;



From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 07 Apr 2020 18:18:05 +0000
Subject: Re: [PATCH] video: fbdev: don't print error message on platform_get_irq() failure
Message-Id: <20200407181805.GC6356@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: alexandre.belloni@bootlin.com, b.zolnierkie@samsung.com, nicolas.ferre@microchip.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tang Bin

On Mon, Apr 06, 2020 at 01:34:50PM +0800, Tang Bin wrote:
> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index d567f5d56..1e2521925 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  
>  	sinfo->irq_base = platform_get_irq(pdev, 0);
>  	if (sinfo->irq_base < 0) {
> -		dev_err(dev, "unable to get irq\n");
>  		ret = sinfo->irq_base;
>  		goto stop_clk;
>  	}

Thanks, applied to drm-misc-next. The fix will appear in kernel 5.8

	Sam

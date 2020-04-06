From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Mon, 06 Apr 2020 14:13:53 +0000
Subject: Re: [PATCH] video: fbdev: don't print error message on platform_get_irq() failure
Message-Id: <d6c8f07c-a57e-45ef-429a-d627ba7d7ce0@microchip.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tang Bin <tangbin@cmss.chinamobile.com>, b.zolnierkie@samsung.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/04/2020 at 07:34, Tang Bin wrote:
> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>   drivers/video/fbdev/atmel_lcdfb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index d567f5d56..1e2521925 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
> 
>          sinfo->irq_base = platform_get_irq(pdev, 0);
>          if (sinfo->irq_base < 0) {
> -               dev_err(dev, "unable to get irq\n");
>                  ret = sinfo->irq_base;
>                  goto stop_clk;
>          }
> --
> 2.20.1.windows.1
> 
> 
> 


-- 
Nicolas Ferre

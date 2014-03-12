From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 12 Mar 2014 09:02:22 +0000
Subject: Re: [PATCH] video: atmel_lcdfb: ensure the hardware is initialized with the correct mode
Message-Id: <5320229E.9020502@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On 07/03/2014 17:20, Antoine Ténart :
> If no driver takeover the atmel_lcdfb, the lcd won't be in a working state
> since atmel_lcdfb_set_par() will never be called. Enabling a driver which does,
> like fbcon, will call the function and put atmel_lcdfb in a working state.
> 
> Fixes: b985172b328a (video: atmel_lcdfb: add device tree suport)
> 
> Signed-off-by: Antoine Ténart <antoine.tenart@free-electrons.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks for having fixing this.

Bye,

> ---
>  drivers/video/atmel_lcdfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index cd96162..b74e5f5d 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1298,6 +1298,12 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  		goto unregister_irqs;
>  	}
>  
> +	ret = atmel_lcdfb_set_par(info);
> +	if (ret < 0) {
> +		dev_err(dev, "set par failed: %d\n", ret);
> +		goto unregister_irqs;
> +	}
> +
>  	dev_set_drvdata(dev, info);
>  
>  	/*
> 


-- 
Nicolas Ferre

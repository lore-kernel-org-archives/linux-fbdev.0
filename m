From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: unsigned irq_base cannot be negative
Date: Tue, 21 Oct 2008 10:46:01 +0200
Message-ID: <48FD96C9.6060204@atmel.com>
References: <48FD4F7E.6010708@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753631AbYJUIqV@vger.kernel.org>
In-Reply-To: <48FD4F7E.6010708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: roel kluin <roel.kluin@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>

Hi,

roel kluin :
> unsigned irq_base cannot be negative

Indeed. Thanks for taking this point !

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index f8d0a57..f93f57a 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -857,12 +857,12 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  		goto stop_clk;
>  	}
>  
> -	sinfo->irq_base = platform_get_irq(pdev, 0);
> -	if (sinfo->irq_base < 0) {
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
>  		dev_err(dev, "unable to get irq\n");
> -		ret = sinfo->irq_base;
>  		goto stop_clk;
>  	}
> +	sinfo->irq_base = ret;

I prefer changing the definition of irq_base to plain int.

So the patch becomes obvious:
-       unsigned long           irq_base;
+       int                     irq_base;

What do you think of this ?

I repost a patch addressing this issue.

Regards,
-- 
Nicolas Ferre

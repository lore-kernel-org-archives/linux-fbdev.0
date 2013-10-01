From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 01 Oct 2013 01:08:31 +0000
Subject: Re: [PATCH -next] backlight: lm3630: add missing destroy_workqueue() on error in lm3630a_intr_config
Message-Id: <000201cebe42$be5bcf90$3b136eb0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, September 27, 2013 6:51 PM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing destroy_workqueue() before return from
> lm3630a_intr_config() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

+cc Andrew Morton, Daniel Jeong

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/lm3630a_bl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index c63f918..0e5d8d3 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -154,6 +154,7 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
>  	    (pchip->irq, NULL, lm3630a_isr_func,
>  	     IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "lm3630a_irq", pchip)) {
>  		dev_err(pchip->dev, "request threaded irq fail\n");
> +		destroy_workqueue(pchip->irqthread);
>  		return -ENOMEM;
>  	}
>  	return rval;
> 
> --


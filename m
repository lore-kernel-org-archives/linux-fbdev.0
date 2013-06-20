From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 20 Jun 2013 07:49:26 +0000
Subject: Re: [PATCH 8/8] at91/avr32/atmel_lcdfb: prepare clk before calling enable
Message-Id: <51C2B406.10604@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
 <1371640930-9771-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1371640930-9771-1-git-send-email-b.brezillon@overkiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 19/06/2013 13:22, Boris BREZILLON :
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   drivers/video/atmel_lcdfb.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 540909d..8525457 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -893,14 +893,14 @@ static int __init atmel_lcdfb_init_fbinfo(struct atmel_lcdfb_info *sinfo)
>
>   static void atmel_lcdfb_start_clock(struct atmel_lcdfb_info *sinfo)
>   {
> -	clk_enable(sinfo->bus_clk);
> -	clk_enable(sinfo->lcdc_clk);
> +	clk_prepare_enable(sinfo->bus_clk);
> +	clk_prepare_enable(sinfo->lcdc_clk);
>   }
>
>   static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
>   {
> -	clk_disable(sinfo->bus_clk);
> -	clk_disable(sinfo->lcdc_clk);
> +	clk_disable_unprepare(sinfo->bus_clk);
> +	clk_disable_unprepare(sinfo->lcdc_clk);
>   }
>
>
>


-- 
Nicolas Ferre

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 25 Jun 2013 08:16:02 +0000
Subject: Re: [PATCH v2 4/4] at91/avr32/atmel_lcdfb: prepare clk before calling enable
Message-Id: <51C951C2.8090901@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372147702-4074-1-git-send-email-b.brezillon@overkiz.com>
 <1372148053-4477-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1372148053-4477-1-git-send-email-b.brezillon@overkiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 25/06/2013 10:14, Boris BREZILLON :
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Jean-Christophe, can you take this one?

Thanks, best regards,

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

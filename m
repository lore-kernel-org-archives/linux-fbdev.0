From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 19 Oct 2013 10:52:02 +0000
Subject: Re: [PATCH] fbdev: fix error return code in metronomefb_probe()
Message-Id: <20131019105202.GK18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd-FgU-512ivq_eRPqefqb8-7qGY8aoOATiFNZYn-P_4rg@mail.gmail.com>
In-Reply-To: <CAPgLHd-FgU-512ivq_eRPqefqb8-7qGY8aoOATiFNZYn-P_4rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 14:25 Sat 12 Oct     , Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Tomi can you take it as a fix

Best Regards,
J.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/metronomefb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index f30150d..0b36160 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -690,7 +690,8 @@ static int metronomefb_probe(struct platform_device *dev)
>  		goto err_csum_table;
>  	}
>  
> -	if (board->setup_irq(info))
> +	retval = board->setup_irq(info);
> +	if (retval)
>  		goto err_csum_table;
>  
>  	retval = metronome_init_regs(par);
> 

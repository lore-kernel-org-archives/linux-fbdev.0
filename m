From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 08 Feb 2017 14:52:40 +0000
Subject: Re: [PATCH -next v2] video: fbdev: sh_mobile_lcdcfb: fix error return code in sh_mobile_lcdc_probe()
Message-Id: <3287163.ui0XjugUXI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170206150826.28634-1-weiyj.lk@gmail.com>
In-Reply-To: <20170206150826.28634-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

On Monday, February 06, 2017 03:08:26 PM Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENOMEM from the ioremap_nocache() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch queued for 4.11, thanks.

> ---
> v1->v2: use -ENOMEM intead of -ENODEV
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 93469f9..ea8b6d5 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -2782,8 +2782,10 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
>  		priv->forced_fourcc = pdata->ch[0].fourcc;
>  
>  	priv->base = ioremap_nocache(res->start, resource_size(res));
> -	if (!priv->base)
> +	if (!priv->base) {
> +		error = -ENOMEM;
>  		goto err1;
> +	}
>  
>  	error = sh_mobile_lcdc_setup_clocks(priv, pdata->clock_source);
>  	if (error) {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


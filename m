From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Feb 2017 14:41:15 +0000
Subject: Re: [PATCH -next] video: fbdev: sh_mobile_lcdcfb: fix error return code in sh_mobile_lcdc_probe()
Message-Id: <CAMuHMdUhRFYEZO1nOiqokbRT8tdnYU740Ok9JCrEE=1R6j_w1g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170206142444.27505-1-weiyj.lk@gmail.com>
In-Reply-To: <20170206142444.27505-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 6, 2017 at 3:24 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix to return error code -ENODEV from the ioremap_nocache() error
> handling case instead of 0, as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

If you fix the minor nit below:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 93469f9..ea8b6d5 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -2782,8 +2782,10 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
>                 priv->forced_fourcc = pdata->ch[0].fourcc;
>
>         priv->base = ioremap_nocache(res->start, resource_size(res));
> -       if (!priv->base)
> +       if (!priv->base) {
> +               error = -ENODEV;

-ENOMEM is more appropriate for this kind of failure.

>                 goto err1;
> +       }
>
>         error = sh_mobile_lcdc_setup_clocks(priv, pdata->clock_source);
>         if (error) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

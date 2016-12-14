From: Yuasa Yoichi <yuasa@linux-mips.org>
Date: Wed, 14 Dec 2016 02:23:07 +0000
Subject: Re: [v1] video:fbdev:cobalt_lcdfb:- Handle return NULL error from devm_ioremap
Message-Id: <CACBHAezjGxyP1KVWuHf7oYSF_mTTnPFaDnphAXk7c0N3e3qqzA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481617252-8298-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1481617252-8298-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, ralf@linux-mips.org, paul.burton@imgtec.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arvind,

Thank you for fixing it.

Acked-by: Yoichi Yuasa <yuasa@linux-mips.org>

2016-12-13 17:20 GMT+09:00 Arvind Yadav <arvind.yadav.cs@gmail.com>:
> Here, If devm_ioremap will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/video/fbdev/cobalt_lcdfb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
> index 2d3b691..038ac69 100644
> --- a/drivers/video/fbdev/cobalt_lcdfb.c
> +++ b/drivers/video/fbdev/cobalt_lcdfb.c
> @@ -308,6 +308,11 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
>         info->screen_size = resource_size(res);
>         info->screen_base = devm_ioremap(&dev->dev, res->start,
>                                          info->screen_size);
> +       if (!info->screen_base) {
> +               framebuffer_release(info);
> +               return -ENOMEM;
> +       }
> +
>         info->fbops = &cobalt_lcd_fbops;
>         info->fix = cobalt_lcdfb_fix;
>         info->fix.smem_start = res->start;
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

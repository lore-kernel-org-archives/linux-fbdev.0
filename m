From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 13 Nov 2017 13:57:05 +0000
Subject: Re: [PATCH 2/3] backlight: max8925_bl: fix device-tree node lookup
Message-Id: <46845070-588c-145f-67aa-42e1011c2d8e@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171113102049.9342-1-johan@kernel.org>
 <20171113102049.9342-2-johan@kernel.org>
In-Reply-To: <20171113102049.9342-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <johan@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, dri-devel@lists.freedesktop.org, Qing Xu <qingx@marvell.com>



On 13/11/17 10:20, Johan Hovold wrote:
> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
> 
> To make things worse, the parent mfd node was also prematurely freed,
> while the child backlight node was leaked.
> 
> Fixes: 47ec340cb8e2 ("mfd: max8925: Support dt for backlight")
> Cc: stable <stable@vger.kernel.org>     # 3.9
> Cc: Qing Xu <qingx@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/max8925_bl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
> index 7b738d60ecc2..f3aa6088f1d9 100644
> --- a/drivers/video/backlight/max8925_bl.c
> +++ b/drivers/video/backlight/max8925_bl.c
> @@ -116,7 +116,7 @@ static void max8925_backlight_dt_init(struct platform_device *pdev)
>   	if (!pdata)
>   		return;
>   
> -	np = of_find_node_by_name(nproot, "backlight");
> +	np = of_get_child_by_name(nproot, "backlight");
>   	if (!np) {
>   		dev_err(&pdev->dev, "failed to find backlight node\n");
>   		return;
> @@ -125,6 +125,8 @@ static void max8925_backlight_dt_init(struct platform_device *pdev)
>   	if (!of_property_read_u32(np, "maxim,max8925-dual-string", &val))
>   		pdata->dual_string = val;
>   
> +	of_node_put(np);
> +
>   	pdev->dev.platform_data = pdata;
>   }
>   
> 

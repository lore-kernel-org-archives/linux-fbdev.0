From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 06 Dec 2018 14:02:21 +0000
Subject: Re: [PATCH] video/backlight: Use of_node_name_eq for node name comparisons
Message-Id: <20181206140221.rq4zp74olghzipxu@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181205195050.4759-28-robh@kernel.org>
In-Reply-To: <20181205195050.4759-28-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>

On Wed, Dec 05, 2018 at 01:50:44PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which this is.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

[this is FAO Lee J. rather than recommending you take it via you tree]

> ---
>  drivers/video/backlight/88pm860x_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
> index 6d8dc2c77520..51e0c4be08df 100644
> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -174,7 +174,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
>  		return -ENODEV;
>  	}
>  	for_each_child_of_node(nproot, np) {
> -		if (!of_node_cmp(np->name, name)) {
> +		if (of_node_name_eq(np, name)) {
>  			of_property_read_u32(np, "marvell,88pm860x-iset",
>  					     &iset);
>  			data->iset = PM8606_WLED_CURRENT(iset);
> -- 
> 2.19.1
> 

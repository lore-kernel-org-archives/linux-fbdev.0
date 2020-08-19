From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 19 Aug 2020 10:36:31 +0000
Subject: Re: [PATCH] video: backlight: sky81452-backlight: Fix refcount imbalance on error
Message-Id: <20200819103631.bptd34ij3fid4ych@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200819030456.7054-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200819030456.7054-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kjlu@umn.edu, Bryan Wu <cooloney@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

On Wed, Aug 19, 2020 at 11:04:56AM +0800, Dinghao Liu wrote:
> When of_property_read_u32_array() returns an error code, a
> pairing refcount decrement is needed to keep np's refcount
> balanced.
> 
> Fixes: f705806c9f355 ("backlight: Add support Skyworks SKY81452 backlight driver")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/sky81452-backlight.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 0ce181585008..8268ac43d54f 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  					num_entry);
>  		if (ret < 0) {
>  			dev_err(dev, "led-sources node is invalid.\n");
> +			of_node_put(np);
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> -- 
> 2.17.1
> 

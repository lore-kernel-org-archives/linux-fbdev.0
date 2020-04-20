From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 15:29:50 +0000
Subject: Re: [PATCH 2/5] backlight: led_bl: drop useless NULL initialization
Message-Id: <20200420152950.hbc54fzxta7lq5ug@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
 <20200417113312.24340-2-tomi.valkeinen@ti.com>
In-Reply-To: <20200417113312.24340-2-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Apr 17, 2020 at 02:33:09PM +0300, Tomi Valkeinen wrote:
> There's no need to set 'levels' to NULL.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/led_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index d4e1ce684366..c46ecdfe8b0a 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -140,7 +140,7 @@ static int led_bl_parse_levels(struct device *dev,
>  	if (num_levels > 1) {
>  		int i;
>  		unsigned int db;
> -		u32 *levels = NULL;
> +		u32 *levels;
>  
>  		levels = devm_kzalloc(dev, sizeof(u32) * num_levels,
>  				      GFP_KERNEL);
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

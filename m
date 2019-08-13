From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 13 Aug 2019 09:12:51 +0000
Subject: Re: [PATCH] backlight: ipaq_micro: Make structure micro_bl_props constant
Message-Id: <20190813091251.2nyxtivsvp47aahp@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813085855.8302-1-nishkadg.linux@gmail.com>
In-Reply-To: <20190813085855.8302-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, lee.jones@linaro.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

On Tue, Aug 13, 2019 at 02:28:55PM +0530, Nishka Dasgupta wrote:
> Static structure micro_bl_props, having type backlight_properties, is
> used only once, when it is passed as the last argument to function
> devm_backlight_device_register(). devm_backlight_device_register() is
> defined with its last parameter being declared constant. Hence make
> micro_bl_props itself constant as well.
> Issue found with Coccinelle.

Did you do any review to see if this pattern occurs in other backlight
drivers (it looks to me like the same pattern appears in
rave-sp-backlight.c... do the tools bring that one out as well).


Daniel.


> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/video/backlight/ipaq_micro_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
> index 1123f67c12b3..85b16cc82878 100644
> --- a/drivers/video/backlight/ipaq_micro_bl.c
> +++ b/drivers/video/backlight/ipaq_micro_bl.c
> @@ -44,7 +44,7 @@ static const struct backlight_ops micro_bl_ops = {
>  	.update_status  = micro_bl_update_status,
>  };
>  
> -static struct backlight_properties micro_bl_props = {
> +static const struct backlight_properties micro_bl_props = {
>  	.type = BACKLIGHT_RAW,
>  	.max_brightness = 255,
>  	.power = FB_BLANK_UNBLANK,
> -- 
> 2.19.1
> 

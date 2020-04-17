From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:07:40 +0000
Subject: Re: [PATCH v1 4/5] video: ssd1307fb: Convert to atomic PWM API
Message-Id: <2157cc9f-5e84-8ca5-fd67-70240eb238d4@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
 <CGME20200324170539eucas1p12a3a4f7cd0d8cbd86f40d70a65ab0df5@eucas1p1.samsung.com>
 <20200324170532.44384-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324170532.44384-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, xllacyx@gmail.com, dri-devel@lists.freedesktop.org


[ added dri-devel ML to Cc: ]

On 3/24/20 6:05 PM, Andy Shevchenko wrote:
> Use the atomic API wherever appropriate and get rid of pwm_apply_args()
> call (the reference period and polarity are now explicitly set when
> calling pwm_apply_state()).
> 
> We also make use of the pwm_set_relative_duty_cycle() helper to ease
> relative to absolute duty_cycle conversion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/ssd1307fb.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 7a6a44a0b7a6..6e543396002a 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -79,7 +79,6 @@ struct ssd1307fb_par {
>  	u32 prechargep1;
>  	u32 prechargep2;
>  	struct pwm_device *pwm;
> -	u32 pwm_period;
>  	struct gpio_desc *reset;
>  	struct regulator *vbat_reg;
>  	u32 vcomh;
> @@ -297,9 +296,9 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
>  
>  static int ssd1307fb_init(struct ssd1307fb_par *par)
>  {
> +	struct pwm_state pwmstate;
>  	int ret;
>  	u32 precharge, dclk, com_invdir, compins;
> -	struct pwm_args pargs;
>  
>  	if (par->device_info->need_pwm) {
>  		par->pwm = pwm_get(&par->client->dev, NULL);
> @@ -308,21 +307,15 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>  			return PTR_ERR(par->pwm);
>  		}
>  
> -		/*
> -		 * FIXME: pwm_apply_args() should be removed when switching to
> -		 * the atomic PWM API.
> -		 */
> -		pwm_apply_args(par->pwm);
> +		pwm_init_state(par->pwm, &pwmstate);
> +		pwm_set_relative_duty_cycle(&pwmstate, 50, 100);
> +		pwm_apply_state(par->pwm, &pwmstate);
>  
> -		pwm_get_args(par->pwm, &pargs);
> -
> -		par->pwm_period = pargs.period;
>  		/* Enable the PWM */
> -		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
>  		pwm_enable(par->pwm);
>  
>  		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> -			par->pwm->pwm, par->pwm_period);
> +			par->pwm->pwm, pwm_get_period(par->pwm));
>  	}
>  
>  	/* Set initial contrast */
> 

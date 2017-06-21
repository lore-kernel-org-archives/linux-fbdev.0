From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 21 Jun 2017 09:37:43 +0000
Subject: Re: [PATCH v2] backlight: lm3630a: bump REG_MAX value to 0x50 instead of 0x1F
Message-Id: <1eda1c22-5a40-74f0-3a79-41e827828a32@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170621052450.2258-1-bshah@kde.org>
 <20170621053152.3008-1-bshah@kde.org>
In-Reply-To: <20170621053152.3008-1-bshah@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhushan Shah <bshah@kde.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/06/17 06:31, Bhushan Shah wrote:
> In the lm3630a_chip_init we try to write to 0x50 register, which is
> higher value then the max_register value, this resulted in regmap_write
> return -EIO.
> 
> Fix this by bumping REG_MAX value to 0x50. >
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Can we get a "Fixes" on this? It looks to me like it has been broken 
since 2a0c316bf3cc ("fix signedness bug in lm3630a_chip_init()").

Also I assume you find this by trying to use the driver on real 
hardware? If so can you confirm what you tested on in the patch 
description. As far as I can tell the code to set the filter strength 
has never worked, so you'll be the first user of it!

> ---
> 
> Changes since v1:
>      - Fix the lm3630a_write call to use proper value (sent worng patch earlier)
> 
>   drivers/video/backlight/lm3630a_bl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 60d6c2ac87aa..b641f706dbc9 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -31,7 +31,8 @@
>   #define REG_FAULT	0x0B
>   #define REG_PWM_OUTLOW	0x12
>   #define REG_PWM_OUTHIGH	0x13
> -#define REG_MAX		0x1F
> +#define REG_FLTR_STR	0x50

Can we expand this to REG_FILTER_STRENGTH?


Daniel.

> +#define REG_MAX		0x50
>   
>   #define INT_DEBOUNCE_MSEC	10
>   struct lm3630a_chip {
> @@ -80,7 +81,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
>   
>   	usleep_range(1000, 2000);
>   	/* set Filter Strength Register */
> -	rval = lm3630a_write(pchip, 0x50, 0x03);
> +	rval = lm3630a_write(pchip, REG_FLTR_STR, 0x03);
>   	/* set Cofig. register */
>   	rval |= lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
>   	/* set boost control */
> 


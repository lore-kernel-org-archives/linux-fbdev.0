From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 02 May 2019 10:07:51 +0000
Subject: Re: [PATCH v6 1/3] backlight: lm3630a: return 0 on success in update_status functions
Message-Id: <864c1ddc-1008-0041-1559-e491ca0186ef@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-2-masneyb@onstation.org>
In-Reply-To: <20190424092505.6578-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca, Daniel Thompson <daniel@redfelineninja.org.uk>

On 24/04/2019 10:25, Brian Masney wrote:
> lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status()
> both return the brightness value if the brightness was successfully
> updated. Writing to these attributes via sysfs would cause a 'Bad
> address' error to be returned. These functions should return 0 on
> success, so let's change it to correct that error.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
> Acked-by: Pavel Machek <pavel@ucw.cz>

Hi Brian, sorry for the delay. For some reason your mails are being 
dumped before they reach me so I only discovered these patches when I 
paid proper attention to the replies and fetched them from patchwork.

Hi Lee, is the same thing happening for you? ;-)

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> No changes since v2 when this patch was originally introduced.
> 
>   drivers/video/backlight/lm3630a_bl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 2030a6b77a09..ef2553f452ca 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -201,7 +201,7 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>   				      LM3630A_LEDA_ENABLE, LM3630A_LEDA_ENABLE);
>   	if (ret < 0)
>   		goto out_i2c_err;
> -	return bl->props.brightness;
> +	return 0;
>   
>   out_i2c_err:
>   	dev_err(pchip->dev, "i2c failed to access\n");
> @@ -278,7 +278,7 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
>   				      LM3630A_LEDB_ENABLE, LM3630A_LEDB_ENABLE);
>   	if (ret < 0)
>   		goto out_i2c_err;
> -	return bl->props.brightness;
> +	return 0;
>   
>   out_i2c_err:
>   	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");
> 

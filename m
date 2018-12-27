From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Dec 2018 09:39:51 +0000
Subject: Re: [PATCH] backlight: (adp8870) fix a missing check for adp8870_write
Message-Id: <20181227093951.GA14579@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181225062109.66943-1-kjlu@umn.edu>
In-Reply-To: <20181225062109.66943-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kangjie Lu <kjlu@umn.edu>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>

Hi Kangjie

> adp8870_write() may fail. This fix checks if adp8870_write fails, and if
> so, returns its error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/video/backlight/adp8870_bl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8d50e0299578..79901fb4fcd1 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -811,9 +811,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  		if (!ret) {
>  			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
>  			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> -		}
> -		mutex_unlock(&data->lock);
> +			ret = adp8870_write(data->client,
> +					ADP8870_CFGR, reg_val);
> +			if (ret) {
> +				mutex_unlock(&data->lock);
> +				return ret;
> +			}
> +		}	else
> +			mutex_unlock(&data->lock);
>  	}

Something looks wrong with the indent.
If you have braces around first part of if () then use
barces also after else. Then it is easier to follow the code.
In this case please consider another approach where you
have only a single mutex_unlock() both in the good and
in the error case.

	Sam

From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 03 Jan 2019 16:48:23 +0000
Subject: Re: [PATCH] backlight: (adp8870) fix a missing check for adp8870_write
Message-Id: <20190103164823.sfehxd6mkwaxiaxf@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181225062109.66943-1-kjlu@umn.edu>
In-Reply-To: <20181225062109.66943-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kangjie Lu <kjlu@umn.edu>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>

On Tue, Dec 25, 2018 at 12:21:09AM -0600, Kangjie Lu wrote:
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

Please don't unbalance the lock paths. Instead check the value of ret *after*
the existing mutex unlock (which will also means that the failed
adp8870_read() isn't silently ignored).

Also there's not much point in fixing this site without also fixing the
missing return checks on adp8870_set_bits() and adp8870_clr_bits() in
the same function.


Daniel.


>  	}
>  
>  	return count;
> -- 
> 2.17.2 (Apple Git-113)
> 

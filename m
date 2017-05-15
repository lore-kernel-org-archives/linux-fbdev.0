From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 15 May 2017 10:55:06 +0000
Subject: Re: [PATCH v4] backlight: report error on failure
Message-Id: <71efaa1a-53e2-e783-275b-ca73a746f4f9@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1494538619-3595-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1494538619-3595-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On 11/05/17 22:36, Sudip Mukherjee wrote:
> It is possible to update the backlight power and the brightness using
> the sysfs and on writing it either returns the count or if the callback
> function does not exist then returns the error code 'ENXIO'.
> 
> We have a situation where the userspace client is writing to the sysfs
> to update the power and since the callback function exists the client
> receives the return value as count and considers the operation to be
> successful. That is correct as the write to the sysfs was successful.
> But there is no way to know if the actual operation was done or not.
> 
> backlight_update_status() returns the error code if it fails. Pass that
> to the userspace client who is trying to update the power so that the
> client knows that the operation failed.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> 
> v4: ABI comment removed from commit message
> v3: remove rc = 0, and update rc with count in else condition.
> v2: update power with old value on failure.
> 
> Copy-pasting from the last patch conversation:
> 
> The problem that prompted me to send this patch is the current project
> that I am working on now. And we faced this there. The userspace code is
> writing to the sysfs node to poweron the backlight and reported success.
> But sometimes we noticed that backlight was not actally powered on. And
> that lead me to check the code and noticed that it is swallowing all the
> errors.
> 
>   drivers/video/backlight/backlight.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 288318a..0289107 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -134,7 +134,7 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>   {
>   	int rc;
>   	struct backlight_device *bd = to_backlight_device(dev);
> -	unsigned long power;
> +	unsigned long power, old_power;
>   
>   	rc = kstrtoul(buf, 0, &power);
>   	if (rc)
> @@ -145,10 +145,15 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>   	if (bd->ops) {
>   		pr_debug("set power to %lu\n", power);
>   		if (bd->props.power != power) {
> +			old_power = bd->props.power;
>   			bd->props.power = power;
> -			backlight_update_status(bd);
> +			rc = backlight_update_status(bd);
> +			if (rc)
> +				bd->props.power = old_power;

Can we lose the ternary condition and have:

			else
				rc = count;


With that change:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> +		} else {
> +			rc = count;
>   		}
> -		rc = count;
> +		rc = rc ? rc : count;
>   	}
>   	mutex_unlock(&bd->ops_lock);
>   
> @@ -176,8 +181,7 @@ int backlight_device_set_brightness(struct backlight_device *bd,
>   		else {
>   			pr_debug("set brightness to %lu\n", brightness);
>   			bd->props.brightness = brightness;
> -			backlight_update_status(bd);
> -			rc = 0;
> +			rc = backlight_update_status(bd);
>   		}
>   	}
>   	mutex_unlock(&bd->ops_lock);
> 


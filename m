From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Sun, 19 Feb 2017 08:13:11 +0000
Subject: Re: [PATCH] backlight: report error on failure
Message-Id: <20170219081311.GA30444@wychelm.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, Jan 18, 2017 at 09:23:50PM +0000, Sudip Mukherjee wrote:
> It is possible to update the backlight power and the brightness using
> the sysfs and on writing it either returns the count or if the callback
> function does not exist then returns the error code 'ENXIO'.
> 
> We have a situation where the userspace client is writing to the sysfs
> to update the power and since the callback function exists the client
> receives the return value as count and considers the operation to be
> successful. That is correct as the write to the sysfs was successful.
> But there is no way to know if the actual operation was done or not.

For brightness there is the actual_brightness file... but I don't think
there's anything for power.


> backlight_update_status() returns the error code if it fails. Pass that
> to the userspace client who is trying to update the power so that the
> client knows that the operation failed.

Strictly speaking this is an ABI change. Its probably a harmless one
making it ok to change but I'm interested what testing or code review 
you've done to be sure the userspace doesn't do odd things if the kernel
starts to pass through errors.


> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/backlight/backlight.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 288318a..74b72b5 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -146,9 +146,9 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>  		pr_debug("set power to %lu\n", power);
>  		if (bd->props.power != power) {
>  			bd->props.power = power;
> -			backlight_update_status(bd);
> +			rc = backlight_update_status(bd);
>  		}
> -		rc = count;
> +		rc = rc ? rc : count;

Shouldn't bd->props,power be rolled back on error?

Without it we end up in an odd situation with the lazy updates, 
specifically if the userspace observes original error and retries then we
will spuriously succeed due to the lazy update (leaving us not much 
better off than without this change).


>  	mutex_unlock(&bd->ops_lock);
>  
> @@ -176,8 +176,7 @@ int backlight_device_set_brightness(struct backlight_device *bd,
>  		else {
>  			pr_debug("set brightness to %lu\n", brightness);
>  			bd->props.brightness = brightness;
> -			backlight_update_status(bd);
> -			rc = 0;
> +			rc = backlight_update_status(bd);

Again, there is no roll back on error.


Daniel.

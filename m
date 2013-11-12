From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 12 Nov 2013 00:18:04 +0000
Subject: Re: [PATCH] video: backlight: Remove backlight sysfs uevent
Message-Id: <002901cedf3c$a7e77a00$f7b66e00$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131111235700.GA29987@july>
In-Reply-To: <20131111235700.GA29987@july>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Kyungmin Park' <kmpark@infradead.org>, 'Henrique de Moraes Holschuh' <ibm-acpi@hmh.eng.br>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kay@vrfy.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Jingoo Han' <jg1.han@samsung.com>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Tuesday, November 12, 2013 8:57 AM, Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> The most mobile phones have Ambient Light Sensors and it changes brightness according lux.
> It means it changes backlight brightness frequently by just writing sysfs node, so it generates uevent.
> 
> Usually there's no user to use this backlight changes. But it forks udev worker threads and it takes
> about 5ms. The main problem is that it hurts other process activities. so remove it.
> 
> Kay said
> "Uevents are for the major, low-frequent, global device state-changes,
>  not for carrying-out any sort of measurement data. Subsystems which
>  need that should use other facilities like poll()-able sysfs file or
>  any other subscription-based, client-tracking interface which does not
>  cause overhead if it isn't used. Uevents are not the right thing to
>  use here, and upstream udev should not paper-over broken kernel
>  subsystems."
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 94a403a..441272d 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -88,9 +88,6 @@ static void backlight_generate_event(struct backlight_device *bd,
>  	char *envp[2];
> 
>  	switch (reason) {
> -	case BACKLIGHT_UPDATE_SYSFS:
> -		envp[0] = "SOURCE=sysfs";
> -		break;
>  	case BACKLIGHT_UPDATE_HOTKEY:
>  		envp[0] = "SOURCE=hotkey";
>  		break;
> @@ -172,8 +169,6 @@ static ssize_t brightness_store(struct device *dev,
>  	}
>  	mutex_unlock(&bd->ops_lock);
> 
> -	backlight_generate_event(bd, BACKLIGHT_UPDATE_SYSFS);
> -
>  	return rc;
>  }
>  static DEVICE_ATTR_RW(brightness);
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 53b7794..d2a27dd 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -29,7 +29,6 @@
> 
>  enum backlight_update_reason {
>  	BACKLIGHT_UPDATE_HOTKEY,
> -	BACKLIGHT_UPDATE_SYSFS,

+cc Henrique de Moraes Holschuh (Maintainer of thinkpad_acpi)

Hi Henrique de Moraes Holschuh,

'thinkpad_acpi.c' uses the 'BACKLIGHT_UPDATE_SYSFS'.
Henrique, can we remove it?

drivers/platform/x86/thinkpad_acpi.c
if (!rc && ibm_backlight_device)
                backlight_force_update(ibm_backlight_device,
                                        BACKLIGHT_UPDATE_SYSFS);

Best regards,
Jingoo Han

>  };
> 
>  enum backlight_type {


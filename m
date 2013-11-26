From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 26 Nov 2013 04:27:11 +0000
Subject: Re: [PATCH v2] video: backlight: Remove backlight sysfs uevent
Message-Id: <001001ceea5f$c6642e50$532c8af0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131112033906.GA30454@july>
In-Reply-To: <20131112033906.GA30454@july>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Kyungmin Park' <kmpark@infradead.org>, 'Richard Purdie' <rpurdie@rpsys.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Kay Sievers' <kay@vrfy.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, November 12, 2013 12:39 PM, Kyungmin Park wrote:
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

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> v1: there's still user to use BACKLIGHT_UPDATE_SYSFS. so just remove store sysfs node uevent
> 
> ---
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 94a403a..292cf99 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -172,8 +172,6 @@ static ssize_t brightness_store(struct device *dev,
>  	}
>  	mutex_unlock(&bd->ops_lock);
> 
> -	backlight_generate_event(bd, BACKLIGHT_UPDATE_SYSFS);
> -
>  	return rc;
>  }
>  static DEVICE_ATTR_RW(brightness);


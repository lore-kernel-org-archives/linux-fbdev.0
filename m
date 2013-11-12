From: Kyungmin Park <kmpark@infradead.org>
Date: Tue, 12 Nov 2013 00:54:04 +0000
Subject: Re: [PATCH] video: backlight: Remove backlight sysfs uevent
Message-Id: <CAH9JG2V0_aFdJaNcVBOYnE=s1YP8hfFhQPjdQ=+HBr0Afy5fLw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131112004436.GA30125@july>
In-Reply-To: <20131112004436.GA30125@july>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kay@vrfy.org

Please ignore it. strange mail system.

After feedback from previous mail, I'll re-send it.

Thank you,
Kyungmin Park

On Tue, Nov 12, 2013 at 9:44 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> The most mobile phones have Ambient Light Sensors and it changes brightness according lux.
> It means it changes backlight brightness frequently by just writing sysfs node, so it generates uevent.
>
> Usually there's no user to use this backlight changes. But it forks udev worker threads and it takes about 5ms. The main problem is that it hurts other process activities. so remove it.
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
>         char *envp[2];
>
>         switch (reason) {
> -       case BACKLIGHT_UPDATE_SYSFS:
> -               envp[0] = "SOURCE=sysfs";
> -               break;
>         case BACKLIGHT_UPDATE_HOTKEY:
>                 envp[0] = "SOURCE=hotkey";
>                 break;
> @@ -172,8 +169,6 @@ static ssize_t brightness_store(struct device *dev,
>         }
>         mutex_unlock(&bd->ops_lock);
>
> -       backlight_generate_event(bd, BACKLIGHT_UPDATE_SYSFS);
> -
>         return rc;
>  }
>  static DEVICE_ATTR_RW(brightness);
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 53b7794..d2a27dd 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -29,7 +29,6 @@
>
>  enum backlight_update_reason {
>         BACKLIGHT_UPDATE_HOTKEY,
> -       BACKLIGHT_UPDATE_SYSFS,
>  };
>
>  enum backlight_type {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

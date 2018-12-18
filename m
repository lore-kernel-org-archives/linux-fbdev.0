From: Rob Clark <robdclark@gmail.com>
Date: Tue, 18 Dec 2018 13:19:54 +0000
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Message-Id: <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181026140931.15771-1-robdclark@gmail.com>
In-Reply-To: <20181026140931.15771-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, Ulf Magnusson <ulfalizer@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Hans de Goede <j.w.r.degoede@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 26, 2018 at 10:09 AM Rob Clark <robdclark@gmail.com> wrote:
>
> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> FB_BACKLIGHT prevents it from being built as a module.  There
> doesn't seem to be any particularly good reason for this, so
> switch FB_BACKLIGHT over to tristate.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> Tested-by: Arnd Bergmann <arnd@arndb.de>

bump

maybe we can merge this via drm-misc?

BR,
-R

> ---
> v2: remove IS_ENABLED() from UABI headers.  Userspace doesn't
>     know the kernel config, so just remove the ifdef guard
>
>  drivers/video/fbdev/Kconfig        | 2 +-
>  drivers/video/fbdev/core/fbsysfs.c | 8 ++++----
>  include/linux/fb.h                 | 2 +-
>  include/uapi/linux/fb.h            | 2 --
>  4 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 591a13a59787..146ab2c347f8 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -198,7 +198,7 @@ config FB_MACMODES
>         default n
>
>  config FB_BACKLIGHT
> -       bool
> +       tristate
>         depends on FB
>         select BACKLIGHT_LCD_SUPPORT
>         select BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index e31a182b42bf..44cca39f2b51 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -60,7 +60,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
>         info->device = dev;
>         info->fbcon_rotate_hint = -1;
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         mutex_init(&info->bl_curve_mutex);
>  #endif
>
> @@ -429,7 +429,7 @@ static ssize_t show_fbstate(struct device *device,
>         return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
>  }
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>  static ssize_t store_bl_curve(struct device *device,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
> @@ -510,7 +510,7 @@ static struct device_attribute device_attrs[] = {
>         __ATTR(stride, S_IRUGO, show_stride, NULL),
>         __ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
>         __ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         __ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
>  #endif
>  };
> @@ -551,7 +551,7 @@ void fb_cleanup_device(struct fb_info *fb_info)
>         }
>  }
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>  /* This function generates a linear backlight curve
>   *
>   *     0: off
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a3cab6dc9b44..7cdd31a69719 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -485,7 +485,7 @@ struct fb_info {
>         struct list_head modelist;      /* mode list */
>         struct fb_videomode *mode;      /* current mode */
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         /* assigned backlight device */
>         /* set before framebuffer registration,
>            remove after unregister */
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index 6cd9b198b7c6..b6aac7ee1f67 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -393,11 +393,9 @@ struct fb_cursor {
>         struct fb_image image;  /* Cursor image */
>  };
>
> -#ifdef CONFIG_FB_BACKLIGHT
>  /* Settings for the generic backlight code */
>  #define FB_BACKLIGHT_LEVELS    128
>  #define FB_BACKLIGHT_MAX       0xFF
> -#endif
>
>
>  #endif /* _UAPI_LINUX_FB_H */
> --
> 2.17.2
>

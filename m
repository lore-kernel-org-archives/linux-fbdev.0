From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 Oct 2019 11:02:25 +0000
Subject: Re: [PATCH v6 2/9] backlight: gpio: remove stray newline
Message-Id: <CAHp75VcBWk6xiFKejuN7qq8yAcubxbfW6GfvL7hOdQWxfoDBzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191019083556.19466-1-brgl@bgdev.pl>
 <20191019083556.19466-3-brgl@bgdev.pl>
In-Reply-To: <20191019083556.19466-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Jacopo Mondi <jacopo@jmondi.org>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Sat, Oct 19, 2019 at 12:58 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Remove a double newline from the driver.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 7e1990199fae..3955b513f2f8 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -91,7 +91,6 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>         return FB_BLANK_UNBLANK;
>  }
>
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>         struct gpio_backlight_platform_data *pdata > --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko

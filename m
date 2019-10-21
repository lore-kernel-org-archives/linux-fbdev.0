From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Oct 2019 12:21:21 +0000
Subject: Re: [PATCH v6 3/9] backlight: gpio: explicitly set the direction of the GPIO
Message-Id: <CAMRc=Md99q+67FAduiixQQs6BVtLXNrC=KbicsuBsB2Jp4O7dw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191019083556.19466-1-brgl@bgdev.pl> <20191019083556.19466-4-brgl@bgdev.pl>
 <20191021104509.p2bsll3rwe7ica6t@holly.lan>
In-Reply-To: <20191021104509.p2bsll3rwe7ica6t@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

pon., 21 paź 2019 o 12:45 Daniel Thompson <daniel.thompson@linaro.org>
napisał(a):
>
> On Sat, Oct 19, 2019 at 10:35:50AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The GPIO backlight driver currently requests the line 'as is', without
> > acively setting its direction. This can lead to problems: if the line
> > is in input mode by default, we won't be able to drive it later when
> > updating the status and also reading its initial value doesn't make
> > sense for backlight setting.
> >
> > Request the line 'as is' initially, so that we can read its value
> > without affecting it but then change the direction to output explicitly
> > when setting the initial brightness.
> >
> > Also: check the current direction and only read the value if it's output.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Intent looks good to me but...
>
> > ---
> >  drivers/video/backlight/gpio_backlight.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> > index 3955b513f2f8..a36ac3a45b81 100644
> > --- a/drivers/video/backlight/gpio_backlight.c
> > +++ b/drivers/video/backlight/gpio_backlight.c
> > @@ -25,9 +25,8 @@ struct gpio_backlight {
> >       int def_value;
> >  };
> >
> > -static int gpio_backlight_update_status(struct backlight_device *bl)
> > +static int gpio_backlight_get_curr_brightness(struct backlight_device *bl)
>
> This function does not get the current brightness (e.g. what the
> hardware is currently doing). Given we've just nuked the function that
> *did* get the current brightness from the hardware this isn't an
> acceptable name.
>
> Would like something like calc_brightness() or get_next_brightness().
>

Fair enough, the latter sounds good in this case.

Bart

From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 27 Jun 2019 09:24:53 +0000
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Message-Id: <20190627092453.GB2000@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-4-mka@chromium.org>
 <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
In-Reply-To: <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

On Fri, 21 Jun 2019, Daniel Thompson wrote:

> On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> > For backlight curves calculated with the CIE 1931 algorithm set
> > the brightness scale type property accordingly. This makes the
> > scale type available to userspace via the 'scale' sysfs attribute.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I'd like to keep discussion on patch 2 open a bit longer (it's not part of
> the thread below patch 2 but Pavel had concerns about the sysfs interface)
> so this ack won't really push things forward but FWIW:
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Does this depend on patch 2, or is it orthogonal?

> > ---
> >   drivers/video/backlight/pwm_bl.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index fb45f866b923..f067fe7aa35d 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   		goto err_alloc;
> >   	}
> > +	memset(&props, 0, sizeof(struct backlight_properties));
> > +
> >   	if (data->levels) {
> >   		/*
> >   		 * For the DT case, only when brightness levels is defined
> > @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   			pb->levels = data->levels;
> >   		}
> > +
> > +		props.scale = BACKLIGHT_SCALE_CIE1931;
> >   	} else {
> >   		/*
> >   		 * That only happens for the non-DT case, where platform data
> > @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> > -	memset(&props, 0, sizeof(struct backlight_properties));
> >   	props.type = BACKLIGHT_RAW;
> >   	props.max_brightness = data->max_brightness;
> >   	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

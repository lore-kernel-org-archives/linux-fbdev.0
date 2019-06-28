From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 28 Jun 2019 07:55:16 +0000
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Message-Id: <20190628075516.dwev7fxz7kmox2i2@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-5-mka@chromium.org>
 <20190626145617.GB22348@xo-6d-61-c0.localdomain>
In-Reply-To: <20190626145617.GB22348@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Wed, Jun 26, 2019 at 04:56:18PM +0200, Pavel Machek wrote:
> On Mon 2019-06-24 13:31:13, Matthias Kaehlcke wrote:
> > Check if a brightness curve specified in the device tree is linear or
> > not and set the corresponding property accordingly. This makes the
> > scale type available to userspace via the 'scale' sysfs attribute.
> > 
> > To determine if a curve is linear it is compared to a interpolated linear
> > curve between min and max brightness. The curve is considered linear if
> > no value deviates more than +/-5% of ${brightness_range} from their
> > interpolated value.
> 
> I don't think this works. Some hardware does takes brightness in perceptual units,
> converting it in the LED controller.

This check is exclusive to PWM backlights so I'd like to double check
that you are thinking specifically of hardware that takes it's signal
from the PWM and works in perceptual units?

I don't recall any examples being offered when we reviewed the
auto-generated CIE tables (although since that can be overriden by DT it
was not of the same gravity and this example).


Daniel.

From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 26 Jun 2019 14:56:18 +0000
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Message-Id: <20190626145617.GB22348@xo-6d-61-c0.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-5-mka@chromium.org>
In-Reply-To: <20190624203114.93277-5-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>

On Mon 2019-06-24 13:31:13, Matthias Kaehlcke wrote:
> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.

I don't think this works. Some hardware does takes brightness in perceptual units,
converting it in the LED controller.

									Pavel

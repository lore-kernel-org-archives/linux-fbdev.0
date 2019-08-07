From: Matthias Kaehlcke <mka@chromium.org>
Date: Wed, 07 Aug 2019 20:15:28 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190807201528.GO250418@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
In-Reply-To: <20190709190007.91260-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>

On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> Backlight brightness curves can have different shapes. The two main
> types are linear and non-linear curves. The human eye doesn't
> perceive linearly increasing/decreasing brightness as linear (see
> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> linearly to human eye"), hence many backlights use non-linear (often
> logarithmic) brightness curves. The type of curve currently is opaque
> to userspace, so userspace often uses more or less reliable heuristics
> (like the number of brightness levels) to decide whether to treat a
> backlight device as linear or non-linear.
> 
> Export the type of the brightness curve via the new sysfs attribute
> 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> 'unknown'. For devices that don't provide information about the scale
> of their brightness curve the value of the 'scale' attribute is 'unknown'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Daniel (et al): do you have any more comments on this patch/series or
is it ready to land?

Thanks

Matthias

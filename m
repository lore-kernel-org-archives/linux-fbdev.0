From: Alexandru Stan <amstan@chromium.org>
Date: Tue, 21 Jul 2020 04:25:19 +0000
Subject: [PATCH 0/3] PWM backlight interpolation adjustments
Message-Id: <20200721042522.2403410-1-amstan@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandru Stan <amstan@chromium.org>, linux-pwm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-arm-kernel@lists.infradead.org

I was trying to adjust the brightness for a new chromebook:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
Like a lot of panels, the low end needs to be cropped,
and now that we have the interpolation stuff I wanted to make use of it
and bake in even the curve.

I found the behavior a little unintuitive and non-linear. See patch 1
for a suggested fix for this.

Unfortunatelly a few veyron dts files were relying on this
(perhaps weird) behavior. Those devices also want a minimum brightness.
The issue is that they also want the 0% point for turning off the
display.
https://github.com/torvalds/linux/commit/6233269bce47bd450196a671ab28eb1ec5eb88d9#diff-e401ae20091bbfb311a062c464f4f47fL23

So the idea here is to change those dts files to only say <3 255> (patch
3), and add in a virtual 0% point at the bottom of the scale (patch 2).

We have to do this conditionally because it seems some devices like to
have the scale inverted:
  % git grep "brightness-levels\s*=\s*<\s*[1-9]"|cat
  arch/arm/boot/dts/tegra124-apalis-eval.dts:             brightness-levels = <255 231 223 207 191 159 127 0>;


Alexandru Stan (3):
  backlight: pwm_bl: Fix interpolation
  backlight: pwm_bl: Artificially add 0% during interpolation
  ARM: dts: rockchip: Remove 0 point in backlight

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  |  2 +-
 drivers/video/backlight/pwm_bl.c           | 78 +++++++++++-----------
 4 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.27.0

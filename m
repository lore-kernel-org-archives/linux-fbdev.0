From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 12 Dec 2018 06:14:04 +0000
Subject: Re: [RESEND PATCH v3] backlight: pwm_bl: Fix brightness levels for non-DT case.
Message-Id: <20181212061404.GK4497@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181210121437.30170-1-enric.balletbo@collabora.com>
In-Reply-To: <20181210121437.30170-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pwm@vger.kernel.org, daniel.thompson@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, u.kleine-koenig@pengutronix.de, kernel@collabora.com, robert.jarzmik@free.fr

On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:

> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
> 
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, it sets the max_brightness in their platform data and the
> driver calculates the level without a table. The offending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
> 
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not.
> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Cc: <stable@vger.kernel.org>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Changes in v3:
> - Fixed some typos in commit message.
> - Removed ' in Fixes tag.
> 
> Changes in v2:
> - Rebase on top of mainline
> - Add Tested-by and Acked-by tags.
> 
>  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)

FYI, this patch is now in Mainline.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

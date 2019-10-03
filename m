From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 03 Oct 2019 11:42:42 +0000
Subject: Re: [PATCH v4 2/2] backlight: lm3630a: Add an enable gpio for the HWEN pin
Message-Id: <20191003114242.GE21172@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info>
 <20190912213257.24147-3-andreas@kemnade.info>
In-Reply-To: <20190912213257.24147-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 12 Sep 2019, Andreas Kemnade wrote:

> For now just enable it in the probe function to allow I2C
> access. Disabling also means resetting the register values
> to default and according to the datasheet does not give
> power savings.
> 
> Tested on Kobo Clara HD.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Dan Murphy <dmurphy@ti.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> changes in v2:
> - simplification
> - correct gpio direction initialisation
> 
> changes in v3:
> - removed legacy include
> 
>  drivers/video/backlight/lm3630a_bl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

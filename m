From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 03 Oct 2019 11:42:26 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: lm3630a: Add enable-gpios to describe HWEN pin
Message-Id: <20191003114226.GD21172@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info>
 <20190912213257.24147-2-andreas@kemnade.info>
In-Reply-To: <20190912213257.24147-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-leds@vger.kernel.org, dmurphy@ti.com

On Thu, 12 Sep 2019, Andreas Kemnade wrote:

> Provide DT documentation for enable-gpios.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dan Murphy <dmurphy@ti.com>
> ---
> changes in v2: added example
> changes in v3: added Acked-by
> changes in v4: moved enable-gpios to the right position
>   in the example
>  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

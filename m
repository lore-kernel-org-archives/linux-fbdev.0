From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 30 Oct 2019 07:50:47 +0000
Subject: Re: [PATCH next] dt-bindings: backlight: lm3630a: fix missing include
Message-Id: <20191030075047.GC4484@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029185350.31155-1-andreas@kemnade.info>
In-Reply-To: <20191029185350.31155-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>

On Tue, 29 Oct 2019, Andreas Kemnade wrote:

> example failed to compile due to undefined GPIO_ACTIVE_HIGH
> fix that by adding the needed #include to the exammple
> 
> Fixes: ae92365cdd75 ("dt-bindings: backlight: lm3630a: Add enable-gpios to describe HWEN pin")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml    | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

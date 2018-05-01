From: "Jingoo Han" <jingoohan1@gmail.com>
Date: Tue, 01 May 2018 03:21:10 +0000
Subject: Re: [PATCH 2/2] backlight: Remove ld9040 driver
Message-Id: <000301d3e0fb$747627f0$5d6277d0$@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180430172945.20938-1-krzk@kernel.org> <20180430172945.20938-2-krzk@kernel.org>
In-Reply-To: <20180430172945.20938-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Lee Jones' <lee.jones@linaro.org>, 'Daniel Thompson' <daniel.thompson@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Inki Dae' <inki.dae@samsung.com>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Monday, April 30, 2018 1:30 PM
> To: Lee Jones <lee.jones@linaro.org>; Daniel Thompson
> <daniel.thompson@linaro.org>; Jingoo Han <jingoohan1@gmail.com>;
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; linux-
> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; linux-
> fbdev@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Inki Dae <inki.dae@samsung.com>
> Subject: [PATCH 2/2] backlight: Remove ld9040 driver
> 
> The driver for LD9040 AMOLED LCD panel was superseded with DRM driver
> panel-samsung-ld9040.c.  It does not support DeviceTree and respective
> possible user (Exynos4210 Universal C210) is DeviceTree-only and uses
> DRM version of driver..
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/video/backlight/Kconfig        |   8 -
>  drivers/video/backlight/Makefile       |   1 -
>  drivers/video/backlight/ld9040.c       | 811
-----------------------------
> ----
>  drivers/video/backlight/ld9040_gamma.h | 202 --------
>  4 files changed, 1022 deletions(-)
>  delete mode 100644 drivers/video/backlight/ld9040.c
>  delete mode 100644 drivers/video/backlight/ld9040_gamma.h

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

[.....]



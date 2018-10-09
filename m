From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 09 Oct 2018 09:57:20 +0000
Subject: Re: [RESEND v2 2/2] backlight: Remove ld9040 driver
Message-Id: <20181009095720.GJ4939@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180927165541.11903-1-krzk@kernel.org>
 <20180927165541.11903-2-krzk@kernel.org>
In-Reply-To: <20180927165541.11903-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Aishwarya Pant <aishpant@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, 27 Sep 2018, Krzysztof Kozlowski wrote:

> The driver for LD9040 AMOLED LCD panel was superseded with DRM driver
> panel-samsung-ld9040.c.  It does not support DeviceTree and respective
> possible user (Exynos4210 Universal C210) is DeviceTree-only and uses
> DRM version of driver.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add Jingoo's and Daniel's acks.
> ---
>  drivers/video/backlight/Kconfig        |   8 -
>  drivers/video/backlight/Makefile       |   1 -
>  drivers/video/backlight/ld9040.c       | 811 -------------------------
>  drivers/video/backlight/ld9040_gamma.h | 202 ------
>  4 files changed, 1022 deletions(-)
>  delete mode 100644 drivers/video/backlight/ld9040.c
>  delete mode 100644 drivers/video/backlight/ld9040_gamma.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

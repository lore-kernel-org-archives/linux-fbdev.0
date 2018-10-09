From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 09 Oct 2018 09:57:10 +0000
Subject: Re: [RESEND v2 1/2] backlight: Remove s6e63m0 driver
Message-Id: <20181009095710.GI4939@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180927165541.11903-1-krzk@kernel.org>
In-Reply-To: <20180927165541.11903-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Aishwarya Pant <aishpant@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, 27 Sep 2018, Krzysztof Kozlowski wrote:

> The driver for S6E63M0 AMOLED LCD panel is not used.  It does not
> support DeviceTree and respective possible users (S5Pv210 Aquila and
> Goni boards) are DeviceTree-only.
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
> 1. Remove sysfs ABI documentation file.
> 2. Add Jingoo's and Daniel's acks.
> ---
>  .../ABI/testing/sysfs-class-lcd-s6e63m0       |  27 -
>  drivers/video/backlight/Kconfig               |   8 -
>  drivers/video/backlight/Makefile              |   1 -
>  drivers/video/backlight/s6e63m0.c             | 857 ------------------
>  drivers/video/backlight/s6e63m0_gamma.h       | 266 ------
>  5 files changed, 1159 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
>  delete mode 100644 drivers/video/backlight/s6e63m0.c
>  delete mode 100644 drivers/video/backlight/s6e63m0_gamma.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

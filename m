From: "Jingoo Han" <jingoohan1@gmail.com>
Date: Tue, 01 May 2018 03:20:29 +0000
Subject: Re: [PATCH 1/2] backlight: Remove s6e63m0 driver
Message-Id: <000201d3e0fb$5be60250$13b206f0$@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180430172945.20938-1-krzk@kernel.org>
In-Reply-To: <20180430172945.20938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Lee Jones' <lee.jones@linaro.org>, 'Daniel Thompson' <daniel.thompson@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Inki Dae' <inki.dae@samsung.com>

On Monday, April 30, 2018 1:30 PM, Krzysztof Kozlowski wrote:
> 
> The driver for S6E63M0 AMOLED LCD panel is not used.  It does not
> support DeviceTree and respective possible users (S5Pv210 Aquila and
> Goni boards) are DeviceTree-only.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/video/backlight/Kconfig         |   8 -
>  drivers/video/backlight/Makefile        |   1 -
>  drivers/video/backlight/s6e63m0.c       | 857
----------------------------
> ----

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

[.....]



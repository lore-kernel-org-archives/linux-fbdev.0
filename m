From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Fri, 27 Mar 2015 19:21:26 +0000
Subject: Re: [RFT PATCHv2] drm/exynos: Enable DP clock to fix display on Exynos5250 and other
Message-Id: <5515ADB6.6050204@collabora.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427472488-21454-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1427472488-21454-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jingoo Han <jg1.han@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, stable@vger.kernel.org

Hello Krzysztof,

On 03/27/2015 05:08 PM, Krzysztof Kozlowski wrote:
> After adding display power domain for Exynos5250 in commit
> 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250") the
> display on Chromebook Snow and others stopped working after boot.
> 
> The reason for this suggested Andrzej Hajda: the DP clock was disabled.
> This clock is required by Display Port and is enabled by bootloader.
> However when FIMD driver probing was deferred, the display power domain
> was turned off. This effectively reset the value of DP clock enable
> register.
> 
> When exynos-dp is later probed, the clock is not enabled and display is
> not properly configured:
> 
> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
> exynos-dp 145b0000.dp-controller: unable to config video
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
> Cc: <stable@vger.kernel.org>
> 
> ---
> 
> This should fix issue reported by Javier [1][2].
>

I tested this patch and does indeed solves both issues I reported
The exynos-dp probe deferral does not make the display to not be
working and also disabling and enabling the display with:

with /sys/devices/platform/exynos-drm/graphics/fb0/blank works.

Thanks a lot for fixing this issue.

On an Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 20 Jun 2017 09:53:51 +0000
Subject: Re: [PATCH 1/2] drm/exynos/decon: Add include guard to the Exynos7 header
Message-Id: <CACvgo51db4Gk+GHAO-F=rz8vLTG6A66f1ZeHPNuAQV1Qthaavw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170619163110.28173-1-krzk@kernel.org>
In-Reply-To: <20170619163110.28173-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On 19 June 2017 at 17:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Although header is included only once but still having an include guard
> is a good practice.  To avoid confusion, add SoC prefix to existing
> Exynos5433 header include guard.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/video/exynos5433_decon.h | 6 +++---
>  include/video/exynos7_decon.h    | 5 +++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/video/exynos5433_decon.h b/include/video/exynos5433_decon.h
> index 78957c9626f5..b30362da5692 100644
> --- a/include/video/exynos5433_decon.h
> +++ b/include/video/exynos5433_decon.h
> @@ -6,8 +6,8 @@
>   * published by the Free Software Foundationr
>   */
>
> -#ifndef EXYNOS_REGS_DECON_H
> -#define EXYNOS_REGS_DECON_H
> +#ifndef EXYNOS5433_REGS_DECON_H
> +#define EXYNOS5433_REGS_DECON_H
>
Drop the _REGS_ part from the guard on each header? The file name/path
does not have it, plus it'll save some WTF moments when
exynos{5433,7}_regs_decon.h comes about.

Regards,
Emil

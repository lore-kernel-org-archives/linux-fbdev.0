From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 30 Jan 2012 23:31:54 +0000
Subject: Re: [PATCH] MAINTAINERS: add entry for exynos display drivers video/driver/exynos/*
Message-Id: <20120130153154.fbc2108a.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F262DB6.7060104@samsung.com>
	<4F2667EE.2090902@samsung.com>
In-Reply-To: <4F2667EE.2090902@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 30 Jan 2012 18:50:38 +0900
Donghwa Lee <dh09.lee@samsung.com> wrote:

> Hi,
> I'd like to add Inki Dae, Donghwa Lee and Kyungmin Park as maintainers
> who developers for exynos display drivers for video/driver/exynos/*
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a90101..0ffdc9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2335,6 +2335,15 @@ S:	Supported
>  F:	drivers/gpu/drm/exynos
>  F:	include/drm/exynos*
>  
> +EXYNOS DISPLAY DRIVERS
> +M:	Inki Dae <inki.dae@samsung.com>
> +M:	Donghwa Lee <dh09.lee@samsung.com>
> +M:	Kyungmin Park <kyungmin.park@samsung.com>
> +L:	linux-fbdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/video/exynos/*
> +F:	include/video/exynos*

The patch is missing your signed-off-by, and rather needs it.  Please
send one?


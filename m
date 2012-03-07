From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 07 Mar 2012 10:13:41 +0000
Subject: Re: [PATCH] MAINTAINERS: add entry for exynos mipi display drivers
Message-Id: <4F5734D5.2030504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F557A2A.2080108@samsung.com>
In-Reply-To: <4F557A2A.2080108@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/06/2012 02:44 AM, Donghwa Lee wrote:
> Hi, I'd like to add Inki Dae, Donghwa Lee and Kyungmin Park as 
> maintainers who developers for exynos mipi display drivers for
> video/driver/exynos/exynos_mipi* and include/video/exynos_mipi*.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied after moving it to keep alphabetical order in MAINTAINERS and
amending the commit message like Andrew did with v1 of this patch
(deleting "Hi, I'd like to").


Thanks,

Florian Tobias Schandinat

> ---
>  MAINTAINERS |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b087b3bc..eb5fbcb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2351,6 +2351,15 @@ S:	Supported
>  F:	drivers/gpu/drm/exynos
>  F:	include/drm/exynos*
>  
> +EXYNOS MIPI DISPLAY DRIVERS
> +M:	Inki Dae <inki.dae@samsung.com>
> +M:	Donghwa Lee <dh09.lee@samsung.com>
> +M:	Kyungmin Park <kyungmin.park@samsung.com>
> +L:	linux-fbdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/video/exynos/exynos_mipi*
> +F:	include/video/exynos_mipi*
> +
>  DSCC4 DRIVER
>  M:	Francois Romieu <romieu@fr.zoreil.com>
>  L:	netdev@vger.kernel.org


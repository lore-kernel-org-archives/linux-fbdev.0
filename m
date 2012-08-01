From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 01 Aug 2012 01:36:32 +0000
Subject: Re: [PATCH V2 4/5] driver: Include the modified FIMD header file
Message-Id: <003101cd6f86$14ca1060$3e5e3120$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, m.szyprowski@samsung.com, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, July 31, 2012 9:23 PM Leela Krishna Amudala wrote:
> 
> The fimd register headers have been moved to include/video/
> hence, modifying the driver files accordingly.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c |    2 +-
>  drivers/video/s3c-fb.c                   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index 29fdbfe..8da90f9 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -20,7 +20,7 @@
>  #include <linux/pm_runtime.h>
> 
>  #include <drm/exynos_drm.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
> 
>  #include "exynos_drm_drv.h"
>  #include "exynos_drm_fbdev.h"
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 69bf9d0..1226fdd 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -26,7 +26,7 @@
>  #include <linux/pm_runtime.h>
> 
>  #include <mach/map.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
>  #include <plat/fb.h>


Please move header include to proper place as bellows:

#include <linux/pm_runtime.h>

#include <video/samsung_fimd.h>

#include <mach/map.h>
#include <plat/fb.h>


Best regards,
Jingoo Han

> 
>  /* This driver will export a number of framebuffer interfaces depending
> --
> 1.7.0.4


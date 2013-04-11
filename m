From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 11 Apr 2013 05:07:02 +0000
Subject: Re: [PATCH 12/30] video/exynos: remove unnecessary header inclusions
Message-Id: <003201ce3672$66f72e50$34e58af0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-13-git-send-email-arnd@arndb.de>
In-Reply-To: <1365638712-1028578-13-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, April 11, 2013 9:05 AM, Arnd Bergmann wrote:
> 
> In multiplatform configurations, we cannot include headers
> provided by only the exynos platform. Fortunately a number
> of drivers that include those headers do not actually need
> them, so we can just remove the inclusions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Jingoo Han <jg1.han@samsung.com>

CC'ed Tomi Valkeinen, Inki Dae, Donghwa Lee, Kyungmin Park


Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/exynos/exynos_mipi_dsi.c          | 2 --
>  drivers/video/exynos/exynos_mipi_dsi_common.c   | 2 --
>  drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 2 --
>  3 files changed, 6 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index fac7df6..3dd43ca 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -35,8 +35,6 @@
> 
>  #include <video/exynos_mipi_dsim.h>
> 
> -#include <plat/fb.h>
> -
>  #include "exynos_mipi_dsi_common.h"
>  #include "exynos_mipi_dsi_lowlevel.h"
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
> b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index c70cb89..520fc9b 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -31,8 +31,6 @@
>  #include <video/mipi_display.h>
>  #include <video/exynos_mipi_dsim.h>
> 
> -#include <mach/map.h>
> -
>  #include "exynos_mipi_dsi_regs.h"
>  #include "exynos_mipi_dsi_lowlevel.h"
>  #include "exynos_mipi_dsi_common.h"
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> index 95cb99a..15c5abd 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> @@ -26,8 +26,6 @@
> 
>  #include <video/exynos_mipi_dsim.h>
> 
> -#include <mach/map.h>
> -
>  #include "exynos_mipi_dsi_regs.h"
> 
>  void exynos_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
> --
> 1.8.1.2


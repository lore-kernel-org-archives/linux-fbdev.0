From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 02 Jul 2013 12:30:31 +0000
Subject: RE: [PATCH] video: exynos: Ensure definitions match prototypes
Message-Id: <008b01ce771f$f15082c0$d3f18840$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372764414-9102-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1372764414-9102-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Tuesday, July 02, 2013 8:27 PM
> To: Tomi Valkeinen; Jingoo Han
> Cc: linux-fbdev@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> linaro-kernel@lists.linaro.org; Mark Brown
> Subject: [PATCH] video: exynos: Ensure definitions match prototypes
> 
> From: Mark Brown <broonie@linaro.org>
> 
> Ensure that the definitions of functions match the prototypes used by
> other modules by including the header with the prototypes in the files
> with the definitions.
> 

Is there some functions being used by other modules? And what problem can be
incurred without this patch?

Thanks,
Inki Dae

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> index 15c5abd..c148d06 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
> @@ -27,6 +27,7 @@
>  #include <video/exynos_mipi_dsim.h>
> 
>  #include "exynos_mipi_dsi_regs.h"
> +#include "exynos_mipi_dsi_lowlevel.h"
> 
>  void exynos_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
>  {
> --
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


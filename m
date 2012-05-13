From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:51:29 +0000
Subject: Re: [PATCH v2] video: exynos_dp: remove unnecessary header includes
Message-Id: <4FB01ED1.2040402@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <004d01cd29be$b79eb8d0$26dc2a70$%han@samsung.com>
In-Reply-To: <004d01cd29be$b79eb8d0$26dc2a70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/04/2012 06:25 AM, Jingoo Han wrote:
> Remove unnecessary headers from the file.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_core.c |    2 --
>  drivers/video/exynos/exynos_dp_reg.c  |    2 --
>  2 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 6e9f3ce..ef4d1ab 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -21,8 +21,6 @@
>  
>  #include <video/exynos_dp.h>
>  
> -#include <plat/cpu.h>
> -
>  #include "exynos_dp_core.h"
>  
>  static int exynos_dp_init_dp(struct exynos_dp_device *dp)
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 3863726..99bafb8 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -16,8 +16,6 @@
>  
>  #include <video/exynos_dp.h>
>  
> -#include <plat/cpu.h>
> -
>  #include "exynos_dp_core.h"
>  #include "exynos_dp_reg.h"
>  


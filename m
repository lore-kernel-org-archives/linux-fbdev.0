From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 02:20:35 +0000
Subject: RE: [PATCH V2 4/5] driver: Include the modified FIMD header file
Message-Id: <02f601cd6f8c$3c9b55d0$b5d20170$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-5-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Leela Krishna Amudala wrote:
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

[...]

> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -26,7 +26,7 @@
>  #include <linux/pm_runtime.h>
> 
>  #include <mach/map.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
>  #include <plat/fb.h>
> 
See my previous comments.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


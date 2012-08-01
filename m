From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 02:19:27 +0000
Subject: RE: [PATCH V2 3/5] arm: samsung: Include the modified FIMD header file
Message-Id: <02f301cd6f8c$137016f0$3a5044d0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-4-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-4-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Leela Krishna Amudala wrote:
> 
> The fimd register headers have been moved to include/video/
> hence, modifying the machine files accordingly.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-nuri.c           |    2 +-
>  arch/arm/mach-exynos/mach-origen.c         |    2 +-
>  arch/arm/mach-exynos/mach-smdk4x12.c       |    2 +-
>  arch/arm/mach-exynos/mach-smdkv310.c       |    2 +-
>  arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
>  arch/arm/mach-exynos/setup-fimd0.c         |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c      |    2 +-
>  arch/arm/mach-s3c64xx/mach-anw6410.c       |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c      |    2 +-
>  arch/arm/mach-s3c64xx/mach-hmt.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-mini6410.c      |    2 +-
>  arch/arm/mach-s3c64xx/mach-ncp.c           |    2 +-
>  arch/arm/mach-s3c64xx/mach-real6410.c      |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq5.c       |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq7.c       |    2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c      |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6440.c      |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6450.c      |    2 +-
>  arch/arm/mach-s5pc100/mach-smdkc100.c      |    2 +-
>  arch/arm/mach-s5pv210/mach-aquila.c        |    2 +-
>  arch/arm/mach-s5pv210/mach-goni.c          |    2 +-
>  arch/arm/mach-s5pv210/mach-smdkv210.c      |    2 +-
>  22 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-
> nuri.c
> index f98a83a..573a0c4 100644
> --- a/arch/arm/mach-exynos/mach-nuri.c
> +++ b/arch/arm/mach-exynos/mach-nuri.c
> @@ -39,7 +39,7 @@
>  #include <asm/mach-types.h>
> 
>  #include <plat/adc.h>
> -#include <plat/regs-fb-v4.h>
> +#include <video/samsung_fimd.h>
>  #include <plat/regs-serial.h>
>  #include <plat/cpu.h>
>  #include <plat/devs.h>

NO! Don't just replace it. Please put the inclusions with the same kind like
following.

diff --git a/arch/arm/mach-exynos/mach-nuri.c
b/arch/arm/mach-exynos/mach-nuri.c
index ea785fc..90d8daa 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -29,6 +29,7 @@
 #include <drm/exynos_drm.h>

 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 #include <media/m5mols.h>
 #include <media/s5k6aa.h>
 #include <media/s5p_fimc.h>
@@ -39,7 +40,6 @@
 #include <asm/mach-types.h>

 #include <plat/adc.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/regs-serial.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


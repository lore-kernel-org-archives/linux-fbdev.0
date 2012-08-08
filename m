From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 08 Aug 2012 06:20:16 +0000
Subject: RE: [PATCH V4 0/2] arm: samsung: Move FIMD headers to include/video/
Message-Id: <0ab701cd752d$e0d1db00$a2759100$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, m.szyprowski@samsung.com, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>

Leela Krishna Amudala wrote:
> 
> This patchset moves the contents of regs-fb-v4.h and regs-fb.h from arch
> side
> to include/video/samsung_fimd.h
> 
> This patchset is created and rebased against master branch of torvalds
> tree.
> Tested on smdk5250 board, build tested for other boards.
> 
> Changes from version 3:
> 	- Squashed 1st, 3rd, 4th and 5th patches from version 3
> 
> Changes from version 2:
> 	- Changed the EXYNOS5_xxx macro name to FIMD_V8_xxx
> 	- Moved the header inclusion under same kind
> 
> Changes from version 1:
> 	- Split the patches as per Sylwester comments
> 	- Changed FIMD_V8_xxx macro to EXYNOS5_xxx
> 
> Leela Krishna Amudala (2):
>   include/video: move fimd register headers from platform to
>     include/video
>   include/video: Add register offsets for FIMD version 8
> 
>  arch/arm/mach-exynos/mach-nuri.c                   |    2 +-
>  arch/arm/mach-exynos/mach-origen.c                 |    2 +-
>  arch/arm/mach-exynos/mach-smdk4x12.c               |    2 +-
>  arch/arm/mach-exynos/mach-smdkv310.c               |    2 +-
>  arch/arm/mach-exynos/mach-universal_c210.c         |    2 +-
>  arch/arm/mach-exynos/setup-fimd0.c                 |    2 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
>  arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
>  arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
>  arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
>  arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
>  arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
>  arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
>  arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +-
>  arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
>  arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159
----------------
> ----
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
>  drivers/video/s3c-fb.c                             |    2 +-
>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  152
> +++++++++++++++++--
>  26 files changed, 165 insertions(+), 194 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>  rename arch/arm/plat-samsung/include/plat/regs-fb.h =>
> include/video/samsung_fimd.h (73%)

Looks OK to me. Will apply into topic branch, 'v3.7-for-florian' for
Florian's pulling.

If there is no objection for a couple of days, I will merge this into
for-next and send to Florian.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


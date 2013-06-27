From: Kukjin Kim <kgene.kim@samsung.com>
Date: Thu, 27 Jun 2013 09:34:09 +0000
Subject: RE: [PATCH v3 5/5] ARM: Samsung: Remove the MIPI PHY setup code
Message-Id: <085701ce7319$79b191a0$6d14b4e0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372258946-15607-1-git-send-email-s.nawrocki@samsung.com>
 <1372258946-15607-6-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1372258946-15607-6-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
> DPHYs so we can remove now unused code at arch/arm/plat-samsung.
> In case there is any board file for S5PV210 platforms using MIPI
> CSIS/DSIM (not any upstream currently) it should use the generic
> PHY API to bind the PHYs to respective PHY consumer drivers and
> a platform device for the PHY provider should be defined.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h    |    5 --
>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    4 --
>  arch/arm/plat-samsung/Kconfig                   |    5 --
>  arch/arm/plat-samsung/Makefile                  |    1 -
>  arch/arm/plat-samsung/setup-mipiphy.c           |   60
---------------------
> --
>  5 files changed, 75 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/setup-mipiphy.c
> 
Looks good, please feel free to add my ack on this,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
- Kukjin


From: Kukjin Kim <kgene.kim@samsung.com>
Date: Mon, 18 Jul 2011 01:25:43 +0000
Subject: RE: [PATCH V7 2/5] ARM: EXYNOS4: Add FIMD resource definition
Message-Id: <047301cc44e9$a1004540$e300cfc0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309171837-30299-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1309171837-30299-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jonghun Han' <jonghun.han@samsung.com>
Cc: 'Thomas Abraham' <thomas.ab@samsung.com>

Jingoo Han wrote:
> 
> From: Jonghun Han <jonghun.han@samsung.com>
> 
> This patch adds resource definitions for EXYNOS4 FIMD.
> IRQ and SFR definitions are added.
> 
> Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos4/include/mach/irqs.h |    8 ++++++++
>  arch/arm/mach-exynos4/include/mach/map.h  |    5 +++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
> exynos4/include/mach/irqs.h
> index 5d03730..2cd2090 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -73,6 +73,14 @@
>  #define IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
>  #define IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
> 
> +#define IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
> +#define IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
> +#define IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
> +
> +#define IRQ_FIMD1_FIFO		COMBINER_IRQ(12, 0)
> +#define IRQ_FIMD1_VSYNC		COMBINER_IRQ(12, 1)
> +#define IRQ_FIMD1_SYSTEM	COMBINER_IRQ(12, 2)
> +
>  #define IRQ_PDMA0		COMBINER_IRQ(21, 0)
>  #define IRQ_PDMA1		COMBINER_IRQ(21, 1)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-
> exynos4/include/mach/map.h
> index 0009e77..94006f7 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -93,6 +93,9 @@
>  #define EXYNOS4_PA_MIPI_CSIS0		0x11880000
>  #define EXYNOS4_PA_MIPI_CSIS1		0x11890000
> 
> +#define EXYNOS4_PA_FIMD0		0x11C00000
> +#define EXYNOS4_PA_FIMD1		0x12000000
> +
>  #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
> 
>  #define EXYNOS4_PA_SATA			0x12560000
> @@ -140,6 +143,8 @@
>  #define S5P_PA_FIMC3			EXYNOS4_PA_FIMC3
>  #define S5P_PA_MIPI_CSIS0		EXYNOS4_PA_MIPI_CSIS0
>  #define S5P_PA_MIPI_CSIS1		EXYNOS4_PA_MIPI_CSIS1
> +#define S5P_PA_FIMD0			EXYNOS4_PA_FIMD0
> +#define S5P_PA_FIMD1			EXYNOS4_PA_FIMD1
>  #define S5P_PA_ONENAND			EXYNOS4_PA_ONENAND
>  #define S5P_PA_ONENAND_DMA
> 	EXYNOS4_PA_ONENAND_DMA
>  #define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
> --
> 1.7.1

Firstly, needs to update based on latest my for-next.

Secondly, do you think we really need to define regarding FIMD1 even though
I couldn't find it in your patch?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


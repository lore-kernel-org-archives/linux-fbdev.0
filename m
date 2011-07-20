From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 20 Jul 2011 22:54:09 +0000
Subject: [PATCH V8 2/5] ARM: EXYNOS4: Add resource definition for FIMD
Message-Id: <1311202449-18169-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Jonghun Han <jonghun.han@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Jingoo Han <jg1.han@samsung.com>

From: Jonghun Han <jonghun.han@samsung.com>

This patch adds resource definitions for EXYNOS4 FIMD.
IRQ and SFR definitions are added.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/irqs.h |    4 ++++
 arch/arm/mach-exynos4/include/mach/map.h  |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 250427f..0d315a9 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -137,6 +137,10 @@
 #define IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
 #define IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
 
+#define IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
+#define IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
+#define IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
+
 #define MAX_COMBINER_NR		16
 
 #define S5P_IRQ_EINT_BASE	COMBINER_IRQ(MAX_COMBINER_NR, 0)
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 3677356..2a5a6f6 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -95,6 +95,8 @@
 #define EXYNOS4_PA_MIPI_CSIS0		0x11880000
 #define EXYNOS4_PA_MIPI_CSIS1		0x11890000
 
+#define EXYNOS4_PA_FIMD0		0x11C00000
+
 #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 
 #define EXYNOS4_PA_SATA			0x12560000
@@ -142,6 +144,7 @@
 #define S5P_PA_FIMC3			EXYNOS4_PA_FIMC3
 #define S5P_PA_MIPI_CSIS0		EXYNOS4_PA_MIPI_CSIS0
 #define S5P_PA_MIPI_CSIS1		EXYNOS4_PA_MIPI_CSIS1
+#define S5P_PA_FIMD0			EXYNOS4_PA_FIMD0
 #define S5P_PA_ONENAND			EXYNOS4_PA_ONENAND
 #define S5P_PA_ONENAND_DMA		EXYNOS4_PA_ONENAND_DMA
 #define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
-- 
1.7.1


From: Sangbeom Kim <sbkim73@samsung.com>
Date: Mon, 18 Oct 2010 12:55:25 +0000
Subject: [PATCH 1/4] ARM: S5PV310: Add FIMD resource definition
Message-Id: <1287406528-15324-2-git-send-email-sbkim73@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jonghun Han <jonghun.han@samsung.com>

This patch adds resource definitions for S5PV310 FIMD.
IRQ and SFR definitions are added.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |    8 ++++++++
 arch/arm/mach-s5pv310/include/mach/map.h  |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index fa7a8a3..16a910d 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -54,6 +54,14 @@
 #define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(64))
 #define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
 
+#define IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
+#define IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
+#define IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
+
+#define IRQ_FIMD1_FIFO		COMBINER_IRQ(12, 0)
+#define IRQ_FIMD1_VSYNC		COMBINER_IRQ(12, 1)
+#define IRQ_FIMD1_SYSTEM	COMBINER_IRQ(12, 2)
+
 #define IRQ_TIMER0_VIC		COMBINER_IRQ(22, 0)
 #define IRQ_TIMER1_VIC		COMBINER_IRQ(22, 1)
 #define IRQ_TIMER2_VIC		COMBINER_IRQ(22, 2)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 1429510..65fe077 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -56,6 +56,9 @@
 #define S5PV310_PA_GPIO2		(0x11000000)
 #define S5PV310_PA_GPIO3		(0x03860000)
 
+#define S5PV310_PA_FIMD0		(0x11C00000)
+#define S5PV310_PA_FIMD1		(0x12000000)
+
 #define S5PV310_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 
 #define S5PV310_PA_UART			(0x13800000)
@@ -78,6 +81,8 @@
 #define S5P_PA_SDRAM			S5PV310_PA_SDRAM
 
 /* compatibiltiy defines. */
+#define S5P_PA_FIMD0			S5PV310_PA_FIMD0
+#define S5P_PA_FIMD1			S5PV310_PA_FIMD1
 #define S3C_PA_UART			S5PV310_PA_UART
 #define S3C_PA_HSMMC0			S5PV310_PA_HSMMC(0)
 #define S3C_PA_HSMMC1			S5PV310_PA_HSMMC(1)
-- 
1.6.2.5


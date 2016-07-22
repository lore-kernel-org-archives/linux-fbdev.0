From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Fri, 22 Jul 2016 14:22:13 +0000
Subject: [PATCH] ARM: no need to select SMP_ON_UP explicitly
Message-Id: <1469197333-24871-1-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SMP_ON_UP is already defaulted to "y" and has all dependencies expressed
- no need to select it per platform level

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mach-imx/Kconfig      |    3 ---
 arch/arm/mach-realview/Kconfig |    1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index dd905b9..cfb1120 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -92,7 +92,6 @@ config SOC_IMX31
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
-	select SMP_ON_UP if SMP
 
 config SOC_IMX35
 	bool
@@ -100,7 +99,6 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select MXC_AVIC
 	select PINCTRL_IMX35
-	select SMP_ON_UP if SMP
 
 if ARCH_MULTI_V4T
 
@@ -589,7 +587,6 @@ config SOC_VF610
 	select ARM_GIC if ARCH_MULTI_V7
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
-	select SMP_ON_UP if SMP
 
 	help
 	  This enables support for Freescale Vybrid VF610 processor.
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 70ab4a2..739800e 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -24,7 +24,6 @@ config REALVIEW_DT
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
-	select SMP_ON_UP if SMP
 	select SOC_REALVIEW
 	select USE_OF
 	help
-- 
1.7.9.5


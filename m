From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 21 Dec 2013 07:58:23 +0000
Subject: [PATCH] ARM: i.MX: Remove IMX_HAVE_PLATFORM_IMX_FB symbol
Message-Id: <1387612703-18512-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Symbol IMX_HAVE_PLATFORM_IMX_FB is selected by boards which
use it, so there is no way to compile the FB driver only with
DT configuration. This patch removes this dependency completely.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/Kconfig          | 10 ----------
 arch/arm/mach-imx/devices/Kconfig  |  3 ---
 arch/arm/mach-imx/devices/Makefile |  3 +--
 drivers/video/Kconfig              |  2 +-
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d511e054..9498878 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -179,7 +179,6 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -196,7 +195,6 @@ config MACH_MX25_3DS
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -211,7 +209,6 @@ config MACH_EUKREA_CPUIMX25SD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -248,7 +245,6 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -281,7 +277,6 @@ choice
 
 config MACH_PCM970_BASEBOARD
 	bool "PHYTEC PCM970 development board"
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  This adds board specific devices that can be found on Phytec's
@@ -326,7 +321,6 @@ choice
 
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	bool "Eukrea MBIMX27 development board"
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -343,7 +337,6 @@ config MACH_MX27_3DS
 	bool "MX27PDK platform"
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_SSI
@@ -389,7 +382,6 @@ config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -406,7 +398,6 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -633,7 +624,6 @@ config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 68c74fb..99951a6 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -25,9 +25,6 @@ config IMX_HAVE_PLATFORM_IMX2_WDT
 config IMX_HAVE_PLATFORM_IMXDI_RTC
 	bool
 
-config IMX_HAVE_PLATFORM_IMX_FB
-	bool
-
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
diff --git a/arch/arm/mach-imx/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
index 67416fb..ba2642d 100644
--- a/arch/arm/mach-imx/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -9,8 +9,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX27_CODA) += platform-imx27-coda.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
-obj-y += platform-imx-dma.o
-obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
+obj-y += platform-imx-dma.o platform-imx-fb.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD) += platform-imx-keypad.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_PATA_IMX) += platform-pata_imx.o
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4f2e1b3..e7d8d88 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -363,7 +363,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	depends on FB && (SOC_IMX1 || SOC_IMX21 || SOC_IMX25 || SOC_IMX27)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.8.3.2


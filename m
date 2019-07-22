From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jul 2019 13:44:15 +0000
Subject: [PATCH v2 1/9] ARM: davinci: refresh davinci_all_defconfig
Message-Id: <20190722134423.26555-2-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722134423.26555-1-brgl@bgdev.pl>
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Refresh davinci_all_defconfig with current master.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9a32a8c0f873..7c2a39305f2b 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -10,13 +10,6 @@ CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DM644x=y
 CONFIG_ARCH_DAVINCI_DM355=y
@@ -31,9 +24,7 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -47,6 +38,12 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPUFREQ_DT=m
 CONFIG_CPU_IDLE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -64,7 +61,6 @@ CONFIG_BT_HCIUART_LL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER=m
-CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
@@ -168,8 +164,6 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_SOC_TLV320AIC3X=m
-CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_DAVINCI_EVM=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
@@ -214,14 +208,12 @@ CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_GPIO=m
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
-CONFIG_TI_EDMA=y
 CONFIG_COMMON_CLK_PWM=m
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
@@ -259,10 +251,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_T10DIF=m
+CONFIG_DMA_CMA=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=m
-- 
2.21.0

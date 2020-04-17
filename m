From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:47 +0000
Subject: [PATCH 2/8] fbdev/ARM: pxa: avoid selecting CONFIG_FB
Message-Id: <20200417155553.675905-3-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

In order to add more compile-time dependencies to CONFIG_FB, remove the
last few instances of selecting it from platform code.

This was originally written to allow a modular driver, but that never
worked because vmlinux cannot call exported functions from a loadable
module.

Just change the #ifdef check to what it should have been and remove
the 'select' statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig | 1 +
 arch/arm/mach-pxa/Kconfig      | 4 ----
 arch/arm/mach-pxa/saar.c       | 2 +-
 arch/arm/mach-pxa/tavorevb.c   | 2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 8df88e8a3048..3931184e2eb1 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -455,6 +455,7 @@ CONFIG_SOC_CAMERA_MT9M111=m
 CONFIG_DRM=m
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
+CONFIG_FB_PXA=y
 CONFIG_FB_W100=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_PXA_OVERLAY=y
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8444d40df1b3..bea8ce447ed3 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -76,16 +76,12 @@ config MACH_TAVOREVB
 	select CPU_PXA930
 	select CPU_PXA935
 	select PXA3xx
-	select FB
-	select FB_PXA
 
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select CPU_PXA930
 	select CPU_PXA935
 	select PXA3xx
-	select FB
-	select FB_PXA
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 3275b679792b..e35d6c57f73e 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -113,7 +113,7 @@ static struct platform_device smc91x_device = {
 	},
 };
 
-#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+#if defined(CONFIG_FB_PXA)
 static uint16_t lcd_power_on[] = {
 	/* single frame */
 	SMART_CMD_NOOP,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index a15eb3b9484d..dda5f10b1883 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -165,7 +165,7 @@ static void __init tavorevb_init_keypad(void)
 static inline void tavorevb_init_keypad(void) {}
 #endif /* CONFIG_KEYBOARD_PXA27x || CONFIG_KEYBOARD_PXA27x_MODULE */
 
-#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+#if defined(CONFIG_FB_PXA)
 static struct pwm_lookup tavorevb_pwm_lookup[] = {
 	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 100000,
 		   PWM_POLARITY_NORMAL),
-- 
2.26.0

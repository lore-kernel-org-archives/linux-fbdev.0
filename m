From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Jan 2015 20:12:33 +0000
Subject: [PATCH] fb: via: turn gpiolib and i2c selects into dependencies
Message-Id: <3127720.VGEDzudcPs@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Device driver should not directly select subsystems. In this case
we get build warnings like

warning: (ARCH_REQUIRE_GPIOLIB && PINCTRL_AT91 && PINCTRL_NOMADIK && MFD_TC6393XB && FB_VIA) selects GPIOLIB which has unmet direct dependencies (ARCH_WANT_OPTIONAL_GPIOLIB || ARCH_REQUIRE_GPIOLIB)

which we can avoid using the normal 'depends on' statement.

Also, this patch makes it possible for DRM drivers to have a dependency
on GPIOLIB without getting circular Kconfig dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f2c3fb7d0399..b3dd417b4719 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1530,13 +1530,11 @@ config FB_SIS_315
 
 config FB_VIA
        tristate "VIA UniChrome (Pro) and Chrome9 display support"
-       depends on FB && PCI && X86
+       depends on FB && PCI && X86 && GPIOLIB && I2C
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT
        select I2C_ALGOBIT
-       select I2C
-       select GPIOLIB
        help
 	  This is the frame buffer device driver for Graphics chips of VIA
 	  UniChrome (Pro) Family (CLE266,PM800/CN400,P4M800CE/P4M800Pro/


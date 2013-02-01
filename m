From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 01 Feb 2013 09:20:48 +0000
Subject: [PATCH v6 6/8] ARM: mmp: added device for display controller
Message-Id: <1359710448-9996-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

added device for display controller and fb support

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/include/mach/pxa910.h |    5 ++++-
 arch/arm/mach-mmp/pxa910.c              |    3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 3b58a3b..b4c94d8 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -10,6 +10,7 @@ extern void __init pxa910_init_irq(void);
 #include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
+#include <video/mmp_disp.h>
 
 extern struct pxa_device_desc pxa910_device_uart1;
 extern struct pxa_device_desc pxa910_device_uart2;
@@ -23,7 +24,9 @@ extern struct pxa_device_desc pxa910_device_nand;
 extern struct platform_device pxa168_device_u2o;
 extern struct platform_device pxa168_device_u2ootg;
 extern struct platform_device pxa168_device_u2oehci;
-
+extern struct pxa_device_desc pxa910_device_disp;
+extern struct pxa_device_desc pxa910_device_fb;
+extern struct pxa_device_desc pxa910_device_panel;
 extern struct platform_device pxa910_device_gpio;
 extern struct platform_device pxa910_device_rtc;
 
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 8b1e16f..e49cdd9 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -138,6 +138,9 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+PXA910_DEVICE(disp, "mmp-disp", 0, LCD, 0xd420b000, 0x1ec);
+PXA910_DEVICE(fb, "mmp-fb", -1, NONE, 0, 0);
+PXA910_DEVICE(panel, "tpo-hvga", -1, NONE, 0, 0);
 
 struct resource pxa910_resource_gpio[] = {
 	{
-- 
1.7.9.5


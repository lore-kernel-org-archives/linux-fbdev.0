From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 01 Feb 2013 09:21:09 +0000
Subject: [PATCH v6 8/8] ARM: mmp: add display and fb support in pxa910 defconfig
Message-Id: <1359710469-10299-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

added display and fb support in pxa910 defconfig.
added tpohvga panel, spi support.
added logo support.

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/configs/pxa910_defconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 191118c..3bb7771 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -42,6 +42,14 @@ CONFIG_SMC91X=y
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_FB=y
+CONFIG_MMP_DISP=y
+CONFIG_MMP_DISP_CONTROLLER=y
+CONFIG_MMP_SPI=y
+CONFIG_MMP_PANEL_TPOHVGA=y
+CONFIG_MMP_FB=y
+CONFIG_LOGO=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-- 
1.7.9.5


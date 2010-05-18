From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 18 May 2010 12:35:09 +0000
Subject: [PATCH 18/23] OMAP: RX51: Update board defconfig
Message-Id: <1274186114-26951-19-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Roger Quadros <roger.quadros@nokia.com>

Add LCD, Boot-up logo, framebuffer console, Keypad
and Power button support

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/configs/rx51_defconfig |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 473f9e1..56d4928 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -784,6 +784,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_GPIO=m
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
@@ -809,6 +810,7 @@ CONFIG_INPUT_MISC=y
 # CONFIG_INPUT_POWERMATE is not set
 # CONFIG_INPUT_YEALINK is not set
 # CONFIG_INPUT_CM109 is not set
+CONFIG_INPUT_TWL4030_PWRBUTTON=y
 CONFIG_INPUT_UINPUT=m
 
 #
@@ -1110,7 +1112,40 @@ CONFIG_RADIO_ADAPTERS=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+
+# Frame buffer hardware drivers
+#
+CONFIG_OMAP2_VRAM=y
+CONFIG_OMAP2_VRFB=y
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=0
+# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
+# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
+# CONFIG_OMAP2_DSS_DPI is not set
+# CONFIG_OMAP2_DSS_RFBI is not set
+# CONFIG_OMAP2_DSS_VENC is not set
+CONFIG_OMAP2_DSS_SDI=y
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+CONFIG_FB_OMAP2_NUM_FBS=3
+
+#
+# OMAP2/3 Display Device Drivers
+#
+# CONFIG_PANEL_GENERIC is not set
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+# CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
+# CONFIG_PANEL_TOPPOLY_TDO35S is not set
+# CONFIG_PANEL_TPO_TD043MTEA1 is not set
+CONFIG_PANEL_ACX565AKM=y
+
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -1127,6 +1162,8 @@ CONFIG_DISPLAY_SUPPORT=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
 CONFIG_SOUND=y
 # CONFIG_SOUND_OSS_CORE is not set
 CONFIG_SND=y
-- 
1.7.0.4


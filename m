From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Oct 2014 18:28:55 +0000
Subject: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux data
Message-Id: <1413311335-25083-3-git-send-email-balbi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
In-Reply-To: <1413311335-25083-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Caused by a copy & paste error. Note that even with
this bug AM437x SK display still works because GPIO
mux mode is always enabled. It's still wrong to mux
somebody else's pin.

Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
isn't used for anything.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d..681be00 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -320,8 +320,7 @@
 
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
-			/* GPIO 5_8 to select LCD / HDMI */
-			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
 		>;
 	};
 };
-- 
2.1.0.GIT


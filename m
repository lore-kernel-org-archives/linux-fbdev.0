From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:34:43 +0000
Subject: [PATCH 4/7] OMAPDSS: remove wrong HDMI HPD muxing
Message-Id: <1330605286-24166-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

"hdmi_hpd" pin is muxed to INPUT and PULLUP, but the pin is not
currently used, and in the future when it is used, the pin is used as a
GPIO and is board specific, not an OMAP4 wide thing.

So remove the muxing for now.

Backported from 7bb122d155f742fe2d79849090c825be7b4a247e

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    4 ----
 arch/arm/mach-omap2/board-omap4panda.c |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index d0a49c3..9bc418e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -578,12 +578,8 @@ static void __init omap_sfh7741prox_init(void)
 
 static void sdp4430_hdmi_mux_init(void)
 {
-	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
-	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_cec",
 			OMAP_PIN_INPUT_PULLUP);
-	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
 	omap_mux_init_signal("hdmi_ddc_scl",
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bc98749..86a2d30 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -614,12 +614,8 @@ int __init omap4_panda_dvi_init(void)
 
 static void omap4_panda_hdmi_mux_init(void)
 {
-	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
-	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_cec",
 			OMAP_PIN_INPUT_PULLUP);
-	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
 	omap_mux_init_signal("hdmi_ddc_scl",
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
-- 
1.7.4.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 17 Jan 2012 12:48:59 +0000
Subject: [PATCH 3/6] OMAPDSS: remove wrong HDMI HPD muxing
Message-Id: <1326804542-22285-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

"hdmi_hpd" pin is muxed to INPUT and PULLUP, but the pin is not
currently used, and in the future when it is used, the pin is used as a
GPIO and is board specific, not an OMAP4 wide thing.

So remove the muxing for now.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ffd9bd9..d6e65e2 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -102,12 +102,8 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 	u32 reg;
 	u16 control_i2c_1;
 
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


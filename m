From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:26:32 +0000
Subject: [PATCH 4/7] OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
Message-Id: <1330604795-29156-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The HDMI GPIO pins LS_OE and CT_CP_HPD are not currently configured.
This patch configures them as output pins.

Backported from 78a1ad8f12db70b8b0a4548b90704de08ee216ce

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 385c1fd..7bcafb9 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -824,6 +824,9 @@ static void omap_4430sdp_display_init(void)
 	sdp4430_hdmi_mux_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e0d0abc..27fc162 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -541,6 +541,9 @@ void omap4_panda_display_init(void)
 
 	omap4_panda_hdmi_mux_init();
 	omap_display_init(&omap4_panda_dss_data);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1


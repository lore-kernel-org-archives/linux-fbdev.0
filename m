From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 17 Jan 2012 12:49:00 +0000
Subject: [PATCH 4/6] OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
Message-Id: <1326804542-22285-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The HDMI GPIO pins LS_OE and CT_CP_HPD are not currently configured.
This patch configures them as output pins.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ae0c09f..5dcc8df 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -833,6 +833,9 @@ static void omap_4430sdp_display_init(void)
 		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
 	else
 		omap_hdmi_init(0);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 133b5a7..06a7075 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -549,6 +549,9 @@ void omap4_panda_display_init(void)
 		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
 	else
 		omap_hdmi_init(0);
+
+	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 }
 
 static void __init omap4_panda_init(void)
-- 
1.7.4.1


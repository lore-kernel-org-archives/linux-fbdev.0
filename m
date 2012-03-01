From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:26:29 +0000
Subject: [PATCH 1/7] OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
Message-Id: <1330604795-29156-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of freeing the GPIOs individually, use gpio_free_array().

Backported from 575753e3bea3b67eef8e454fb87f719e3f7da599

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +--
 arch/arm/mach-omap2/board-omap4panda.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5156468..8434b0c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -628,8 +628,7 @@ static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
 }
 
 static struct nokia_dsi_panel_data dsi1_panel = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a8c2c42..1ac7a22 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -512,8 +512,7 @@ static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
 }
 
 static struct omap_dss_device  omap4_panda_hdmi_device = {
-- 
1.7.4.1


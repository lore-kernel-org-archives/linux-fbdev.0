From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 31 Aug 2016 08:18:14 +0000
Subject: [PATCH 3/6] drm/panel: simple: Add A10 EVB 5 inch panel support
Message-Id: <20160831081817.5191-4-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
In-Reply-To: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, Alexander Kaplan <alex@nextthing.co>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org

The A10-EVB from Allwinner comes with an unidentified panel, with the only
mark on the PCB being A10-SUB-EVB-5LCD.

Add timings to simple panel to handle it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 85143d1b9b31..be371b053aab 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -386,6 +386,29 @@ static void panel_simple_shutdown(struct device *dev)
 	panel_simple_disable(&panel->base);
 }
 
+static const struct drm_display_mode allwinner_a10_sub_evb_5lcd_mode = {
+	.clock = 33000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 209,
+	.hsync_end = 800 + 209 + 1,
+	.htotal = 800 + 209 + 1 + 45,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 1,
+	.vtotal = 480 + 22 + 1 + 22,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc allwinner_a10_sub_evb_5lcd = {
+	.modes = &allwinner_a10_sub_evb_5lcd_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 110,
+		.height = 67,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode ampire_am800480r3tmqwa1h_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -1515,6 +1538,9 @@ static const struct panel_desc urt_umsh_8596md_parallel = {
 
 static const struct of_device_id platform_of_match[] = {
 	{
+		.compatible = "allwinner,sun4i-a10-sub-evb-5-lcd",
+		.data = &allwinner_a10_sub_evb_5lcd,
+	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
 	}, {
-- 
2.9.2


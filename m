From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Sep 2011 09:13:37 +0000
Subject: [PATCHv2 14/15] OMAP: Panda, Beagle, Overo: DVI: Add i2c_bus_num
Message-Id: <1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c bus number for DVI output. The driver uses this to detect if a
panel is connected and to read EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/board-overo.c       |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 26bc860..742ac45 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -206,6 +206,7 @@ static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c35384e..a38ed273 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -458,6 +458,7 @@ static void omap4_panda_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data omap4_dvi_panel = {
 	.platform_enable	= omap4_panda_enable_dvi,
 	.platform_disable	= omap4_panda_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 struct omap_dss_device omap4_panda_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 06064d5..da94376 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -186,6 +186,7 @@ static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
 static struct panel_dvi_platform_data dvi_panel = {
 	.platform_enable	= overo_panel_enable_dvi,
 	.platform_disable	= overo_panel_disable_dvi,
+	.i2c_bus_num		= 3,
 };
 
 static struct omap_dss_device overo_dvi_device = {
-- 
1.7.4.1


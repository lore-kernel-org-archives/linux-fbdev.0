From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Aug 2011 13:23:22 +0000
Subject: [PATCH 11/12] OMAP: Panda & Beagle: DVI: Add i2c_bus_num
Message-Id: <1314797003-17638-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c bus number for DVI output. The driver uses this to detect if a
panel is connected and to read EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..13244e9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -207,6 +207,7 @@ static struct panel_generic_dpi_data dvi_panel = {
 	.name = "generic",
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..d5760e3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -459,6 +459,7 @@ static struct panel_generic_dpi_data omap4_dvi_panel = {
 	.name			= "generic",
 	.platform_enable	= omap4_panda_enable_dvi,
 	.platform_disable	= omap4_panda_disable_dvi,
+	.i2c_bus_num = 3,
 };
 
 struct omap_dss_device omap4_panda_dvi_device = {
-- 
1.7.4.1


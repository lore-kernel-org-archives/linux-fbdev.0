From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Tue, 07 Aug 2012 08:40:59 +0000
Subject: [PATCH 5/6] ARM: OMAP: Disable venc for OMAP4
Message-Id: <e99477f7030c655ef6f560adafcb30a7328f12cb.1343912533.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com>
In-Reply-To: <cover.1343912532.git.cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is a alternative to "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to
prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> to prevent
VENC from crashing OMAP4 kernel. This prevents OMAPDSS from initial registration
of a device for VENC on OMAP4.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 arch/arm/mach-omap2/display.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af1ed7d..ee40739 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -95,7 +95,6 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_core", "omapdss_dss", -1 },
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
-	{ "dss_venc", "omapdss_venc", -1 },
 	{ "dss_dsi1", "omapdss_dsi", 0 },
 	{ "dss_dsi2", "omapdss_dsi", 1 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
-- 
1.7.10


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:45:20 +0000
Subject: [PATCH 3/3] ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi
Message-Id: <1327401920-5617-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hwmod data for OMAP3 does not define sysconfig for DSI. This patch adds
it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 76e6498..c3ab5e4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1547,8 +1547,20 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
  * display serial interface controller
  */
 
+static struct omap_hwmod_class_sysconfig omap3xxx_dsi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
 static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 	.name = "dsi",
+	.sysc = &omap3xxx_dsi_sysc,
 };
 
 static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
-- 
1.7.4.1


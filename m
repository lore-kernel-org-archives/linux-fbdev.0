From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 23 Aug 2012 13:45:09 +0000
Subject: [PATCH 3/8] OMAP4: TWL: add vdda_hdmi_dac regulator supply
Message-Id: <1345729514-2441-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

HDMI requires vdda_hdmi_dac (vdac) power for operation. The regulator,
or the regulator supplying the vdac, has been enabled by default and
things have worked without the HDMI driver enabling the vdac.

I encountered the problem when implementing HDMI device tree support,
where the regulator was not enabled by default.

This patch adds the vdda_hdmi_dac to twl-common.c so that the HDMI
driver can use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/twl-common.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..bf90356 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -257,6 +257,10 @@ static struct twl4030_usb_data omap4_usb_pdata = {
 	.phy_suspend	= omap4430_phy_suspend,
 };
 
+static struct regulator_consumer_supply omap4_vdda_hdmi_dac_supplies[] = {
+	REGULATOR_SUPPLY("vdda_hdmi_dac", "omapdss_hdmi"),
+};
+
 static struct regulator_init_data omap4_vdac_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
@@ -266,6 +270,8 @@ static struct regulator_init_data omap4_vdac_idata = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap4_vdda_hdmi_dac_supplies),
+	.consumer_supplies	= omap4_vdda_hdmi_dac_supplies,
 	.supply_regulator	= "V2V1",
 };
 
-- 
1.7.9.5


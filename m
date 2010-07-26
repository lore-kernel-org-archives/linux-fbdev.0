From: Igor Grinberg <grinberg@compulab.co.il>
Date: Mon, 26 Jul 2010 10:34:28 +0000
Subject: [PATCH 2/2] [ARM] omap: cm-t35: fix video signal on DVI panels
Message-Id: <1280140468-8183-2-git-send-email-grinberg@compulab.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
In-Reply-To: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>

CM-T35 DVI transmitter sampling the data on the raising edge of the
pixel clock, therefore the data strobe should happen on the falling
edge.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..1b636f8 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -384,6 +384,7 @@ static struct omap_dss_device cm_t35_dvi_device = {
 	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
+	.panel.config		= OMAP_DSS_LCD_IPC | OMAP_DSS_LCD_ONOFF,
 	.platform_enable	= cm_t35_panel_enable_dvi,
 	.platform_disable	= cm_t35_panel_disable_dvi,
 };
-- 
1.7.1


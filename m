From: Igor Grinberg <grinberg@compulab.co.il>
Date: Mon, 12 Jul 2010 10:43:49 +0000
Subject: [PATCH] [ARM] omap/board-cm-t35: fix visual artefacts
Message-Id: <1278931429-20018-1-git-send-email-grinberg@compulab.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>

CM-T35 DVI transmitter sampling the data on the raising edge of the
pixel clock, therefore the data strobe should happen on the falling
edge.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..015ebf8 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -349,6 +349,8 @@ static int cm_t35_panel_enable_dvi(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
+	dssdev->panel.config |= OMAP_DSS_LCD_IPC | OMAP_DSS_LCD_ONOFF;
+
 	gpio_set_value(dvi_en_gpio, 0);
 	dvi_enabled = 1;
 
-- 
1.7.1


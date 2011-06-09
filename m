From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:31 +0000
Subject: [PATCHv2 09/28] OMAP: DSS2: Use omap_pm_get_dev_context_loss_count to get ctx loss count
Message-Id: <1307627810-3768-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Initialize get_context_loss_count in the DSS board data to
omap_pm_get_dev_context_loss_count, so that omapdss driver can use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 084a51b..c7e19c4 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -25,6 +25,7 @@
 #include <video/omapdss.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 static struct platform_device omap_display_device = {
 	.name          = "omapdss",
@@ -117,7 +118,8 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	}
 
 	pdata.board_data = board_data;
-	pdata.board_data->get_context_loss_count = NULL;
+	pdata.board_data->get_context_loss_count +		omap_pm_get_dev_context_loss_count;
 	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
-- 
1.7.4.1


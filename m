From: peterhuewe@gmx.de
Date: Tue, 22 Dec 2009 08:34:49 +0000
Subject: [PATCH 08/10] video/omap: add __init/__exit macros to drivers/video/omap/lcd_htcherald.c
Message-Id: <1261470890-24031-1-git-send-email-peterhuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>, Cory Maccarrone <darkstar6262@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

Trivial patch which adds the __init/__exit macros to the module_init/
module_exit functions of

drivers/video/omap/lcd_htcherald.c

Please have a look at the small patch and either pull it through
your tree, or please ack' it so Jiri can pull it through the trivial
tree.

Patch against linux-next-tree, 22. Dez 08:38:18 CET 2009
but also present in linus tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/video/omap/lcd_htcherald.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/lcd_htcherald.c b/drivers/video/omap/lcd_htcherald.c
index a9007c5..4802419 100644
--- a/drivers/video/omap/lcd_htcherald.c
+++ b/drivers/video/omap/lcd_htcherald.c
@@ -115,12 +115,12 @@ struct platform_driver htcherald_panel_driver = {
 	},
 };
 
-static int htcherald_panel_drv_init(void)
+static int __init htcherald_panel_drv_init(void)
 {
 	return platform_driver_register(&htcherald_panel_driver);
 }
 
-static void htcherald_panel_drv_cleanup(void)
+static void __exit htcherald_panel_drv_cleanup(void)
 {
 	platform_driver_unregister(&htcherald_panel_driver);
 }
-- 
1.6.4.4


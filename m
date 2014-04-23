From: Marek Belisko <marek@goldelico.com>
Date: Wed, 23 Apr 2014 20:15:20 +0000
Subject: [PATCH v2 3/3] omapdss: panel-tpo-td028ec1: Add module alias
Message-Id: <1398284120-4986-4-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1398284120-4986-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add module alias string to make it working when panel is compiled as module.
Without this change panel module is not probed thus display is not working.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
index 5b3466e..728808b 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
@@ -505,6 +505,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
+MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
-- 
1.8.3.2


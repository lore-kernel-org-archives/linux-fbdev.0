From: Archit Taneja <archit@ti.com>
Date: Thu, 08 May 2014 09:27:16 +0000
Subject: [RFC 5/6] omapdss: DPI: make dpi_get_channel take DPI reg-id
Message-Id: <1399540517-17883-5-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

To support multiple DPI instances, dpi_get_channel needs to take the DPI
instance's reg-id to get the corresponding channel. Make it take this
argument.

We just pass 0 in the non-DT path, since we don't support multiple instances
in the non-DT case.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index b891e17..faf266e 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -640,7 +640,7 @@ static void dpi_init_pll(struct dpi_data *dpi)
  * the channel in some more dynamic manner, or get the channel as a user
  * parameter.
  */
-static enum omap_channel dpi_get_channel(void)
+static enum omap_channel dpi_get_channel(int reg)
 {
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
@@ -733,7 +733,7 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi.0";
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(0);
 	out->ops.dpi = &dpi_ops;
 	out->owner = THIS_MODULE;
 
@@ -768,7 +768,7 @@ static void dpi_init_output_port(struct platform_device *pdev,
 	out->dev = &pdev->dev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(reg);
 	out->ops.dpi = &dpi_ops;
 	out->reg = reg;
 	out->owner = THIS_MODULE;
-- 
1.8.3.2


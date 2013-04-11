From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 11 Apr 2013 09:35:48 +0000
Subject: [PATCH 2/2] OMAPDSS: DPI: widen the pck search when using dss fck
Message-Id: <1365672948-938-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365672662-612-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1365672662-612-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When not using DSI PLL to generate the pixel clock, but DSS FCK, the
possible pixel clock rates are rather limited. DSS FCK is currently used
on OMAP2 and OMAP3.

When using Beagleboard with a monitor that supports high resolutions,
the clock rates do not match (at least for me) for the monitor's pixel
clocks within the current threshold in the code, which is +/- 1MHz.

This patch widens the search up to +/- 15MHz. The search is done in
steps, i.e. it first tries to find a rather exact clock, than a bit less
exact, etc. so this should not change the cases where a clock was
already found.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index abe1a4e2..e93c4de 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -222,10 +222,10 @@ static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 	 * DSS fck gives us very few possibilities, so finding a good pixel
 	 * clock may not be possible. We try multiple times to find the clock,
 	 * each time widening the pixel clock range we look for, up to
-	 * +/- 1MHz.
+	 * +/- ~15MHz.
 	 */
 
-	for (i = 0; i < 10; ++i) {
+	for (i = 0; i < 25; ++i) {
 		bool ok;
 
 		memset(ctx, 0, sizeof(*ctx));
-- 
1.7.10.4


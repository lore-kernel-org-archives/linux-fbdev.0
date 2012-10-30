From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:10:02 +0000
Subject: [PATCH 05/12] OMAPDSS: DSI: skip odd dividers when pck >= 100MHz
Message-Id: <1351613409-21186-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The DSI PLL and HSDivider can be used to generate the pixel clock for
LCD overlay manager, which then goes to DPI output. On the DPI output
pin the voltage of the signal is shifted from the OMAP's internal
minimal voltage to 1.8V range. The shifting is not instant, and the
higher the clock frequency, the less time there is to shift the signal
to nominal voltage.

If the HSDivider's divider is greater than one and odd, the resulting
pixel clock does not have 50% duty cycle. For example, with a divider of
3, the duty cycle is 33%.

When combining high frequency (in the area of 140MHz+) and non-50% duty
cycle, it has been observed the the shifter does not have enough time to
shift the voltage enough, and this leads to bad signal which is rejected
by monitors.

As a workaround this patch makes the divider calculation skip all odd
dividers when the required pixel clock is over 100MHz.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 7d0db2b..d0e35da 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1386,6 +1386,11 @@ retry:
 				cur.dsi_pll_hsdiv_dispc_clk  					cur.clkin4ddr / cur.regm_dispc;
 
+				if (cur.regm_dispc > 1 &&
+						cur.regm_dispc % 2 != 0 &&
+						req_pck >= 1000000)
+					continue;
+
 				/* this will narrow down the search a bit,
 				 * but still give pixclocks below what was
 				 * requested */
-- 
1.7.10.4


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:30 +0000
Subject: [PATCH 06/11] OMAPDSS: DISPC: fix 64 bit issue in 5-tap
Message-Id: <1434545675-477-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC driver uses 64 bit arithmetic to calculate the required clock
rate for scaling. The code does not seem to work correctly, and instead
calculates with 32 bit numbers, giving wrong result.

Fix the code by typecasting values to u64 first, so that the
calculations do happen in 64 bits.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 4488d9367bd3..2db1c986e989 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2166,7 +2166,7 @@ static unsigned long calc_core_clk_five_taps(unsigned long pclk,
 	if (height > out_height) {
 		unsigned int ppl = mgr_timings->x_res;
 
-		tmp = pclk * height * out_width;
+		tmp = (u64)pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
 		core_clk = tmp;
 
@@ -2174,14 +2174,14 @@ static unsigned long calc_core_clk_five_taps(unsigned long pclk,
 			if (ppl = out_width)
 				return 0;
 
-			tmp = pclk * (height - 2 * out_height) * out_width;
+			tmp = (u64)pclk * (height - 2 * out_height) * out_width;
 			do_div(tmp, 2 * out_height * (ppl - out_width));
 			core_clk = max_t(u32, core_clk, tmp);
 		}
 	}
 
 	if (width > out_width) {
-		tmp = pclk * width;
+		tmp = (u64)pclk * width;
 		do_div(tmp, out_width);
 		core_clk = max_t(u32, core_clk, tmp);
 
-- 
2.1.4


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Oct 2014 08:39:30 +0000
Subject: [PATCH 1/5] OMAPDSS: HDMI: fix PLL GO bit handling
Message-Id: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The PLL settings are committed by setting GO bit, which is then cleared
by the HW when the settings have been taken into use.

The current PLL code handles this wrong: instead of waiting for the bit
to be cleared, it waits for the bit to be set. Usually, the bit is
always set, as the CPU has just set it before. However, if the CPU takes
enough time between setting the GO bit and checking it, the HW may
already have cleared the bit and this leads to timeout error.

Fix the wait to check the bit properly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index 54df12a8d744..d4ec815ba42e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -144,8 +144,8 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 
 	/* wait for bit change */
 	if (hdmi_wait_for_bit_change(pll->base, PLLCTRL_PLL_GO,
-			0, 0, 1) != 1) {
-		DSSERR("PLL GO bit not set\n");
+			0, 0, 0) != 0) {
+		DSSERR("PLL GO bit not clearing\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.1.1


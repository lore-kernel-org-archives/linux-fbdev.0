From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Oct 2014 08:39:31 +0000
Subject: [PATCH 2/5] OMAPDSS: HDMI: fix regsd write
Message-Id: <1413967174-28009-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

HDMI PLL's REGSD field is only set by the driver if the PLL's output
clock is over 1GHz. This is clearly an error, as REGSD should be set
always.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index d4ec815ba42e..6d92bb32fe51 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -124,16 +124,15 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 	r = FLD_MOD(r, 0x0, 14, 14);	/* PHY_CLKINEN de-assert during locking */
 	r = FLD_MOD(r, fmt->refsel, 22, 21);	/* REFSEL */
 
-	if (fmt->dcofreq) {
-		/* divider programming for frequency beyond 1000Mhz */
-		REG_FLD_MOD(pll->base, PLLCTRL_CFG3, fmt->regsd, 17, 10);
+	if (fmt->dcofreq)
 		r = FLD_MOD(r, 0x4, 3, 1);	/* 1000MHz and 2000MHz */
-	} else {
+	else
 		r = FLD_MOD(r, 0x2, 3, 1);	/* 500MHz and 1000MHz */
-	}
 
 	hdmi_write_reg(pll->base, PLLCTRL_CFG2, r);
 
+	REG_FLD_MOD(pll->base, PLLCTRL_CFG3, fmt->regsd, 17, 10);
+
 	r = hdmi_read_reg(pll->base, PLLCTRL_CFG4);
 	r = FLD_MOD(r, fmt->regm2, 24, 18);
 	r = FLD_MOD(r, fmt->regmf, 17, 0);
-- 
2.1.1


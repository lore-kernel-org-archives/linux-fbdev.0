From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Nov 2014 11:52:19 +0000
Subject: [PATCH 17/22] OMAPDSS: HDMI: Remove HDMI PLL reset
Message-Id: <1415793144-11723-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The SYSRESET bits in HDMI PLL do not reset the PLL itself, but only
affect the power used for the PLL.

Afaik there is no reason to use the SYSRESET bits, and we don't use it
in the other PLLs, so let's remove the HDMI PLL reset to make the PLL
code simpler and similar to other PLLs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index f04d435c4c0f..0942bdc8dfa6 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -166,21 +166,6 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 	return 0;
 }
 
-static int hdmi_pll_reset(struct hdmi_pll_data *pll)
-{
-	/* SYSRESET  controlled by power FSM */
-	REG_FLD_MOD(pll->base, PLLCTRL_PLL_CONTROL, pll_feat->sys_reset, 3, 3);
-
-	/* READ 0x0 reset is in progress */
-	if (hdmi_wait_for_bit_change(pll->base, PLLCTRL_PLL_STATUS, 0, 0, 1)
-			!= 1) {
-		DSSERR("Failed to sysreset PLL\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
 {
 	u16 r = 0;
@@ -193,10 +178,6 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
 	if (r)
 		return r;
 
-	r = hdmi_pll_reset(pll);
-	if (r)
-		return r;
-
 	r = hdmi_pll_config(pll);
 	if (r)
 		return r;
-- 
2.1.3


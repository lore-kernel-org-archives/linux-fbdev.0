From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Nov 2014 11:52:22 +0000
Subject: [PATCH 20/22] OMAPDSS: HDMI: remove extra poweroff
Message-Id: <1415793144-11723-21-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

hdmi_pll_enable powers off the PLL as the first thing it does. Right
after that, it enables the PLL powers.

The initial power-off is pointless, so let's remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index c14c3d132513..92d22252f86a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -171,10 +171,6 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll)
 	struct hdmi_wp_data *wp = pll->wp;
 	u16 r = 0;
 
-	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
-	if (r)
-		return r;
-
 	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 	if (r)
 		return r;
-- 
2.1.3


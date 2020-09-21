From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Mon, 21 Sep 2020 13:11:12 +0000
Subject: [PATCH -next] video: omapfb: simplify the return expression of hdmi_pll_enable
Message-Id: <20200921131112.93411-1-miaoqinglang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Qinglang Miao <miaoqinglang@huawei.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index 4991be031..a36e92155 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -104,11 +104,7 @@ static int hdmi_pll_enable(struct dss_pll *dsspll)
 
 	dss_ctrl_pll_enable(DSS_PLL_HDMI, true);
 
-	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
-	if (r)
-		return r;
-
-	return 0;
+	return hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 }
 
 static void hdmi_pll_disable(struct dss_pll *dsspll)
-- 
2.23.0

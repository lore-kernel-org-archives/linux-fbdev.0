From: Xu Wang <vulab@iscas.ac.cn>
Date: Wed, 14 Oct 2020 08:57:22 +0000
Subject: [PATCH] video: fbdev: sh_mobile_lcdcfb: Remove redundant null check before clk_prepare_enable/clk_di
Message-Id: <20201014085722.26069-1-vulab@iscas.ac.cn>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161217010203.GA140420@beast>
In-Reply-To: <20161217010203.GA140420@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, gustavoars@kernel.org, arnd@arndb.de, daniel.vetter@ffwll.ch, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c1043420dbd3..c0952cc96bdb 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -341,8 +341,7 @@ static void lcdc_wait_bit(struct sh_mobile_lcdc_priv *priv,
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_inc_and_test(&priv->hw_usecnt)) {
-		if (priv->dot_clk)
-			clk_prepare_enable(priv->dot_clk);
+		clk_prepare_enable(priv->dot_clk);
 		pm_runtime_get_sync(priv->dev);
 	}
 }
@@ -351,8 +350,7 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
 		pm_runtime_put(priv->dev);
-		if (priv->dot_clk)
-			clk_disable_unprepare(priv->dot_clk);
+		clk_disable_unprepare(priv->dot_clk);
 	}
 }
 
-- 
2.17.1

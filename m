From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Jul 2011 12:35:54 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
Message-Id: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Resuming from runtime PM restores all LCDC registers. If the dot clock
is off at that time display panning information will be corrupted.

Turn the dot clock on before resuming from runtime PM. Similarly,
turn the clock off after suspending the LCDC.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This patch should fix the LCDC panning issue caused by runtime suspend. It
applies on top of Rafael J. Wysocki's pm-domains branch and Damian
Hobson-Garcia's MERAM patches.

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 48a40e3..e9b80bc 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -256,9 +256,9 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_inc_and_test(&priv->hw_usecnt)) {
-		pm_runtime_get_sync(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
+		pm_runtime_get_sync(priv->dev);
 		if (priv->meram_dev && priv->meram_dev->pdev)
 			pm_runtime_get_sync(&priv->meram_dev->pdev->dev);
 	}
@@ -267,11 +267,11 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
-		if (priv->dot_clk)
-			clk_disable(priv->dot_clk);
 		if (priv->meram_dev && priv->meram_dev->pdev)
 			pm_runtime_put_sync(&priv->meram_dev->pdev->dev);
 		pm_runtime_put(priv->dev);
+		if (priv->dot_clk)
+			clk_disable(priv->dot_clk);
 	}
 }
 
-- 
Regards,

Laurent Pinchart


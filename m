From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 04 Jul 2011 08:06:47 +0000
Subject: [PATCH 2/5 v4] fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC
Message-Id: <1309766807-32484-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The MERAM reference counts should be tied to the two LCDC devices (LCD/HDMI)
so that when they are enable/disabled, the MERAM is as well.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
Changes from V3
=======* Remove the MERAM callbacks used to runtime_get/runtime_put the device from
  the LCDC driver.  Instead, just call the functions on the MERAM device
  directly

 drivers/video/sh_mobile_lcdcfb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 019dbd3..15e77f3 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -259,6 +259,8 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 		pm_runtime_get_sync(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
+		if (priv->meram_dev && priv->meram_dev->pdev)
+			pm_runtime_get_sync(&priv->meram_dev->pdev->dev);
 	}
 }
 
@@ -267,6 +270,8 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
 		if (priv->dot_clk)
 			clk_disable(priv->dot_clk);
+		if (priv->meram_dev && priv->meram_dev->pdev)
+			pm_runtime_put_sync(&priv->meram_dev->pdev->dev);
 		pm_runtime_put(priv->dev);
 	}
 }
-- 
1.7.1


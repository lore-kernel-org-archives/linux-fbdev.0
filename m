From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:49 +0000
Subject: [PATCH 2/5 v3] fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC
Message-Id: <1308728992-9660-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The MERAM reference counts should be tied to the two LCDC devices (LCD/HDMI)
so that when they are enable/disabled, the MERAM is as well.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
Changes from V2
=======
* Change the names of the clk_on/clk_off callbacks to pm_get_sync/pm_put_sync
  to better reflect their actual functionality

 drivers/video/sh_mobile_lcdcfb.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 019dbd3..78cc828 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -259,6 +259,11 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 		pm_runtime_get_sync(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
+		if (priv->meram_dev && priv->meram_dev->ops) {
+			struct sh_mobile_meram_info *mdev;
+			mdev = priv->meram_dev;
+			mdev->ops->meram_pm_get_sync(mdev);
+		}
 	}
 }
 
@@ -267,6 +272,11 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
 		if (priv->dot_clk)
 			clk_disable(priv->dot_clk);
+		if (priv->meram_dev && priv->meram_dev->ops) {
+			struct sh_mobile_meram_info *mdev;
+			mdev = priv->meram_dev;
+			mdev->ops->meram_pm_put_sync(mdev);
+		}
 		pm_runtime_put(priv->dev);
 	}
 }
-- 
1.7.1


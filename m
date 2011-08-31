From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Aug 2011 11:00:52 +0000
Subject: [PATCH v2 1/8] sh_mobile_meram: Reset ICBs at unregistration time
Message-Id: <1314788459-31791-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

When ICBs are unregistered and later reused they need to be reset to
avoid data corruption. Set the WBF, WF and RF bits to make sure ICBs get
reset properly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index f632970..4d63490 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -373,8 +373,10 @@ static void meram_deinit(struct sh_mobile_meram_priv *priv,
 			struct sh_mobile_meram_icb *icb)
 {
 	/* disable ICB */
-	meram_write_icb(priv->base, icb->cache_icb,  MExxCTL, 0);
-	meram_write_icb(priv->base, icb->marker_icb, MExxCTL, 0);
+	meram_write_icb(priv->base, icb->cache_icb,  MExxCTL,
+			MExxCTL_WBF | MExxCTL_WF | MExxCTL_RF);
+	meram_write_icb(priv->base, icb->marker_icb, MExxCTL,
+			MExxCTL_WBF | MExxCTL_WF | MExxCTL_RF);
 	icb->cache_unit = 0;
 }
 
-- 
1.7.3.4


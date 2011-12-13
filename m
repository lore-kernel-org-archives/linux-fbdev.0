From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:38 +0000
Subject: [PATCH 43/57] fbdev: sh_mobile_meram: Make current_reg field store the current reg set
Message-Id: <1323784972-24205-44-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make sure current_reg = 0/1 always mean register set A/B through all
the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 548f700..7af2ffe 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -259,8 +259,8 @@ static inline void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
 {
 	unsigned long target;
 
-	target = (cfg->current_reg) ? MExxSARA : MExxSARB;
 	cfg->current_reg ^= 1;
+	target = cfg->current_reg ? MExxSARB : MExxSARA;
 
 	/* set the next address to fetch */
 	meram_write_icb(priv->base, cfg->icb[0].cache_icb,  target,
-- 
1.7.3.4


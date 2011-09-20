From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:21:29 +0000
Subject: [PATCH v2 3/4] fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM suspend
Message-Id: <1316546490-4639-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

To reset the ICB on resume the MExxCTL register needs to be OR'ed with
MExxCTL_WBF | MExxCTL_WF | MExxCTL_RF, no set to that value. Fix this.

This fixes corruption at the bottom of the display when resuming from
runtime PM.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index f7e77f6..4ad083c 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -552,7 +552,7 @@ static int sh_mobile_meram_runtime_suspend(struct device *dev)
 				meram_read_icb(priv->base, j, icb_regs[k]);
 			/* Reset ICB on resume */
 			if (icb_regs[k] = MExxCTL)
-				priv->icb_saved_regs[j * ICB_REGS_SIZE + k] +				priv->icb_saved_regs[j * ICB_REGS_SIZE + k] | 					MExxCTL_WBF | MExxCTL_WF | MExxCTL_RF;
 		}
 	}
-- 
1.7.3.4


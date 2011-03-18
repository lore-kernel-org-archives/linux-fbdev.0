From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:59:45 +0000
Subject: [PATCH 18/20] video: msm: Prevent DMA lockups when switching bit depths
Message-Id: <1300485585-27640-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Forces the lcdc off and waits a frame vsync period to prevent the MDP DMA
engine crashing if the DMA bit depth is changed.  A sleep cannot be used
because lcdc_dma_start is called in irq context.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index b3f334ad..49d956a 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -564,6 +564,13 @@ void mdp_hw_init(struct mdp_info *mdp)
 	mdp_writel(mdp, 1, 0x60);
 	mdp_writel(mdp, 1, MDP_EBI2_PORTMAP_MODE);
 
+	/* disable lcdc */
+	mdp_writel(mdp, 0, MDP_LCDC_CTL);
+	/* enable auto clock gating for all blocks by default */
+	mdp_writel(mdp, 0xffffffff, MDP_CGC_EN);
+	/* reset color/gamma correct parms */
+	mdp_writel(mdp, 0, MDP_DMA_P_COLOR_CORRECT_CONFIG);
+
 	mdp_writel(mdp, 0, MDP_CMD_DEBUG_ACCESS_BASE + 0x01f8);
 	mdp_writel(mdp, 0, MDP_CMD_DEBUG_ACCESS_BASE + 0x01fc);
 	mdp_writel(mdp, 1, 0x60);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:58:58 +0000
Subject: [PATCH 14/20] video: msm: Write IRQ mask to MDP registers
Message-Id: <1300485538-27479-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Writing MDP IRQ mask to the MDP IRQ register to fully disable interrupt.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index bdca2d9..8184ca9 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -59,9 +59,13 @@ static int locked_enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 		enable_irq(mdp->irq);
 	}
 
+	/* clear out any previous irqs for the requested mask*/
+	mdp_writel(mdp, mask, MDP_INTR_CLEAR);
+
 	/* update the irq mask to reflect the fact that the interrupt is
 	 * enabled */
 	mdp_irq_mask |= mask;
+	mdp_writel(mdp, mdp_irq_mask, MDP_INTR_ENABLE);
 	return 0;
 }
 
@@ -87,6 +91,8 @@ static int locked_disable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 	/* update the irq mask to reflect the fact that the interrupt is
 	 * disabled */
 	mdp_irq_mask &= ~(mask);
+	mdp_writel(mdp, mdp_irq_mask, MDP_INTR_ENABLE);
+
 	/* if no one is waiting on the interrupt, disable it */
 	if (!mdp_irq_mask) {
 		disable_irq_nosync(mdp->irq);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


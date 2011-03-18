From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:53:58 +0000
Subject: [PATCH 03/20] video: msm: add locked_enable_mdp_irq function
Message-Id: <1300485238-27004-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a version of this fuction to be called in a locked context.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index a078028..9fb9f1a 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -47,14 +47,12 @@ static struct clk *clk;
 static unsigned int mdp_irq_mask;
 DEFINE_MUTEX(mdp_mutex);
 
-static int enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
+static int locked_enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 {
-	unsigned long irq_flags;
 	int ret = 0;
 
 	BUG_ON(!mask);
 
-	spin_lock_irqsave(&mdp->lock, irq_flags);
 	/* if the mask bits are already set return an error, this interrupt
 	 * is already enabled */
 	if (mdp_irq_mask & mask) {
@@ -72,7 +70,17 @@ static int enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 	/* update the irq mask to reflect the fact that the interrupt is
 	 * enabled */
 	mdp_irq_mask |= mask;
-	spin_unlock_irqrestore(&mdp->lock, irq_flags);
+	return 0;
+}
+
+static int enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&mdp->lock, flags);
+	ret = locked_enable_mdp_irq(mdp, mask);
+	spin_unlock_irqrestore(&mdp->lock, flags);
 	return ret;
 }
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


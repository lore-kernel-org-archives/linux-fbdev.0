From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:59:12 +0000
Subject: [PATCH 15/20] video: msm: convert printk to pr_*
Message-Id: <1300485552-27519-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Reword debugging messages to use pr_err and pr_warning

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index 8184ca9..b03204d 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -42,16 +42,13 @@ DEFINE_MUTEX(mdp_mutex);
 
 static int locked_enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 {
-	int ret = 0;
-
 	BUG_ON(!mask);
 
 	/* if the mask bits are already set return an error, this interrupt
 	 * is already enabled */
 	if (mdp_irq_mask & mask) {
-		printk(KERN_ERR "mdp irq already on already on %x %x\n",
-		       mdp_irq_mask, mask);
-		ret = -1;
+		pr_err("mdp irq already on %x %x\n", mdp_irq_mask, mask);
+		return -1;
 	}
 	/* if the mdp irq is not already enabled enable it */
 	if (!mdp_irq_mask) {
@@ -172,9 +169,9 @@ static int mdp_wait(struct mdp_info *mdp, uint32_t mask, wait_queue_head_t *wq)
 
 	spin_lock_irqsave(&mdp->lock, irq_flags);
 	if (mdp_irq_mask & mask) {
+		pr_warning("%s: timeout waiting for mdp to complete 0x%x\n",
+			   __func__, mask);
 		locked_disable_mdp_irq(mdp, mask);
-		printk(KERN_WARNING "timeout waiting for mdp to complete %x\n",
-		       mask);
 		ret = -ETIMEDOUT;
 	}
 	spin_unlock_irqrestore(&mdp->lock, irq_flags);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


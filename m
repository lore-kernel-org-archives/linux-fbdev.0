From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:59:34 +0000
Subject: [PATCH 17/20] video: msm: Prevent framebuffer glitch during initialization
Message-Id: <1300485574-27600-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Holds a reference to the mdp_clk until lateinit, and moves the frambuffer
initialization to device_init.  The framebuffer lcdc driver will grab a
reference to mdp_clk, which prevents the clock from being disabled by
clock_late_init.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index 0bb19fa..b3f334ad 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -38,6 +38,7 @@ struct class *mdp_class;
 
 static DECLARE_WAIT_QUEUE_HEAD(mdp_ppp_waitqueue);
 static unsigned int mdp_irq_mask;
+struct clk *mdp_clk_to_disable_later;
 DEFINE_MUTEX(mdp_mutex);
 
 static int locked_enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
@@ -670,6 +671,7 @@ int mdp_probe(struct platform_device *pdev)
 	disable_irq(mdp->irq);
 
 	clk_enable(mdp->clk);
+	mdp_clk_to_disable_later = mdp->clk;
 	mdp_hw_init(mdp);
 
 	/* register mdp device */
@@ -706,6 +708,13 @@ static struct platform_driver msm_mdp_driver = {
 	.driver = {.name = "msm_mdp"},
 };
 
+static int __init mdp_lateinit(void)
+{
+	if (mdp_clk_to_disable_later)
+		clk_disable(mdp_clk_to_disable_later);
+	return 0;
+}
+
 static int __init mdp_init(void)
 {
 	mdp_class = class_create(THIS_MODULE, "msm_mdp");
@@ -717,3 +726,4 @@ static int __init mdp_init(void)
 }
 
 subsys_initcall(mdp_init);
+late_initcall(mdp_lateinit);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


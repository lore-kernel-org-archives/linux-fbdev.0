From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:59:22 +0000
Subject: [PATCH 16/20] video: msm: Set the EBI1 clock to 128MHz when performing blits
Message-Id: <1300485562-27560-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This makes sure that the MDP (locked to AXI) and the AXI/ABI1 run at the
maximum frequency during blit operations.

Authors:
Dima Zavin <dima@android.com>
Rebecca Schultz Zavin <rebecca@android.com>
Colin Cross <ccross@android.com>

Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
---
 drivers/video/msm/mdp.c    |   11 +++++++++++
 drivers/video/msm/mdp_hw.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index b03204d..0bb19fa 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -52,6 +52,7 @@ static int locked_enable_mdp_irq(struct mdp_info *mdp, uint32_t mask)
 	}
 	/* if the mdp irq is not already enabled enable it */
 	if (!mdp_irq_mask) {
+		clk_set_rate(mdp->ebi1_clk, 128000000);
 		clk_enable(mdp->clk);
 		enable_irq(mdp->irq);
 	}
@@ -656,6 +657,13 @@ int mdp_probe(struct platform_device *pdev)
 		goto error_get_mdp_clk;
 	}
 
+	mdp->ebi1_clk = clk_get(NULL, "ebi1_clk");
+	if (IS_ERR(mdp->ebi1_clk)) {
+		pr_err("mdp: failed to get ebi1 clk\n");
+		ret = PTR_ERR(mdp->ebi1_clk);
+		goto error_get_ebi1_clk;
+	}
+
 	ret = request_irq(mdp->irq, mdp_isr, IRQF_DISABLED, "msm_mdp", mdp);
 	if (ret)
 		goto error_request_irq;
@@ -681,6 +689,9 @@ int mdp_probe(struct platform_device *pdev)
 error_device_register:
 	free_irq(mdp->irq, mdp);
 error_request_irq:
+	clk_put(mdp->ebi1_clk);
+error_get_ebi1_clk:
+	clk_put(mdp->clk);
 error_get_mdp_clk:
 error_mddi_pmdh_register:
 	iounmap(mdp->base);
diff --git a/drivers/video/msm/mdp_hw.h b/drivers/video/msm/mdp_hw.h
index fdf9e5e..7485a9e 100644
--- a/drivers/video/msm/mdp_hw.h
+++ b/drivers/video/msm/mdp_hw.h
@@ -46,6 +46,7 @@ struct mdp_info {
 	char * __iomem base;
 	int irq;
 	struct clk *clk;
+	struct clk *ebi1_clk;
 	struct mdp_out_interface out_if[MSM_MDP_NUM_INTERFACES];
 	int format;
 	int pack_pattern;
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


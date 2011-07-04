From: Julia Lawall <julia@diku.dk>
Date: Mon, 04 Jul 2011 14:11:45 +0000
Subject: [PATCH 5/5] drivers/video/msm/mdp.c: adjust error handling code
Message-Id: <1309788705-22278-5-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brown <davidb@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use the error handling code at the end of the function, rather than
returning directly.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier x;
@@

kfree(x)

@@
identifier r.x;
expression E1!=0,E2,E3,E4;
statement S;
@@

(
if (<+...x...+>) S
|
if (...) { ... when != kfree(x)
               when != if (...) { ... kfree(x); ... }
               when != x = E3
* return E1;
}
... when != x = E2
if (...) { ... when != x = E4
 kfree(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
I wonder if the error handling code at the end of the function should be
calling clk_put as well?  In that case, having a separate label for this
case would be useful.  Otherwise, one of error_request_irq and error_get_clk
can be deleted

 drivers/video/msm/mdp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
index 243d16f..01fa660 100644
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@ -421,7 +421,8 @@ int mdp_probe(struct platform_device *pdev)
 	clk = clk_get(&pdev->dev, "mdp_clk");
 	if (IS_ERR(clk)) {
 		printk(KERN_INFO "mdp: failed to get mdp clk");
-		return PTR_ERR(clk);
+		ret = PTR_ERR(clk);
+		goto error_get_clk;
 	}
 
 	ret = request_irq(mdp->irq, mdp_isr, IRQF_DISABLED, "msm_mdp", mdp);
@@ -495,6 +496,7 @@ int mdp_probe(struct platform_device *pdev)
 error_device_register:
 	free_irq(mdp->irq, mdp);
 error_request_irq:
+error_get_clk:
 	iounmap(mdp->base);
 error_get_irq:
 error_ioremap:


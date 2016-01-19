From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 19 Jan 2016 13:10:57 +0000
Subject: [PATCH] video: fbdev: imxfb: Provide a reset mechanism
Message-Id: <1453209057-16444-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently when we boot the kernel on a mx25pdk the LCDC controller
does not show the Linux logo on boot.

This problem is well explained by Sascha Hauer:

"Unfortunately this LCD controller does not have an enable bit. The
controller starts directly when the clocks are enabled. If the clocks
are enabled when the controller is not yet programmed with proper
register values then it just goes into some undefined state. What I
suspect is that the clocks already were enabled before driver probe,
presumably by the bootloader, so the controller is already in undefined
state when entering Linux. Now by dis/enabling the ipg clock you
effectively reset the controller. Since you have programmed it with
valid register values in the mean time it starts working after this
reset."

So do as suggested and force a reset of the LCDC hardware by 
enabling and disabling the IPG clock.

With this change the Linux logo can be seen on boot on a mx25pdk.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/video/fbdev/imxfb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index cee8860..bb2f1e8 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -902,6 +902,21 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_getclock;
 	}
 
+	/*
+	 * The LCDC controller does not have an enable bit. The
+	 * controller starts directly when the clocks are enabled.
+	 * If the clocks are enabled when the controller is not yet
+	 * programmed with proper register values (enabled at the
+	 * bootloader, for example) then it just goes into some undefined
+	 * state.
+	 * To avoid this issue, let's enable and disable LCDC IPG clock
+	 * so that we force some kind of 'reset' to the LCDC block.
+	 */
+	ret = clk_prepare_enable(fbi->clk_ipg);
+	if (ret)
+		goto failed_getclock;
+	clk_disable_unprepare(fbi->clk_ipg);
+
 	fbi->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(fbi->clk_ahb)) {
 		ret = PTR_ERR(fbi->clk_ahb);
-- 
1.9.1


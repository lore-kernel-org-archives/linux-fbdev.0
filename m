From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 07 Jun 2017 09:55:40 +0000
Subject: [PATCH] video: fbdev: pxafb:  Handle return value of clk_prepare_enable
Message-Id: <5e0ce70b74924acc351ce4d8ef846c28f8e6ceda.1496829008.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index b21a89b..c3d49e1 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1436,7 +1436,10 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
 	pr_debug("reg_lccr3 0x%08x\n", (unsigned int) fbi->reg_lccr3);
 
 	/* enable LCD controller clock */
-	clk_prepare_enable(fbi->clk);
+	if (clk_prepare_enable(fbi->clk)) {
+		pr_err("%s: Failed to prepare clock\n", __func__);
+		return;
+	}
 
 	if (fbi->lccr0 & LCCR0_LCDT)
 		return;
-- 
1.9.1


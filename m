From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Oct 2016 06:46:32 +0000
Subject: [PATCH] video: ARM CLCD: fix Vexpress regression
Message-Id: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The CLCD does not come up on Versatile Express as it does not
(currently) have a syscon node for controlling the block apart
from the CLCD itself. Make sure the .init() function can bail
out without an error making it probe again.

Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 19ad8645d93c..d909b7dda14d 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
 					     &clcd_id);
 	if (!np) {
 		dev_err(dev, "no Versatile syscon node\n");
-		return -ENODEV;
+		/* Vexpress does not have this */
+		return 0;
 	}
 	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
 
-- 
2.7.4


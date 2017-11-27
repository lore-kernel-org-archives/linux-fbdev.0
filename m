From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:28:31 +0000
Subject: [PATCH 5/5] radeon_backlight: Delete a jump target in radeonfb_bl_init()
Message-Id: <3b2295cf-59c8-b5af-25e5-c1d075093e19@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
In-Reply-To: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 22:03:03 +0100

* Replace a goto statement by a direct call of the function "kfree"
  in an if branch.

* Delete the jump label "error" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index 7f7ed6f72ddb..3c5b8291e773 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -157,7 +157,8 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 	if (IS_ERR(bd)) {
 		rinfo->info->bl_dev = NULL;
 		printk("radeonfb: Backlight registration failed\n");
-		goto error;
+		kfree(pdata);
+		return;
 	}
 
 	pdata->rinfo = rinfo;
@@ -188,11 +189,6 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 	backlight_update_status(bd);
 
 	printk("radeonfb: Backlight initialized (%s)\n", name);
-
-	return;
-
-error:
-	kfree(pdata);
 }
 
 void radeonfb_bl_exit(struct radeonfb_info *rinfo)
-- 
2.15.0


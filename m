From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:26:08 +0000
Subject: [PATCH 3/5] radeon_backlight: Delete an unnecessary return statement in radeonfb_bl_init()
Message-Id: <e1e33551-53de-7ad2-d5de-6e5c2135ecbc@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
In-Reply-To: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:37:52 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index 78c36c8d5e57..c5e0e3557cc2 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -193,7 +193,6 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 
 error:
 	kfree(pdata);
-	return;
 }
 
 void radeonfb_bl_exit(struct radeonfb_info *rinfo)
-- 
2.15.0


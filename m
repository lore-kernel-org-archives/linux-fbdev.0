From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:21:18 +0000
Subject: [PATCH 1/5] radeon_backlight: Delete an error message for a failed memory allocation in radeonfb_bl_
Message-Id: <f41ab46f-3e9b-a340-3178-44e37a9127d0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
In-Reply-To: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:27:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index 301d6d6aeead..ce5b22d710b3 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -144,10 +144,8 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 #endif
 
 	pdata = kmalloc(sizeof(struct radeon_bl_privdata), GFP_KERNEL);
-	if (!pdata) {
-		printk("radeonfb: Memory allocation failed\n");
+	if (!pdata)
 		goto error;
-	}
 
 	snprintf(name, sizeof(name), "radeonbl%d", rinfo->info->node);
 
-- 
2.15.0


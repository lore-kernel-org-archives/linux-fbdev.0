From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:27:32 +0000
Subject: [PATCH 4/5] radeon_backlight: Return directly after a failed kmalloc() in radeonfb_bl_init()
Message-Id: <3c7e74d9-0be1-cbfd-4070-d60904c55696@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
In-Reply-To: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:50:28 +0100

Return directly after a call of the function "kmalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index c5e0e3557cc2..7f7ed6f72ddb 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -145,7 +145,7 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 
 	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		goto error;
+		return;
 
 	snprintf(name, sizeof(name), "radeonbl%d", rinfo->info->node);
 
-- 
2.15.0


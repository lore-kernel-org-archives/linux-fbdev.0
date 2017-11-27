From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:25:38 +0000
Subject: [PATCH 2/5] radeon_backlight: Improve a size determination in radeonfb_bl_init()
Message-Id: <a1b1f11e-082e-841a-565e-bcf67f5cf15f@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
In-Reply-To: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:30:06 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/aty/radeon_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index ce5b22d710b3..78c36c8d5e57 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -143,7 +143,7 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 		return;
 #endif
 
-	pdata = kmalloc(sizeof(struct radeon_bl_privdata), GFP_KERNEL);
+	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		goto error;
 
-- 
2.15.0


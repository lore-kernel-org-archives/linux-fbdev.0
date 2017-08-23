From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 23 Aug 2017 17:37:26 +0000
Subject: [PATCH] video: ARM CLCD: constify amba_id
Message-Id: <b142bfffbda07fe20b845161aebc0472edf21cbe.1503509038.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@armlinux.org.uk, b.zolnierkie@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/amba-clcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index ffc2c33c..36d2519 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -1035,7 +1035,7 @@ static struct clcd_vendor_data vendor_nomadik = {
 	.init_panel = nomadik_clcd_init_panel,
 };
 
-static struct amba_id clcdfb_id_table[] = {
+static const struct amba_id clcdfb_id_table[] = {
 	{
 		.id	= 0x00041110,
 		.mask	= 0x000ffffe,
-- 
2.7.4


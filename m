From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 05 Dec 2017 17:12:30 +0000
Subject: [PATCH 1/2] video: ARM CLCD: Delete an error message for a failed memory allocation in clcdfb_probe(
Message-Id: <0ad85d10-a18f-ff02-f1f4-95452e54d32d@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
In-Reply-To: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Dec 2017 17:50:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/amba-clcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 36d25190b48c..79f5ebf23fcd 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -969,7 +969,6 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 
 	fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
 	if (!fb) {
-		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
 		goto free_region;
 	}
-- 
2.15.1


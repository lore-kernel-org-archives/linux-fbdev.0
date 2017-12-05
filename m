From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 05 Dec 2017 17:13:33 +0000
Subject: [PATCH 2/2] video: ARM CLCD: Improve a size determination in clcdfb_probe()
Message-Id: <3656de6d-53cc-f6a4-1950-71fc989c79a4@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
In-Reply-To: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Dec 2017 17:53:19 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/amba-clcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 79f5ebf23fcd..38c1f324ce15 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -967,7 +967,7 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
-	fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
+	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
 	if (!fb) {
 		ret = -ENOMEM;
 		goto free_region;
-- 
2.15.1


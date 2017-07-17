From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 17 Jul 2017 01:19:06 +0000
Subject: [PATCH] video: bfin-lq035q1-fb: constify dev_pm_ops
Message-Id: <20170717011906.GA25787@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

This dev_pm_ops structure is only stored in the pm field of a
device_driver structure. This field is declared const, so
dev_pm_ops structures that have this property can be declared
as const also.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/bfin-lq035q1-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/bfin-lq035q1-fb.c b/drivers/video/fbdev/bfin-lq035q1-fb.c
index b594a58..b459354 100644
--- a/drivers/video/fbdev/bfin-lq035q1-fb.c
+++ b/drivers/video/fbdev/bfin-lq035q1-fb.c
@@ -841,7 +841,7 @@ static int bfin_lq035q1_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops bfin_lq035q1_dev_pm_ops = {
+static const struct dev_pm_ops bfin_lq035q1_dev_pm_ops = {
 	.suspend = bfin_lq035q1_suspend,
 	.resume  = bfin_lq035q1_resume,
 };
-- 
2.5.0


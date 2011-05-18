From: anish <anish198519851985@gmail.com>
Date: Wed, 18 May 2011 18:19:18 +0000
Subject: [patch 2/2] trivial: amba-clcd.c changed the printk to pr_err
Message-Id: <1305742038.8771.27.camel@anish-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As suggested by russell,printk in the fail scenario
 is an error and should be reported at error severity.They
 cause things to stop working and so they are not just a
 warning so changed to pr_err.

Signed-off-by: anish kumar <anish198519851985@gmail.com>

---
 drivers/video/amba-clcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 5fc983c..9f27c71 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -545,13 +545,13 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 
 	ret = amba_request_regions(dev, NULL);
 	if (ret) {
-		printk(KERN_ERR "CLCD: unable to reserve regs region\n");
+		pr_err("CLCD: unable to reserve regs region\n");
 		goto out;
 	}
 
 	fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
 	if (!fb) {
-		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
+		pr_err("CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
 		goto free_region;
 	}
-- 
1.7.0.4






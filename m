From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 09:12:45 +0000
Subject: [PATCH v7][ 1/5] video: mx3fb: Use devm_kzalloc
Message-Id: <1394788369-5096-1-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Replace kzalloc by devm_kzalloc and remove the kfree() calls.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Removed the Cc from the patch, they went into 
  git send-email instead.
ChangeLog v5->v6:
 - New patch need
---
 drivers/video/fbdev/mx3fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 142e860..ee95de8 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -1496,7 +1496,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	if (!sdc_reg)
 		return -EINVAL;
 
-	mx3fb = kzalloc(sizeof(*mx3fb), GFP_KERNEL);
+	mx3fb = devm_kzalloc(&pdev->dev, sizeof(*mx3fb), GFP_KERNEL);
 	if (!mx3fb)
 		return -ENOMEM;
 
@@ -1542,7 +1542,6 @@ ersdc0:
 	dmaengine_put();
 	iounmap(mx3fb->reg_base);
 eremap:
-	kfree(mx3fb);
 	dev_err(dev, "mx3fb: failed to register fb\n");
 	return ret;
 }
@@ -1561,7 +1560,6 @@ static int mx3fb_remove(struct platform_device *dev)
 	dmaengine_put();
 
 	iounmap(mx3fb->reg_base);
-	kfree(mx3fb);
 	return 0;
 }
 
-- 
1.7.9.5


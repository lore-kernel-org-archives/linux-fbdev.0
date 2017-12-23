From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Sat, 23 Dec 2017 10:59:24 +0000
Subject: [PATCH v3 11/27] video: replace devm_ioremap_nocache with devm_ioremap
Message-Id: <1514026764-33087-1-git-send-email-xieyisheng1@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: ysxie@foxmail.com, Yisheng Xie <xieyisheng1@huawei.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/video/fbdev/mbx/mbxfb.c       | 9 ++++-----
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 2 +-
 drivers/video/fbdev/pxa168fb.c        | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 539b85d..fcecf48 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -940,9 +940,8 @@ static int mbxfb_probe(struct platform_device *dev)
 	}
 	mfbi->reg_phys_addr = mfbi->reg_res->start;
 
-	mfbi->reg_virt_addr = devm_ioremap_nocache(&dev->dev,
-						   mfbi->reg_phys_addr,
-						   res_size(mfbi->reg_req));
+	mfbi->reg_virt_addr = devm_ioremap(&dev->dev, mfbi->reg_phys_addr,
+					   res_size(mfbi->reg_req));
 	if (!mfbi->reg_virt_addr) {
 		dev_err(&dev->dev, "failed to ioremap Marathon registers\n");
 		ret = -EINVAL;
@@ -950,8 +949,8 @@ static int mbxfb_probe(struct platform_device *dev)
 	}
 	virt_base_2700 = mfbi->reg_virt_addr;
 
-	mfbi->fb_virt_addr = devm_ioremap_nocache(&dev->dev, mfbi->fb_phys_addr,
-						  res_size(mfbi->fb_req));
+	mfbi->fb_virt_addr = devm_ioremap(&dev->dev, mfbi->fb_phys_addr,
+					  res_size(mfbi->fb_req));
 	if (!mfbi->fb_virt_addr) {
 		dev_err(&dev->dev, "failed to ioremap frame buffer\n");
 		ret = -EINVAL;
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index b6f83d5..8bbc873 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -500,7 +500,7 @@ static int mmphw_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	ctrl->reg_base = devm_ioremap_nocache(ctrl->dev,
+	ctrl->reg_base = devm_ioremap(ctrl->dev,
 			res->start, resource_size(res));
 	if (ctrl->reg_base = NULL) {
 		dev_err(ctrl->dev, "%s: res %pR map failed\n", __func__, res);
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index def3a50..7d74f07 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -668,8 +668,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * Map LCD controller registers.
 	 */
-	fbi->reg_base = devm_ioremap_nocache(&pdev->dev, res->start,
-					     resource_size(res));
+	fbi->reg_base = devm_ioremap(&pdev->dev, res->start,
+				     resource_size(res));
 	if (fbi->reg_base = NULL) {
 		ret = -ENOMEM;
 		goto failed_free_info;
-- 
1.8.3.1


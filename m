From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 13:19:00 +0000
Subject: [PATCH] video: fbdev: aty: Use dev_get_drvdata
Message-Id: <20190724131900.2039-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 6f891d82eebe..5d042653e9bd 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2217,8 +2217,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+		struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
@@ -2230,8 +2229,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 				 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+		struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
-- 
2.20.1

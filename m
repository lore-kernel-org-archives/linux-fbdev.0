From: Wang Qing <wangqing@vivo.com>
Date: Tue, 22 Sep 2020 12:14:24 +0000
Subject: [PATCH] video: use kobj_to_dev()
Message-Id: <1600776867-24226-1-git-send-email-wangqing@vivo.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Wang Qing <wangqing@vivo.com>

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 4 ++--
 drivers/video/fbdev/udlfb.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 3fe509c..878c39a
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2200,7 +2200,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
 				 struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
@@ -2212,7 +2212,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 				 struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 5b014b4..f9b3c1c
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1457,7 +1457,7 @@ static ssize_t edid_show(
 			struct file *filp,
 			struct kobject *kobj, struct bin_attribute *a,
 			 char *buf, loff_t off, size_t count) {
-	struct device *fbdev = container_of(kobj, struct device, kobj);
+	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
 
@@ -1479,7 +1479,7 @@ static ssize_t edid_store(
 			struct file *filp,
 			struct kobject *kobj, struct bin_attribute *a,
 			char *src, loff_t src_off, size_t src_size) {
-	struct device *fbdev = container_of(kobj, struct device, kobj);
+	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
 	int ret;
-- 
2.7.4

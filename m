From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 02 Aug 2017 17:21:55 +0000
Subject: [PATCH] video: fbdev: add const to bin_attribute structures
Message-Id: <1501693795-13090-1-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, bernie@plugable.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Add const to bin_attribute structures as they are only passed to the
functions sysfs_{remove/create}_bin_file or
device_{remove/create}_bin_file. The corresponding arguments are of
type const, so declare the structures to be const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 4 ++--
 drivers/video/fbdev/udlfb.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index dba479e..1e2ec36 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2241,7 +2241,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
 }
 
-static struct bin_attribute edid1_attr = {
+static const struct bin_attribute edid1_attr = {
 	.attr   = {
 		.name	= "edid1",
 		.mode	= 0444,
@@ -2250,7 +2250,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 	.read	= radeon_show_edid1,
 };
 
-static struct bin_attribute edid2_attr = {
+static const struct bin_attribute edid2_attr = {
 	.attr   = {
 		.name	= "edid2",
 		.mode	= 0444,
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 05ef657..4454eb4 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1465,7 +1465,7 @@ static ssize_t metrics_reset_store(struct device *fbdev,
 	return count;
 }
 
-static struct bin_attribute edid_attr = {
+static const struct bin_attribute edid_attr = {
 	.attr.name = "edid",
 	.attr.mode = 0666,
 	.size = EDID_LENGTH,
-- 
1.9.1


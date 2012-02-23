From: Olivier Sobrie <olivier@sobrie.be>
Date: Thu, 23 Feb 2012 07:53:21 +0000
Subject: [PATCH] udlfb: Fix invalid return codes in edid sysfs entry store function
Message-Id: <1329983601-25335-1-git-send-email-olivier@sobrie.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Return a negative errno instead of zero in the write function of
the sysfs entry in case of error.
Also add a check on the return value of dlfb_setup_modes().

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/video/udlfb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index a197731..abbc3fe 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1427,19 +1427,22 @@ static ssize_t edid_store(
 	struct device *fbdev = container_of(kobj, struct device, kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dev = fb_info->par;
+	int ret;
 
 	/* We only support write of entire EDID at once, no offset*/
 	if ((src_size != EDID_LENGTH) || (src_off != 0))
-		return 0;
+		return -EINVAL;
 
-	dlfb_setup_modes(dev, fb_info, src, src_size);
+	ret = dlfb_setup_modes(dev, fb_info, src, src_size);
+	if (ret)
+		return ret;
 
 	if (dev->edid && (memcmp(src, dev->edid, src_size) = 0)) {
 		pr_info("sysfs written EDID is new default\n");
 		dlfb_ops_set_par(fb_info);
 		return src_size;
 	} else
-		return 0;
+		return -EINVAL;
 }
 
 static ssize_t metrics_reset_store(struct device *fbdev,
-- 
1.7.5.4


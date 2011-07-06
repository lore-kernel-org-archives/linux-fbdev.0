From: Pavel Roskin <proski@gnu.org>
Date: Wed, 06 Jul 2011 15:02:51 +0000
Subject: [PATCH] video: output: remove video_output_{register,unregister}
Message-Id: <20110706150251.30204.26171.stgit@mj.roinet.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>

video_output_register() and video_output_unregister() are not called
anywhere in the kernel code.  Also remove the fallback implementation
from the header.
---
 drivers/video/output.c       |   38 --------------------------------------
 include/linux/video_output.h |   19 -------------------
 2 files changed, 0 insertions(+), 57 deletions(-)

diff --git a/drivers/video/output.c b/drivers/video/output.c
index 0d6f2cd..858b6d1 100644
--- a/drivers/video/output.c
+++ b/drivers/video/output.c
@@ -81,44 +81,6 @@ static struct class video_output_class = {
 	.dev_attrs = video_output_attributes,
 };
 
-struct output_device *video_output_register(const char *name,
-	struct device *dev,
-	void *devdata,
-	struct output_properties *op)
-{
-	struct output_device *new_dev;
-	int ret_code = 0;
-
-	new_dev = kzalloc(sizeof(struct output_device),GFP_KERNEL);
-	if (!new_dev) {
-		ret_code = -ENOMEM;
-		goto error_return;
-	}
-	new_dev->props = op;
-	new_dev->dev.class = &video_output_class;
-	new_dev->dev.parent = dev;
-	dev_set_name(&new_dev->dev, name);
-	dev_set_drvdata(&new_dev->dev, devdata);
-	ret_code = device_register(&new_dev->dev);
-	if (ret_code) {
-		kfree(new_dev);
-		goto error_return;
-	}
-	return new_dev;
-
-error_return:
-	return ERR_PTR(ret_code);
-}
-EXPORT_SYMBOL(video_output_register);
-
-void video_output_unregister(struct output_device *dev)
-{
-	if (!dev)
-		return;
-	device_unregister(&dev->dev);
-}
-EXPORT_SYMBOL(video_output_unregister);
-
 static void __exit video_output_class_exit(void)
 {
 	class_unregister(&video_output_class);
diff --git a/include/linux/video_output.h b/include/linux/video_output.h
index ed5cdeb..be03118 100644
--- a/include/linux/video_output.h
+++ b/include/linux/video_output.h
@@ -35,23 +35,4 @@ struct output_device {
 	struct device dev;
 };
 #define to_output_device(obj) container_of(obj, struct output_device, dev)
-#if	defined(CONFIG_VIDEO_OUTPUT_CONTROL) || defined(CONFIG_VIDEO_OUTPUT_CONTROL_MODULE)
-struct output_device *video_output_register(const char *name,
-	struct device *dev,
-	void *devdata,
-	struct output_properties *op);
-void video_output_unregister(struct output_device *dev);
-#else
-static struct output_device *video_output_register(const char *name,
-        struct device *dev,
-        void *devdata,
-        struct output_properties *op)
-{
-	return ERR_PTR(-ENODEV);
-}
-static void video_output_unregister(struct output_device *dev)
-{
-	return;
-}
-#endif
 #endif

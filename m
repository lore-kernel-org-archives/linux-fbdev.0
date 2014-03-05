From: Daniel Mack <zonque@gmail.com>
Date: Wed, 05 Mar 2014 16:12:48 +0000
Subject: [PATCH 3/4] video: pxa3xx-gcu: provide an empty .open call
Message-Id: <1394035969-32420-4-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is necessary in order to make the core set file->private_data to
miscdev in use. We need that information later to dereference the
container of the device, so we can get access to our private struct from
other callbacks.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/video/pxa3xx-gcu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index f9961ba..73c29ec 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -373,6 +373,15 @@ static inline struct pxa3xx_gcu_priv *to_pxa3xx_gcu_priv(struct file *file)
 	return container_of(dev, struct pxa3xx_gcu_priv, misc_dev);
 }
 
+/*
+ * provide an empty .open callback, so the core sets file->private_data
+ * for us.
+ */
+static int pxa3xx_gcu_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
 static ssize_t
 pxa3xx_gcu_write(struct file *file, const char *buff,
 		 size_t count, loff_t *offp)
@@ -571,6 +580,7 @@ pxa3xx_gcu_free_buffers(struct device *dev,
 
 static const struct file_operations pxa3xx_gcu_miscdev_fops = {
 	.owner =		THIS_MODULE,
+	.open =			pxa3xx_gcu_open,
 	.write =		pxa3xx_gcu_write,
 	.unlocked_ioctl =	pxa3xx_gcu_ioctl,
 	.mmap =			pxa3xx_gcu_mmap,
-- 
1.8.5.3


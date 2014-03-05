From: Daniel Mack <zonque@gmail.com>
Date: Wed, 05 Mar 2014 16:12:46 +0000
Subject: [PATCH 1/4] video: pxa3xx-gcu: rename some symbols
Message-Id: <1394035969-32420-2-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Prefix some functions with more specific names. While at it, kill some
stray newlines and other coding style related minor things.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/video/pxa3xx-gcu.c | 48 ++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index ad382b3..9cd48ab 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -107,7 +107,6 @@ struct pxa3xx_gcu_priv {
 	struct timeval 		  base_time;
 
 	struct pxa3xx_gcu_batch *free;
-
 	struct pxa3xx_gcu_batch *ready;
 	struct pxa3xx_gcu_batch *ready_last;
 	struct pxa3xx_gcu_batch *running;
@@ -368,27 +367,26 @@ pxa3xx_gcu_wait_free(struct pxa3xx_gcu_priv *priv)
 
 /* Misc device layer */
 
-static inline struct pxa3xx_gcu_priv *file_dev(struct file *file)
+static inline struct pxa3xx_gcu_priv *to_pxa3xx_gcu_priv(struct file *file)
 {
 	struct miscdevice *dev = file->private_data;
 	return container_of(dev, struct pxa3xx_gcu_priv, misc_dev);
 }
 
 static ssize_t
-pxa3xx_gcu_misc_write(struct file *file, const char *buff,
-		      size_t count, loff_t *offp)
+pxa3xx_gcu_write(struct file *file, const char *buff,
+		 size_t count, loff_t *offp)
 {
 	int ret;
 	unsigned long flags;
 	struct pxa3xx_gcu_batch	*buffer;
-	struct pxa3xx_gcu_priv *priv = file_dev(file);
+	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
 
 	int words = count / 4;
 
 	/* Does not need to be atomic. There's a lock in user space,
 	 * but anyhow, this is just for statistics. */
 	priv->shared->num_writes++;
-
 	priv->shared->num_words += words;
 
 	/* Last word reserved for batch buffer end command */
@@ -406,10 +404,8 @@ pxa3xx_gcu_misc_write(struct file *file, const char *buff,
 	 * Get buffer from free list
 	 */
 	spin_lock_irqsave(&priv->spinlock, flags);
-
 	buffer = priv->free;
 	priv->free = buffer->next;
-
 	spin_unlock_irqrestore(&priv->spinlock, flags);
 
 
@@ -454,10 +450,10 @@ pxa3xx_gcu_misc_write(struct file *file, const char *buff,
 
 
 static long
-pxa3xx_gcu_misc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+pxa3xx_gcu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	unsigned long flags;
-	struct pxa3xx_gcu_priv *priv = file_dev(file);
+	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
 
 	switch (cmd) {
 	case PXA3XX_GCU_IOCTL_RESET:
@@ -474,10 +470,10 @@ pxa3xx_gcu_misc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 static int
-pxa3xx_gcu_misc_mmap(struct file *file, struct vm_area_struct *vma)
+pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned int size = vma->vm_end - vma->vm_start;
-	struct pxa3xx_gcu_priv *priv = file_dev(file);
+	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
 
 	switch (vma->vm_pgoff) {
 	case 0:
@@ -532,8 +528,8 @@ static inline void pxa3xx_gcu_init_debug_timer(void) {}
 #endif
 
 static int
-add_buffer(struct platform_device *dev,
-	   struct pxa3xx_gcu_priv *priv)
+pxa3xx_gcu_add_buffer(struct platform_device *dev,
+		      struct pxa3xx_gcu_priv *priv)
 {
 	struct pxa3xx_gcu_batch *buffer;
 
@@ -549,15 +545,14 @@ add_buffer(struct platform_device *dev,
 	}
 
 	buffer->next = priv->free;
-
 	priv->free = buffer;
 
 	return 0;
 }
 
 static void
-free_buffers(struct platform_device *dev,
-	     struct pxa3xx_gcu_priv *priv)
+pxa3xx_gcu_free_buffers(struct platform_device *dev,
+			struct pxa3xx_gcu_priv *priv)
 {
 	struct pxa3xx_gcu_batch *next, *buffer = priv->free;
 
@@ -568,18 +563,17 @@ free_buffers(struct platform_device *dev,
 				  buffer->ptr, buffer->phys);
 
 		kfree(buffer);
-
 		buffer = next;
 	}
 
 	priv->free = NULL;
 }
 
-static const struct file_operations misc_fops = {
-	.owner	= THIS_MODULE,
-	.write	= pxa3xx_gcu_misc_write,
-	.unlocked_ioctl = pxa3xx_gcu_misc_ioctl,
-	.mmap	= pxa3xx_gcu_misc_mmap
+static const struct file_operations pxa3xx_gcu_miscdev_fops = {
+	.owner =		THIS_MODULE,
+	.write =		pxa3xx_gcu_write,
+	.unlocked_ioctl =	pxa3xx_gcu_ioctl,
+	.mmap =			pxa3xx_gcu_mmap,
 };
 
 static int pxa3xx_gcu_probe(struct platform_device *dev)
@@ -593,7 +587,7 @@ static int pxa3xx_gcu_probe(struct platform_device *dev)
 		return -ENOMEM;
 
 	for (i = 0; i < 8; i++) {
-		ret = add_buffer(dev, priv);
+		ret = pxa3xx_gcu_add_buffer(dev, priv);
 		if (ret) {
 			dev_err(&dev->dev, "failed to allocate DMA memory\n");
 			goto err_free_priv;
@@ -611,7 +605,7 @@ static int pxa3xx_gcu_probe(struct platform_device *dev)
 
 	priv->misc_dev.minor	= MISCDEV_MINOR,
 	priv->misc_dev.name	= DRV_NAME,
-	priv->misc_dev.fops	= &misc_fops,
+	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
 
 	/* register misc device */
 	ret = misc_register(&priv->misc_dev);
@@ -710,7 +704,7 @@ err_misc_deregister:
 	misc_deregister(&priv->misc_dev);
 
 err_free_priv:
-	free_buffers(dev, priv);
+	pxa3xx_gcu_free_buffers(dev, priv);
 	kfree(priv);
 	return ret;
 }
@@ -728,7 +722,7 @@ static int pxa3xx_gcu_remove(struct platform_device *dev)
 	iounmap(priv->mmio_base);
 	release_mem_region(r->start, resource_size(r));
 	clk_disable(priv->clk);
-	free_buffers(dev, priv);
+	pxa3xx_gcu_free_buffers(dev, priv);
 	kfree(priv);
 
 	return 0;
-- 
1.8.5.3


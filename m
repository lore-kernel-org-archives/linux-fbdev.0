From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 27 Jun 2011 22:28:35 +0000
Subject: [PATCH] fbdev: bfin_adv7393fb: convert to seq_file
Message-Id: <1309213715-31842-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

->read_proc and ->write_proc interfaces are going away,
switch to seq_file/->write().

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bfin_adv7393fb.c |   44 ++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index 8486f54..ac19284 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -35,6 +35,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/platform_device.h>
 
 #include <linux/i2c.h>
@@ -322,42 +323,25 @@ static irqreturn_t ppi_irq_error(int irq, void *dev_id)
 
 }
 
-static int proc_output(char *buf)
+static int adv7393_proc_show(struct seq_file *m, void *v)
 {
-	char *p = buf;
-
-	p += sprintf(p,
+	return seq_puts(m,
 		"Usage:\n"
 		"echo 0x[REG][Value] > adv7393\n"
 		"example: echo 0x1234 >adv7393\n"
 		"writes 0x34 into Register 0x12\n");
-
-	return p - buf;
 }
 
-static int
-adv7393_read_proc(char *page, char **start, off_t off,
-		  int count, int *eof, void *data)
+static int adv7393_proc_open(struct inode *inode, struct file *file)
 {
-	int len;
-
-	len = proc_output(page);
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-	return len;
+	return single_open(file, adv7393_proc_show, NULL);
 }
 
 static int
 adv7393_write_proc(struct file *file, const char __user * buffer,
 		   unsigned long count, void *data)
 {
-	struct adv7393fb_device *fbdev = data;
+	struct adv7393fb_device *fbdev = PDE(file->f_path.dentry->d_inode)->data;
 	char line[8];
 	unsigned int val;
 	int ret;
@@ -372,6 +356,14 @@ adv7393_write_proc(struct file *file, const char __user * buffer,
 	return count;
 }
 
+static const struct file_operations adv7393_proc_ops = {
+	.open		= adv7393_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= adv7393_proc_write,
+};
+
 static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
 					   const struct i2c_device_id *id)
 {
@@ -509,17 +501,13 @@ static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
 	       fbdev->info.node, fbdev->info.fix.id);
 	dev_info(&client->dev, "fb memory address : 0x%p\n", fbdev->fb_mem);
 
-	entry = create_proc_entry("driver/adv7393", 0, NULL);
+	entry = proc_create_data("driver/adv7393", 0, NULL,
+				 &adv7393_proc_ops, fbdev);
 	if (!entry) {
 		dev_err(&client->dev, "unable to create /proc entry\n");
 		ret = -EFAULT;
 		goto out_0;
 	}
-
-	entry->read_proc = adv7393_read_proc;
-	entry->write_proc = adv7393_write_proc;
-	entry->data = fbdev;
-
 	return 0;
 
  out_0:
-- 
1.7.5.3


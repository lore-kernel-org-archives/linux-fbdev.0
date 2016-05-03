From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Tue, 03 May 2016 02:22:27 +0000
Subject: [PATCH] fbdev: fbmem: implement error handling in fbmem_init()
Message-Id: <1462242147-19876-1-git-send-email-khoroshilov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

fbmem_init() ignores all errors, while fbmem_exit() does not
check if deallocating resources are valid.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/video/fbdev/core/fbmem.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 4e73b6f6b1c0..76c1ad96fb37 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1854,17 +1854,31 @@ EXPORT_SYMBOL(fb_set_suspend);
 static int __init
 fbmem_init(void)
 {
-	proc_create("fb", 0, NULL, &fb_proc_fops);
+	int ret;
+
+	if (!proc_create("fb", 0, NULL, &fb_proc_fops))
+		return -ENOMEM;
 
-	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
+	ret = register_chrdev(FB_MAJOR, "fb", &fb_fops);
+	if (ret) {
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+		goto err_chrdev;
+	}
 
 	fb_class = class_create(THIS_MODULE, "graphics");
 	if (IS_ERR(fb_class)) {
-		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
+		ret = PTR_ERR(fb_class);
+		pr_warn("Unable to create fb class; errno = %d\n", ret);
 		fb_class = NULL;
+		goto err_class;
 	}
 	return 0;
+
+err_class:
+	unregister_chrdev(FB_MAJOR, "fb");
+err_chrdev:
+	remove_proc_entry("fb", NULL);
+	return ret;
 }
 
 #ifdef MODULE
-- 
1.9.1


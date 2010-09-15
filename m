From: Jing Liu <jing.liu.linux@gmail.com>
Date: Wed, 15 Sep 2010 18:35:39 +0000
Subject: [PATCH] s3c-fb: fix spinlock lockup
Message-Id: <1284575739.24018.19.camel@ubuntu64.ipb.online.sh.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch fixes spinlock lockup caused by calling request_irq before
init_waitqueue_head in s3c-fb.c.

This patch has been tested on SmartQ5.


Signed-off-by: Jing Liu <jing.liu.linux at gmail.com>
---
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index f9aca9d..980ad04 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1160,8 +1160,6 @@ static int __devinit s3c_fb_probe_win(struct
s3c_fb *sfb, unsigned int win_no,
 
 	dev_dbg(sfb->dev, "probing window %d, variant %p\n", win_no, variant);
 
-	init_waitqueue_head(&sfb->vsync_info.wait);
-
 	palette_size = variant->palette_sz * 4;
 
 	fbinfo = framebuffer_alloc(sizeof(struct s3c_fb_win) +
@@ -1351,6 +1349,9 @@ static int __devinit s3c_fb_probe(struct
platform_device *pdev)
 		goto err_ioremap;
 	}
 	sfb->irq_no = res->start;
+
+	init_waitqueue_head(&sfb->vsync_info.wait);
+
 	ret = request_irq(sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
 	if (ret) {


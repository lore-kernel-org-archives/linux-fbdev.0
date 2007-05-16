From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/10] w100fb: Fix compile warnings
Date: Thu, 17 May 2007 05:21:02 +0800
Message-ID: <464B75BE.8000505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9d-0005vm-4Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:29 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9b-0003Q1-Id
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:29 -0700
Received: by py-out-1112.google.com with SMTP id a29so647770pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Richard Purdie <rpurdie@rpsys.net>

Fix compile warnings from w100fb.c. Attribute registration failure
doesn't stop the driver working so just warn about it.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/w100fb.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 5fc86ea..003c49a 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -660,7 +660,7 @@ int __init w100fb_probe(struct platform_
 			err = -ENODEV;
 			goto out;
 	}
-	printk(" at 0x%08lx.\n", mem->start+W100_CFG_BASE);
+	printk(" at 0x%08lx.\n", (unsigned long) mem->start+W100_CFG_BASE);
 
 	/* Remap the framebuffer */
 	remapped_fbuf = ioremap_nocache(mem->start+MEM_WINDOW_BASE, MEM_WINDOW_SIZE);
@@ -753,10 +753,14 @@ int __init w100fb_probe(struct platform_
 		goto out;
 	}
 
-	device_create_file(&pdev->dev, &dev_attr_fastpllclk);
-	device_create_file(&pdev->dev, &dev_attr_reg_read);
-	device_create_file(&pdev->dev, &dev_attr_reg_write);
-	device_create_file(&pdev->dev, &dev_attr_flip);
+	err = device_create_file(&pdev->dev, &dev_attr_fastpllclk);
+	err |= device_create_file(&pdev->dev, &dev_attr_reg_read);
+	err |= device_create_file(&pdev->dev, &dev_attr_reg_write);
+	err |= device_create_file(&pdev->dev, &dev_attr_flip);
+
+	if (err != 0)
+		printk(KERN_WARNING "fb%d: failed to register attributes (%d)\n",
+				info->node, err);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

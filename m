From: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] Fix w100fb compile warnings
Date: Sun, 13 May 2007 13:37:24 +0100
Message-ID: <1179059844.5883.5.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HnDKS-0002z6-P3 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 May 2007 05:37:36 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HnDKS-0006VV-5H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 May 2007 05:37:36 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Fix compile warnings from w100fb.c. Attribute registration failure
doesn't stop the driver working so just warn about it.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 5fc86ea..003c49a 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -660,7 +660,7 @@ int __init w100fb_probe(struct platform_device *pdev)
 			err = -ENODEV;
 			goto out;
 	}
-	printk(" at 0x%08lx.\n", mem->start+W100_CFG_BASE);
+	printk(" at 0x%08lx.\n", (unsigned long) mem->start+W100_CFG_BASE);
 
 	/* Remap the framebuffer */
 	remapped_fbuf = ioremap_nocache(mem->start+MEM_WINDOW_BASE, MEM_WINDOW_SIZE);
@@ -753,10 +753,14 @@ int __init w100fb_probe(struct platform_device *pdev)
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

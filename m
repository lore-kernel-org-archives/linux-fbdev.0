From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] skeletonfb: update to correct platform
	driver usage
Date: Thu, 5 Jun 2008 23:07:26 +0200
Message-ID: <20080605230726.9b378d8a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Mdv-0001dL-Gq for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:05:07 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4Mds-0006kQ-Fu
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:05:07 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

It updates skeletonfb to new platform driver API.
The skeletonfb is templates for creating new drivers.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

--- linux-mm1/drivers/video/skeletonfb.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/drivers/video/skeletonfb.c	2008-06-05 23:01:47.393941821 +0200
@@ -675,13 +675,13 @@ static struct fb_ops xxxfb_ops = {
      *  Initialization
      */
 
-/* static int __init xxfb_probe (struct device *device) -- for platform devs */
+/* static int __init xxfb_probe (struct platform_device *pdev) -- for platform devs */
 static int __devinit xxxfb_probe(struct pci_dev *dev,
 			      const struct pci_device_id *ent)
 {
     struct fb_info *info;
     struct xxx_par *par;
-    struct device* device = &dev->dev; /* for pci drivers */
+    struct device *device = &dev->dev; /* or &pdev->dev */
     int cmap_len, retval;	
    
     /*
@@ -824,18 +824,18 @@ static int __devinit xxxfb_probe(struct 
 	return -EINVAL;
     printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
 	   info->fix.id);
-    pci_set_drvdata(dev, info); /* or dev_set_drvdata(device, info) */
+    pci_set_drvdata(dev, info); /* or platform_set_drvdata(pdev, info) */
     return 0;
 }
 
     /*
      *  Cleanup
      */
-/* static void __devexit xxxfb_remove(struct device *device) */
+/* static void __devexit xxxfb_remove(struct platform_device *pdev) */
 static void __devexit xxxfb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	/* or dev_get_drvdata(device); */
+	/* or platform_get_drvdata(pdev); */
 
 	if (info) {
 		unregister_framebuffer(info);
@@ -961,18 +961,17 @@ static int xxxfb_resume(struct platform_
 #define xxxfb_resume NULL
 #endif /* CONFIG_PM */
 
-static struct device_driver xxxfb_driver = {
-	.name = "xxxfb",
-	.bus  = &platform_bus_type,
+static struct platform_device_driver xxxfb_driver = {
 	.probe = xxxfb_probe,
 	.remove = xxxfb_remove,
 	.suspend = xxxfb_suspend, /* optional but recommended */
 	.resume = xxxfb_resume,   /* optional but recommended */
+	.driver = {
+		.name = "xxxfb",
+	},
 };
 
-static struct platform_device xxxfb_device = {
-	.name = "xxxfb",
-};
+static struct platform_device *xxxfb_device;
 
 #ifndef MODULE
     /*
@@ -1002,12 +1001,16 @@ static int __init xxxfb_init(void)
 		return -ENODEV;
 	xxxfb_setup(option);
 #endif
-	ret = driver_register(&xxxfb_driver);
+	ret = platform_driver_register(&xxxfb_driver);
 
 	if (!ret) {
-		ret = platform_device_register(&xxxfb_device);
-		if (ret)
-			driver_unregister(&xxxfb_driver);
+		xxxfb_device = platform_device_register_simple("xxxfb", 0,
+								NULL, 0);
+
+		if (IS_ERR(xxxfb_device)) {
+			platform_driver_unregister(&xxxfb_driver);
+			ret = PTR_ERR(xxxfb_device);
+		}
 	}
 
 	return ret;
@@ -1015,8 +1018,8 @@ static int __init xxxfb_init(void)
 
 static void __exit xxxfb_exit(void)
 {
-	platform_device_unregister(&xxxfb_device);
-	driver_unregister(&xxxfb_driver);
+	platform_device_unregister(xxxfb_device);
+	platform_driver_unregister(&xxxfb_driver);
 }
 #endif /* CONFIG_PCI */
 

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e20 



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

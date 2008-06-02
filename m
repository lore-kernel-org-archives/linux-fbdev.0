From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] hgafb: convert to new platform driver
	API (bugzilla #9689)
Date: Mon, 2 Jun 2008 19:36:08 +0200
Message-ID: <20080602193608.5173cdc0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3Duz-0001Sl-RW for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Jun 2008 10:34:01 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3Duy-0003zx-2X
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Jun 2008 10:34:01 -0700
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

Convert the hgafb driver to use new platform driver API. 
This solves problem reported in Bugzilla #9689.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-rc2/drivers/video/hgafb.c linux-new/drivers/video/hgafb.c
--- linux-rc2/drivers/video/hgafb.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/drivers/video/hgafb.c	2008-06-02 19:20:54.778088766 +0200
@@ -547,7 +547,7 @@ static struct fb_ops hgafb_ops = {
 	 *  Initialization
 	 */
 
-static int __init hgafb_probe(struct device *device)
+static int __init hgafb_probe(struct platform_device *pdev)
 {
 	struct fb_info *info;
 
@@ -561,7 +561,7 @@ static int __init hgafb_probe(struct dev
 	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
 		hga_type_name, hga_vram_len/1024);
 
-	info = framebuffer_alloc(0, NULL);
+	info = framebuffer_alloc(0, &pdev->dev);
 	if (!info) {
 		iounmap(hga_vram);
 		return -ENOMEM;
@@ -589,13 +589,13 @@ static int __init hgafb_probe(struct dev
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
                info->node, info->fix.id);
-	dev_set_drvdata(device, info);
+	platform_set_drvdata(pdev, info);
 	return 0;
 }
 
-static int hgafb_remove(struct device *device)
+static int hgafb_remove(struct platform_device *pdev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(pdev);
 
 	hga_txt_mode();
 	hga_clear_screen();
@@ -616,16 +616,15 @@ static int hgafb_remove(struct device *d
 	return 0;
 }
 
-static struct device_driver hgafb_driver = {
-	.name = "hgafb",
-	.bus  = &platform_bus_type,
+static struct platform_driver hgafb_driver = {
 	.probe = hgafb_probe,
 	.remove = hgafb_remove,
+	.driver = {
+		.name = "hgafb",
+	},
 };
 
-static struct platform_device hgafb_device = {
-	.name = "hgafb",
-};
+static struct platform_device *hgafb_device;
 
 static int __init hgafb_init(void)
 {
@@ -634,12 +633,15 @@ static int __init hgafb_init(void)
 	if (fb_get_options("hgafb", NULL))
 		return -ENODEV;
 
-	ret = driver_register(&hgafb_driver);
+	ret = platform_driver_register(&hgafb_driver);
 
 	if (!ret) {
-		ret = platform_device_register(&hgafb_device);
-		if (ret)
-			driver_unregister(&hgafb_driver);
+		hgafb_device = platform_device_register_simple("hgafb", 0, NULL, 0);
+
+		if (IS_ERR(hgafb_device)) {
+			platform_driver_unregister(&hgafb_driver);
+			ret = PTR_ERR(hgafb_device);
+		}
 	}
 
 	return ret;
@@ -647,8 +649,8 @@ static int __init hgafb_init(void)
 
 static void __exit hgafb_exit(void)
 {
-	platform_device_unregister(&hgafb_device);
-	driver_unregister(&hgafb_driver);
+	platform_device_unregister(hgafb_device);
+	platform_driver_unregister(&hgafb_driver);
 }
 
 /* -------------------------------------------------------------------------


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

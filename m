From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 5/6] Xilinxfb: cleanup platform_bus
 binding to use platform	bus API.
Date: Mon, 01 Oct 2007 09:57:54 -0600
Message-ID: <20071001155754.6114.6830.stgit@trillian.cg.shawcable.net>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcNfD-0003vW-8N for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:32 -0700
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]
	helo=pd3mo1so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcNfC-0002tJ-Hs
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:31 -0700
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JP80022HPOV8UF0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:58:07 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP8009I3POVD060@pd3mr5so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:58:08 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JP800ABFPOLQ6J1@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:57 -0600 (MDT)
In-reply-to: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

From: Grant Likely <grant.likely@secretlab.ca>

Change the platform bus binding to make use of the established
platform_bus API.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 12d9127..e482bb5 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -339,26 +339,24 @@ static int xilinxfb_release(struct device *dev)
  */
 
 static int
-xilinxfb_drv_probe(struct device *dev)
+xilinxfb_platform_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
 	struct xilinxfb_platform_data *pdata;
 	struct resource *res;
 	int width_mm;
 	int height_mm;
 	int rotate;
 
-	pdev = to_platform_device(dev);
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
-		dev_err(dev, "Missing pdata structure\n");
+		dev_err(&pdev->dev, "Missing pdata structure\n");
 		return -ENODEV;
 	}
 
 	/* Find the registers address */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
-		dev_err(dev, "Couldn't get registers resource\n");
+		dev_err(&pdev->dev, "Couldn't get registers resource\n");
 		return -ENODEV;
 	}
 
@@ -366,22 +364,24 @@ xilinxfb_drv_probe(struct device *dev)
 	width_mm = pdata->screen_width_mm;
 	rotate = pdata->rotate_screen ? 1 : 0;
 
-	return xilinxfb_assign(dev, res->start, width_mm, height_mm, rotate);
+	return xilinxfb_assign(&pdev->dev, res->start, width_mm, height_mm,
+			       rotate);
 }
 
 static int
-xilinxfb_drv_remove(struct device *dev)
+xilinxfb_platform_remove(struct platform_device *pdev)
 {
-	return xilinxfb_release(dev);
+	return xilinxfb_release(&pdev->dev);
 }
 
 
-static struct device_driver xilinxfb_driver = {
-	.name		= DRIVER_NAME,
-	.bus		= &platform_bus_type,
-
-	.probe		= xilinxfb_drv_probe,
-	.remove		= xilinxfb_drv_remove
+static struct platform_driver xilinxfb_platform_driver = {
+	.probe		= xilinxfb_platform_probe,
+	.remove		= xilinxfb_platform_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRIVER_NAME,
+	},
 };
 
 static int __init
@@ -391,13 +391,13 @@ xilinxfb_init(void)
 	 * No kernel boot options used,
 	 * so we just need to register the driver
 	 */
-	return driver_register(&xilinxfb_driver);
+	return platform_driver_register(&xilinxfb_platform_driver);
 }
 
 static void __exit
 xilinxfb_cleanup(void)
 {
-	driver_unregister(&xilinxfb_driver);
+	platform_driver_unregister(&xilinxfb_platform_driver);
 }
 
 module_init(xilinxfb_init);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

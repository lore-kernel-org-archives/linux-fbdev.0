From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] xilinxfb: Don't bail if the
 xilinxfb platform device doesn't have any pdata
Date: Mon, 09 Jul 2007 17:52:49 -0600
Message-ID: <20070709235249.4919.52551.stgit@trillian>
References: <20070709235244.4919.10308.stgit@trillian>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I833J-00044q-Sx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 16:54:01 -0700
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]
	helo=pd3mo3so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I833J-0003xP-IF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 16:54:01 -0700
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JKX00GNFROISZD0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:06 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JKX00FP2ROEXK10@pd2mr5so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:04 -0600 (MDT)
Received: from trillian.secretlab.ca ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JKX001ILROEWZB0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:02 -0600 (MDT)
In-reply-to: <20070709235244.4919.10308.stgit@trillian>
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
To: linux-fbdev-devel@lists.sourceforge.net

From: Grant Likely <grant.likely@secretlab.ca>

lack of pdata is not a fatal omission.  The driver can still be used even
if we do not know the screen dimensions.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
cc: Andrei Konovalov <akonovalov@ru.mvista.com>
---

 drivers/video/xilinxfb.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 44ce955..6ef9733 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -212,11 +212,6 @@ xilinxfb_drv_probe(struct device *dev)
 	pdev = to_platform_device(dev);
 	pdata = pdev->dev.platform_data;
 
-	if (pdata == NULL) {
-		printk(KERN_ERR "Couldn't find platform data.\n");
-		return -EFAULT;
-	}
-
 	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
 		printk(KERN_ERR "Couldn't allocate device private record\n");
@@ -258,11 +253,9 @@ xilinxfb_drv_probe(struct device *dev)
 	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
 
 	/* Turn on the display */
-	if (pdata->rotate_screen) {
-		drvdata->reg_ctrl_default = REG_CTRL_ENABLE | REG_CTRL_ROTATE;
-	} else {
-		drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
-	}
+	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
+	if (pdata && pdata->rotate_screen)
+		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
 	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
 
 	/* Fill struct fb_info */
@@ -281,8 +274,10 @@ xilinxfb_drv_probe(struct device *dev)
 	}
 
 	drvdata->info.flags = FBINFO_DEFAULT;
-	xilinx_fb_var.height = pdata->screen_height_mm;
-	xilinx_fb_var.width = pdata->screen_width_mm;
+	if (pdata) {
+		xilinx_fb_var.height = pdata->screen_height_mm;
+		xilinx_fb_var.width = pdata->screen_width_mm;
+	}
 	drvdata->info.var = xilinx_fb_var;
 
 	/* Register new frame buffer */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

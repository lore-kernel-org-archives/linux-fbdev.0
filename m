From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/33] xilinxfb: Don't bail if the
 xilinxfb platform device doesn't have any pdata
Date: Thu, 26 Jul 2007 19:50:12 +0800
Message-ID: <46A88A74.5060203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2sd-0000mF-63 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:47 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2sb-0007HM-U7
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:47 -0700
Received: by wa-out-1112.google.com with SMTP id k22so613963waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:55:45 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrei Konovalov <akonovalov@ru.mvista.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Grant Likely <grant.likely@secretlab.ca>

lack of pdata is not a fatal omission.  The driver can still be used even
if we do not know the screen dimensions.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
cc: Andrei Konovalov <akonovalov@ru.mvista.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
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
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

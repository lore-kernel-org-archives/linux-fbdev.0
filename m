From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] au1100fb: Add power management support
Date: Tue, 30 May 2006 05:41:28 +0800
Message-ID: <447B6A88.1090105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkpWf-0005yV-7r
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:43:49 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkpWf-0007lm-29
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:43:49 -0700
Received: by py-out-1112.google.com with SMTP id b29so228815pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 May 2006 14:43:48 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Rodolfo Giometti <giometti@linux.it>

From: Rodolfo Giometti <giometti@linux.it>

Add power management support

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index f55c16a..fcb8a4c 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -7,6 +7,8 @@
  *  	Karl Lessard <klessard@sunrisetelecom.com>
  *  	<c.pellegrin@exadron.com>
  *
+ * PM support added by Rodolfo Giometti <giometti@linux.it>
+ *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
  *		ppopov@mvista.com or source@mvista.com
@@ -602,17 +604,49 @@ int au1100fb_drv_remove(struct device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static u32 sys_clksrc;
+static struct au1100fb_regs fbregs;
+
 int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	/* Save the clock source state */
+	sys_clksrc = au_readl(SYS_CLKSRC);
+
+	/* Blank the LCD */
+	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+
+	/* Stop LCD clocking */
+	au_writel(sys_clksrc & ~SYS_CS_ML_MASK, SYS_CLKSRC);
+
+	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+
 	return 0;
 }
 
 int au1100fb_drv_resume(struct device *dev)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+
+	/* Restart LCD clocking */
+	au_writel(sys_clksrc, SYS_CLKSRC);
+
+	/* Unblank the LCD */
+	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+
 	return 0;
 }
+#endif
 
 static struct device_driver au1100fb_driver = {
 	.name		= "au1100-lcd",
@@ -620,8 +654,10 @@ static struct device_driver au1100fb_dri
 
 	.probe		= au1100fb_drv_probe,
         .remove		= au1100fb_drv_remove,
+#ifdef CONFIG_PM
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
+#endif
 };
 
 /*-------------------------------------------------------------------------*/



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

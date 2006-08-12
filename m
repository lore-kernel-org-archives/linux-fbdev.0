From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] CONFIG_PM=n slim: drivers/video/*
Date: Sat, 12 Aug 2006 04:39:39 +0400
Message-ID: <20060812003939.GL6847@martell.zuzino.mipt.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBhXU-0003yn-5K for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Aug 2006 17:39:44 -0700
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GBhXS-0001g8-LF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Aug 2006 17:39:44 -0700
Received: by ug-out-1314.google.com with SMTP id s2so392760uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 11 Aug 2006 17:39:40 -0700 (PDT)
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net

Compile out dead code for CONFIG_PM=n users.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/video/aty/aty128fb.c           |    7 ++++++-
 drivers/video/cyber2000fb.c            |    6 ++++++
 drivers/video/i810/i810_main.c         |    7 +++++++
 drivers/video/savage/savagefb_driver.c |    5 ++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -166,9 +166,11 @@ static const char *r128_family[] __devin
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
+#ifdef CONFIG_PM
 static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
+#endif
 
 /* supported Rage128 chipsets */
 static struct pci_device_id aty128_pci_tbl[] = {
@@ -276,8 +278,10 @@ static struct pci_driver aty128fb_driver
 	.id_table	= aty128_pci_tbl,
 	.probe		= aty128_probe,
 	.remove		= __devexit_p(aty128_remove),
+#ifdef CONFIG_PM
 	.suspend	= aty128_pci_suspend,
 	.resume		= aty128_pci_resume,
+#endif
 };
 
 /* packed BIOS settings */
@@ -2398,6 +2402,7 @@ static void fbcon_aty128_bmove(struct di
 }
 #endif /* 0 */
 
+#ifdef CONFIG_PM
 static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
@@ -2555,7 +2560,7 @@ static int aty128_pci_resume(struct pci_
 
 	return rc;
 }
-
+#endif
 
 static int __devinit aty128fb_init(void)
 {
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1406,6 +1406,7 @@ failed:
 	return err;
 }
 
+#ifdef CONFIG_PM
 static void cyberpro_common_resume(struct cfb_info *cfb)
 {
 	cyberpro_init_hw(cfb);
@@ -1422,6 +1423,7 @@ static void cyberpro_common_resume(struc
 	 */
 	cyber2000fb_set_par(&cfb->fb);
 }
+#endif
 
 #ifdef CONFIG_ARCH_SHARK
 
@@ -1664,6 +1666,7 @@ static void __devexit cyberpro_pci_remov
 	}
 }
 
+#ifdef CONFIG_PM
 static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
@@ -1683,6 +1686,7 @@ static int cyberpro_pci_resume(struct pc
 
 	return 0;
 }
+#endif
 
 static struct pci_device_id cyberpro_pci_table[] = {
 //	Not yet
@@ -1703,8 +1707,10 @@ static struct pci_driver cyberpro_driver
 	.name		= "CyberPro",
 	.probe		= cyberpro_pci_probe,
 	.remove		= __devexit_p(cyberpro_pci_remove),
+#ifdef CONFIG_PM
 	.suspend	= cyberpro_pci_suspend,
 	.resume		= cyberpro_pci_resume,
+#endif
 	.id_table	= cyberpro_pci_table
 };
 #endif
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -81,8 +81,10 @@ static int i810fb_cursor(struct fb_info 
 static int  __devinit i810fb_init_pci (struct pci_dev *dev,
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
+#ifdef CONFIG_PM
 static int i810fb_resume(struct pci_dev *dev);
 static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
+#endif
 
 /* Chipset Specific Functions */
 static int i810fb_set_par    (struct fb_info *info);
@@ -128,8 +130,10 @@ static struct pci_driver i810fb_driver =
 	.id_table =	i810fb_pci_tbl,
 	.probe    =	i810fb_init_pci,
 	.remove   =	__exit_p(i810fb_remove_pci),
+#ifdef CONFIG_PM
 	.suspend  =     i810fb_suspend,
 	.resume   =     i810fb_resume,
+#endif
 };
 
 static char *mode_option __devinitdata = NULL;
@@ -1551,6 +1555,7 @@ static struct fb_ops i810fb_ops __devini
 	.fb_sync =           i810fb_sync,
 };
 
+#ifdef CONFIG_PM
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
@@ -1612,6 +1617,8 @@ static int i810fb_resume(struct pci_dev 
 	release_console_sem();
 	return 0;
 }
+#endif
+
 /***********************************************************************
  *                  AGP resource allocation                            *
  ***********************************************************************/
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2323,6 +2323,7 @@ #endif
 	}
 }
 
+#ifdef CONFIG_PM
 static int savagefb_suspend(struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
@@ -2396,7 +2397,7 @@ static int savagefb_resume(struct pci_de
 
 	return 0;
 }
-
+#endif
 
 static struct pci_device_id savagefb_devices[] __devinitdata = {
 	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
@@ -2477,8 +2478,10 @@ static struct pci_driver savagefb_driver
 	.name =     "savagefb",
 	.id_table = savagefb_devices,
 	.probe =    savagefb_probe,
+#ifdef CONFIG_PM
 	.suspend =  savagefb_suspend,
 	.resume =   savagefb_resume,
+#endif
 	.remove =   __devexit_p(savagefb_remove)
 };
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] au1100fb compiling fix and PM support
Date: Thu, 25 May 2006 11:08:00 +0200
Message-ID: <20060525090800.GC27426@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjBpK-0000nz-1n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 02:08:18 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjBpK-0000gS-1P
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 02:08:18 -0700
Received: from 81-174-11-161.f5.ngi.it
	([81.174.11.161] helo=goldrake.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjBpJ-0008Nr-6d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 02:08:17 -0700
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FjBlH-0002PS-JT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 11:04:08 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FjBp2-000386-Hx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 11:08:00 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here two patches to fix some compiling issues and to add power
management support.

Please, apply first au1100fb_clean_compile.patch and then
au1100fb_pm_support.patch.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb_clean_compile.patch"

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 7c5fd9c..1f401a9 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -215,10 +244,13 @@ int au1100fb_setmode(struct au1100fb_dev
  */
 int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
-	u32 *palette = fbdev->regs->lcd_pallettebase;
+	struct au1100fb_device *fbdev;
+	u32 *palette;
 	u32 value;
 
+	fbdev = to_au1100fb_device(fbi);
+	palette = fbdev->regs->lcd_pallettebase;
+
 	if (regno > (AU1100_LCD_NBR_PALETTE_ENTRIES - 1))
 		return -EINVAL;
 
@@ -317,9 +363,11 @@ int au1100fb_fb_blank(int blank_mode, st
  */
 int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_device *fbdev;
 	int dy;
 
+	fbdev = to_au1100fb_device(fbi);
+
 	print_dbg("fb_pan_display %p %p", var, fbi);
 
 	if (!var || !fbdev) {
@@ -383,10 +431,12 @@ void au1100fb_fb_rotate(struct fb_info *
  */
 int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_device *fbdev;
 	unsigned int len;
 	unsigned long start=0, off;
 
+	fbdev = to_au1100fb_device(fbi);
+
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
@@ -468,7 +518,7 @@ int au1100fb_drv_probe(struct device *de
 
 	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
 				DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08x",
+		print_err("fail to lock memory region at 0x%08lx",
 				au1100fb_fix.mmio_start);
 		return -EBUSY;
 	}
@@ -596,13 +657,13 @@ int au1100fb_drv_remove(struct device *d
 	return 0;
 }
 
-int au1100fb_drv_suspend(struct device *dev, u32 state, u32 level)
+int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
 {
 	/* TODO */
 	return 0;
 }
 
-int au1100fb_drv_resume(struct device *dev, u32 level)
+int au1100fb_drv_resume(struct device *dev)
 {
 	/* TODO */
 	return 0;

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb_pm_support.patch"

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 1f401a9..0be2d55 100644
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
@@ -657,17 +659,49 @@ int au1100fb_drv_remove(struct device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static u32 sys_clksrc;
+static struct au1100fb_regs fbregs;
+
 int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
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
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
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
@@ -675,8 +709,10 @@ static struct device_driver au1100fb_dri
 
 	.probe		= au1100fb_drv_probe,
         .remove		= au1100fb_drv_remove,
+#ifdef CONFIG_PM
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
+#endif
 };
 
 /*-------------------------------------------------------------------------*/

--R+My9LyyhiUvIEro--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

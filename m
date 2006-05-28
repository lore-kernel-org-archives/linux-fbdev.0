From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/5] au1100fb: Fix compilation
Date: Sun, 28 May 2006 08:35:49 +0800
Message-ID: <4478F065.4010502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fk9NL-0001pB-WD
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:24 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fk9NL-0008KM-OX
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:24 -0700
Received: by py-out-1112.google.com with SMTP id b29so208814pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 17:43:23 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>

From: Rodolfo Giometti <giometti@linux.it>

Fix compilation

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index d7d2dba..f55c16a 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -214,10 +214,13 @@ int au1100fb_setmode(struct au1100fb_dev
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
 
@@ -316,9 +319,11 @@ int au1100fb_fb_blank(int blank_mode, stFrom: Rodolfo Giometti <giometti@linux.it>

Fix compilation

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index d7d2dba..f55c16a 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -214,10 +214,13 @@ int au1100fb_setmode(struct au1100fb_dev
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
 
@@ -316,9 +319,11 @@ int au1100fb_fb_blank(int blank_mode, st
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
@@ -382,10 +387,12 @@ void au1100fb_fb_rotate(struct fb_info *
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
@@ -467,7 +474,7 @@ int au1100fb_drv_probe(struct device *de
 
 	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
 				DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08x",
+		print_err("fail to lock memory region at 0x%08lx",
 				au1100fb_fix.mmio_start);
 		return -EBUSY;
 	}
@@ -595,13 +602,13 @@ int au1100fb_drv_remove(struct device *d
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
@@ -382,10 +387,12 @@ void au1100fb_fb_rotate(struct fb_info *
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
@@ -467,7 +474,7 @@ int au1100fb_drv_probe(struct device *de
 
 	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
 				DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08x",
+		print_err("fail to lock memory region at 0x%08lx",
 				au1100fb_fix.mmio_start);
 		return -EBUSY;
 	}
@@ -595,13 +602,13 @@ int au1100fb_drv_remove(struct device *d
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



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642

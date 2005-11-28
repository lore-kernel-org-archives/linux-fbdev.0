From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/16] kyrofb: Driver cleanups
Date: Mon, 28 Nov 2005 23:29:27 +0800
Message-ID: <438B2257.60100@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGor-0002Q6-NE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:37 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGor-00035W-C6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:37 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537654nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:31:36 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>

- remove unneeded casts
- use framebuffer_alloc/framebuffer_release to allocate/free memory
- the pseudo_palette is always u32 regardless of bpp if using generic
  drawing functions

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/kyro/fbdev.c |   32 ++++++++++++++------------------
 include/video/kyro.h       |    1 +
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 5eb4d5c..bcd359b 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -73,8 +73,6 @@ static struct fb_var_screeninfo kyro_var
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct kyrofb_info *currentpar;
-
 typedef struct {
 	STG4000REG __iomem *pSTGReg;	/* Virtual address of PCI register region */
 	u32 ulNextFreeVidMem;	/* Offset from start of vid mem to next free region */
@@ -309,7 +307,7 @@ enum {
 /* Accessors */
 static int kyro_dev_video_mode_set(struct fb_info *info)
 {
-	struct kyrofb_info *par = (struct kyrofb_info *)info->par;
+	struct kyrofb_info *par = info->par;
 
 	/* Turn off display */
 	StopVTG(deviceInfo.pSTGReg);
@@ -402,7 +400,7 @@ static inline unsigned long get_line_len
 
 static int kyrofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct kyrofb_info *par = (struct kyrofb_info *)info->par;
+	struct kyrofb_info *par = info->par;
 
 	if (var->bits_per_pixel != 16 && var->bits_per_pixel != 32) {
 		printk(KERN_WARNING "kyrofb: depth not supported: %u\n", var->bits_per_pixel);
@@ -478,7 +476,7 @@ static int kyrofb_check_var(struct fb_va
 
 static int kyrofb_set_par(struct fb_info *info)
 {
-	struct kyrofb_info *par = (struct kyrofb_info *)info->par;
+	struct kyrofb_info *par = info->par;
 	unsigned long lineclock;
 	unsigned long frameclock;
 
@@ -536,20 +534,22 @@ static int kyrofb_set_par(struct fb_info
 static int kyrofb_setcolreg(u_int regno, u_int red, u_int green,
 			    u_int blue, u_int transp, struct fb_info *info)
 {
+	struct kyrofb_info *par = info->par;
+
 	if (regno > 255)
 		return 1;	/* Invalid register */
 
 	if (regno < 16) {
 		switch (info->var.bits_per_pixel) {
 		case 16:
-			((u16*)(info->pseudo_palette))[regno] =
+			par->palette[regno] =
 			     (red   & 0xf800) |
 			    ((green & 0xfc00) >> 5) |
 			    ((blue  & 0xf800) >> 11);
 			break;
 		case 32:
 			red >>= 8; green >>= 8; blue >>= 8; transp >>= 8;
-			((u32*)(info->pseudo_palette))[regno] =
+			par->palette[regno] =
 			    (transp << 24) | (red << 16) | (green << 8) | blue;
 			break;
 		}
@@ -675,6 +675,7 @@ static int __devinit kyrofb_probe(struct
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
+	struct kyrofb_info *currentpar;
 	unsigned long size;
 	int err;
 
@@ -683,14 +684,11 @@ static int __devinit kyrofb_probe(struct
 		return err;
 	}
 
-	size = sizeof(struct fb_info) + sizeof(struct kyrofb_info) + 16 * sizeof(u32);
-	info = kmalloc(size, GFP_KERNEL);
+	info = framebuffer_alloc(sizeof(struct kyrofb_info), &pdev->dev);
 	if (!info)
 		return -ENOMEM;
 
-	memset(info, 0, size);
-
-	currentpar = (struct kyrofb_info *)(info + 1);
+	currentpar = info->par;
 
 	kyro_fix.smem_start = pci_resource_start(pdev, 0);
 	kyro_fix.smem_len   = pci_resource_len(pdev, 0);
@@ -716,8 +714,7 @@ static int __devinit kyrofb_probe(struct
 
 	info->fbops		= &kyrofb_ops;
 	info->fix		= kyro_fix;
-	info->par		= currentpar;
-	info->pseudo_palette	= (void *)(currentpar + 1);
+	info->pseudo_palette	= currentpar->palette;
 	info->flags		= FBINFO_DEFAULT;
 
 	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
@@ -741,7 +738,6 @@ static int __devinit kyrofb_probe(struct
 
 	fb_memset(info->screen_base, 0, size);
 
-	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
 
@@ -757,7 +753,7 @@ static int __devinit kyrofb_probe(struct
 out_unmap:
 	iounmap(currentpar->regbase);
 	iounmap(info->screen_base);
-	kfree(info);
+	framebuffer_release(info);
 
 	return -EINVAL;
 }
@@ -765,7 +761,7 @@ out_unmap:
 static void __devexit kyrofb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
-	struct kyrofb_info *par = (struct kyrofb_info *)info->par;
+	struct kyrofb_info *par = info->par;
 
 	/* Reset the board */
 	StopVTG(deviceInfo.pSTGReg);
@@ -789,7 +785,7 @@ static void __devexit kyrofb_remove(stru
 
 	unregister_framebuffer(info);
 	pci_set_drvdata(pdev, NULL);
-	kfree(info);
+	framebuffer_release(info);
 }
 
 static int __init kyrofb_init(void)
diff --git a/include/video/kyro.h b/include/video/kyro.h
index 1bed37c..dba7de2 100644
--- a/include/video/kyro.h
+++ b/include/video/kyro.h
@@ -15,6 +15,7 @@
 struct kyrofb_info {
 	void __iomem *regbase;
 
+	u32 palette[16];
 	u32 HTot;	/* Hor Total Time    */
 	u32 HFP;	/* Hor Front Porch   */
 	u32 HST;	/* Hor Sync Time     */



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

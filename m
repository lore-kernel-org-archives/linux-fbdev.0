From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/16] imsttfb: Driver cleanups
Date: Mon, 28 Nov 2005 23:25:56 +0800
Message-ID: <438B2184.1010908@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGom-0002Pm-Ag
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:32 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGol-0002py-SH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:32 -0800
Received: by zproxy.gmail.com with SMTP id r28so881935nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:31:30 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ryan Nielsen <ran@krazynet.com>

- remove unneeded casts
- the pseudo_palette, if using the generic drawing functions, must always
be u32 regardless of the bpp
- use framebuffer_alloc/framebuffer_release to allocate memory

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/imsttfb.c |   56 +++++++++++++++++++++++------------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 7fbe242..a5d8130 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -323,6 +323,7 @@ struct imstt_par {
 	unsigned long cmap_regs_phys;
 	__u8 *cmap_regs;
 	__u32 ramdac;
+	__u32 palette[16];
 };
  
 enum {
@@ -657,7 +658,7 @@ set_imstt_regvals_tvp (struct imstt_par 
 static void
 set_imstt_regvals (struct fb_info *info, u_int bpp)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	struct imstt_regvals *init = &par->init;
 	__u32 ctl, pitch, byteswap, scr;
 
@@ -749,7 +750,7 @@ set_imstt_regvals (struct fb_info *info,
 static inline void
 set_offset (struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	__u32 off = var->yoffset * (info->fix.line_length >> 3)
 		    + ((var->xoffset * (var->bits_per_pixel >> 3)) >> 3);
 	write_reg_le32(par->dc_regs, SSR, off);
@@ -863,7 +864,7 @@ imsttfb_check_var(struct fb_var_screenin
 static int
 imsttfb_set_par(struct fb_info *info) 
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 		
 	if (!compute_imstt_regvals(par, info->var.xres, info->var.yres))
 		return -EINVAL;
@@ -881,7 +882,7 @@ static int
 imsttfb_setcolreg (u_int regno, u_int red, u_int green, u_int blue,
 		   u_int transp, struct fb_info *info)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	u_int bpp = info->var.bits_per_pixel;
 
 	if (regno > 255)
@@ -905,14 +906,17 @@ imsttfb_setcolreg (u_int regno, u_int re
 	if (regno < 16)
 		switch (bpp) {
 			case 16:
-				((u16 *)info->pseudo_palette)[regno] = (regno << (info->var.green.length == 5 ? 10 : 11)) | (regno << 5) | regno;
+				par->palette[regno] =
+					(regno << (info->var.green.length ==
+					5 ? 10 : 11)) | (regno << 5) | regno;
 				break;
 			case 24:
-				((u32 *)info->pseudo_palette)[regno] = (regno << 16) | (regno << 8) | regno;
+				par->palette[regno] =
+					(regno << 16) | (regno << 8) | regno;
 				break;
 			case 32: {
 				int i = (regno << 8) | regno;
-				((u32 *)info->pseudo_palette)[regno] = (i << 16) | i;
+				par->palette[regno] = (i << 16) |i;
 				break;
 			}
 		}
@@ -935,7 +939,7 @@ imsttfb_pan_display(struct fb_var_screen
 static int 
 imsttfb_blank(int blank, struct fb_info *info)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	__u32 ctrl;
 
 	ctrl = read_reg_le32(par->dc_regs, STGCTL);
@@ -989,7 +993,7 @@ imsttfb_blank(int blank, struct fb_info 
 static void
 imsttfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 { 
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	__u32 Bpp, line_pitch, bgc, dx, dy, width, height;
 
 	bgc = rect->color;
@@ -1033,7 +1037,7 @@ imsttfb_fillrect(struct fb_info *info, c
 static void
 imsttfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	__u32 Bpp, line_pitch, fb_offset_old, fb_offset_new, sp, dp_octl;
  	__u32 cnt, bltctl, sx, sy, dx, dy, height, width;
 
@@ -1195,7 +1199,7 @@ imstt_set_cursor(struct imstt_par *par, 
 static int 
 imsttfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
         u32 flags = cursor->set, fg, bg, xx, yy;
 
 	if (cursor->dest == NULL && cursor->rop == ROP_XOR)
@@ -1266,7 +1270,7 @@ static int
 imsttfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 	      u_long arg, struct fb_info *info)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	void __user *argp = (void __user *)arg;
 	__u32 reg[2];
 	__u8 idx[2];
@@ -1350,7 +1354,7 @@ static struct fb_ops imsttfb_ops = {
 static void __devinit
 init_imstt(struct fb_info *info)
 {
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
 
 	tmp = read_reg_le32(par->dc_regs, PRC);
@@ -1413,7 +1417,7 @@ init_imstt(struct fb_info *info)
 	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> 3) > info->fix.smem_len
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
-		kfree(info);
+		framebuffer_release(info);
 		return;
 	}
 
@@ -1449,7 +1453,7 @@ init_imstt(struct fb_info *info)
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
 	if (register_framebuffer(info) < 0) {
-		kfree(info);
+		framebuffer_release(info);
 		return;
 	}
 
@@ -1474,26 +1478,21 @@ imsttfb_probe(struct pci_dev *pdev, cons
 		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
 #endif /* CONFIG_PPC_OF */
 
-	size = sizeof(struct fb_info) + sizeof(struct imstt_par) +
-		sizeof(u32) * 16;
-
-	info = kmalloc(size, GFP_KERNEL);
+	info = framebuffer_alloc(sizeof(struct imstt_par), &pdev->dev);
 
 	if (!info) {
 		printk(KERN_ERR "imsttfb: Can't allocate memory\n");
 		return -ENOMEM;
 	}
 
-	memset(info, 0, size);
-
-	par = (struct imstt_par *) (info + 1);
+	par = info->par;
 
 	addr = pci_resource_start (pdev, 0);
 	size = pci_resource_len (pdev, 0);
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		kfree(info);
+		framebuffer_release(info);
 		return -ENODEV;
 	}
 
@@ -1516,14 +1515,13 @@ imsttfb_probe(struct pci_dev *pdev, cons
 	}
 
 	info->fix.smem_start = addr;
-	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ? 0x400000 : 0x800000);
+	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
+					    0x400000 : 0x800000);
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
-	info->par = par;
-	info->pseudo_palette = (void *) (par + 1);
-	info->device = &pdev->dev;
+	info->pseudo_palette = par->palette;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
@@ -1534,7 +1532,7 @@ static void __devexit
 imsttfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
-	struct imstt_par *par = (struct imstt_par *) info->par;
+	struct imstt_par *par = info->par;
 	int size = pci_resource_len(pdev, 0);
 
 	unregister_framebuffer(info);
@@ -1542,7 +1540,7 @@ imsttfb_remove(struct pci_dev *pdev)
 	iounmap(par->dc_regs);
 	iounmap(info->screen_base);
 	release_mem_region(info->fix.smem_start, size);
-	kfree(info);
+	framebuffer_release(info);
 }
 
 #ifndef MODULE



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

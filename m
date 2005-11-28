From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/16] tdfxfb: Driver cleanups
Date: Mon, 28 Nov 2005 23:45:46 +0800
Message-ID: <438B262A.30809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGpT-0002U6-AP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:15 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGpS-00035W-GG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:32:15 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537654nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:32:13 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Hannu Mallat <hmallat@cc.hut.fi>

- remove unneeded casts
- move memory for pseudo_palette inside struct tdfxfb_par
- whitespace changes

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/tdfxfb.c |   57 ++++++++++++++++++---------------
 include/video/tdfx.h   |   84 ++++++++++++++++++++++++------------------------
 2 files changed, 73 insertions(+), 68 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 60bc890..3e7baf4 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -291,7 +291,7 @@ static inline void banshee_make_room(str
  
 static int banshee_wait_idle(struct fb_info *info)
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par; 
+	struct tdfx_par *par = info->par;
 	int i = 0;
 
 	banshee_make_room(par, 1);
@@ -364,7 +364,7 @@ static u32 do_calc_pll(int freq, int* fr
 
 static void do_write_regs(struct fb_info *info, struct banshee_reg* reg) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par; 
+	struct tdfx_par *par = info->par;
 	int i;
 
 	banshee_wait_idle(info);
@@ -469,7 +469,7 @@ static unsigned long do_lfb_size(struct 
 
 static int tdfxfb_check_var(struct fb_var_screeninfo *var,struct fb_info *info) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par; 
+	struct tdfx_par *par = info->par;
 	u32 lpitch;
 
 	if (var->bits_per_pixel != 8  && var->bits_per_pixel != 16 &&
@@ -558,7 +558,7 @@ static int tdfxfb_check_var(struct fb_va
 
 static int tdfxfb_set_par(struct fb_info *info)
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;	
+	struct tdfx_par *par = info->par;
 	u32 hdispend, hsyncsta, hsyncend, htotal;
 	u32 hd, hs, he, ht, hbs, hbe;
 	u32 vd, vs, ve, vt, vbs, vbe;
@@ -780,7 +780,7 @@ static int tdfxfb_set_par(struct fb_info
 static int tdfxfb_setcolreg(unsigned regno, unsigned red, unsigned green,  
 			    unsigned blue,unsigned transp,struct fb_info *info) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	u32 rgbcol;
    
 	if (regno >= info->cmap.len || regno > 255) return 1;
@@ -794,11 +794,15 @@ static int tdfxfb_setcolreg(unsigned reg
 			break;
 		/* Truecolor has no hardware color palettes. */
 		case FB_VISUAL_TRUECOLOR:
-			rgbcol = (CNVT_TOHW( red, info->var.red.length) << info->var.red.offset) |
-				 (CNVT_TOHW( green, info->var.green.length) << info->var.green.offset) |
-				 (CNVT_TOHW( blue, info->var.blue.length) << info->var.blue.offset) |
-				 (CNVT_TOHW( transp, info->var.transp.length) << info->var.transp.offset);
-				((u32*)(info->pseudo_palette))[regno] = rgbcol;
+			rgbcol = (CNVT_TOHW( red, info->var.red.length) <<
+				  info->var.red.offset) |
+				 (CNVT_TOHW( green, info->var.green.length) <<
+				  info->var.green.offset) |
+				 (CNVT_TOHW( blue, info->var.blue.length) <<
+				  info->var.blue.offset) |
+				 (CNVT_TOHW( transp, info->var.transp.length) <<
+				  info->var.transp.offset);
+				par->palette[regno] = rgbcol;
 			break;
 		default:
 			DPRINTK("bad depth %u\n", info->var.bits_per_pixel);
@@ -810,7 +814,7 @@ static int tdfxfb_setcolreg(unsigned reg
 /* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
 static int tdfxfb_blank(int blank, struct fb_info *info)
 { 
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	u32 dacmode, state = 0, vgablank = 0;
 
 	dacmode = tdfx_inl(par, DACMODE);
@@ -855,7 +859,7 @@ static int tdfxfb_blank(int blank, struc
 static int tdfxfb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	u32 addr;  	
 
 	if (nopan || var->xoffset || (var->yoffset > var->yres_virtual))
@@ -878,7 +882,7 @@ static int tdfxfb_pan_display(struct fb_
  */
 static void tdfxfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	u32 bpp = info->var.bits_per_pixel;
 	u32 stride = info->fix.line_length;
 	u32 fmt= stride | ((bpp+((bpp==8) ? 0 : 8)) << 13); 
@@ -894,7 +898,7 @@ static void tdfxfb_fillrect(struct fb_in
 	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
 		tdfx_outl(par,	COLORFORE, rect->color);
 	} else { /* FB_VISUAL_TRUECOLOR */
-		tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[rect->color]);
+		tdfx_outl(par, COLORFORE, par->palette[rect->color]);
 	}
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
@@ -906,7 +910,7 @@ static void tdfxfb_fillrect(struct fb_in
  */
 static void tdfxfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)  
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
    	u32 sx = area->sx, sy = area->sy, dx = area->dx, dy = area->dy;
 	u32 bpp = info->var.bits_per_pixel;
 	u32 stride = info->fix.line_length;
@@ -938,7 +942,7 @@ static void tdfxfb_copyarea(struct fb_in
 
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image) 
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	int size = image->height * ((image->width * image->depth + 7)>>3);
 	int fifo_free;
 	int i, stride = info->fix.line_length;
@@ -961,8 +965,10 @@ static void tdfxfb_imageblit(struct fb_i
 				break;
 			case FB_VISUAL_TRUECOLOR:
 			default:
-				tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[image->fg_color]);
-				tdfx_outl(par, COLORBACK, ((u32*)(info->pseudo_palette))[image->bg_color]);
+				tdfx_outl(par, COLORFORE,
+					  par->palette[image->fg_color]);
+				tdfx_outl(par, COLORBACK,
+					  par->palette[image->bg_color]);
 		}
 #ifdef __BIG_ENDIAN
 		srcfmt = 0x400000 | BIT(20);
@@ -1007,7 +1013,7 @@ static void tdfxfb_imageblit(struct fb_i
 #ifdef TDFX_HARDWARE_CURSOR
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 	unsigned long flags;
 
 	/*
@@ -1157,18 +1163,17 @@ static int __devinit tdfxfb_probe(struct
 {
 	struct tdfx_par *default_par;
 	struct fb_info *info;
-	int size, err, lpitch;
+	int err, lpitch;
 
 	if ((err = pci_enable_device(pdev))) {
 		printk(KERN_WARNING "tdfxfb: Can't enable pdev: %d\n", err);
 		return err;
 	}
 
-	size = sizeof(struct tdfx_par)+256*sizeof(u32);
+	info = framebuffer_alloc(sizeof(struct tdfx_par), &pdev->dev);
 
-	info = framebuffer_alloc(size, &pdev->dev);
-
-	if (!info)	return -ENOMEM;
+	if (!info)
+		return -ENOMEM;
 		
 	default_par = info->par;
  
@@ -1248,7 +1253,7 @@ static int __devinit tdfxfb_probe(struct
    
 	info->fbops		= &tdfxfb_ops;
 	info->fix		= tdfx_fix; 	
-	info->pseudo_palette	= (void *)(default_par + 1); 
+	info->pseudo_palette	= default_par->palette;
 	info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_3DFX_ACCEL
 	info->flags             |= FBINFO_HWACCEL_FILLRECT |
@@ -1340,7 +1345,7 @@ static void tdfxfb_setup(char *options)
 static void __devexit tdfxfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
-	struct tdfx_par *par = (struct tdfx_par *) info->par;
+	struct tdfx_par *par = info->par;
 
 	unregister_framebuffer(info);
 	iounmap(par->regbase_virt);
diff --git a/include/video/tdfx.h b/include/video/tdfx.h
index 0423767..c1cc94b 100644
--- a/include/video/tdfx.h
+++ b/include/video/tdfx.h
@@ -140,52 +140,52 @@
 #ifdef __KERNEL__
 
 struct banshee_reg {
-  /* VGA rubbish */
-  unsigned char att[21];
-  unsigned char crt[25];
-  unsigned char gra[ 9];
-  unsigned char misc[1];
-  unsigned char seq[ 5];
-
-  /* Banshee extensions */
-  unsigned char ext[2];
-  unsigned long vidcfg;
-  unsigned long vidpll;
-  unsigned long mempll;
-  unsigned long gfxpll;
-  unsigned long dacmode;
-  unsigned long vgainit0;
-  unsigned long vgainit1;
-  unsigned long screensize;
-  unsigned long stride;
-  unsigned long cursloc;
-  unsigned long curspataddr;
-  unsigned long cursc0;
-  unsigned long cursc1;
-  unsigned long startaddr;
-  unsigned long clip0min;
-  unsigned long clip0max;
-  unsigned long clip1min;
-  unsigned long clip1max;
-  unsigned long srcbase;
-  unsigned long dstbase;
-  unsigned long miscinit0;	
+	/* VGA rubbish */
+	unsigned char att[21];
+	unsigned char crt[25];
+	unsigned char gra[ 9];
+	unsigned char misc[1];
+	unsigned char seq[ 5];
+
+	/* Banshee extensions */
+	unsigned char ext[2];
+	unsigned long vidcfg;
+	unsigned long vidpll;
+	unsigned long mempll;
+	unsigned long gfxpll;
+	unsigned long dacmode;
+	unsigned long vgainit0;
+	unsigned long vgainit1;
+	unsigned long screensize;
+	unsigned long stride;
+	unsigned long cursloc;
+	unsigned long curspataddr;
+	unsigned long cursc0;
+	unsigned long cursc1;
+	unsigned long startaddr;
+	unsigned long clip0min;
+	unsigned long clip0max;
+	unsigned long clip1min;
+	unsigned long clip1max;
+	unsigned long srcbase;
+	unsigned long dstbase;
+	unsigned long miscinit0;
 };
 
 struct tdfx_par {
-  u32 max_pixclock;
+	u32 max_pixclock;
+	u32 palette[16];
+	void __iomem *regbase_virt;
+	unsigned long iobase;
+	u32 baseline;
+
+	struct {
+		int w,u,d;
+		unsigned long enable,disable;
+		struct timer_list timer;
+	} hwcursor;
 
-  void __iomem *regbase_virt;
-  unsigned long iobase;
-  u32 baseline;
-
-  struct {
-     int w,u,d;
-     unsigned long enable,disable;
-     struct timer_list timer;
-  } hwcursor; 
-
-  spinlock_t DAClock;
+	spinlock_t DAClock;
 };
 
 #endif /* __KERNEL__ */




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

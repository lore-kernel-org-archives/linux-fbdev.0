From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] stifb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 00:17:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915221759.GD27662@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z1gG-0008GW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 15:18:48 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z1gF-0002wv-Ud
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 15:18:48 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: deller@gmx.de
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/stifb.c to framebuffer_alloc:

======== drivers/video/stifb.c 1.20 ========
D 1.20 03/09/14 18:09:56+02:00 kronos@kronoz.cjb.net 22 21 39/36/1371
P drivers/video/stifb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/stifb.c 1.19 vs 1.20 =====
--- 1.19/drivers/video/stifb.c	Thu Sep  4 21:53:36 2003
+++ 1.20/drivers/video/stifb.c	Sun Sep 14 18:09:56 2003
@@ -105,7 +105,7 @@
 } ngle_rom_t;
 
 struct stifb_info {
-	struct fb_info info;
+	struct fb_info *info;
 	unsigned int id;
 	ngle_rom_t ngle_rom;
 	struct sti_struct *sti;
@@ -115,6 +115,8 @@
 static int __initdata bpp = 8;	/* parameter from modprobe */
 static int __initdata stifb_force_bpp[MAX_STI_ROMS];
 
+static void release_stifb(struct fb_info *info);
+
 /* ------------------- chipset specific functions -------------------------- */
 
 /* offsets to graphic-chip internal registers */
@@ -152,10 +154,10 @@
 #define REG_44		0x210030
 #define REG_45		0x210034
 
-#define READ_BYTE(fb,reg)		__raw_readb((fb)->info.fix.mmio_start + (reg))
-#define READ_WORD(fb,reg)		__raw_readl((fb)->info.fix.mmio_start + (reg))
-#define WRITE_BYTE(value,fb,reg)	__raw_writeb((value),(fb)->info.fix.mmio_start + (reg))
-#define WRITE_WORD(value,fb,reg)	__raw_writel((value),(fb)->info.fix.mmio_start + (reg))
+#define READ_BYTE(fb,reg)		__raw_readb((fb)->info->fix.mmio_start + (reg))
+#define READ_WORD(fb,reg)		__raw_readl((fb)->info->fix.mmio_start + (reg))
+#define WRITE_BYTE(value,fb,reg)	__raw_writeb((value),(fb)->info->fix.mmio_start + (reg))
+#define WRITE_WORD(value,fb,reg)	__raw_writel((value),(fb)->info->fix.mmio_start + (reg))
 
 #define ENABLE	1	/* for enabling/disabling screen */	
 #define DISABLE 0
@@ -190,13 +192,13 @@
 			reg10_value = 0x13601000;
 			break;
 		case S9000_ID_A1439A:
-			if (fb->info.var.bits_per_pixel == 32)						
+			if (fb->info->var.bits_per_pixel == 32)						
 				reg10_value = 0xBBA0A000;
 			else 
 				reg10_value = 0x13601000;
 			break;
 		case S9000_ID_HCRX:
-			if (fb->info.var.bits_per_pixel == 32)
+			if (fb->info->var.bits_per_pixel == 32)
 				reg10_value = 0xBBA0A000;
 			else					
 				reg10_value = 0x13602000;
@@ -234,7 +236,7 @@
 FINISH_IMAGE_COLORMAP_ACCESS(struct stifb_info *fb) 
 {		
 	WRITE_WORD(0x400, fb, REG_2);
-	if (fb->info.var.bits_per_pixel == 32) {
+	if (fb->info->var.bits_per_pixel == 32) {
 		WRITE_WORD(0x83000100, fb, REG_1);
 	} else {
 		if (fb->id == S9000_ID_ARTIST || fb->id == CRT_ID_VISUALIZE_EG)
@@ -473,7 +475,7 @@
 ngleSetupAttrPlanes(struct stifb_info *fb, int BufferNumber)
 {
 	SETUP_ATTR_ACCESS(fb, BufferNumber);
-	SET_ATTR_SIZE(fb, fb->info.var.xres, fb->info.var.yres);
+	SET_ATTR_SIZE(fb, fb->info->var.xres, fb->info->var.yres);
 	FINISH_ATTR_ACCESS(fb);
 	SETUP_FB(fb);
 }
@@ -489,8 +491,8 @@
 	SETUP_HW(fb);
 	WRITE_BYTE(1, fb, REG_16b1);
 
-	fb_memset(fb->info.fix.smem_start, 0xff,
-		fb->info.var.yres*fb->info.fix.line_length);
+	fb_memset(fb->info->fix.smem_start, 0xff,
+		fb->info->var.yres*fb->info->fix.line_length);
     
 	CRX24_SET_OVLY_MASK(fb);
 	SETUP_FB(fb);
@@ -569,7 +571,7 @@
 	lutBltCtl.fields.lutType = HYPER_CMAP_TYPE;
 
 	/* Expect lutIndex to be 0 or 1 for image cmaps, 2 or 3 for overlay cmaps */
-	if (fb->info.var.bits_per_pixel == 8)
+	if (fb->info->var.bits_per_pixel == 8)
 		lutBltCtl.fields.lutOffset = 2 * 256;
 	else
 		lutBltCtl.fields.lutOffset = 0 * 256;
@@ -650,7 +652,7 @@
 					       DataDynamic, MaskOtc,
 					       BGx(0), FGx(0)));
 	packed_dst = 0;
-	packed_len = (fb->info.var.xres << 16) | fb->info.var.yres;
+	packed_len = (fb->info->var.xres << 16) | fb->info->var.yres;
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 2);
 	NGLE_SET_DSTXY(fb, packed_dst);
 	SET_LENXY_START_RECFILL(fb, packed_len);
@@ -700,7 +702,7 @@
         NGLE_REALLY_SET_IMAGE_PLANEMASK(fb, mask);
     
         packed_dst = 0;
-        packed_len = (fb->info.var.xres << 16) | fb->info.var.yres;
+        packed_len = (fb->info->var.xres << 16) | fb->info->var.yres;
         NGLE_SET_DSTXY(fb, packed_dst);
     
         /* Write zeroes to overlay planes */		       
@@ -722,7 +724,7 @@
 	NGLE_LOCK(fb);
 
 	if (IS_24_DEVICE(fb))
-		if (fb->info.var.bits_per_pixel == 32)
+		if (fb->info->var.bits_per_pixel == 32)
 			controlPlaneReg = 0x04000F00;
 		else
 			controlPlaneReg = 0x00000F00;   /* 0x00000800 should be enought, but lets clear all 4 bits */
@@ -852,7 +854,7 @@
 	GET_FIFO_SLOTS(fb, nFreeFifoSlots, 7);
 	
 	if (IS_24_DEVICE(fb)) {
-		hyperbowl = (fb->info.var.bits_per_pixel == 32) ?
+		hyperbowl = (fb->info->var.bits_per_pixel == 32) ?
 			HYPERBOWL_MODE01_8_24_LUT0_TRANSPARENT_LUT1_OPAQUE :
 			HYPERBOWL_MODE01_8_24_LUT0_OPAQUE_LUT1_OPAQUE;
 
@@ -964,7 +966,7 @@
 stifb_setcolreg(u_int regno, u_int red, u_int green,
 	      u_int blue, u_int transp, struct fb_info *info)
 {
-	struct stifb_info *fb = (struct stifb_info *) info;
+	struct stifb_info *fb = info->par;
 	u32 color;
 
 	if (regno >= 256)  /* no. of hw registers */
@@ -976,7 +978,7 @@
 
 	START_IMAGE_COLORMAP_ACCESS(fb);
 	
-	if (fb->info.var.grayscale) {
+	if (info->var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		color = ((red * 77) +
 			 (green * 151) +
@@ -1011,7 +1013,7 @@
 static int
 stifb_blank(int blank_mode, struct fb_info *info)
 {
-	struct stifb_info *fb = (struct stifb_info *) info;
+	struct stifb_info *fb = info->par;
 	int enable = (blank_mode == 0) ? ENABLE : DISABLE;
 
 	switch (fb->id) {
@@ -1073,7 +1075,7 @@
         switch (id) {
 	 case S9000_ID_A1659A:
 	 case S9000_ID_A1439A:
-	    if (fb->info.var.bits_per_pixel == 32)
+	    if (fb->info->var.bits_per_pixel == 32)
 		ngleSetupAttrPlanes(fb, BUFF1_CMAP3);
 	    else {
 		ngleSetupAttrPlanes(fb, BUFF1_CMAP0);
@@ -1083,14 +1085,14 @@
 	    break;
 	 case S9000_ID_ARTIST:
 	 case CRT_ID_VISUALIZE_EG:
-	    if (fb->info.var.bits_per_pixel == 32)
+	    if (fb->info->var.bits_per_pixel == 32)
 		ngleSetupAttrPlanes(fb, BUFF1_CMAP3);
 	    else {
 		ngleSetupAttrPlanes(fb, ARTIST_CMAP0);
 	    }
 	    break;
 	}
-	stifb_blank(0, (struct fb_info *)fb);	/* 0=enable screen */
+	stifb_blank(0, fb->info);	/* 0=enable screen */
 
 	SETUP_FB(fb);
 }
@@ -1125,16 +1127,17 @@
 	char *dev_name;
 	int bpp, xres, yres;
 
-	fb = kmalloc(sizeof(*fb), GFP_ATOMIC);
-	if (!fb) {
+	info = framebuffer_alloc(sizeof(*fb), NULL);
+	if (!info) {
 		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
 		return -ENODEV;
 	}
-	
-	info = &fb->info;
+
+	fb = info->par;
+	fb->info = info;
+	info->release = &release_stifb;
 
 	/* set struct to a known state */
-	memset(fb, 0, sizeof(*fb));
 	fix = &info->fix;
 	var = &info->var;
 
@@ -1299,14 +1302,14 @@
 		goto out_err2;
 	}
 
-	if (register_framebuffer(&fb->info) < 0)
+	if (register_framebuffer(info) < 0)
 		goto out_err3;
 
 	sti->info = info; /* save for unregister_framebuffer() */
 
 	printk(KERN_INFO 
 	    "fb%d: %s %dx%d-%d frame buffer device, id: %04x, mmio: 0x%04lx\n",
-		fb->info.node, 
+		fb->info->node, 
 		fix->id,
 		var->xres, 
 		var->yres,
@@ -1323,7 +1326,7 @@
 	release_mem_region(fix->smem_start, fix->smem_len);
 out_err1:
 	fb_dealloc_cmap(&info->cmap);
-	kfree(fb);
+	kfree(info);
 	return -ENXIO;
 }
 
@@ -1348,6 +1351,12 @@
  *  Cleanup
  */
 
+static void release_stifb(struct fb_info *info) {
+	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
+	release_mem_region(info->fix.smem_start, info->fix.smem_len);
+	fb_dealloc_cmap(&info->cmap);
+}
+
 static void __exit
 stifb_cleanup(void)
 {
@@ -1359,14 +1368,8 @@
 		if (!sti)
 			break;
 		if (sti->info) {
-			struct fb_info *info = sti->info;
 			unregister_framebuffer(sti->info);
-			release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
-		        release_mem_region(info->fix.smem_start, info->fix.smem_len);
-		        fb_dealloc_cmap(&info->cmap);
-		        kfree(info); 
 		}
-		sti->info = NULL;
 	}
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] sa1100fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:06:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915210635.GG23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0ZN-0002U3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:07:37 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0ZL-0001sw-Os
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:07:35 -0700
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
To: rmk@arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/sa1100fb.c to framebuffer_alloc:

======== drivers/video/sa1100fb.c 1.31 ========
D 1.31 03/09/14 00:14:52+02:00 kronos@kronoz.cjb.net 38 37 82/81/1801
P drivers/video/sa1100fb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/sa1100fb.c 1.30 vs 1.31 =====
--- 1.30/drivers/video/sa1100fb.c	Fri Aug 22 08:34:52 2003
+++ 1.31/drivers/video/sa1100fb.c	Sun Sep 14 00:14:52 2003
@@ -812,7 +812,7 @@
 sa1100fb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
 		       u_int trans, struct fb_info *info)
 {
-	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
+	struct sa1100fb_info *fbi = info->par;
 	u_int val, ret = 1;
 
 	if (regno < fbi->palette_size) {
@@ -821,7 +821,7 @@
 		val |= ((blue >> 12) & 0x00f);
 
 		if (regno == 0)
-			val |= palette_pbs(&fbi->fb.var);
+			val |= palette_pbs(&info->var);
 
 		fbi->palette_cpu[regno] = val;
 		ret = 0;
@@ -833,7 +833,7 @@
 sa1100fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		   u_int trans, struct fb_info *info)
 {
-	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
+	struct sa1100fb_info *fbi = info->par;
 	unsigned int val;
 	int ret = 1;
 
@@ -853,22 +853,22 @@
 	 * If greyscale is true, then we convert the RGB value
 	 * to greyscale no mater what visual we are using.
 	 */
-	if (fbi->fb.var.grayscale)
+	if (info->var.grayscale)
 		red = green = blue = (19595 * red + 38470 * green +
 					7471 * blue) >> 16;
 
-	switch (fbi->fb.fix.visual) {
+	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 		/*
 		 * 12 or 16-bit True Colour.  We encode the RGB value
 		 * according to the RGB bitfield information.
 		 */
 		if (regno < 16) {
-			u32 *pal = fbi->fb.pseudo_palette;
+			u32 *pal = info->pseudo_palette;
 
-			val  = chan_to_field(red, &fbi->fb.var.red);
-			val |= chan_to_field(green, &fbi->fb.var.green);
-			val |= chan_to_field(blue, &fbi->fb.var.blue);
+			val  = chan_to_field(red, &info->var.red);
+			val |= chan_to_field(green, &info->var.green);
+			val |= chan_to_field(blue, &info->var.blue);
 
 			pal[regno] = val;
 			ret = 0;
@@ -908,7 +908,7 @@
 static int
 sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
+	struct sa1100fb_info *fbi = info->par;
 	int rgbidx;
 
 	if (var->xres < MIN_XRES)
@@ -987,26 +987,26 @@
  */
 static int sa1100fb_set_par(struct fb_info *info)
 {
-	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
+	struct sa1100fb_info *fbi = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	unsigned long palette_mem_size;
 
 	DPRINTK("set_par\n");
 
 	if (var->bits_per_pixel == 16)
-		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 	else if (!fbi->cmap_static)
-		fbi->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 	else {
 		/*
 		 * Some people have weird ideas about wanting static
 		 * pseudocolor maps.  I suspect their user space
 		 * applications are broken.
 		 */
-		fbi->fb.fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+		info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
 	}
 
-	fbi->fb.fix.line_length = var->xres_virtual *
+	info->fix.line_length = var->xres_virtual *
 				  var->bits_per_pixel / 8;
 	fbi->palette_size = var->bits_per_pixel == 8 ? 256 : 16;
 
@@ -1020,7 +1020,7 @@
 	/*
 	 * Set (any) board control register to handle new color depth
 	 */
-	sa1100fb_set_truecolor(fbi->fb.fix.visual == FB_VISUAL_TRUECOLOR);
+	sa1100fb_set_truecolor(info->fix.visual == FB_VISUAL_TRUECOLOR);
 
 #ifdef CONFIG_SA1100_OMNIMETER
 #error Do we have to do this here?   We already do it at init time.
@@ -1087,7 +1087,7 @@
  */
 static int sa1100fb_blank(int blank, struct fb_info *info)
 {
-	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
+	struct sa1100fb_info *fbi = info->par;
 	int i;
 
 	DPRINTK("sa1100fb_blank: blank=%d\n", blank);
@@ -1096,17 +1096,17 @@
 	case VESA_POWERDOWN:
 	case VESA_VSYNC_SUSPEND:
 	case VESA_HSYNC_SUSPEND:
-		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
-		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
 			for (i = 0; i < fbi->palette_size; i++)
 				sa1100fb_setpalettereg(i, 0, 0, 0, 0, info);
 		sa1100fb_schedule_work(fbi, C_DISABLE);
 		break;
 
 	case VESA_NO_BLANKING:
-		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
-		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
-			fb_set_cmap(&fbi->fb.cmap, 1, info);
+		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+			fb_set_cmap(&info->cmap, 1, info);
 		sa1100fb_schedule_work(fbi, C_ENABLE);
 	}
 	return 0;
@@ -1162,28 +1162,28 @@
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
 		printk(KERN_ERR "%s: invalid xres %d\n",
-			fbi->fb.fix.id, var->xres);
+			fbi->fb->fix.id, var->xres);
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
-			fbi->fb.fix.id, var->hsync_len);
+			fbi->fb->fix.id, var->hsync_len);
 	if (var->left_margin < 1  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
-			fbi->fb.fix.id, var->left_margin);
+			fbi->fb->fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
-			fbi->fb.fix.id, var->right_margin);
+			fbi->fb->fix.id, var->right_margin);
 	if (var->yres < 1         || var->yres > 1024)
 		printk(KERN_ERR "%s: invalid yres %d\n",
-			fbi->fb.fix.id, var->yres);
+			fbi->fb->fix.id, var->yres);
 	if (var->vsync_len < 1    || var->vsync_len > 64)
 		printk(KERN_ERR "%s: invalid vsync_len %d\n",
-			fbi->fb.fix.id, var->vsync_len);
+			fbi->fb->fix.id, var->vsync_len);
 	if (var->upper_margin < 0 || var->upper_margin > 255)
 		printk(KERN_ERR "%s: invalid upper_margin %d\n",
-			fbi->fb.fix.id, var->upper_margin);
+			fbi->fb->fix.id, var->upper_margin);
 	if (var->lower_margin < 0 || var->lower_margin > 255)
 		printk(KERN_ERR "%s: invalid lower_margin %d\n",
-			fbi->fb.fix.id, var->lower_margin);
+			fbi->fb->fix.id, var->lower_margin);
 #endif
 
 	new_regs.lccr0 = fbi->lccr0 |
@@ -1288,7 +1288,7 @@
 	    (fbi->reg_lccr0 & (LCCR0_Dual|LCCR0_Act)) != 0) {
 		mask = GPIO_LDD11 | GPIO_LDD10 | GPIO_LDD9  | GPIO_LDD8;
 
-		if (fbi->fb.var.bits_per_pixel > 8 ||
+		if (fbi->fb->var.bits_per_pixel > 8 ||
 		    (fbi->reg_lccr0 & (LCCR0_Dual|LCCR0_Act)) == LCCR0_Dual)
 			mask |= GPIO_LDD15 | GPIO_LDD14 | GPIO_LDD13 | GPIO_LDD12;
 
@@ -1312,7 +1312,7 @@
 	 * Make sure the mode bits are present in the first palette entry
 	 */
 	fbi->palette_cpu[0] &= 0xcfff;
-	fbi->palette_cpu[0] |= palette_pbs(&fbi->fb.var);
+	fbi->palette_cpu[0] |= palette_pbs(&fbi->fb->var);
 
 	/* Sequence from 11.7.10 */
 	LCCR3 = fbi->reg_lccr3;
@@ -1553,7 +1553,7 @@
 	/*
 	 * FIXME: we need to verify _all_ consoles.
 	 */
-	return sa1100fb_display_dma_period(&fbi->fb.var);
+	return sa1100fb_display_dma_period(&fbi->fb->var);
 #endif
 }
 
@@ -1576,7 +1576,7 @@
 		break;
 
 	case CPUFREQ_POSTCHANGE:
-		pcd = get_pcd(fbi->fb.var.pixclock, f->new);
+		pcd = get_pcd(fbi->fb->var.pixclock, f->new);
 		fbi->reg_lccr3 = (fbi->reg_lccr3 & ~0xff) | LCCR3_PixClkDiv(pcd);
 		set_ctrlr_state(fbi, C_ENABLE_CLKCHANGE);
 		break;
@@ -1652,14 +1652,14 @@
 	 * We reserve one page for the palette, plus the size
 	 * of the framebuffer.
 	 */
-	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + PAGE_SIZE);
+	fbi->map_size = PAGE_ALIGN(fbi->fb->fix.smem_len + PAGE_SIZE);
 	fbi->map_cpu = consistent_alloc(GFP_KERNEL, fbi->map_size,
 					&fbi->map_dma, PTE_BUFFERABLE);
 
 	if (fbi->map_cpu) {
-		fbi->fb.screen_base = fbi->map_cpu + PAGE_SIZE;
+		fbi->fb->screen_base = fbi->map_cpu + PAGE_SIZE;
 		fbi->screen_dma = fbi->map_dma + PAGE_SIZE;
-		fbi->fb.fix.smem_start = fbi->screen_dma;
+		fbi->fb->fix.smem_start = fbi->screen_dma;
 	}
 
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -1671,38 +1671,39 @@
 };
 
 
-static struct sa1100fb_info * __init sa1100fb_init_fbinfo(void)
+static struct sa1100fb_info * __init sa1100fb_init_fbinfo(struct device *dev)
 {
 	struct sa1100fb_mach_info *inf;
 	struct sa1100fb_info *fbi;
+	struct fb_info *info;
 
-	fbi = kmalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
-		      GFP_KERNEL);
-	if (!fbi)
+	info = framebuffer_alloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
+				dev);
+	if (!info)
 		return NULL;
+	fbi = info->par;
+	fbi->fb = info;
 
-	memset(fbi, 0, sizeof(struct sa1100fb_info));
-
-	strcpy(fbi->fb.fix.id, SA1100_NAME);
+	strcpy(info->fix.id, SA1100_NAME);
 
-	fbi->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
-	fbi->fb.fix.type_aux	= 0;
-	fbi->fb.fix.xpanstep	= 0;
-	fbi->fb.fix.ypanstep	= 0;
-	fbi->fb.fix.ywrapstep	= 0;
-	fbi->fb.fix.accel	= FB_ACCEL_NONE;
-
-	fbi->fb.var.nonstd	= 0;
-	fbi->fb.var.activate	= FB_ACTIVATE_NOW;
-	fbi->fb.var.height	= -1;
-	fbi->fb.var.width	= -1;
-	fbi->fb.var.accel_flags	= 0;
-	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
-
-	fbi->fb.fbops		= &sa1100fb_ops;
-	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
-	fbi->fb.monspecs	= monspecs;
-	fbi->fb.pseudo_palette	= (fbi + 1);
+	info->fix.type		= FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux	= 0;
+	info->fix.xpanstep	= 0;
+	info->fix.ypanstep	= 0;
+	info->fix.ywrapstep	= 0;
+	info->fix.accel		= FB_ACCEL_NONE;
+
+	info->var.nonstd	= 0;
+	info->var.activate	= FB_ACTIVATE_NOW;
+	info->var.height	= -1;
+	info->var.width		= -1;
+	info->var.accel_flags	= 0;
+	info->var.vmode		= FB_VMODE_NONINTERLACED;
+
+	info->fbops		= &sa1100fb_ops;
+	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->monspecs		= monspecs;
+	info->pseudo_palette	= (fbi + 1);
 
 	fbi->rgb[RGB_8]		= &rgb_8;
 	fbi->rgb[RGB_16]	= &def_rgb_16;
@@ -1720,29 +1721,29 @@
 			"pixclock.");
 
 	fbi->max_xres			= inf->xres;
-	fbi->fb.var.xres		= inf->xres;
-	fbi->fb.var.xres_virtual	= inf->xres;
+	info->var.xres			= inf->xres;
+	info->var.xres_virtual		= inf->xres;
 	fbi->max_yres			= inf->yres;
-	fbi->fb.var.yres		= inf->yres;
-	fbi->fb.var.yres_virtual	= inf->yres;
+	info->var.yres			= inf->yres;
+	info->var.yres_virtual		= inf->yres;
 	fbi->max_bpp			= inf->bpp;
-	fbi->fb.var.bits_per_pixel	= inf->bpp;
-	fbi->fb.var.pixclock		= inf->pixclock;
-	fbi->fb.var.hsync_len		= inf->hsync_len;
-	fbi->fb.var.left_margin		= inf->left_margin;
-	fbi->fb.var.right_margin	= inf->right_margin;
-	fbi->fb.var.vsync_len		= inf->vsync_len;
-	fbi->fb.var.upper_margin	= inf->upper_margin;
-	fbi->fb.var.lower_margin	= inf->lower_margin;
-	fbi->fb.var.sync		= inf->sync;
-	fbi->fb.var.grayscale		= inf->cmap_greyscale;
+	info->var.bits_per_pixel	= inf->bpp;
+	info->var.pixclock		= inf->pixclock;
+	info->var.hsync_len		= inf->hsync_len;
+	info->var.left_margin		= inf->left_margin;
+	info->var.right_margin		= inf->right_margin;
+	info->var.vsync_len		= inf->vsync_len;
+	info->var.upper_margin		= inf->upper_margin;
+	info->var.lower_margin		= inf->lower_margin;
+	info->var.sync			= inf->sync;
+	info->var.grayscale		= inf->cmap_greyscale;
 	fbi->cmap_inverse		= inf->cmap_inverse;
 	fbi->cmap_static		= inf->cmap_static;
 	fbi->lccr0			= inf->lccr0;
 	fbi->lccr3			= inf->lccr3;
 	fbi->state			= C_STARTUP;
 	fbi->task_state			= (u_char)-1;
-	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
+	info->fix.smem_len		= fbi->max_xres * fbi->max_yres *
 					  fbi->max_bpp / 8;
 
 	init_waitqueue_head(&fbi->ctrlr_wait);
@@ -1760,7 +1761,7 @@
 	if (!request_mem_region(0xb0100000, 0x10000, "LCD"))
 		return -EBUSY;
 
-	fbi = sa1100fb_init_fbinfo();
+	fbi = sa1100fb_init_fbinfo(dev);
 	ret = -ENOMEM;
 	if (!fbi)
 		goto failed;
@@ -1796,11 +1797,11 @@
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
 	 */
-	sa1100fb_check_var(&fbi->fb.var, &fbi->fb);
+	sa1100fb_check_var(&fbi->fb->var, fbi->fb);
 
 	dev_set_drvdata(dev, fbi);
 
-	ret = register_framebuffer(&fbi->fb);
+	ret = register_framebuffer(fbi->fb);
 	if (ret < 0)
 		goto failed;
 
@@ -1819,7 +1820,7 @@
 failed:
 	dev_set_drvdata(dev, NULL);
 	if (fbi)
-		kfree(fbi);
+		kfree(fbi->fb);
 	release_mem_region(0xb0100000, 0x10000);
 	return ret;
 }


======== drivers/video/sa1100fb.h 1.10 ========
D 1.10 03/09/14 00:13:57+02:00 kronos@kronoz.cjb.net 11 10 1/1/145
P drivers/video/sa1100fb.h
C make fb field a pointer
------------------------------------------------

===== drivers/video/sa1100fb.h 1.9 vs 1.10 =====
--- 1.9/drivers/video/sa1100fb.h	Thu Jan 16 14:11:38 2003
+++ 1.10/drivers/video/sa1100fb.h	Sun Sep 14 00:13:57 2003
@@ -62,7 +62,7 @@
 #define NR_RGB	2
 
 struct sa1100fb_info {
-	struct fb_info		fb;
+	struct fb_info		*fb;
 	struct sa1100fb_rgb	*rgb[NR_RGB];
 
 	u_int			max_bpp;


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

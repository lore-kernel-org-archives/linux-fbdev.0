From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] matroxfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:16:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201630.GV16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzmK-0006rQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:57 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzmI-0005Fo-Rc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:55 -0700
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
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/matrox to framebuffer_alloc. Now
fb_info (and minfo) are dynamically allocated. This also voids the need 
of a global matrox_fb_info if CONFIG_FB_MATROX_MULTIHEAD:

======== drivers/video/matrox/i2c-matroxfb.c 1.11 ========
D 1.11 03/09/13 23:48:00+02:00 kronos@kronoz.cjb.net 12 11 1/1/222
P drivers/video/matrox/i2c-matroxfb.c
C minfo->fbcon is now a pointer
------------------------------------------------

===== drivers/video/matrox/i2c-matroxfb.c 1.10 vs 1.11 =====
--- 1.10/drivers/video/matrox/i2c-matroxfb.c	Mon Aug 18 00:33:31 2003
+++ 1.11/drivers/video/matrox/i2c-matroxfb.c	Sat Sep 13 23:48:00 2003
@@ -112,7 +112,7 @@
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
 	snprintf(b->adapter.name, DEVICE_NAME_SIZE, name,
-		minfo->fbcon.node);
+		minfo->fbcon->node);
 	i2c_set_adapdata(&b->adapter, b);
 	b->adapter.algo_data = &b->bac;
 	b->bac = matrox_i2c_algo_template;


======== drivers/video/matrox/matroxfb_accel.c 1.10 ========
D 1.10 03/09/13 23:56:19+02:00 kronos@kronoz.cjb.net 11 10 8/8/497
P drivers/video/matrox/matroxfb_accel.c
C fixes: fbcon is now a pointer
------------------------------------------------

===== drivers/video/matrox/matroxfb_accel.c 1.9 vs 1.10 =====
--- 1.9/drivers/video/matrox/matroxfb_accel.c	Tue May 27 18:56:09 2003
+++ 1.10/drivers/video/matrox/matroxfb_accel.c	Sat Sep 13 23:56:19 2003
@@ -117,16 +117,16 @@
 
 	DBG(__FUNCTION__)
 
-	mpitch = ACCESS_FBINFO(fbcon).var.xres_virtual;
+	mpitch = ACCESS_FBINFO(fbcon)->var.xres_virtual;
 
 	ACCESS_FBINFO(fbops).fb_copyarea = cfb_copyarea;
 	ACCESS_FBINFO(fbops).fb_fillrect = cfb_fillrect;
 	ACCESS_FBINFO(fbops).fb_imageblit = cfb_imageblit;
 	ACCESS_FBINFO(fbops).fb_cursor = soft_cursor;
 
-	accel = (ACCESS_FBINFO(fbcon).var.accel_flags & FB_ACCELF_TEXT) == FB_ACCELF_TEXT;
+	accel = (ACCESS_FBINFO(fbcon)->var.accel_flags & FB_ACCELF_TEXT) == FB_ACCELF_TEXT;
 
-	switch (ACCESS_FBINFO(fbcon).var.bits_per_pixel) {
+	switch (ACCESS_FBINFO(fbcon)->var.bits_per_pixel) {
 		case 4:		maccess = 0x00000000;	/* accelerate as 8bpp video */
 				mpitch = (mpitch >> 1) | 0x8000; /* disable linearization */
 				mopmode = M_OPMODE_4BPP;
@@ -145,7 +145,7 @@
 					ACCESS_FBINFO(fbops).fb_imageblit = matroxfb_imageblit;
 				}
 				break;
-		case 16:	if (ACCESS_FBINFO(fbcon).var.green.length == 5) {
+		case 16:	if (ACCESS_FBINFO(fbcon)->var.green.length == 5) {
 					maccess = 0xC0000001;
 					ACCESS_FBINFO(cmap[16]) = 0x7FFF7FFF;
 				} else {
@@ -281,13 +281,13 @@
 	if ((area->sx | area->dx | area->width) & 1)
 		cfb_copyarea(info, area);
 	else
-		matrox_accel_bmove_lin(PMINFO ACCESS_FBINFO(fbcon.var.xres_virtual) >> 1, area->sy, area->sx >> 1, area->dy, area->dx >> 1, area->height, area->width >> 1);
+		matrox_accel_bmove_lin(PMINFO ACCESS_FBINFO(fbcon->var.xres_virtual) >> 1, area->sy, area->sx >> 1, area->dy, area->dx >> 1, area->height, area->width >> 1);
 }
 
 static void matroxfb_copyarea(struct fb_info* info, const struct fb_copyarea* area) {
 	MINFO_FROM_INFO(info);
 
-	matrox_accel_bmove(PMINFO ACCESS_FBINFO(fbcon.var.xres_virtual), area->sy, area->sx, area->dy, area->dx, area->height, area->width);
+	matrox_accel_bmove(PMINFO ACCESS_FBINFO(fbcon->var.xres_virtual), area->sy, area->sx, area->dy, area->dx, area->height, area->width);
 }
 
 static void matroxfb_accel_clear(WPMINFO u_int32_t color, int sy, int sx, int height,
@@ -343,12 +343,12 @@
 		mga_outl(M_DWGCTL, ACCESS_FBINFO(accel.m_dwg_rect) | M_DWG_REPLACE2);
 		mga_outl(M_FCOL, bgx);
 		mga_outl(M_FXBNDRY, ((sx + width) << 16) | sx);
-		mga_outl(M_YDST, sy * ACCESS_FBINFO(fbcon).var.xres_virtual >> 6);
+		mga_outl(M_YDST, sy * ACCESS_FBINFO(fbcon)->var.xres_virtual >> 6);
 		mga_outl(M_LEN | M_EXEC, height);
 		WaitTillIdle();
 	}
 	if (whattodo) {
-		u_int32_t step = ACCESS_FBINFO(fbcon).var.xres_virtual >> 1;
+		u_int32_t step = ACCESS_FBINFO(fbcon)->var.xres_virtual >> 1;
 		vaddr_t vbase = ACCESS_FBINFO(video.vbase);
 		if (whattodo & 1) {
 			unsigned int uaddr = sy * step + sx - 1;


======== drivers/video/matrox/matroxfb_base.c 1.44 ========
D 1.44 03/09/13 23:50:18+02:00 kronos@kronoz.cjb.net 49 48 71/69/2440
P drivers/video/matrox/matroxfb_base.c
C use framebuffer_alloc
C remove matroxfb_global_mxinfo
------------------------------------------------

===== drivers/video/matrox/matroxfb_base.c 1.43 vs 1.44 =====
--- 1.43/drivers/video/matrox/matroxfb_base.c	Fri Aug 22 08:34:52 2003
+++ 1.44/drivers/video/matrox/matroxfb_base.c	Sat Sep 13 23:50:18 2003
@@ -122,6 +122,7 @@
 #endif
 
 static void matroxfb_unregister_device(struct matrox_fb_info* minfo);
+static void release_matroxfb(struct fb_info *info);
 
 /* --------------------------------------------------------------------- */
 
@@ -157,17 +158,17 @@
 	struct matroxfb_dh_fb_info* info = ACCESS_FBINFO(crtc2.info);
 
 	/* Make sure that displays are compatible */
-	if (info && (info->fbcon.var.bits_per_pixel == ACCESS_FBINFO(fbcon).var.bits_per_pixel)
-	         && (info->fbcon.var.xres_virtual == ACCESS_FBINFO(fbcon).var.xres_virtual)
-	         && (info->fbcon.var.green.length == ACCESS_FBINFO(fbcon).var.green.length)
+	if (info && (info->fbcon->var.bits_per_pixel == ACCESS_FBINFO(fbcon)->var.bits_per_pixel)
+	         && (info->fbcon->var.xres_virtual == ACCESS_FBINFO(fbcon)->var.xres_virtual)
+	         && (info->fbcon->var.green.length == ACCESS_FBINFO(fbcon)->var.green.length)
 	         ) {
-		switch (ACCESS_FBINFO(fbcon).var.bits_per_pixel) {
+		switch (ACCESS_FBINFO(fbcon)->var.bits_per_pixel) {
 			case 16:
 			case 32:
 				pos = pos * 8;
 				if (info->interlaced) {
 					mga_outl(0x3C2C, pos);
-					mga_outl(0x3C28, pos + ACCESS_FBINFO(fbcon).var.xres_virtual * ACCESS_FBINFO(fbcon).var.bits_per_pixel / 8);
+					mga_outl(0x3C28, pos + ACCESS_FBINFO(fbcon)->var.xres_virtual * ACCESS_FBINFO(fbcon)->var.bits_per_pixel / 8);
 				} else {
 					mga_outl(0x3C28, pos);
 				}
@@ -318,9 +319,9 @@
 	if (ACCESS_FBINFO(dead))
 		return;
 
-	ACCESS_FBINFO(fbcon).var.xoffset = var->xoffset;
-	ACCESS_FBINFO(fbcon).var.yoffset = var->yoffset;
-	pos = (ACCESS_FBINFO(fbcon).var.yoffset * ACCESS_FBINFO(fbcon).var.xres_virtual + ACCESS_FBINFO(fbcon).var.xoffset) * ACCESS_FBINFO(curr.final_bppShift) / 32;
+	ACCESS_FBINFO(fbcon)->var.xoffset = var->xoffset;
+	ACCESS_FBINFO(fbcon)->var.yoffset = var->yoffset;
+	pos = (ACCESS_FBINFO(fbcon)->var.yoffset * ACCESS_FBINFO(fbcon)->var.xres_virtual + ACCESS_FBINFO(fbcon)->var.xoffset) * ACCESS_FBINFO(curr.final_bppShift) / 32;
 	pos += ACCESS_FBINFO(curr.ydstorg.chunks);
 	p0 = ACCESS_FBINFO(hw).CRTC[0x0D] = pos & 0xFF;
 	p1 = ACCESS_FBINFO(hw).CRTC[0x0C] = (pos & 0xFF00) >> 8;
@@ -355,6 +356,20 @@
 	CRITEND
 }
 
+static void release_matroxfb(struct fb_info *info) {
+	struct matrox_fb_info *minfo = info->par;
+
+	matroxfb_g450_shutdown(PMINFO2);
+#ifdef CONFIG_MTRR
+	if (ACCESS_FBINFO(mtrr.vram_valid))
+		mtrr_del(ACCESS_FBINFO(mtrr.vram), ACCESS_FBINFO(video.base), ACCESS_FBINFO(video.len));
+#endif
+	mga_iounmap(ACCESS_FBINFO(mmio.vbase));
+	mga_iounmap(ACCESS_FBINFO(video.vbase));
+	release_mem_region(ACCESS_FBINFO(video.base), ACCESS_FBINFO(video.len_maximum));
+	release_mem_region(ACCESS_FBINFO(mmio.base), 16384);
+}
+
 static void matroxfb_remove(WPMINFO int dummy) {
 	/* Currently we are holding big kernel lock on all dead & usecount updates.
 	 * Destroy everything after all users release it. Especially do not unregister
@@ -370,19 +385,7 @@
 		return;
 	}
 	matroxfb_unregister_device(MINFO);
-	unregister_framebuffer(&ACCESS_FBINFO(fbcon));
-	matroxfb_g450_shutdown(PMINFO2);
-#ifdef CONFIG_MTRR
-	if (ACCESS_FBINFO(mtrr.vram_valid))
-		mtrr_del(ACCESS_FBINFO(mtrr.vram), ACCESS_FBINFO(video.base), ACCESS_FBINFO(video.len));
-#endif
-	mga_iounmap(ACCESS_FBINFO(mmio.vbase));
-	mga_iounmap(ACCESS_FBINFO(video.vbase));
-	release_mem_region(ACCESS_FBINFO(video.base), ACCESS_FBINFO(video.len_maximum));
-	release_mem_region(ACCESS_FBINFO(mmio.base), 16384);
-#ifdef CONFIG_FB_MATROX_MULTIHEAD
-	kfree(minfo);
-#endif
+	unregister_framebuffer(ACCESS_FBINFO(fbcon));
 }
 
 	/*
@@ -649,9 +652,7 @@
 			      unsigned blue, unsigned transp,
 			      struct fb_info *fb_info)
 {
-#ifdef CONFIG_FB_MATROX_MULTIHEAD
-	struct matrox_fb_info* minfo = container_of(fb_info, struct matrox_fb_info, fbcon);
-#endif
+	MINFO_FROM_INFO(fb_info);
 
 	DBG(__FUNCTION__)
 
@@ -665,17 +666,17 @@
 	if (regno >= ACCESS_FBINFO(curr.cmap_len))
 		return 1;
 
-	if (ACCESS_FBINFO(fbcon).var.grayscale) {
+	if (ACCESS_FBINFO(fbcon)->var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 	}
 
-	red = CNVT_TOHW(red, ACCESS_FBINFO(fbcon).var.red.length);
-	green = CNVT_TOHW(green, ACCESS_FBINFO(fbcon).var.green.length);
-	blue = CNVT_TOHW(blue, ACCESS_FBINFO(fbcon).var.blue.length);
-	transp = CNVT_TOHW(transp, ACCESS_FBINFO(fbcon).var.transp.length);
+	red = CNVT_TOHW(red, ACCESS_FBINFO(fbcon)->var.red.length);
+	green = CNVT_TOHW(green, ACCESS_FBINFO(fbcon)->var.green.length);
+	blue = CNVT_TOHW(blue, ACCESS_FBINFO(fbcon)->var.blue.length);
+	transp = CNVT_TOHW(transp, ACCESS_FBINFO(fbcon)->var.transp.length);
 
-	switch (ACCESS_FBINFO(fbcon).var.bits_per_pixel) {
+	switch (ACCESS_FBINFO(fbcon)->var.bits_per_pixel) {
 	case 4:
 	case 8:
 		mga_outb(M_DAC_REG, regno);
@@ -686,20 +687,20 @@
 	case 16:
 		{
 			u_int16_t col =
-				(red << ACCESS_FBINFO(fbcon).var.red.offset)     |
-				(green << ACCESS_FBINFO(fbcon).var.green.offset) |
-				(blue << ACCESS_FBINFO(fbcon).var.blue.offset)   |
-				(transp << ACCESS_FBINFO(fbcon).var.transp.offset); /* for 1:5:5:5 */
+				(red << ACCESS_FBINFO(fbcon)->var.red.offset)     |
+				(green << ACCESS_FBINFO(fbcon)->var.green.offset) |
+				(blue << ACCESS_FBINFO(fbcon)->var.blue.offset)   |
+				(transp << ACCESS_FBINFO(fbcon)->var.transp.offset); /* for 1:5:5:5 */
 			ACCESS_FBINFO(cmap[regno]) = col | (col << 16);
 		}
 		break;
 	case 24:
 	case 32:
 		ACCESS_FBINFO(cmap[regno]) =
-			(red   << ACCESS_FBINFO(fbcon).var.red.offset)   |
-			(green << ACCESS_FBINFO(fbcon).var.green.offset) |
-			(blue  << ACCESS_FBINFO(fbcon).var.blue.offset)  |
-			(transp << ACCESS_FBINFO(fbcon).var.transp.offset);	/* 8:8:8:8 */
+			(red   << ACCESS_FBINFO(fbcon)->var.red.offset)   |
+			(green << ACCESS_FBINFO(fbcon)->var.green.offset) |
+			(blue  << ACCESS_FBINFO(fbcon)->var.blue.offset)  |
+			(transp << ACCESS_FBINFO(fbcon)->var.transp.offset);	/* 8:8:8:8 */
 		break;
 	}
 	return 0;
@@ -707,7 +708,7 @@
 
 static void matroxfb_init_fix(WPMINFO2)
 {
-	struct fb_fix_screeninfo *fix = &ACCESS_FBINFO(fbcon).fix;
+	struct fb_fix_screeninfo *fix = &ACCESS_FBINFO(fbcon)->fix;
 	DBG(__FUNCTION__)
 
 	strcpy(fix->id,"MATROX");
@@ -722,7 +723,7 @@
 
 static void matroxfb_update_fix(WPMINFO2)
 {
-	struct fb_fix_screeninfo *fix = &ACCESS_FBINFO(fbcon).fix;
+	struct fb_fix_screeninfo *fix = &ACCESS_FBINFO(fbcon)->fix;
 	DBG(__FUNCTION__)
 
 	fix->smem_start = ACCESS_FBINFO(video.base) + ACCESS_FBINFO(curr.ydstorg.bytes);
@@ -763,12 +764,12 @@
 	var = &info->var;
 	if ((err = matroxfb_decode_var(PMINFO var, &visual, &cmap_len, &ydstorg)) != 0)
 		return err;
-	ACCESS_FBINFO(fbcon.screen_base) = vaddr_va(ACCESS_FBINFO(video.vbase)) + ydstorg;
+	ACCESS_FBINFO(fbcon->screen_base) = vaddr_va(ACCESS_FBINFO(video.vbase)) + ydstorg;
 	matroxfb_update_fix(PMINFO2);
-	ACCESS_FBINFO(fbcon).fix.visual = visual;
-	ACCESS_FBINFO(fbcon).fix.type = FB_TYPE_PACKED_PIXELS;
-	ACCESS_FBINFO(fbcon).fix.type_aux = 0;
-	ACCESS_FBINFO(fbcon).fix.line_length = (var->xres_virtual * var->bits_per_pixel) >> 3;
+	ACCESS_FBINFO(fbcon)->fix.visual = visual;
+	ACCESS_FBINFO(fbcon)->fix.type = FB_TYPE_PACKED_PIXELS;
+	ACCESS_FBINFO(fbcon)->fix.type_aux = 0;
+	ACCESS_FBINFO(fbcon)->fix.line_length = (var->xres_virtual * var->bits_per_pixel) >> 3;
 	{
 		unsigned int pos;
 
@@ -855,7 +856,7 @@
 		vblank->flags |= FB_VBLANK_HBLANKING;
 	if (sts1 & 8)
 		vblank->flags |= FB_VBLANK_VSYNCING;
-	if (vblank->vcount >= ACCESS_FBINFO(fbcon).var.yres)
+	if (vblank->vcount >= ACCESS_FBINFO(fbcon)->var.yres)
 		vblank->flags |= FB_VBLANK_VBLANKING;
 	if (test_bit(0, &ACCESS_FBINFO(irq_flags))) {
 		vblank->flags |= FB_VBLANK_HAVE_COUNT;
@@ -947,7 +948,7 @@
 							down_read(&ACCESS_FBINFO(crtc2.lock));
 							crtc2 = ACCESS_FBINFO(crtc2.info);
 							if (crtc2)
-								crtc2->fbcon.fbops->fb_set_par(&crtc2->fbcon);
+								crtc2->fbcon->fbops->fb_set_par(crtc2->fbcon);
 							up_read(&ACCESS_FBINFO(crtc2.lock));
 						}
 						break;
@@ -1695,11 +1696,11 @@
 	matroxfb_g450_connect(PMINFO2);
 	ACCESS_FBINFO(hw_switch->reset(PMINFO2));
 
-	ACCESS_FBINFO(fbcon.monspecs.hfmin) = 0;
-	ACCESS_FBINFO(fbcon.monspecs.hfmax) = fh;
-	ACCESS_FBINFO(fbcon.monspecs.vfmin) = 0;
-	ACCESS_FBINFO(fbcon.monspecs.vfmax) = fv;
-	ACCESS_FBINFO(fbcon.monspecs.dpms) = 0;	/* TBD */
+	ACCESS_FBINFO(fbcon->monspecs.hfmin) = 0;
+	ACCESS_FBINFO(fbcon->monspecs.hfmax) = fh;
+	ACCESS_FBINFO(fbcon->monspecs.vfmin) = 0;
+	ACCESS_FBINFO(fbcon->monspecs.vfmax) = fv;
+	ACCESS_FBINFO(fbcon->monspecs.dpms) = 0;	/* TBD */
 
 	/* static settings */
 	vesafb_defined.red = colors[depth-1].red;
@@ -1712,17 +1713,17 @@
 		vesafb_defined.accel_flags &= ~FB_ACCELF_TEXT;
 
 	ACCESS_FBINFO(fbops) = matroxfb_ops;
-	ACCESS_FBINFO(fbcon.fbops) = &ACCESS_FBINFO(fbops);
-	ACCESS_FBINFO(fbcon.pseudo_palette) = ACCESS_FBINFO(cmap);
+	ACCESS_FBINFO(fbcon->fbops) = &ACCESS_FBINFO(fbops);
+	ACCESS_FBINFO(fbcon->pseudo_palette) = ACCESS_FBINFO(cmap);
 	/* after __init time we are like module... no logo */
-	ACCESS_FBINFO(fbcon.flags) = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
+	ACCESS_FBINFO(fbcon->flags) = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
 	ACCESS_FBINFO(video.len_usable) &= PAGE_MASK;
-	fb_alloc_cmap(&ACCESS_FBINFO(fbcon.cmap), 256, 1);
+	fb_alloc_cmap(&ACCESS_FBINFO(fbcon->cmap), 256, 1);
 
 #ifndef MODULE
 	/* mode database is marked __init!!! */
 	if (!hotplug) {
-		fb_find_mode(&vesafb_defined, &ACCESS_FBINFO(fbcon), videomode[0]?videomode:NULL,
+		fb_find_mode(&vesafb_defined, ACCESS_FBINFO(fbcon), videomode[0]?videomode:NULL,
 			NULL, 0, &defaultmode, vesafb_defined.bits_per_pixel);
 	}
 #endif /* !MODULE */
@@ -1823,11 +1824,11 @@
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
-	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
+	if (register_framebuffer(ACCESS_FBINFO(fbcon)) < 0) {
 		goto failVideoIO;
 	}
 	printk("fb%d: %s frame buffer device\n",
-	       ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
+	       ACCESS_FBINFO(fbcon->node), ACCESS_FBINFO(fbcon->fix.id));
 	return 0;
 failVideoIO:;
 	matroxfb_g450_shutdown(PMINFO2);
@@ -1926,6 +1927,7 @@
 	u_int16_t svid;
 	u_int16_t sid;
 	struct matrox_fb_info* minfo;
+	struct fb_info* fb_info;
 	int err;
 	u_int32_t cmd;
 #ifndef CONFIG_FB_MATROX_MULTIHEAD
@@ -1955,16 +1957,17 @@
 		return -1;
 	}
 
-#ifdef CONFIG_FB_MATROX_MULTIHEAD
-	minfo = (struct matrox_fb_info*)kmalloc(sizeof(*minfo), GFP_KERNEL);
-	if (!minfo)
-		return -1;
-#else
-	if (registered)	/* singlehead driver... */
+#ifndef CONFIG_FB_MATROX_MULTIHEAD
+	/* FIXME */
+	if (registered) /* singlehead driver... */
 		return -1;
-	minfo = &matroxfb_global_mxinfo;
 #endif
-	memset(MINFO, 0, sizeof(*MINFO));
+	fb_info = framebuffer_alloc(sizeof(*minfo), &pdev->dev);
+	if (!fb_info)
+		return -1;
+	fb_info->release = &release_matroxfb;
+	minfo = fb_info->par;
+	minfo->fbcon = fb_info;
 
 	ACCESS_FBINFO(pcidev) = pdev;
 	ACCESS_FBINFO(dead) = 0;
@@ -2013,9 +2016,8 @@
 		matroxfb_register_device(MINFO);
 		return 0;
 	}
-#ifdef CONFIG_FB_MATROX_MULTIHEAD
 	kfree(minfo);
-#endif
+	
 	return -1;
 }


======== drivers/video/matrox/matroxfb_base.h 1.25 ========
D 1.25 03/09/13 23:51:15+02:00 kronos@kronoz.cjb.net 26 25 2/24/831
P drivers/video/matrox/matroxfb_base.h
C matroxfb_global_mxinfo is gone, remove useless macros
------------------------------------------------

===== drivers/video/matrox/matroxfb_base.h 1.24 vs 1.25 =====
--- 1.24/drivers/video/matrox/matroxfb_base.h	Wed Aug  6 19:06:59 2003
+++ 1.25/drivers/video/matrox/matroxfb_base.h	Sat Sep 13 23:51:15 2003
@@ -436,7 +436,7 @@
 };
 
 struct matrox_fb_info {
-	struct fb_info		fbcon;
+	struct fb_info		*fbcon;
 
 	struct list_head	next_fb;
 
@@ -599,9 +599,6 @@
 	u_int32_t cmap[17];
 };
 
-#define info2minfo(info) container_of(info, struct matrox_fb_info, fbcon)
-
-#ifdef CONFIG_FB_MATROX_MULTIHEAD
 #define ACCESS_FBINFO2(info, x) (info->x)
 #define ACCESS_FBINFO(x) ACCESS_FBINFO2(minfo,x)
 
@@ -615,27 +612,8 @@
 #define PMINFO   PMINFO2 ,
 
 #define MINFO_FROM(x)	   struct matrox_fb_info* minfo = x
-#else
-
-extern struct matrox_fb_info matroxfb_global_mxinfo;
-
-#define ACCESS_FBINFO(x) (matroxfb_global_mxinfo.x)
-#define ACCESS_FBINFO2(info, x) (matroxfb_global_mxinfo.x)
-
-#define MINFO (&matroxfb_global_mxinfo)
-
-#define WPMINFO2 void
-#define WPMINFO
-#define CPMINFO2 void
-#define CPMINFO
-#define PMINFO2
-#define PMINFO
-
-#define MINFO_FROM(x)
-
-#endif
 
-#define MINFO_FROM_INFO(x) MINFO_FROM(info2minfo(x))
+#define MINFO_FROM_INFO(x) MINFO_FROM(x->par)
 
 struct matrox_switch {
 	int	(*preinit)(WPMINFO2);


======== drivers/video/matrox/matroxfb_crtc2.c 1.29 ========
D 1.29 03/09/13 23:54:12+02:00 kronos@kronoz.cjb.net 30 29 65/65/682
P drivers/video/matrox/matroxfb_crtc2.c
C convert to dynamically allocated fb_info
------------------------------------------------

===== drivers/video/matrox/matroxfb_crtc2.c 1.28 vs 1.29 =====
--- 1.28/drivers/video/matrox/matroxfb_crtc2.c	Fri Aug 22 08:27:08 2003
+++ 1.29/drivers/video/matrox/matroxfb_crtc2.c	Sat Sep 13 23:54:12 2003
@@ -29,25 +29,25 @@
 static int matroxfb_dh_setcolreg(unsigned regno, unsigned red, unsigned green,
 		unsigned blue, unsigned transp, struct fb_info* info) {
 	u_int32_t col;
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info* m2info = info->par;
 
 	if (regno >= 16)
 		return 1;
-	if (m2info->fbcon.var.grayscale) {
+	if (m2info->fbcon->var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 	}
-	red = CNVT_TOHW(red, m2info->fbcon.var.red.length);
-	green = CNVT_TOHW(green, m2info->fbcon.var.green.length);
-	blue = CNVT_TOHW(blue, m2info->fbcon.var.blue.length);
-	transp = CNVT_TOHW(transp, m2info->fbcon.var.transp.length);
-
-	col = (red << m2info->fbcon.var.red.offset)     |
-	      (green << m2info->fbcon.var.green.offset) |
-	      (blue << m2info->fbcon.var.blue.offset)   |
-	      (transp << m2info->fbcon.var.transp.offset);
+	red = CNVT_TOHW(red, m2info->fbcon->var.red.length);
+	green = CNVT_TOHW(green, m2info->fbcon->var.green.length);
+	blue = CNVT_TOHW(blue, m2info->fbcon->var.blue.length);
+	transp = CNVT_TOHW(transp, m2info->fbcon->var.transp.length);
+
+	col = (red << m2info->fbcon->var.red.offset)     |
+	      (green << m2info->fbcon->var.green.offset) |
+	      (blue << m2info->fbcon->var.blue.offset)   |
+	      (transp << m2info->fbcon->var.transp.offset);
 
-	switch (m2info->fbcon.var.bits_per_pixel) {
+	switch (m2info->fbcon->var.bits_per_pixel) {
 		case 16:
 			m2info->cmap[regno] = col | (col << 16);
 			break;
@@ -56,7 +56,6 @@
 			break;
 	}
 	return 0;
-#undef m2info
 }
 
 static void matroxfb_dh_restore(struct matroxfb_dh_fb_info* m2info,
@@ -118,7 +117,7 @@
 	mga_outl(0x3C20, ((mt->VSyncEnd - 1) << 16) | (mt->VSyncStart - 1));
 	mga_outl(0x3C24, ((mt->VSyncStart) << 16) | (mt->HSyncStart));	/* preload */
 	{
-		u_int32_t linelen = m2info->fbcon.var.xres_virtual * (m2info->fbcon.var.bits_per_pixel >> 3);
+		u_int32_t linelen = m2info->fbcon->var.xres_virtual * (m2info->fbcon->var.bits_per_pixel >> 3);
 		if (tmp & 0x02000000) {
 			/* field #0 is smaller, so... */
 			mga_outl(0x3C2C, pos);			/* field #1 vmemory start */
@@ -175,11 +174,11 @@
 	unsigned int pixelsize;
 	MINFO_FROM(m2info->primary_dev);
 
-	m2info->fbcon.var.xoffset = var->xoffset;
-	m2info->fbcon.var.yoffset = var->yoffset;
-	pixelsize = m2info->fbcon.var.bits_per_pixel >> 3;
-	linelen = m2info->fbcon.var.xres_virtual * pixelsize;
-	pos = m2info->fbcon.var.yoffset * linelen + m2info->fbcon.var.xoffset * pixelsize;
+	m2info->fbcon->var.xoffset = var->xoffset;
+	m2info->fbcon->var.yoffset = var->yoffset;
+	pixelsize = m2info->fbcon->var.bits_per_pixel >> 3;
+	linelen = m2info->fbcon->var.xres_virtual * pixelsize;
+	pos = m2info->fbcon->var.yoffset * linelen + m2info->fbcon->var.xoffset * pixelsize;
 	pos += m2info->video.offbase;
 	if (m2info->interlaced) {
 		mga_outl(0x3C2C, pos);
@@ -264,7 +263,7 @@
 }
 
 static int matroxfb_dh_open(struct fb_info* info, int user) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	MINFO_FROM(m2info->primary_dev);
 
 	if (MINFO) {
@@ -273,29 +272,27 @@
 		if (ACCESS_FBINFO(dead)) {
 			return -ENXIO;
 		}
-		err = ACCESS_FBINFO(fbops).fb_open(&ACCESS_FBINFO(fbcon), user);
+		err = ACCESS_FBINFO(fbops).fb_open(ACCESS_FBINFO(fbcon), user);
 		if (err) {
 			return err;
 		}
 	}
 	return 0;
-#undef m2info
 }
 
 static int matroxfb_dh_release(struct fb_info* info, int user) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	int err = 0;
 	MINFO_FROM(m2info->primary_dev);
 
 	if (MINFO) {
-		err = ACCESS_FBINFO(fbops).fb_release(&ACCESS_FBINFO(fbcon), user);
+		err = ACCESS_FBINFO(fbops).fb_release(ACCESS_FBINFO(fbcon), user);
 	}
 	return err;
-#undef m2info
 }
 
 static void matroxfb_dh_init_fix(struct matroxfb_dh_fb_info *m2info) {
-	struct fb_fix_screeninfo *fix = &m2info->fbcon.fix;
+	struct fb_fix_screeninfo *fix = &m2info->fbcon->fix;
 
 	strcpy(fix->id, "MATROX DH");
 
@@ -310,17 +307,16 @@
 }
 
 static int matroxfb_dh_check_var(struct fb_var_screeninfo* var, struct fb_info* info) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	int visual;
 	int cmap_len;
 	int mode;
 
 	return matroxfb_dh_decode_var(m2info, var, &visual, &cmap_len, &mode);
-#undef m2info
 }
 
 static int matroxfb_dh_set_par(struct fb_info* info) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	int visual;
 	int cmap_len;
 	int mode;
@@ -332,11 +328,11 @@
 		return err;
 	/* cmap */
 	{
-		m2info->fbcon.screen_base = vaddr_va(m2info->video.vbase);
-		m2info->fbcon.fix.visual = visual;
-		m2info->fbcon.fix.type = FB_TYPE_PACKED_PIXELS;
-		m2info->fbcon.fix.type_aux = 0;
-		m2info->fbcon.fix.line_length = (var->xres_virtual * var->bits_per_pixel) >> 3;
+		m2info->fbcon->screen_base = vaddr_va(m2info->video.vbase);
+		m2info->fbcon->fix.visual = visual;
+		m2info->fbcon->fix.type = FB_TYPE_PACKED_PIXELS;
+		m2info->fbcon->fix.type_aux = 0;
+		m2info->fbcon->fix.line_length = (var->xres_virtual * var->bits_per_pixel) >> 3;
 	}
 	{
 		struct my_timming mt;
@@ -344,12 +340,12 @@
 		int out;
 		int cnt;
 
-		matroxfb_var2my(&m2info->fbcon.var, &mt);
+		matroxfb_var2my(&m2info->fbcon->var, &mt);
 		mt.crtc = MATROXFB_SRC_CRTC2;
 		/* CRTC2 delay */
 		mt.delay = 34;
 
-		pos = (m2info->fbcon.var.yoffset * m2info->fbcon.var.xres_virtual + m2info->fbcon.var.xoffset) * m2info->fbcon.var.bits_per_pixel >> 3;
+		pos = (m2info->fbcon->var.yoffset * m2info->fbcon->var.xres_virtual + m2info->fbcon->var.xoffset) * m2info->fbcon->var.bits_per_pixel >> 3;
 		pos += m2info->video.offbase;
 		cnt = 0;
 		down_read(&ACCESS_FBINFO(altout).lock);
@@ -388,14 +384,12 @@
 		matroxfb_dh_cfbX_init(m2info);
 	}
 	return 0;
-#undef m2info
 }
 
 static int matroxfb_dh_pan_display(struct fb_var_screeninfo* var, struct fb_info* info) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	matroxfb_dh_pan_var(m2info, var);
 	return 0;
-#undef m2info
 }
 
 static int matroxfb_dh_get_vblank(const struct matroxfb_dh_fb_info* m2info, struct fb_vblank* vblank) {
@@ -407,7 +401,7 @@
 	/* mask out reserved bits + field number (odd/even) */
 	vblank->vcount = mga_inl(0x3C48) & 0x000007FF;
 	/* compatibility stuff */
-	if (vblank->vcount >= m2info->fbcon.var.yres)
+	if (vblank->vcount >= m2info->fbcon->var.yres)
 		vblank->flags |= FB_VBLANK_VBLANKING;
         if (test_bit(0, &ACCESS_FBINFO(irq_flags))) {
                 vblank->flags |= FB_VBLANK_HAVE_COUNT;
@@ -423,7 +417,7 @@
 		unsigned int cmd,
 		unsigned long arg,
 		struct fb_info* info) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
+	struct matroxfb_dh_fb_info *m2info = info->par;
 	MINFO_FROM(m2info->primary_dev);
 
 	DBG(__FUNCTION__)
@@ -456,7 +450,7 @@
 		case MATROXFB_GET_OUTPUT_MODE:
 		case MATROXFB_GET_ALL_OUTPUTS:
 			{
-				return ACCESS_FBINFO(fbcon.fbops)->fb_ioctl(inode, file, cmd, arg, &ACCESS_FBINFO(fbcon));
+				return ACCESS_FBINFO(fbcon->fbops)->fb_ioctl(inode, file, cmd, arg, ACCESS_FBINFO(fbcon));
 			}
 		case MATROXFB_SET_OUTPUT_CONNECTION:
 			{
@@ -545,11 +539,9 @@
 			}
 	}
 	return -ENOTTY;
-#undef m2info
 }
 
 static int matroxfb_dh_blank(int blank, struct fb_info* info) {
-#define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
 	switch (blank) {
 		case 1:
 		case 2:
@@ -559,7 +551,6 @@
 	}
 	/* do something... */
 	return 0;
-#undef m2info
 }
 
 static struct fb_ops matroxfb_dh_ops = {
@@ -601,12 +592,11 @@
 #define minfo (m2info->primary_dev)
 	void* oldcrtc2;
 
-	m2info->fbcon.fbops = &matroxfb_dh_ops;
-	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
-	m2info->fbcon.currcon = -1;
-	m2info->fbcon.pseudo_palette = m2info->cmap;
-	m2info->fbcon.dev = &m2info->primary_dev->pcidev->dev;
-	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
+	m2info->fbcon->fbops = &matroxfb_dh_ops;
+	m2info->fbcon->flags = FBINFO_FLAG_DEFAULT;
+	m2info->fbcon->currcon = -1;
+	m2info->fbcon->pseudo_palette = m2info->cmap;
+	fb_alloc_cmap(&m2info->fbcon->cmap, 256, 1);
 
 	if (mem < 64)
 		mem *= 1024;
@@ -639,11 +629,12 @@
 	}
 
 	matroxfb_dh_init_fix(m2info);
-	if (register_framebuffer(&m2info->fbcon)) {
+	if (register_framebuffer(m2info->fbcon)) {
+		kfree(m2info->fbcon);
 		return -ENXIO;
 	}
-	if (m2info->fbcon.currcon < 0) {
-		fb_set_var(&m2info->fbcon, &matroxfb_dh_defined);
+	if (m2info->fbcon->currcon < 0) {
+		fb_set_var(m2info->fbcon, &matroxfb_dh_defined);
 	}
 	down_write(&ACCESS_FBINFO(crtc2.lock));
 	oldcrtc2 = ACCESS_FBINFO(crtc2.info);
@@ -666,12 +657,21 @@
 		return -1;
 	}
 	printk(KERN_INFO "matroxfb_crtc2: secondary head of fb%u was registered as fb%u\n",
-		ACCESS_FBINFO(fbcon.node), m2info->fbcon.node);
+		ACCESS_FBINFO(fbcon->node), m2info->fbcon->node);
 	m2info->fbcon_registered = 1;
 	return 0;
 #undef minfo
 }
 
+static void release_matroxfb_dh(struct fb_info *info) {
+	struct matroxfb_dh_fb_info *m2info = info->par;
+#define minfo (m2info->primary_dev)
+	
+	/* return memory back to primary head */
+	ACCESS_FBINFO(video.len_usable) += m2info->video.borrowed;
+#undef minfo
+}
+
 static void matroxfb_dh_deregisterfb(struct matroxfb_dh_fb_info* m2info) {
 #define minfo (m2info->primary_dev)
 	if (m2info->fbcon_registered) {
@@ -689,31 +689,32 @@
 			printk(KERN_ERR "matroxfb_crtc2: Expect kernel crash after module unload.\n");
 			return;
 		}
-		id = m2info->fbcon.node;
-		unregister_framebuffer(&m2info->fbcon);
-		/* return memory back to primary head */
-		ACCESS_FBINFO(video.len_usable) += m2info->video.borrowed;
+		id = m2info->fbcon->node;
+		unregister_framebuffer(m2info->fbcon);
 		printk(KERN_INFO "matroxfb_crtc2: fb%u unregistered\n", id);
-		m2info->fbcon_registered = 0;
 	}
 #undef minfo
 }
 
 static void* matroxfb_crtc2_probe(struct matrox_fb_info* minfo) {
 	struct matroxfb_dh_fb_info* m2info;
+	struct fb_info *fb_info;
 
 	/* hardware is CRTC2 incapable... */
 	if (!ACCESS_FBINFO(devflags.crtc2))
 		return NULL;
-	m2info = (struct matroxfb_dh_fb_info*)kmalloc(sizeof(*m2info), GFP_KERNEL);
-	if (!m2info) {
+	fb_info = framebuffer_alloc(sizeof(*m2info), &minfo->pcidev->dev);
+	if (!fb_info) {
 		printk(KERN_ERR "matroxfb_crtc2: Not enough memory for CRTC2 control structs\n");
 		return NULL;
 	}
-	memset(m2info, 0, sizeof(*m2info));
+	fb_info->release = &release_matroxfb_dh;
+	m2info = fb_info->par;
+	m2info->fbcon = fb_info;
+
 	m2info->primary_dev = MINFO;
 	if (matroxfb_dh_registerfb(m2info)) {
-		kfree(m2info);
+		kfree(fb_info);
 		printk(KERN_ERR "matroxfb_crtc2: CRTC2 framebuffer failed to register\n");
 		return NULL;
 	}
@@ -722,7 +723,6 @@
 
 static void matroxfb_crtc2_remove(struct matrox_fb_info* minfo, void* crtc2) {
 	matroxfb_dh_deregisterfb(crtc2);
-	kfree(crtc2);
 }
 
 static struct matroxfb_driver crtc2 = {


======== drivers/video/matrox/matroxfb_crtc2.h 1.6 ========
D 1.6 03/09/13 23:54:32+02:00 kronos@kronoz.cjb.net 7 6 1/1/34
P drivers/video/matrox/matroxfb_crtc2.h
C make fbcon a pointer
------------------------------------------------

===== drivers/video/matrox/matroxfb_crtc2.h 1.5 vs 1.6 =====
--- 1.5/drivers/video/matrox/matroxfb_crtc2.h	Wed Aug  6 18:52:41 2003
+++ 1.6/drivers/video/matrox/matroxfb_crtc2.h	Sat Sep 13 23:54:32 2003
@@ -7,7 +7,7 @@
 #include "matroxfb_base.h"
 
 struct matroxfb_dh_fb_info {
-	struct fb_info		fbcon;
+	struct fb_info		*fbcon;
 	int			fbcon_registered;
 
 	struct matrox_fb_info*	primary_dev;


======== drivers/video/matrox/matroxfb_misc.c 1.11 ========
D 1.11 03/09/13 23:55:14+02:00 kronos@kronoz.cjb.net 12 11 1/5/772
P drivers/video/matrox/matroxfb_misc.c
C remove matroxfb_global_mxinfo
C fix: fbcon is a pointer
------------------------------------------------

===== drivers/video/matrox/matroxfb_misc.c 1.10 vs 1.11 =====
--- 1.10/drivers/video/matrox/matroxfb_misc.c	Tue May 27 19:13:40 2003
+++ 1.11/drivers/video/matrox/matroxfb_misc.c	Sat Sep 13 23:55:14 2003
@@ -278,7 +278,7 @@
 	if (((ht & 0x07) == 0x06) || ((ht & 0x0F) == 0x04))
 		ht++;
 	hbe = ht;
-	wd = ACCESS_FBINFO(fbcon).var.xres_virtual * ACCESS_FBINFO(curr.final_bppShift) / 64;
+	wd = ACCESS_FBINFO(fbcon)->var.xres_virtual * ACCESS_FBINFO(curr.final_bppShift) / 64;
 
 	hw->CRTCEXT[0] = 0;
 	hw->CRTCEXT[5] = 0;
@@ -764,10 +764,6 @@
 EXPORT_SYMBOL(matroxfb_DAC_out);
 EXPORT_SYMBOL(matroxfb_var2my);
 EXPORT_SYMBOL(matroxfb_PLL_calcclock);
-#ifndef CONFIG_FB_MATROX_MULTIHEAD
-struct matrox_fb_info matroxfb_global_mxinfo;
-EXPORT_SYMBOL(matroxfb_global_mxinfo);
-#endif
 EXPORT_SYMBOL(matroxfb_vgaHWinit);		/* DAC1064, Ti3026 */
 EXPORT_SYMBOL(matroxfb_vgaHWrestore);		/* DAC1064, Ti3026 */
 EXPORT_SYMBOL(matroxfb_read_pins);


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

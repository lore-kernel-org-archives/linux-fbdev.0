From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] amifb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:36:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915193640.GD16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzAH-0003RH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:37:37 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzAF-0001ih-Ux
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:37:36 -0700
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
To: geert@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/amifb.c to framebuffer_alloc:

======== drivers/video/amifb.c 1.29 ========
D 1.29 03/09/13 00:33:55+02:00 kronos@kronoz.cjb.net 33 32 70/50/3778
P drivers/video/amifb.c
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/amifb.c 1.28 vs 1.29 =====
--- 1.28/drivers/video/amifb.c	Tue May 27 02:51:43 2003
+++ 1.29/drivers/video/amifb.c	Sat Sep 13 00:33:55 2003
@@ -774,15 +774,7 @@
 	u_short fmode;		/* vmode */
 } currentpar;
 
-
-static struct fb_info fb_info = {
-    .fix = {
-	.id		= "Amiga ",
-	.visual		= FB_VISUAL_PSEUDOCOLOR,
-	.accel		= FB_ACCEL_AMIGABLITT
-    }
-};
-
+static struct fb_info *fb_info;
 
 	/*
 	 *  Saved color entry 0 so we can restore it when unblanking
@@ -1140,6 +1132,7 @@
 
 int amifb_init(void);
 static void amifb_deinit(void);
+static void release_amifb(struct fb_info *);
 
 	/*
 	 * Internal routines
@@ -1220,10 +1213,10 @@
 	if (hmax <= 0 || hmax <= hmin)
 		return;
 
-	fb_info.monspecs.vfmin = vmin;
-	fb_info.monspecs.vfmax = vmax;
-	fb_info.monspecs.hfmin = hmin;
-	fb_info.monspecs.hfmax = hmax;
+	fb_info->monspecs.vfmin = vmin;
+	fb_info->monspecs.vfmax = vmax;
+	fb_info->monspecs.hfmin = hmin;
+	fb_info->monspecs.hfmax = hmax;
 }
 
 int __init amifb_setup(char *options)
@@ -1233,6 +1226,17 @@
 	if (!options || !*options)
 		return 0;
 
+	if (!fb_info) {
+		fb_info = framebuffer_alloc(0, NULL);
+		if (!fb_info)
+			return -ENOMEM;
+
+		strcpy(fb_info->fix.id, "Amiga ");
+		fb_info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		fb_info->fix.accel = FB_ACCEL_AMIGABLITT;
+		fb_info->release = &release_amifb;
+	}
+
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
@@ -2277,12 +2281,23 @@
 				"amifb [Denise/Lisa]"))
 		return -EBUSY;
 
+	if (!fb_info) {
+		fb_info = framebuffer_alloc(0, NULL);
+		if (!fb_info)
+			return -ENOMEM;
+
+		strcpy(fb_info->fix.id, "Amiga ");
+		fb_info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		fb_info->fix.accel = FB_ACCEL_AMIGABLITT;
+		fb_info->release = &release_amifb;
+	}
+
 	custom.dmacon = DMAF_ALL | DMAF_MASTER;
 
 	switch (amiga_chipset) {
 #ifdef CONFIG_FB_AMIGA_OCS
 		case CS_OCS:
-			strcat(fb_info.fix.id, "OCS");
+			strcat(fb_info->fix.id, "OCS");
 default_chipset:
 			chipset = TAG_OCS;
 			maxdepth[TAG_SHRES] = 0;	/* OCS means no SHRES */
@@ -2291,13 +2306,13 @@
 			maxfmode = TAG_FMODE_1;
 			defmode = amiga_vblank == 50 ? DEFMODE_PAL
 						     : DEFMODE_NTSC;
-			fb_info.fix.smem_len = VIDEOMEMSIZE_OCS;
+			fb_info->fix.smem_len = VIDEOMEMSIZE_OCS;
 			break;
 #endif /* CONFIG_FB_AMIGA_OCS */
 
 #ifdef CONFIG_FB_AMIGA_ECS
 		case CS_ECS:
-			strcat(fb_info.fix.id, "ECS");
+			strcat(fb_info->fix.id, "ECS");
 			chipset = TAG_ECS;
 			maxdepth[TAG_SHRES] = 2;
 			maxdepth[TAG_HIRES] = 4;
@@ -2311,15 +2326,15 @@
 							 : DEFMODE_NTSC;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
 			    VIDEOMEMSIZE_ECS_1M)
-				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_2M;
+				fb_info->fix.smem_len = VIDEOMEMSIZE_ECS_2M;
 			else
-				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_1M;
+				fb_info->fix.smem_len = VIDEOMEMSIZE_ECS_1M;
 			break;
 #endif /* CONFIG_FB_AMIGA_ECS */
 
 #ifdef CONFIG_FB_AMIGA_AGA
 		case CS_AGA:
-			strcat(fb_info.fix.id, "AGA");
+			strcat(fb_info->fix.id, "AGA");
 			chipset = TAG_AGA;
 			maxdepth[TAG_SHRES] = 8;
 			maxdepth[TAG_HIRES] = 8;
@@ -2328,16 +2343,16 @@
 			defmode = DEFMODE_AGA;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
 			    VIDEOMEMSIZE_AGA_1M)
-				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_2M;
+				fb_info->fix.smem_len = VIDEOMEMSIZE_AGA_2M;
 			else
-				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_1M;
+				fb_info->fix.smem_len = VIDEOMEMSIZE_AGA_1M;
 			break;
 #endif /* CONFIG_FB_AMIGA_AGA */
 
 		default:
 #ifdef CONFIG_FB_AMIGA_OCS
 			printk("Unknown graphics chipset, defaulting to OCS\n");
-			strcat(fb_info.fix.id, "Unknown");
+			strcat(fb_info->fix.id, "Unknown");
 			goto default_chipset;
 #else /* CONFIG_FB_AMIGA_OCS */
 			err = -ENXIO;
@@ -2373,31 +2388,31 @@
 	/*
 	 *  These monitor specs are for a typical Amiga monitor (e.g. A1960)
 	 */
-	if (fb_info.monspecs.hfmin == 0) {
-	    fb_info.monspecs.hfmin = 15000;
-	    fb_info.monspecs.hfmax = 38000;
-	    fb_info.monspecs.vfmin = 49;
-	    fb_info.monspecs.vfmax = 90;
+	if (fb_info->monspecs.hfmin == 0) {
+	    fb_info->monspecs.hfmin = 15000;
+	    fb_info->monspecs.hfmax = 38000;
+	    fb_info->monspecs.vfmin = 49;
+	    fb_info->monspecs.vfmax = 90;
 	}
 
-	fb_info.fbops = &amifb_ops;
-	fb_info.par = &currentpar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->fbops = &amifb_ops;
+	fb_info->par = &currentpar;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
 
-	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, ami_modedb,
+	if (!fb_find_mode(&fb_info->var, fb_info, mode_option, ami_modedb,
 			  NUM_TOTAL_MODES, &ami_modedb[defmode], 4)) {
 		err = -EINVAL;
 		goto amifb_error;
 	}
 
 	round_down_bpp = 0;
-	chipptr = chipalloc(fb_info.fix.smem_len+
+	chipptr = chipalloc(fb_info->fix.smem_len+
 	                    SPRITEMEMSIZE+
 	                    DUMMYSPRITEMEMSIZE+
 	                    COPINITSIZE+
 	                    4*COPLISTSIZE);
 
-	assignchunk(videomemory, u_long, chipptr, fb_info.fix.smem_len);
+	assignchunk(videomemory, u_long, chipptr, fb_info->fix.smem_len);
 	assignchunk(spritememory, u_long, chipptr, SPRITEMEMSIZE);
 	assignchunk(dummysprite, u_short *, chipptr, DUMMYSPRITEMEMSIZE);
 	assignchunk(copdisplay.init, copins *, chipptr, COPINITSIZE);
@@ -2409,15 +2424,15 @@
 	/*
 	 * access the videomem with writethrough cache
 	 */
-	fb_info.fix.smem_start = (u_long)ZTWO_PADDR(videomemory);
-	videomemory = (u_long)ioremap_writethrough(fb_info.fix.smem_start,
-						   fb_info.fix.smem_len);
+	fb_info->fix.smem_start = (u_long)ZTWO_PADDR(videomemory);
+	videomemory = (u_long)ioremap_writethrough(fb_info->fix.smem_start,
+						   fb_info->fix.smem_len);
 	if (!videomemory) {
 		printk("amifb: WARNING! unable to map videomem cached writethrough\n");
-		videomemory = ZTWO_VADDR(fb_info.fix.smem_start);
+		videomemory = ZTWO_VADDR(fb_info->fix.smem_start);
 	}
 
-	fb_info.screen_base = (char *)videomemory;
+	fb_info->screen_base = (char *)videomemory;
 	memset(dummysprite, 0, DUMMYSPRITEMEMSIZE);
 
 	/*
@@ -2439,15 +2454,15 @@
 		goto amifb_error;
 	}
 
-	fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
+	fb_alloc_cmap(&fb_info->cmap, 1<<fb_info->var.bits_per_pixel, 0);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(fb_info) < 0) {
 		err = -EINVAL;
 		goto amifb_error;
 	}
 
 	printk("fb%d: %s frame buffer device, using %dK of video memory\n",
-	       fb_info.node, fb_info.fix.id, fb_info.fix.smem_len>>10);
+	       fb_info->node, fb_info->fix.id, fb_info->fix.smem_len>>10);
 
 	return 0;
 
@@ -2458,7 +2473,8 @@
 
 static void amifb_deinit(void)
 {
-	fb_dealloc_cmap(&fb_info.cmap);
+	fb_dealloc_cmap(&fb_info->cmap);
+	kfree(fb_info);
 	chipfree();
 	release_mem_region(CUSTOM_PHYSADDR+0xe0, 0x120);
 	custom.dmacon = DMAF_ALL | DMAF_MASTER;
@@ -2850,14 +2866,14 @@
 	if (amifb_ilbm) {
 		par->next_plane = div8(upx(16<<maxfmode, par->vxres));
 		par->next_line = par->bpp*par->next_plane;
-		if (par->next_line * par->vyres > fb_info.fix.smem_len) {
+		if (par->next_line * par->vyres > fb_info->fix.smem_len) {
 			DPRINTK("too few video mem\n");
 			return -EINVAL;
 		}
 	} else {
 		par->next_line = div8(upx(16<<maxfmode, par->vxres));
 		par->next_plane = par->vyres*par->next_line;
-		if (par->next_plane * par->bpp > fb_info.fix.smem_len) {
+		if (par->next_plane * par->bpp > fb_info->fix.smem_len) {
 			DPRINTK("too few video mem\n");
 			return -EINVAL;
 		}
@@ -3089,16 +3105,16 @@
 		par->bpl1mod = par->bpl2mod;
 
 	if (par->yoffset) {
-		par->bplpt0 = fb_info.fix.smem_start + par->next_line*par->yoffset + move;
+		par->bplpt0 = fb_info->fix.smem_start + par->next_line*par->yoffset + move;
 		if (par->vmode & FB_VMODE_YWRAP) {
 			if (par->yoffset > par->vyres-par->yres) {
-				par->bplpt0wrap = fb_info.fix.smem_start + move;
+				par->bplpt0wrap = fb_info->fix.smem_start + move;
 				if (par->bplcon0 & BPC0_LACE && mod2(par->diwstrt_v+par->vyres-par->yoffset))
 					par->bplpt0wrap += par->next_line;
 			}
 		}
 	} else
-		par->bplpt0 = fb_info.fix.smem_start + move;
+		par->bplpt0 = fb_info->fix.smem_start + move;
 
 	if (par->bplcon0 & BPC0_LACE && mod2(par->diwstrt_v))
 		par->bplpt0 += par->next_line;
@@ -3810,6 +3826,12 @@
 	}
 }
 
+static void release_amifb(struct fb_info *info) {
+	amifb_deinit();
+	amifb_video_off();
+	
+	fb_info = NULL;
+}
 
 #ifdef MODULE
 MODULE_LICENSE("GPL");
@@ -3821,8 +3843,6 @@
 
 void cleanup_module(void)
 {
-	unregister_framebuffer(&fb_info);
-	amifb_deinit();
-	amifb_video_off();
+	unregister_framebuffer(fb_info);
 }
 #endif /* MODULE */

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

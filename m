From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 4/5]: i810fb fixes
Date: 16 Feb 2003 14:08:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045375698.1823.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aZkEjihxk2CDrYRdhZtm"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kI0W-0005gz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Feb 2003 22:10:32 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-aZkEjihxk2CDrYRdhZtm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch (linux-2.5.61 + James' fbdev.diff) to update i810fb:

1.  added suspend/resume hooks to pci_driver.  This is needed to
save/recover GART mappings during suspends/resumes.  These are also
necessary for swsusp (software suspend) to work.

2.  Fix compilation warnings.

Tony




--=-aZkEjihxk2CDrYRdhZtm
Content-Disposition: attachment; filename=i810fb2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=i810fb2.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/i810/i810.h linux-2.5.61-ad/dri=
vers/video/i810/i810.h
--- linux-2.5.61-fbdev/drivers/video/i810/i810.h	2003-02-16 00:55:52.000000=
000 +0000
+++ linux-2.5.61-ad/drivers/video/i810/i810.h	2003-02-16 04:50:15.000000000=
 +0000
@@ -256,6 +256,7 @@
 	drm_agp_t                *drm_agp;
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
+	u32 pci_state[16];
 	unsigned long mmio_start_phys;
 	u8 *mmio_start_virtual;
 	u32 cursor_reset;
@@ -273,6 +274,7 @@
 	u32 depth;
 	u32 blit_bpp;
 	u32 ovract;
+	u32 cur_state;
 	int mtrr_reg;
 	u16 bltcntl;
 	u8 interlace;
diff -Naur linux-2.5.61-fbdev/drivers/video/i810/i810_accel.c linux-2.5.61-=
ad/drivers/video/i810/i810_accel.c
--- linux-2.5.61-fbdev/drivers/video/i810/i810_accel.c	2003-02-16 00:55:52.=
000000000 +0000
+++ linux-2.5.61-ad/drivers/video/i810/i810_accel.c	2003-02-16 04:50:11.000=
000000 +0000
@@ -315,19 +315,19 @@
 	i810_writel(IRING + 12, mmio, tmp);
 }      =20
=20
-void i810fb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+void i810fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	u32 dx, dy, width, height, dest, rop =3D 0, color =3D 0;
=20
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
 	    par->depth =3D=3D 4)=20
-		return cfb_fillrect(p, rect);
+		return cfb_fillrect(info, rect);
=20
 	if (par->depth =3D=3D 1)=20
 		color =3D rect->color;
 	else=20
-		color =3D ((u32 *) (p->pseudo_palette))[rect->color];
+		color =3D ((u32 *) (info->pseudo_palette))[rect->color];
=20
 	rop =3D i810fb_rop[rect->rop];
=20
@@ -336,19 +336,19 @@
 	dy =3D rect->dy;
 	height =3D rect->height;
=20
-	dest =3D p->fix.smem_start + (dy * p->fix.line_length) + dx;
-	color_blit(width, height, p->fix.line_length, dest, rop, color,=20
+	dest =3D info->fix.smem_start + (dy * info->fix.line_length) + dx;
+	color_blit(width, height, info->fix.line_length, dest, rop, color,=20
 		   par->blit_bpp, par);
 }
 =09
-void i810fb_copyarea(struct fb_info *p, struct fb_copyarea *region)=20
+void i810fb_copyarea(struct fb_info *info, const struct fb_copyarea *regio=
n)=20
 {
-	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	u32 sx, sy, dx, dy, pitch, width, height, src, dest, xdir;
=20
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
 	    par->depth =3D=3D 4)
-		return cfb_copyarea(p, region);
+		return cfb_copyarea(info, region);
=20
 	dx =3D region->dx * par->depth;
 	sx =3D region->sx * par->depth;
@@ -366,66 +366,68 @@
 		dx +=3D width - 1;
 	}
 	if (dy <=3D sy) {
-		pitch =3D p->fix.line_length;
+		pitch =3D info->fix.line_length;
 	}
 	else {
-		pitch =3D (-(p->fix.line_length)) & 0xFFFF;
+		pitch =3D (-(info->fix.line_length)) & 0xFFFF;
 		sy +=3D height - 1;
 		dy +=3D height - 1;
 	}
-	src =3D p->fix.smem_start + (sy * p->fix.line_length) + sx;
-	dest =3D p->fix.smem_start + (dy * p->fix.line_length) + dx;
+	src =3D info->fix.smem_start + (sy * info->fix.line_length) + sx;
+	dest =3D info->fix.smem_start + (dy * info->fix.line_length) + dx;
=20
 	source_copy_blit(width, height, pitch, xdir, src, dest,
 			 PAT_COPY_ROP, par->blit_bpp, par);
 }
=20
-void i810fb_imageblit(struct fb_info *p, struct fb_image *image)
+void i810fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	u32 fg =3D 0, bg =3D 0, s_pitch, d_pitch, size, offset, dst, i, j;
 	u8 *s_addr, *d_addr;
 =09
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
-	    par->depth =3D=3D 4 || image->depth !=3D 1)=20
-		return cfb_imageblit(p, image);
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
+	    par->depth =3D=3D 4 || image->depth !=3D 0)=20
+		return cfb_imageblit(info, image);
=20
-	switch (p->var.bits_per_pixel) {
+	switch (info->var.bits_per_pixel) {
 	case 8:
 		fg =3D image->fg_color;
 		bg =3D image->bg_color;
 		break;
 	case 16:
 	case 24:
-		fg =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
-		bg =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
+		fg =3D ((u32 *)(info->pseudo_palette))[image->fg_color];
+		bg =3D ((u32 *)(info->pseudo_palette))[image->bg_color];
 		break;
 	}=09
 =09
-	dst =3D p->fix.smem_start + (image->dy * p->fix.line_length) +=20
+	dst =3D info->fix.smem_start + (image->dy * info->fix.line_length) +=20
 		(image->dx * par->depth);
=20
 	s_pitch =3D (image->width+7)/8;
 	d_pitch =3D (s_pitch + 1) & ~1;
-=09
-	size =3D (d_pitch * image->height) + 7;
-	size &=3D ~7;
-
-	if (image->width & 15) {
+	size =3D d_pitch * image->height;
+	if (s_pitch !=3D d_pitch || size & 7) {
+		size +=3D 7;
+		size &=3D ~7;
 		offset =3D get_buffer_offset(size, par);	=09
 		d_addr =3D par->pixmap.virtual + offset;
-		s_addr =3D image->data;
+		s_addr =3D (u8 *) image->data;
 	=09
-		for (i =3D image->height; i--; ) {
-			for (j =3D 0; j < s_pitch; j++)=20
-				i810_writeb(j, d_addr, s_addr[j]);
-			s_addr +=3D s_pitch;
-			d_addr +=3D d_pitch;
+		if (s_pitch =3D=3D d_pitch) {
+			memcpy_toio(d_addr, s_addr, s_pitch * image->height);
+		} else {=20
+			for (i =3D image->height; i--; ) {
+				for (j =3D 0; j < s_pitch; j++)=20
+					i810_writeb(j, d_addr, s_addr[j]);
+				s_addr +=3D s_pitch;
+				d_addr +=3D d_pitch;
+			}
 		}
-	=09
 		mono_src_copy_blit(image->width * par->depth, image->height,=20
-				   p->fix.line_length, size/8, par->blit_bpp,
-				   PAT_COPY_ROP, dst,=20
+				   info->fix.line_length, size/8,=20
+				   par->blit_bpp, PAT_COPY_ROP, dst,=20
 				   par->pixmap.physical + offset,
 				   bg, fg, par);
 	}
@@ -434,18 +436,18 @@
 	 */
 	else {
 		mono_src_copy_imm_blit(image->width * par->depth,=20
-				       image->height, p->fix.line_length,=20
+				       image->height, info->fix.line_length,=20
 				       size/4, par->blit_bpp,
 				       PAT_COPY_ROP, dst, (u32 *) image->data,=20
 				       bg, fg, par);
 	}=20
 }
=20
-int i810fb_sync(struct fb_info *p)
+int i810fb_sync(struct fb_info *info)
 {
-	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 =09
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP)
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
 		return 0;
=20
 	return wait_for_engine_idle(par);
diff -Naur linux-2.5.61-fbdev/drivers/video/i810/i810_main.c linux-2.5.61-a=
d/drivers/video/i810/i810_main.c
--- linux-2.5.61-fbdev/drivers/video/i810/i810_main.c	2003-02-16 00:55:52.0=
00000000 +0000
+++ linux-2.5.61-ad/drivers/video/i810/i810_main.c	2003-02-16 04:50:11.0000=
00000 +0000
@@ -1437,6 +1437,68 @@
 };
=20
 /***********************************************************************
+ *                         Power Management                            *
+ ***********************************************************************/
+static int i810fb_suspend(struct pci_dev *dev, u32 state)
+{
+	struct fb_info *info =3D pci_get_drvdata(dev);
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
+	int blank =3D 0, prev_state =3D par->cur_state;
+
+	if (state =3D=3D prev_state)
+		return 0;
+
+	par->cur_state =3D state;
+
+	switch (state) {
+	case 1:
+		blank =3D VESA_VSYNC_SUSPEND;
+		break;
+	case 2:
+		blank =3D VESA_HSYNC_SUSPEND;
+		break;
+	case 3:
+		blank =3D VESA_POWERDOWN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	info->fbops->fb_blank(blank, info);
+
+	if (!prev_state) {=20
+		par->drm_agp->unbind_memory(par->i810_gtt.i810_fb_memory);
+		par->drm_agp->unbind_memory(par->i810_gtt.i810_cursor_memory);
+		pci_disable_device(dev);
+	}
+	pci_save_state(dev, par->pci_state);
+	pci_set_power_state(dev, state);
+
+	return 0;
+}
+
+static int i810fb_resume(struct pci_dev *dev)=20
+{
+	struct fb_info *info =3D pci_get_drvdata(dev);
+	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
+
+	if (par->cur_state =3D=3D 0)
+		return 0;
+
+	pci_restore_state(dev, par->pci_state);
+	pci_set_power_state(dev, 0);
+	pci_enable_device(dev);
+	par->drm_agp->bind_memory(par->i810_gtt.i810_fb_memory,=20
+				  par->fb.offset);
+	par->drm_agp->bind_memory(par->i810_gtt.i810_cursor_memory,=20
+				  par->cursor_heap.offset);
+
+	info->fbops->fb_blank(VESA_NO_BLANKING, info);
+
+	par->cur_state =3D 0;
+
+	return 0;
+}
+/***********************************************************************
  *                  AGP resource allocation                            *
  ***********************************************************************/
  =20
@@ -1469,13 +1531,13 @@
 	par->fb.offset =3D v_offset_default << 20;
 	par->fb.offset >>=3D 12;
=20
-	par->iring.offset =3D par->fb.offset + (par->fb.size >> 12);
-	par->iring.size =3D RINGBUFFER_SIZE;
-
-	par->pixmap.offset =3D par->iring.offset + (RINGBUFFER_SIZE >> 12);
+	par->pixmap.offset =3D par->fb.offset + (par->fb.size >> 12);
 	par->pixmap.size =3D PIXMAP_SIZE;
=20
-	par->cursor_heap.offset =3D par->pixmap.offset + (PIXMAP_SIZE >> 12);
+	par->iring.offset =3D par->pixmap.offset + (PIXMAP_SIZE >> 12);
+	par->iring.size =3D RINGBUFFER_SIZE;
+
+	par->cursor_heap.offset =3D par->iring.offset + (RINGBUFFER_SIZE >> 12);
 	par->cursor_heap.size =3D 4096;
 }
=20
@@ -1817,12 +1879,16 @@
 	vfreq =3D hfreq/(info->var.yres + info->var.upper_margin +
 		       info->var.vsync_len + info->var.lower_margin);
=20
-      	printk("fb: %s v%d.%d.%d%s, (c) Tony Daplas\n"
-      	       "     Video RAM      : %dK\n"=20
-	       "     Mode           : %dx%d-%dbpp@%dHz\n",
+      	printk("I810FB: fb%d         : %s v%d.%d.%d%s\n"
+      	       "I810FB: Video RAM   : %dK\n"=20
+	       "I810FB: Monitor     : H: %d-%d KHz V: %d-%d Hz\n"
+	       "I810FB: Mode        : %dx%d-%dbpp@%dHz\n",
+	       minor(info->node),
 	       i810_pci_list[entry->driver_data],
 	       VERSION_MAJOR, VERSION_MINOR, VERSION_TEENIE, BRANCH_VERSION,
-	       (int) par->fb.size>>10, info->var.xres,=20
+	       (int) par->fb.size>>10, info->monspecs.hfmin/1000,
+	       info->monspecs.hfmax/1000, info->monspecs.vfmin,
+	       info->monspecs.vfmax, info->var.xres,=20
 	       info->var.yres, info->var.bits_per_pixel, vfreq);
 	return 0;
 }
@@ -1893,7 +1959,10 @@
 		return -ENODEV;
 	}
=20
-	return (pci_module_init(&i810fb_driver));
+	if (pci_register_driver(&i810fb_driver) > 0)
+		return 0;
+	pci_unregister_driver(&i810fb_driver);
+	return -ENODEV;
 }
 #endif=20
=20
@@ -1909,7 +1978,10 @@
 	hsync1 *=3D 1000;
 	hsync2 *=3D 1000;
=20
-	return (pci_module_init(&i810fb_driver));
+	if (pci_register_driver(&i810fb_driver) > 0)
+		return 0;
+	pci_unregister_driver(&i810fb_driver);
+	return -ENODEV;
 }
=20
 MODULE_PARM(vram, "i");
diff -Naur linux-2.5.61-fbdev/drivers/video/i810/i810_main.h linux-2.5.61-a=
d/drivers/video/i810/i810_main.h
--- linux-2.5.61-fbdev/drivers/video/i810/i810_main.h	2003-02-16 00:55:52.0=
00000000 +0000
+++ linux-2.5.61-ad/drivers/video/i810/i810_main.h	2003-02-16 04:50:15.0000=
00000 +0000
@@ -43,12 +43,16 @@
 static int  __init i810fb_init_pci (struct pci_dev *dev,=20
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
+static int i810fb_resume(struct pci_dev *dev);
+static int i810fb_suspend(struct pci_dev *dev, u32 state);
=20
 static struct pci_driver i810fb_driver =3D {
 	.name     =3D	"i810fb",
 	.id_table =3D	i810fb_pci_tbl,
 	.probe    =3D	i810fb_init_pci,
 	.remove   =3D	__exit_p(i810fb_remove_pci),
+	.suspend  =3D     i810fb_suspend,
+	.resume   =3D     i810fb_resume,
 };=09
=20
 static int i810_init  __initdata =3D 0;
@@ -121,9 +125,11 @@
 extern void i810fb_fill_var_timings(struct fb_var_screeninfo *var);
 				   =20
 /* Accelerated Functions */
-extern void i810fb_fillrect (struct fb_info *p, const struct fb_fillrect *=
rect);
-extern void i810fb_copyarea (struct fb_info *p, struct fb_copyarea *region=
);
-extern void i810fb_imageblit(struct fb_info *p, struct fb_image *image);
+extern void i810fb_fillrect (struct fb_info *p,=20
+			     const struct fb_fillrect *rect);
+extern void i810fb_copyarea (struct fb_info *p,=20
+			     const struct fb_copyarea *region);
+extern void i810fb_imageblit(struct fb_info *p, const struct fb_image *ima=
ge);
 extern int  i810fb_sync     (struct fb_info *p);
=20
 extern void i810fb_init_ringbuffer   (struct i810fb_par *par);

--=-aZkEjihxk2CDrYRdhZtm--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

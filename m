From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] add mutex to fbdev for fb_mmap locking
Date: Sun, 31 May 2009 16:24:53 +0200
Message-ID: <20090531162453.dff458cb.krzysztof.h1@poczta.fm>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MAlrh-00027w-Mp
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 14:18:21 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MAlrf-0002Tu-MO for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 14:18:21 +0000
In-Reply-To: <alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add a mutex to avoid a circular locking problem between the mm layer semaphore 
and fbdev ioctl mutex through the fb_mmap() call.

Also, add mutex to all places where smem_start and smem_len fields change
so the mutex inside the fb_mmap() is actually used. Changing of these fields
before calling the framebuffer_register() are not mutexed.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This is the promised patch.

Please decide if this is 2.6.30 material or not. It removes one lockdep (fb_mmap()
and register_framebuffer()) but there is still another one (fb_release() and register_framebuffer()).
It also cleans up handling of the smem_start and smem_len fields used by mutexed 
section of the fb_mmap().

Kind regards,
Krzysztof

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 018850c..c6f43c3 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2406,6 +2406,8 @@ static int do_fb_set_var(struct fb_var_screeninfo *var, int isactive)
 }
 
 static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct atafb_par par;
 	int err;
@@ -2414,7 +2416,10 @@ static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
 	if (err)
 		return err;
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	return fbhw->encode_fix(fix, &par);
+	mutex_lock(&info->mm_lock);
+	err = fbhw->encode_fix(fix, &par);
+	mutex_unlock(&info->mm_lock);
+	return err;
 }
 
 static int atafb_get_var(struct fb_var_screeninfo *var, struct fb_info *info)
@@ -2738,12 +2743,16 @@ static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	/* actually set hw par by decoding var, then setting hardware from
 	 * hw par just decoded */
 static int atafb_set_par(struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct atafb_par *par = (struct atafb_par *)info->par;
 
 	/* Decode wanted screen parameters */
 	fbhw->decode_var(&info->var, par);
+	mutex_lock(&info->mm_lock);
 	fbhw->encode_fix(&info->fix, par);
+	mutex_unlock(&info->mm_lock);
 
 	/* Set new videomode */
 	ata_set_par(par);
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 2fb63f6..40eb1b4 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -263,6 +263,8 @@ static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
  *	@sinfo: the frame buffer to allocate memory for
  */
 static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct fb_info *info = sinfo->info;
 	struct fb_var_screeninfo *var = &info->var;
@@ -270,7 +272,9 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
 
 	smem_len = (var->xres_virtual * var->yres_virtual
 		    * ((var->bits_per_pixel + 7) / 8));
+	mutex_lock(&info->mm_lock);
 	info->fix.smem_len = max(smem_len, sinfo->smem_len);
+	mutex_unlock(&info->mm_lock);
 
 	info->screen_base = dma_alloc_writecombine(info->device, info->fix.smem_len,
 					(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index d412a1d..c173683 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1310,8 +1310,8 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 
 static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
-__acquires(&info->lock)
-__releases(&info->lock)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	int fbidx = iminor(file->f_path.dentry->d_inode);
 	struct fb_info *info = registered_fb[fbidx];
@@ -1325,16 +1325,14 @@ __releases(&info->lock)
 	off = vma->vm_pgoff << PAGE_SHIFT;
 	if (!fb)
 		return -ENODEV;
+	mutex_lock(&info->mm_lock);
 	if (fb->fb_mmap) {
 		int res;
-		mutex_lock(&info->lock);
 		res = fb->fb_mmap(info, vma);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&info->mm_lock);
 		return res;
 	}
 
-	mutex_lock(&info->lock);
-
 	/* frame buffer memory */
 	start = info->fix.smem_start;
 	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
@@ -1342,13 +1340,13 @@ __releases(&info->lock)
 		/* memory mapped io */
 		off -= len;
 		if (info->var.accel_flags) {
-			mutex_unlock(&info->lock);
+			mutex_unlock(&info->mm_lock);
 			return -EINVAL;
 		}
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 	}
-	mutex_unlock(&info->lock);
+	mutex_unlock(&info->mm_lock);
 	start &= PAGE_MASK;
 	if ((vma->vm_end - vma->vm_start + off) > len)
 		return -EINVAL;
@@ -1491,6 +1489,7 @@ register_framebuffer(struct fb_info *fb_info)
 			break;
 	fb_info->node = i;
 	mutex_init(&fb_info->lock);
+	mutex_init(&fb_info->mm_lock);
 
 	fb_info->dev = device_create(fb_class, fb_info->device,
 				     MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index f153c58..ca664f5 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -748,37 +748,45 @@ static void update_lcdc(struct fb_info *info)
 }
 
 static int map_video_memory(struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	phys_addr_t phys;
+	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
 
 	pr_debug("info->var.xres_virtual = %d\n", info->var.xres_virtual);
 	pr_debug("info->var.yres_virtual = %d\n", info->var.yres_virtual);
 	pr_debug("info->fix.line_length  = %d\n", info->fix.line_length);
+	pr_debug("MAP_VIDEO_MEMORY: smem_len = %u\n", smem_len);
 
-	info->fix.smem_len = info->fix.line_length * info->var.yres_virtual;
-	pr_debug("MAP_VIDEO_MEMORY: smem_len = %d\n", info->fix.smem_len);
-	info->screen_base = fsl_diu_alloc(info->fix.smem_len, &phys);
+	info->screen_base = fsl_diu_alloc(smem_len, &phys);
 	if (info->screen_base == NULL) {
 		printk(KERN_ERR "Unable to allocate fb memory\n");
 		return -ENOMEM;
 	}
+	mutex_lock(&info->mm_lock);
 	info->fix.smem_start = (unsigned long) phys;
+	info->fix.smem_len = smem_len;
+	mutex_unlock(&info->mm_lock);
 	info->screen_size = info->fix.smem_len;
 
 	pr_debug("Allocated fb @ paddr=0x%08lx, size=%d.\n",
-				info->fix.smem_start,
-		info->fix.smem_len);
+		 info->fix.smem_start, info->fix.smem_len);
 	pr_debug("screen base %p\n", info->screen_base);
 
 	return 0;
 }
 
 static void unmap_video_memory(struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	fsl_diu_free(info->screen_base, info->fix.smem_len);
+	mutex_lock(&info->mm_lock);
 	info->screen_base = NULL;
 	info->fix.smem_start = 0;
 	info->fix.smem_len = 0;
+	mutex_unlock(&info->mm_lock);
 }
 
 /*
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 2e94019..fac172d 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1084,14 +1084,18 @@ static int i810_check_params(struct fb_var_screeninfo *var,
  * This will set up parameters that are unmodifiable by the user.
  */
 static int encode_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct i810fb_par *par = info->par;
 
     	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
 
     	strcpy(fix->id, "I810");
+	mutex_lock(&info->mm_lock);
     	fix->smem_start = par->fb.physical;
     	fix->smem_len = par->fb.size;
+	mutex_unlock(&info->mm_lock);
     	fix->type = FB_TYPE_PACKED_PIXELS;
     	fix->type_aux = 0;
 	fix->xpanstep = 8;
diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 8e7a275..b6bf28f 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -720,12 +720,16 @@ static void matroxfb_init_fix(WPMINFO2)
 }
 
 static void matroxfb_update_fix(WPMINFO2)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct fb_fix_screeninfo *fix = &ACCESS_FBINFO(fbcon).fix;
 	DBG(__func__)
 
+	mutex_lock(&ACCESS_FBINFO(fbcon).mm_lock);
 	fix->smem_start = ACCESS_FBINFO(video.base) + ACCESS_FBINFO(curr.ydstorg.bytes);
 	fix->smem_len = ACCESS_FBINFO(video.len_usable) - ACCESS_FBINFO(curr.ydstorg.bytes);
+	mutex_unlock(&ACCESS_FBINFO(fbcon).mm_lock);
 }
 
 static int matroxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
@@ -2081,6 +2085,7 @@ static int matroxfb_probe(struct pci_dev* pdev, const struct pci_device_id* dumm
 	spin_lock_init(&ACCESS_FBINFO(lock.accel));
 	init_rwsem(&ACCESS_FBINFO(crtc2.lock));
 	init_rwsem(&ACCESS_FBINFO(altout.lock));
+	mutex_init(&ACCESS_FBINFO(fbcon).mm_lock);
 	ACCESS_FBINFO(irq_flags) = 0;
 	init_waitqueue_head(&ACCESS_FBINFO(crtc1.vsync.wait));
 	init_waitqueue_head(&ACCESS_FBINFO(crtc2.vsync.wait));
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index 7ac4c5f..7ad14d0 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -289,13 +289,18 @@ static int matroxfb_dh_release(struct fb_info* info, int user) {
 #undef m2info
 }
 
-static void matroxfb_dh_init_fix(struct matroxfb_dh_fb_info *m2info) {
+static void matroxfb_dh_init_fix(struct matroxfb_dh_fb_info *m2info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
+{
 	struct fb_fix_screeninfo *fix = &m2info->fbcon.fix;
 
 	strcpy(fix->id, "MATROX DH");
 
+	mutex_lock(&m2info->fbcon.mm_lock);
 	fix->smem_start = m2info->video.base;
 	fix->smem_len = m2info->video.len_usable;
+	mutex_unlock(&m2info->fbcon.mm_lock);
 	fix->ypanstep = 1;
 	fix->ywrapstep = 0;
 	fix->xpanstep = 8;	/* TBD */
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 9894de1..fb57795 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -669,7 +669,7 @@ static uint32_t bpp_to_pixfmt(int bpp)
 }
 
 static int mx3fb_blank(int blank, struct fb_info *fbi);
-static int mx3fb_map_video_memory(struct fb_info *fbi);
+static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len);
 static int mx3fb_unmap_video_memory(struct fb_info *fbi);
 
 /**
@@ -742,8 +742,7 @@ static int mx3fb_set_par(struct fb_info *fbi)
 		if (fbi->fix.smem_start)
 			mx3fb_unmap_video_memory(fbi);
 
-		fbi->fix.smem_len = mem_len;
-		if (mx3fb_map_video_memory(fbi) < 0) {
+		if (mx3fb_map_video_memory(fbi, mem_len) < 0) {
 			mutex_unlock(&mx3_fbi->mutex);
 			return -ENOMEM;
 		}
@@ -1198,6 +1197,7 @@ static int mx3fb_resume(struct platform_device *pdev)
 /**
  * mx3fb_map_video_memory() - allocates the DRAM memory for the frame buffer.
  * @fbi:	framebuffer information pointer
+ * @mem_len:	length of mapped memory
  * @return:	Error code indicating success or failure
  *
  * This buffer is remapped into a non-cached, non-buffered, memory region to
@@ -1205,23 +1205,28 @@ static int mx3fb_resume(struct platform_device *pdev)
  * area is remapped, all virtual memory access to the video memory should occur
  * at the new region.
  */
-static int mx3fb_map_video_memory(struct fb_info *fbi)
+static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	int retval = 0;
 	dma_addr_t addr;
 
 	fbi->screen_base = dma_alloc_writecombine(fbi->device,
-						  fbi->fix.smem_len,
+						  mem_len,
 						  &addr, GFP_DMA);
 
 	if (!fbi->screen_base) {
 		dev_err(fbi->device, "Cannot allocate %u bytes framebuffer memory\n",
-			fbi->fix.smem_len);
+			mem_len);
 		retval = -EBUSY;
 		goto err0;
 	}
 
+	mutex_lock(&fbi->mm_lock);
 	fbi->fix.smem_start = addr;
+	fbi->fix.smem_len = mem_len;
+	mutex_unlock(&fbi->mm_lock);
 
 	dev_dbg(fbi->device, "allocated fb @ p=0x%08x, v=0x%p, size=%d.\n",
 		(uint32_t) fbi->fix.smem_start, fbi->screen_base, fbi->fix.smem_len);
@@ -1246,13 +1251,17 @@ err0:
  * @return:	error code indicating success or failure
  */
 static int mx3fb_unmap_video_memory(struct fb_info *fbi)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	dma_free_writecombine(fbi->device, fbi->fix.smem_len,
 			      fbi->screen_base, fbi->fix.smem_start);
 
 	fbi->screen_base = 0;
+	mutex_lock(&fbi->mm_lock);
 	fbi->fix.smem_start = 0;
 	fbi->fix.smem_len = 0;
+	mutex_unlock(&fbi->mm_lock);
 	return 0;
 }
 
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 060d72f..eccf4bd 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -384,6 +384,8 @@ static void omapfb_sync(struct fb_info *fbi)
  * When calling this fb_info.var must be set up already.
  */
 static void set_fb_fix(struct fb_info *fbi)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct fb_fix_screeninfo *fix = &fbi->fix;
 	struct fb_var_screeninfo *var = &fbi->var;
@@ -393,8 +395,10 @@ static void set_fb_fix(struct fb_info *fbi)
 
 	rg = &plane->fbdev->mem_desc.region[plane->idx];
 	fbi->screen_base	= rg->vaddr;
+	mutex_lock(&fbi->mm_lock);
 	fix->smem_start		= rg->paddr;
 	fix->smem_len		= rg->size;
+	mutex_unlock(&fbi->mm_lock);
 
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	bpp = var->bits_per_pixel;
@@ -824,6 +828,8 @@ static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 }
 
 static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct omapfb_plane_struct *plane = fbi->par;
 	struct omapfb_device *fbdev = plane->fbdev;
@@ -886,8 +892,10 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 				 * plane memory is dealloce'd, the other
 				 * screen parameters in var / fix are invalid.
 				 */
+				mutex_lock(&fbi->mm_lock);
 				fbi->fix.smem_start = 0;
 				fbi->fix.smem_len = 0;
+				mutex_unlock(&fbi->mm_lock);
 			}
 		}
 	}
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 03b3670..1600ee7 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -122,6 +122,8 @@ static int platinumfb_check_var (struct fb_var_screeninfo *var, struct fb_info *
  * Applies current var to display
  */
 static int platinumfb_set_par (struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct fb_info_platinum *pinfo = info->par;
 	struct platinum_regvals *init;
@@ -141,7 +143,9 @@ static int platinumfb_set_par (struct fb_info *info)
   		offset = 0x10;
 
 	info->screen_base = pinfo->frame_buffer + init->fb_offset + offset;
+	mutex_lock(&info->mm_lock);
 	info->fix.smem_start = (pinfo->frame_buffer_phys) + init->fb_offset + offset;
+	mutex_unlock(&info->mm_lock);
 	info->fix.visual = (pinfo->cmode == CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
  	info->fix.line_length = vmode_attrs[pinfo->vmode-1].hres * (1<<pinfo->cmode)
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 0889d50..140c692 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -783,6 +783,8 @@ static int overlayfb_check_var(struct fb_var_screeninfo *var,
 }
 
 static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct fb_var_screeninfo *var = &ofb->fb.var;
 	int pfor = NONSTD_TO_PFOR(var->nonstd);
@@ -815,8 +817,10 @@ static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
 	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
 	ofb->video_mem_size = size;
 
+	mutex_lock(&ofb->fb.mm_lock);
 	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
 	ofb->fb.fix.smem_len	= ofb->fb.fix.line_length * var->yres_virtual;
+	mutex_unlock(&ofb->fb.mm_lock);
 	ofb->fb.screen_base	= ofb->video_mem;
 	return 0;
 }
diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 653bdfe..9f6d6e6 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -120,18 +120,6 @@ static int sh7760_setcolreg (u_int regno,
 	return 0;
 }
 
-static void encode_fix(struct fb_fix_screeninfo *fix, struct fb_info *info,
-		       unsigned long stride)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, "sh7760-lcdc");
-
-	fix->smem_start = (unsigned long)info->screen_base;
-	fix->smem_len = info->screen_size;
-
-	fix->line_length = stride;
-}
-
 static int sh7760fb_get_color_info(struct device *dev,
 				   u16 lddfr, int *bpp, int *gray)
 {
@@ -334,7 +322,8 @@ static int sh7760fb_set_par(struct fb_info *info)
 
 	iowrite32(ldsarl, par->base + LDSARL);	/* mem for lower half of DSTN */
 
-	encode_fix(&info->fix, info, stride);
+	info->fix.line_length = stride;
+
 	sh7760fb_check_var(&info->var, info);
 
 	sh7760fb_blank(FB_BLANK_UNBLANK, info);	/* panel on! */
@@ -435,6 +424,8 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 
 	info->screen_base = fbmem;
 	info->screen_size = vram;
+	info->fix.smem_start = (unsigned long)info->screen_base;
+	info->fix.smem_len = info->screen_size;
 
 	return 0;
 }
@@ -520,6 +511,8 @@ static int __devinit sh7760fb_probe(struct platform_device *pdev)
 	info->var.transp.length = 0;
 	info->var.transp.msb_right = 0;
 
+	strcpy(info->fix.id, "sh7760-lcdc");
+
 	/* set the DON2 bit now, before cmap allocation, as it will randomize
 	 * palette memory.
 	 */
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 7e17ee9..59f5faf 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1840,6 +1840,8 @@ static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 
 static int
 sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
 
@@ -1847,8 +1849,10 @@ sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
 
 	strcpy(fix->id, ivideo->myid);
 
+	mutex_lock(&info->mm_lock);
 	fix->smem_start  = ivideo->video_base + ivideo->video_offset;
 	fix->smem_len    = ivideo->sisfb_mem;
+	mutex_unlock(&info->mm_lock);
 	fix->type        = FB_TYPE_PACKED_PIXELS;
 	fix->type_aux    = 0;
 	fix->visual      = (ivideo->video_bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index eb5d73a..1285b70 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -145,7 +145,7 @@ static inline void sm501fb_sync_regs(struct sm501fb_info *info)
 #define SM501_MEMF_ACCEL		(8)
 
 static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
-			   unsigned int why, size_t size)
+			   unsigned int why, size_t size, u32 smem_len)
 {
 	struct sm501fb_par *par;
 	struct fb_info *fbi;
@@ -172,7 +172,7 @@ static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
 		if (ptr > 0)
 			ptr &= ~(PAGE_SIZE - 1);
 
-		if (fbi && ptr < fbi->fix.smem_len)
+		if (fbi && ptr < smem_len)
 			return -ENOMEM;
 
 		break;
@@ -197,7 +197,7 @@ static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
 
 	case SM501_MEMF_ACCEL:
 		fbi = inf->fb[HEAD_CRT];
-		ptr = fbi ? fbi->fix.smem_len : 0;
+		ptr = fbi ? smem_len : 0;
 
 		fbi = inf->fb[HEAD_PANEL];
 		if (fbi) {
@@ -405,6 +405,8 @@ static int sm501fb_check_var_pnl(struct fb_var_screeninfo *var,
 
 static int sm501fb_set_par_common(struct fb_info *info,
 				  struct fb_var_screeninfo *var)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct sm501fb_par  *par = info->par;
 	struct sm501fb_info *fbi = par->info;
@@ -413,6 +415,7 @@ static int sm501fb_set_par_common(struct fb_info *info,
 	unsigned int mem_type;
 	unsigned int clock_type;
 	unsigned int head_addr;
+	unsigned int smem_len;
 
 	dev_dbg(fbi->dev, "%s: %dx%d, bpp = %d, virtual %dx%d\n",
 		__func__, var->xres, var->yres, var->bits_per_pixel,
@@ -453,18 +456,20 @@ static int sm501fb_set_par_common(struct fb_info *info,
 
 	/* allocate fb memory within 501 */
 	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel)/8;
-	info->fix.smem_len    = info->fix.line_length * var->yres_virtual;
+	smem_len = info->fix.line_length * var->yres_virtual;
 
 	dev_dbg(fbi->dev, "%s: line length = %u\n", __func__,
 		info->fix.line_length);
 
-	if (sm501_alloc_mem(fbi, &par->screen, mem_type,
-			    info->fix.smem_len)) {
+	if (sm501_alloc_mem(fbi, &par->screen, mem_type, smem_len, smem_len)) {
 		dev_err(fbi->dev, "no memory available\n");
 		return -ENOMEM;
 	}
 
+	mutex_lock(&info->mm_lock);
 	info->fix.smem_start = fbi->fbmem_res->start + par->screen.sm_addr;
+	info->fix.smem_len   = smem_len;
+	mutex_unlock(&info->mm_lock);
 
 	info->screen_base = fbi->fbmem + par->screen.sm_addr;
 	info->screen_size = info->fix.smem_len;
@@ -637,7 +642,8 @@ static int sm501fb_set_par_crt(struct fb_info *info)
 	if ((control & SM501_DC_CRT_CONTROL_SEL) == 0) {
 		/* the head is displaying panel data... */
 
-		sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_CRT, 0);
+		sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_CRT, 0,
+				info->fix.smem_len);
 		goto out_update;
 	}
 
@@ -1289,7 +1295,8 @@ static int sm501_init_cursor(struct fb_info *fbi, unsigned int reg_base)
 
 	par->cursor_regs = info->regs + reg_base;
 
-	ret = sm501_alloc_mem(info, &par->cursor, SM501_MEMF_CURSOR, 1024);
+	ret = sm501_alloc_mem(info, &par->cursor, SM501_MEMF_CURSOR, 1024,
+			      fbi->fix.smem_len);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index d0674f1..05356d3 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -510,6 +510,8 @@ static int w100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
  *  by looking at the values in info.var
  */
 static int w100fb_set_par(struct fb_info *info)
+__acquires(&info->mm_lock)
+__releases(&info->mm_lock)
 {
 	struct w100fb_par *par=info->par;
 
@@ -523,6 +525,7 @@ static int w100fb_set_par(struct fb_info *info)
 		info->fix.ywrapstep = 0;
 		info->fix.line_length = par->xres * BITS_PER_PIXEL / 8;
 
+		mutex_lock(&info->mm_lock);
 		if ((par->xres*par->yres*BITS_PER_PIXEL/8) > (MEM_INT_SIZE+1)) {
 			par->extmem_active = 1;
 			info->fix.smem_len = par->mach->mem->size+1;
@@ -530,6 +533,7 @@ static int w100fb_set_par(struct fb_info *info)
 			par->extmem_active = 0;
 			info->fix.smem_len = MEM_INT_SIZE+1;
 		}
+		mutex_unlock(&info->mm_lock);
 
 		w100fb_activate_var(par);
 	}
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 330c4b1..89a4d91 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -814,6 +814,7 @@ struct fb_info {
 	int node;
 	int flags;
 	struct mutex lock;		/* Lock for open/release/ioctl funcs */
+	struct mutex mm_lock;		/* Lock for fb_mmap and smem_* fields */
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */

----------------------------------------------------------------------
Kup wlasne mieszkanie za 33 tys. zl.
Sprawdz >>> http://link.interia.pl/f21a3


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 

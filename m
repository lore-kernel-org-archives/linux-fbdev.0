From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:09:00 +0000
Subject: [PATCH 6/6] video: fbdev: controlfb: remove function prototypes part #3
Message-Id: <20200116140900.26363-7-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200116140900.26363-1-b.zolnierkie@samsung.com>
 <CGME20200116140916eucas1p2bd3480995a55fdc646481a8fa5a5aff3@eucas1p2.samsung.com>
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: b.zolnierkie@samsung.com

Reorder code a bit and then remove no longer needed function
prototypes.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 306 +++++++++++++++-----------------
 1 file changed, 147 insertions(+), 159 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 4012ecf72d47..e71192ee5650 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -129,16 +129,6 @@ struct fb_info_control {
 #define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs->REG).r))
 
 
-/******************** Prototypes for internal functions **********************/
-
-static void control_set_hardware(struct fb_info_control *p,
-	struct fb_par_control *par);
-static int control_var_to_par(struct fb_var_screeninfo *var,
-	struct fb_par_control *par, const struct fb_info *fb_info);
-static inline void control_par_to_var(struct fb_par_control *par,
-	struct fb_var_screeninfo *var);
-
-
 /************************** Internal variables *******************************/
 
 static struct fb_info_control *control_fb;
@@ -147,155 +137,6 @@ static int default_vmode __initdata = VMODE_NVRAM;
 static int default_cmode __initdata = CMODE_NVRAM;
 
 
-/********************  The functions for controlfb_ops ********************/
-
-/*
- * Checks a var structure
- */
-static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	struct fb_par_control par;
-	int err;
-
-	err = control_var_to_par(var, &par, info);
-	if (err)
-		return err;	
-	control_par_to_var(&par, var);
-
-	return 0;
-}
-
-/*
- * Applies current var to display
- */
-static int controlfb_set_par (struct fb_info *info)
-{
-	struct fb_info_control *p -		container_of(info, struct fb_info_control, info);
-	struct fb_par_control par;
-	int err;
-
-	if((err = control_var_to_par(&info->var, &par, info))) {
-		printk (KERN_ERR "controlfb_set_par: error calling"
-				 " control_var_to_par: %d.\n", err);
-		return err;
-	}
-	
-	control_set_hardware(p, &par);
-
-	info->fix.visual = (p->par.cmode = CMODE_8) ?
-		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-	info->fix.line_length = p->par.pitch;
-	info->fix.xpanstep = 32 >> p->par.cmode;
-	info->fix.ypanstep = 1;
-
-	return 0;
-}
-
-/*
- * Set screen start address according to var offset values
- */
-static inline void set_screen_start(int xoffset, int yoffset,
-	struct fb_info_control *p)
-{
-	struct fb_par_control *par = &p->par;
-
-	par->xoffset = xoffset;
-	par->yoffset = yoffset;
-	out_le32(CNTRL_REG(p,start_addr),
-		 par->yoffset * par->pitch + (par->xoffset << par->cmode));
-}
-
-
-static int controlfb_pan_display(struct fb_var_screeninfo *var,
-				 struct fb_info *info)
-{
-	unsigned int xoffset, hstep;
-	struct fb_info_control *p -		container_of(info, struct fb_info_control, info);
-	struct fb_par_control *par = &p->par;
-
-	/*
-	 * make sure start addr will be 32-byte aligned
-	 */
-	hstep = 0x1f >> par->cmode;
-	xoffset = (var->xoffset + hstep) & ~hstep;
-
-	if (xoffset+par->xres > par->vxres ||
-	    var->yoffset+par->yres > par->vyres)
-		return -EINVAL;
-
-	set_screen_start(xoffset, var->yoffset, p);
-
-	return 0;
-}
-
-
-/*
- * Private mmap since we want to have a different caching on the framebuffer
- * for controlfb.
- * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
- */
-static int controlfb_mmap(struct fb_info *info,
-                       struct vm_area_struct *vma)
-{
-	unsigned long mmio_pgoff;
-	unsigned long start;
-	u32 len;
-
-	start = info->fix.smem_start;
-	len = info->fix.smem_len;
-	mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
-	if (vma->vm_pgoff >= mmio_pgoff) {
-		if (info->var.accel_flags)
-			return -EINVAL;
-		vma->vm_pgoff -= mmio_pgoff;
-		start = info->fix.mmio_start;
-		len = info->fix.mmio_len;
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	} else {
-		/* framebuffer */
-#ifdef CONFIG_PPC_PMAC
-		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
-#endif
-	}
-
-	return vm_iomap_memory(vma, start, len);
-}
-
-static int controlfb_blank(int blank_mode, struct fb_info *info)
-{
-	struct fb_info_control *p -		container_of(info, struct fb_info_control, info);
-	unsigned ctrl;
-
-	ctrl = le32_to_cpup((const __force __le32 *)CNTRL_REG(p, ctrl));
-	if (blank_mode > 0)
-		switch (blank_mode) {
-		case FB_BLANK_VSYNC_SUSPEND:
-			ctrl &= ~3;
-			break;
-		case FB_BLANK_HSYNC_SUSPEND:
-			ctrl &= ~0x30;
-			break;
-		case FB_BLANK_POWERDOWN:
-			ctrl &= ~0x33;
-			/* fall through */
-		case FB_BLANK_NORMAL:
-			ctrl |= 0x400;
-			break;
-		default:
-			break;
-		}
-	else {
-		ctrl &= ~0x400;
-		ctrl |= 0x33;
-	}
-	out_le32(CNTRL_REG(p,ctrl), ctrl);
-
-	return 0;
-}
-
 static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info)
 {
@@ -352,6 +193,20 @@ static void set_control_clock(unsigned char *params)
 #endif	
 }
 
+/*
+ * Set screen start address according to var offset values
+ */
+static inline void set_screen_start(int xoffset, int yoffset,
+	struct fb_info_control *p)
+{
+	struct fb_par_control *par = &p->par;
+
+	par->xoffset = xoffset;
+	par->yoffset = yoffset;
+	out_le32(CNTRL_REG(p,start_addr),
+		 par->yoffset * par->pitch + (par->xoffset << par->cmode));
+}
+
 #define RADACAL_WRITE(a,d) \
 	out_8(&p->cmap_regs->addr, (a)); \
 	out_8(&p->cmap_regs->dat,   (d))
@@ -774,6 +629,139 @@ static inline void control_par_to_var(struct fb_par_control *par,
 	var->pixclock >>= par->regvals.clock_params[2];
 }
 
+/********************  The functions for controlfb_ops ********************/
+
+/*
+ * Checks a var structure
+ */
+static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct fb_par_control par;
+	int err;
+
+	err = control_var_to_par(var, &par, info);
+	if (err)
+		return err;	
+	control_par_to_var(&par, var);
+
+	return 0;
+}
+
+/*
+ * Applies current var to display
+ */
+static int controlfb_set_par (struct fb_info *info)
+{
+	struct fb_info_control *p +		container_of(info, struct fb_info_control, info);
+	struct fb_par_control par;
+	int err;
+
+	if((err = control_var_to_par(&info->var, &par, info))) {
+		printk (KERN_ERR "controlfb_set_par: error calling"
+				 " control_var_to_par: %d.\n", err);
+		return err;
+	}
+	
+	control_set_hardware(p, &par);
+
+	info->fix.visual = (p->par.cmode = CMODE_8) ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+	info->fix.line_length = p->par.pitch;
+	info->fix.xpanstep = 32 >> p->par.cmode;
+	info->fix.ypanstep = 1;
+
+	return 0;
+}
+
+static int controlfb_pan_display(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
+{
+	unsigned int xoffset, hstep;
+	struct fb_info_control *p +		container_of(info, struct fb_info_control, info);
+	struct fb_par_control *par = &p->par;
+
+	/*
+	 * make sure start addr will be 32-byte aligned
+	 */
+	hstep = 0x1f >> par->cmode;
+	xoffset = (var->xoffset + hstep) & ~hstep;
+
+	if (xoffset+par->xres > par->vxres ||
+	    var->yoffset+par->yres > par->vyres)
+		return -EINVAL;
+
+	set_screen_start(xoffset, var->yoffset, p);
+
+	return 0;
+}
+
+static int controlfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct fb_info_control *p +		container_of(info, struct fb_info_control, info);
+	unsigned ctrl;
+
+	ctrl = le32_to_cpup((const __force __le32 *)CNTRL_REG(p, ctrl));
+	if (blank_mode > 0)
+		switch (blank_mode) {
+		case FB_BLANK_VSYNC_SUSPEND:
+			ctrl &= ~3;
+			break;
+		case FB_BLANK_HSYNC_SUSPEND:
+			ctrl &= ~0x30;
+			break;
+		case FB_BLANK_POWERDOWN:
+			ctrl &= ~0x33;
+			/* fall through */
+		case FB_BLANK_NORMAL:
+			ctrl |= 0x400;
+			break;
+		default:
+			break;
+		}
+	else {
+		ctrl &= ~0x400;
+		ctrl |= 0x33;
+	}
+	out_le32(CNTRL_REG(p,ctrl), ctrl);
+
+	return 0;
+}
+
+/*
+ * Private mmap since we want to have a different caching on the framebuffer
+ * for controlfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int controlfb_mmap(struct fb_info *info,
+                       struct vm_area_struct *vma)
+{
+	unsigned long mmio_pgoff;
+	unsigned long start;
+	u32 len;
+
+	start = info->fix.smem_start;
+	len = info->fix.smem_len;
+	mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
+	if (vma->vm_pgoff >= mmio_pgoff) {
+		if (info->var.accel_flags)
+			return -EINVAL;
+		vma->vm_pgoff -= mmio_pgoff;
+		start = info->fix.mmio_start;
+		len = info->fix.mmio_len;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	} else {
+		/* framebuffer */
+#ifdef CONFIG_PPC_PMAC
+		vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
+#endif
+	}
+
+	return vm_iomap_memory(vma, start, len);
+}
+
 static const struct fb_ops controlfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= controlfb_check_var,
-- 
2.24.1

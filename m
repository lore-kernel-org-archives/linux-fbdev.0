From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:08:07 +0000
Subject: [PATCH 01/13] staging: sm750: Reintend
Message-Id: <20150322230807.GA16817@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The reintend fixes the
"WARNING: please, no spaces at the start of a line",
"ERROR: code indent should use tabs where possible"
and some other small checkpatch.pl warnings and errors.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 928 ++++++++++++++++++++--------------------
 1 file changed, 464 insertions(+), 464 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a7b1b9c..459807f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -31,12 +31,12 @@ int smi_indent = 0;
 
 
 /*
-#ifdef __BIG_ENDIAN
-ssize_t lynxfb_ops_write(struct fb_info *info, const char __user *buf,
- 	    size_t count, loff_t *ppos);
-ssize_t lynxfb_ops_read(struct fb_info *info, char __user *buf,
-			   size_t count, loff_t *ppos);
-#endif
+ * #ifdef __BIG_ENDIAN
+ * ssize_t lynxfb_ops_write(struct fb_info *info, const char __user *buf,
+ * size_t count, loff_t *ppos);
+ * ssize_t lynxfb_ops_read(struct fb_info *info, char __user *buf,
+ * size_t count, loff_t *ppos);
+ * #endif
  */
 
 typedef void (*PROC_SPEC_SETUP)(struct lynx_share*,char *);
@@ -76,54 +76,54 @@ static inline void myspin_unlock(spinlock_t * sl){
 static const struct fb_videomode lynx750_ext[] = {
 	/*  	1024x600-60 VESA 	[1.71:1]	*/
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/* 	1024x600-70 VESA */
 	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*  	1024x600-75 VESA */
 	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*  	1024x600-85 VESA */
 	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	720x480	*/
 	{NULL, 60,  720,  480,  37427, 88,   16, 13, 1,   72,  3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	1280x720		[1.78:1]	*/
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 
 	/* 1280x768@60 */
 	{NULL,60,1280,768,12579,192,64,20,3,128,7,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 
 	{NULL,60,1360,768,11804,208,64,23,1,144,3,
-	FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
 
 	/*	1360 x 768	[1.77083:1]	*/
 	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	1368 x 768      [1.78:1]	*/
 	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/* 	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
-	FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 
 	/*	1440x960		[15:10]	*/
 	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
-	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	1920x1080	[16:9]	*/
 	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
-	FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 };
 
 
@@ -141,8 +141,8 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 	cursor = &crtc->cursor;
 
 	if(fbcursor->image.width > cursor->maxW ||
-		fbcursor->image.height > cursor->maxH ||
-		 fbcursor->image.depth > 1){
+			fbcursor->image.height > cursor->maxH ||
+			fbcursor->image.depth > 1){
 		return -ENXIO;
 	}
 
@@ -153,19 +153,19 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 
 	if(fbcursor->set & FB_CUR_SETPOS){
 		cursor->setPos(cursor,fbcursor->image.dx - info->var.xoffset,
-								fbcursor->image.dy - info->var.yoffset);
+				fbcursor->image.dy - info->var.yoffset);
 	}
 
 	if(fbcursor->set & FB_CUR_SETCMAP){
 		/* get the 16bit color of kernel means */
 		u16 fg,bg;
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
-				((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
-				((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
+			((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
+			((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
 
 		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800))|
-				((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
-				((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
+			((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
+			((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
 		cursor->setColor(cursor,fg,bg);
 	}
@@ -174,9 +174,9 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 	if(fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE))
 	{
 		cursor->setData(cursor,
-						fbcursor->rop,
-						fbcursor->image.data,
-						fbcursor->mask);
+				fbcursor->rop,
+				fbcursor->image.data,
+				fbcursor->mask);
 	}
 
 	if(fbcursor->enable){
@@ -211,10 +211,10 @@ static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* r
 
 	myspin_lock(&share->slock);
 	share->accel.de_fillrect(&share->accel,
-							base,pitch,Bpp,
-							region->dx,region->dy,
-							region->width,region->height,
-							color,rop);
+			base,pitch,Bpp,
+			region->dx,region->dy,
+			region->width,region->height,
+			color,rop);
 	myspin_unlock(&share->slock);
 }
 
@@ -235,9 +235,9 @@ static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea *
 
 	myspin_lock(&share->slock);
 	share->accel.de_copyarea(&share->accel,
-							base,pitch,region->sx,region->sy,
-							base,pitch,Bpp,region->dx,region->dy,
-							region->width,region->height,HW_ROP2_COPY);
+			base,pitch,region->sx,region->sy,
+			base,pitch,Bpp,region->dx,region->dy,
+			region->width,region->height,HW_ROP2_COPY);
 	myspin_unlock(&share->slock);
 }
 
@@ -258,7 +258,7 @@ static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* imag
 
 	if(image->depth = 1){
 		if(info->fix.visual = FB_VISUAL_TRUECOLOR ||
-			info->fix.visual = FB_VISUAL_DIRECTCOLOR)
+				info->fix.visual = FB_VISUAL_DIRECTCOLOR)
 		{
 			fgcol = ((u32*)info->pseudo_palette)[image->fg_color];
 			bgcol = ((u32*)info->pseudo_palette)[image->bg_color];
@@ -274,31 +274,31 @@ static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* imag
 _do_work:
 	myspin_lock(&share->slock);
 	share->accel.de_imageblit(&share->accel,
-					image->data,image->width>>3,0,
-					base,pitch,Bpp,
-					image->dx,image->dy,
-					image->width,image->height,
-					fgcol,bgcol,HW_ROP2_COPY);
+			image->data,image->width>>3,0,
+			base,pitch,Bpp,
+			image->dx,image->dy,
+			image->width,image->height,
+			fgcol,bgcol,HW_ROP2_COPY);
 	myspin_unlock(&share->slock);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-        struct fb_info *info)
+		struct fb_info *info)
 {
-    struct lynxfb_par * par;
-    struct lynxfb_crtc * crtc;
-    int ret;
-    
+	struct lynxfb_par * par;
+	struct lynxfb_crtc * crtc;
+	int ret;
 
-    if(!info)
-        return -EINVAL;
 
-    ret = 0;
-    par = info->par;
-    crtc = &par->crtc;
-    ret = crtc->proc_panDisplay(crtc, var, info);
+	if(!info)
+		return -EINVAL;
+
+	ret = 0;
+	par = info->par;
+	crtc = &par->crtc;
+	ret = crtc->proc_panDisplay(crtc, var, info);
 
-    return ret;
+	return ret;
 }
 
 static int lynxfb_ops_set_par(struct fb_info * info)
@@ -453,7 +453,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	struct lynx_cursor * cursor;
 
 	int ret;
-	
+
 
 	ret = 0;
 	share = pci_get_drvdata(pdev);
@@ -519,7 +519,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* in
 	int ret;
 	resource_size_t request;
 
-	
+
 	par = info->par;
 	crtc = &par->crtc;
 	output = &par->output;
@@ -604,64 +604,64 @@ exit:
 
 
 static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
-									unsigned green,unsigned blue,
-									unsigned transp,struct fb_info * info)
+		unsigned green,unsigned blue,
+		unsigned transp,struct fb_info * info)
 {
-    struct lynxfb_par * par;
-    struct lynxfb_crtc * crtc;
-    struct fb_var_screeninfo * var;
-    int ret;
-
-    par = info->par;
-    crtc = &par->crtc;
-    var = &info->var;
-    ret = 0;
-
-    //pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
-    if(regno > 256){
-        pr_err("regno = %d\n",regno);
-        return -EINVAL;
-    }
-
-    if(info->var.grayscale)
-        red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
-
-    if(var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR)
-    {
-        red >>= 8;
-        green >>= 8;
-        blue >>= 8;
-        ret = crtc->proc_setColReg(crtc,regno,red,green,blue);
-        goto exit;
-    }
-
-
-    if(info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256 )
-    {
-        u32 val;
-        if(var->bits_per_pixel = 16 ||
-                var->bits_per_pixel = 32 ||
-                var->bits_per_pixel = 24)
-        {
-            val = chan_to_field(red,&var->red);
-            val |= chan_to_field(green,&var->green);
-            val |= chan_to_field(blue,&var->blue);
-            par->pseudo_palette[regno] = val;
-            goto exit;
-        }
-    }
-
-    ret = -EINVAL;
+	struct lynxfb_par * par;
+	struct lynxfb_crtc * crtc;
+	struct fb_var_screeninfo * var;
+	int ret;
+
+	par = info->par;
+	crtc = &par->crtc;
+	var = &info->var;
+	ret = 0;
+
+	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
+	if(regno > 256){
+		pr_err("regno = %d\n",regno);
+		return -EINVAL;
+	}
+
+	if(info->var.grayscale)
+		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+
+	if(var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR)
+	{
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
+		ret = crtc->proc_setColReg(crtc,regno,red,green,blue);
+		goto exit;
+	}
+
+
+	if(info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256 )
+	{
+		u32 val;
+		if(var->bits_per_pixel = 16 ||
+				var->bits_per_pixel = 32 ||
+				var->bits_per_pixel = 24)
+		{
+			val = chan_to_field(red,&var->red);
+			val |= chan_to_field(green,&var->green);
+			val |= chan_to_field(blue,&var->blue);
+			par->pseudo_palette[regno] = val;
+			goto exit;
+		}
+	}
+
+	ret = -EINVAL;
 
 exit:
-    return ret;
+	return ret;
 }
 
 static int lynxfb_ops_blank(int blank,struct fb_info* info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_output * output;
-	
+
 	pr_debug("blank = %d.\n",blank);
 	par = info->par;
 	output = &par->output;
@@ -670,89 +670,89 @@ static int lynxfb_ops_blank(int blank,struct fb_info* info)
 
 static int sm750fb_set_drv(struct lynxfb_par * par)
 {
-    int ret;
-    struct lynx_share * share;
-    struct sm750_share * spec_share;
-    struct lynxfb_output * output;
-    struct lynxfb_crtc * crtc;
-    
-    ret = 0;
-
-    share = par->share;
-    spec_share = container_of(share,struct sm750_share,share);
-    output = &par->output;
-    crtc = &par->crtc;
-
-    crtc->vidmem_size = (share->dual)?share->vidmem_size>>1:share->vidmem_size;
-    /* setup crtc and output member */
-    spec_share->hwCursor = g_hwcursor;
-
-    crtc->proc_setMode = hw_sm750_crtc_setMode;
-    crtc->proc_checkMode = hw_sm750_crtc_checkMode;
-    crtc->proc_setColReg = hw_sm750_setColReg;
-    crtc->proc_panDisplay = hw_sm750_pan_display;
-    crtc->clear = hw_sm750_crtc_clear;
-    crtc->line_pad = 16;
-    //crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;
-    crtc->xpanstep = 8;
-    crtc->ypanstep = 1;
-    crtc->ywrapstep = 0;
-
-    output->proc_setMode = hw_sm750_output_setMode;
-    output->proc_checkMode = hw_sm750_output_checkMode;
-
-    output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_setBLANK:hw_sm750_setBLANK;
-    output->clear = hw_sm750_output_clear;
-    /* chip specific phase */
-    share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait: hw_sm750_deWait;
-    switch (spec_share->state.dataflow)
-    {
-        case sm750_simul_pri:
-            output->paths = sm750_pnc;
-            crtc->channel = sm750_primary;
-            crtc->oScreen = 0;
-            crtc->vScreen = share->pvMem;
-            pr_info("use simul primary mode\n");
-            break;
-        case sm750_simul_sec:
-            output->paths = sm750_pnc;
-            crtc->channel = sm750_secondary;
-            crtc->oScreen = 0;
-            crtc->vScreen = share->pvMem;
-            break;
-        case sm750_dual_normal:
-            if(par->index = 0){
-                output->paths = sm750_panel;
-                crtc->channel = sm750_primary;
-                crtc->oScreen = 0;
-                crtc->vScreen = share->pvMem;
-            }else{
-                output->paths = sm750_crt;
-                crtc->channel = sm750_secondary;
-                /* not consider of padding stuffs for oScreen,need fix*/
-                crtc->oScreen = (share->vidmem_size >> 1);
-                crtc->vScreen = share->pvMem + crtc->oScreen;
-            }
-            break;
-        case sm750_dual_swap:
-            if(par->index = 0){
-                output->paths = sm750_panel;
-                crtc->channel = sm750_secondary;
-                crtc->oScreen = 0;
-                crtc->vScreen = share->pvMem;
-            }else{
-                output->paths = sm750_crt;
-                crtc->channel = sm750_primary;
-                /* not consider of padding stuffs for oScreen,need fix*/
-                crtc->oScreen = (share->vidmem_size >> 1);
-                crtc->vScreen = share->pvMem + crtc->oScreen;
-            }
-            break;
-        default:
-            ret = -EINVAL;
-    }
-
-    return ret;
+	int ret;
+	struct lynx_share * share;
+	struct sm750_share * spec_share;
+	struct lynxfb_output * output;
+	struct lynxfb_crtc * crtc;
+
+	ret = 0;
+
+	share = par->share;
+	spec_share = container_of(share,struct sm750_share,share);
+	output = &par->output;
+	crtc = &par->crtc;
+
+	crtc->vidmem_size = (share->dual)?share->vidmem_size>>1:share->vidmem_size;
+	/* setup crtc and output member */
+	spec_share->hwCursor = g_hwcursor;
+
+	crtc->proc_setMode = hw_sm750_crtc_setMode;
+	crtc->proc_checkMode = hw_sm750_crtc_checkMode;
+	crtc->proc_setColReg = hw_sm750_setColReg;
+	crtc->proc_panDisplay = hw_sm750_pan_display;
+	crtc->clear = hw_sm750_crtc_clear;
+	crtc->line_pad = 16;
+	//crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;
+	crtc->xpanstep = 8;
+	crtc->ypanstep = 1;
+	crtc->ywrapstep = 0;
+
+	output->proc_setMode = hw_sm750_output_setMode;
+	output->proc_checkMode = hw_sm750_output_checkMode;
+
+	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_setBLANK:hw_sm750_setBLANK;
+	output->clear = hw_sm750_output_clear;
+	/* chip specific phase */
+	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait: hw_sm750_deWait;
+	switch (spec_share->state.dataflow)
+	{
+	case sm750_simul_pri:
+		output->paths = sm750_pnc;
+		crtc->channel = sm750_primary;
+		crtc->oScreen = 0;
+		crtc->vScreen = share->pvMem;
+		pr_info("use simul primary mode\n");
+		break;
+	case sm750_simul_sec:
+		output->paths = sm750_pnc;
+		crtc->channel = sm750_secondary;
+		crtc->oScreen = 0;
+		crtc->vScreen = share->pvMem;
+		break;
+	case sm750_dual_normal:
+		if(par->index = 0){
+			output->paths = sm750_panel;
+			crtc->channel = sm750_primary;
+			crtc->oScreen = 0;
+			crtc->vScreen = share->pvMem;
+		}else{
+			output->paths = sm750_crt;
+			crtc->channel = sm750_secondary;
+			/* not consider of padding stuffs for oScreen,need fix*/
+			crtc->oScreen = (share->vidmem_size >> 1);
+			crtc->vScreen = share->pvMem + crtc->oScreen;
+		}
+		break;
+	case sm750_dual_swap:
+		if(par->index = 0){
+			output->paths = sm750_panel;
+			crtc->channel = sm750_secondary;
+			crtc->oScreen = 0;
+			crtc->vScreen = share->pvMem;
+		}else{
+			output->paths = sm750_crt;
+			crtc->channel = sm750_primary;
+			/* not consider of padding stuffs for oScreen,need fix*/
+			crtc->oScreen = (share->vidmem_size >> 1);
+			crtc->vScreen = share->pvMem + crtc->oScreen;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
 }
 
 static struct fb_ops lynxfb_ops={
@@ -771,86 +771,86 @@ static struct fb_ops lynxfb_ops={
 
 static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 {
-    int i;
-    struct lynxfb_par * par;
-    struct lynx_share * share;
-    struct lynxfb_crtc * crtc;
-    struct lynxfb_output * output;
-    struct fb_var_screeninfo * var;
-    struct fb_fix_screeninfo * fix;
-
-    const struct fb_videomode * pdb[] = {
-        lynx750_ext, NULL,vesa_modes,
-    };
-    int cdb[] = {ARRAY_SIZE(lynx750_ext),0,VESA_MODEDB_SIZE};
-    static const char * mdb_desc[] ={
-        "driver prepared modes",
-        "kernel prepared default modedb",
-        "kernel HELPERS prepared vesa_modes",
-    };
-
-
-    static const char * fixId[2]-    {
-        "sm750_fb1","sm750_fb2",
-    };
-
-    int ret,line_length;
-    
-    ret = 0;
-    par = (struct lynxfb_par *)info->par;
-    share = par->share;
-    crtc = &par->crtc;
-    output = &par->output;
-    var = &info->var;
-    fix = &info->fix;
-
-    /* set index */
-    par->index = index;
-    output->channel = &crtc->channel;
+	int i;
+	struct lynxfb_par * par;
+	struct lynx_share * share;
+	struct lynxfb_crtc * crtc;
+	struct lynxfb_output * output;
+	struct fb_var_screeninfo * var;
+	struct fb_fix_screeninfo * fix;
+
+	const struct fb_videomode * pdb[] = {
+		lynx750_ext, NULL,vesa_modes,
+	};
+	int cdb[] = {ARRAY_SIZE(lynx750_ext),0,VESA_MODEDB_SIZE};
+	static const char * mdb_desc[] ={
+		"driver prepared modes",
+		"kernel prepared default modedb",
+		"kernel HELPERS prepared vesa_modes",
+	};
+
+
+	static const char * fixId[2]+	{
+		"sm750_fb1","sm750_fb2",
+	};
+
+	int ret,line_length;
+
+	ret = 0;
+	par = (struct lynxfb_par *)info->par;
+	share = par->share;
+	crtc = &par->crtc;
+	output = &par->output;
+	var = &info->var;
+	fix = &info->fix;
+
+	/* set index */
+	par->index = index;
+	output->channel = &crtc->channel;
 	sm750fb_set_drv(par);
-        lynxfb_ops.fb_pan_display = lynxfb_ops_pan_display;
-
-
-    /* set current cursor variable and proc pointer,
-     * must be set after crtc member initialized */
-       crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
-        crtc->cursor.mmio = share->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
-
-        pr_info("crtc->cursor.mmio = %p\n",crtc->cursor.mmio);
-        crtc->cursor.maxH = crtc->cursor.maxW = 64;
-        crtc->cursor.size = crtc->cursor.maxH*crtc->cursor.maxW*2/8;
-        crtc->cursor.disable = hw_cursor_disable;
-        crtc->cursor.enable = hw_cursor_enable;
-        crtc->cursor.setColor = hw_cursor_setColor;
-        crtc->cursor.setPos = hw_cursor_setPos;
-        crtc->cursor.setSize = hw_cursor_setSize;
-        crtc->cursor.setData = hw_cursor_setData;
-        crtc->cursor.vstart = share->pvMem + crtc->cursor.offset;
-
-
-    crtc->cursor.share = share;
-    memset(crtc->cursor.vstart, 0, crtc->cursor.size);
-    if(!g_hwcursor){
-        lynxfb_ops.fb_cursor = NULL;
-        crtc->cursor.disable(&crtc->cursor);
-    }
-
-
-    /* set info->fbops, must be set before fb_find_mode */
-    if(!share->accel_off){
-        /* use 2d acceleration */
-        lynxfb_ops.fb_fillrect = lynxfb_ops_fillrect;
-        lynxfb_ops.fb_copyarea = lynxfb_ops_copyarea;
-        lynxfb_ops.fb_imageblit = lynxfb_ops_imageblit;
-    }
-    info->fbops = &lynxfb_ops;
-
-    if(!g_fbmode[index]){
-        g_fbmode[index] = g_def_fbmode;
-        if(index)
-            g_fbmode[index] = g_fbmode[0];
-    }
+	lynxfb_ops.fb_pan_display = lynxfb_ops_pan_display;
+
+
+	/* set current cursor variable and proc pointer,
+	 * must be set after crtc member initialized */
+	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
+	crtc->cursor.mmio = share->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
+
+	pr_info("crtc->cursor.mmio = %p\n",crtc->cursor.mmio);
+	crtc->cursor.maxH = crtc->cursor.maxW = 64;
+	crtc->cursor.size = crtc->cursor.maxH*crtc->cursor.maxW*2/8;
+	crtc->cursor.disable = hw_cursor_disable;
+	crtc->cursor.enable = hw_cursor_enable;
+	crtc->cursor.setColor = hw_cursor_setColor;
+	crtc->cursor.setPos = hw_cursor_setPos;
+	crtc->cursor.setSize = hw_cursor_setSize;
+	crtc->cursor.setData = hw_cursor_setData;
+	crtc->cursor.vstart = share->pvMem + crtc->cursor.offset;
+
+
+	crtc->cursor.share = share;
+	memset(crtc->cursor.vstart, 0, crtc->cursor.size);
+	if(!g_hwcursor){
+		lynxfb_ops.fb_cursor = NULL;
+		crtc->cursor.disable(&crtc->cursor);
+	}
+
+
+	/* set info->fbops, must be set before fb_find_mode */
+	if(!share->accel_off){
+		/* use 2d acceleration */
+		lynxfb_ops.fb_fillrect = lynxfb_ops_fillrect;
+		lynxfb_ops.fb_copyarea = lynxfb_ops_copyarea;
+		lynxfb_ops.fb_imageblit = lynxfb_ops_imageblit;
+	}
+	info->fbops = &lynxfb_ops;
+
+	if(!g_fbmode[index]){
+		g_fbmode[index] = g_def_fbmode;
+		if(index)
+			g_fbmode[index] = g_fbmode[0];
+	}
 
 
 	for(i=0;i<3;i++){
@@ -870,7 +870,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 			break;
 		}else if(ret = 3){
 			pr_warn("wanna use default mode\n");
-//			break;
+			//			break;
 		}else if(ret = 4){
 			pr_warn("fall back to any valid mode\n");
 		}else{
@@ -878,94 +878,94 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 		}
 	}
 
-    /* some member of info->var had been set by fb_find_mode */
-
-    pr_info("Member of info->var is :\n\
-            xres=%d\n\
-            yres=%d\n\
-            xres_virtual=%d\n\
-            yres_virtual=%d\n\
-            xoffset=%d\n\
-            yoffset=%d\n\
-            bits_per_pixel=%d\n \
-            ...\n",var->xres,var->yres,var->xres_virtual,var->yres_virtual,
-            var->xoffset,var->yoffset,var->bits_per_pixel);
-
-    /* set par */
-    par->info = info;
-
-    /* set info */
-    line_length = PADDING(crtc->line_pad,
-            (var->xres_virtual * var->bits_per_pixel/8));
-
-    info->pseudo_palette = &par->pseudo_palette[0];
-    info->screen_base = crtc->vScreen;
-    pr_debug("screen_base vaddr = %p\n",info->screen_base);
+	/* some member of info->var had been set by fb_find_mode */
+
+	pr_info("Member of info->var is :\n\
+			xres=%d\n\
+			yres=%d\n\
+			xres_virtual=%d\n\
+			yres_virtual=%d\n\
+			xoffset=%d\n\
+			yoffset=%d\n\
+			bits_per_pixel=%d\n \
+			...\n",var->xres,var->yres,var->xres_virtual,var->yres_virtual,
+			var->xoffset,var->yoffset,var->bits_per_pixel);
+
+	/* set par */
+	par->info = info;
+
+	/* set info */
+	line_length = PADDING(crtc->line_pad,
+			(var->xres_virtual * var->bits_per_pixel/8));
+
+	info->pseudo_palette = &par->pseudo_palette[0];
+	info->screen_base = crtc->vScreen;
+	pr_debug("screen_base vaddr = %p\n",info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 	info->flags = FBINFO_FLAG_DEFAULT|0;
 
-    /* set info->fix */
-    fix->type = FB_TYPE_PACKED_PIXELS;
-    fix->type_aux = 0;
-    fix->xpanstep = crtc->xpanstep;
-    fix->ypanstep = crtc->ypanstep;
-    fix->ywrapstep = crtc->ywrapstep;
-    fix->accel = FB_ACCEL_SMI;
+	/* set info->fix */
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->type_aux = 0;
+	fix->xpanstep = crtc->xpanstep;
+	fix->ypanstep = crtc->ypanstep;
+	fix->ywrapstep = crtc->ywrapstep;
+	fix->accel = FB_ACCEL_SMI;
 
-    strlcpy(fix->id,fixId[index],sizeof(fix->id));
+	strlcpy(fix->id,fixId[index],sizeof(fix->id));
 
 
 	fix->smem_start = crtc->oScreen + share->vidmem_start;
 	pr_info("fix->smem_start = %lx\n",fix->smem_start);
-    /* according to mmap experiment from user space application,
-     * fix->mmio_len should not larger than virtual size
-     * (xres_virtual x yres_virtual x ByPP)
-     * Below line maybe buggy when user mmap fb dev node and write
-     * data into the bound over virtual size
-     * */
-    fix->smem_len = crtc->vidmem_size;
-    pr_info("fix->smem_len = %x\n",fix->smem_len);
-    info->screen_size = fix->smem_len;
-    fix->line_length = line_length;
-    fix->mmio_start = share->vidreg_start;
-    pr_info("fix->mmio_start = %lx\n",fix->mmio_start);
-    fix->mmio_len = share->vidreg_size;
-    pr_info("fix->mmio_len = %x\n",fix->mmio_len);
-    switch(var->bits_per_pixel)
-    {
-        case 8:
-            fix->visual = FB_VISUAL_PSEUDOCOLOR;
-            break;
-        case 16:
-        case 32:
-            fix->visual = FB_VISUAL_TRUECOLOR;
-            break;
-    }
-
-    /* set var */
-    var->activate = FB_ACTIVATE_NOW;
-    var->accel_flags = 0;
-    var->vmode = FB_VMODE_NONINTERLACED;
-
-    pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-            info->cmap.start,info->cmap.len,
-            info->cmap.red,info->cmap.green,info->cmap.blue,
-            info->cmap.transp);
-
-    if((ret = fb_alloc_cmap(&info->cmap,256,0)) < 0){
-        pr_err("Could not allcate memory for cmap.\n");
-        goto exit;
-    }
-
-    pr_debug("#2 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-            info->cmap.start,info->cmap.len,
-            info->cmap.red,info->cmap.green,info->cmap.blue,
-            info->cmap.transp);
+	/* according to mmap experiment from user space application,
+	 * fix->mmio_len should not larger than virtual size
+	 * (xres_virtual x yres_virtual x ByPP)
+	 * Below line maybe buggy when user mmap fb dev node and write
+	 * data into the bound over virtual size
+	 * */
+	fix->smem_len = crtc->vidmem_size;
+	pr_info("fix->smem_len = %x\n",fix->smem_len);
+	info->screen_size = fix->smem_len;
+	fix->line_length = line_length;
+	fix->mmio_start = share->vidreg_start;
+	pr_info("fix->mmio_start = %lx\n",fix->mmio_start);
+	fix->mmio_len = share->vidreg_size;
+	pr_info("fix->mmio_len = %x\n",fix->mmio_len);
+	switch(var->bits_per_pixel)
+	{
+	case 8:
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 32:
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
+	/* set var */
+	var->activate = FB_ACTIVATE_NOW;
+	var->accel_flags = 0;
+	var->vmode = FB_VMODE_NONINTERLACED;
+
+	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+			info->cmap.start,info->cmap.len,
+			info->cmap.red,info->cmap.green,info->cmap.blue,
+			info->cmap.transp);
+
+	if((ret = fb_alloc_cmap(&info->cmap,256,0)) < 0){
+		pr_err("Could not allcate memory for cmap.\n");
+		goto exit;
+	}
+
+	pr_debug("#2 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+			info->cmap.start,info->cmap.len,
+			info->cmap.red,info->cmap.green,info->cmap.blue,
+			info->cmap.transp);
 
 exit:
 	lynxfb_ops_check_var(var,info);
-//    lynxfb_ops_set_par(info);
-    return ret;
+	//    lynxfb_ops_set_par(info);
+	return ret;
 }
 
 /* 	chip specific g_option configuration routine */
@@ -977,94 +977,94 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
 	char * exp_res;
 #endif
 	int swap;
-	
+
 
 	spec_share = container_of(share,struct sm750_share,share);
 #ifdef CAP_EXPENSIION
-        exp_res = NULL;
+	exp_res = NULL;
 #endif
-        swap = 0;
-
-        spec_share->state.initParm.chip_clk = 0;
-        spec_share->state.initParm.mem_clk = 0;
-        spec_share->state.initParm.master_clk = 0;
-        spec_share->state.initParm.powerMode = 0;
-        spec_share->state.initParm.setAllEngOff = 0;
-        spec_share->state.initParm.resetMemory = 1;
-
-        /*defaultly turn g_hwcursor on for both view */
-        g_hwcursor = 3;
-
-        if(!src || !*src){
-            pr_warn("no specific g_option.\n");
-            goto NO_PARAM;
-        }
-
-        while((opt = strsep(&src,":")) != NULL && *opt != 0){
-			pr_err("opt=%s\n",opt);
-			pr_err("src=%s\n",src);
-
-            if(!strncmp(opt,"swap",strlen("swap")))
-                swap = 1;
-            else if(!strncmp(opt,"nocrt",strlen("nocrt")))
-                spec_share->state.nocrt = 1;
-            else if(!strncmp(opt,"36bit",strlen("36bit")))
-                spec_share->state.pnltype = sm750_doubleTFT;
-            else if(!strncmp(opt,"18bit",strlen("18bit")))
-                spec_share->state.pnltype = sm750_dualTFT;
-            else if(!strncmp(opt,"24bit",strlen("24bit")))
-                spec_share->state.pnltype = sm750_24TFT;
+	swap = 0;
+
+	spec_share->state.initParm.chip_clk = 0;
+	spec_share->state.initParm.mem_clk = 0;
+	spec_share->state.initParm.master_clk = 0;
+	spec_share->state.initParm.powerMode = 0;
+	spec_share->state.initParm.setAllEngOff = 0;
+	spec_share->state.initParm.resetMemory = 1;
+
+	/*defaultly turn g_hwcursor on for both view */
+	g_hwcursor = 3;
+
+	if(!src || !*src){
+		pr_warn("no specific g_option.\n");
+		goto NO_PARAM;
+	}
+
+	while((opt = strsep(&src,":")) != NULL && *opt != 0){
+		pr_err("opt=%s\n",opt);
+		pr_err("src=%s\n",src);
+
+		if(!strncmp(opt,"swap",strlen("swap")))
+			swap = 1;
+		else if(!strncmp(opt,"nocrt",strlen("nocrt")))
+			spec_share->state.nocrt = 1;
+		else if(!strncmp(opt,"36bit",strlen("36bit")))
+			spec_share->state.pnltype = sm750_doubleTFT;
+		else if(!strncmp(opt,"18bit",strlen("18bit")))
+			spec_share->state.pnltype = sm750_dualTFT;
+		else if(!strncmp(opt,"24bit",strlen("24bit")))
+			spec_share->state.pnltype = sm750_24TFT;
 #ifdef CAP_EXPANSION
-            else if(!strncmp(opt,"exp:",strlen("exp:")))
-                exp_res = opt + strlen("exp:");
+		else if(!strncmp(opt,"exp:",strlen("exp:")))
+			exp_res = opt + strlen("exp:");
 #endif
-            else if(!strncmp(opt,"nohwc0",strlen("nohwc0")))
-                g_hwcursor &= ~0x1;
-            else if(!strncmp(opt,"nohwc1",strlen("nohwc1")))
-                g_hwcursor &= ~0x2;
-            else if(!strncmp(opt,"nohwc",strlen("nohwc")))
-                g_hwcursor = 0;
-            else
-            {
-                if(!g_fbmode[0]){
-                    g_fbmode[0] = opt;
-                    pr_info("find fbmode0 : %s\n",g_fbmode[0]);
-                }else if(!g_fbmode[1]){
-                    g_fbmode[1] = opt;
-                    pr_info("find fbmode1 : %s\n",g_fbmode[1]);
-                }else{
-                    pr_warn("How many view you wann set?\n");
-                }
-            }
-        }
+		else if(!strncmp(opt,"nohwc0",strlen("nohwc0")))
+			g_hwcursor &= ~0x1;
+		else if(!strncmp(opt,"nohwc1",strlen("nohwc1")))
+			g_hwcursor &= ~0x2;
+		else if(!strncmp(opt,"nohwc",strlen("nohwc")))
+			g_hwcursor = 0;
+		else
+		{
+			if(!g_fbmode[0]){
+				g_fbmode[0] = opt;
+				pr_info("find fbmode0 : %s\n",g_fbmode[0]);
+			}else if(!g_fbmode[1]){
+				g_fbmode[1] = opt;
+				pr_info("find fbmode1 : %s\n",g_fbmode[1]);
+			}else{
+				pr_warn("How many view you wann set?\n");
+			}
+		}
+	}
 #ifdef CAP_EXPANSION
-        if(getExpRes(exp_res,&spec_share->state.xLCD,&spec_share->state.yLCD))
-        {
-            /* seems exp_res is not valid*/
-            spec_share->state.xLCD = spec_share->state.yLCD = 0;
-        }
+	if(getExpRes(exp_res,&spec_share->state.xLCD,&spec_share->state.yLCD))
+	{
+		/* seems exp_res is not valid*/
+		spec_share->state.xLCD = spec_share->state.yLCD = 0;
+	}
 #endif
 
 NO_PARAM:
-        if(share->revid != SM750LE_REVISION_ID){
-            if(share->dual)
-            {
-                if(swap)
-                    spec_share->state.dataflow = sm750_dual_swap;
-                else
-                    spec_share->state.dataflow = sm750_dual_normal;
-            }else{
-                if(swap)
-                    spec_share->state.dataflow = sm750_simul_sec;
-                else
-                    spec_share->state.dataflow = sm750_simul_pri;
-            }
-        }else{
-            /* SM750LE only have one crt channel */
-            spec_share->state.dataflow = sm750_simul_sec;
-            /* sm750le do not have complex attributes*/
-            spec_share->state.nocrt = 0;
-        }
+	if(share->revid != SM750LE_REVISION_ID){
+		if(share->dual)
+		{
+			if(swap)
+				spec_share->state.dataflow = sm750_dual_swap;
+			else
+				spec_share->state.dataflow = sm750_dual_normal;
+		}else{
+			if(swap)
+				spec_share->state.dataflow = sm750_simul_sec;
+			else
+				spec_share->state.dataflow = sm750_simul_pri;
+		}
+	}else{
+		/* SM750LE only have one crt channel */
+		spec_share->state.dataflow = sm750_simul_sec;
+		/* sm750le do not have complex attributes*/
+		spec_share->state.nocrt = 0;
+	}
 }
 
 static int lynxfb_pci_probe(struct pci_dev * pdev,
@@ -1076,7 +1076,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	struct sm750_share *spec_share = NULL;
 	size_t spec_offset = 0;
 	int fbidx;
-	
+
 
 	/* enable device */
 	if(pci_enable_device(pdev)){
@@ -1161,52 +1161,52 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	hw_sm750_inithw(share,pdev);
 
 	/* allocate frame buffer info structor according to g_dualview */
-		fbidx = 0;
+	fbidx = 0;
 ALLOC_FB:
-		info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par),&pdev->dev);
-		if(!info[fbidx])
-		{
-			pr_err("Could not allocate framebuffer #%d.\n",fbidx);
+	info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par),&pdev->dev);
+	if(!info[fbidx])
+	{
+		pr_err("Could not allocate framebuffer #%d.\n",fbidx);
+		if(fbidx = 0)
+			goto err_info0_alloc;
+		else
+			goto err_info1_alloc;
+	}
+	else
+	{
+		struct lynxfb_par * par;
+		int errno;
+		pr_info("framebuffer #%d alloc okay\n",fbidx);
+		share->fbinfo[fbidx] = info[fbidx];
+		par = info[fbidx]->par;
+		par->share = share;
+
+		/* set fb_info structure */
+		if(lynxfb_set_fbinfo(info[fbidx],fbidx)){
+			pr_err("Failed to initial fb_info #%d.\n",fbidx);
 			if(fbidx = 0)
-				goto err_info0_alloc;
+				goto err_info0_set;
 			else
-				goto err_info1_alloc;
+				goto err_info1_set;
 		}
-		else
-		{
-			struct lynxfb_par * par;
-			int errno;
-			pr_info("framebuffer #%d alloc okay\n",fbidx);
-			share->fbinfo[fbidx] = info[fbidx];
-			par = info[fbidx]->par;
-			par->share = share;
-
-			/* set fb_info structure */
-			if(lynxfb_set_fbinfo(info[fbidx],fbidx)){
-				pr_err("Failed to initial fb_info #%d.\n",fbidx);
-				if(fbidx = 0)
-					goto err_info0_set;
-				else
-					goto err_info1_set;
-			}
 
-			/* register frame buffer*/
-			pr_info("Ready to register framebuffer #%d.\n",fbidx);
-			errno = register_framebuffer(info[fbidx]);
-			if (errno < 0) {
-				pr_err("Failed to register fb_info #%d. err %d\n",fbidx, errno);
-				if(fbidx = 0)
-					goto err_register0;
-				else
-					goto err_register1;
-			}
-			pr_info("Accomplished register framebuffer #%d.\n",fbidx);
+		/* register frame buffer*/
+		pr_info("Ready to register framebuffer #%d.\n",fbidx);
+		errno = register_framebuffer(info[fbidx]);
+		if (errno < 0) {
+			pr_err("Failed to register fb_info #%d. err %d\n",fbidx, errno);
+			if(fbidx = 0)
+				goto err_register0;
+			else
+				goto err_register1;
 		}
+		pr_info("Accomplished register framebuffer #%d.\n",fbidx);
+	}
 
-		/* no dual view by far */
-		fbidx++;
-		if(share->dual && fbidx < 2)
-			goto ALLOC_FB;
+	/* no dual view by far */
+	fbidx++;
+	if(share->dual && fbidx < 2)
+		goto ALLOC_FB;
 
 	return 0;
 
@@ -1268,7 +1268,7 @@ static int __init lynxfb_setup(char * options)
 {
 	int len;
 	char * opt,*tmp;
-	
+
 
 	if(!options || !*options){
 		pr_warn("no options.\n");
-- 
2.3.3


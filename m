From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:11:31 +0000
Subject: [PATCH 02/13] staging: sm750: add missing spaces after ','
Message-Id: <20150322231131.GA17080@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes checkpatch.pl error:
"ERROR: space required after that ',' (ctx:VxV)"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 264 ++++++++++++++++++++--------------------
 1 file changed, 132 insertions(+), 132 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 459807f..83c81d2 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -50,7 +50,7 @@ static int g_noaccel;
 #ifdef CONFIG_MTRR
 static int g_nomtrr;
 #endif
-static const char * g_fbmode[] = {NULL,NULL};
+static const char * g_fbmode[] = {NULL, NULL};
 static const char * g_def_fbmode = "800x600-16@60";
 static char * g_settings = NULL;
 static int g_dualview;
@@ -60,7 +60,7 @@ static char * g_option = NULL;
  * and immediatly unload driver frequently (dual)*/
 static inline void myspin_lock(spinlock_t * sl){
 	struct lynx_share * share;
-	share = container_of(sl,struct lynx_share,slock);
+	share = container_of(sl, struct lynx_share, slock);
 	if(share->dual){
 		spin_lock(sl);
 	}
@@ -68,7 +68,7 @@ static inline void myspin_lock(spinlock_t * sl){
 
 static inline void myspin_unlock(spinlock_t * sl){
 	struct lynx_share * share;
-	share = container_of(sl,struct lynx_share,slock);
+	share = container_of(sl, struct lynx_share, slock);
 	if(share->dual){
 		spin_unlock(sl);
 	}
@@ -96,13 +96,13 @@ static const struct fb_videomode lynx750_ext[] = {
 
 	/*	1280x720		[1.78:1]	*/
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/* 1280x768@60 */
-	{NULL,60,1280,768,12579,192,64,20,3,128,7,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	{NULL,60,1360,768,11804,208,64,23,1,144,3,
+	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
 		FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
 
 	/*	1360 x 768	[1.77083:1]	*/
@@ -115,7 +115,7 @@ static const struct fb_videomode lynx750_ext[] = {
 
 	/* 	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
-		FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	1440x960		[15:10]	*/
 	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
@@ -123,14 +123,14 @@ static const struct fb_videomode lynx750_ext[] = {
 
 	/*	1920x1080	[16:9]	*/
 	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
-		FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 };
 
 
 
 
 /* no hardware cursor supported under version 2.6.10, kernel bug */
-static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
+static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -148,17 +148,17 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 
 	cursor->disable(cursor);
 	if(fbcursor->set & FB_CUR_SETSIZE){
-		cursor->setSize(cursor,fbcursor->image.width,fbcursor->image.height);
+		cursor->setSize(cursor, fbcursor->image.width, fbcursor->image.height);
 	}
 
 	if(fbcursor->set & FB_CUR_SETPOS){
-		cursor->setPos(cursor,fbcursor->image.dx - info->var.xoffset,
+		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
 				fbcursor->image.dy - info->var.yoffset);
 	}
 
 	if(fbcursor->set & FB_CUR_SETCMAP){
 		/* get the 16bit color of kernel means */
-		u16 fg,bg;
+		u16 fg, bg;
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
 			((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
 			((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
@@ -167,7 +167,7 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 			((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
 			((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		cursor->setColor(cursor,fg,bg);
+		cursor->setColor(cursor, fg, bg);
 	}
 
 
@@ -186,11 +186,11 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 	return 0;
 }
 
-static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* region)
+static void lynxfb_ops_fillrect(struct fb_info* info, const struct fb_fillrect* region)
 {
 	struct lynxfb_par * par;
 	struct lynx_share * share;
-	unsigned int base,pitch,Bpp,rop;
+	unsigned int base, pitch, Bpp, rop;
 	u32 color;
 
 	if(info->state != FBINFO_STATE_RUNNING){
@@ -211,18 +211,18 @@ static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* r
 
 	myspin_lock(&share->slock);
 	share->accel.de_fillrect(&share->accel,
-			base,pitch,Bpp,
-			region->dx,region->dy,
-			region->width,region->height,
-			color,rop);
+			base, pitch, Bpp,
+			region->dx, region->dy,
+			region->width, region->height,
+			color, rop);
 	myspin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea * region)
+static void lynxfb_ops_copyarea(struct fb_info * info, const struct fb_copyarea * region)
 {
 	struct lynxfb_par * par;
 	struct lynx_share * share;
-	unsigned int base,pitch,Bpp;
+	unsigned int base, pitch, Bpp;
 
 	par = info->par;
 	share = par->share;
@@ -235,16 +235,16 @@ static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea *
 
 	myspin_lock(&share->slock);
 	share->accel.de_copyarea(&share->accel,
-			base,pitch,region->sx,region->sy,
-			base,pitch,Bpp,region->dx,region->dy,
-			region->width,region->height,HW_ROP2_COPY);
+			base, pitch, region->sx, region->sy,
+			base, pitch, Bpp, region->dx, region->dy,
+			region->width, region->height, HW_ROP2_COPY);
 	myspin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* image)
+static void lynxfb_ops_imageblit(struct fb_info*info, const struct fb_image* image)
 {
-	unsigned int base,pitch,Bpp;
-	unsigned int fgcol,bgcol;
+	unsigned int base, pitch, Bpp;
+	unsigned int fgcol, bgcol;
 	struct lynxfb_par * par;
 	struct lynx_share * share;
 
@@ -274,11 +274,11 @@ static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* imag
 _do_work:
 	myspin_lock(&share->slock);
 	share->accel.de_imageblit(&share->accel,
-			image->data,image->width>>3,0,
-			base,pitch,Bpp,
-			image->dx,image->dy,
-			image->width,image->height,
-			fgcol,bgcol,HW_ROP2_COPY);
+			image->data, image->width>>3, 0,
+			base, pitch, Bpp,
+			image->dx, image->dy,
+			image->width, image->height,
+			fgcol, bgcol, HW_ROP2_COPY);
 	myspin_unlock(&share->slock);
 }
 
@@ -325,9 +325,9 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 
 	/* fix structur is not so FIX ... */
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
-	line_length = PADDING(crtc->line_pad,line_length);
+	line_length = PADDING(crtc->line_pad, line_length);
 	fix->line_length = line_length;
-	pr_err("fix->line_length = %d\n",fix->line_length);
+	pr_err("fix->line_length = %d\n", fix->line_length);
 
 	/* var->red,green,blue,transp are need to be set by driver
 	 * and these data should be set before setcolreg routine
@@ -377,13 +377,13 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 		pr_err("pixel bpp format not satisfied\n.");
 		return ret;
 	}
-	ret = crtc->proc_setMode(crtc,var,fix);
+	ret = crtc->proc_setMode(crtc, var, fix);
 	if(!ret)
-		ret = output->proc_setMode(output,var,fix);
+		ret = output->proc_setMode(output, var, fix);
 	return ret;
 }
 
-static inline unsigned int chan_to_field(unsigned int chan,struct fb_bitfield * bf)
+static inline unsigned int chan_to_field(unsigned int chan, struct fb_bitfield * bf)
 {
 	chan &= 0xffff;
 	chan >>= 16 - bf->length;
@@ -461,7 +461,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	console_lock();
 
 	if((ret = pci_set_power_state(pdev, PCI_D0)) != 0){
-		pr_err("error:%d occured in pci_set_power_state\n",ret);
+		pr_err("error:%d occured in pci_set_power_state\n", ret);
 		return ret;
 	}
 
@@ -469,7 +469,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	if(pdev->dev.power.power_state.event != PM_EVENT_FREEZE){
 		pci_restore_state(pdev);
 		if ((ret = pci_enable_device(pdev)) != 0){
-			pr_err("error:%d occured in pci_enable_device\n",ret);
+			pr_err("error:%d occured in pci_enable_device\n", ret);
 			return ret;
 		}
 		pci_set_master(pdev);
@@ -477,7 +477,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	if(share->resume)
 		(*share->resume)(share);
 
-	hw_sm750_inithw(share,pdev);
+	hw_sm750_inithw(share, pdev);
 
 
 	info = share->fbinfo[0];
@@ -487,7 +487,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset(cursor->vstart, 0x0, cursor->size);
-		memset(crtc->vScreen,0x0,crtc->vidmem_size);
+		memset(crtc->vScreen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -499,7 +499,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset(cursor->vstart, 0x0, cursor->size);
-		memset(crtc->vScreen,0x0,crtc->vidmem_size);
+		memset(crtc->vScreen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -510,7 +510,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 }
 #endif
 
-static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* info)
+static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -539,7 +539,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* in
 	case 32:
 		break;
 	default:
-		pr_err("bpp %d not supported\n",var->bits_per_pixel);
+		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -588,24 +588,24 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* in
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
 	/* defaulty crtc->channel go with par->index */
 
-	request = PADDING(crtc->line_pad,request);
+	request = PADDING(crtc->line_pad, request);
 	request = request * var->yres_virtual;
 	if(crtc->vidmem_size < request){
 		pr_err("not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
-	ret = output->proc_checkMode(output,var);
+	ret = output->proc_checkMode(output, var);
 	if(!ret)
-		ret = crtc->proc_checkMode(crtc,var);
+		ret = crtc->proc_checkMode(crtc, var);
 exit:
 	return ret;
 }
 
 
-static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
-		unsigned green,unsigned blue,
-		unsigned transp,struct fb_info * info)
+static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
+		unsigned green, unsigned blue,
+		unsigned transp, struct fb_info * info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -619,7 +619,7 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
 
 	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
 	if(regno > 256){
-		pr_err("regno = %d\n",regno);
+		pr_err("regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -631,7 +631,7 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		ret = crtc->proc_setColReg(crtc,regno,red,green,blue);
+		ret = crtc->proc_setColReg(crtc, regno, red, green, blue);
 		goto exit;
 	}
 
@@ -643,9 +643,9 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
 				var->bits_per_pixel = 32 ||
 				var->bits_per_pixel = 24)
 		{
-			val = chan_to_field(red,&var->red);
-			val |= chan_to_field(green,&var->green);
-			val |= chan_to_field(blue,&var->blue);
+			val = chan_to_field(red, &var->red);
+			val |= chan_to_field(green, &var->green);
+			val |= chan_to_field(blue, &var->blue);
 			par->pseudo_palette[regno] = val;
 			goto exit;
 		}
@@ -657,15 +657,15 @@ exit:
 	return ret;
 }
 
-static int lynxfb_ops_blank(int blank,struct fb_info* info)
+static int lynxfb_ops_blank(int blank, struct fb_info* info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_output * output;
 
-	pr_debug("blank = %d.\n",blank);
+	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output,blank);
+	return output->proc_setBLANK(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par * par)
@@ -679,7 +679,7 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
 	ret = 0;
 
 	share = par->share;
-	spec_share = container_of(share,struct sm750_share,share);
+	spec_share = container_of(share, struct sm750_share, share);
 	output = &par->output;
 	crtc = &par->crtc;
 
@@ -769,7 +769,7 @@ static struct fb_ops lynxfb_ops={
 };
 
 
-static int lynxfb_set_fbinfo(struct fb_info* info,int index)
+static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 {
 	int i;
 	struct lynxfb_par * par;
@@ -780,9 +780,9 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	struct fb_fix_screeninfo * fix;
 
 	const struct fb_videomode * pdb[] = {
-		lynx750_ext, NULL,vesa_modes,
+		lynx750_ext, NULL, vesa_modes,
 	};
-	int cdb[] = {ARRAY_SIZE(lynx750_ext),0,VESA_MODEDB_SIZE};
+	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
 	static const char * mdb_desc[] ={
 		"driver prepared modes",
 		"kernel prepared default modedb",
@@ -792,10 +792,10 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	static const char * fixId[2] 	{
-		"sm750_fb1","sm750_fb2",
+		"sm750_fb1", "sm750_fb2",
 	};
 
-	int ret,line_length;
+	int ret, line_length;
 
 	ret = 0;
 	par = (struct lynxfb_par *)info->par;
@@ -817,7 +817,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
 	crtc->cursor.mmio = share->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
 
-	pr_info("crtc->cursor.mmio = %p\n",crtc->cursor.mmio);
+	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.maxH = crtc->cursor.maxW = 64;
 	crtc->cursor.size = crtc->cursor.maxH*crtc->cursor.maxW*2/8;
 	crtc->cursor.disable = hw_cursor_disable;
@@ -855,8 +855,8 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	for(i=0;i<3;i++){
 
-		ret = fb_find_mode(var,info,g_fbmode[index],
-				pdb[i],cdb[i],NULL,8);
+		ret = fb_find_mode(var, info, g_fbmode[index],
+				pdb[i], cdb[i], NULL, 8);
 
 		if(ret = 1){
 			pr_info("success! use specified mode:%s in %s\n",
@@ -874,7 +874,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 		}else if(ret = 4){
 			pr_warn("fall back to any valid mode\n");
 		}else{
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",ret,mdb_desc[i]);
+			pr_warn("ret = %d,fb_find_mode failed,with %s\n", ret, mdb_desc[i]);
 		}
 	}
 
@@ -888,8 +888,8 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 			xoffset=%d\n\
 			yoffset=%d\n\
 			bits_per_pixel=%d\n \
-			...\n",var->xres,var->yres,var->xres_virtual,var->yres_virtual,
-			var->xoffset,var->yoffset,var->bits_per_pixel);
+			...\n", var->xres, var->yres, var->xres_virtual, var->yres_virtual,
+			var->xoffset, var->yoffset, var->bits_per_pixel);
 
 	/* set par */
 	par->info = info;
@@ -900,7 +900,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->vScreen;
-	pr_debug("screen_base vaddr = %p\n",info->screen_base);
+	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 	info->flags = FBINFO_FLAG_DEFAULT|0;
 
@@ -912,11 +912,11 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	fix->ywrapstep = crtc->ywrapstep;
 	fix->accel = FB_ACCEL_SMI;
 
-	strlcpy(fix->id,fixId[index],sizeof(fix->id));
+	strlcpy(fix->id, fixId[index], sizeof(fix->id));
 
 
 	fix->smem_start = crtc->oScreen + share->vidmem_start;
-	pr_info("fix->smem_start = %lx\n",fix->smem_start);
+	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/* according to mmap experiment from user space application,
 	 * fix->mmio_len should not larger than virtual size
 	 * (xres_virtual x yres_virtual x ByPP)
@@ -924,13 +924,13 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	 * data into the bound over virtual size
 	 * */
 	fix->smem_len = crtc->vidmem_size;
-	pr_info("fix->smem_len = %x\n",fix->smem_len);
+	pr_info("fix->smem_len = %x\n", fix->smem_len);
 	info->screen_size = fix->smem_len;
 	fix->line_length = line_length;
 	fix->mmio_start = share->vidreg_start;
-	pr_info("fix->mmio_start = %lx\n",fix->mmio_start);
+	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = share->vidreg_size;
-	pr_info("fix->mmio_len = %x\n",fix->mmio_len);
+	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
 	switch(var->bits_per_pixel)
 	{
 	case 8:
@@ -948,28 +948,28 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	var->vmode = FB_VMODE_NONINTERLACED;
 
 	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-			info->cmap.start,info->cmap.len,
-			info->cmap.red,info->cmap.green,info->cmap.blue,
+			info->cmap.start, info->cmap.len,
+			info->cmap.red, info->cmap.green, info->cmap.blue,
 			info->cmap.transp);
 
-	if((ret = fb_alloc_cmap(&info->cmap,256,0)) < 0){
+	if((ret = fb_alloc_cmap(&info->cmap, 256, 0)) < 0){
 		pr_err("Could not allcate memory for cmap.\n");
 		goto exit;
 	}
 
 	pr_debug("#2 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-			info->cmap.start,info->cmap.len,
-			info->cmap.red,info->cmap.green,info->cmap.blue,
+			info->cmap.start, info->cmap.len,
+			info->cmap.red, info->cmap.green, info->cmap.blue,
 			info->cmap.transp);
 
 exit:
-	lynxfb_ops_check_var(var,info);
+	lynxfb_ops_check_var(var, info);
 	//    lynxfb_ops_set_par(info);
 	return ret;
 }
 
 /* 	chip specific g_option configuration routine */
-static void sm750fb_setup(struct lynx_share * share,char * src)
+static void sm750fb_setup(struct lynx_share * share, char * src)
 {
 	struct sm750_share * spec_share;
 	char * opt;
@@ -979,7 +979,7 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
 	int swap;
 
 
-	spec_share = container_of(share,struct sm750_share,share);
+	spec_share = container_of(share, struct sm750_share, share);
 #ifdef CAP_EXPENSIION
 	exp_res = NULL;
 #endif
@@ -1000,45 +1000,45 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
 		goto NO_PARAM;
 	}
 
-	while((opt = strsep(&src,":")) != NULL && *opt != 0){
-		pr_err("opt=%s\n",opt);
-		pr_err("src=%s\n",src);
+	while((opt = strsep(&src, ":")) != NULL && *opt != 0){
+		pr_err("opt=%s\n", opt);
+		pr_err("src=%s\n", src);
 
-		if(!strncmp(opt,"swap",strlen("swap")))
+		if(!strncmp(opt, "swap", strlen("swap")))
 			swap = 1;
-		else if(!strncmp(opt,"nocrt",strlen("nocrt")))
+		else if(!strncmp(opt, "nocrt", strlen("nocrt")))
 			spec_share->state.nocrt = 1;
-		else if(!strncmp(opt,"36bit",strlen("36bit")))
+		else if(!strncmp(opt, "36bit", strlen("36bit")))
 			spec_share->state.pnltype = sm750_doubleTFT;
-		else if(!strncmp(opt,"18bit",strlen("18bit")))
+		else if(!strncmp(opt, "18bit", strlen("18bit")))
 			spec_share->state.pnltype = sm750_dualTFT;
-		else if(!strncmp(opt,"24bit",strlen("24bit")))
+		else if(!strncmp(opt, "24bit", strlen("24bit")))
 			spec_share->state.pnltype = sm750_24TFT;
 #ifdef CAP_EXPANSION
-		else if(!strncmp(opt,"exp:",strlen("exp:")))
+		else if(!strncmp(opt, "exp:", strlen("exp:")))
 			exp_res = opt + strlen("exp:");
 #endif
-		else if(!strncmp(opt,"nohwc0",strlen("nohwc0")))
+		else if(!strncmp(opt, "nohwc0", strlen("nohwc0")))
 			g_hwcursor &= ~0x1;
-		else if(!strncmp(opt,"nohwc1",strlen("nohwc1")))
+		else if(!strncmp(opt, "nohwc1", strlen("nohwc1")))
 			g_hwcursor &= ~0x2;
-		else if(!strncmp(opt,"nohwc",strlen("nohwc")))
+		else if(!strncmp(opt, "nohwc", strlen("nohwc")))
 			g_hwcursor = 0;
 		else
 		{
 			if(!g_fbmode[0]){
 				g_fbmode[0] = opt;
-				pr_info("find fbmode0 : %s\n",g_fbmode[0]);
+				pr_info("find fbmode0 : %s\n", g_fbmode[0]);
 			}else if(!g_fbmode[1]){
 				g_fbmode[1] = opt;
-				pr_info("find fbmode1 : %s\n",g_fbmode[1]);
+				pr_info("find fbmode1 : %s\n", g_fbmode[1]);
 			}else{
 				pr_warn("How many view you wann set?\n");
 			}
 		}
 	}
 #ifdef CAP_EXPANSION
-	if(getExpRes(exp_res,&spec_share->state.xLCD,&spec_share->state.yLCD))
+	if(getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD))
 	{
 		/* seems exp_res is not valid*/
 		spec_share->state.xLCD = spec_share->state.yLCD = 0;
@@ -1070,7 +1070,7 @@ NO_PARAM:
 static int lynxfb_pci_probe(struct pci_dev * pdev,
 		const struct pci_device_id * ent)
 {
-	struct fb_info * info[] = {NULL,NULL};
+	struct fb_info * info[] = {NULL, NULL};
 	struct lynx_share * share = NULL;
 
 	struct sm750_share *spec_share = NULL;
@@ -1086,9 +1086,9 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 
 	/* though offset of share in sm750_share is 0,
 	 * we use this marcro as the same */
-	spec_offset = offsetof(struct sm750_share,share);
+	spec_offset = offsetof(struct sm750_share, share);
 
-	spec_share = kzalloc(sizeof(*spec_share),GFP_KERNEL);
+	spec_share = kzalloc(sizeof(*spec_share), GFP_KERNEL);
 	if(!spec_share){
 		pr_err("Could not allocate memory for share.\n");
 		goto err_share;
@@ -1100,7 +1100,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	share->devid = pdev->device;
 	share->revid = pdev->revision;
 
-	pr_info("share->revid = %02x\n",share->revid);
+	pr_info("share->revid = %02x\n", share->revid);
 	share->pdev = pdev;
 #ifdef CONFIG_MTRR
 	share->mtrr_off = g_nomtrr;
@@ -1126,10 +1126,10 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	}
 
 	/* call chip specific setup routine  */
-	sm750fb_setup(share,g_settings);
+	sm750fb_setup(share, g_settings);
 
 	/* call chip specific mmap routine */
-	if(hw_sm750_map(share,pdev)){
+	if(hw_sm750_map(share, pdev)){
 		pr_err("Memory map failed\n");
 		goto err_map;
 	}
@@ -1139,7 +1139,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 		pr_info("enable mtrr\n");
 		share->mtrr.vram = mtrr_add(share->vidmem_start,
 				share->vidmem_size,
-				MTRR_TYPE_WRCOMB,1);
+				MTRR_TYPE_WRCOMB, 1);
 
 		if(share->mtrr.vram < 0){
 			/* don't block driver with the failure of MTRR */
@@ -1151,22 +1151,22 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	}
 #endif
 
-	memset(share->pvMem,0,share->vidmem_size);
+	memset(share->pvMem, 0, share->vidmem_size);
 
-	pr_info("sm%3x mmio address = %p\n",share->devid,share->pvReg);
+	pr_info("sm%3x mmio address = %p\n", share->devid, share->pvReg);
 
-	pci_set_drvdata(pdev,share);
+	pci_set_drvdata(pdev, share);
 
 	/* call chipInit routine */
-	hw_sm750_inithw(share,pdev);
+	hw_sm750_inithw(share, pdev);
 
 	/* allocate frame buffer info structor according to g_dualview */
 	fbidx = 0;
 ALLOC_FB:
-	info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par),&pdev->dev);
+	info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par), &pdev->dev);
 	if(!info[fbidx])
 	{
-		pr_err("Could not allocate framebuffer #%d.\n",fbidx);
+		pr_err("Could not allocate framebuffer #%d.\n", fbidx);
 		if(fbidx = 0)
 			goto err_info0_alloc;
 		else
@@ -1176,14 +1176,14 @@ ALLOC_FB:
 	{
 		struct lynxfb_par * par;
 		int errno;
-		pr_info("framebuffer #%d alloc okay\n",fbidx);
+		pr_info("framebuffer #%d alloc okay\n", fbidx);
 		share->fbinfo[fbidx] = info[fbidx];
 		par = info[fbidx]->par;
 		par->share = share;
 
 		/* set fb_info structure */
-		if(lynxfb_set_fbinfo(info[fbidx],fbidx)){
-			pr_err("Failed to initial fb_info #%d.\n",fbidx);
+		if(lynxfb_set_fbinfo(info[fbidx], fbidx)){
+			pr_err("Failed to initial fb_info #%d.\n", fbidx);
 			if(fbidx = 0)
 				goto err_info0_set;
 			else
@@ -1191,16 +1191,16 @@ ALLOC_FB:
 		}
 
 		/* register frame buffer*/
-		pr_info("Ready to register framebuffer #%d.\n",fbidx);
+		pr_info("Ready to register framebuffer #%d.\n", fbidx);
 		errno = register_framebuffer(info[fbidx]);
 		if (errno < 0) {
-			pr_err("Failed to register fb_info #%d. err %d\n",fbidx, errno);
+			pr_err("Failed to register fb_info #%d. err %d\n", fbidx, errno);
 			if(fbidx = 0)
 				goto err_register0;
 			else
 				goto err_register1;
 		}
-		pr_info("Accomplished register framebuffer #%d.\n",fbidx);
+		pr_info("Accomplished register framebuffer #%d.\n", fbidx);
 	}
 
 	/* no dual view by far */
@@ -1252,16 +1252,16 @@ static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
 	}
 #ifdef CONFIG_MTRR
 	if(share->mtrr.vram_added)
-		mtrr_del(share->mtrr.vram,share->vidmem_start,share->vidmem_size);
+		mtrr_del(share->mtrr.vram, share->vidmem_start, share->vidmem_size);
 #endif
 	//	pci_release_regions(pdev);
 
 	iounmap(share->pvReg);
 	iounmap(share->pvMem);
-	spec_share = container_of(share,struct sm750_share,share);
+	spec_share = container_of(share, struct sm750_share, share);
 	kfree(g_settings);
 	kfree(spec_share);
-	pci_set_drvdata(pdev,NULL);
+	pci_set_drvdata(pdev, NULL);
 }
 
 static int __init lynxfb_setup(char * options)
@@ -1275,7 +1275,7 @@ static int __init lynxfb_setup(char * options)
 		return 0;
 	}
 
-	pr_info("options:%s\n",options);
+	pr_info("options:%s\n", options);
 
 	len = strlen(options) + 1;
 	g_settings = kzalloc(len, GFP_KERNEL);
@@ -1292,20 +1292,20 @@ static int __init lynxfb_setup(char * options)
 		strsep() updates @options to pointer after the first found token
 		it also returns the pointer ahead the token.
 		*/
-	while((opt = strsep(&options,":"))!=NULL)
+	while((opt = strsep(&options, ":"))!=NULL)
 	{
 		/* options that mean for any lynx chips are configured here */
-		if(!strncmp(opt,"noaccel",strlen("noaccel")))
+		if(!strncmp(opt, "noaccel", strlen("noaccel")))
 			g_noaccel = 1;
 #ifdef CONFIG_MTRR
-		else if(!strncmp(opt,"nomtrr",strlen("nomtrr")))
+		else if(!strncmp(opt, "nomtrr", strlen("nomtrr")))
 			g_nomtrr = 1;
 #endif
-		else if(!strncmp(opt,"dual",strlen("dual")))
+		else if(!strncmp(opt, "dual", strlen("dual")))
 			g_dualview = 1;
 		else
 		{
-			strcat(tmp,opt);
+			strcat(tmp, opt);
 			tmp += strlen(opt);
 			if(options != NULL)
 				*tmp++ = ':';
@@ -1315,7 +1315,7 @@ static int __init lynxfb_setup(char * options)
 	}
 
 	/* misc g_settings are transport to chip specific routines */
-	pr_info("parameter left for chip specific analysis:%s\n",g_settings);
+	pr_info("parameter left for chip specific analysis:%s\n", g_settings);
 	return 0;
 }
 
@@ -1324,7 +1324,7 @@ static struct pci_device_id smi_pci_table[] = {
 	{0,}
 };
 
-MODULE_DEVICE_TABLE(pci,smi_pci_table);
+MODULE_DEVICE_TABLE(pci, smi_pci_table);
 
 static struct pci_driver lynxfb_driver = {
 	.name =		"sm750fb",
@@ -1346,7 +1346,7 @@ static int __init lynxfb_init(void)
 #ifdef MODULE
 	option = g_option;
 #else
-	if(fb_get_options("sm750fb",&option))
+	if(fb_get_options("sm750fb", &option))
 		return -ENODEV;
 #endif
 
@@ -1362,7 +1362,7 @@ static void __exit lynxfb_exit(void)
 }
 module_exit(lynxfb_exit);
 
-module_param(g_option,charp,S_IRUGO);
+module_param(g_option, charp, S_IRUGO);
 
 MODULE_PARM_DESC(g_option,
 		"\n\t\tCommon options:\n"
-- 
2.3.3


From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:24:53 +0000
Subject: [PATCH v2 02/12] staging: sm750: add missing spaces after ','
Message-Id: <b464743fe899a0b8c6a3ae37f7fd45a38892ff87.1427406762.git.michel.von.czettritz@gmail.com>
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
index 87b50fc..e98eefc 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -50,26 +50,26 @@ static int g_noaccel;
 #ifdef CONFIG_MTRR
 static int g_nomtrr;
 #endif
-static const char * g_fbmode[] = {NULL,NULL};
+static const char * g_fbmode[] = {NULL, NULL};
 static const char * g_def_fbmode = "800x600-16@60";
 static char * g_settings = NULL;
 static int g_dualview;
 static char * g_option = NULL;
 
 static const struct fb_videomode lynx750_ext[] = {
-	/*	1024x600-60 VESA	[1.71:1]	*/
+	/*  	1024x600-60 VESA 	[1.71:1]	*/
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*	1024x600-70 VESA */
+	/* 	1024x600-70 VESA */
 	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*	1024x600-75 VESA */
+	/*  	1024x600-75 VESA */
 	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*	1024x600-85 VESA */
+	/*  	1024x600-85 VESA */
 	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
@@ -79,13 +79,13 @@ static const struct fb_videomode lynx750_ext[] = {
 
 	/*	1280x720		[1.78:1]	*/
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*	1280x768@60 */
-	{NULL,60,1280,768,12579,192,64,20,3,128,7,
+	/* 1280x768@60 */
+	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 
-	{NULL,60,1360,768,11804,208,64,23,1,144,3,
+	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
 	 FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
 
 	/*	1360 x 768	[1.77083:1]	*/
@@ -96,9 +96,9 @@ static const struct fb_videomode lynx750_ext[] = {
 	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*	1440 x 900		[16:10]	*/
+	/* 	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
-	 FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+	 FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
 	/*	1440x960		[15:10]	*/
 	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
@@ -106,14 +106,14 @@ static const struct fb_videomode lynx750_ext[] = {
 
 	/*	1920x1080	[16:9]	*/
 	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
-	 FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
+	 FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 };
 
 
 
 
 /* no hardware cursor supported under version 2.6.10, kernel bug */
-static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
+static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -131,17 +131,17 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 
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
@@ -150,7 +150,7 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
 		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
 		      ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		cursor->setColor(cursor,fg,bg);
+		cursor->setColor(cursor, fg, bg);
 	}
 
 
@@ -169,11 +169,11 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
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
@@ -200,19 +200,19 @@ static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* r
 		spin_lock(&share->slock);
 
 	share->accel.de_fillrect(&share->accel,
-				 base,pitch,Bpp,
-				 region->dx,region->dy,
-				 region->width,region->height,
-				 color,rop);
+				 base, pitch, Bpp,
+				 region->dx, region->dy,
+				 region->width, region->height,
+				 color, rop);
 	if (share->dual)
 		spin_unlock(&share->slock);
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
@@ -231,17 +231,17 @@ static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea *
 		spin_lock(&share->slock);
 
 	share->accel.de_copyarea(&share->accel,
-				 base,pitch,region->sx,region->sy,
-				 base,pitch,Bpp,region->dx,region->dy,
-				 region->width,region->height,HW_ROP2_COPY);
+				 base, pitch, region->sx, region->sy,
+				 base, pitch, Bpp, region->dx, region->dy,
+				 region->width, region->height, HW_ROP2_COPY);
 	if (share->dual)
 		spin_unlock(&share->slock);
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
 
@@ -277,11 +277,11 @@ _do_work:
 		spin_lock(&share->slock);
 
 	share->accel.de_imageblit(&share->accel,
-				  image->data,image->width>>3,0,
-				  base,pitch,Bpp,
-				  image->dx,image->dy,
-				  image->width,image->height,
-				  fgcol,bgcol,HW_ROP2_COPY);
+				  image->data, image->width>>3, 0,
+				  base, pitch, Bpp,
+				  image->dx, image->dy,
+				  image->width, image->height,
+				  fgcol, bgcol, HW_ROP2_COPY);
 	if (share->dual)
 		spin_unlock(&share->slock);
 }
@@ -329,9 +329,9 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 
 	/* fix structur is not so FIX ... */
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
-	line_length = PADDING(crtc->line_pad,line_length);
+	line_length = PADDING(crtc->line_pad, line_length);
 	fix->line_length = line_length;
-	pr_err("fix->line_length = %d\n",fix->line_length);
+	pr_err("fix->line_length = %d\n", fix->line_length);
 
 	/* var->red,green,blue,transp are need to be set by driver
 	 * and these data should be set before setcolreg routine
@@ -381,13 +381,13 @@ static int lynxfb_ops_set_par(struct fb_info * info)
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
@@ -465,7 +465,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	console_lock();
 
 	if((ret = pci_set_power_state(pdev, PCI_D0)) != 0){
-		pr_err("error:%d occured in pci_set_power_state\n",ret);
+		pr_err("error:%d occured in pci_set_power_state\n", ret);
 		return ret;
 	}
 
@@ -473,7 +473,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	if(pdev->dev.power.power_state.event != PM_EVENT_FREEZE){
 		pci_restore_state(pdev);
 		if ((ret = pci_enable_device(pdev)) != 0){
-			pr_err("error:%d occured in pci_enable_device\n",ret);
+			pr_err("error:%d occured in pci_enable_device\n", ret);
 			return ret;
 		}
 		pci_set_master(pdev);
@@ -481,7 +481,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 	if(share->resume)
 		(*share->resume)(share);
 
-	hw_sm750_inithw(share,pdev);
+	hw_sm750_inithw(share, pdev);
 
 
 	info = share->fbinfo[0];
@@ -514,7 +514,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 }
 #endif
 
-static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* info)
+static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -543,7 +543,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* in
 	case 32:
 		break;
 	default:
-		pr_err("bpp %d not supported\n",var->bits_per_pixel);
+		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -592,24 +592,24 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* in
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
-				unsigned green,unsigned blue,
-				unsigned transp,struct fb_info * info)
+static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
+				unsigned green, unsigned blue,
+				unsigned transp, struct fb_info * info)
 {
 	struct lynxfb_par * par;
 	struct lynxfb_crtc * crtc;
@@ -623,7 +623,7 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
 
 	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
 	if(regno > 256){
-		pr_err("regno = %d\n",regno);
+		pr_err("regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -635,7 +635,7 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		ret = crtc->proc_setColReg(crtc,regno,red,green,blue);
+		ret = crtc->proc_setColReg(crtc, regno, red, green, blue);
 		goto exit;
 	}
 
@@ -647,9 +647,9 @@ static int lynxfb_ops_setcolreg(unsigned regno,unsigned red,
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
@@ -661,15 +661,15 @@ exit:
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
@@ -683,7 +683,7 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
 	ret = 0;
 
 	share = par->share;
-	spec_share = container_of(share,struct sm750_share,share);
+	spec_share = container_of(share, struct sm750_share, share);
 	output = &par->output;
 	crtc = &par->crtc;
 
@@ -773,7 +773,7 @@ static struct fb_ops lynxfb_ops={
 };
 
 
-static int lynxfb_set_fbinfo(struct fb_info* info,int index)
+static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 {
 	int i;
 	struct lynxfb_par * par;
@@ -784,9 +784,9 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
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
@@ -796,10 +796,10 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	static const char * fixId[2] 	{
-		"sm750_fb1","sm750_fb2",
+		"sm750_fb1", "sm750_fb2",
 	};
 
-	int ret,line_length;
+	int ret, line_length;
 
 	ret = 0;
 	par = (struct lynxfb_par *)info->par;
@@ -821,7 +821,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
 	crtc->cursor.mmio = share->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
 
-	pr_info("crtc->cursor.mmio = %p\n",crtc->cursor.mmio);
+	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.maxH = crtc->cursor.maxW = 64;
 	crtc->cursor.size = crtc->cursor.maxH*crtc->cursor.maxW*2/8;
 	crtc->cursor.disable = hw_cursor_disable;
@@ -859,8 +859,8 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	for(i=0;i<3;i++){
 
-		ret = fb_find_mode(var,info,g_fbmode[index],
-				   pdb[i],cdb[i],NULL,8);
+		ret = fb_find_mode(var, info, g_fbmode[index],
+				   pdb[i], cdb[i], NULL, 8);
 
 		if(ret = 1){
 			pr_info("success! use specified mode:%s in %s\n",
@@ -878,7 +878,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 		}else if(ret = 4){
 			pr_warn("fall back to any valid mode\n");
 		}else{
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",ret,mdb_desc[i]);
+			pr_warn("ret = %d,fb_find_mode failed,with %s\n", ret, mdb_desc[i]);
 		}
 	}
 
@@ -892,8 +892,8 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 			xoffset=%d\n\
 			yoffset=%d\n\
 			bits_per_pixel=%d\n \
-			...\n",var->xres,var->yres,var->xres_virtual,var->yres_virtual,
-			var->xoffset,var->yoffset,var->bits_per_pixel);
+			...\n", var->xres, var->yres, var->xres_virtual, var->yres_virtual,
+			var->xoffset, var->yoffset, var->bits_per_pixel);
 
 	/* set par */
 	par->info = info;
@@ -904,7 +904,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->vScreen;
-	pr_debug("screen_base vaddr = %p\n",info->screen_base);
+	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 	info->flags = FBINFO_FLAG_DEFAULT|0;
 
@@ -916,11 +916,11 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
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
@@ -928,13 +928,13 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
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
@@ -952,28 +952,28 @@ static int lynxfb_set_fbinfo(struct fb_info* info,int index)
 	var->vmode = FB_VMODE_NONINTERLACED;
 
 	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start,info->cmap.len,
-		 info->cmap.red,info->cmap.green,info->cmap.blue,
+		 info->cmap.start, info->cmap.len,
+		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
 
-	if((ret = fb_alloc_cmap(&info->cmap,256,0)) < 0){
+	if((ret = fb_alloc_cmap(&info->cmap, 256, 0)) < 0){
 		pr_err("Could not allcate memory for cmap.\n");
 		goto exit;
 	}
 
 	pr_debug("#2 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start,info->cmap.len,
-		 info->cmap.red,info->cmap.green,info->cmap.blue,
+		 info->cmap.start, info->cmap.len,
+		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
 
 exit:
-	lynxfb_ops_check_var(var,info);
+	lynxfb_ops_check_var(var, info);
 	//    lynxfb_ops_set_par(info);
 	return ret;
 }
 
 /*	chip specific g_option configuration routine */
-static void sm750fb_setup(struct lynx_share * share,char * src)
+static void sm750fb_setup(struct lynx_share * share, char * src)
 {
 	struct sm750_share * spec_share;
 	char * opt;
@@ -983,7 +983,7 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
 	int swap;
 
 
-	spec_share = container_of(share,struct sm750_share,share);
+	spec_share = container_of(share, struct sm750_share, share);
 #ifdef CAP_EXPENSIION
 	exp_res = NULL;
 #endif
@@ -1004,45 +1004,45 @@ static void sm750fb_setup(struct lynx_share * share,char * src)
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
@@ -1074,7 +1074,7 @@ NO_PARAM:
 static int lynxfb_pci_probe(struct pci_dev * pdev,
 			    const struct pci_device_id * ent)
 {
-	struct fb_info * info[] = {NULL,NULL};
+	struct fb_info * info[] = {NULL, NULL};
 	struct lynx_share * share = NULL;
 
 	struct sm750_share *spec_share = NULL;
@@ -1090,9 +1090,9 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 
 	/* though offset of share in sm750_share is 0,
 	 * we use this marcro as the same */
-	spec_offset = offsetof(struct sm750_share,share);
+	spec_offset = offsetof(struct sm750_share, share);
 
-	spec_share = kzalloc(sizeof(*spec_share),GFP_KERNEL);
+	spec_share = kzalloc(sizeof(*spec_share), GFP_KERNEL);
 	if(!spec_share){
 		pr_err("Could not allocate memory for share.\n");
 		goto err_share;
@@ -1104,7 +1104,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	share->devid = pdev->device;
 	share->revid = pdev->revision;
 
-	pr_info("share->revid = %02x\n",share->revid);
+	pr_info("share->revid = %02x\n", share->revid);
 	share->pdev = pdev;
 #ifdef CONFIG_MTRR
 	share->mtrr_off = g_nomtrr;
@@ -1130,10 +1130,10 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
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
@@ -1143,7 +1143,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 		pr_info("enable mtrr\n");
 		share->mtrr.vram = mtrr_add(share->vidmem_start,
 					    share->vidmem_size,
-					    MTRR_TYPE_WRCOMB,1);
+					    MTRR_TYPE_WRCOMB, 1);
 
 		if(share->mtrr.vram < 0){
 			/* don't block driver with the failure of MTRR */
@@ -1157,20 +1157,20 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 
 	memset_io(share->pvMem, 0, share->vidmem_size);
 
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
@@ -1180,14 +1180,14 @@ ALLOC_FB:
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
@@ -1195,16 +1195,16 @@ ALLOC_FB:
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
@@ -1256,16 +1256,16 @@ static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
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
@@ -1279,7 +1279,7 @@ static int __init lynxfb_setup(char * options)
 		return 0;
 	}
 
-	pr_info("options:%s\n",options);
+	pr_info("options:%s\n", options);
 
 	len = strlen(options) + 1;
 	g_settings = kzalloc(len, GFP_KERNEL);
@@ -1296,20 +1296,20 @@ static int __init lynxfb_setup(char * options)
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
@@ -1319,7 +1319,7 @@ static int __init lynxfb_setup(char * options)
 	}
 
 	/* misc g_settings are transport to chip specific routines */
-	pr_info("parameter left for chip specific analysis:%s\n",g_settings);
+	pr_info("parameter left for chip specific analysis:%s\n", g_settings);
 	return 0;
 }
 
@@ -1328,7 +1328,7 @@ static struct pci_device_id smi_pci_table[] = {
 	{0,}
 };
 
-MODULE_DEVICE_TABLE(pci,smi_pci_table);
+MODULE_DEVICE_TABLE(pci, smi_pci_table);
 
 static struct pci_driver lynxfb_driver = {
 	.name =		"sm750fb",
@@ -1350,7 +1350,7 @@ static int __init lynxfb_init(void)
 #ifdef MODULE
 	option = g_option;
 #else
-	if(fb_get_options("sm750fb",&option))
+	if(fb_get_options("sm750fb", &option))
 		return -ENODEV;
 #endif
 
@@ -1366,7 +1366,7 @@ static void __exit lynxfb_exit(void)
 }
 module_exit(lynxfb_exit);
 
-module_param(g_option,charp,S_IRUGO);
+module_param(g_option, charp, S_IRUGO);
 
 MODULE_PARM_DESC(g_option,
 		 "\n\t\tCommon options:\n"
-- 
2.3.3


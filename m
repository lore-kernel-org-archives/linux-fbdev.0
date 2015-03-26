From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:25:22 +0000
Subject: [PATCH v2 04/12] staging: sm750: fix whitespace around braces
Message-Id: <e9dfbb627e86bde96caf24f1429c99204edc335c.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix multiple similar checkpatch.pl errors:

- "ERROR: space required before the open parenthesis '('"
- "ERROR: space required before the open brace '{'"
- "ERROR: space prohibited after that open parenthesis '('"
- "ERROR: space prohibited before that close parenthesis ')'"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 194 ++++++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index bc2986d..6d148a5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -39,9 +39,9 @@ int smi_indent = 0;
  * #endif
  */
 
-typedef void (*PROC_SPEC_SETUP)(struct lynx_share*,char *);
-typedef int (*PROC_SPEC_MAP)(struct lynx_share*,struct pci_dev*);
-typedef int (*PROC_SPEC_INITHW)(struct lynx_share*,struct pci_dev*);
+typedef void (*PROC_SPEC_SETUP)(struct lynx_share*, char *);
+typedef int (*PROC_SPEC_MAP)(struct lynx_share*, struct pci_dev*);
+typedef int (*PROC_SPEC_INITHW)(struct lynx_share*, struct pci_dev*);
 
 
 /* common var for all device */
@@ -123,23 +123,23 @@ static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 	crtc = &par->crtc;
 	cursor = &crtc->cursor;
 
-	if(fbcursor->image.width > cursor->maxW ||
+	if (fbcursor->image.width > cursor->maxW ||
 	   fbcursor->image.height > cursor->maxH ||
-	   fbcursor->image.depth > 1){
+	   fbcursor->image.depth > 1) {
 		return -ENXIO;
 	}
 
 	cursor->disable(cursor);
-	if(fbcursor->set & FB_CUR_SETSIZE){
+	if (fbcursor->set & FB_CUR_SETSIZE) {
 		cursor->setSize(cursor, fbcursor->image.width, fbcursor->image.height);
 	}
 
-	if(fbcursor->set & FB_CUR_SETPOS){
+	if (fbcursor->set & FB_CUR_SETPOS) {
 		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
 			       fbcursor->image.dy - info->var.yoffset);
 	}
 
-	if(fbcursor->set & FB_CUR_SETCMAP){
+	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
 		u16 fg, bg;
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
@@ -154,14 +154,14 @@ static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 	}
 
 
-	if(fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
 		cursor->setData(cursor,
 				fbcursor->rop,
 				fbcursor->image.data,
 				fbcursor->mask);
 	}
 
-	if(fbcursor->enable){
+	if (fbcursor->enable) {
 		cursor->enable(cursor);
 	}
 
@@ -175,7 +175,7 @@ static void lynxfb_ops_fillrect(struct fb_info* info, const struct fb_fillrect*
 	unsigned int base, pitch, Bpp, rop;
 	u32 color;
 
-	if(info->state != FBINFO_STATE_RUNNING){
+	if (info->state != FBINFO_STATE_RUNNING) {
 		return;
 	}
 
@@ -189,7 +189,7 @@ static void lynxfb_ops_fillrect(struct fb_info* info, const struct fb_fillrect*
 	Bpp = info->var.bits_per_pixel >> 3;
 
 	color = (Bpp = 1)?region->color:((u32*)info->pseudo_palette)[region->color];
-	rop = ( region->rop != ROP_COPY ) ? HW_ROP2_XOR:HW_ROP2_COPY;
+	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR:HW_ROP2_COPY;
 
 	/*
 	 * If not use spin_lock,system will die if user load driver
@@ -252,8 +252,8 @@ static void lynxfb_ops_imageblit(struct fb_info*info, const struct fb_image* ima
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	if(image->depth = 1){
-		if(info->fix.visual = FB_VISUAL_TRUECOLOR ||
+	if (image->depth = 1) {
+		if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
 				info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
 			fgcol = ((u32*)info->pseudo_palette)[image->fg_color];
 			bgcol = ((u32*)info->pseudo_palette)[image->bg_color];
@@ -290,7 +290,7 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	int ret;
 
 
-	if(!info)
+	if (!info)
 		return -EINVAL;
 
 	ret = 0;
@@ -312,7 +312,7 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 	int ret;
 	unsigned int line_length;
 
-	if(!info)
+	if (!info)
 		return -EINVAL;
 
 	ret = 0;
@@ -333,7 +333,7 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 	 * and these data should be set before setcolreg routine
 	 * */
 
-	switch(var->bits_per_pixel){
+	switch (var->bits_per_pixel) {
 	case 8:
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		var->red.offset = 0;
@@ -373,12 +373,12 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 	var->height = var->width = -1;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
-	if(ret){
+	if (ret) {
 		pr_err("pixel bpp format not satisfied\n.");
 		return ret;
 	}
 	ret = crtc->proc_setMode(crtc, var, fix);
-	if(!ret)
+	if (!ret)
 		ret = output->proc_setMode(output, var, fix);
 	return ret;
 }
@@ -460,21 +460,21 @@ static int lynxfb_resume(struct pci_dev* pdev)
 
 	console_lock();
 
-	if((ret = pci_set_power_state(pdev, PCI_D0)) != 0){
+	if ((ret = pci_set_power_state(pdev, PCI_D0)) != 0) {
 		pr_err("error:%d occured in pci_set_power_state\n", ret);
 		return ret;
 	}
 
 
-	if(pdev->dev.power.power_state.event != PM_EVENT_FREEZE){
+	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
 		pci_restore_state(pdev);
-		if ((ret = pci_enable_device(pdev)) != 0){
+		if ((ret = pci_enable_device(pdev)) != 0) {
 			pr_err("error:%d occured in pci_enable_device\n", ret);
 			return ret;
 		}
 		pci_set_master(pdev);
 	}
-	if(share->resume)
+	if (share->resume)
 		(*share->resume)(share);
 
 	hw_sm750_inithw(share, pdev);
@@ -482,7 +482,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 
 	info = share->fbinfo[0];
 
-	if(info){
+	if (info) {
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
@@ -494,7 +494,7 @@ static int lynxfb_resume(struct pci_dev* pdev)
 
 	info = share->fbinfo[1];
 
-	if(info){
+	if (info) {
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
@@ -532,7 +532,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* i
 		 var->bits_per_pixel);
 
 
-	switch(var->bits_per_pixel){
+	switch (var->bits_per_pixel) {
 	case 8:
 	case 16:
 	case 24: /* support 24 bpp for only lynx712/722/720 */
@@ -544,7 +544,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* i
 		goto exit;
 	}
 
-	switch(var->bits_per_pixel){
+	switch (var->bits_per_pixel) {
 	case 8:
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		var->red.offset = 0;
@@ -590,13 +590,13 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* i
 
 	request = PADDING(crtc->line_pad, request);
 	request = request * var->yres_virtual;
-	if(crtc->vidmem_size < request){
+	if (crtc->vidmem_size < request) {
 		pr_err("not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
 	ret = output->proc_checkMode(output, var);
-	if(!ret)
+	if (!ret)
 		ret = crtc->proc_checkMode(crtc, var);
 exit:
 	return ret;
@@ -618,15 +618,15 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	ret = 0;
 
 	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
-	if(regno > 256){
+	if (regno > 256) {
 		pr_err("regno = %d\n", regno);
 		return -EINVAL;
 	}
 
-	if(info->var.grayscale)
+	if (info->var.grayscale)
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 
-	if(var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
+	if (var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
@@ -635,9 +635,9 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	}
 
 
-	if(info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256 ) {
+	if (info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256) {
 		u32 val;
-		if(var->bits_per_pixel = 16 ||
+		if (var->bits_per_pixel = 16 ||
 		   var->bits_per_pixel = 32 ||
 		   var->bits_per_pixel = 24) {
 			val = chan_to_field(red, &var->red);
@@ -717,12 +717,12 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
 		crtc->vScreen = share->pvMem;
 		break;
 	case sm750_dual_normal:
-		if(par->index = 0){
+		if (par->index = 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->oScreen = 0;
 			crtc->vScreen = share->pvMem;
-		}else{
+		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for oScreen,need fix*/
@@ -731,12 +731,12 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
 		}
 		break;
 	case sm750_dual_swap:
-		if(par->index = 0){
+		if (par->index = 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->oScreen = 0;
 			crtc->vScreen = share->pvMem;
-		}else{
+		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
 			/* not consider of padding stuffs for oScreen,need fix*/
@@ -826,14 +826,14 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 
 	crtc->cursor.share = share;
 		memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
-	if(!g_hwcursor){
+	if (!g_hwcursor) {
 		lynxfb_ops.fb_cursor = NULL;
 		crtc->cursor.disable(&crtc->cursor);
 	}
 
 
 	/* set info->fbops, must be set before fb_find_mode */
-	if(!share->accel_off){
+	if (!share->accel_off) {
 		/* use 2d acceleration */
 		lynxfb_ops.fb_fillrect = lynxfb_ops_fillrect;
 		lynxfb_ops.fb_copyarea = lynxfb_ops_copyarea;
@@ -841,34 +841,34 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 	}
 	info->fbops = &lynxfb_ops;
 
-	if(!g_fbmode[index]){
+	if (!g_fbmode[index]) {
 		g_fbmode[index] = g_def_fbmode;
-		if(index)
+		if (index)
 			g_fbmode[index] = g_fbmode[0];
 	}
 
 
-	for(i=0;i<3;i++){
+	for (i=0;i<3;i++) {
 
 		ret = fb_find_mode(var, info, g_fbmode[index],
 				   pdb[i], cdb[i], NULL, 8);
 
-		if(ret = 1){
+		if (ret = 1) {
 			pr_info("success! use specified mode:%s in %s\n",
 				g_fbmode[index],
 				mdb_desc[i]);
 			break;
-		}else if(ret = 2){
+		} else if (ret = 2) {
 			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
 				g_fbmode[index],
 				mdb_desc[i]);
 			break;
-		}else if(ret = 3){
+		} else if (ret = 3) {
 			pr_warn("wanna use default mode\n");
 			//			break;
-		}else if(ret = 4){
+		} else if (ret = 4) {
 			pr_warn("fall back to any valid mode\n");
-		}else{
+		} else {
 			pr_warn("ret = %d,fb_find_mode failed,with %s\n", ret, mdb_desc[i]);
 		}
 	}
@@ -926,7 +926,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = share->vidreg_size;
 	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
-	switch(var->bits_per_pixel) {
+	switch (var->bits_per_pixel) {
 	case 8:
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
@@ -946,7 +946,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
 
-	if((ret = fb_alloc_cmap(&info->cmap, 256, 0)) < 0){
+	if ((ret = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
 		pr_err("Could not allcate memory for cmap.\n");
 		goto exit;
 	}
@@ -989,68 +989,68 @@ static void sm750fb_setup(struct lynx_share * share, char * src)
 	/*defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
 
-	if(!src || !*src){
+	if (!src || !*src) {
 		pr_warn("no specific g_option.\n");
 		goto NO_PARAM;
 	}
 
-	while((opt = strsep(&src, ":")) != NULL && *opt != 0){
+	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
 		pr_err("opt=%s\n", opt);
 		pr_err("src=%s\n", src);
 
-		if(!strncmp(opt, "swap", strlen("swap")))
+		if (!strncmp(opt, "swap", strlen("swap")))
 			swap = 1;
-		else if(!strncmp(opt, "nocrt", strlen("nocrt")))
+		else if (!strncmp(opt, "nocrt", strlen("nocrt")))
 			spec_share->state.nocrt = 1;
-		else if(!strncmp(opt, "36bit", strlen("36bit")))
+		else if (!strncmp(opt, "36bit", strlen("36bit")))
 			spec_share->state.pnltype = sm750_doubleTFT;
-		else if(!strncmp(opt, "18bit", strlen("18bit")))
+		else if (!strncmp(opt, "18bit", strlen("18bit")))
 			spec_share->state.pnltype = sm750_dualTFT;
-		else if(!strncmp(opt, "24bit", strlen("24bit")))
+		else if (!strncmp(opt, "24bit", strlen("24bit")))
 			spec_share->state.pnltype = sm750_24TFT;
 #ifdef CAP_EXPANSION
-		else if(!strncmp(opt, "exp:", strlen("exp:")))
+		else if (!strncmp(opt, "exp:", strlen("exp:")))
 			exp_res = opt + strlen("exp:");
 #endif
-		else if(!strncmp(opt, "nohwc0", strlen("nohwc0")))
+		else if (!strncmp(opt, "nohwc0", strlen("nohwc0")))
 			g_hwcursor &= ~0x1;
-		else if(!strncmp(opt, "nohwc1", strlen("nohwc1")))
+		else if (!strncmp(opt, "nohwc1", strlen("nohwc1")))
 			g_hwcursor &= ~0x2;
-		else if(!strncmp(opt, "nohwc", strlen("nohwc")))
+		else if (!strncmp(opt, "nohwc", strlen("nohwc")))
 			g_hwcursor = 0;
 		else {
-			if(!g_fbmode[0]){
+			if (!g_fbmode[0]) {
 				g_fbmode[0] = opt;
 				pr_info("find fbmode0 : %s\n", g_fbmode[0]);
-			}else if(!g_fbmode[1]){
+			} else if (!g_fbmode[1]) {
 				g_fbmode[1] = opt;
 				pr_info("find fbmode1 : %s\n", g_fbmode[1]);
-			}else{
+			} else {
 				pr_warn("How many view you wann set?\n");
 			}
 		}
 	}
 #ifdef CAP_EXPANSION
-	if(getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD)) {
+	if (getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD)) {
 		/* seems exp_res is not valid*/
 		spec_share->state.xLCD = spec_share->state.yLCD = 0;
 	}
 #endif
 
 NO_PARAM:
-	if(share->revid != SM750LE_REVISION_ID){
-		if(share->dual) {
-			if(swap)
+	if (share->revid != SM750LE_REVISION_ID) {
+		if (share->dual) {
+			if (swap)
 				spec_share->state.dataflow = sm750_dual_swap;
 			else
 				spec_share->state.dataflow = sm750_dual_normal;
-		}else{
-			if(swap)
+		} else {
+			if (swap)
 				spec_share->state.dataflow = sm750_simul_sec;
 			else
 				spec_share->state.dataflow = sm750_simul_pri;
 		}
-	}else{
+	} else {
 		/* SM750LE only have one crt channel */
 		spec_share->state.dataflow = sm750_simul_sec;
 		/* sm750le do not have complex attributes*/
@@ -1070,7 +1070,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 
 
 	/* enable device */
-	if(pci_enable_device(pdev)){
+	if (pci_enable_device(pdev)) {
 		pr_err("can not enable device.\n");
 		goto err_enable;
 	}
@@ -1080,13 +1080,13 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	spec_offset = offsetof(struct sm750_share, share);
 
 	spec_share = kzalloc(sizeof(*spec_share), GFP_KERNEL);
-	if(!spec_share){
+	if (!spec_share) {
 		pr_err("Could not allocate memory for share.\n");
 		goto err_share;
 	}
 
 	/* setting share structure */
-	share = (struct lynx_share * )(&(spec_share->share));
+	share = (struct lynx_share *)(&(spec_share->share));
 	share->fbinfo[0] = share->fbinfo[1] = NULL;
 	share->devid = pdev->device;
 	share->revid = pdev->revision;
@@ -1102,7 +1102,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	share->dual = g_dualview;
 	spin_lock_init(&share->slock);
 
-	if(!share->accel_off){
+	if (!share->accel_off) {
 		/* hook deInit and 2d routines, notes that below hw_xxx
 		 * routine can work on most of lynx chips
 		 * if some chip need specific function,please hook it in smXXX_set_drv
@@ -1112,7 +1112,7 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 		share->accel.de_copyarea = hw_copyarea;
 		share->accel.de_imageblit = hw_imageblit;
 		pr_info("enable 2d acceleration\n");
-	}else{
+	} else {
 		pr_info("disable 2d acceleration\n");
 	}
 
@@ -1120,22 +1120,22 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	sm750fb_setup(share, g_settings);
 
 	/* call chip specific mmap routine */
-	if(hw_sm750_map(share, pdev)){
+	if (hw_sm750_map(share, pdev)) {
 		pr_err("Memory map failed\n");
 		goto err_map;
 	}
 
 #ifdef CONFIG_MTRR
-	if(!share->mtrr_off){
+	if (!share->mtrr_off) {
 		pr_info("enable mtrr\n");
 		share->mtrr.vram = mtrr_add(share->vidmem_start,
 					    share->vidmem_size,
 					    MTRR_TYPE_WRCOMB, 1);
 
-		if(share->mtrr.vram < 0){
+		if (share->mtrr.vram < 0) {
 			/* don't block driver with the failure of MTRR */
 			pr_err("Unable to setup MTRR.\n");
-		}else{
+		} else {
 			share->mtrr.vram_added = 1;
 			pr_info("MTRR added succesfully\n");
 		}
@@ -1155,9 +1155,9 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	fbidx = 0;
 ALLOC_FB:
 	info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par), &pdev->dev);
-	if(!info[fbidx]) {
+	if (!info[fbidx]) {
 		pr_err("Could not allocate framebuffer #%d.\n", fbidx);
-		if(fbidx = 0)
+		if (fbidx = 0)
 			goto err_info0_alloc;
 		else
 			goto err_info1_alloc;
@@ -1170,9 +1170,9 @@ ALLOC_FB:
 		par->share = share;
 
 		/* set fb_info structure */
-		if(lynxfb_set_fbinfo(info[fbidx], fbidx)){
+		if (lynxfb_set_fbinfo(info[fbidx], fbidx)) {
 			pr_err("Failed to initial fb_info #%d.\n", fbidx);
-			if(fbidx = 0)
+			if (fbidx = 0)
 				goto err_info0_set;
 			else
 				goto err_info1_set;
@@ -1183,7 +1183,7 @@ ALLOC_FB:
 		errno = register_framebuffer(info[fbidx]);
 		if (errno < 0) {
 			pr_err("Failed to register fb_info #%d. err %d\n", fbidx, errno);
-			if(fbidx = 0)
+			if (fbidx = 0)
 				goto err_register0;
 			else
 				goto err_register1;
@@ -1193,7 +1193,7 @@ ALLOC_FB:
 
 	/* no dual view by far */
 	fbidx++;
-	if(share->dual && fbidx < 2)
+	if (share->dual && fbidx < 2)
 		goto ALLOC_FB;
 
 	return 0;
@@ -1225,9 +1225,9 @@ static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
 	cnt = 2;
 	share = pci_get_drvdata(pdev);
 
-	while(cnt-- > 0){
+	while (cnt-- > 0) {
 		info = share->fbinfo[cnt];
-		if(!info)
+		if (!info)
 			continue;
 		par = info->par;
 
@@ -1239,7 +1239,7 @@ static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
 		framebuffer_release(info);
 	}
 #ifdef CONFIG_MTRR
-	if(share->mtrr.vram_added)
+	if (share->mtrr.vram_added)
 		mtrr_del(share->mtrr.vram, share->vidmem_start, share->vidmem_size);
 #endif
 	//	pci_release_regions(pdev);
@@ -1258,7 +1258,7 @@ static int __init lynxfb_setup(char * options)
 	char * opt,*tmp;
 
 
-	if(!options || !*options){
+	if (!options || !*options) {
 		pr_warn("no options.\n");
 		return 0;
 	}
@@ -1267,7 +1267,7 @@ static int __init lynxfb_setup(char * options)
 
 	len = strlen(options) + 1;
 	g_settings = kzalloc(len, GFP_KERNEL);
-	if(!g_settings)
+	if (!g_settings)
 		return -ENOMEM;
 
 	tmp = g_settings;
@@ -1280,20 +1280,20 @@ static int __init lynxfb_setup(char * options)
 		strsep() updates @options to pointer after the first found token
 		it also returns the pointer ahead the token.
 		*/
-	while((opt = strsep(&options, ":"))!=NULL) {
+	while ((opt = strsep(&options, ":"))!=NULL) {
 		/* options that mean for any lynx chips are configured here */
-		if(!strncmp(opt, "noaccel", strlen("noaccel")))
+		if (!strncmp(opt, "noaccel", strlen("noaccel")))
 			g_noaccel = 1;
 #ifdef CONFIG_MTRR
-		else if(!strncmp(opt, "nomtrr", strlen("nomtrr")))
+		else if (!strncmp(opt, "nomtrr", strlen("nomtrr")))
 			g_nomtrr = 1;
 #endif
-		else if(!strncmp(opt, "dual", strlen("dual")))
+		else if (!strncmp(opt, "dual", strlen("dual")))
 			g_dualview = 1;
 		else {
 			strcat(tmp, opt);
 			tmp += strlen(opt);
-			if(options != NULL)
+			if (options != NULL)
 				*tmp++ = ':';
 			else
 				*tmp++ = 0;
@@ -1332,7 +1332,7 @@ static int __init lynxfb_init(void)
 #ifdef MODULE
 	option = g_option;
 #else
-	if(fb_get_options("sm750fb", &option))
+	if (fb_get_options("sm750fb", &option))
 		return -ENODEV;
 #endif
 
-- 
2.3.3


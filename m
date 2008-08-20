From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27-rc3 1/1] n411 and hecubafb
	improvements
Date: Wed, 20 Aug 2008 09:11:20 -0400
Message-ID: <1219237880-5573-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVnTD-0008CA-UD for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 06:11:27 -0700
Received: from ti-out-0910.google.com ([209.85.142.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVnT9-0001rC-Rc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 06:11:27 -0700
Received: by ti-out-0910.google.com with SMTP id y6so302030tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 20 Aug 2008 06:11:22 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, krzysztof.h1@wp.pl, geert@linux-m68k.org

Hi Krzysztof, Geert, Tony, and fbdev friends,

These changes are in order to improve the state of n411 and hecubafb.
It adds 2 bit support, basic partial update support, cleans up the error
handling sequence, enables n411 build, and increases timeout on n411 to
handle clocked down devices.

I would be grateful for any feedback and advice.

Thanks,
jaya

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a6b5529..b20a8bd 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o c2p.o atafb_mfb.o \
                                      atafb_iplan2p2.o atafb_iplan2p4.o atafb_iplan2p8.o
 obj-$(CONFIG_FB_MAC)              += macfb.o
+obj-$(CONFIG_FB_N411)             += n411.o
 obj-$(CONFIG_FB_HECUBA)           += hecubafb.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o
 obj-$(CONFIG_FB_XVR500)           += sunxvr500.o
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 0b4bffb..c3f8b7f 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -44,14 +44,18 @@
 
 #include <video/hecubafb.h>
 
+static unsigned int panel_mode;
+static void (*hecubafb_do_display)(struct hecubafb_par *par,
+					unsigned char *buf, u16 y1, u16 y2);
+
 /* Display specific information */
-#define DPY_W 600
-#define DPY_H 800
+#define DPY_W 800
+#define DPY_H 600
 
 static struct fb_fix_screeninfo hecubafb_fix __devinitdata = {
 	.id =		"hecubafb",
 	.type =		FB_TYPE_PACKED_PIXELS,
-	.visual =	FB_VISUAL_MONO01,
+	.visual =	FB_VISUAL_STATIC_PSEUDOCOLOR,
 	.xpanstep =	0,
 	.ypanstep =	0,
 	.ywrapstep =	0,
@@ -64,8 +68,13 @@ static struct fb_var_screeninfo hecubafb_var __devinitdata = {
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,
 	.yres_virtual	= DPY_H,
-	.bits_per_pixel	= 1,
+	.bits_per_pixel	= 8,
+	.grayscale	= 1,
 	.nonstd		= 1,
+	.red =		{ 0, 1, 0 },
+	.green =	{ 0, 1, 0 },
+	.blue =		{ 0, 1, 0 },
+	.transp =	{ 0, 0, 0 },
 };
 
 /* main hecubafb functions */
@@ -100,26 +109,135 @@ static void apollo_send_command(struct hecubafb_par *par, unsigned char data)
 	par->board->set_ctl(par, HCB_CD_BIT, 0);
 }
 
-static void hecubafb_dpy_update(struct hecubafb_par *par)
+static void hecubafb_1bit_raw_displayer(struct hecubafb_par *par,
+					unsigned char *buf, u16 j, u16 y2)
 {
 	int i;
+
+	buf += j * par->info->var.xres;
+	for (; j < y2; j++) {
+		for (i = 0; i < par->info->var.xres/8; i++)
+			apollo_send_data(par, *(buf++));
+	}
+}
+
+static void hecubafb_1bit_displayer(struct hecubafb_par *par,
+					unsigned char *buf, u16 j, u16 y2)
+{
+	int i, k;
+
+	buf += j * par->info->var.xres;
+	for (; j < y2; j++) {
+		for (i = 0; i < par->info->var.xres/8; i++) {
+			u8 output = 0;
+
+			/* input=1bpp, output byte has 8 pixels */
+			for (k = 0; k < 8; k++)
+				output |= (((*(buf++) >> 1) & 0x01) << (7 - k));
+
+			output = ~output;
+			apollo_send_data(par, output);
+		}
+	}
+}
+
+static void hecubafb_2bit_displayer(struct hecubafb_par *par,
+					unsigned char *buf, u16 j, u16 y2)
+{
+	int i, k;
+
+	buf += j * par->info->var.xres;
+	for (; j < y2; j++) {
+		for (i = 0; i < par->info->var.xres/4; i++) {
+			u8 output = 0;
+
+			/* input=2bpp, output byte has 4 pixels */
+			for (k = 0; k < 4; k++)
+				output |= (((*(buf++)) & 0x03) << (6 - (2*k)));
+
+			apollo_send_data(par, output);
+		}
+	}
+}
+
+static void hecubafb_dpy_update(struct hecubafb_par *par, int j, int y2)
+{
 	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
 
 	apollo_send_command(par, APOLLO_START_NEW_IMG);
 
-	for (i=0; i < (DPY_W*DPY_H/8); i++) {
-		apollo_send_data(par, *(buf++));
-	}
+	hecubafb_do_display(par, buf, j, y2);
 
 	apollo_send_command(par, APOLLO_STOP_IMG_DATA);
 	apollo_send_command(par, APOLLO_DISPLAY_IMG);
 }
 
+static void hecubafb_dpy_update_pages(struct hecubafb_par *par, u16 y1, u16 y2)
+{
+	u16 x2;
+	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
+
+	/* y1 must be a multiple of 4 so drop the lower bits */
+	y1 &= 0xFFFC;
+	/* y2 must be a multiple of 4 , but - 1 so up the lower bits */
+	y2 |= 0x0003;
+	apollo_send_command(par, APOLLO_START_PART_IMG);
+	apollo_send_data(par, 0);
+	apollo_send_data(par, 0);
+	apollo_send_data(par, cpu_to_le16(y1) >> 8);
+	apollo_send_data(par, cpu_to_le16(y1));
+	x2 = par->info->var.xres - 1;
+	apollo_send_data(par, cpu_to_le16(x2) >> 8);
+	apollo_send_data(par, cpu_to_le16(x2));
+	apollo_send_data(par, cpu_to_le16(y2) >> 8);
+	apollo_send_data(par, cpu_to_le16(y2));
+	hecubafb_do_display(par, buf, y1, y2 + 1);
+	apollo_send_command(par, APOLLO_STOP_IMG_DATA);
+	apollo_send_command(par, APOLLO_DISPLAY_PART_IMG);
+}
+
 /* this is called back from the deferred io workqueue */
 static void hecubafb_dpy_deferred_io(struct fb_info *info,
 				struct list_head *pagelist)
 {
-	hecubafb_dpy_update(info->par);
+	u16 y1 = 0, h = 0;
+	int prev_index = -1;
+	struct page *cur;
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+	int h_inc;
+	u16 yres = info->var.yres;
+	u16 xres = info->var.xres;
+
+	/* height increment is fixed per page */
+	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
+
+	/* walk the written page list and swizzle the data */
+	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+		if (prev_index < 0) {
+			/* just starting so assign first page */
+			y1 = (cur->index << PAGE_SHIFT) / xres;
+			h = h_inc;
+		} else if ((prev_index + 1) == cur->index) {
+			/* this page is consecutive so increase our height */
+			h += h_inc;
+		} else {
+			/* page not consecutive, issue previous update first */
+			hecubafb_dpy_update_pages(info->par, y1, y1 + h);
+			/* start over with our non consecutive page */
+			y1 = (cur->index << PAGE_SHIFT) / xres;
+			h = h_inc;
+		}
+		prev_index = cur->index;
+	}
+
+	/* if we still have any pages to update we do so now */
+	if (h >= yres) {
+		/* its a full screen update, just do it */
+		hecubafb_dpy_update(info->par, 0, yres);
+	} else {
+		hecubafb_dpy_update_pages(info->par, y1,
+						min((u16) (y1 + h), yres));
+	}
 }
 
 static void hecubafb_fillrect(struct fb_info *info,
@@ -129,7 +247,7 @@ static void hecubafb_fillrect(struct fb_info *info,
 
 	sys_fillrect(info, rect);
 
-	hecubafb_dpy_update(par);
+	hecubafb_dpy_update(par, 0, info->var.yres);
 }
 
 static void hecubafb_copyarea(struct fb_info *info,
@@ -139,7 +257,7 @@ static void hecubafb_copyarea(struct fb_info *info,
 
 	sys_copyarea(info, area);
 
-	hecubafb_dpy_update(par);
+	hecubafb_dpy_update(par, 0, info->var.yres);
 }
 
 static void hecubafb_imageblit(struct fb_info *info,
@@ -149,7 +267,7 @@ static void hecubafb_imageblit(struct fb_info *info,
 
 	sys_imageblit(info, image);
 
-	hecubafb_dpy_update(par);
+	hecubafb_dpy_update(par, 0, info->var.yres);
 }
 
 /*
@@ -193,11 +311,72 @@ static ssize_t hecubafb_write(struct fb_info *info, const char __user *buf,
 	if  (!err)
 		*ppos += count;
 
-	hecubafb_dpy_update(par);
+	hecubafb_dpy_update(par, 0, info->var.yres);
 
 	return (err) ? err : count;
 }
 
+static int hecubafb_check_var(struct fb_var_screeninfo *var,
+				struct fb_info *info)
+{
+	switch (info->var.bits_per_pixel) {
+	case 1:
+		info->fix.visual = FB_VISUAL_MONO01;
+		var->red.offset = 0; var->red.length = 1;
+		var->green.offset = 0; var->green.length = 1;
+		var->blue.offset = 0; var->blue.length = 1;
+		var->transp.offset = var->transp.length = 0;
+		var->bits_per_pixel = 1;
+		break;
+	default:
+		info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+		var->red.offset = 0; var->red.length = 2;
+		var->green.offset = 0; var->green.length = 2;
+		var->blue.offset = 0; var->blue.length = 2;
+		var->transp.offset = var->transp.length = 0;
+		var->bits_per_pixel = 8;
+		break;
+	}
+
+	var->xres = DPY_W; var->yres = DPY_H;
+
+	return 0;
+}
+
+static int hecubafb_set_par(struct fb_info *info)
+{
+	struct hecubafb_par *par = info->par;
+
+	switch (panel_mode) {
+	case 2:
+		apollo_send_command(par, APOLLO_SET_DEPTH);
+		apollo_send_data(par, 0x02);
+		info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+		hecubafb_do_display = hecubafb_2bit_displayer;
+		break;
+	case 1:
+	default:
+		apollo_send_command(par, APOLLO_SET_DEPTH);
+		apollo_send_data(par, 0x00);
+		switch (info->var.bits_per_pixel) {
+		case 1:
+			/* if the app asks 1bit, provide mono */
+			info->fix.visual = FB_VISUAL_MONO01;
+			hecubafb_do_display = hecubafb_1bit_raw_displayer;
+			break;
+		default:
+			/* otherwise stick with 8bpp */
+			info->var.bits_per_pixel = 8;
+			info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+			hecubafb_do_display = hecubafb_1bit_displayer;
+			break;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static struct fb_ops hecubafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_read        = fb_sys_read,
@@ -205,6 +384,8 @@ static struct fb_ops hecubafb_ops = {
 	.fb_fillrect	= hecubafb_fillrect,
 	.fb_copyarea	= hecubafb_copyarea,
 	.fb_imageblit	= hecubafb_imageblit,
+	.fb_check_var	= hecubafb_check_var,
+	.fb_set_par	= hecubafb_set_par,
 };
 
 static struct fb_deferred_io hecubafb_defio = {
@@ -212,6 +393,38 @@ static struct fb_deferred_io hecubafb_defio = {
 	.deferred_io	= hecubafb_dpy_deferred_io,
 };
 
+static int __devinit handle_cmap(struct fb_info *info, int mode)
+{
+	int i;
+	int retval;
+	int cmap_size;
+
+	switch (mode) {
+	case 2:
+		cmap_size = 4;
+		break;
+	case 1:
+	default:
+		cmap_size = 2;
+		break;
+	}
+
+	retval = fb_alloc_cmap(&info->cmap, cmap_size, 0);
+	if (retval < 0) {
+		printk(KERN_ERR "Failed to allocate colormap\n");
+		return retval;
+	}
+
+	/* find mid points for cmap */
+	for (i = 0; i < cmap_size; i++)
+		info->cmap.red[i] = (((2*i)+1)*(0xFFFF))/(2*cmap_size);
+
+	memcpy(info->cmap.green, info->cmap.red, sizeof(u16)*cmap_size);
+	memcpy(info->cmap.blue, info->cmap.red, sizeof(u16)*cmap_size);
+
+	return 0;
+}
+
 static int __devinit hecubafb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
@@ -230,17 +443,17 @@ static int __devinit hecubafb_probe(struct platform_device *dev)
 	if (!try_module_get(board->owner))
 		return -ENODEV;
 
-	videomemorysize = (DPY_W*DPY_H)/8;
+	info = framebuffer_alloc(sizeof(struct hecubafb_par), &dev->dev);
+	if (!info)
+		goto err;
 
-	if (!(videomemory = vmalloc(videomemorysize)))
-		return retval;
+	videomemorysize = (DPY_W*DPY_H);
+	videomemory = vmalloc(videomemorysize);
+	if (!videomemory)
+		goto err_fb_rel;
 
 	memset(videomemory, 0, videomemorysize);
 
-	info = framebuffer_alloc(sizeof(struct hecubafb_par), &dev->dev);
-	if (!info)
-		goto err_fballoc;
-
 	info->screen_base = (char __force __iomem *)videomemory;
 	info->fbops = &hecubafb_ops;
 
@@ -258,25 +471,39 @@ static int __devinit hecubafb_probe(struct platform_device *dev)
 	info->fbdefio = &hecubafb_defio;
 	fb_deferred_io_init(info);
 
+	retval = handle_cmap(info, panel_mode);
+	if (retval < 0)
+		goto err_vfree;
+
+	/* this inits the dpy */
+	retval = par->board->init(par);
+	if (retval < 0)
+		goto err_cmap;
+
+	hecubafb_set_par(info);
+
 	retval = register_framebuffer(info);
 	if (retval < 0)
-		goto err_fbreg;
+		goto err_board;
+
 	platform_set_drvdata(dev, info);
 
 	printk(KERN_INFO
 	       "fb%d: Hecuba frame buffer device, using %dK of video memory\n",
 	       info->node, videomemorysize >> 10);
 
-	/* this inits the dpy */
-	retval = par->board->init(par);
-	if (retval < 0)
-		goto err_fbreg;
-
 	return 0;
-err_fbreg:
-	framebuffer_release(info);
-err_fballoc:
+
+err_cmap:
+	fb_dealloc_cmap(&info->cmap);
+err_board:
+	if (par->board->remove)
+		par->board->remove(par);
+err_vfree:
 	vfree(videomemory);
+err_fb_rel:
+	framebuffer_release(info);
+err:
 	module_put(board->owner);
 	return retval;
 }
@@ -287,11 +514,15 @@ static int __devexit hecubafb_remove(struct platform_device *dev)
 
 	if (info) {
 		struct hecubafb_par *par = info->par;
-		fb_deferred_io_cleanup(info);
+
 		unregister_framebuffer(info);
-		vfree((void __force *)info->screen_base);
+		fb_deferred_io_cleanup(info);
+		fb_dealloc_cmap(&info->cmap);
+
 		if (par->board->remove)
 			par->board->remove(par);
+
+		vfree((void __force *)info->screen_base);
 		module_put(par->board->owner);
 		framebuffer_release(info);
 	}
@@ -317,6 +548,9 @@ static void __exit hecubafb_exit(void)
 	platform_driver_unregister(&hecubafb_driver);
 }
 
+module_param(panel_mode, uint, 0);
+MODULE_PARM_DESC(panel_mode, "Panel mode: 1 for 1 bit, 2 for 2 bit");
+
 module_init(hecubafb_init);
 module_exit(hecubafb_exit);
 
diff --git a/drivers/video/n411.c b/drivers/video/n411.c
index 935830f..9f6e570 100644
--- a/drivers/video/n411.c
+++ b/drivers/video/n411.c
@@ -80,7 +80,7 @@ static void n411_wait_for_ack(struct hecubafb_par *par, int clear)
 	int timeout;
 	unsigned char tmp;
 
-	timeout = 500;
+	timeout = 3000;
 	do {
 		tmp = n411_get_ctl(par);
 		if ((tmp & HCB_ACK_BIT) && (!clear))
@@ -130,12 +130,13 @@ static int n411_init_board(struct hecubafb_par *par)
 	par->send_data(par, 0x81);
 
 	/* have to wait while display resets */
-	udelay(1000);
+	mdelay(3000);
 
 	/* if we were told to splash the screen, we just clear it */
 	if (!nosplash) {
 		par->send_command(par, APOLLO_ERASE_DISPLAY);
 		par->send_data(par, splashval);
+		mdelay(2000);
 	}
 
 	return 0;
diff --git a/include/video/hecubafb.h b/include/video/hecubafb.h
index 7b99523..5ba77ba 100644
--- a/include/video/hecubafb.h
+++ b/include/video/hecubafb.h
@@ -18,6 +18,9 @@
 #define APOLLO_DISPLAY_IMG	0xA2
 #define APOLLO_ERASE_DISPLAY	0xA3
 #define APOLLO_INIT_DISPLAY	0xA4
+#define APOLLO_START_PART_IMG	0xB0
+#define APOLLO_DISPLAY_PART_IMG	0xB1
+#define APOLLO_SET_DEPTH	0xF3
 
 /* Hecuba interface specific defines */
 #define HCB_WUP_BIT	0x01

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

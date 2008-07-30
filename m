From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 5/5] metronomefb: changes to
	use separate framebuffer
Date: Wed, 30 Jul 2008 08:51:09 -0400
Message-ID: <1217422269-11093-6-git-send-email-jayakumar.lkml@gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOC2D-00017U-0B for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:48:09 -0700
Received: from qw-out-1920.google.com ([74.125.92.146])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOC2C-0001q1-70
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:48:08 -0700
Received: by qw-out-1920.google.com with SMTP id 5so21603qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Jul 2008 06:48:07 -0700 (PDT)
In-Reply-To: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
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
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

These changes are used in order to support the use of a separate
framebuffer provided by the platform device driver. Other changes
are cleanup to error handling and order of release.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/Kconfig       |   18 +++-
 drivers/video/metronomefb.c |  227 +++++++++++++++++++++++++------------------
 include/video/metronomefb.h |   22 ++---
 3 files changed, 153 insertions(+), 114 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 752907d..dda770c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -172,11 +172,6 @@ config FB_DEFERRED_IO
 	bool
 	depends on FB
 
-config FB_METRONOME
-	tristate
-	depends on FB
-	depends on FB_DEFERRED_IO
-
 config FB_HECUBA
 	tristate
 	depends on FB
@@ -1975,6 +1970,19 @@ config XEN_FBDEV_FRONTEND
 	  frame buffer driver.  It communicates with a back-end
 	  in another domain.
 
+config FB_METRONOME
+	tristate "E-Ink Metronome/8track controller support"
+	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+	help
+	  This driver implements support for the E-Ink Metronome
+	  controller. The pre-release name for this device was 8track
+	  and could also have been called by some vendors as PVI-nnnn.
+
 source "drivers/video/omap/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 7cda4f8..0222044 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -44,16 +44,59 @@
 #define DPY_W 832
 #define DPY_H 622
 
+static int user_wfm_size;
+
 /* frame differs from image. frame includes non-visible pixels */
 struct epd_frame {
 	int fw; /* frame width */
 	int fh; /* frame height */
+	u16 config[4];
+	int wfm_size;
 };
 
 static struct epd_frame epd_frame_table[] = {
 	{
-	.fw = 832,
-	.fh = 622
+		.fw = 832,
+		.fh = 622,
+		.config = {
+			15 /* sdlew */
+			| 2 << 8 /* sdosz */
+			| 0 << 11 /* sdor */
+			| 0 << 12 /* sdces */
+			| 0 << 15, /* sdcer */
+			42 /* gdspl */
+			| 1 << 8 /* gdr1 */
+			| 1 << 9 /* sdshr */
+			| 0 << 15, /* gdspp */
+			18 /* gdspw */
+			| 0 << 15, /* dispc */
+			599 /* vdlc */
+			| 0 << 11 /* dsi */
+			| 0 << 12, /* dsic */
+		},
+		.wfm_size = 47001,
+	},
+	{
+		.fw = 1088,
+		.fh = 791,
+		.config = {
+			0x0104,
+			0x031f,
+			0x0088,
+			0x02ff,
+		},
+		.wfm_size = 46770,
+	},
+	{
+		.fw = 1200,
+		.fh = 842,
+		.config = {
+			0x0101,
+			0x030e,
+			0x0012,
+			0x0280,
+		},
+		.wfm_size = 46770,
 	},
 };
 
@@ -125,7 +168,6 @@ static u16 calc_img_cksum(u16 *start, int length)
 }
 
 /* here we decode the incoming waveform file and populate metromem */
-#define EXP_WFORM_SIZE 47001
 static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
 				struct metronomefb_par *par)
 {
@@ -142,9 +184,12 @@ static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
 	u8 *metromem = par->metromem_wfm;
 	struct device *dev = par->info->dev;
 
-	if (size != EXP_WFORM_SIZE) {
+	if (user_wfm_size)
+		epd_frame_table[par->dt].wfm_size = user_wfm_size;
+
+	if (size != epd_frame_table[par->dt].wfm_size) {
 		dev_err(dev, "Error: unexpected size %d != %d\n", size,
-					EXP_WFORM_SIZE);
+					epd_frame_table[par->dt].wfm_size);
 		return -EINVAL;
 	}
 
@@ -328,44 +373,17 @@ static int __devinit metronome_powerup_cmd(struct metronomefb_par *par)
 
 static int __devinit metronome_config_cmd(struct metronomefb_par *par)
 {
-	int i;
-	u16 cs;
-
 	/* setup config command
 	we can't immediately set the opcode since the controller
-	will try parse the command before we've set it all up
-	so we just set cs here and set the opcode at the end */
-
-	cs = 0xCC10;
-
-	/* set the 12 args ( 8 bytes ) for config. see spec for meanings */
-	i = 0;
-	par->metromem_cmd->args[i] = 	15 /* sdlew */
-					| 2 << 8 /* sdosz */
-					| 0 << 11 /* sdor */
-					| 0 << 12 /* sdces */
-					| 0 << 15; /* sdcer */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	42 /* gdspl */
-					| 1 << 8 /* gdr1 */
-					| 1 << 9 /* sdshr */
-					| 0 << 15; /* gdspp */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	18 /* gdspw */
-					| 0 << 15; /* dispc */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	599 /* vdlc */
-					| 0 << 11 /* dsi */
-					| 0 << 12; /* dsic */
-	cs += par->metromem_cmd->args[i++];
+	will try parse the command before we've set it all up */
 
+	memcpy(par->metromem_cmd->args, epd_frame_table[par->dt].config,
+		sizeof(epd_frame_table[par->dt].config));
 	/* the rest are 0 */
-	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
+	memset((u8 *) (par->metromem_cmd->args + 4), 0, (32-4)*2);
 
-	par->metromem_cmd->csum = cs;
+	par->metromem_cmd->csum = 0xCC10;
+	par->metromem_cmd->csum += calc_img_cksum(par->metromem_cmd->args, 4);
 	par->metromem_cmd->opcode = 0xCC10; /* config cmd */
 
 	return par->board->met_wait_event(par);
@@ -401,12 +419,9 @@ static int __devinit metronome_init_regs(struct metronomefb_par *par)
 {
 	int res;
 
-	par->board->init_gpio_regs(par);
-
-	par->board->init_lcdc_regs(par);
-
-	/* now that lcd is setup, setup dma descriptor */
-	par->board->post_dma_setup(par);
+	res = par->board->setup_io(par);
+	if (res)
+		return res;
 
 	res = metronome_powerup_cmd(par);
 	if (res)
@@ -423,16 +438,16 @@ static int __devinit metronome_init_regs(struct metronomefb_par *par)
 
 static void metronomefb_dpy_update(struct metronomefb_par *par)
 {
+	int fbsize;
 	u16 cksum;
 	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
 
+	fbsize = par->info->fix.smem_len;
 	/* copy from vm to metromem */
-	memcpy(par->metromem_img, buf, DPY_W*DPY_H);
+	memcpy(par->metromem_img, buf, fbsize);
 
-	cksum = calc_img_cksum((u16 *) par->metromem_img,
-				(epd_frame_table[0].fw * DPY_H)/2);
-	*((u16 *)(par->metromem_img) +
-			(epd_frame_table[0].fw * DPY_H)/2) = cksum;
+	cksum = calc_img_cksum((u16 *) par->metromem_img, fbsize/2);
+	*((u16 *)(par->metromem_img) + fbsize/2) = cksum;
 	metronome_display_cmd(par);
 }
 
@@ -567,8 +582,11 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	unsigned char *videomemory;
 	struct metronomefb_par *par;
 	const struct firmware *fw_entry;
-	int cmd_size, wfm_size, img_size, padding_size, totalsize;
+	int cmd_size, wfm_size, padding_size;
 	int i;
+	int panel_type;
+	int fw, fh;
+	int epd_dt_index;
 
 	/* pick up board specific routines */
 	board = dev->dev.platform_data;
@@ -579,39 +597,67 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	if (!try_module_get(board->owner))
 		return -ENODEV;
 
+	info = framebuffer_alloc(sizeof(struct metronomefb_par), &dev->dev);
+	if (!info)
+		goto err;
+
 	/* we have two blocks of memory.
 	info->screen_base which is vm, and is the fb used by apps.
 	par->metromem which is physically contiguous memory and
 	contains the display controller commands, waveform,
 	processed image data and padding. this is the data pulled
-	by the device's LCD controller and pushed to Metronome */
-
-	videomemorysize = (DPY_W*DPY_H);
+	by the device's LCD controller and pushed to Metronome.
+	the metromem memory is allocated by the board driver and
+	is provided to us */
+
+	panel_type = board->get_panel_type();
+	switch (panel_type) {
+	case 6:
+		epd_dt_index = 0;
+		break;
+	case 8:
+		epd_dt_index = 1;
+		break;
+	case 97:
+		epd_dt_index = 2;
+		break;
+	default:
+		dev_err(&dev->dev, "Unexpected panel type. Defaulting to 6\n");
+		epd_dt_index = 0;
+		break;
+	}
+	fw = epd_frame_table[epd_dt_index].fw;
+	fh = epd_frame_table[epd_dt_index].fh;
+	/* we need to add a spare page because our csum caching scheme walks
+	 * to the end of the page */
+	videomemorysize = PAGE_SIZE + (fw * fh);
 	videomemory = vmalloc(videomemorysize);
 	if (!videomemory)
-		return -ENOMEM;
+		goto err_fb_rel;
 
 	memset(videomemory, 0, videomemorysize);
 
-	info = framebuffer_alloc(sizeof(struct metronomefb_par), &dev->dev);
-	if (!info)
-		goto err_vfree;
-
 	info->screen_base = (char __force __iomem *)videomemory;
 	info->fbops = &metronomefb_ops;
 
+	metronomefb_fix.line_length = fw;
+	metronomefb_var.xres = fw;
+	metronomefb_var.yres = fh;
+	metronomefb_var.xres_virtual = fw;
+	metronomefb_var.yres_virtual = fh;
 	info->var = metronomefb_var;
 	info->fix = metronomefb_fix;
 	info->fix.smem_len = videomemorysize;
 	par = info->par;
 	par->info = info;
 	par->board = board;
+	par->dt = epd_dt_index;
 	init_waitqueue_head(&par->waitq);
 
 	/* this table caches per page csum values. */
 	par->csum_table = vmalloc(videomemorysize/PAGE_SIZE);
 	if (!par->csum_table)
-		goto err_csum_table;
+		goto err_vfree;
 
 	/* the metromem buffer is divided as follows:
 	command | CRC | padding
@@ -621,34 +667,26 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	eg: IW=832 IH=622 WS=128
 	*/
 
-	cmd_size = 1 * epd_frame_table[0].fw;
-	wfm_size = ((16*1024 + 2 + epd_frame_table[0].fw - 1)
-			/ epd_frame_table[0].fw) * epd_frame_table[0].fw;
-	img_size = epd_frame_table[0].fh * epd_frame_table[0].fw;
-	padding_size = 4 * epd_frame_table[0].fw;
-	totalsize = cmd_size + wfm_size + img_size + padding_size;
-	par->metromemsize = PAGE_ALIGN(totalsize + 256);
-	DPRINTK("desired memory size = %d\n", par->metromemsize);
-	dev->dev.coherent_dma_mask = 0xffffffffull;
-	par->metromem = dma_alloc_writecombine(&dev->dev, par->metromemsize,
-						&par->metromem_dma, GFP_KERNEL);
+	cmd_size = 1 * fw;
+	wfm_size = ((16*1024 + 2 + fw - 1) / fw) * fw;
+	padding_size = 4 * fw;
+	par->extra_size = cmd_size + wfm_size + padding_size;
+	retval = par->board->setup_fb(par);
+	if (retval) {
+		dev_err(&dev->dev, "Failed to setup fb\n");
+		goto err_csum_table;
+	}
+	/* after this point we should have a framebuffer */
 	if (!par->metromem) {
-		printk(KERN_ERR
-			"metronomefb: unable to allocate dma buffer\n");
-		goto err_vfree;
+		retval = -EINVAL;
+		goto err_csum_table;
 	}
 
 	info->fix.smem_start = par->metromem_dma;
 	par->metromem_cmd = (struct metromem_cmd *) par->metromem;
 	par->metromem_wfm = par->metromem + cmd_size;
 	par->metromem_img = par->metromem + cmd_size + wfm_size;
-	par->metromem_img_csum = (u16 *) (par->metromem_img +
-					(epd_frame_table[0].fw * DPY_H));
-	DPRINTK("img offset=0x%x\n", cmd_size + wfm_size);
-	par->metromem_desc = (struct metromem_desc *) (par->metromem + cmd_size
-					+ wfm_size + img_size + padding_size);
-	par->metromem_desc_dma = par->metromem_dma + cmd_size + wfm_size
-				 + img_size + padding_size;
+	par->metromem_img_csum = (u16 *) (par->metromem_img + (fw * fh));
 
 	/* load the waveform in. assume mode 3, temp 31 for now
 		a) request the waveform file from userspace
@@ -656,7 +694,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	retval = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to get waveform\n");
-		goto err_dma_free;
+		goto err_csum_table;
 	}
 
 	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size, 3, 31,
@@ -664,11 +702,11 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	release_firmware(fw_entry);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed processing waveform\n");
-		goto err_dma_free;
+		goto err_csum_table;
 	}
 
 	if (board->setup_irq(info))
-		goto err_dma_free;
+		goto err_csum_table;
 
 	retval = metronome_init_regs(par);
 	if (retval < 0)
@@ -682,7 +720,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	retval = fb_alloc_cmap(&info->cmap, 8, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_fb_rel;
+		goto err_free_irq;
 	}
 
 	/* set cmap */
@@ -705,17 +743,15 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_fb_rel:
-	framebuffer_release(info);
 err_free_irq:
-	board->free_irq(info);
-err_dma_free:
-	dma_free_writecombine(&dev->dev, par->metromemsize, par->metromem,
-				par->metromem_dma);
+	board->cleanup(par);
 err_csum_table:
 	vfree(par->csum_table);
 err_vfree:
 	vfree(videomemory);
+err_fb_rel:
+	framebuffer_release(info);
+err:
 	module_put(board->owner);
 	return retval;
 }
@@ -726,15 +762,15 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
 
 	if (info) {
 		struct metronomefb_par *par = info->par;
+
+		unregister_framebuffer(info);
 		fb_deferred_io_cleanup(info);
-		dma_free_writecombine(&dev->dev, par->metromemsize,
-					par->metromem, par->metromem_dma);
 		fb_dealloc_cmap(&info->cmap);
+		par->board->cleanup(par);
 		vfree(par->csum_table);
-		unregister_framebuffer(info);
 		vfree((void __force *)info->screen_base);
-		par->board->free_irq(info);
 		module_put(par->board->owner);
+		dev_dbg(&dev->dev, "calling release\n");
 		framebuffer_release(info);
 	}
 	return 0;
@@ -759,6 +795,9 @@ static void __exit metronomefb_exit(void)
 	platform_driver_unregister(&metronomefb_driver);
 }
 
+module_param(user_wfm_size, uint, 0);
+MODULE_PARM_DESC(user_wfm_size, "Set custom waveform size");
+
 module_init(metronomefb_init);
 module_exit(metronomefb_exit);
 
diff --git a/include/video/metronomefb.h b/include/video/metronomefb.h
index dab04b4..79444cd 100644
--- a/include/video/metronomefb.h
+++ b/include/video/metronomefb.h
@@ -12,14 +12,6 @@
 #ifndef _LINUX_METRONOMEFB_H_
 #define _LINUX_METRONOMEFB_H_
 
-/* address and control descriptors used by metronome controller */
-struct metromem_desc {
-	u32 mFDADR0;
-	u32 mFSADR0;
-	u32 mFIDR0;
-	u32 mLDCMD0;
-};
-
 /* command structure used by metronome controller */
 struct metromem_cmd {
 	u16 opcode;
@@ -30,33 +22,33 @@ struct metromem_cmd {
 /* struct used by metronome. board specific stuff comes from *board */
 struct metronomefb_par {
 	unsigned char *metromem;
-	struct metromem_desc *metromem_desc;
 	struct metromem_cmd *metromem_cmd;
 	unsigned char *metromem_wfm;
 	unsigned char *metromem_img;
 	u16 *metromem_img_csum;
 	u16 *csum_table;
-	int metromemsize;
 	dma_addr_t metromem_dma;
-	dma_addr_t metromem_desc_dma;
 	struct fb_info *info;
 	struct metronome_board *board;
 	wait_queue_head_t waitq;
 	u8 frame_count;
+	int extra_size;
+	int dt;
 };
 
 /* board specific routines */
 struct metronome_board {
 	struct module *owner;
-	void (*free_irq)(struct fb_info *);
-	void (*init_gpio_regs)(struct metronomefb_par *);
-	void (*init_lcdc_regs)(struct metronomefb_par *);
-	void (*post_dma_setup)(struct metronomefb_par *);
+	struct module *fbmaster;
 	void (*set_rst)(struct metronomefb_par *, int);
 	void (*set_stdby)(struct metronomefb_par *, int);
+	void (*cleanup)(struct metronomefb_par *);
 	int (*met_wait_event)(struct metronomefb_par *);
 	int (*met_wait_event_intr)(struct metronomefb_par *);
 	int (*setup_irq)(struct fb_info *);
+	int (*setup_fb)(struct metronomefb_par *);
+	int (*setup_io)(struct metronomefb_par *);
+	int (*get_panel_type)(void);
 };
 
 #endif
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

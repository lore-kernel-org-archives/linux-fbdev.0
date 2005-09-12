From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: porting a driver to the new fbdev api - part
 2
Date: Mon, 12 Sep 2005 17:59:12 +0800
Message-ID: <43255170.7080005@gmail.com>
References: <196b7d3105091105032ec2e67f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEl74-0004L9-0D
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Sep 2005 03:00:34 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEl72-0003oW-W7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Sep 2005 03:00:34 -0700
Received: by zproxy.gmail.com with SMTP id 9so1621068nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Sep 2005 03:00:27 -0700 (PDT)
In-Reply-To: <196b7d3105091105032ec2e67f@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, balkohen@gmail.com

Lior Balkohen wrote:

Just a few suggestions.  If you have more specific questions, feel free
to ask.

> ok, apparently no attachments allowed in the list, so i'm sending the
> source in plain.
> 
> /*  Xilleon 220 frame buffer driver
>  *
>  *  Copyright (C) 2002 MontaVista Software Inc.
>  *
>  */
> 
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/errno.h>
> #include <linux/string.h>
> #include <linux/mm.h>
> #include <linux/tty.h>
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
> #include <linux/delay.h>
> #include <linux/interrupt.h>
> #include <asm/uaccess.h>
> #include <linux/fb.h>
> #include <linux/ioctl.h>
> #include <linux/init.h>
> #include <linux/pci.h>
> #include <asm/io.h>
> 

> #include <video/fbcon.h>
> #include <video/fbcon-mfb.h>
> #include <video/fbcon-cfb16.h>
> #include <video/fbcon-cfb24.h>
> #include <video/fbcon-cfb32.h>

video/fbcon*.h are not needed.

> 
> struct x220fb_config {
> 	unsigned int fb_offset;
> 	struct fb_var_screeninfo var;
> };
> 
> #define X220_MAGIC 0xD8
> #define FBIO_X220_CONFIG      _IOW (X220_MAGIC, 1, struct x220fb_config)
> #define FBIO_X220_WAIT_ACLREQ _IOR (X220_MAGIC, 2, struct fb_var_screeninfo)
> #define FBIO_X220_SET_DMS     _IOW (X220_MAGIC, 3, int)
> 
> // FIXME: just a guess and shouldn't be here
> #define X220_MEM_BASE 0
> 
> #define X220_MODULE_NAME "X220FB"
> #define PFX X220_MODULE_NAME
> 
> #define X220_DEBUG
> 
> #ifdef X220_DEBUG
> #define dbg(format, arg...) \
>     printk(KERN_DEBUG "%s: " format "\n" , __func__, ## arg)
> #else
> #define dbg(format, arg...) do {} while (0)
> #endif
> #define err(format, arg...) printk(KERN_ERR PFX ": " format "\n" , ## arg)
> #define info(format, arg...) printk(KERN_INFO PFX ": " format "\n" , ## arg)
> #define warn(format, arg...) printk(KERN_WARNING PFX ": " format "\n" , ## arg)
> #define emerg(format, arg...) printk(KERN_EMERG PFX ": " format "\n" , ## arg)
> 
> #define CMAPSIZE 16
> #define arraysize(x)	(sizeof(x)/sizeof(*(x)))
> 
> /* command line data, set in x220fb_setup() */
> static char __initdata fontname[40] = { 0 };
> static int accel = 0;
> static int nodms = 0;
> 
> static const char *mode_option __initdata = NULL;
> 
> struct x220fb_par {
>         struct fb_var_screeninfo var;
> 
> 	ssize_t fb_size;
> 	int fb_order;
> 
> 	int line_length;  // in bytes
> };
> 
> typedef enum {
> 	IDLE = 0,
> 	WAIT_IN_PROGRESS,
> 	MODE_CHANGE_IN_PROGRESS
> } x220fb_state_t;
> 	
> 
> struct x220fb_info {
>         struct fb_info_gen gen;

struct fb_info_gen is gone
 
> 	struct x220fb_par curpar;
> 	struct x220fb_par reqpar;
>         struct display disp;
> 
>         void *      fb_addr_virt;
>         phys_addr_t fb_addr_phys;
> 
> 	int fake_offset;
> 	x220fb_state_t state;
> 	int dms;
> 	
> 	wait_queue_head_t aclreq_wait;
> 	wait_queue_head_t setpar_wait;
>         struct semaphore ioctl_sem;
>         struct semaphore setpar_sem;
> 	
> 	struct {
> 		unsigned red;
> 		unsigned green;
> 		unsigned blue;
> 		unsigned alpha;
> 	} palette[256];
> };

You can combine all private data into one.

> 
> static struct x220fb_info *fb_x220;
> 
> static char x220fb_name[16] = X220_MODULE_NAME;
> 
> static union {
> #ifdef FBCON_HAS_CFB16
> 	u16 cfb16[CMAPSIZE];
> #endif
> #ifdef FBCON_HAS_CFB24
> 	u32 cfb24[CMAPSIZE];
> #endif
> #ifdef FBCON_HAS_CFB32
> 	u32 cfb32[CMAPSIZE];
> #endif
> } fbcon_cmap;
> 

You don't need the above.

> static const struct fb_var_screeninfo x220_default_var = {
> 	640, 480, 640, 480, 0, 0, 16, 0,
> 	{0}, {0}, {0}, {0},
> 	0, FB_ACTIVATE_NOW, -1, -1, 0,
> 	0, 0, 0, 0, 0, 0, 0,
> 	0, FB_VMODE_NONINTERLACED
> };
> 
> /*
>  * These are just for documentation purposes - linux fb doesn't
>  * distinguish between the different broadcast standards.
>  */
> #define FB_SYNC_PS2   0 // VGA
> #define FB_SYNC_HD    FB_SYNC_BROADCAST
> #define FB_SYNC_NTSC  FB_SYNC_BROADCAST
> #define FB_SYNC_PAL   FB_SYNC_BROADCAST
> #define FB_SYNC_SECAM FB_SYNC_BROADCAST
> 
> static const struct {
> 	u32 xres;
> 	u32 yres;
> 	u32 vmode; // only holds interlaced vs. progressive info
> 	u32 sync;  // only holds PS2 vs. brodcast info
> }  acl_modes[] = {
> 	{  640,  480, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{  720,  480, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{  720,  576, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{  800,  600, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{ 1024,  768, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{ 1280,  720, FB_VMODE_NONINTERLACED, FB_SYNC_PS2   },
> 	{ 1920, 1080, FB_VMODE_INTERLACED   , FB_SYNC_PS2   },
> 	{  720,  480, FB_VMODE_INTERLACED   , FB_SYNC_HD    },
> 	{  720,  480, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
> 	{  960,  540, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
> 	{ 1280,  720, FB_VMODE_NONINTERLACED, FB_SYNC_HD    },
> 	{ 1920, 1080, FB_VMODE_INTERLACED   , FB_SYNC_HD    },
> 	{  720,  480, FB_VMODE_INTERLACED   , FB_SYNC_NTSC  },
> 	{  720,  576, FB_VMODE_INTERLACED   , FB_SYNC_PAL   },
> 	{  720,  576, FB_VMODE_INTERLACED   , FB_SYNC_SECAM }
> };
> 
> 	
> /* Interface used by the world */
> int x220fb_init(void);
> int x220fb_setup(char *options);

fb_setup is gone.

> 
> /* Hardware Specific Routines */
> static int x220fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
> 			u_long arg, int con, struct fb_info *info);
> static void x220fb_detect (void);

fb_detect is gone

> static int x220fb_encode_fix (struct fb_fix_screeninfo *fix, const void *par,
> 				struct fb_info_gen *info);
> static int x220fb_decode_var (const struct fb_var_screeninfo *var, void *par,
> 				struct fb_info_gen *info);
> static int x220fb_encode_var (struct fb_var_screeninfo *var, const void *par,
> 				struct fb_info_gen *info);

The above 3 are gone

> static void x220fb_get_par (void *par, struct fb_info_gen *info);

The above is gone

> static void x220fb_set_par (const void *par, struct fb_info_gen *info);

This is now int fb_set_par(struct fb_info);

> static int x220fb_getcolreg (unsigned regno, unsigned *red, unsigned *green,
> 			       unsigned *blue, unsigned *transp,
> 			       struct fb_info *info);

fb_getcolreg is gone.

> static int x220fb_setcolreg (unsigned regno, unsigned red, unsigned green,
>                             unsigned blue, unsigned transp,
> 			       struct fb_info *info);
> static int x220fb_pan_display (const struct fb_var_screeninfo *var,
> 				 struct fb_info_gen *info);
> static int x220fb_blank (int blank_mode, struct fb_info_gen *info);

You need the above 3.  Change struct fb_info_gen to fb_info.

> static void x220fb_set_disp (const void *par, struct display *disp,
> 			       struct fb_info_gen *info);
> 

fb_set_disp is gone.

> /* function table of the above functions */
> static struct fb_ops x220fb_ops = {
>         owner:          THIS_MODULE,
>         fb_get_fix:     fbgen_get_fix,
>         fb_get_var:     fbgen_get_var,
>         fb_set_var:     fbgen_set_var,

fb_set_var is split into two:

fb_check_var() - check/round up values in struct fb_var_screeninfo to one that
fits hardware

fb_set_par() - initialize hardware based on the contents of struct fb_info.var;

>         fb_get_cmap:    fbgen_get_cmap,

fb_get_cmap() is gone.

>         fb_set_cmap:    fbgen_set_cmap,
fb_get_cmap() is replaced by fb_set_colreg.  However, an optional fb_set_cmap()
is recently added to 2.6 kernels.  You may choose not to provide one.

>         fb_pan_display: fbgen_pan_display,
>         fb_ioctl:       x220fb_ioctl,

You need additional 4 hooks (required)
	fb_imageblit
	fb_copyarea
	fb_fillrect
	fb_cursor

You can use the provided generic functions for the above:

	cfb_imageblit, cfb_copyarea, cfb_fillrect, soft_cursor.

> };
> 
> /* function table of the above functions */
> static struct fbgen_hwswitch x220fb_hwswitch =
> {
>         x220fb_detect,
>         x220fb_encode_fix,
>         x220fb_decode_var,
>         x220fb_encode_var,
>         x220fb_get_par,
>         x220fb_set_par,
>         x220fb_getcolreg,
>         x220fb_setcolreg,
>         x220fb_pan_display,
>         x220fb_blank,
>         x220fb_set_disp
> };

fb_hwswitch is gone.

> 
> 
> static void set_color_bitfields(struct fb_var_screeninfo *var)
> {
> 	switch (var->bits_per_pixel) {
> 	case 16:	/* ARGB1555 */
> 		var->transp.offset = 15;
> 		var->transp.length = 1;
> 		var->red.offset = 10;
> 		var->red.length = 5;
> 		var->green.offset = 5;
> 		var->green.length = 5;
> 		var->blue.offset = 0;
> 		var->blue.length = 5;
> 		break;
> 	case 32:	/* ARGB 8888 */
> 		var->transp.offset = 24;
> 		var->transp.length = 8;
> 		var->red.offset = 16;
> 		var->red.length = 8;
> 		var->green.offset = 8;
> 		var->green.length = 8;
> 		var->blue.offset = 0;
> 		var->blue.length = 8;
> 		break;
> 	}
> 
> 	var->red.msb_right = 0;
> 	var->green.msb_right = 0;
> 	var->blue.msb_right = 0;
> 	var->transp.msb_right = 0;
> }
> 
> 

You can reuse set_color_bitfields as part of fb_check_var().
 
> static void calc_par(struct x220fb_par *par,
> 		     const struct fb_var_screeninfo *var)
> {
> 	memset(par, 0, sizeof(struct x220fb_par));
> 
> 	par->line_length =
> 		var->xres_virtual * ((var->bits_per_pixel + 7) >> 3);
> 	par->line_length = (par->line_length + 127) & ~127;
> 
> 	par->fb_size = par->line_length * var->yres_virtual;
> 
> 	par->fb_order = 0;
> 	while (par->fb_size > (PAGE_SIZE * (1 << par->fb_order)))
> 		par->fb_order++;
> 
> 	par->var = *var;
> 
> 	par->var.width = par->var.height = -1;
> 	/* no virtual display support (no panning/scrolling) */
> 	par->var.vmode &= FB_VMODE_MASK;
> 	par->var.xoffset = par->var.yoffset = 0;
> 	par->var.xres_virtual = par->var.xres;
> 	par->var.yres_virtual = par->var.yres;
> 	/* no accels */
> 	par->var.accel_flags = 0;
> 	par->var.sync &= FB_SYNC_BROADCAST;
> 	
> 	set_color_bitfields(&par->var);
> }
> 

You can reuse calc_par() as part of fb_set_par().

> 
> static void x220fb_detect (void)
> {
> 	dbg("");
> }
> 

fb_detect is not needed.

> 
> static int x220fb_encode_fix(struct fb_fix_screeninfo *fix,
> 				const void* _par,
> 				struct fb_info_gen* _info)
> {
>         struct x220fb_par *par = (struct x220fb_par *) _par;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
> 	struct fb_var_screeninfo* var = &par->var;
> 
> 	down(&info->setpar_sem);
> 
> 	dbg("");
> 
> 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
> 	strcpy(fix->id, x220fb_name);
> 
> 	fix->smem_start = info->fb_addr_phys;
> 	fix->smem_len = par->fb_size;
> 	fix->type = FB_TYPE_PACKED_PIXELS;
> 	fix->type_aux = 0;
>         fix->visual = (var->bits_per_pixel <= 8) ?
> 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
> 	fix->ywrapstep = 0;
> 	fix->xpanstep = 1;
> 	fix->ypanstep = 1;
> 	fix->line_length = par->line_length;
> 
> 	up(&info->setpar_sem);
> 
> 	return 0;
> }
> 

You can reuse encode_fix as part of fb_set_par().

> 
> 
> static int x220fb_decode_var(const struct fb_var_screeninfo *var,
> 			     void *_par,
> 			     struct fb_info_gen *_info)
> {
>         struct x220fb_par *par = (struct x220fb_par *) _par;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
>         struct fb_var_screeninfo *curvar = &info->curpar.var;
> 	int i;
> 	
> 	dbg("");
> 
> 	if (!info->dms) {
> 		if (var->xres != curvar->xres ||
> 		    var->yres != curvar->yres) {
> 			dbg("resolution doesn't match");
> 			return -EINVAL;
> 		}
> 		
> 		if ((var->vmode & FB_VMODE_MASK) !=
> 		    (curvar->vmode & FB_VMODE_MASK)) {
> 			dbg("interlace mode doesn't match");
> 			return -EINVAL;
> 		}
> 		
> 		if ((var->sync & FB_SYNC_BROADCAST) != curvar->sync) {
> 			dbg("sync mode doesn't match");
> 			return -EINVAL;
> 		}
> 
> 		if (var->bits_per_pixel != curvar->bits_per_pixel) {
> 			dbg("color depth doesn't match");
> 			return -EINVAL;
> 		}
> 	}
> 	
> 	for (i=0; i < sizeof(acl_modes)/sizeof(acl_modes[0]); i++) {
> 		if (var->xres == acl_modes[i].xres &&
> 		    var->yres == acl_modes[i].yres &&
> 		    (var->vmode & FB_VMODE_MASK) == acl_modes[i].vmode &&
> 		    (var->sync & FB_SYNC_BROADCAST) == acl_modes[i].sync)
> 			break;
> 	}
> 	if (i >= sizeof(acl_modes)/sizeof(acl_modes[0])) {
> 		dbg("unsupported mode: %s %dx%d%c",
> 		    (var->sync & FB_SYNC_BROADCAST) ? "Broadcast" : "VGA",
> 		    var->xres, var->yres,
> 		    (var->vmode & FB_VMODE_INTERLACED) ? 'i' : 'p');
> 		return -EINVAL;
> 	}
> 
> 	if (var->bits_per_pixel != 32 && var->bits_per_pixel != 16) {
> 		dbg("unsupported color depth: %d bpp", var->bits_per_pixel);
> 		return -EINVAL;
> 	}
> 	
> 	calc_par(par, var);
> 
> 	if (!info->dms) {
> 		/*
> 		 *  check memory limit
> 		 */
> 		if (par->line_length * par->var.yres_virtual > par->fb_size) {
> 			dbg("not enough video memory for res %dx%d-%dbpp!",
> 			    par->var.xres_virtual, par->var.yres_virtual,
> 			    par->var.bits_per_pixel);
> 			return -ENOMEM;
> 		}
> 	}
> 	
> 	return 0;
> }
> 

You may reuse decode_var as part of fb_check_var().

> 
> static int  x220fb_encode_var(struct fb_var_screeninfo *var,
> 				const void *par,
> 				struct fb_info_gen *info)
> {
> 	dbg("");
> 
> 	*var = ((struct x220fb_par *)par)->var;
> 	return 0;
> }
> 
> 
> static void x220fb_set_disp(const void *_par, struct display *disp,
> 			      struct fb_info_gen *_info)
> {
>         struct x220fb_par *par = (struct x220fb_par *) _par;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
> 
> 	down(&info->setpar_sem);
> 
> 	dbg("");
> 
> 	disp->screen_base = (char *)info->fb_addr_virt;
> 
> 	switch (par->var.bits_per_pixel) {
> #ifdef FBCON_HAS_CFB16
> 	case 16:
> 		disp->dispsw = &fbcon_cfb16;
> 		disp->dispsw_data = fbcon_cmap.cfb16;
> 		break;
> #endif
> #ifdef FBCON_HAS_CFB24
> 	case 24:
> 		disp->dispsw = &fbcon_cfb24;
> 		disp->dispsw_data = fbcon_cmap.cfb24;
> 		break;
> #endif
> #ifdef FBCON_HAS_CFB32
> 	case 32:
> 		disp->dispsw = &fbcon_cfb32;
> 		disp->dispsw_data = fbcon_cmap.cfb32;
> 		break;
> #endif
> 	default:
> 		disp->dispsw = &fbcon_dummy;
> 		disp->dispsw_data = NULL;
> 		break;
> 	}
> 
> 	up(&info->setpar_sem);
> }
> 

You don't need fb_set_disp.

> 
> 
> /*
>  *  Blank the display.
>  *
>  * 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off
>  */
> static int x220fb_blank(int mode, struct fb_info_gen *_info)
> {
> 	/* not supported */
> 	dbg("");
> 	return -EINVAL;
> }
> 
> 
> /* get current video mode */
> static void x220fb_get_par (void *_par, struct fb_info_gen *_info)
> {
>         struct x220fb_par *par = (struct x220fb_par *) _par;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
> 
> 	down(&info->setpar_sem);
> 	dbg("");
>         *par = info->curpar;
> 	up(&info->setpar_sem);
> }
> 

You don't need the above.

> 
> static void x220fb_set_par(const void *_par, struct fb_info_gen *_info)
> {
>         struct x220fb_par *par = (struct x220fb_par *) _par;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
> 	struct fb_var_screeninfo *curvar = &info->curpar.var;
> 	struct fb_var_screeninfo *newvar = &par->var;
> 	DECLARE_WAITQUEUE(wait, current);
> 
> 	dbg("%dx%d-%dbpp", newvar->xres, newvar->yres, newvar->bits_per_pixel);
> 
> 	if (!info->dms)
> 		return;
> 	
> 	down(&info->setpar_sem);
> 
> 	if (newvar->xres != curvar->xres ||
> 	    newvar->yres != curvar->yres ||
> 	    newvar->bits_per_pixel != curvar->bits_per_pixel) {
> 		
> 		if (info->state != WAIT_IN_PROGRESS) {
> 			dbg("invalid state (no daemon listening?)");
> 			*par = info->curpar;
> 			up(&info->setpar_sem);
> 			return;
> 		}
> 		
> 		/* wakeup ACL daemon waiting for a request... */
> 		if (waitqueue_active(&info->aclreq_wait)) {
> 			dbg("waking ACL daemon");
> 			wake_up(&info->aclreq_wait);
> 		}
> 		
> 		/* and give the daemon the requested par */
> 		info->reqpar = *par;
> 
> 		dbg("waiting for ACL daemon to program mode");
> 
> 		/* now sleep waiting for ACL to complete the mode */
> 		add_wait_queue(&info->setpar_wait, &wait);
> 		__set_current_state(TASK_INTERRUPTIBLE);
> 		schedule();
> 		remove_wait_queue(&info->setpar_wait, &wait);
> 		set_current_state(TASK_RUNNING);
> 		dbg("ACL daemon done programming mode");
> 		
> 		/*
> 		 * the requested mode may not have succeeded,
> 		 * make sure we return the actual current mode
> 		 * to the caller.
> 		 */
> 		*par = info->curpar;
> 	}
> 
> 	up(&info->setpar_sem);
> }
> 

You need the above.  You probably don't need the semaphore as
almost all fb_functions are serialized by the console semaphore.

> 
> static int x220fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
> 			  u_long arg, int con, struct fb_info *_info)
> {
> 	int fbidx = GET_FB_IDX(inode->i_rdev);
> 	int dms_enb_dis, ret = 0;
>         struct x220fb_info *info = (struct x220fb_info *) _info;
>         struct fb_var_screeninfo *var;
>         struct x220fb_par *curpar = &info->curpar;
> 	struct x220fb_config cfg;
> 	DECLARE_WAITQUEUE(wait, current);
> 	extern int set_all_vcs(int, struct fb_ops *,
> 			       struct fb_var_screeninfo *var,
> 			       struct fb_info *);
> 
> 	/*
> 	 * this mutex prevents reentrancy while sleeping in
> 	 * WAIT_ACLREQ.
> 	 */
> 	down(&info->ioctl_sem);
> 
> 	dbg("");
> 
> 	switch (cmd) {
> 	case FBIO_X220_SET_DMS:
> 		/*
> 		 * changing the DMS flag at weird times can
> 		 * screw-up the mode-change state machine
> 		 * (it should ony be done when info->state = IDLE),
> 		 * but since only the daemon uses these custom
> 		 * ioctls, and we must trust the daemon, we'll
> 		 * allow it always.
> 		 */
> 		if (get_user(dms_enb_dis, (int *)(arg))) {
> 			ret = -EFAULT;
> 			break;
> 		}
> 		info->dms = dms_enb_dis;
> 		info("Dynamic Mode Selection is %s",
> 		     info->dms ? "ON" : "OFF");
> 		break;
> 	case FBIO_X220_CONFIG:
> 		if (info->dms && info->state != MODE_CHANGE_IN_PROGRESS) {
> 			dbg("hey daemon, you're doing something stupid!");
> 			ret = -EINVAL;
> 			break;
> 		}
> 			
> 		if (copy_from_user(&cfg, (void *)arg,
> 				   sizeof(struct x220fb_config))) {
> 			err("fault in copy_from_user");
> 			ret = -EFAULT;
> 			break;
> 		}
> 		
> 		if (info->fake_offset) {
> 			free_pages((unsigned long)info->fb_addr_virt,
> 				   curpar->fb_order);
> 			info->fake_offset = 0;
> 		} else if (info->fb_addr_virt)
> 			iounmap(info->fb_addr_virt);
> 		
> 		var = &cfg.var;
> 		calc_par(curpar, var);
> 
> 		info->fb_addr_phys = X220_MEM_BASE + cfg.fb_offset;
> 		info->fb_addr_virt = ioremap(info->fb_addr_phys,
> 					     curpar->fb_size);
> 		if (info->dms) {
> 			/* wakeup FB app waiting for set_par to complete */
> 			if (waitqueue_active(&info->setpar_wait)) {
> 				dbg("CONFIG: waking FB app");
> 				wake_up(&info->setpar_wait);
> 			}
> 		} else {
> 			if (var->activate & FB_ACTIVATE_ALL)
> 				set_all_vcs(fbidx, _info->fbops,
> 					    var, _info);
> 			else
> 				_info->fbops->fb_set_var(var,
> 							 PROC_CONSOLE(_info),
> 							 _info);
> 		}
> 
> 		// mode change cycle is complete, back to IDLE
> 		info->state = IDLE;
> 		info("CONFIG: FB at 0x%08x, mapped to %p, size %d",
> 		     (u32)info->fb_addr_phys,
> 		     info->fb_addr_virt,
> 		     (int)curpar->fb_size);
> 		info("CONFIG: mode set to %dx%d-%dbpp",
> 		     var->xres, var->yres, var->bits_per_pixel);
> 		break;
> 	case FBIO_X220_WAIT_ACLREQ:
> 		if (info->dms) {
> 			if (info->state != IDLE) {
> 				dbg("hey daemon, you're doing "
> 				    "something stupid!");
> 				ret = -EINVAL;
> 				break;
> 			}
> 			
> 			dbg("WAIT_ACLREQ: waiting...");
> 			info->state = WAIT_IN_PROGRESS;
> 			add_wait_queue(&info->aclreq_wait, &wait);
> 			__set_current_state(TASK_INTERRUPTIBLE);
> 			schedule();
> 			remove_wait_queue(&info->aclreq_wait, &wait);
> 			set_current_state(TASK_RUNNING);
> 			if (signal_pending(current)) {
> 				info->state = IDLE;
> 				ret = -ERESTARTSYS;
> 				break;
> 			}
> 			dbg("WAIT_ACLREQ: got a request");
> 
> 			info->state = MODE_CHANGE_IN_PROGRESS;
> 
> 			/*
> 			 * a framebuffer app has issued a set var, waking
> 			 * us up. Return the requested var (to ACL daemon).
> 			 */
> 			if (copy_to_user((void *) arg,
> 					 &info->reqpar.var,
> 					 sizeof(struct fb_var_screeninfo))) {
> 				err("fault in copy_to_user");
> 				ret = -EFAULT;
> 			}
> 		} else {
> 			ret = -EINVAL;
> 		}
> 
> 		break;
> 	default:
> 		ret = -EINVAL;
> 	}
> 	
>         up(&info->ioctl_sem);
> 	return ret;
> }
> 

fb_ioctl, as always, is optional.

> 
> static int x220fb_getcolreg(unsigned regno, unsigned *red, unsigned *green,
> 			      unsigned *blue, unsigned *transp,
> 			      struct fb_info *_info)
> {
>         struct x220fb_info *info = (struct x220fb_info *) _info;
> 
> 	//dbg("");
> 
>         if (regno > 255)
>                 return 1;
> 
>         *red    = info->palette[regno].red << 10;
>         *green  = info->palette[regno].green << 10;
>         *blue   = info->palette[regno].blue << 10;
>         *transp = info->palette[regno].alpha << 10;
> 
>         return 0;
> }
> 

You don't need the above.

> 
> static int x220fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> 			      unsigned blue, unsigned transp,
> 			      struct fb_info *_info)
> {
> 	struct x220fb_info *info = (struct x220fb_info *) _info;
> 	struct x220fb_par* par = &info->curpar;
> 	
> 	//dbg("");
> 
> 	if (regno > 255)
> 		return -EINVAL;
> 
>         info->palette[regno].red = red >> 10;
>         info->palette[regno].green = green >> 10;
>         info->palette[regno].blue = blue >> 10;
>         info->palette[regno].alpha = transp >> 10;
> 

You need to write these to the hardware palette before exiting.

> 	switch (par->var.bits_per_pixel) {
> #ifdef FBCON_HAS_CFB16
> 	case 16:
> 		if(regno < CMAPSIZE)
> 			fbcon_cmap.cfb16[regno] =
> 				((red & 0xf800) >> 0) |
> 				((green & 0xf800) >> 5) |
> 				((blue & 0xf800) >> 11);
> 		break;
> #endif
> #ifdef FBCON_HAS_CFB24
> 	case 24:
> 		if (regno < CMAPSIZE)
> 			fbcon_cmap.cfb24[regno] =
> 				((red & 0xff00) << 8) |
> 				((green & 0xff00)) |
> 				((blue & 0xff00) >> 8);
> 		break;
> #endif
> #ifdef FBCON_HAS_CFB32
> 	case 32:
> 		if(regno < CMAPSIZE)
> 			// FIXME: what about transp
> 			fbcon_cmap.cfb32[regno] =
> 				((red & 0xff00) >> 8) |
> 				((green & 0xff00)) |
> 				((blue & 0xff00) << 8);
> 		break;
> #endif
> 	default: 
> 		break;
> 	}
> 
> 	return 0;
> }
> 

You need the above, but needs a little modification.  Write the
color values in info->pseudo_palette instead. And no need for the
#ifdef/#endif

> 
> static int x220fb_pan_display (const struct fb_var_screeninfo *var,
> 				 struct fb_info_gen *info)
> {
> 	/* not supported */
> 	dbg("");
> 
> 	return -EINVAL;
> }
> 
> 
> /*
>  *  Initialisation
>  */
> int __init x220fb_init(void)
> {
> 	struct x220fb_info *p = NULL;
> 	struct fb_var_screeninfo *var;
> 	
> 	fb_x220 = p =
> 		(struct x220fb_info *) kmalloc(sizeof(*p), GFP_ATOMIC);

Use:
struct fb_info *info = framebuffer_alloc(sizeof(struct private_par);
private_par = info->par;

> 	if(p==NULL)
> 		return -ENOMEM;
> 	memset(p, 0, sizeof(*p));
> 
> 	init_waitqueue_head(&p->aclreq_wait);
> 	init_waitqueue_head(&p->setpar_wait);
> 	init_MUTEX(&p->setpar_sem);
> 	init_MUTEX(&p->ioctl_sem);
> 
> 	info("Xilleon 220 Framebuffer Driver");
> 
>         /* set up a few more things, register framebuffer driver etc */
>         p->gen.parsize = sizeof (struct x220fb_par);
>         p->gen.fbhw = &x220fb_hwswitch;
> 
> 	strcpy(p->gen.info.modename, "ATI "); 
> 	strcat(p->gen.info.modename, x220fb_name);
> 	p->gen.info.changevar = NULL;
> 	p->gen.info.node = -1;
> 
> 	p->gen.info.fbops = &x220fb_ops;
> 	p->gen.info.disp = &p->disp;
> 	p->gen.info.switch_con = &fbgen_switch;
> 	p->gen.info.updatevar = &fbgen_update_var;
> 	p->gen.info.blank = &fbgen_blank;
> 	p->gen.info.flags = FBINFO_FLAG_DEFAULT;
> 
> 	calc_par(&p->curpar, &x220_default_var);
> 	var = &p->curpar.var;
> 	
> 	/* TODO: explain this crap */
> 	p->fb_addr_virt = (void *)__get_free_pages(GFP_KERNEL,
> 						   p->curpar.fb_order);
> 	p->fb_addr_phys = virt_to_phys(p->fb_addr_virt);
> 	p->fake_offset = 1;
> 	info("Initial framebuffer at 0x%08x, mapped to %p, size %d",
> 	     (u32)p->fb_addr_phys,
> 	     p->fb_addr_virt,
> 	     (int)p->curpar.fb_size);
> 	
>         if (fbgen_do_set_var(&p->curpar.var, 1, &p->gen)) {
>                 err("boot video mode failed");
>                 goto ret_enxio;
>         }
> 
>         p->disp.var = p->curpar.var;
>         fbgen_set_disp(-1, &p->gen);
>         fbgen_install_cmap(0, &p->gen);
> 
> 	if (register_framebuffer(&p->gen.info) < 0) {
> 		goto ret_enxio;
> 	}
> 
> 	if (!nodms)
> 		p->dms = 1;
> 
> 	return 0;
> 
>  ret_enxio:
> 	kfree(p);
> 	iounmap(p->fb_addr_virt);
> 	return -ENXIO;
> }
> 
> 
> #ifdef MODULE
> 
> static void __exit x220fb_exit(void)
> {
> 	unregister_framebuffer(&(fb_x220->gen.info));
> 	iounmap(fb_x220->fb_addr_virt);
> 	kfree(fb_x220);
> }
> 
> module_init(x220fb_init);
> module_exit(x220fb_exit);
> 
> MODULE_PARM(font, "s");
> MODULE_PARM_DESC(font, "Specifies a compiled-in font (default=none)");
> MODULE_PARM(accel, "i");
> MODULE_PARM_DESC(accel, "Enables hardware acceleration (default=0)");
> MODULE_PARM(nodms, "i");
> MODULE_PARM_DESC(nodms, "Disables dynamic mode selection (default=0)");
> 
> #else
> 
> int x220fb_setup(char *options)
> {
> 	char *this_opt;
> 	
> 	if (!options || !*options)
> 		return 1;
> 
> 	for (this_opt = strtok(options, ","); this_opt;
> 	     this_opt = strtok(NULL, ",")) {
> 		if (!strncmp(this_opt, "font:", 5)) {
> 			strcpy(fontname, this_opt+5);
> 		} else if (!strncmp(this_opt, "accel", 5)) {
> 			accel = 1;
> 		} else if (!strncmp(this_opt, "nodms", 3)) {
> 			nodms = 1;
> 		} else {
> 			mode_option = this_opt;
> 		}
> 	}
> 	
> 	return 0;
> }
> 
> #endif /* MODULE */
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

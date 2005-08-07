From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch
 added to -mm tree
Date: Sun, 07 Aug 2005 18:11:16 +0800
Message-ID: <42F5DE44.50800@gmail.com>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1i7j-0001Yc-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:11:19 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1i7f-0006JP-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:11:19 -0700
Received: by wproxy.gmail.com with SMTP id i5so613554wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 03:11:05 -0700 (PDT)
In-Reply-To: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jamey@handhelds.org, anpaza@mail.ru, mm-commits@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
>=20
>      framebuffer driver for MQ11xx graphics chip
>=20
> has been added to the -mm tree.  Its filename is
>=20
>      framebuffer-driver-for-mq11xx-graphics-chip.patch
>=20
> Patches currently in -mm which might be from jamey@handhelds.org are
>=20
> platform-device-driver-for-mq11xx-graphics-chip.patch
> framebuffer-driver-for-mq11xx-graphics-chip.patch
> usb-gadget-driver-for-mq11xx-graphics-chip.patch
>=20
>=20
>=20
> From: Jamey Hicks <jamey@handhelds.org>
>=20
> This patch adds a framebuffer driver for MQ11xx system-on-chip graphics
> chip.  This chip is used in several non-PCI ARM and MIPS platforms such=
 as
> the iPAQ H5550.  This driver depends on the overall platform_device dri=
ver
> for the chip.
>=20
> Signed-off-by: Jamey Hicks <jamey@handhelds.org>
> Signed-off-by: Andrew Zabolotny <anpaza@mail.ru>
> Cc: <linux-fbdev-devel@lists.sourceforge.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>=20
>  drivers/video/Kconfig    |   17 +
>  drivers/video/Makefile   |    1=20
>  drivers/video/mq1100fb.c |  497 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>  3 files changed, 515 insertions(+)
>=20
> diff -puN drivers/video/Kconfig~framebuffer-driver-for-mq11xx-graphics-=
chip drivers/video/Kconfig
> --- devel/drivers/video/Kconfig~framebuffer-driver-for-mq11xx-graphics-=
chip	2005-08-05 00:18:05.000000000 -0700
> +++ devel-akpm/drivers/video/Kconfig	2005-08-05 00:18:05.000000000 -070=
0
> @@ -1438,6 +1438,23 @@ config FB_PXA
> =20
>  	  If unsure, say N.
> =20
> +config FB_MQ1100
> +	tristate "MQ1100/32/68/78/88 framebuffer support"
> +	depends on FB && PLATFORM_MQ11XX
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	select FB_SOFT_CURSOR
> +	help
> +	  This is a framebuffer device for the MediaQ 1100/32/68/78/88
> +	  LCD controllers (http://www.mediaq.com) found in some PDAs
> +	  (these include: iPAQ 5400, Axim X5, iPAQ 221x).
> +
> +	  This driver handles only the LCD controller apect of the MediaQ;
> +	  other functions are handled in respective drivers.
> +	  See <http://www.linux-fbdev.org/> for information
> +	  on framebuffer devices.
> +
>  config FB_W100
>  	tristate "W100 frame buffer support"
>  	depends on FB && PXA_SHARPSL
> diff -puN drivers/video/Makefile~framebuffer-driver-for-mq11xx-graphics=
-chip drivers/video/Makefile
> --- devel/drivers/video/Makefile~framebuffer-driver-for-mq11xx-graphics=
-chip	2005-08-05 00:18:05.000000000 -0700
> +++ devel-akpm/drivers/video/Makefile	2005-08-05 00:18:05.000000000 -07=
00
> @@ -83,6 +83,7 @@ obj-$(CONFIG_FB_GBE)              +=3D gbe
>  obj-$(CONFIG_FB_CIRRUS)		  +=3D cirrusfb.o
>  obj-$(CONFIG_FB_ASILIANT)	  +=3D asiliantfb.o
>  obj-$(CONFIG_FB_PXA)		  +=3D pxafb.o
> +obj-$(CONFIG_FB_MQ1100)		  +=3D mq1100fb.o
>  obj-$(CONFIG_FB_W100)		  +=3D w100fb.o
>  obj-$(CONFIG_FB_AU1100)		  +=3D au1100fb.o fbgen.o
>  obj-$(CONFIG_FB_PMAG_AA)	  +=3D pmag-aa-fb.o
> diff -puN /dev/null drivers/video/mq1100fb.c
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ devel-akpm/drivers/video/mq1100fb.c	2005-08-05 00:18:05.000000000 -=
0700
> @@ -0,0 +1,497 @@
> +/*
> + * linux/drivers/mq1100fb.c
> + *
> + * Copyright =A9 2003 Keith Packard
> + *
> + * This file is subject to the terms and conditions of the GNU General=
 Public
> + * License.  See the file COPYING in the main directory of this archiv=
e for
> + * more details.
> + *
> + *	    MediaQ 1100/32/68/78/88 LCD Controller Frame Buffer Driver
> + *
> + * Please direct your questions and comments on this driver to the fol=
lowing
> + * email address:
> + *
> + *	keithp@keithp.com
> + *
> + * ChangeLog
> + *
> + * 2003-12-06: Andrew Zabolotny <zap@homelink.ru>
> + *      - Modified to use the MediaQ SoC base driver to allow
> + *        sharing of other MediaQ subdevices with other drivers.
> + * 2003-05-18: <keithp@keithp.com>
> + *	- Ported from PCI development board to ARM H5400
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +#include <../drivers/platform/mq11xx.h>
> +
> +#if 0
> +#  define debug(s, args...) printk (KERN_INFO s, ##args)
> +#else
> +#  define debug(s, args...)
> +#endif
> +#define debug_func(s, args...) debug ("%s: " s, __FUNCTION__, ##args)
> +
> +#define MQ_Rotate_0	1
> +#define MQ_Rotate_90	2
> +#define MQ_Rotate_180	4
> +#define MQ_Rotate_270	8
> +
> +#define MQ_Reflect_X	16
> +#define MQ_Reflect_Y	32
> +
> +struct mq1100fb_rgb {
> +	unsigned char red,green,blue,transp;
> +};
> +
> +struct mq1100fb_info {
> +	/* Framebuffer info */
> +	struct fb_info fb;

If you use framebuffer_alloc(), you need not include
struct fb_info in mq1100fb_info.

> +	/* The link to the base SoC driver */
> +	struct mediaq11xx_base *base;
> +	/* The RGB palette */
> +	struct mq1100fb_rgb palette[256];
> +	/* Notifier block */
> +	struct notifier_block notify;
> +	/* Framebuffer offset inside MediaQ RAM */
> +	u32 fb_addr, fb_size;
> +	/* The pseudo-palette */
> +	u32 pseudo_pal[16];
> +	/* Device instance number (0-7) */
> +	u8 inst;
> +	/* Combination of MQ_Rotate_XXX bits */
> +	u8 rotation;
> +	/* 1 if device is active, 0 if poweroff */
> +	unsigned active:1;
> +	/* 1 if initialization is complete, 0 while it is deferred */
> +	unsigned initcomplete:1;
> +	/* 1 if power is enabled to the MEDIAQ_11XX_FB_DEVICE_ID subdevice */
> +	unsigned poweron:1;
> +};
> +#define to_mq1100fb_info(n) container_of(n, struct mq1100fb_info, fb)
> +
> +#define MAX_MQFB_INSTANCES 8
> +
> +static int ppm [MAX_MQFB_INSTANCES];
> +MODULE_PARM(ppm, "i");
> +MODULE_PARM_DESC(ppm, "LCD pixel density in pixels per meter");
> +
> +/* ------------------- chipset specific functions --------------------=
------ */
> +
> +static void mq1100fb_power (struct mq1100fb_info *info, int val)
> +{
> +	debug_func ("val:%d\n", val);
> +
> +	info->active =3D (val =3D=3D 0) ? 1 : 0;
> +
> +	if (info->active !=3D info->poweron) {
> +		info->poweron =3D info->active;
> +		info->base->set_power (info->base, MEDIAQ_11XX_FB_DEVICE_ID,
> +				       info->active);
> +	}
> +}
> +
> +static void mq1100fb_update_screeninfo (struct mq1100fb_info *info, in=
t ppm)
> +{
> +	u32 control =3D info->base->regs->GC.control;
> +	u32 horizontal_width =3D info->base->regs->GC.horizontal_window;
> +	u32 vertical_height =3D info->base->regs->GC.vertical_window;
> +	u32 window_stride =3D info->base->regs->GC.window_stride;
> +	int stride;
> +
> +	debug_func ("ppm:%d\n", ppm);
> +
> +	info->fb.var.grayscale =3D 0;
> +
> +	switch (control & MQ_GC_DEPTH) {
> +	case MQ_GC_DEPTH_PSEUDO_1:
> +		info->fb.var.bits_per_pixel =3D 1;
> +		info->fb.fix.visual =3D FB_VISUAL_MONO01;
> +		break;
> +	case MQ_GC_DEPTH_PSEUDO_2:
> +		info->fb.var.bits_per_pixel =3D 2;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_PSEUDO_4:
> +		info->fb.var.bits_per_pixel =3D 4;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_PSEUDO_8:
> +		info->fb.var.bits_per_pixel =3D 8;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_GRAY_1:
> +		info->fb.var.bits_per_pixel =3D 1;
> +		info->fb.var.grayscale =3D 1;
> +		info->fb.fix.visual =3D FB_VISUAL_MONO01;
> +		break;
> +	case MQ_GC_DEPTH_GRAY_2:
> +		info->fb.var.bits_per_pixel =3D 2;
> +		info->fb.var.grayscale =3D 1;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_GRAY_4:
> +		info->fb.var.bits_per_pixel =3D 4;
> +		info->fb.var.grayscale =3D 1;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_GRAY_8:
> +		info->fb.var.bits_per_pixel =3D 8;
> +		info->fb.var.grayscale =3D 1;
> +		info->fb.fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +	case MQ_GC_DEPTH_TRUE_16:
> +		info->fb.var.bits_per_pixel =3D 16;
> +		info->fb.fix.visual =3D FB_VISUAL_TRUECOLOR;
> +		break;
> +	}
> +
> +	info->fb.var.xres =3D info->fb.var.xres_virtual =3D
> +		((horizontal_width & MQ_GC_HORIZONTAL_WINDOW_WIDTH) >> 16) + 1;
> +	info->fb.var.yres =3D info->fb.var.yres_virtual =3D
> +		((vertical_height & MQ_GC_VERTICAL_WINDOW_HEIGHT) >> 16) + 1;
> +	stride =3D (short)window_stride;
> +	info->fb.fix.line_length =3D (stride < 0) ? -stride : stride;
> +
> +	switch (control & (MQ_GC_X_SCANNING_DIRECTION|MQ_GC_LINE_SCANNING_DIR=
ECTION)) {
> +	case 0:
> +		if (stride >=3D 0)
> +			info->rotation =3D MQ_Rotate_0; /* 000 */
> +		else
> +			info->rotation |=3D MQ_Rotate_0 | MQ_Reflect_Y; /* 010 */
> +		break;
> +	case MQ_GC_X_SCANNING_DIRECTION:
> +		if (stride >=3D 0)
> +			info->rotation =3D MQ_Rotate_0 | MQ_Reflect_X; /* 001 */
> +		else
> +			info->rotation =3D MQ_Rotate_180; /* 011 */
> +		break;
> +	case MQ_GC_LINE_SCANNING_DIRECTION:
> +		if (stride >=3D 0)
> +			info->rotation =3D MQ_Rotate_90 | MQ_Reflect_X; /* 100 */
> +		else
> +			info->rotation =3D MQ_Rotate_90; /* 110 */
> +		break;
> +	case MQ_GC_LINE_SCANNING_DIRECTION|MQ_GC_X_SCANNING_DIRECTION:
> +		if (stride >=3D 0)
> +			info->rotation =3D MQ_Rotate_270; /* 101 */
> +		else
> +			info->rotation =3D MQ_Rotate_270 | MQ_Reflect_X; /* 111 */
> +		break;
> +	}
> +
> +	info->fb.var.width =3D info->fb.var.xres * 1000 / ppm;
> +	info->fb.var.height =3D info->fb.var.yres * 1000 / ppm;
> +}
> +
> +/*
> + *  mq1100fb_check_var():
> + *    Round up in the following order: bits_per_pixel, xres,
> + *    yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
> + *    bitfields, horizontal timing, vertical timing.
> + */
> +static int mq1100fb_check_var(struct fb_var_screeninfo *var,
> +			      struct fb_info *fbinfo)
> +{
> +	debug_func ("\n");
> +
> +	switch (var->bits_per_pixel) {
> +	case 8:
> +		var->red.offset =3D 0;
> +		var->green.offset =3D 0;
> +		var->blue.offset =3D 0;
> +		var->red.length =3D 6;
> +		var->green.length =3D 6;
> +		var->blue.length =3D 6;
> +		break;
> +	case 16:
> +		var->red.offset =3D 11;
> +		var->green.offset =3D 5;
> +		var->blue.offset =3D 0;
> +		var->red.length =3D 5;
> +		var->green.length =3D 6;
> +		var->blue.length =3D 5;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_set_par(struct fb_info *fbinfo)
> +{
> +	struct mq1100fb_info *info =3D to_mq1100fb_info(fbinfo);
> +
> +	debug_func ("\n");
> +
> +	if (!info->active)
> +		/* Enable the LCD controller */
> +		mq1100fb_power (info, 0);
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_setcolreg(unsigned regno, unsigned red, unsigned g=
reen,
> +			      unsigned blue, unsigned transp,
> +			      struct fb_info *fbinfo)
> +{
> +	struct mq1100fb_info *info =3D to_mq1100fb_info(fbinfo);
> +	int bpp, m =3D 0;
> +
> +	debug_func ("color:%d rgba:%d/%d/%d/%d\n",
> +		    regno, red>>8, green>>8, blue>>8, transp>>8);
> +
> +	bpp =3D info->fb.var.bits_per_pixel;
> +	m =3D (bpp <=3D 8) ? (1 << bpp) : 256;
> +	if (regno >=3D m) {
> +		debug ("regno %d out of range (max %d)\n", regno, m);
> +		return -EINVAL;
> +	}
> +
> +	info->palette[regno].red =3D red;
> +	info->palette[regno].green =3D green;
> +	info->palette[regno].blue =3D blue;
> +	info->palette[regno].transp =3D transp;
> +
> +	switch (bpp) {
> +	case 8:
> +		break;
> +	case 16:
> +		/* RGB 565 */
> +		info->pseudo_pal[regno] =3D ((red & 0xF800) |
> +					   ((green & 0xFC00) >> 5) |
> +					   ((blue & 0xF800) >> 11));
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_pan_display(struct fb_var_screeninfo *var,
> +				struct fb_info *fbinfo)
> +{
> +	debug_func ("\n");
> +	/*
> +	 *  Pan (or wrap, depending on the `vmode' field) the display using t=
he
> +	 *  `xoffset' and `yoffset' fields of the `var' structure.
> +	 *  If the values don't fit, return -EINVAL.
> +	 */
> +
> +	/* ... */
> +	return 0;
> +}

If with no pan_display, just comment out the entire function.

> +
> +static void mq1100fb_rotate (struct fb_info *fbinfo, int angle)
> +{
> +	/* For now it is not implemented but mq1100 fully
> +	 * supports display rotation.
> +	 */
> +	debug_func ("\n");
> +}
> +
> +static int mq1100fb_blank(int blank_mode, struct fb_info *fbinfo)
> +{
> +	struct mq1100fb_info *info =3D to_mq1100fb_info(fbinfo);
> +
> +	debug_func ("blank_mode:%d\n", blank_mode);
> +
> +	/*
> +	 *  Blank the screen if blank_mode !=3D 0, else unblank. If blank =3D=
=3D NULL
> +	 *  then the caller blanks by setting the CLUT (Color Look Up Table) =
to all
> +	 *  black. Return 0 if blanking succeeded, !=3D 0 if un-/blanking fai=
led due
> +	 *  to e.g. a video mode which doesn't support it. Implements VESA su=
spend
> +	 *  and powerdown modes on hardware that supports disabling hsync/vsy=
nc:
> +	 *    blank_mode =3D=3D 2: suspend vsync
> +	 *    blank_mode =3D=3D 3: suspend hsync
> +	 *    blank_mode =3D=3D 4: powerdown
> +	 */
> +
> +	mq1100fb_power (info, blank_mode);
> +
> +	return 0;
> +}
> +
> +/* ------------ Interfaces to hardware functions ------------ */
> +
> +static struct fb_ops mq1100fb_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.fb_check_var	=3D mq1100fb_check_var,
> +	.fb_set_par	=3D mq1100fb_set_par,
> +	.fb_setcolreg	=3D mq1100fb_setcolreg,
> +	.fb_fillrect	=3D cfb_fillrect,
> +	.fb_copyarea	=3D cfb_copyarea,
> +	.fb_imageblit	=3D cfb_imageblit,
> +	.fb_blank	=3D mq1100fb_blank,
> +	.fb_pan_display	=3D mq1100fb_pan_display,
> +	.fb_rotate	=3D mq1100fb_rotate,
> +	.fb_cursor	=3D soft_cursor
> +};
> +
> +static struct fb_bitfield def_rgb [3] =3D {
> +	{ 11, 5, 0 },   /* red */
> +	{  5, 6, 0 },   /* green */
> +	{  0, 5, 0 },   /* blue */
> +};
> +
> +static int mq1100fb_finish_init (struct mq1100fb_info *info)
> +{
> +        int err;
> +	int inst_ppm =3D ppm [info->inst];
> +	if (!inst_ppm)
> +		inst_ppm =3D 4210;
> +
> +	debug_func ("\n");
> +
> +	info->fb.var.red   =3D def_rgb [0];
> +	info->fb.var.green =3D def_rgb [1];
> +	info->fb.var.blue  =3D def_rgb [2];
> +	info->fb.var.activate =3D FB_ACTIVATE_NOW;
> +
> +	strcpy (info->fb.fix.id, "mq1100");
> +	info->fb.fix.type =3D FB_TYPE_PACKED_PIXELS;
> +	info->fb.fix.type_aux =3D 0;
> +	info->fb.fix.xpanstep =3D info->fb.fix.ypanstep =3D 0;
> +	info->fb.fix.ywrapstep =3D 0;
> +	info->fb.fix.accel =3D FB_ACCEL_NONE;
> +
> +	info->fb.screen_base =3D info->base->gfxram;
> +	info->fb.pseudo_palette =3D &info->pseudo_pal;
> +	info->fb.fbops =3D &mq1100fb_ops;

Don't forget to allocate info->fb.cmap with fb_alloc_cmap().  And
an equivalent fb_dealloc_cmap() on platform_remove.

You might get some hard-to-pinpoint user app bugs.

> +
> +	mq1100fb_update_screeninfo (info, inst_ppm);
> +
> +	info->fb_size =3D info->fb.fix.line_length * info->fb.var.yres_virtua=
l;
> +	info->fb_addr =3D info->base->alloc (info->base, info->fb_size, 1);
> +
> +	if (info->fb_addr =3D=3D (u32)-1) {
> +		err =3D -ENOMEM;
> +		printk (KERN_ERR "Cannot allocate %u bytes in MediaQ internal RAM fo=
r framebuffer\n",
> +			info->fb_size);
> +error:		kfree (info);
> +		return err;
> +	}
> +
> +	//info->fb.fix.mmio_start =3D info->base->paddr_regs;
> +	//info->fb.fix.mmio_len =3D MQ11xx_REG_SIZE;
> +	info->fb.fix.smem_start =3D info->base->paddr_gfxram + info->fb_addr;
> +	info->fb.fix.smem_len =3D info->fb_size;
> +
> +	/* Program framebuffer start address */
> +	info->base->regs->GC.window_start_address =3D info->fb_addr;
> +
> +	if ((err =3D register_framebuffer(&info->fb)) < 0) {
> +		printk (KERN_ERR "Could not register mq1100 framebuffer\n");
> +		info->base->free (info->base, info->fb_addr, info->fb_size);
> +		goto error;
> +	}
> +
> +	info->initcomplete =3D 1;
> +
> +	/* Clear the screen in the case we don't use fbcon */
> +	memset (info->base->gfxram + info->fb_addr, 0, info->fb_size);

memset_io?

> +
> +	debug ("frame buffer device %dx%d-%dbpp\n",
> +	       info->fb.var.xres, info->fb.var.yres, info->fb.var.bits_per_pi=
xel);
> +        return 0;
> +}
> +
> +static int mq1100fb_probe (struct device *dev, struct mediaq11xx_base =
*base)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct mq1100fb_info *info;
> +
> +	info =3D kmalloc (sizeof (struct mq1100fb_info), GFP_KERNEL);

Is it possible to use framebuffer_alloc() instead?. =20

struct fb_info *info =3D framebuffer_alloc(sizeof(struct mq1100fb_info, d=
ev));

Then instead of below...

struct mq1100fb_info *info =3D to_mq1100fb_info(fbinfo);

do

struct mq1100fb_info *info =3D fbinfo->par;

> +	memset (info, 0, sizeof (struct mq1100fb_info));

No need to memset if framebuffer_alloc() is used. And check
if kmalloc (framebuffer_alloc()) is successful.


> +	info->base =3D base;
> +        info->inst =3D pdev->id;
> +
> +	dev_set_drvdata (dev, info);
> +
> +	/* Turn on the power to the MediaQ chip */
> +	mq1100fb_power (info, 0);
> +	mq1100fb_finish_init (info);
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_platform_probe (struct device *dev)
> +{
> +	debug_func ("\n");
> +	return mq1100fb_probe (dev, (struct mediaq11xx_base *)dev->platform_d=
ata);
> +}
> +
> +static int mq1100fb_platform_remove (struct device *dev)
> +{
> +	struct mq1100fb_info *info =3D
> +		(struct mq1100fb_info *)dev_get_drvdata (dev);
> +
> +	debug_func ("\n");
> +
> +	if (info->active) {
> +		mq1100fb_power (info, 4);
> +		unregister_framebuffer (&info->fb);
> +		info->base->free (info->base, info->fb_addr, info->fb_size);

kfree(info)? (Or framebuffer_dealloc() for that matter?)

> +	}
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_platform_suspend (struct device *dev, u32 state, u=
32 level)
> +{
> +	struct mq1100fb_info *info =3D
> +		(struct mq1100fb_info *)dev_get_drvdata (dev);
> +
> +	debug_func ("\n");
> +
> +	mq1100fb_power (info, 4);
> +
> +	return 0;
> +}
> +
> +static int mq1100fb_platform_resume (struct device *dev, u32 level)
> +{
> +	struct mq1100fb_info *info =3D
> +		(struct mq1100fb_info *)dev_get_drvdata (dev);
> +
> +	debug_func ("\n");
> +
> +	mq1100fb_power (info, 0);
> +
> +	return 0;
> +}
> +
> +/* We need the framebuffer subdevice */
> +struct device_driver mq1100fb_device_driver =3D {
> +	.name     =3D "mq11xx_fb",
> +	.bus	  =3D &platform_bus_type,
> +	.probe    =3D mq1100fb_platform_probe,
> +	.remove   =3D mq1100fb_platform_remove,
> +	.suspend  =3D mq1100fb_platform_suspend,
> +	.resume   =3D mq1100fb_platform_resume
> +};
> +
> +static int __init mq1100fb_init(void)
> +{
> +	return driver_register (&mq1100fb_device_driver);
> +}
> +
> +static void __exit mq1100fb_exit(void)
> +{
> +	driver_unregister (&mq1100fb_device_driver);
> +}
> +
> +module_init(mq1100fb_init);
> +module_exit(mq1100fb_exit);
> +
> +MODULE_AUTHOR("Keith Packard <keithp@keithp.com>");
> +MODULE_DESCRIPTION("Framebuffer driver for MediaQ 1100/32/68/78/88 chi=
ps");
> +MODULE_LICENSE("GPL");
> _
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Pract=
ices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing &=
 QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5=
sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

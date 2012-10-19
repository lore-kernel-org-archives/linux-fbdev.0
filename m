From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Date: Fri, 19 Oct 2012 10:35:16 +0000
Subject: Re: [Qemu-devel] [PATCH] add bochs dispi interface framebuffer driver
Message-Id: <20121019103515.GA30341@dhcp-192-168-178-175.profitbricks.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331201626-23402-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1331201626-23402-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-fbdev@vger.kernel.org, qemu-devel@nongnu.org

Hi,

On Thu, Mar 08, 2012 at 11:13:46AM +0100, Gerd Hoffmann wrote:
> This patchs adds a frame buffer driver for (virtual/emulated) vga cards
> implementing the bochs dispi interface.  Supported hardware are the
> bochs vga card with vbe extension and the qemu standard vga.
> 
> The driver uses a fixed depth of 32bpp.  Otherwise it supports the full
> (but small) feature set of the bochs dispi interface:  Resolution
> switching and display panning.  It is tweaked to maximize fbcon speed,
> so you'll get the comfort of the framebuffer console in kvm guests
> without performance penalty.

I am testing this driver with qemu-kvm-1.2 or qemu-kvm master (commit)
and "-std vga". The driver works fine in general.

When I test a guest that runs X (ubuntu-12.04 desktop amd64), sometimes parts of
the screen and keyboard input is mixed between the X terminal and fbconsole
terminals. This happens only on the initial X11 login (right after boot or
reboot) and only sometimes.

During this time, there is a second keyboard cursor at top of the screen on the
X11 login. When switching to an fbconsole (ctrl+alt+f1), screen output of the X11
login screen gets mixed with fbconsole screen. And vice-versa when I go back to the
X11 terminal(I can send you 2 screendumps if needed, I haven't attached them here
due to size)
If I try to login (pressing enter), the X11-login is redrawn and from then on vt
switching works with no problems (I have to retype login, I am not sure where the
original keyboard input goes to)

Xorg driver used is fbdev (i can send xorg log), not sure if another driver
should be used/implemented for the bochsfb.

According to "xrandr -q" same resolution as bochsfb is used:
Screen 0: minimum 1024 x 768, current 1024 x 768, maximum 1024 x 768
    1024x768    116.0*

"fbset -i" output is as expected:

mode "1024x768-116"
    # D: 100.000 MHz, H: 93.985 kHz, V: 116.318 Hz
    geometry 1024 768 1024 4096 32
    timings 10000 16 16 16 16 8 8
    rgba 8/16,8/8,8/0,8/24
endmode

Frame buffer device information:
    Name        : bochsfb
    Address     : 0xfd000000
    Size        : 16777216
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 4096
    Accelerator : No

Some framebuffer-relevant guest kernel options used:

CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_DEFERRED_IO=y
#
# Frame buffer hardware drivers
#
CONFIG_FB_BOCHS=m
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set

Should FB_VESA be turned to "not set" for this test? (it's not tristate in Kconfig)

Btw (slightly off-topic) are other framebuffer drivers suitable for the
standard qemu vga-pci device? Would vesafb or uvesafb work? 

I haven't been able to load uvesafb in a guest, because the userspace helper
program v86d segfaults (maybe it tries to access vga ioports that are not
implemented in qemu?)

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/Kconfig   |   18 +++
>  drivers/video/Makefile  |    1 +
>  drivers/video/bochsfb.c |  385 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 404 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/bochsfb.c
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6ca0c40..4d21f90 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -286,6 +286,24 @@ config FB_CIRRUS
>  	  Say N unless you have such a graphics board or plan to get one
>  	  before you next recompile the kernel.
>  
> +config FB_BOCHS
> +	tristate "Bochs dispi interface support"
> +	depends on FB && PCI
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	---help---
> +	  This is the frame buffer driver for (virtual/emulated) vga
> +          cards implementing the bochs dispi interface.  Supported
> +          hardware are the bochs vga card with vbe extension and the
> +          qemu standard vga.
> +
> +          The driver handles the PCI variants only.  It uses a fixed
> +          depth of 32bpp, anything else doesn't make sense these days.
> +
> +          Say Y here if you plan to run the kernel in a virtual machine
> +          emulated by bochs or qemu.
> +
>  config FB_PM2
>  	tristate "Permedia2 support"
>  	depends on FB && ((AMIGA && BROKEN) || PCI)
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 1426068..a065ad3 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o
>  obj-$(CONFIG_FB_68328)            += 68328fb.o
>  obj-$(CONFIG_FB_GBE)              += gbefb.o
>  obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
> +obj-$(CONFIG_FB_BOCHS)		  += bochsfb.o
>  obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
>  obj-$(CONFIG_FB_PXA)		  += pxafb.o
>  obj-$(CONFIG_FB_PXA168)		  += pxa168fb.o
> diff --git a/drivers/video/bochsfb.c b/drivers/video/bochsfb.c
> new file mode 100644
> index 0000000..18a94dc
> --- /dev/null
> +++ b/drivers/video/bochsfb.c
> @@ -0,0 +1,385 @@
> +/*
> + *  This file is subject to the terms and conditions of the GNU General Public
> + *  License. See the file COPYING in the main directory of this archive for
> + *  more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/fb.h>
> +#include <linux/pm.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/console.h>
> +#include <asm/io.h>
> +
> +#define VBE_DISPI_IOPORT_INDEX           0x01CE
> +#define VBE_DISPI_IOPORT_DATA            0x01CF
> +
> +#define VBE_DISPI_INDEX_ID               0x0
> +#define VBE_DISPI_INDEX_XRES             0x1
> +#define VBE_DISPI_INDEX_YRES             0x2
> +#define VBE_DISPI_INDEX_BPP              0x3
> +#define VBE_DISPI_INDEX_ENABLE           0x4
> +#define VBE_DISPI_INDEX_BANK             0x5
> +#define VBE_DISPI_INDEX_VIRT_WIDTH       0x6
> +#define VBE_DISPI_INDEX_VIRT_HEIGHT      0x7
> +#define VBE_DISPI_INDEX_X_OFFSET         0x8
> +#define VBE_DISPI_INDEX_Y_OFFSET         0x9
> +#define VBE_DISPI_INDEX_VIDEO_MEMORY_64K 0xa
> +
> +#define VBE_DISPI_ID0                    0xB0C0
> +#define VBE_DISPI_ID1                    0xB0C1
> +#define VBE_DISPI_ID2                    0xB0C2
> +#define VBE_DISPI_ID3                    0xB0C3
> +#define VBE_DISPI_ID4                    0xB0C4
> +#define VBE_DISPI_ID5                    0xB0C5
> +
> +#define VBE_DISPI_DISABLED               0x00
> +#define VBE_DISPI_ENABLED                0x01
> +#define VBE_DISPI_GETCAPS                0x02
> +#define VBE_DISPI_8BIT_DAC               0x20
> +#define VBE_DISPI_LFB_ENABLED            0x40
> +#define VBE_DISPI_NOCLEARMEM             0x80
> +
> +enum bochs_types {
> +	BOCHS_QEMU_STDVGA,
> +	BOCHS_UNKNOWN,
> +};
> +
> +static const char *bochs_names[] = {
> +	[ BOCHS_QEMU_STDVGA ] = "QEMU standard vga",
> +	[ BOCHS_UNKNOWN ]     = "unknown",
> +};
> +
> +static struct fb_fix_screeninfo bochsfb_fix __devinitdata = {
> +	.id          = "bochsfb",
> +	.type        = FB_TYPE_PACKED_PIXELS,
> +	.visual      = FB_VISUAL_TRUECOLOR,
> +	.accel       = FB_ACCEL_NONE,
> +	.xpanstep    = 1,
> +	.ypanstep    = 1,
> +};
> +
> +static struct fb_var_screeninfo bochsfb_var __devinitdata = {
> +	.xres           = 1024,
> +	.yres           = 768,
> +	.bits_per_pixel = 32,
> +#ifdef __BIG_ENDIAN
> +	.transp         = { .length = 8, .offset =  0 },
> +	.red            = { .length = 8, .offset =  8 },
> +	.green          = { .length = 8, .offset = 16 },
> +	.blue           = { .length = 8, .offset = 24 },
> +#else
> +	.transp         = { .length = 8, .offset = 24 },
> +	.red            = { .length = 8, .offset = 16 },
> +	.green          = { .length = 8, .offset =  8 },
> +	.blue           = { .length = 8, .offset =  0 },
> +#endif
> +	.height         = -1,
> +	.width          = -1,
> +	.vmode          = FB_VMODE_NONINTERLACED,
> +	.pixclock       = 10000,
> +	.left_margin    = 16,
> +	.right_margin   = 16,
> +	.upper_margin   = 16,
> +	.lower_margin   = 16,
> +	.hsync_len      = 8,
> +	.vsync_len      = 8,
> +};
> +
> +static char *mode __devinitdata;
> +module_param(mode, charp, 0);
> +MODULE_PARM_DESC(mode, "Initial video mode e.g. '648x480'");
> +
> +static u16 bochs_read(u16 reg)
> +{
> +	outw(reg, VBE_DISPI_IOPORT_INDEX);
> +	return inw(VBE_DISPI_IOPORT_DATA);
> +}
> +
> +static void bochs_write(u16 reg, u16 val)
> +{
> +	outw(reg, VBE_DISPI_IOPORT_INDEX);
> +	outw(val, VBE_DISPI_IOPORT_DATA);
> +}
> +
> +static int bochsfb_check_var(struct fb_var_screeninfo *var,
> +			     struct fb_info *info)
> +{
> +	uint32_t x,y, xv,yv, pixels;
> +
> +	if (var->bits_per_pixel != 32 ||
> +	    var->xres > 65535 ||
> +	    var->xres_virtual > 65535 ||
> +	    (var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
> +		return -EINVAL;
> +
> +	x  = var->xres & ~0x0f;
> +	y  = var->yres & ~0x03;
> +	xv = var->xres_virtual & ~0x0f;
> +	yv = var->yres_virtual & ~0x03;
> +	if (xv < x)
> +		xv = x;
> +	pixels = info->fix.smem_len * 8 / info->var.bits_per_pixel;
> +	yv = pixels / xv;
> +	if (y > yv)
> +		return -EINVAL;
> +
> +	var->xres = x;
> +	var->yres = y;
> +	var->xres_virtual = xv;
> +	var->yres_virtual = yv;
> +	var->xoffset = 0;
> +	var->yoffset = 0;
> +
> +	return 0;
> +}
> +
> +static int bochsfb_set_par(struct fb_info *info)
> +{
> +	dev_dbg(info->dev, "set mode: real: %dx%d, virtual: %dx%d\n",
> +		info->var.xres, info->var.yres,
> +		info->var.xres_virtual, info->var.yres_virtual);
> +
> +	info->fix.line_length = info->var.xres * info->var.bits_per_pixel / 8;
> +
> +	bochs_write(VBE_DISPI_INDEX_BPP,         info->var.bits_per_pixel);
> +	bochs_write(VBE_DISPI_INDEX_XRES,        info->var.xres);
> +	bochs_write(VBE_DISPI_INDEX_YRES,        info->var.yres);
> +	bochs_write(VBE_DISPI_INDEX_BANK,        0);
> +	bochs_write(VBE_DISPI_INDEX_VIRT_WIDTH,  info->var.xres_virtual);
> +	bochs_write(VBE_DISPI_INDEX_VIRT_HEIGHT, info->var.yres_virtual);
> +	bochs_write(VBE_DISPI_INDEX_X_OFFSET,    info->var.xoffset);
> +	bochs_write(VBE_DISPI_INDEX_Y_OFFSET,    info->var.yoffset);
> +
> +	bochs_write(VBE_DISPI_INDEX_ENABLE,
> +		    VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
> +	return 0;
> +}
> +
> +static int bochsfb_setcolreg(unsigned regno, unsigned red, unsigned green,
> +			     unsigned blue, unsigned transp,
> +			     struct fb_info *info)
> +{
> +	if (regno < 16 && info->var.bits_per_pixel = 32) {
> +		red   >>= 8;
> +		green >>= 8;
> +		blue  >>= 8;
> +		((u32 *)(info->pseudo_palette))[regno] > +			(red   << info->var.red.offset)   |
> +			(green << info->var.green.offset) |
> +			(blue  << info->var.blue.offset);
> +	}
> +	return 0;
> +}
> +
> +static int bochsfb_pan_display(struct fb_var_screeninfo *var,
> +			       struct fb_info *info)
> +{
> +	bochs_write(VBE_DISPI_INDEX_X_OFFSET, var->xoffset);
> +	bochs_write(VBE_DISPI_INDEX_Y_OFFSET, var->yoffset);
> +	return 0;
> +}
> +
> +static struct fb_ops bochsfb_ops = {
> +	.owner	        = THIS_MODULE,
> +	.fb_check_var   = bochsfb_check_var,
> +	.fb_set_par     = bochsfb_set_par,
> +	.fb_setcolreg   = bochsfb_setcolreg,
> +	.fb_pan_display = bochsfb_pan_display,
> +	.fb_fillrect    = cfb_fillrect,
> +	.fb_copyarea    = cfb_copyarea,
> +	.fb_imageblit   = cfb_imageblit,
> +};
> +
> +static int __devinit
> +bochsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
> +{
> +	struct fb_info *p;
> +	unsigned long addr, size, mem;
> +	u16 id;
> +	int rc = -ENODEV;
> +
> +	id = bochs_read(VBE_DISPI_INDEX_ID);;
> +	mem = bochs_read(VBE_DISPI_INDEX_VIDEO_MEMORY_64K) * 64 * 1024;
> +	dev_info(&dp->dev,"Found bochs VGA, ID 0x%x, mem %ldk, type \"%s\".\n",
> +		 id, mem / 1024, bochs_names[ent->driver_data]);
> +	if ((id & 0xfff0) != VBE_DISPI_ID0) {
> +		dev_err(&dp->dev, "ID mismatch\n");
> +		goto err_out;
> +	}
> +
> +	if (pci_enable_device(dp) < 0) {
> +		dev_err(&dp->dev, "Cannot enable PCI device\n");
> +		goto err_out;
> +	}
> +
> +	if ((dp->resource[0].flags & IORESOURCE_MEM) = 0)
> +		goto err_disable;
> +	addr = pci_resource_start(dp, 0);
> +	size = pci_resource_len(dp, 0);
> +	if (addr = 0)
> +		goto err_disable;
> +	if (size != mem) {
> +		dev_err(&dp->dev, "Size mismatch: pci=%ld, bochs=%ld\n", size, mem);
> +		size = min(size, mem);
> +	}
> +
> +	p = framebuffer_alloc(0, &dp->dev);
> +	if (p = NULL) {
> +		dev_err(&dp->dev, "Cannot allocate framebuffer structure\n");
> +		rc = -ENOMEM;
> +		goto err_disable;
> +	}
> +
> +	if (pci_request_region(dp, 0, "bochsfb") != 0) {
> +		dev_err(&dp->dev, "Cannot request framebuffer\n");
> +		rc = -EBUSY;
> +		goto err_release_fb;
> +	}
> +
> +	if (!request_region(VBE_DISPI_IOPORT_INDEX, 2, "bochsfb")) {
> +		dev_err(&dp->dev, "Cannot request ioports\n");
> +		rc = -EBUSY;
> +		goto err_release_pci;
> +	}
> +
> +	p->screen_base = ioremap(addr, size);
> +	if (p->screen_base = NULL) {
> +		dev_err(&dp->dev, "Cannot map framebuffer\n");
> +		rc = -ENOMEM;
> +		goto err_release_ports;
> +	}
> +	memset(p->screen_base, 0, size);
> +
> +	pci_set_drvdata(dp, p);
> +	p->fbops = &bochsfb_ops;
> +	p->flags = FBINFO_FLAG_DEFAULT
> +		| FBINFO_READS_FAST
> +		| FBINFO_HWACCEL_XPAN
> +		| FBINFO_HWACCEL_YPAN;
> +	p->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
> +	p->fix = bochsfb_fix;
> +	p->fix.smem_start = addr;
> +	p->fix.smem_len = size;
> +
> +	p->var = bochsfb_var;
> +	bochsfb_check_var(&p->var, p);
> +	if (mode) {
> +		fb_find_mode(&p->var, p, mode, NULL, 0, NULL, 32);
> +	}
> +
> +	if (register_framebuffer(p) < 0) {
> +		dev_err(&dp->dev,"Framebuffer failed to register\n");
> +		goto err_unmap;
> +	}
> +
> +	dev_info(&dp->dev,"fb%d: bochs VGA frame buffer initialized.\n",
> +		 p->node);
> +
> +	return 0;
> +
> + err_unmap:
> +	iounmap(p->screen_base);
> + err_release_ports:
> +	release_region(VBE_DISPI_IOPORT_INDEX, 2);
> + err_release_pci:
> +	pci_release_region(dp, 0);
> + err_release_fb:
> +	framebuffer_release(p);
> + err_disable:
> + err_out:
> +	return rc;
> +}
> +
> +static void __devexit bochsfb_remove(struct pci_dev *dp)
> +{
> +	struct fb_info *p = pci_get_drvdata(dp);
> +
> +	if (p->screen_base = NULL)
> +		return;
> +	unregister_framebuffer(p);
> +	iounmap(p->screen_base);
> +	p->screen_base = NULL;
> +	release_region(VBE_DISPI_IOPORT_INDEX, 2);
> +	pci_release_region(dp, 0);
> +	kfree(p->pseudo_palette);
> +	framebuffer_release(p);
> +}
> +
> +static struct pci_device_id bochsfb_pci_tbl[] = {
> +	{
> +		.vendor      = 0x1234,
> +		.device      = 0x1111,
> +		.subvendor   = 0x1af4,
> +		.subdevice   = 0x1100,
> +		.driver_data = BOCHS_QEMU_STDVGA,
> +	},
> +	{
> +		.vendor      = 0x1234,
> +		.device      = 0x1111,
> +		.subvendor   = PCI_ANY_ID,
> +		.subdevice   = PCI_ANY_ID,
> +		.driver_data = BOCHS_UNKNOWN,
> +	},
> +	{ /* end of list */ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, bochsfb_pci_tbl);
> +
> +static struct pci_driver bochsfb_driver = {
> +	.name =		"bochsfb",
> +	.id_table =	bochsfb_pci_tbl,
> +	.probe =	bochsfb_pci_init,
> +	.remove =	__devexit_p(bochsfb_remove),
> +};
> +
> +#ifndef MODULE
> +static int __init bochsfb_setup(char *options)
> +{
> +	char *this_opt;
> +
> +	if (!options || !*options)
> +		return 0;
> +
> +	while ((this_opt = strsep(&options, ",")) != NULL) {
> +		if (!*this_opt)
> +			continue;
> +		if (!strncmp(this_opt, "mode:", 5))
> +			mode = this_opt + 5;
> +		else
> +			mode = this_opt;
> +	}
> +	return 0;
> +}
> +#endif
> +
> +int __init bochs_init(void)
> +{
> +#ifndef MODULE
> +	char *option = NULL;
> +
> +	if (fb_get_options("bochsfb", &option))
> +		return -ENODEV;
> +	bochsfb_setup(option);
> +#endif
> +	return pci_register_driver(&bochsfb_driver);
> +}
> +
> +module_init(bochs_init);
> +
> +static void __exit bochsfb_exit(void)
> +{
> +	pci_unregister_driver(&bochsfb_driver);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_DESCRIPTION("bochs dispi interface framebuffer driver");
> -- 
> 1.7.1
> 
> 

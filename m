From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.13-rc4] framebuffer: new driver
 for cyberblade/i1 core
Date: Sun, 31 Jul 2005 19:51:41 +0800
Message-ID: <42ECBB4D.6020306@gmail.com>
References: <42ECA05F.40401@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzCNl-0005tz-P2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 04:53:29 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DzCNl-0006Vk-5T
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 04:53:30 -0700
Received: by wproxy.gmail.com with SMTP id i3so870936wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 31 Jul 2005 04:53:23 -0700 (PDT)
In-Reply-To: <42ECA05F.40401@t-online.de>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Currently tridenfb claims to support the cyberblade/i1 graphics core.
> This is of very limited truth. There is a great number of bugs, even
> vesafb is faster and provides more working modes and much better
> quality of the video signal.
> 
> Tridentfb seems to be unmaintained,and documentation for most of the
> supported chips is not available. Fixing cyberblade/i1 support inside
> of tridentfb was not an option, it would have caused numerous
> if(CYBERBLADEi1) else ... cases and would have rendered the code
> to be almost unmaintainable.
> 
> This code does support the graphics core of a single north bridge
> and has been tested and developed on a system equipped with that
> chip. It cannot break anything but the broken cyberblade/i1 support
> of tridentfb, and even if that would be the case, there is still
> vesafb as a working alternative. On the other hand it provides
> significant improvements. Because of this I believe that there is
> no reason to keep it out of 2.6.13 just because it is presented a
> bit late in the development cycle.
> 
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
> 
> diff -urN linux-2.6.13-rc4/Documentation/fb/cyblafb.txt 
> linux-2.6.13-rc4-tfix/Documentation/fb/cyblafb.txt
> --- linux-2.6.13-rc4/Documentation/fb/cyblafb.txt    1970-01-01 
> 01:00:00.000000000 +0100
> +++ linux-2.6.13-rc4-tfix/Documentation/fb/cyblafb.txt    2005-07-31 
> 09:38:44.000000000 +0200
> @@ -0,0 +1,354 @@
> +CyBlaFB is a framebuffer driver for the Cyberblade/i1 graphics core 
> integrated
> +into the VIA Apollo PLE133 (aka vt8601) south bridge. It is developed and
> +tested using a VIA EPIA 5000 board.

Nice docs :-)

<snip>

> +
> config FB_TRIDENT
>     tristate "Trident support"
>     depends on FB && PCI
> @@ -1193,8 +1219,12 @@
>       but also on some motherboards. For more information, read
>       <file:Documentation/fb/tridentfb.txt>
> 
> +      Attention: Cyberblade/i1 support has been removed, choose the 
> +      cyblafb driver instead.
> +

Is it really necessary to remove it from tridentfb so soon? Maybe you
can add a warning first, then remove it after a few development cycles.

<snip>

> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <asm/types.h>
> +#include <video/cyblafb.h>
> +
> +#define VERSION "0.50"
> +
> +struct cyblafb_par {
> +    void __iomem * io_virt; //iospace virtual memory address
> +};
> +
> +static struct cyblafb_par default_par;
> +static struct fb_info fb_info;

Do this in the beginning of cybla_pci_probe()

struct fb_info *info;

info = framebuffer_alloc(sizeof(struct cyblafb_par), dev->dev);
if (info)
	exit;

Then do a corresponding framebuffer_dealloc() on exit/unload.

This way, you need not statically allocate memory for the par
and info, which increases the kernel image size unnecessarily.

And so you don't lose your info structure, do this:

pci_set_drvdata(dev, info) at the end of cybla_pci_probe()

To get your info back (ie. in  cybla_pci_remove()), do this:

struct fb_info *info = pci_get_drvdata(dev);

> +static struct fb_var_screeninfo default_var;

You also don't need to allocate this.  default_var is used only
during init.  Why not use info->var? Or if you can't, mark it
__devinitdata.

> +static struct fb_fix_screeninfo cyblafb_fix = {
> +    .id = "CyBla",
> +    .type = FB_TYPE_PACKED_PIXELS,
> +    .ypanstep = 1,
> +    .visual = FB_VISUAL_PSEUDOCOLOR,
> +    .accel = FB_ACCEL_NONE,
> +};

Same with the above.  You can mark it __devinitdata and
don't reference it again after saving it in info->fix.

> +
> +static u32 pseudo_pal[16];
> +
> +static int displaytype;
> +
> +static char *mode = NULL;
> +static int bpp = 8;
> +static int ref = 75;
> +static int fp;
> +static int crt;
> +static int nativex;
> +static int center;
> +static int stretch;
> +static int pciwb = 1;
> +static int pcirb = 1;
> +static int pciwr = 1;
> +static int pcirr = 1;
> +static int memsize;
> +static int verbosity;
> +static int vesafb;

Any of the above that can be marked __devinitdata?  For those
that you need after initialization, place them in info->par.

> +
> +module_param(mode, charp, 0);
> +module_param(bpp, int, 0);
> +module_param(ref, int, 0);
> +module_param(fp, int, 0);
> +module_param(crt, int, 0);
> +module_param(nativex, int, 0);
> +module_param(center, int, 0);
> +module_param(stretch, int, 0);
> +module_param(pciwb, int, 0);
> +module_param(pcirb, int, 0);
> +module_param(pciwr, int, 0);
> +module_param(pcirr, int, 0);
> +module_param(memsize, int, 0);
> +module_param(verbosity, int, 0);
> +module_param(vesafb, int, 0);
> +
> +
> +//=========================================
> +//
> +// Port access macros for memory mapped io
> +//
> +//=========================================
> +
> +#define out8(r,v)    writeb(v,((struct cyblafb_par 
> *)fb_info.par)->io_virt+r)
> +#define out32(r,v)   writel(v,((struct cyblafb_par 
> *)fb_info.par)->io_virt+r)
> +#define in8(r)         readb(((struct cyblafb_par 
> *)fb_info.par)->io_virt+r)
> +#define in32(r)      readl(((struct cyblafb_par *)fb_info.par)->io_virt+r)

If you use framebuffer_alloc(), you can change the above macros to
(struct cyblafb_par *)info->par->io_virt+r, for example.

<snip>

> +//=====================================================================
> +//
> +// Although this is a .fb_sync function that could be enabled in
> +// cyblafb_ops, we do not include it there. We sync immediately before
> +// new GE operations to improve performance.

I wonder. I thought that avoiding to sync as much as possible improves
performance...

<snip>

> +static int cyblafb_check_var(struct fb_var_screeninfo *var,
> +                 struct fb_info *info)
> +{
> +    int bpp = var->bits_per_pixel;
> +    int s,t,maxvyres;
> +
> +    //
> +    // we try to support 8, 16, 24 and 32 bpp modes,
> +    // default to 8
> +    //
> +    // there is a 24 bpp mode, but for now we change requests to 32 bpp
> +    // (This is what tridentfb does ... will be changed in the future)
> +    //
> +    //
> +    if ( bpp % 8 != 0 || bpp < 8 || bpp >32)
> +        bpp = 8;
> +    if (bpp == 24 )
> +        bpp = var->bits_per_pixel = 32;
> +
> +
> +    //
> +    // interlaced modes are broken, fail if one is requested
> +    //
> +    if (var->vmode & FB_VMODE_INTERLACED)
> +        return -EINVAL;

You are too strict :-)  You can always clear FB_VMODE_INTERLACED and
return success.  This is acceptable behavior.

> +
> +    //
> +    // fail if requested resolution is higher than physical
> +    // flatpanel resolution
> +    //
> +    if (flatpanel && nativex && var->xres > nativex)
> +        return -EINVAL;
> +

This is acceptable behavior, but you can always return
with var->xres = nativex.

> +    //
> +    // xres != xres_virtual is broken, fail if such an
> +    // unusual mode is requested
> +    //
> +    if (var->xres != var->xres_virtual)
> +        return -EINVAL;

Same here, var->xres = var->xres_virtual.

> +
> +    //
> +    // we do not allow vclk to exceed 230 MHz
> +    //
> +    if ((bpp==32 ? 200000000 : 100000000) / var->pixclock > 23000)
> +        return -EINVAL;
> +
> +    //
> +    // calc max yres_virtual that would fit in memory
> +    // and max yres_virtual that could be used for scrolling
> +    // and use minimum of the results as maxvyres
> +    //
> +    // adjust vyres_virtual to maxvyres if necessary
> +    // fail if requested yres is bigger than maxvyres
> +    //
> +    s = (0x1fffff / (var->xres * bpp/8)) + var->yres;
> +    t = info->fix.smem_len / (var->xres * bpp/8);
> +    maxvyres = t < s ? t : s;
> +    if (maxvyres < var->yres_virtual)
> +        var->yres_virtual=maxvyres;
> +    if (maxvyres < var->yres)
> +        return -EINVAL;
> +
> +    switch (bpp) {
> +        case 8:
> +            var->red.offset = 0;
> +            var->green.offset = 0;
> +            var->blue.offset = 0;
> +            var->red.length = 6;
> +            var->green.length = 6;
> +            var->blue.length = 6;
> +            break;
> +        case 16:
> +            var->red.offset = 11;
> +            var->green.offset = 5;
> +            var->blue.offset = 0;
> +            var->red.length = 5;
> +            var->green.length = 6;
> +            var->blue.length = 5;
> +            break;
> +        case 32:
> +            var->red.offset = 16;
> +            var->green.offset = 8;
> +            var->blue.offset = 0;
> +            var->red.length = 8;
> +            var->green.length = 8;
> +            var->blue.length = 8;
> +            break;
> +        default:
> +            return -EINVAL;
	
Again, you can always round off bits_per_pixel to
ones that the driver can support.

<snip>

> +//========================================================================== 
> 
> +//
> +// getstartupmode() decides about the inital video mode
> +//
> +// There is no reason to use modedb, a lot of video modes there would
> +// need altered timings to display correctly. So I decided that it is much
> +// better to provide a limited optimized set of modes plus the option of
> +// using the mode in effect at startup time (might be selected using the
> +// vga=??? paramter). After that the user might use fbset to select any
> +// mode he likes, check_var will not try to alter geometry parameters as
> +// it would be necessary otherwise.
> +//
> +//==========================================================================

You can get the correct set of video modes from the EDID. If you can't add DDC/I2C
support, I will submit a patch that will grab the EDID from the BIOS.  Should
be usable by all x86 drivers. This way you don't need to massage the timings.
 
<snip>

> +static int __devinit cybla_pci_probe(struct pci_dev * dev,
> +                     const struct pci_device_id * id)
> +{
> +
> +    fb_info.par = &default_par;

As mentioned in the beginning, you don't need to do the above.

> +
> +    if (pci_enable_device(dev)) {
> +        output("could not enable device!\n");
> +        goto errout_enable;
> +    }
> +
> +    // might already be requested by vga console or vesafb,
> +    // so we do care about success
> +    request_region(0x3c0, 32, "cyblafb");
> +
> +    //
> +    // Graphics Engine Registers
> +    //
> +    request_region(GEBase, 0x100, "cyblafb");
> +
> +    regdump();
> +
> +    enable_mmio();
> +
> +    /* setup MMIO region */
> +    cyblafb_fix.mmio_start = pci_resource_start(dev,1);
> +    cyblafb_fix.mmio_len = 0x20000;
> +
> +    if (!request_mem_region(cyblafb_fix.mmio_start,
> +                cyblafb_fix.mmio_len, "cyblafb")) {
> +        output("request_mem_region failed for mmio region!\n");
> +        goto errout_mmio_reqmem;
> +    }
> +
> +    default_par.io_virt = ioremap_nocache(cyblafb_fix.mmio_start,
> +                  cyblafb_fix.mmio_len);
> +
> +    if (!default_par.io_virt) {
> +        output("ioremap failed for mmio region\n");
> +        goto errout_mmio_remap;
> +    }
> +
> +    // setup framebuffer memory ... might already be requested
> +    // by vesafb. Not to fail in case of an unsuccessful request
> +    // is useful for the development cycle
> +    cyblafb_fix.smem_start = pci_resource_start(dev,0);
> +    cyblafb_fix.smem_len = get_memsize();
> +
> +    if (!request_mem_region(cyblafb_fix.smem_start,
> +                cyblafb_fix.smem_len, "cyblafb")) {
> +        output("request_mem_region failed for smem region!\n");
> +        if (!vesafb)

Instead of testing for the vesafb boot option, you can test for 
screen_info.orig_video_isVGA == VIDEO_TYPE_VLFB.  This is set when
screen is in VESA VGA graphics mode. See include/linux/tty.h.

> +            goto errout_smem_req;
> +    }
> +
> +    fb_info.screen_base = ioremap_nocache(cyblafb_fix.smem_start,
> +                    cyblafb_fix.smem_len);
> +
> +    if (!fb_info.screen_base) {
> +        output("ioremap failed for smem region\n");
> +        goto errout_smem_remap;
> +    }
> +
> +    displaytype = get_displaytype();
> +
> +    if(flatpanel)
> +        nativex = get_nativex();
> +
> +    fb_info.fix = cyblafb_fix;
> +    fb_info.fbops = &cyblafb_ops;
> +
> +    //
> +    // FBINFO_HWACCEL_YWRAP    .... does not work (could be made to work)
> +    // FBINFO_PARTIAL_PAN_OK   .... is not ok
> +    // FBINFO_READS_FAST       .... is necessary for optimal scrolling
> +    //
> +    fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN
> +              | FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT
> +              | FBINFO_HWACCEL_IMAGEBLIT | FBINFO_READS_FAST;
> +
> +    fb_info.pseudo_palette = pseudo_pal;
> +
> +    if(getstartupmode())
> +        goto errout_findmode;
> +
> +    fb_alloc_cmap(&fb_info.cmap,256,0);
> +
> +    fb_info.var = default_var;
> +    fb_info.device = &dev->dev;
> +
> +    if (register_framebuffer(&fb_info)) {
> +        output("Could not register CyBla framebuffer\n");
> +        goto errout_register;
> +    }
> +
> +    return 0;
> +
> +    //
> +    // error paths
> +    //
> +
> +    errout_register:
> +    errout_findmode:
> +        iounmap(fb_info.screen_base);
> +    errout_smem_remap:
> +        release_mem_region(cyblafb_fix.smem_start,
> +                             cyblafb_fix.smem_len);
> +    errout_smem_req:
> +        iounmap(default_par.io_virt);
> +    errout_mmio_remap:
> +        release_mem_region(cyblafb_fix.mmio_start,
> +                             cyblafb_fix.mmio_len);
> +    errout_mmio_reqmem:
> +//        release_region(0x3c0, 32);
> +    errout_enable:
> +

Don't forget fb_dealloc_cmap() in the exit path, especially if
you like to load/unload the driver.  You can insert
framebuffer_dealloc() here also if you use framebuffer_alloc().

> +    output("CyblaFB version %s aborting init.\n", VERSION);
> +    return -ENODEV;
> +}
> +
> +static void __devexit cybla_pci_remove(struct pci_dev * dev)
> +{
> +    struct cyblafb_par *par = (struct cyblafb_par*)fb_info.par;

or
	struct fb_info *info = pci_get_drvdata(dev);
	struct cyblafb_par *par = info->par;


And to please Linus, try to compile the driver with sparse checking
on.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

From: jkimble@one.net
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04on	Coldfire running 2.6.25)
Date: Tue, 11 Nov 2008 09:50:47 -0500 (EST)
Message-ID: <43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20081111095047_31099"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1KzuaB-0005ZC-KG
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 14:51:07 +0000
Received: from smtp-out2.atlngahp.sys.nuvox.net ([70.43.63.19]
	helo=smtp02.atlngahp.sys.nuvox.net)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kzua2-0000GJ-6E
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 14:51:07 +0000
In-Reply-To: <49195726.2060103@cetrtapot.si>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: linux-fbdev-devel@lists.sourceforge.net

------=_20081111095047_31099
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> James Kimble wrote:
>> I've been working on porting the s1d13xxxfb driver from the latest
>> kernel from Freescale for Coldfire to work with the S1D13A04 chip. I was
>> able to get things working to the point that I do get a little TUX logo
>> up on the screen at boot up. Seemed like a good start but none of my
>> user space applications will work. I can open the /dev/fb0 device and
>> the data in the info structure is correct but if I try to write to any
>> register or area in the frame buffer (or write to the device at all) I
>> get a seg fault.
>>
>> I had an earlier driver working with the 2.6.10 kernel with the same
>> hardware. The same application space program should work ( I would
>> think...) but I get the seg fault on the first write to fb0. I tried a
>> different memory location (ox4400 0000 to 0x7400 0000) for the CS
>> associated with the video  chip, no  difference. Permissions for
>> /dev/fb0 are "rw". No other process using fb0. This is really weird.
>>
>> Any help or suggestions MUCH appreciated.
>>
>
> You are probably not reserving and/or translating physical memory space
> to virtual if you get a segfault on every access. Try cat /proc/iomem. Is
> your device listed?
>
> OTOH, a lot of arch specific code has probably changed since 2.6.10 -
> 2.6.25 that might not even be directly related to fb. Is your arch port
> up to date?
>
> Also you might post your fb driver and someone might spot the fault
> faster..
>

/proc/iomem shows:

74000000-74009000 : s1d13a04fb.0
74000000-74009000 : s1d13xxxfb regs
74040000-74068000 : s1d13a04fb.0
74040000-74068000 : s1d13xxxfb mem
f000070c-f000070c : spi-int-mask
f0000740-f000075f : spi-int-level
f0000a50-f0000a50 : spi-par
f0008a00-f0008ab8 : spi-module
f0008f00-f0008f20 : MCF548X-i2c
f000a000-f000a7ff : mcf548x-flexcan.0
f000a000-f000a7ff : mcf548x-flexcan
f000a800-f000afff : mcf548x-flexcan.1
f000a800-f000afff : mcf548x-flexcan
f0020000-f0033000 : fsl-sec1
fc000000-ffffffff : physmap-flash.0

Which looks fine to me. The s1d13 lines match the mapping I set up. I've
attached the driver. It is the driver for this family of chips that was
included in the Freescale release of the 2.6.25 kernel for Coldfire. It
includes my changes.





------=_20081111095047_31099
Content-Type: text/x-csrc; name="s1d13xxxfb.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="s1d13xxxfb.c"

///////////////////////////////////////////////////////////////////////////////
//
//  drivers/video/s1d13xxxfb.c
// 
//  (c) 2004 Simtec Electronics
//  (c) 2005 Thibaut VARENE <varenet@parisc-linux.org>
// 
//  Driver for Epson S1D13xxx series framebuffer chips
// 
//  Adapted from:
//   linux/drivers/video/skeletonfb.c
//   linux/drivers/video/epson1355fb.c
//   linux/drivers/video/epson/s1d13xxxfb.c (2.4 driver by Epson)
// 
//  Note: Currently only tested on S1D13806 with 16bit CRT. As such, this 
//        driver might still contain some hardcoded bits relating to
//        S1D13806.
//
//  Making it work on other S1D13XXX chips should merely be a matter of adding
//  a few switch()s, some missing glue here and there maybe, and split header
//  files.
// 
//  TODO: - handle dual screen display (CRT and LCD at the same time).
// 	  - check_var(), mode change, etc.
// 	  - PM untested.
// 	  - Accelerated interfaces.
// 	  - Probably not SMP safe :)
// 
//  This file is subject to the terms and conditions of the GNU General Public
//  License. See the file COPYING in the main directory of this archive for
//  more details.
//
///////////////////////////////////////////////////////////////////////////////

#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/delay.h>

#include <linux/types.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/fb.h>

#include <asm/io.h>

#include <video/s1d13xxxfb.h>
#include <video/palette.h>


#define S1D_DISPLAY_PCLK 0x5F5E10

typedef unsigned long S1D_VALUE;


#define PFX "s1d13xxxfb: "

#if 1
#define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
#else
#define dbg(fmt, args...) do { } while (0)
#endif


//
//  Here we define the default struct fb_fix_screeninfo
//
static struct fb_fix_screeninfo __devinitdata s1d13xxxfb_fix = 
{
    .id        = S1D_FBID,
    .type      = FB_TYPE_PACKED_PIXELS,
    .visual    = FB_VISUAL_PSEUDOCOLOR,
    .xpanstep  = 0,
    .ypanstep  = 1,
    .ywrapstep = 0,
    .accel     = FB_ACCEL_NONE,
};



///////////////////////////////////////////////////////////////////////////////
//
//  Read chip registers defined in /arch/<chip>/xxxx-devices.c
//
///////////////////////////////////////////////////////////////////////////////
static inline u32
s1d13xxxfb_readreg(struct s1d13xxxfb_par *par, u8 regno)
{
    //return readb(par->regs + regno);
    return ((S1D_VALUE*)par->regs)[regno/sizeof(S1D_VALUE)];
}


///////////////////////////////////////////////////////////////////////////////
//
//  Write chip registers defined in /arch/<chip>/xxxx-devices.c
//
///////////////////////////////////////////////////////////////////////////////
static inline void
s1d13xxxfb_writereg(struct s1d13xxxfb_par *par, u8 regno, u32 value)
{
    //writeb(value, par->regs + regno);
    ((S1D_VALUE*)par->regs)[regno/sizeof(S1D_VALUE)] = value;
}


///////////////////////////////////////////////////////////////////////////////
//
//  Read register values from device or setup file and write them to the
//  the device.
//
///////////////////////////////////////////////////////////////////////////////
static inline void
s1d13xxxfb_runinit( struct s1d13xxxfb_par *par,
                    const struct s1d13xxxfb_regval *initregs,
                    const unsigned int size )
{
    int i;
    u32 value;

    printk("In s1d13xxxfb_runinit()\n");
    printk("size = %d\n", size);

    for (i = 0; i < size; i++) 
    {
        if ((initregs[i].addr == S1DREG_DELAYOFF) || 
            (initregs[i].addr == S1DREG_DELAYON))
        {
            mdelay((int)initregs[i].value);
        }
        else 
        {
            s1d13xxxfb_writereg(par, initregs[i].addr, initregs[i].value);
            mdelay(10);
        }

        //printk("Tried to write: ");
        //printk("initregs[i].addr: 0x%0.8x  ", initregs[i].addr);
        //printk("value: 0x%0.8x\n", initregs[i].value);

        //value = s1d13xxxfb_readreg(par, initregs[i].addr);
        //printk("Actually wrote: ");
        //printk("initregs[i].addr: 0x%0.8x  ", initregs[i].addr);
        //printk("value: 0x%0.8x\n", value);

    }

    /* make sure the hardware can cope with us */
    mdelay(1);
}
 

///////////////////////////////////////////////////////////////////////////////
//
//  Set enable bit in device register
//
///////////////////////////////////////////////////////////////////////////////
static inline void
lcd_enable(struct s1d13xxxfb_par *par, int enable)
{
    u32 mode = s1d13xxxfb_readreg(par, 0x10);
    mode &= 0xff7fffff; 
    s1d13xxxfb_writereg(par, 0x10, mode);
}



/////////////////// FRAMEBUFFER CONTROL ROUTINES /////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
//  Setup pseudocolor settings
//
///////////////////////////////////////////////////////////////////////////////
static inline void
s1d13xxxfb_setup_pseudocolour(struct fb_info *info)
{
    info->fix.visual = FB_VISUAL_PSEUDOCOLOR;

    //info->var.red.length   = 4;
    //info->var.green.length = 4;
    //info->var.blue.length  = 4;
    info->var.red.length   = 8;
    info->var.green.length = 8;
    info->var.blue.length  = 8;
}


///////////////////////////////////////////////////////////////////////////////
//
//  Setup true color settings
//
///////////////////////////////////////////////////////////////////////////////
static inline void
s1d13xxxfb_setup_truecolour(struct fb_info *info)
{
    info->fix.visual = FB_VISUAL_TRUECOLOR;
    info->var.bits_per_pixel = 16;

    info->var.red.length = 5;
    info->var.red.offset = 11;

    info->var.green.length = 6;
    info->var.green.offset = 5;

    info->var.blue.length = 5;
    info->var.blue.offset = 0;
}


///////////////////////////////////////////////////////////////////////////////
// 
//  s1d13xxxfb_set_par - Alters the hardware state.
//  @info: frame buffer structure
//
//  Using the fb_var_screeninfo in fb_info we set the depth of the
//  framebuffer. This function alters the par AND the
//  fb_fix_screeninfo stored in fb_info. It doesn't not alter var in
//  fb_info since we are using that data. This means we depend on the
//  data in var inside fb_info to be supported by the hardware.
//  xxxfb_check_var is always called before xxxfb_set_par to ensure this.
//
//  XXX TODO: write proper s1d13xxxfb_check_var(), without which that
//  function is quite useless.
//
///////////////////////////////////////////////////////////////////////////////
static int
s1d13xxxfb_set_par(struct fb_info *info)
{
    struct s1d13xxxfb_par *s1dfb = info->par;
    unsigned int val;

    dbg("s1d13xxxfb_set_par: bpp=%d\n", info->var.bits_per_pixel);

    // Read colour control
    //val = s1d13xxxfb_readreg(s1dfb, S1DREG_LCD_DISP_MODE); 

    //val &= ~0x07;

    switch (info->var.bits_per_pixel) 
    {
        case 4:
            dbg("pseudo colour 4\n");
            s1d13xxxfb_setup_pseudocolour(info);
            val |= 2;
            break;

        case 8:
            dbg("pseudo colour 8\n");
            s1d13xxxfb_setup_pseudocolour(info);
            //val |= 3;
            break;

        case 16:
            dbg("true colour\n");
            s1d13xxxfb_setup_truecolour(info);
            val |= 5;
            break;

        default:
            dbg("bpp not supported!\n");
            return -EINVAL;
    }

    dbg("writing %02x to display mode register\n", val);

    // Write color control
    //s1d13xxxfb_writereg(s1dfb, S1DREG_LCD_DISP_MODE, val);

    //info->fix.line_length  = info->var.xres * info->var.bits_per_pixel;
    //info->fix.line_length /= 8;
    info->fix.line_length = 320;

    dbg("setting line_length to %d\n", info->fix.line_length);
    dbg("done setup\n");

    return 0;
}


///////////////////////////////////////////////////////////////////////////////
// 
//  s1d13xxxfb_setcolreg - sets a color register.
//      @regno: Which register in the CLUT we are programming
//      @red: The red value which can be up to 16 bits wide
//      @green: The green value which can be up to 16 bits wide
//      @blue:  The blue value which can be up to 16 bits wide.
//      @transp: If supported the alpha value which can be up to 16 bits wide.
//      @info: frame buffer info structure
//
//  Returns negative errno on error, or zero on success.
//
///////////////////////////////////////////////////////////////////////////////
static int
s1d13xxxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                     u_int transp, struct fb_info *info)
{
    struct s1d13xxxfb_par *s1dfb = info->par;
    unsigned int pseudo_val;
    unsigned long lutdata;

    if (regno >= S1D_PALETTE_SIZE)
    {
        return -EINVAL;
    }

    dbg("s1d13xxxfb_setcolreg: %d: rgb=%d,%d,%d, tr=%d\n",
        regno, red, green, blue, transp);

    if (info->var.grayscale)
    {
        red = green = blue = (19595*red + 38470*green + 7471*blue) >> 16;
    }

    info->fix.visual = FB_VISUAL_PSEUDOCOLOR;


    switch (info->fix.visual) 
    {
        case FB_VISUAL_TRUECOLOR:

            if (regno >= 16)
            {
                return -EINVAL;
            }

            // Deal with creating pseudo-palette entries 
            pseudo_val  = (red   >> 11) << info->var.red.offset;
            pseudo_val |= (green >> 10) << info->var.green.offset;
            pseudo_val |= (blue  >> 11) << info->var.blue.offset;

            dbg("s1d13xxxfb_setcolreg: pseudo %d, val %08x\n",
                regno, pseudo_val);

            ((u32 *)info->pseudo_palette)[regno] = pseudo_val;

            break;

        case FB_VISUAL_PSEUDOCOLOR:
            //s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_ADDR, regno);
            //s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, red);
            //s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, green);
            //s1d13xxxfb_writereg(s1dfb, S1DREG_LKUP_DATA, blue);
            lutdata =(regno << 24) | color_palette[regno*4] | 
                     (color_palette[regno*4+1] << 8) | 
                     (color_palette[regno*4+2] << 16);
            s1d13xxxfb_writereg(s1dfb, 0x18, lutdata);

            break;

        default:
            return -ENOSYS;
    }

    //dbg("s1d13xxxfb_setcolreg: done\n");

    return 0;
}


///////////////////////////////////////////////////////////////////////////////
// 
//  s1d13xxxfb_blank - blanks the display.
//      @blank_mode: the blank mode we want.
//      @info: frame buffer structure that represents a single frame buffer
//
//  Blank the screen if blank_mode != 0, else unblank. Return 0 if
//  blanking succeeded, != 0 if un-/blanking failed due to e.g. a
//  video mode which doesn't support it. Implements VESA suspend
//  and powerdown modes on hardware that supports disabling hsync/vsync:
//      blank_mode == 2: suspend vsync
//      blank_mode == 3: suspend hsync
//      blank_mode == 4: powerdown
//
//  Returns negative errno on error, or zero on success.
//
///////////////////////////////////////////////////////////////////////////////
static int
s1d13xxxfb_blank(int blank_mode, struct fb_info *info)
{
    struct s1d13xxxfb_par *par = info->par;

    dbg("s1d13xxxfb_blank: blank=%d, info=%p\n", blank_mode, info);

    switch (blank_mode) 
    {
        case FB_BLANK_UNBLANK:
        case FB_BLANK_NORMAL:
            if ((par->display & 0x01) != 0)
            {
                lcd_enable(par, 1);
            }
            break;

        case FB_BLANK_VSYNC_SUSPEND:
        case FB_BLANK_HSYNC_SUSPEND:
            break;

        case FB_BLANK_POWERDOWN:
            lcd_enable(par, 0);
            break;

        default:
            return -EINVAL;
    }

    // Let fbcon do a soft blank for us
    return ((blank_mode == FB_BLANK_NORMAL) ? 1 : 0);
}


///////////////////////////////////////////////////////////////////////////////
// 
//      s1d13xxxfb_pan_display - Pans the display.
//      @var: frame buffer variable screen structure
//      @info: frame buffer structure that represents a single frame buffer
//
//    Pan (or wrap, depending on the `vmode' field) the display using the
//      `yoffset' field of the `var' structure (`xoffset'  not yet supported).
//      If the values don't fit, return -EINVAL.
//
//     Returns negative errno on error, or zero on success.
// 
///////////////////////////////////////////////////////////////////////////////
static int
s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
{
    struct s1d13xxxfb_par *par = info->par;
    u32 start;

    if (var->xoffset != 0)    // not yet ... 
    {
        return -EINVAL;
    }

    if (var->yoffset + info->var.yres > info->var.yres_virtual)
    {
        return -EINVAL;
    }

    start = (info->fix.line_length >> 1) * var->yoffset;

    //s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START0, (start & 0xff));
    //s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START1, ((start >> 8) & 0xff));
    //s1d13xxxfb_writereg(par, S1DREG_LCD_DISP_START2, ((start >> 16) & 0x0f));

    return 0;
}



/////////////////// FRAMEBUFFER INFORMATION STRUCTURES  //////////////////////

static struct fb_ops s1d13xxxfb_fbops = 
{
    .owner        = THIS_MODULE,
    .fb_set_par   = s1d13xxxfb_set_par,
    .fb_setcolreg = s1d13xxxfb_setcolreg,
    .fb_blank     = s1d13xxxfb_blank,

    .fb_pan_display = s1d13xxxfb_pan_display,

    // To be replaced by any acceleration we can 
    .fb_fillrect    = cfb_fillrect,
    .fb_copyarea    = cfb_copyarea,
    .fb_imageblit    = cfb_imageblit,
};


static int s1d13xxxfb_width_tab[2][4] __devinitdata = 
{
    {4,  8, 16, -1},
    {9, 12, 18, -1},
};


///////////////////////////////////////////////////////////////////////////////
// 
//      s1d13xxxfb_fetch_hw_state - Configure the framebuffer according to
//    hardware setup.
//      @info: frame buffer structure
//
//    We setup the framebuffer structures according to the current
//    hardware setup. On some machines, the BIOS will have filled
//    the chip registers with such info, on others, these values will
//    have been written in some init procedure. In any case, the
//    software values needs to match the hardware ones. This is what
//    this function ensures.
//
//    Note: some of the hardcoded values here might need some love to
//    work on various chips, and might need to no longer be hardcoded.
// 
///////////////////////////////////////////////////////////////////////////////
static void __devinit
s1d13xxxfb_fetch_hw_state(struct fb_info *info)
{
    struct fb_var_screeninfo *var = &info->var;
    struct fb_fix_screeninfo *fix = &info->fix;
    struct s1d13xxxfb_par *par = info->par;
    u8 panel, display;
    u16 offset;
    u32 xres, yres;
    u32 xres_virtual, yres_virtual;
    int bpp, lcd_bpp;
    int is_color, is_dual, is_tft;
    int lcd_enabled, crt_enabled;

    printk("In fetch_hw_state()\n");

    fix->type = FB_TYPE_PACKED_PIXELS;

    printk("1\n");

    // General info
    //par->display = s1d13xxxfb_readreg(par, S1DREG_COM_DISP_MODE);
    par->display = s1d13xxxfb_readreg(par, 0x0);
    printk("par->display: 0x%x\n", par->display);
    printk("2\n");
    crt_enabled = (par->display & 0x02) != 0;
    printk("3\n");
    lcd_enabled = (par->display & 0x01) != 0;
    printk("4\n");

    crt_enabled = 0;
    lcd_enabled = 1;

    printk("5\n");

    //display = s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_MODE);
    display = s1d13xxxfb_readreg(par, 0x10);
    printk("dispay: 0x%x\n", display);

    printk("6\n");


    //bpp = display & 0x07;
    bpp = 3;

    printk("bpp: %d\n", bpp);

    switch (bpp) 
    {
        case 2:    /* 4 bpp */
        case 3:    /* 8 bpp */
            var->bits_per_pixel = 8;
            var->red.offset = var->green.offset = var->blue.offset = 0;
            var->red.length = var->green.length = var->blue.length = 8;
            break;

        case 5:    /* 16 bpp */
            s1d13xxxfb_setup_truecolour(info);
            break;

        default:
            dbg("bpp: %i\n", bpp);
    }

    fb_alloc_cmap(&info->cmap, 256, 0);

    printk("7\n");

    /* LCD info */
    //panel = s1d13xxxfb_readreg(par, S1DREG_PANEL_TYPE);
    //is_color = (panel & 0x04) != 0;
    //is_dual = (panel & 0x02) != 0;
    //is_tft = (panel & 0x01) != 0;
    //lcd_bpp = s1d13xxxfb_width_tab[is_tft][(panel >> 4) & 3];

    is_color = 1;
    is_dual  = 0;
    is_tft   = 0;
    lcd_bpp  = 8; 

    printk("8\n");
    printk("lcd_enabled: %d\n", lcd_enabled);

    //xres = (s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_HWIDTH) + 1) * 8;
    xres = 320; 

    //yres = (s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_VHEIGHT0) +
    //   ((s1d13xxxfb_readreg(par, S1DREG_LCD_DISP_VHEIGHT1) & 0x03) << 8) + 1);
    yres = 240;

    //offset = (s1d13xxxfb_readreg(par, S1DREG_LCD_MEM_OFF0) +
    //    ((s1d13xxxfb_readreg(par, S1DREG_LCD_MEM_OFF1) & 0x7) << 8));
    offset = 0;

    printk("9\n");

    printk("var->bits_per_pixel: 0x%x\n", var->bits_per_pixel);
    printk("fix->smem_len: 0x%x\n", fix->smem_len);
    printk("offset: 0x%x\n", offset);

    //xres_virtual = offset * 16 / var->bits_per_pixel;
    xres_virtual = xres;
    //yres_virtual = fix->smem_len / (offset * 2);
    yres_virtual = yres;

    printk("10\n");

    var->xres = xres;
    var->yres = yres;

    var->xres_virtual = xres_virtual;
    var->yres_virtual = yres_virtual;

    var->xoffset = var->yoffset = 0;

    //fix->line_length = offset * 2;
    fix->line_length = 320;

    var->grayscale = !is_color;
    var->activate  = FB_ACTIVATE_NOW;

    /////////////////////////////////////////////////////////////
    var->xres           = 320;
    var->yres           = 240;
    var->xres_virtual   = var->xres;
    var->yres_virtual   = var->yres;
    var->xoffset        = var->yoffset = 0;
    var->bits_per_pixel = 8;
    var->grayscale      = 0;
    var->nonstd         = 0;               /* != 0 Non standard pixel format */
    var->activate       = FB_ACTIVATE_NOW; /* see FB_ACTIVATE_*              */
    var->height         = -1;              /* height of picture in mm        */
    var->width          = -1;              /* width of picture in mm         */
    var->accel_flags    = 0;               /* acceleration flags (hints      */
    var->pixclock       = S1D_DISPLAY_PCLK;
    var->right_margin   = 0;
    var->lower_margin   = 0;
    var->hsync_len      = 0;
    var->vsync_len      = 0;
    var->left_margin    = 0;
    var->upper_margin   = 0;
    var->sync           = 0;
    var->vmode          = FB_VMODE_NONINTERLACED;
    info->fix.visual    = FB_VISUAL_PSEUDOCOLOR;

    var->red.msb_right = var->green.msb_right = var->blue.msb_right = 0;
    var->transp.offset = var->transp.length = var->transp.msb_right = 0;
    /////////////////////////////////////////////////////////////


    dbg ("bpp=%d, lcd_bpp=%d, crt_enabled=%d, lcd_enabled=%d\n",
         var->bits_per_pixel, lcd_bpp, crt_enabled, lcd_enabled);

    dbg ("xres=%d, yres=%d, vxres=%d, vyres=%d "
         "is_color=%d, is_dual=%d, is_tft=%d\n",
          xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
}


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_remove - Unregister frame buffer device from kernel
//
///////////////////////////////////////////////////////////////////////////////
static int
s1d13xxxfb_remove(struct platform_device *pdev)
{
    struct fb_info *info = platform_get_drvdata(pdev);
    struct s1d13xxxfb_par *par = NULL;

    if (info) 
    {
        par = info->par;

        if (par && par->regs) 
        {
            // Disable output & enable powersave 
            //s1d13xxxfb_writereg(par, S1DREG_COM_DISP_MODE, 0x00);
            //s1d13xxxfb_writereg(par, S1DREG_PS_CNF, 0x11);
            iounmap(par->regs);
        }

        fb_dealloc_cmap(&info->cmap);

        if (info->screen_base)
        {
            iounmap(info->screen_base);
        }

        framebuffer_release(info);
    }

    release_mem_region(pdev->resource[0].start,
                       pdev->resource[0].end - pdev->resource[0].start +1);
    release_mem_region(pdev->resource[1].start,
                       pdev->resource[1].end - pdev->resource[1].start +1);

    return 0;
}


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_probe - Initialize and load frame buffer for use by kernel
//
///////////////////////////////////////////////////////////////////////////////
static int __devinit
s1d13xxxfb_probe(struct platform_device *pdev)
{
    struct s1d13xxxfb_par *default_par;
    struct fb_info *info;
    struct s1d13xxxfb_pdata *pdata = NULL;
    int ret = 0;
    u8 revision;

    dbg("probe called: device is %p\n", pdev);

    printk(KERN_INFO "Epson S1D13XXX FB Driver\n");

    // Enable platform-dependent hardware glue, if any 
    if (pdev->dev.platform_data)
    {
        pdata = pdev->dev.platform_data;
        printk(KERN_INFO "pdata set\n");
    }

    if (pdata && pdata->platform_init_video)
    {
        pdata->platform_init_video();
        printk(KERN_INFO "pdata->platform_init_video() called\n");
    }

    if (pdev->num_resources != 2) 
    {
        dev_err(&pdev->dev, "invalid num_resources: %i\n", pdev->num_resources);
        ret = -ENODEV;

        goto bail;
    }

    // resource[0] is VRAM, resource[1] is registers
    if (pdev->resource[0].flags != IORESOURCE_MEM || 
        pdev->resource[1].flags != IORESOURCE_MEM) 
    {
        dev_err(&pdev->dev, "invalid resource type\n");
        ret = -ENODEV;

        goto bail;
    }

    if (!request_mem_region(pdev->resource[0].start,
         pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) 
    {
        dev_dbg(&pdev->dev, "request_mem_region failed\n");
        ret = -EBUSY;

        goto bail;
    }

    if (!request_mem_region(pdev->resource[1].start,
        pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) 
    {
        dev_dbg(&pdev->dev, "request_mem_region failed\n");
        ret = -EBUSY;

        goto bail;
    }

    info = framebuffer_alloc(
               sizeof(struct s1d13xxxfb_par) + sizeof(u32) * 256, &pdev->dev);

    if (!info) 
    {
        ret = -ENOMEM;

        goto bail;
    }

    platform_set_drvdata(pdev, info);

    default_par = info->par;
    default_par->regs = ioremap_nocache(pdev->resource[1].start,
                        pdev->resource[1].end - pdev->resource[1].start +1);

    if (!default_par->regs) 
    {
        printk(KERN_ERR PFX "unable to map registers\n");
        ret = -ENOMEM;

        goto bail;
    }

    info->pseudo_palette = default_par->pseudo_palette;

    info->screen_base = ioremap_nocache(pdev->resource[0].start,
                        pdev->resource[0].end - pdev->resource[0].start +1);

    if (!info->screen_base) 
    {
        printk(KERN_ERR PFX "unable to map framebuffer\n");
        ret = -ENOMEM;

        goto bail;
    }

    // Turn BitBLT off
    s1d13xxxfb_writereg(info->par, 0x8000, 0x00000000);

    printk ("revision = 0x%x\n", revision);

    info->fix = s1d13xxxfb_fix;
    info->fix.mmio_start = pdev->resource[1].start;
    info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start +1;
    info->fix.smem_start = pdev->resource[0].start;
    info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start +1;

    printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
           default_par->regs, info->fix.smem_len / 1024, info->screen_base);

    info->par = default_par;
    info->fbops = &s1d13xxxfb_fbops;

    //info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
    info->flags = FBINFO_DEFAULT;

    
    // Perform "manual" chip initialization, if needed 
    if (pdata && pdata->initregs)
    {
        s1d13xxxfb_runinit(info->par, pdata->initregs, pdata->initregssize);
    }

    s1d13xxxfb_fetch_hw_state(info);

    // Enable device
    u32 mode = s1d13xxxfb_readreg(info->par, 0x10);
    mode &= 0xff7fffff; 
    s1d13xxxfb_writereg(info->par, 0x10, mode);


    if (register_framebuffer(info) < 0) 
    {
        ret = -EINVAL;

        goto bail;
    }

    printk(KERN_INFO "fb%d: %s frame buffer device\n",info->node,info->fix.id);

    return 0;

bail:
    s1d13xxxfb_remove(pdev);
    return ret;
}


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_suspend - 
//
///////////////////////////////////////////////////////////////////////////////
#ifdef CONFIG_PM
static int s1d13xxxfb_suspend(struct platform_device *dev, pm_message_t state)
{
    struct fb_info *info = platform_get_drvdata(dev);
    struct s1d13xxxfb_par *s1dfb = info->par;
    struct s1d13xxxfb_pdata *pdata = NULL;

    // Disable display
    lcd_enable(s1dfb, 0);

    if (dev->dev.platform_data)
    {
        pdata = dev->dev.platform_data;
    }

#if 0
    if (!s1dfb->disp_save)
        s1dfb->disp_save = kmalloc(info->fix.smem_len, GFP_KERNEL);

    if (!s1dfb->disp_save) {
        printk(KERN_ERR PFX "no memory to save screen");
        return -ENOMEM;
    }

    memcpy_fromio(s1dfb->disp_save, info->screen_base, info->fix.smem_len);
#else
    s1dfb->disp_save = NULL;
#endif

    if (!s1dfb->regs_save)
    {
        s1dfb->regs_save = kmalloc(info->fix.mmio_len, GFP_KERNEL);
    }

    if (!s1dfb->regs_save) 
    {
        printk(KERN_ERR PFX "no memory to save registers");

        return -ENOMEM;
    }

    /* backup all registers */
    memcpy_fromio(s1dfb->regs_save, s1dfb->regs, info->fix.mmio_len);

    /* now activate power save mode */
    //s1d13xxxfb_writereg(s1dfb, S1DREG_PS_CNF, 0x11);

    if (pdata && pdata->platform_suspend_video)
    {
        return pdata->platform_suspend_video();
    }
    else
    {
        return 0;
    }
}


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_resume - 
//
///////////////////////////////////////////////////////////////////////////////
static int s1d13xxxfb_resume(struct platform_device *dev)
{
    struct fb_info *info = platform_get_drvdata(dev);
    struct s1d13xxxfb_par *s1dfb = info->par;
    struct s1d13xxxfb_pdata *pdata = NULL;

    // Awaken the chip
    //s1d13xxxfb_writereg(s1dfb, S1DREG_PS_CNF, 0x10);

    // Do not let go until SDRAM "wakes up" 
    while ((s1d13xxxfb_readreg(s1dfb, S1DREG_PS_STATUS) & 0x01))
    {
        udelay(10);
    }

    if (dev->dev.platform_data)
    {
        pdata = dev->dev.platform_data;
    }

    if (s1dfb->regs_save) 
    {
        // Will write RO regs, *should* get away with it :) 
        memcpy_toio(s1dfb->regs, s1dfb->regs_save, info->fix.mmio_len);
        kfree(s1dfb->regs_save);
    }

    if (s1dfb->disp_save) 
    {
        memcpy_toio(info->screen_base, s1dfb->disp_save, info->fix.smem_len);
        kfree(s1dfb->disp_save);    // XXX kmalloc()'d when?
    }

    if ((s1dfb->display & 0x01) != 0)
    {
        lcd_enable(s1dfb, 1);
    }

    if (pdata && pdata->platform_resume_video)
    {
        return pdata->platform_resume_video();
    }
    else
    {
        return 0;
    }
}
#endif /* CONFIG_PM */


//
//  Here we define the platform struct s1d13xxxfb_driver 
//
static struct platform_driver s1d13xxxfb_driver = 
{
    .probe   = s1d13xxxfb_probe,
    .remove  = s1d13xxxfb_remove,
#ifdef CONFIG_PM
    .suspend = s1d13xxxfb_suspend,
    .resume  = s1d13xxxfb_resume,
#endif
    .driver = 
    {
        .name = S1D_DEVICENAME,
    },
};


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_init - Start intitialization of frame buffer
//
///////////////////////////////////////////////////////////////////////////////
static int __init
s1d13xxxfb_init(void)
{

#ifndef MODULE
    if (fb_get_options("s1d13xxxfb", NULL))
    {
        return -ENODEV;
    }
#endif

    return platform_driver_register(&s1d13xxxfb_driver);
}


///////////////////////////////////////////////////////////////////////////////
//
//  s1d13xxxfb_exit - Unregister driver
//
///////////////////////////////////////////////////////////////////////////////
static void __exit
s1d13xxxfb_exit(void)
{
    platform_driver_unregister(&s1d13xxxfb_driver);
}


module_init(s1d13xxxfb_init);
module_exit(s1d13xxxfb_exit);


MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Framebuffer driver for S1D13xxx devices");
MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Thibaut VARENE <varenet@parisc-linux.org>");
------=_20081111095047_31099
Content-Type: text/x-csrc; name="mcf5445x-devices.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mcf5445x-devices.c"

/*
 * arch/m68k/coldfire/mcf5445x-devices.c
 *
 * Coldfire M5445x Platform Device Configuration
 *
 * Based on the Freescale MXC devices.c
 *
 * Copyright (c) 2007 Freescale Semiconductor, Inc.
 *	Kurt Mahan <kmahan@freescale.com>
 */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/fsl_devices.h>

#include <asm/coldfire.h>
#include <asm/mcfsim.h>

/* ATA Interrupt */
#define IRQ_ATA		(64 + 64 + 54)

/* ATA Base */
#define	BASE_IO_ATA	0x90000000

#define ATA_IER		MCF_REG08(BASE_IO_ATA+0x2c)	/* int enable reg */
#define ATA_ICR		MCF_REG08(BASE_IO_ATA+0x30)	/* int clear reg */

/*
 * On-chip PATA
 */
#if defined(CONFIG_PATA_FSL) || defined(CONFIG_PATA_FSL_MODULE)
static int ata_init(struct platform_device *pdev)
{
	/* clear ints */
	ATA_IER = 0x00;
	ATA_ICR = 0xff;

	/* setup shared pins */
	MCF_GPIO_PAR_FEC = (MCF_GPIO_PAR_FEC & MCF_GPIO_PAR_FEC_FEC1_MASK) |
			   MCF_GPIO_PAR_FEC_FEC1_ATA;

	MCF_GPIO_PAR_FECI2C = (MCF_GPIO_PAR_FECI2C &
	  		      (MCF_GPIO_PAR_FECI2C_MDC1_MASK &
			      MCF_GPIO_PAR_FECI2C_MDIO1_MASK)) |
	  		      MCF_GPIO_PAR_FECI2C_MDC1_ATA_DIOR |
	  		      MCF_GPIO_PAR_FECI2C_MDIO1_ATA_DIOW;

	MCF_GPIO_PAR_ATA = MCF_GPIO_PAR_ATA_BUFEN |
			   MCF_GPIO_PAR_ATA_CS1 |
			   MCF_GPIO_PAR_ATA_CS0 |
			   MCF_GPIO_PAR_ATA_DA2 |
			   MCF_GPIO_PAR_ATA_DA1 |
			   MCF_GPIO_PAR_ATA_DA0 |
			   MCF_GPIO_PAR_ATA_RESET_RESET |
			   MCF_GPIO_PAR_ATA_DMARQ_DMARQ |
			   MCF_GPIO_PAR_ATA_IORDY_IORDY;

	MCF_GPIO_PAR_PCI = (MCF_GPIO_PAR_PCI &
			     (MCF_GPIO_PAR_PCI_GNT3_MASK &
			      MCF_GPIO_PAR_PCI_REQ3_MASK)) |
			   MCF_GPIO_PAR_PCI_GNT3_ATA_DMACK |
			   MCF_GPIO_PAR_PCI_REQ3_ATA_INTRQ;

	return 0;
}

static void ata_exit(void)
{
	printk(KERN_INFO "** ata_exit\n");
}

static int ata_get_clk_rate(void)
{
	return MCF_BUSCLK;
}

/* JKM -- move these to a header file */
#define MCF_IDE_DMA_WATERMARK	32	/* DMA watermark level in bytes */
#define MCF_IDE_DMA_BD_NR	(512/3/4) /* number of BDs per channel */

static struct fsl_ata_platform_data ata_data = {
	.init             = ata_init,
	.exit             = ata_exit,
	.get_clk_rate     = ata_get_clk_rate,
#ifdef CONFIG_PATA_FSL_USE_DMA
        .udma_mask        = 0x0F, /* the board handles up to UDMA3 */
        .fifo_alarm       = MCF_IDE_DMA_WATERMARK / 2,
        .max_sg           = MCF_IDE_DMA_BD_NR,
#endif
};

static struct resource pata_fsl_resources[] = {
	[0] = {		/* I/O */
		.start		= BASE_IO_ATA,
		.end		= BASE_IO_ATA + 0x000000d8,
		.flags		= IORESOURCE_MEM,
	},
	[2] = {		/* IRQ */
		.start		= IRQ_ATA,
		.end		= IRQ_ATA,
		.flags		= IORESOURCE_IRQ,
	},
};

static struct platform_device pata_fsl_device = {
	.name			= "pata_fsl",
	.id			= -1,
	.num_resources		= ARRAY_SIZE(pata_fsl_resources),
	.resource		= pata_fsl_resources,
	.dev			= {
		.platform_data	= &ata_data,
		.coherent_dma_mask = ~0,	/* $$$ REVISIT */
	},
};

static inline void mcf5445x_init_pata(void)
{
	(void)platform_device_register(&pata_fsl_device);
}
#else
static inline void mcf5445x_init_pata(void)
{
}
#endif

static int __init mcf5445x_init_devices(void)
{
	printk(KERN_INFO "MCF5445x INIT_DEVICES\n");
#if 0
	mcf5445x_init_pata();
#endif

	return 0;
}
arch_initcall(mcf5445x_init_devices);
------=_20081111095047_31099
Content-Type: application/octet-stream; name="s1d13xxxfb.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s1d13xxxfb.h"

LyogaW5jbHVkZS92aWRlby9zMWQxM3h4eGZiLmgKICoKICogKGMpIDIwMDQgU2ltdGVjIEVsZWN0
cm9uaWNzCiAqIChjKSAyMDA1IFRoaWJhdXQgVkFSRU5FIDx2YXJlbmV0QHBhcmlzYy1saW51eC5v
cmc+CiAqCiAqIEhlYWRlciBmaWxlIGZvciBFcHNvbiBTMUQxM1hYWCBkcml2ZXIgY29kZQogKgog
KiBUaGlzIGZpbGUgaXMgc3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYwogKiBMaWNlbnNlLiBTZWUgdGhlIGZpbGUgQ09QWUlORyBpbiB0
aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhpcyBhcmNoaXZlIGZvcgogKiBtb3JlIGRldGFpbHMuCiAq
LwoKI2lmbmRlZglTMUQxM1hYWEZCX0gKI2RlZmluZQlTMUQxM1hYWEZCX0gKCiNkZWZpbmUgUzFE
X1BBTEVUVEVfU0laRQkJMjU2CiNkZWZpbmUgUzFEX0NISVBfUkVWCQkJNwkvKiBleHBlY3RlZCBj
aGlwIHJldmlzaW9uIG51bWJlciBmb3IgczFkMTM4MDYgKi8KI2RlZmluZSBTMURfRkJJRAkJCSJT
MUQxMzgwNiIKLyogI2RlZmluZSBTMURfREVWSUNFTkFNRQkJCSJzMWQxMzgwNmZiIiAgKi8KI2Rl
ZmluZSBTMURfREVWSUNFTkFNRQkJCSJzMWQxM2EwNGZiIgoKLyogcmVnaXN0ZXIgZGVmaW5pdGlv
bnMgKHRlc3RlZCBvbiBzMWQxMzg5NikgKi8KI2RlZmluZSBTMURSRUdfUkVWX0NPREUJCQkweDAw
MDAJLyogUmV2aXNpb24gQ29kZSBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19NSVNDCQkJMHgw
MDAxCS8qIE1pc2NlbGxhbmVvdXMgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfR1BJT19DTkYw
CQkweDAwMDQJLyogR2VuZXJhbCBJTyBQaW5zIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgMCAqLwoj
ZGVmaW5lIFMxRFJFR19HUElPX0NORjEJCTB4MDAwNQkvKiBHZW5lcmFsIElPIFBpbnMgQ29uZmln
dXJhdGlvbiBSZWdpc3RlciAxICovCiNkZWZpbmUgUzFEUkVHX0dQSU9fQ1RMMAkJMHgwMDA4CS8q
IEdlbmVyYWwgSU8gUGlucyBDb250cm9sIFJlZ2lzdGVyIDAgKi8KI2RlZmluZSBTMURSRUdfR1BJ
T19DVEwxCQkweDAwMDkJLyogR2VuZXJhbCBJTyBQaW5zIENvbnRyb2wgUmVnaXN0ZXIgMSAqLwoj
ZGVmaW5lIFMxRFJFR19DTkZfU1RBVFVTCQkweDAwMEMJLyogQ29uZmlndXJhdGlvbiBTdGF0dXMg
UmVhZGJhY2sgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ0xLX0NORgkJCTB4MDAxMAkvKiBN
ZW1vcnkgQ2xvY2sgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MQ0Rf
Q0xLX0NORgkJMHgwMDE0CS8qIExDRCBQaXhlbCBDbG9jayBDb25maWd1cmF0aW9uIFJlZ2lzdGVy
ICovCiNkZWZpbmUgUzFEUkVHX0NSVF9DTEtfQ05GCQkweDAwMTgJLyogQ1JUL1RWIFBpeGVsIENs
b2NrIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTVBMVUdfQ0xLX0NO
RgkJMHgwMDFDCS8qIE1lZGlhUGx1ZyBDbG9jayBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICovCiNk
ZWZpbmUgUzFEUkVHX0NQVTJNRU1fV1NUX1NFTAkJMHgwMDFFCS8qIENQVSBUbyBNZW1vcnkgV2Fp
dCBTdGF0ZSBTZWxlY3QgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTUVNX0NORgkJCTB4MDAy
MAkvKiBNZW1vcnkgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19TRFJB
TV9SRUZfUkFURQkJMHgwMDIxCS8qIFNEUkFNIFJlZnJlc2ggUmF0ZSBSZWdpc3RlciAqLwojZGVm
aW5lIFMxRFJFR19TRFJBTV9UQzAJCTB4MDAyQQkvKiBTRFJBTSBUaW1pbmcgQ29udHJvbCBSZWdp
c3RlciAwICovCiNkZWZpbmUgUzFEUkVHX1NEUkFNX1RDMQkJMHgwMDJCCS8qIFNEUkFNIFRpbWlu
ZyBDb250cm9sIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBTMURSRUdfUEFORUxfVFlQRQkJMHgwMDMw
CS8qIFBhbmVsIFR5cGUgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTU9EX1JBVEUJCQkweDAw
MzEJLyogTU9EIFJhdGUgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTENEX0RJU1BfSFdJRFRI
CQkweDAwMzIJLyogTENEIEhvcml6b250YWwgRGlzcGxheSBXaWR0aCBSZWdpc3RlcjogKCh2YWwp
KzEpKjgpPXBpeC9saW5lICovCiNkZWZpbmUgUzFEUkVHX0xDRF9ORElTUF9IUEVSCQkweDAwMzQJ
LyogTENEIEhvcml6b250YWwgTm9uLURpc3BsYXkgUGVyaW9kIFJlZ2lzdGVyOiAoKHZhbCkrMSkq
OCk9TkRwaXgvbGluZSAqLwojZGVmaW5lIFMxRFJFR19URlRfRlBMSU5FX1NUQVJUCQkweDAwMzUJ
LyogVEZUIEZQTElORSBTdGFydCBQb3NpdGlvbiBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19U
RlRfRlBMSU5FX1BXSURUSAkweDAwMzYJLyogVEZUIEZQTElORSBQdWxzZSBXaWR0aCBSZWdpc3Rl
ci4gKi8KI2RlZmluZSBTMURSRUdfTENEX0RJU1BfVkhFSUdIVDAJMHgwMDM4CS8qIExDRCBWZXJ0
aWNhbCBEaXNwbGF5IEhlaWdodCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0xDRF9ESVNQ
X1ZIRUlHSFQxCTB4MDAzOQkvKiBMQ0QgVmVydGljYWwgRGlzcGxheSBIZWlnaHQgUmVnaXN0ZXIg
MSAqLwojZGVmaW5lIFMxRFJFR19MQ0RfTkRJU1BfVlBFUgkJMHgwMDNBCS8qIExDRCBWZXJ0aWNh
bCBOb24tRGlzcGxheSBQZXJpb2QgUmVnaXN0ZXI6ICh2YWwpKzE9TkRsaW5lcyAqLwojZGVmaW5l
IFMxRFJFR19URlRfRlBGUkFNRV9TVEFSVAkweDAwM0IJLyogVEZUIEZQRlJBTUUgU3RhcnQgUG9z
aXRpb24gUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfVEZUX0ZQRlJBTUVfUFdJRFRICTB4MDAz
QwkvKiBURlQgRlBGUkFNRSBQdWxzZSBXaWR0aCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19M
Q0RfRElTUF9NT0RFCQkweDAwNDAJLyogTENEIERpc3BsYXkgTW9kZSBSZWdpc3RlciAqLwojZGVm
aW5lIFMxRFJFR19MQ0RfTUlTQwkJCTB4MDA0MQkvKiBMQ0QgTWlzY2VsbGFuZW91cyBSZWdpc3Rl
ciAqLwojZGVmaW5lIFMxRFJFR19MQ0RfRElTUF9TVEFSVDAJCTB4MDA0MgkvKiBMQ0QgRGlzcGxh
eSBTdGFydCBBZGRyZXNzIFJlZ2lzdGVyIDAgKi8KI2RlZmluZSBTMURSRUdfTENEX0RJU1BfU1RB
UlQxCQkweDAwNDMJLyogTENEIERpc3BsYXkgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAxICovCiNk
ZWZpbmUgUzFEUkVHX0xDRF9ESVNQX1NUQVJUMgkJMHgwMDQ0CS8qIExDRCBEaXNwbGF5IFN0YXJ0
IEFkZHJlc3MgUmVnaXN0ZXIgMiAqLwojZGVmaW5lIFMxRFJFR19MQ0RfTUVNX09GRjAJCTB4MDA0
NgkvKiBMQ0QgTWVtb3J5IEFkZHJlc3MgT2Zmc2V0IFJlZ2lzdGVyIDAgKi8KI2RlZmluZSBTMURS
RUdfTENEX01FTV9PRkYxCQkweDAwNDcJLyogTENEIE1lbW9yeSBBZGRyZXNzIE9mZnNldCBSZWdp
c3RlciAxICovCiNkZWZpbmUgUzFEUkVHX0xDRF9QSVhfUEFOCQkweDAwNDgJLyogTENEIFBpeGVs
IFBhbm5pbmcgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTENEX0RJU1BfRklGT19IVEMJMHgw
MDRBCS8qIExDRCBEaXNwbGF5IEZJRk8gSGlnaCBUaHJlc2hvbGQgQ29udHJvbCBSZWdpc3RlciAq
LwojZGVmaW5lIFMxRFJFR19MQ0RfRElTUF9GSUZPX0xUQwkweDAwNEIJLyogTENEIERpc3BsYXkg
RklGTyBMb3cgVGhyZXNob2xkIENvbnRyb2wgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1JU
X0RJU1BfSFdJRFRICQkweDAwNTAJLyogQ1JUL1RWIEhvcml6b250YWwgRGlzcGxheSBXaWR0aCBS
ZWdpc3RlcjogKCh2YWwpKzEpKjgpPXBpeC9saW5lICovCiNkZWZpbmUgUzFEUkVHX0NSVF9ORElT
UF9IUEVSCQkweDAwNTIJLyogQ1JUL1RWIEhvcml6b250YWwgTm9uLURpc3BsYXkgUGVyaW9kIFJl
Z2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9IUlRDX1NUQVJUCQkweDAwNTMJLyogQ1JUL1RW
IEhSVEMgU3RhcnQgUG9zaXRpb24gUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1JUX0hSVENf
UFdJRFRICQkweDAwNTQJLyogQ1JUL1RWIEhSVEMgUHVsc2UgV2lkdGggUmVnaXN0ZXIgKi8KI2Rl
ZmluZSBTMURSRUdfQ1JUX0RJU1BfVkhFSUdIVDAJMHgwMDU2CS8qIENSVC9UViBWZXJ0aWNhbCBE
aXNwbGF5IEhlaWdodCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0NSVF9ESVNQX1ZIRUlH
SFQxCTB4MDA1NwkvKiBDUlQvVFYgVmVydGljYWwgRGlzcGxheSBIZWlnaHQgUmVnaXN0ZXIgMSAq
LwojZGVmaW5lIFMxRFJFR19DUlRfTkRJU1BfVlBFUgkJMHgwMDU4CS8qIENSVC9UViBWZXJ0aWNh
bCBOb24tRGlzcGxheSBQZXJpb2QgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1JUX1ZSVENf
U1RBUlQJCTB4MDA1OQkvKiBDUlQvVFYgVlJUQyBTdGFydCBQb3NpdGlvbiBSZWdpc3RlciAqLwoj
ZGVmaW5lIFMxRFJFR19DUlRfVlJUQ19QV0lEVEgJCTB4MDA1QQkvKiBDUlQvVFYgVlJUQyBQdWxz
ZSBXaWR0aCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19UVl9PVVRfQ1RMCQkweDAwNUIJLyog
VFYgT3V0cHV0IENvbnRyb2wgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1JUX0RJU1BfTU9E
RQkJMHgwMDYwCS8qIENSVC9UViBEaXNwbGF5IE1vZGUgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURS
RUdfQ1JUX0RJU1BfU1RBUlQwCQkweDAwNjIJLyogQ1JUL1RWIERpc3BsYXkgU3RhcnQgQWRkcmVz
cyBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0NSVF9ESVNQX1NUQVJUMQkJMHgwMDYzCS8q
IENSVC9UViBEaXNwbGF5IFN0YXJ0IEFkZHJlc3MgUmVnaXN0ZXIgMSAqLwojZGVmaW5lIFMxRFJF
R19DUlRfRElTUF9TVEFSVDIJCTB4MDA2NAkvKiBDUlQvVFYgRGlzcGxheSBTdGFydCBBZGRyZXNz
IFJlZ2lzdGVyIDIgKi8KI2RlZmluZSBTMURSRUdfQ1JUX01FTV9PRkYwCQkweDAwNjYJLyogQ1JU
L1RWIE1lbW9yeSBBZGRyZXNzIE9mZnNldCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0NS
VF9NRU1fT0ZGMQkJMHgwMDY3CS8qIENSVC9UViBNZW1vcnkgQWRkcmVzcyBPZmZzZXQgUmVnaXN0
ZXIgMSAqLwojZGVmaW5lIFMxRFJFR19DUlRfUElYX1BBTgkJMHgwMDY4CS8qIENSVC9UViBQaXhl
bCBQYW5uaW5nIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9ESVNQX0ZJRk9fSFRDCTB4
MDA2QQkvKiBDUlQvVFYgRGlzcGxheSBGSUZPIEhpZ2ggVGhyZXNob2xkIENvbnRyb2wgUmVnaXN0
ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1JUX0RJU1BfRklGT19MVEMJMHgwMDZCCS8qIENSVC9UViBE
aXNwbGF5IEZJRk8gTG93IFRocmVzaG9sZCBDb250cm9sIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFE
UkVHX0xDRF9DVVJfQ1RMCQkweDAwNzAJLyogTENEIEluay9DdXJzb3IgQ29udHJvbCBSZWdpc3Rl
ciAqLwojZGVmaW5lIFMxRFJFR19MQ0RfQ1VSX1NUQVJUCQkweDAwNzEJLyogTENEIEluay9DdXJz
b3IgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MQ0RfQ1VSX1hQT1Mw
CQkweDAwNzIJLyogTENEIEN1cnNvciBYIFBvc2l0aW9uIFJlZ2lzdGVyIDAgKi8KI2RlZmluZSBT
MURSRUdfTENEX0NVUl9YUE9TMQkJMHgwMDczCS8qIExDRCBDdXJzb3IgWCBQb3NpdGlvbiBSZWdp
c3RlciAxICovCiNkZWZpbmUgUzFEUkVHX0xDRF9DVVJfWVBPUzAJCTB4MDA3NAkvKiBMQ0QgQ3Vy
c29yIFkgUG9zaXRpb24gUmVnaXN0ZXIgMCAqLwojZGVmaW5lIFMxRFJFR19MQ0RfQ1VSX1lQT1Mx
CQkweDAwNzUJLyogTENEIEN1cnNvciBZIFBvc2l0aW9uIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBT
MURSRUdfTENEX0NVUl9CQ1RMMAkJMHgwMDc2CS8qIExDRCBJbmsvQ3Vyc29yIEJsdWUgQ29sb3Ig
MCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MQ0RfQ1VSX0dDVEwwCQkweDAwNzcJLyogTENE
IEluay9DdXJzb3IgR3JlZW4gQ29sb3IgMCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MQ0Rf
Q1VSX1JDVEwwCQkweDAwNzgJLyogTENEIEluay9DdXJzb3IgUmVkIENvbG9yIDAgUmVnaXN0ZXIg
Ki8KI2RlZmluZSBTMURSRUdfTENEX0NVUl9CQ1RMMQkJMHgwMDdBCS8qIExDRCBJbmsvQ3Vyc29y
IEJsdWUgQ29sb3IgMSBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MQ0RfQ1VSX0dDVEwxCQkw
eDAwN0IJLyogTENEIEluay9DdXJzb3IgR3JlZW4gQ29sb3IgMSBSZWdpc3RlciAqLwojZGVmaW5l
IFMxRFJFR19MQ0RfQ1VSX1JDVEwxCQkweDAwN0MJLyogTENEIEluay9DdXJzb3IgUmVkIENvbG9y
IDEgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTENEX0NVUl9GSUZPX0hUQwkJMHgwMDdFCS8q
IExDRCBJbmsvQ3Vyc29yIEZJRk8gSGlnaCBUaHJlc2hvbGQgUmVnaXN0ZXIgKi8KI2RlZmluZSBT
MURSRUdfQ1JUX0NVUl9DVEwJCTB4MDA4MAkvKiBDUlQvVFYgSW5rL0N1cnNvciBDb250cm9sIFJl
Z2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9DVVJfU1RBUlQJCTB4MDA4MQkvKiBDUlQvVFYg
SW5rL0N1cnNvciBTdGFydCBBZGRyZXNzIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9D
VVJfWFBPUzAJCTB4MDA4MgkvKiBDUlQvVFYgQ3Vyc29yIFggUG9zaXRpb24gUmVnaXN0ZXIgMCAq
LwojZGVmaW5lIFMxRFJFR19DUlRfQ1VSX1hQT1MxCQkweDAwODMJLyogQ1JUL1RWIEN1cnNvciBY
IFBvc2l0aW9uIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBTMURSRUdfQ1JUX0NVUl9ZUE9TMAkJMHgw
MDg0CS8qIENSVC9UViBDdXJzb3IgWSBQb3NpdGlvbiBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFE
UkVHX0NSVF9DVVJfWVBPUzEJCTB4MDA4NQkvKiBDUlQvVFYgQ3Vyc29yIFkgUG9zaXRpb24gUmVn
aXN0ZXIgMSAqLwojZGVmaW5lIFMxRFJFR19DUlRfQ1VSX0JDVEwwCQkweDAwODYJLyogQ1JUL1RW
IEluay9DdXJzb3IgQmx1ZSBDb2xvciAwIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9D
VVJfR0NUTDAJCTB4MDA4NwkvKiBDUlQvVFYgSW5rL0N1cnNvciBHcmVlbiBDb2xvciAwIFJlZ2lz
dGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9DVVJfUkNUTDAJCTB4MDA4OAkvKiBDUlQvVFYgSW5r
L0N1cnNvciBSZWQgQ29sb3IgMCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19DUlRfQ1VSX0JD
VEwxCQkweDAwOEEJLyogQ1JUL1RWIEluay9DdXJzb3IgQmx1ZSBDb2xvciAxIFJlZ2lzdGVyICov
CiNkZWZpbmUgUzFEUkVHX0NSVF9DVVJfR0NUTDEJCTB4MDA4QgkvKiBDUlQvVFYgSW5rL0N1cnNv
ciBHcmVlbiBDb2xvciAxIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NSVF9DVVJfUkNUTDEJ
CTB4MDA4QwkvKiBDUlQvVFYgSW5rL0N1cnNvciBSZWQgQ29sb3IgMSBSZWdpc3RlciAqLwojZGVm
aW5lIFMxRFJFR19DUlRfQ1VSX0ZJRk9fSFRDCQkweDAwOEUJLyogQ1JUL1RWIEluay9DdXJzb3Ig
RklGTyBIaWdoIFRocmVzaG9sZCBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19CQkxUX0NUTDAJ
CTB4MDEwMAkvKiBCaXRCTFQgQ29udHJvbCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0JC
TFRfQ1RMMQkJMHgwMTAxCS8qIEJpdEJMVCBDb250cm9sIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBT
MURSRUdfQkJMVF9DQ19FWFAJCTB4MDEwMgkvKiBCaXRCTFQgQ29kZS9Db2xvciBFeHBhbnNpb24g
UmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQkJMVF9PUAkJCTB4MDEwMwkvKiBCaXRCTFQgT3Bl
cmF0aW9uIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0JCTFRfU1JDX1NUQVJUMAkJMHgwMTA0
CS8qIEJpdEJMVCBTb3VyY2UgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFE
UkVHX0JCTFRfU1JDX1NUQVJUMQkJMHgwMTA1CS8qIEJpdEJMVCBTb3VyY2UgU3RhcnQgQWRkcmVz
cyBSZWdpc3RlciAxICovCiNkZWZpbmUgUzFEUkVHX0JCTFRfU1JDX1NUQVJUMgkJMHgwMTA2CS8q
IEJpdEJMVCBTb3VyY2UgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAyICovCiNkZWZpbmUgUzFEUkVH
X0JCTFRfRFNUX1NUQVJUMAkJMHgwMTA4CS8qIEJpdEJMVCBEZXN0aW5hdGlvbiBTdGFydCBBZGRy
ZXNzIFJlZ2lzdGVyIDAgKi8KI2RlZmluZSBTMURSRUdfQkJMVF9EU1RfU1RBUlQxCQkweDAxMDkJ
LyogQml0QkxUIERlc3RpbmF0aW9uIFN0YXJ0IEFkZHJlc3MgUmVnaXN0ZXIgMSAqLwojZGVmaW5l
IFMxRFJFR19CQkxUX0RTVF9TVEFSVDIJCTB4MDEwQQkvKiBCaXRCTFQgRGVzdGluYXRpb24gU3Rh
cnQgQWRkcmVzcyBSZWdpc3RlciAyICovCiNkZWZpbmUgUzFEUkVHX0JCTFRfTUVNX09GRjAJCTB4
MDEwQwkvKiBCaXRCTFQgTWVtb3J5IEFkZHJlc3MgT2Zmc2V0IFJlZ2lzdGVyIDAgKi8KI2RlZmlu
ZSBTMURSRUdfQkJMVF9NRU1fT0ZGMQkJMHgwMTBECS8qIEJpdEJMVCBNZW1vcnkgQWRkcmVzcyBP
ZmZzZXQgUmVnaXN0ZXIgMSAqLwojZGVmaW5lIFMxRFJFR19CQkxUX1dJRFRIMAkJMHgwMTEwCS8q
IEJpdEJMVCBXaWR0aCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0JCTFRfV0lEVEgxCQkw
eDAxMTEJLyogQml0QkxUIFdpZHRoIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBTMURSRUdfQkJMVF9I
RUlHSFQwCQkweDAxMTIJLyogQml0QkxUIEhlaWdodCBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFE
UkVHX0JCTFRfSEVJR0hUMQkJMHgwMTEzCS8qIEJpdEJMVCBIZWlnaHQgUmVnaXN0ZXIgMSAqLwoj
ZGVmaW5lIFMxRFJFR19CQkxUX0JHQzAJCTB4MDExNAkvKiBCaXRCTFQgQmFja2dyb3VuZCBDb2xv
ciBSZWdpc3RlciAwICovCiNkZWZpbmUgUzFEUkVHX0JCTFRfQkdDMQkJMHgwMTE1CS8qIEJpdEJM
VCBCYWNrZ3JvdW5kIENvbG9yIFJlZ2lzdGVyIDEgKi8KI2RlZmluZSBTMURSRUdfQkJMVF9GR0Mw
CQkweDAxMTgJLyogQml0QkxUIEZvcmVncm91bmQgQ29sb3IgUmVnaXN0ZXIgMCAqLwojZGVmaW5l
IFMxRFJFR19CQkxUX0ZHQzEJCTB4MDExOQkvKiBCaXRCTFQgRm9yZWdyb3VuZCBDb2xvciBSZWdp
c3RlciAxICovCiNkZWZpbmUgUzFEUkVHX0xLVVBfTU9ERQkJMHgwMUUwCS8qIExvb2stVXAgVGFi
bGUgTW9kZSBSZWdpc3RlciAqLwojZGVmaW5lIFMxRFJFR19MS1VQX0FERFIJCTB4MDFFMgkvKiBM
b29rLVVwIFRhYmxlIEFkZHJlc3MgUmVnaXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfTEtVUF9EQVRB
CQkweDAxRTQJLyogTG9vay1VcCBUYWJsZSBEYXRhIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVH
X1BTX0NORgkJCTB4MDFGMAkvKiBQb3dlciBTYXZlIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKi8K
I2RlZmluZSBTMURSRUdfUFNfU1RBVFVTCQkweDAxRjEJLyogUG93ZXIgU2F2ZSBTdGF0dXMgUmVn
aXN0ZXIgKi8KI2RlZmluZSBTMURSRUdfQ1BVMk1FTV9XRE9HVAkJMHgwMUY0CS8qIENQVS10by1N
ZW1vcnkgQWNjZXNzIFdhdGNoZG9nIFRpbWVyIFJlZ2lzdGVyICovCiNkZWZpbmUgUzFEUkVHX0NP
TV9ESVNQX01PREUJCTB4MDFGQwkvKiBDb21tb24gRGlzcGxheSBNb2RlIFJlZ2lzdGVyICovCgoj
ZGVmaW5lIFMxRFJFR19ERUxBWU9GRgkJCTB4RkZGRQojZGVmaW5lIFMxRFJFR19ERUxBWU9OCQkJ
MHhGRkZGCgovKiBOb3RlOiBhbGwgYWJvdmUgZGVmaW5lcyBzaG91bGQgZ28gaW4gc2VwYXJhdGUg
aGVhZGVyIGZpbGVzCiAgIHdoZW4gaW1wbGVtZW50aW5nIG90aGVyIFMxRDEzeHh4IGNoaXAgc3Vw
cG9ydC4gKi8KCnN0cnVjdCBzMWQxM3h4eGZiX3JlZ3ZhbCB7CgkvL3UxNglhZGRyOwoJLy91OAl2
YWx1ZTsKCXU4CWFkZHI7Cgl1MzIgICAgIHZhbHVlOwp9OwoKCnN0cnVjdCBzMWQxM3h4eGZiX3Bh
ciB7Cgl2b2lkIF9faW9tZW0JKnJlZ3M7Cgl1bnNpZ25lZCBjaGFyCWRpc3BsYXk7CgoJdW5zaWdu
ZWQgaW50CXBzZXVkb19wYWxldHRlWzE2XTsKI2lmZGVmIENPTkZJR19QTQoJdm9pZAkJKnJlZ3Nf
c2F2ZTsJLyogcG0gc2F2ZXMgYWxsIHJlZ2lzdGVycyBoZXJlICovCgl2b2lkCQkqZGlzcF9zYXZl
OwkvKiBwbSBzYXZlcyBlbnRpcmUgc2NyZWVuIGhlcmUgKi8KI2VuZGlmCn07CgpzdHJ1Y3QgczFk
MTN4eHhmYl9wZGF0YSB7Cgljb25zdCBzdHJ1Y3QgczFkMTN4eHhmYl9yZWd2YWwJKmluaXRyZWdz
OwoJY29uc3QgdW5zaWduZWQgaW50CQlpbml0cmVnc3NpemU7Cgl2b2lkCQkJCSgqcGxhdGZvcm1f
aW5pdF92aWRlbykodm9pZCk7CiNpZmRlZiBDT05GSUdfUE0KCWludAkJCQkoKnBsYXRmb3JtX3N1
c3BlbmRfdmlkZW8pKHZvaWQpOwoJaW50CQkJCSgqcGxhdGZvcm1fcmVzdW1lX3ZpZGVvKSh2b2lk
KTsKI2VuZGlmCn07CgojZW5kaWYKCg==
------=_20081111095047_31099
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
------=_20081111095047_31099
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------=_20081111095047_31099--

From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10.1/12] viafb: Framebuffer
	driver	for VIA UniChrome/Chrome9 HC (fwd)
Date: Tue, 01 May 2007 19:57:04 +0800
Message-ID: <1178020624.4372.55.camel@daplas>
References: <Pine.LNX.4.64.0704301037450.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hiqys-000629-3U for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 04:57:18 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hiqyr-0002rD-0e
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 04:57:18 -0700
Received: by py-out-1112.google.com with SMTP id a29so1550842pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 May 2007 04:57:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704301037450.27246@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: EddyFu <EddyFu@via.com.tw>

On Mon, 2007-04-30 at 10:37 +0200, Geert Uytterhoeven wrote:

This is a pretty big patch and it's quite hard to review, so here's a
preliminary one:

Most importantly, I want a Signed-off-by: line, especially since the
copyright holder is VIA and S3. You can do it yourself, if you're
allowed to, since your email address comes from via.

Please read the following docs in under linux/Documentation, especially
links within these documents on how to properly submit patches and
drivers:

HOWTO
SubmittingDrivers
SubmittingPatches
CodingStyle

I'm going to hold off on technical comments once you submitted a trimmed
driver. And when you are submitting a series of patch, please divide
them in logical chunks. 

Tony

> ---------- Forwarded message ----------
> Date: Mon, 30 Apr 2007 13:20:48 +0800
> From: EddyFu@via.com.tw
> To: linux-fbdev-devel-bounces@lists.sourceforge.net
> Subject: [Linux-fbdev-devel] [PATCH 10.1/12] viafb: Framebuffer driver for VIA
>     UniChrome/Chrome9 HC
> 
> Dear All, 
>  
> Here is the part 10.1/12 of viafb.
>  
> Best Regards,
> Eddy Fu 
>  
> diff -Nur linux-2.6.21-rc7/drivers/video/via/viafbdev.c linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.c
> --- linux-2.6.21-rc7/drivers/video/via/viafbdev.c 1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.c 2007-04-26 19:52:32.000000000 -0400
> @@ -0,0 +1,4917 @@
> +/*
> + * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sub license,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> + * DEALINGS IN THE SOFTWARE.
> + */

As mentioned, I would want an explicit statement about
GPL-compatibility. Better yet, dual-license the code.  Because even if
the above is X-MIT and is GPL-compatible, once this get into the kernel,
it automatically becomes GPL.

> +#include <linux/version.h>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)

Please remove all code that pertains to old kernel versions.  It's
unnecessary, and I won't backport it to old kernels.  Only include code
for the latest kernel version and you'll be able to drastically reduce
the size of the driver.

[snip]

> +extern void tv_get_support_standard(u32* support_state);
> +extern void tv_get_support_signal(u32* support_state);
> +extern int tv_get_max_size(void);
> +extern void tv_get_support_tuning_state(u32* support_state);
> +extern void tv_get_tuning_max_value(u32 item, u32* value);
> +extern void tv_get_support_setting_state(u32* support_state);
> +extern int check_macrovision_enabled(void);
> +extern void get_fb_info(unsigned int *fb_base, unsigned int *fb_len);

All extern's must be declared in a separate header file.

[snip]

> +
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
> +static int
> +viafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
> +{
> +    /* Modified for dual-fb. */
> +    struct viafb_par *ppar;

Don't use spaces for indentation, use 8-column tabs.

[snip]

> +
> +static int viafb_check_var(struct fb_var_screeninfo *var,
> +                           struct fb_info *info)
> +{
> +    int vres,vfront,vback,vsync;
> +    int vmode_index;
> +    /* Modified for dual-fb according. */
> +    struct viafb_par *ppar;
> +    ppar = info->par;
> +
> +    DEBUG_MSG(KERN_INFO "viafb_check_var!\n");
> +    vmode_index = get_mode_index(var->xres, var->yres,0);
> +    if (vmode_index == VIA_RES_INVALID)
> +    {

CodingStyle: The move the curly braces up one line, ie:

	if (vmode_index == VIA_RES_INVALID) {

> +        DEBUG_MSG(KERN_INFO "viafb: Mode %dx%dx%d not supported!!\n", var->xres, var->yres, var->bits_per_pixel);
> +        return -EINVAL;
> +    }
> +    /* convert from picoseconds to MHz */
> +    refresh = get_refresh(var->xres, var->yres, var->pixclock);
> +    if(24 == var->bits_per_pixel)
> +    {
> +        var->bits_per_pixel = 32;
> +    }
> +    if((var->xres_virtual * (var->bits_per_pixel>> 3)) & 0x1F)/* Is 32 bytes alignment? */
> +    {
> +        var->xres_virtual = (var->xres_virtual + 31) & ~31;/* 32 pixel alignment */
> +    }
> +    
> +    /* Fill var's time information according our table, or fbset will show wrong information */
> +    fill_var_timing_info(var, refresh, vmode_index);
> +    
> +    ppar->var = *var;
> +    ppar->bpp = var->bits_per_pixel;
> +
> +    if (ppar->bpp == 24)
> +        ppar->bpp = 32;
> +
> +    ppar->linelength = ((var->xres_virtual + 7) & ~7) * ppar->bpp/8;
> +
> +    switch (ppar->bpp) {
> +        case 8:
> +            ppar->var.red.offset = 0;

CodingStyle: the case statement must be in the same column as the switch
statement, ie:

	switch (ppar->bpp) {
	case 8:
		ppar->var.red.offset = 0;

> +            ppar->var.green.offset = 0;
> +            ppar->var.blue.offset = 0;
> +            ppar->var.red.length = 6;
> +            ppar->var.green.length = 6;
> +            ppar->var.blue.length = 6;
> +            break;
> +        case 16:
> +            ppar->var.red.offset = 11;
> +            ppar->var.green.offset = 5;
> +            ppar->var.blue.offset = 0;
> +            ppar->var.red.length = 5;
> +            ppar->var.green.length = 6;
> +            ppar->var.blue.length = 5;
> +            break;
> +        case 32:
> +            ppar->var.red.offset = 16;
> +            ppar->var.green.offset = 8;
> +            ppar->var.blue.offset = 0;
> +            ppar->var.red.length = 8;
> +            ppar->var.green.length = 8;
> +            ppar->var.blue.length = 8;
> +            break;
> +        default:
> +            return -EINVAL;
> +    }
> +
> +    ppar->vclk = 1000000/var->pixclock;
> +
> +    if (ppar->bpp == 32)
> +        ppar->vclk *=2;
> +
> +    ppar->hres = var->xres;
> +    vres = ppar->vres = var->yres;
> +
> +    /* See if requested resolution fits in available memory */
> +    if (ppar->hres * ppar->vres * ppar->bpp/8 > ppar->memsize) {
> +        return -EINVAL;
> +    }

CodingStyle: No need for curly braces if only a single statement is
enclosed, ie:

	if (ppar->hres *ppar->vyres...etc)
		return -EINVAL;

> +
> +    vfront = var->upper_margin;
> +    vback = var->lower_margin;
> +    vsync = var->vsync_len;
> +
> +    /* Compute horizontal and vertical VGA CRTC timing values */
> +    if (var->vmode & FB_VMODE_INTERLACED) {
> +        vres /= 2;
> +        vfront /=2;
> +        vback /=2;
> +        vsync /=2;
> +    }
> +
> +    if (var->vmode & FB_VMODE_DOUBLE) {
> +        vres *= 2;
> +        vfront *=2;
> +        vback *=2;
> +        vsync *=2;
> +    }
> +
> +    ppar->htotal = (ppar->hres + var->left_margin + var->right_margin + var->hsync_len)/8 - 10;

CodingStyle: Limit lines to 80-columns.  For excessively long
statements, break them into chunks.

[snip]

> +
> +static int viafb_pan_display(struct fb_var_screeninfo *var,
> +                 struct fb_info *info)
> +{
> +    unsigned int offset=0;
> +    DEBUG_MSG(KERN_INFO "viafb_pan_display!\n");
> +
> + if(var->xoffset > (var->xres_virtual - var->xres)) {
> +  return -EINVAL;
> + }
> + if(var->yoffset > (var->yres_virtual - var->yres)) {
> +  return -EINVAL;
> + }
> +
> + if(var->vmode & FB_VMODE_YWRAP) return -EINVAL;
> +

No need for the above checks, they're already done by the upper layer.

> + if(var->xoffset + info->var.xres > info->var.xres_virtual ||
> +    var->yoffset + info->var.yres > info->var.yres_virtual) {
> +  return -EINVAL;
> + }
> +        /* begin add by zepeng for zerocopy mode ,switch on screen */
> +        offset = (var->xoffset + (var->yoffset * var->xres)) * var->bits_per_pixel/16;
> +   
> +        DEBUG_MSG(KERN_INFO "\nviafb_pan_display,offset =%d ",offset);
> +
> +        write_reg_mask(0x48,0x3d4,((offset>>24) & 0x3),0x3);
> +        write_reg_mask(0x34,0x3d4,((offset>>16) & 0xff),0xff);
> +        write_reg_mask(0x0c,0x3d4,((offset>>8) & 0xff),0xff);
> +        write_reg_mask(0x0d,0x3d4,(offset & 0xff),0xff);
> +
> +    ((struct viafb_par *)(info->par))->var.xoffset = var->xoffset;
> +    ((struct viafb_par *)(info->par))->var.yoffset = var->yoffset;
> +    return 0;
> +}
> +
> +static int viafb_blank(int blank_mode, struct fb_info *info)
> +{
> +    DEBUG_MSG(KERN_INFO "viafb_blank!\n" );
> +    /* clear DPMS setting */
> +    switch (blank_mode) {
> +    case VESA_NO_BLANKING:

Use FB_BLANK_* instead of VESA_* as defined in include/linux/fb.h

> +        /* Screen: On, HSync: On, VSync: On */
> +        write_reg_mask(CR36, VIACR, 0x00, BIT4+BIT5);   /* control CRT monitor power management */
> +        break;
> +    case VESA_HSYNC_SUSPEND:
> +        /* Screen: Off, HSync: Off, VSync: On */
> +        write_reg_mask(CR36, VIACR, 0x10, BIT4+BIT5);   /* control CRT monitor power management */
> +        break;
> +    case VESA_VSYNC_SUSPEND:
> +        /* Screen: Off, HSync: On, VSync: Off */
> +        write_reg_mask(CR36, VIACR, 0x20, BIT4+BIT5);   /* control CRT monitor power management */
> +        break;
> +    case VESA_POWERDOWN:
> +        /* Screen: Off, HSync: Off, VSync: Off */
> +        write_reg_mask(CR36, VIACR, 0x30, BIT4+BIT5);   /* control CRT monitor power management */
> +        break;
> +        }
> +    return 0;
> +}
> +
> +/* Under FC5 and kernel after 2.6.16, the fb_ioctl's prototype is changed,*/
> +#if defined FC5_2_6_15 || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,16))
> +static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
> +#else
> +static int viafb_ioctl(struct inode *inode, struct file *file, u_int cmd,
> +               u_long arg, struct fb_info *info)
> +#endif
> +{
> +    struct viafb_ioctl_info viainfo;
> +    struct viafb_ioctl_mode viamode;
> +    struct viafb_ioctl_samm viasamm;
> +    struct viafb_driver_version driver_version;
> +    struct fb_var_screeninfo sec_var;
> +    /* Only for case "SET_DEVICE_INFO" and "GET_DEVICE_INFO" */
> +    struct viafb_ioctl_setting viafb_setting;  
> +    u32 state_info = 0;
> +    u32 item_info =0;
> +    u32 viafb_gamma_table[256];
> +    char driver_name[10]="viafb\0"; /* for driver name use */
> +    POSITIONVALUE view_size, view_pos;
> +
> +    u32 __user  *argp = (u32 __user *)arg;
> +    u32         gpu32 = 0,ss;
> +    device_t active_dev;
> +    u32 video_dev_info = 0;
> +    ss = sizeof(active_dev);
> +    memset(&viafb_setting,0,sizeof(viafb_setting));
> +    memset(&active_dev,0,ss);
> +
> +    DEBUG_MSG(KERN_INFO "viafb_ioctl: 0x%X !!\n", cmd);
> +    switch (cmd) 
> +    {
> +        case VIAFB_GET_CHIP_INFO: /* struct chip_information        chip_info ; */
> +            if(copy_to_user((void __user *)arg, &chip_info, sizeof(chip_info)))
> +                return -EFAULT;
> +            break;    
> +        case VIAFB_GET_INFO_SIZE:
> +            return put_user(sizeof(viainfo), argp);
> +        case VIAFB_GET_INFO:
> +            return ioctl_get_viafb_info(arg);
> +        case VIAFB_HOTPLUG:
> +            return put_user((u32)ioctl_hotplug(info->var.xres, info->var.yres, info->var.bits_per_pixel), argp);
> +            break;
> +        case VIAFB_SET_HOTPLUG_FLAG:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            HotPlug = (gpu32) ? 1 : 0;
> +            break;
> +        case VIAFB_GET_RESOLUTION:
> +            viamode.xres = (u32)HotPlug_Xres;
> +            viamode.yres = (u32)HotPlug_Yres;
> +            viamode.refresh = (u32)HotPlug_refresh;
> +            viamode.bpp = (u32)HotPlug_bpp;
> +            if(SAMM_ON==1){
> +                viamode.xres_sec=second_xres;
> +                viamode.yres_sec=second_yres;
> +                viamode.virtual_xres_sec = second_virtual_xres;
> +                viamode.virtual_yres_sec = second_virtual_yres;
> +                viamode.refresh_sec=refresh1;
> +                viamode.bpp_sec=bpp1;
> +            }else{
> +                viamode.xres_sec=0;
> +                viamode.yres_sec=0;
> +                viamode.virtual_xres_sec = 0;
> +                viamode.virtual_yres_sec = 0;
> +                viamode.refresh_sec=0;
> +                viamode.bpp_sec=0;
> +            }
> +            if(copy_to_user((void __user *)arg, &viamode, sizeof(viamode))) {
> +                return -EFAULT;
> +            }
> +            break;
> +        case VIAFB_GET_TV_TYPE:
> +            return ioctl_get_tv_type(arg);
> +        case VIAFB_GET_SAMM_INFO:
> +            viasamm.samm_status= SAMM_ON;
> +            if(SAMM_ON==1) {
> +                if(dual_fb) 
> +                {
> +                    viasamm.size_prim = parinfo.fbmem_free;
> +                    viasamm.size_sec = parinfo1.fbmem_free;
> +                }
> +                else 
> +                {
> +                    if(second_size)
> +                    {
> +                        viasamm.size_prim = parinfo.memsize - second_size*1024*1024;
> +                        if(accel)
> +                            viasamm.size_sec=second_size*1024*1024 - parinfo.fbmem_used;
> +                        else
> +                            viasamm.size_sec=second_size*1024*1024;
> +                    }
> +                    else
> +                    {
> +                        viasamm.size_prim=parinfo.memsize>>1;
> +                        if(accel)
> +                            viasamm.size_sec=(parinfo.memsize>>1) - parinfo.fbmem_used;
> +                        else
> +                            viasamm.size_sec=parinfo.memsize>>1;
> +                    }
> +                }
> +                viasamm.mem_base=parinfo.fbmem;
> +                viasamm.offset_sec=second_offset;
> +            }else{
> +                viasamm.size_prim=parinfo.memsize;
> +                viasamm.size_sec=0;
> +                viasamm.mem_base=parinfo.fbmem;
> +                viasamm.offset_sec=0;
> +            }
> +           
> +            if(copy_to_user((void __user *)arg, &viasamm, sizeof(viasamm))) 
> +                return -EFAULT;
> +
> +            break;
> +        case VIAFB_TURN_ON_OUTPUT_DEVICE:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            if (gpu32 & CRT_Device)
> +                crt_enable();
> +            if (gpu32 & DVI_Device)
> +                dvi_enable();
> +            if (gpu32 & TV_Device)
> +                tv_enable();
> +            if (gpu32 & LCD_Device)
> +                lcd_enable();
> +            break;
> +        case VIAFB_TURN_OFF_OUTPUT_DEVICE:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            if (gpu32 & CRT_Device)
> +                crt_disable();
> +            if (gpu32 & DVI_Device)
> +                dvi_disable();
> +            if (gpu32 & TV_Device)
> +                tv_disable();
> +            if (gpu32 & LCD_Device)
> +                lcd_disable();
> +            break;
> +        case VIAFB_SET_DEVICE:
> +            if (copy_from_user(&active_dev, (void *)argp,ss))
> +            {
> +                return -EFAULT;
> +            }
> +            if(check_macrovision_enabled() && (active_dev.tv != TV_ON || TV_ON))
> +                break;
> +            viafb_set_device(active_dev);
> +            viafb_set_par(info);
> +            break;
> +        case VIAFB_GET_DEVICE:
> +            active_dev.crt = CRT_ON;
> +            active_dev.dvi = DVI_ON;
> +            active_dev.tv = TV_ON;
> +            active_dev.lcd = LCD_ON;
> +            active_dev.samm = SAMM_ON;
> +            active_dev.primary_dev = primary_dev;
> +
> +            active_dev.tv_system = tv_system;
> +            active_dev.tv_level = tv_level;
> +            active_dev.tv_out_sig = tv_out_signal;
> +            active_dev.tv_dedotcrawl = tv_dedotcrawl;
> +
> +            active_dev.lcd_dsp_cent = lcd_dsp_method; 
> +            active_dev.lcd_panel_id = lcd_panel_id;
> +            active_dev.lcd_mode = lcd_mode;
> +
> +            active_dev.xres = HotPlug_Xres;
> +            active_dev.yres = HotPlug_Yres;
> +
> +            active_dev.xres1 = second_xres;
> +            active_dev.yres1 = second_yres;
> +      
> +            active_dev.bpp = bpp;
> +            active_dev.bpp1 = bpp1;
> +            active_dev.refresh = refresh;
> +            active_dev.refresh1 = refresh1;
> +            
> +            active_dev.epia_dvi=EPIA_DVI;
> +            active_dev.lcd_dual_edge=LCDDualEdge;
> +            active_dev.bus_width=BusWidth;
> +
> +            if(copy_to_user((void __user *)arg, &active_dev,ss)) 
> +                return -EFAULT;
> +            break;
> +        case VIAFB_SET_TV_FFILTER:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            tv_set_ffilter(STATE_ON, gpu32);
> +            break;
> +        case VIAFB_SET_TV_COLOR_DEFAULT:
> +        {
> +            u32 def_val[4];
> +            tv_set_brightness(tv_setting_info.DefaultBrightness);
> +            tv_set_contrast(tv_setting_info.DefaultContrast);
> +            tv_set_saturation(tv_setting_info.DefaultSaturation);
> +            tv_set_tint(tv_setting_info.DefaultTINT);
> +            def_val[0] = tv_setting_info.DefaultBrightness;
> +            def_val[1] = tv_setting_info.DefaultContrast;
> +            def_val[2] = tv_setting_info.DefaultSaturation;
> +            def_val[3] = tv_setting_info.DefaultTINT;
> +            if(copy_to_user((void __user *)arg, &def_val, sizeof(u32)*4)) 
> +                return -EFAULT;
> +            break;
> +        }
> +        case VIAFB_SET_TV_BRIGHTNESS:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            tv_set_brightness(gpu32);
> +            break;
> +        case VIAFB_SET_TV_CONTRAST:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            tv_set_contrast(gpu32);
> +            break;
> +        case VIAFB_SET_TV_SATURATION:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            tv_set_saturation(gpu32);
> +            break;
> +        case VIAFB_SET_TV_TINT:
> +            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
> +                return -EFAULT;
> +            }
> +            tv_set_tint(gpu32);
> +            break;
> +
> +        /* Add for getting driver version. */
> +        case VIAFB_GET_DRIVER_VERSION:
> +            driver_version.iMajorNum = VERSION_MAJOR;            
> +            driver_version.iKernelNum = VERSION_KERNEL;
> +            driver_version.iOSNum = VERSION_OS;
> +            driver_version.iMinorNum = VERSION_MINOR;
> +            
> +            if(copy_to_user((void __user *)arg, &driver_version, sizeof(driver_version)))
> +            {
> +                return -EFAULT;
> +            }
> +            break;
> +
> +        /* Set and apply CRT,DVI,LCD,TV's setting info. */
> +        case VIAFB_SET_DEVICE_INFO:
> +            if(copy_from_user(&viafb_setting, (void *)argp,sizeof(viafb_setting)))
> +            {
> +                return -EFAULT;
> +            }
> +            if(check_macrovision_enabled() && (((viafb_setting.device_status & TV_Device)>> 2) != TV_ON || TV_ON))
> +                break;
> +            if(apply_device_setting(viafb_setting, info)<0)
> +            {
> +                return -EINVAL;
> +            }           
> +            break;
> +
> +        case VIAFB_SET_SECOND_MODE:
> +             if(copy_from_user(&sec_var, (void *)argp,sizeof(sec_var)))
> +            {
> +                return -EFAULT;
> +            }
> +            apply_second_mode_setting(&sec_var);
> +            break;
> +        
> +        /*  Get current VIA framebuffer device setting info. */
> +        case VIAFB_GET_DEVICE_INFO:
> +
> +            retrieve_device_setting(&viafb_setting);
> +
> +            if(copy_to_user((void __user *)arg, &viafb_setting, sizeof(viafb_setting)))
> +            {
> +               return -EFAULT;
> +            }
> +            break;
> +
> +        case VIAFB_GET_DEVICE_SUPPORT:
> +            get_device_support_state(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_DEVICE_CONNECT:
> +            get_device_connect_state(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_PANEL_SUPPORT_EXPAND:
> +            state_info = lcd_get_support_expand_state(info->var.xres, info->var.yres);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_SUPPORT_SIGNAL:
> +            tv_get_support_signal(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_SUPPORT_STANDARD:
> +            tv_get_support_standard(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_MAX_SIZE:
> +            state_info = tv_get_max_size();
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_MAX_POSITION:
> +            if (put_user(TV_HOR_POSITION_MAXIMUM, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_SUPPORT_TUNING_ITEM:
> +            tv_get_support_tuning_state(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +            
> +        case VIAFB_GET_TV_MAX_TUNING_VALUE:
> +            get_user(item_info, argp);
> +            tv_get_tuning_max_value(item_info, &state_info);
> +            put_user(state_info, argp);
> +            break;
> +            
> +        case VIAFB_GET_TV_SUPPORT_SETTING_ITEM:
> +            tv_get_support_setting_state(&state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +
> +        /* Add for setting TV position. */
> +        case VIAFB_SET_TV_POSITION:
> +            if(copy_from_user(&view_pos, (void *)argp, sizeof(POSITIONVALUE)))
> +            {
> +                return -EFAULT;
> +            }
> +
> +            tv_set_position(view_pos.dwX, view_pos.dwY);
> +            break;
> +
> +        /* Add for setting TV size. */
> +        case VIAFB_SET_TV_SIZE:
> +            if(copy_from_user(&view_size, (void *)argp, sizeof(POSITIONVALUE)))
> +            {
> +                return -EFAULT;
> +            }
> +            tv_set_size(view_size.dwX, view_size.dwY);
> +            break;
> +            
> +        case VIAFB_GET_DRIVER_NAME:
> +            if(copy_to_user((void __user *)arg, driver_name, sizeof(driver_name)))
> +            {
> +                return -EFAULT;
> +            }
> +            break;
> +            
> +        case VIAFB_SET_GAMMA_LUT:
> +            if(copy_from_user(viafb_gamma_table, argp, sizeof(viafb_gamma_table)))
> +            {
> +                return -EFAULT;
> +            }
> +            set_gamma_table(bpp, viafb_gamma_table);            
> +            break;
> +            
> +        case VIAFB_GET_GAMMA_LUT:
> +            get_gamma_table(viafb_gamma_table);
> +            if(copy_to_user((void __user *)arg, viafb_gamma_table, sizeof(viafb_gamma_table)))
> +            {
> +                return -EFAULT;
> +            }
> +            break;
> +            
> +        case VIAFB_GET_GAMMA_SUPPORT_STATE:
> +            get_gamma_support_state(bpp, &state_info);
> +            if (put_user(state_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +        case VIAFB_SET_VIDEO_DEVICE:
> +            get_user(video_dev_info, argp);
> +            viafb_set_video_device(video_dev_info);
> +            break;
> +        case VIAFB_GET_VIDEO_DEVICE:
> +            viafb_get_video_device(&video_dev_info);
> +            if (put_user(video_dev_info, argp))
> +            {
> +               return -EFAULT; 
> +            }
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +

Are all these ioctls necessary?

[snip]

> +        } else if (hres==1400 && vres==1050) {
> +            resMode = VIA_RES_1400X1050;
> +            mode1 = "1400x1050";
> +        } else if (hres==720 && vres==480) {
> +            resMode = VIA_RES_720X480;
> +            mode1 = "720x480";
> +        } else if (hres==720 && vres==576) {
> +            resMode = VIA_RES_720X576;
> +            mode1 = "720x576";
> +        } else if (hres==1024 && vres==512) {
> +            resMode = VIA_RES_1024X512;
> +            mode1 = "1024x512";
> +        } else if (hres==856 && vres==480) {
> +            resMode = VIA_RES_856X480;
> +            mode1 = "856x480";
> +        } else if (hres==1024 && vres==576) {
> +            resMode = VIA_RES_1024X576;
> +            mode1 = "1024x576";            
> +        } else if (hres==1024 && vres==600){
> +         resMode = VIA_RES_1024X600; 
> +            mode1 = "1024x600";
> +        } else if (hres==1280 && vres==720) {
> +            resMode = VIA_RES_1280X720;
> +            mode1 = "1280x720";
> +         } else if (hres==1920 && vres==1080) {
> +            resMode = VIA_RES_1920X1080;
> +            mode1 = "1920x1080";
> +        } else if (hres==1366 && vres==768){
> +          resMode = VIA_RES_1368X768; 
> +            mode1 = "1368x768";
> +      }else {
> +            resMode = VIA_RES_INVALID;
> +            mode1 = "640x480";
> +        }
> +    }
> +    return(resMode);
> +}
> 

Where is the rest of the patch?

Tony
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

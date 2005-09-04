From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/2] ARM S3C2410 framebuffer driver
Date: Sun, 04 Sep 2005 23:50:21 +0800
Message-ID: <431B17BD.4090209@gmail.com>
References: <8564th6srr.fsf@Orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBwn4-0004UN-Ds
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 08:52:18 -0700
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EBwn0-0001F7-PR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 08:52:18 -0700
Received: by zproxy.gmail.com with SMTP id 9so529747nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 Sep 2005 08:52:08 -0700 (PDT)
In-Reply-To: <8564th6srr.fsf@Orfeo.duckcorp.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

Arnaud Patard (Rtp) wrote:
> Hi,
> 
> This set of two patches add support for the framebuffer of the Samsung
> S3C2410 ARM SoC. This driver was started about one year ago and is now
> used on iPAQ h1930/h1940, Acer n30 and probably other s3c2410-based
> machines I'm not aware of. I've also heard yesterday that it's working also
> on iPAQ rx3715/rx3115 (s3c2440-based machines).
> 
> Theses patches are against current linux-2.6 git tree.
> The first one add the driver by itself along with Kconfig, Makefile and
> some headers. The second one add the plateform specific stuff needed to
> configure and use the driver.
> 

Do the ARM people know about this driver?

> Regards,
> Arnaud Patard
> 
> 
> Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
> 

<snip>

> +
> +static inline struct s3c2410fb_info *fb_to_s3cfb(struct fb_info *info)
> +{
> +	return container_of(info, struct s3c2410fb_info, fb);
> +}
> +

Instead of the private structure containing struct fb_info,
any reason why the private data can't be placed in fb_info->par?...
 
> + *	s3c2410fb_check_var():
> + *	Get the video params out of 'var'. If a value doesn't fit, round it up,
> + *	if it's too big, return -EINVAL.
> + *
> + */
> +static int s3c2410fb_check_var(struct fb_var_screeninfo *var,
> +			       struct fb_info *info)
> +{
> +	struct s3c2410fb_info *fbi = fb_to_s3cfb(info);
> +

... and do it like this instead:

struct s3c2410fb_info *fbi = info->par;

> +
> +	if (var->bits_per_pixel == 16) {
> +		var->red.offset		= 11;
> +		var->green.offset	= 5;
> +		var->blue.offset	= 0;
> +		var->red.length		= 5;
> +		var->green.length	= 6;
> +		var->blue.length	= 5;
> +		var->transp.length	= 0;
> +	} else {
> +		var->red.length		= 8;
> +		var->red.offset		= 0;
> +		var->green.length	= 0;
> +		var->green.offset	= 8;

swapped green.length and green.offset?
	
> +		var->blue.length	= 8;
> +		var->blue.offset	= 0;
> +		var->transp.length	= 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/* s3c2410fb_activate_var
> + *
> + * activate (set) the controller from the given framebuffer
> + * information
> +*/
> +
> +static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
> +				  struct fb_var_screeninfo *var)
> +{
> +	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
> +
> +	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
> +	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
> +	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
> +
> +	switch (var->bits_per_pixel) {
> +	case 1:
> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT1BPP;
> +		break;
> +	case 2:
> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT2BPP;
> +		break;
> +	case 4:
> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT4BPP;
> +		break;
> +	case 8:
> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT8BPP;
> +		break;
> +	case 16:
> +		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT16BPP;
> +		break;
> +
> +	default:
> +		/* invalid pixel depth */
> +		dev_err(fbi->dev, "invalid bpp %d\n", var->bits_per_pixel);

You won't need to have an error path here if you round up bits_per_pixel
in the check_var(). info->var will always contain a valid var as it would
always go through the driver's check_var().

> +static int s3c2410fb_setcolreg(unsigned regno,
> +			       unsigned red, unsigned green, unsigned blue,
> +			       unsigned transp, struct fb_info *info)
> +{
> +	struct s3c2410fb_info *fbi = (struct s3c2410fb_info *)info;
> +	unsigned int val;
> +
> +	/* dprintk("setcol: regno=%d, rgb=%d,%d,%d\n", regno, red, green, blue); */
> +
> +	switch (fbi->fb.fix.visual) {
> +	case FB_VISUAL_TRUECOLOR:
> +		/* true-colour, use pseuo-palette */
> +
> +		if (regno < 16) {
> +			u32 *pal = fbi->fb.pseudo_palette;
> +
> +			val  = chan_to_field(red,   &fbi->fb.var.red);
> +			val |= chan_to_field(green, &fbi->fb.var.green);
> +			val |= chan_to_field(blue,  &fbi->fb.var.blue);
> +
> +			pal[regno] = val;
> +		}

Missing break statement?
> +
> +	case FB_VISUAL_STATIC_PSEUDOCOLOR:

static pseudocolor does not have a modifiable CLUT. And I don't see
your driver supporting static pseudocolor.

Similarly, truecolor cannot have a modifiable clut, that's why you need
the 'break' above.  If you think your driver can modify the clut at
16 bpp, then advertise the visual as directcolor.
 
The above may seem nitpicking, but it can confuse user apps if the
driver incorrectly advertises its capability.

> +	case FB_VISUAL_PSEUDOCOLOR:
> +		if (regno < 256) {
> +			/* currently assume RGB 5-6-5 mode */
> +
> +			val  = ((red   >>  0) & 0xf800);
> +			val |= ((green >>  5) & 0x07e0);
> +			val |= ((blue  >> 11) & 0x001f);
> +			
> +			writel(val, S3C2410_TFTPAL(regno));
> +			schedule_palette_update(fbi, regno, val);
> +		}
> +
> +		break;
> +
> +	default:
> +		return 1;   /* unknown type */
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/**
> + *	s3c2410fb_pan_display
> + *	@var: frame buffer variable screen structure
> + *	@info: frame buffer structure that represents a single frame buffer
> + *
> + *	Pan (or wrap, depending on the `vmode' field) the display using the
> + *	`xoffset' and `yoffset' fields of the `var' structure.
> + *	If the values don't fit, return -EINVAL.
> + *
> + *	Returns negative errno on error, or zero on success.
> + */
> +static int s3c2410fb_pan_display(struct fb_var_screeninfo *var,
> +			     struct fb_info *info)
> +{
> +	dprintk("pan_display(var=%p, info=%p)\n", var, info);
> +
> +	dprintk("pan_display: xoffset=%d\n", var->xoffset);
> +	dprintk("pan_display: yoffset=%d\n", var->yoffset);
> +
> +	return 0;
> +}

Just comment out pan_display if it's not doing anything. You'll
just confuse apps that do multi-buffering.

> +
> +
> +/* Fake monspecs to fill in fbinfo structure */
> +/* Don't know if the values are important    */

The values in monspecs are important if the driver
uses it. Otherwise, you need not fake a monspecs.

> +int __init s3c2410fb_probe(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct s3c2410fb_hw *mregs;
> +	int ret;
> +	int irq;
> +	int i;
> +
> +	mach_info = dev->platform_data;
> +	if (mach_info == NULL) {
> +		dev_err(dev,"no platform data for lcd, cannot attach\n");
> +		return -EINVAL;
> +	}
> +
> +	mregs = &mach_info->regs;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no irq for device\n");
> +		return -ENOENT;
> +	}
> +	
> +	s3c2410fb_init_registers(&info);
> +	
> +	dprintk("devinit\n");
> +
> +	strcpy(info.fb.fix.id, driver_name);
> +
> +	memcpy(&info.regs, &mach_info->regs, sizeof(info.regs));
> +
> +	info.mach_info		    = dev->platform_data;
> +
> +	info.fb.fix.type	    = FB_TYPE_PACKED_PIXELS;
> +	info.fb.fix.type_aux	    = 0;
> +	info.fb.fix.xpanstep	    = 0;
> +	info.fb.fix.ypanstep	    = 0;
> +	info.fb.fix.ywrapstep	    = 0;
> +	info.fb.fix.accel	    = FB_ACCEL_NONE;
> +
> +	info.fb.var.nonstd	    = 0;
> +	info.fb.var.activate	    = FB_ACTIVATE_NOW;
> +	info.fb.var.height	    = mach_info->height;
> +	info.fb.var.width	    = mach_info->width;
> +	info.fb.var.accel_flags     = 0;
> +	info.fb.var.vmode	    = FB_VMODE_NONINTERLACED;
> +
> +	info.fb.fbops		    = &s3c2410fb_ops;
> +	info.fb.flags		    = FBINFO_FLAG_DEFAULT;
> +	info.fb.monspecs	    = monspecs;
> +	info.fb.pseudo_palette      = &info.pseudo_pal;
> +
> +	info.fb.var.xres	    = mach_info->xres.defval;
> +	info.fb.var.xres_virtual    = mach_info->xres.defval;
> +	info.fb.var.yres	    = mach_info->yres.defval;
> +	info.fb.var.yres_virtual    = mach_info->yres.defval;
> +	info.fb.var.bits_per_pixel  = mach_info->bpp.defval;
> +
> +	info.fb.var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) +1;
> +	info.fb.var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) +1;
> +	info.fb.var.vsync_len	    = S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
> +
> +	info.fb.var.left_margin	    = S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;
> +	info.fb.var.right_margin    = S3C2410_LCDCON3_GET_HBPD(mregs->lcdcon3) + 1;
> +	info.fb.var.hsync_len	    = S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) + 1;
> +
> +	info.fb.var.red.offset      = 11;
> +	info.fb.var.green.offset    = 5;
> +	info.fb.var.blue.offset     = 0;
> +	info.fb.var.transp.offset   = 0;
> +	info.fb.var.red.length      = 5;
> +	info.fb.var.green.length    = 6;
> +	info.fb.var.blue.length     = 5;
> +	info.fb.var.transp.length   = 0;
> +	info.fb.fix.smem_len        =	mach_info->xres.max *
> +					mach_info->yres.max *
> +					mach_info->bpp.max / 8;
> +

You may need to allocate info.fb.cmap also (with fb_alloc_cmap(),
and check its return).

And you can set info.fb.device = dev so your driver will become
visible in sysfs.

(The standard method is to use framebuffer_alloc() to allocate
struct fb_info and framebuffer_release() to free. You may have your own
reasons not to use them, so it's okay).


> +/*
> + *  Cleanup
> + */
> +static void __exit s3c2410fb_cleanup(void)
> +{
> +	s3c2410fb_stop_lcd();
> +	msleep(1);
> +
> + 	if (info.clk) {
> + 		clk_disable(info.clk);
> + 		clk_unuse(info.clk);
> + 		clk_put(info.clk);
> + 		info.clk = NULL;
> +	}
> +

and deallocate your info.fb.cmap here (with fb_dealloc_cmap())

> +	unregister_framebuffer(&info.fb);
> +	release_mem_region((unsigned long)S3C24XX_VA_LCD, S3C24XX_SZ_LCD);
> +}
> +

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

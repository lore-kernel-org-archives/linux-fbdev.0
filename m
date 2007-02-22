From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge,
	updated
Date: Thu, 22 Feb 2007 08:05:33 +0800
Message-ID: <1172102733.4217.38.camel@daplas>
References: <20070209193405.GB2637@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Q5-0004q8-JI for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:02:45 -0800
Received: from nz-out-0506.google.com ([64.233.162.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK1Q3-0007vc-0A
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:02:45 -0800
Received: by nz-out-0506.google.com with SMTP id i11so5918nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 16:02:42 -0800 (PST)
In-Reply-To: <20070209193405.GB2637@localhost.localdomain>
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
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Fri, 2007-02-09 at 20:34 +0100, Ondrej Zajicek wrote: 
> This patch adds driver for S3 Trio / S3 Virge. Driver is tested
> with most versions of S3 Trio and S3 Virge, on i386.
> It is tested both as compiled-in and module. It is against
> linux-2.6.20 .
> 
> This is version 3. There are some minor modifications from version 2
> (mostly coding style cleanups).

Nice, the first driver to use tileblit :-)

Since this driver is already in the -mm tree, can you resubmit a diff
against that? 

> +
> +static const struct vga_regset s3_h_total_regs[]        = {{0x00, 0, 7}, {0x5D, 0, 0}, VGA_REGSET_END};
> +static const struct vga_regset s3_h_display_regs[]      = {{0x01, 0, 7}, {0x5D, 1, 1}, VGA_REGSET_END};
> +static const struct vga_regset s3_h_blank_start_regs[]  = {{0x02, 0, 7}, {0x5D, 2, 2}, VGA_REGSET_END};
> +static const struct vga_regset s3_h_blank_end_regs[]    = {{0x03, 0, 4}, {0x05, 7, 7}, VGA_REGSET_END};
> +static const struct vga_regset s3_h_sync_start_regs[]   = {{0x04, 0, 7}, {0x5D, 4, 4}, VGA_REGSET_END};
> +static const struct vga_regset s3_h_sync_end_regs[]     = {{0x05, 0, 4}, VGA_REGSET_END};
> +
> +static const struct vga_regset s3_v_total_regs[]        = {{0x06, 0, 7}, {0x07, 0, 0}, {0x07, 5, 5}, {0x5E, 0, 0}, VGA_REGSET_END};
> +static const struct vga_regset s3_v_display_regs[]      = {{0x12, 0, 7}, {0x07, 1, 1}, {0x07, 6, 6}, {0x5E, 1, 1}, VGA_REGSET_END};
> +static const struct vga_regset s3_v_blank_start_regs[]  = {{0x15, 0, 7}, {0x07, 3, 3}, {0x09, 5, 5}, {0x5E, 2, 2}, VGA_REGSET_END};
> +static const struct vga_regset s3_v_blank_end_regs[]    = {{0x16, 0, 7}, VGA_REGSET_END};
> +static const struct vga_regset s3_v_sync_start_regs[]   = {{0x10, 0, 7}, {0x07, 2, 2}, {0x07, 7, 7}, {0x5E, 4, 4}, VGA_REGSET_END};
> +static const struct vga_regset s3_v_sync_end_regs[]     = {{0x11, 0, 3}, VGA_REGSET_END};
> +
> +static const struct vga_regset s3_line_compare_regs[]   = {{0x18, 0, 7}, {0x07, 4, 4}, {0x09, 6, 6}, {0x5E, 6, 6}, VGA_REGSET_END};
> +static const struct vga_regset s3_start_address_regs[]  = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x31, 4, 5}, {0x51, 0, 1}, VGA_REGSET_END};
> +static const struct vga_regset s3_offset_regs[]         = {{0x13, 0, 7}, {0x51, 4, 5}, VGA_REGSET_END}; /* set 0x43 bit 2 to 0 */
> +

Within reason, try to limit each line to 80 columns.


> +
> +/* image data is MSB-first, fb structure is MSB-first too */
> +static inline u32 expand_color(u32 c)
> +{
> +	return ((c & 1) | ((c & 2) << 7) | ((c & 4) << 14) | ((c & 8) << 21)) * 0xFF;
> +}
> +
> +/* s3fb_iplan_imageblit silently assumes that almost everything is 8-pixel aligned */

Hmn, same thing with vga16fb... Perhaps we should bring back the
fontwidth flag of 2.2 and 2.4 kernels.


> +
> +static int s3fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> +				u_int transp, struct fb_info *fb)
> +{
> +	switch (fb->var.bits_per_pixel) {
> +	case 0:
> +	case 4:
> +		if (regno >= 16)
> +			return -EINVAL;
> +
> +		if ((fb->var.bits_per_pixel == 4) &&
> +		    (fb->var.nonstd == 0)) {
> +			outb(0xF0, VGA_PEL_MSK);
> +			outb(regno*16, VGA_PEL_IW);
> +		} else {
> +			outb(0x0F, VGA_PEL_MSK);
> +			outb(regno, VGA_PEL_IW);
> +		}
> +		outb(red >> 10, VGA_PEL_D);
> +		outb(green >> 10, VGA_PEL_D);
> +		outb(blue >> 10, VGA_PEL_D);
> +		break;
> +	case 8:
> +		if (regno >= 256)
> +			return -EINVAL;
> +
> +		outb(0xFF, VGA_PEL_MSK);
> +		outb(regno, VGA_PEL_IW);
> +		outb(red >> 10, VGA_PEL_D);
> +		outb(green >> 10, VGA_PEL_D);
> +		outb(blue >> 10, VGA_PEL_D);
> +		break;
> +	case 16:
> +		if (regno >= 16)
> +			return -EINVAL;

Just return success without doing anything. I presume this is
truecolor.
> +
> +		if (fb->var.green.length == 5)
> +			((u32*)fb->pseudo_palette)[regno] = ((red & 0xF800) >> 1) |
> +				((green & 0xF800) >> 6) | ((blue & 0xF800) >> 11);
> +		else if (fb->var.green.length == 6)
> +			((u32*)fb->pseudo_palette)[regno] = (red & 0xF800) |
> +				((green & 0xFC00) >> 5) | ((blue & 0xF800) >> 11);
> +		else return -EINVAL;

Same here. 
> +		break;
> +	case 24:
> +	case 32:
> +		if (regno >= 16)
> +			return -EINVAL;

And here. 
> +
> +		((u32*)fb->pseudo_palette)[regno] = ((transp & 0xFF00) << 16) | ((red & 0xFF00) << 8) |
> +			(green & 0xFF00) | ((blue & 0xFF00) >> 8);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[snip]

> +
> +/* Pan the display */
> +
> +static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info) {
> +
> +	unsigned int offset;
> +
> +	/* Validate the offsets */
> +	if ((var->xoffset + var->xres) > var->xres_virtual)
> +		return -EINVAL;
> +	if ((var->yoffset + var->yres) > var->yres_virtual)
> +		return -EINVAL;

You need not validate the offsets, fb_pan_display() does this for you.

> +
> +	/* Calculate the offset */
> +	if (var->bits_per_pixel == 0) {
> +		offset = (var->yoffset / 16) * (var->xres_virtual / 2) + (var->xoffset / 2);
> +		offset = offset >> 2;
> +	} else {
> +		offset = (var->yoffset * info->fix.line_length) +
> +			 (var->xoffset * var->bits_per_pixel / 8);
> +		offset = offset >> 2;
> +	}
> +
> +	/* Set the offset */
> +	svga_wcrt_multi(s3_start_address_regs, offset);
> +
> +	return 0;
> +}
> +
> +/* ------------------------------------------------------------------------- */
> +
> +/* Frame buffer operations */
> +
> +static struct fb_ops s3fb_ops = {
> +	.owner		= THIS_MODULE,
> +	.fb_open	= s3fb_open,
> +	.fb_release	= s3fb_release,
> +	.fb_check_var	= s3fb_check_var,
> +	.fb_set_par	= s3fb_set_par,
> +	.fb_setcolreg	= s3fb_setcolreg,
> +	.fb_blank	= s3fb_blank,
> +	.fb_pan_display	= s3fb_pan_display,
> +	.fb_fillrect	= s3fb_fillrect,
> +	.fb_copyarea	= cfb_copyarea,

No s3fb_copyarea :-). Usually it's the other way around,
imageblit is unaccelerated.

> +	.fb_imageblit	= s3fb_imageblit,
> +};
> +

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

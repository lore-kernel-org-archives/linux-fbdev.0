From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: SM501 framebuffer driver
Date: Tue, 13 Feb 2007 21:01:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702132053110.898@pentafluge.infradead.org>
References: <20070213193449.GA7701@fluff.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751085AbXBMVB2@vger.kernel.org>
In-Reply-To: <20070213193449.GA7701@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, vince@arm.linux.org.uk, ben-linux@fluff.org


> Framebuffer support for the Silicon Motion SM501
> multi-function chip.
> 
> This driver provides a pair of framebuffer interfaces
> for the CRT and LCD panel interfaces, and some basic
> acceleration for the cursor.
> 
> The patch has been updated slightly from the previous
> version to including being able to pass an initial
> video mode through via the platform data.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Vincent Sanders <vince@arm.linux.org.uk>

> + *
> + * Converts a period in picoseconds to Hz.
> + *
> + * Note, we try to keep this in Hz to minimise rounding with
> + * the limited PLL settings on the SM501.
> +*/
> +
> +static unsigned long sm501fb_ps_to_hz(unsigned long psvalue)
> +{
> +	unsigned long long numerator=1000000000000ULL;
> +
> +	/* 10^12 / picosecond period gives frequency in Hz */
> +	do_div(numerator, psvalue);
> +	return (unsigned long)numerator;
> +}
> +
> +/* sm501fb_hz_to_ps is identical to the oposite transform */
> +
> +#define sm501fb_hz_to_ps(x) sm501fb_ps_to_hz(x)

You really need it down to the Hz? 

> +/* sm501fb_validate_pan
> + *
> + * check panning on a var
> +*/
> +
> +static inline int sm501fb_validate_pan(struct fb_var_screeninfo *var)
> +{
> +	if (var->xoffset < 0 || var->yoffset < 0)
> +		return 0;
> +
> +	if (var->xoffset > (var->xres_virtual - var->xres) ||
> +	    var->yoffset > (var->yres_virtual - var->yres))
> +		return 0;
> +
> +	return 1;
> +}

Not needed. fb_pan_display in fbmem.c does this check for you :-)

> +/* framebuffer ops */
> +
> +static struct fb_ops sm501fb_ops_crt = {
> +	.owner		= THIS_MODULE,
> +	.fb_check_var	= sm501fb_check_var_crt,
> +	.fb_set_par	= sm501fb_set_par_crt,
> +	.fb_blank	= sm501fb_blank_crt,
> +	.fb_setcolreg	= sm501fb_setcolreg,
> +	.fb_pan_display	= sm501fb_pan_crt,
> +	.fb_cursor	= sm501fb_cursor,
> +	.fb_fillrect	= cfb_fillrect,
> +	.fb_copyarea	= cfb_copyarea,
> +	.fb_imageblit	= cfb_imageblit,
> +};
> +
> +static struct fb_ops sm501fb_ops_pnl = {
> +	.owner		= THIS_MODULE,
> +	.fb_check_var	= sm501fb_check_var_pnl,
> +	.fb_set_par	= sm501fb_set_par_pnl,
> +	.fb_pan_display	= sm501fb_pan_pnl,
> +	.fb_blank	= sm501fb_blank_pnl,
> +	.fb_setcolreg	= sm501fb_setcolreg,
> +	.fb_cursor	= sm501fb_cursor,
> +	.fb_fillrect	= cfb_fillrect,
> +	.fb_copyarea	= cfb_copyarea,
> +	.fb_imageblit	= cfb_imageblit,
> +};

Many cards require a fb_sync function after/before they do a drawing 
operation. I notice you don't have one. Is sm501fb_sync_regs equivalent to 
that?

Other than that the driver looks great. Thank you.

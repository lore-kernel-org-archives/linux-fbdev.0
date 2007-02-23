From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge, updated
Date: Fri, 23 Feb 2007 13:45:57 +0100
Message-ID: <20070223124557.GA13443@localhost.localdomain>
References: <20070209193405.GB2637@localhost.localdomain> <1172102733.4217.38.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932309AbXBWMrE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172102733.4217.38.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Jiri Slaby <jirislaby@gmail.com>

On Thu, Feb 22, 2007 at 08:05:33AM +0800, Antonino A. Daplas wrote:
> On Fri, 2007-02-09 at 20:34 +0100, Ondrej Zajicek wrote: 
> > This patch adds driver for S3 Trio / S3 Virge. Driver is tested
> > with most versions of S3 Trio and S3 Virge, on i386.
> > It is tested both as compiled-in and module. It is against
> > linux-2.6.20 .
> > 
> > This is version 3. There are some minor modifications from version 2
> > (mostly coding style cleanups).
> 
> Nice, the first driver to use tileblit :-)
> 
> Since this driver is already in the -mm tree, can you resubmit a diff
> against that? 

This driver was removed from -mm tree, because it is in 2.6.21-rc1 .
So it is probably unnnecessary to resubmit a diff, isn't it?

> > +
> > +static int s3fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> > +				u_int transp, struct fb_info *fb)
> > +{
...
> > +	case 16:
> > +		if (regno >= 16)
> > +			return -EINVAL;
> 
> Just return success without doing anything. I presume this is
> truecolor.

OK

> > +static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info) {
> > +
> > +	unsigned int offset;
> > +
> > +	/* Validate the offsets */
> > +	if ((var->xoffset + var->xres) > var->xres_virtual)
> > +		return -EINVAL;
> > +	if ((var->yoffset + var->yres) > var->yres_virtual)
> > +		return -EINVAL;
> 
> You need not validate the offsets, fb_pan_display() does this for you.

OK

> > +/* Frame buffer operations */
> > +
> > +static struct fb_ops s3fb_ops = {
> > +	.owner		= THIS_MODULE,
> > +	.fb_open	= s3fb_open,
> > +	.fb_release	= s3fb_release,
> > +	.fb_check_var	= s3fb_check_var,
> > +	.fb_set_par	= s3fb_set_par,
> > +	.fb_setcolreg	= s3fb_setcolreg,
> > +	.fb_blank	= s3fb_blank,
> > +	.fb_pan_display	= s3fb_pan_display,
> > +	.fb_fillrect	= s3fb_fillrect,
> > +	.fb_copyarea	= cfb_copyarea,
> 
> No s3fb_copyarea :-). Usually it's the other way around,
> imageblit is unaccelerated.

This driver is unaccelerated (if i don't consider text mode support as
acceleration). s3fb_fillrect and s3fb_imageblit are here because of supported
4bpp modes are not handled by cfb_* functions. cfb_copyarea works for that
modes by coincidence.

-- 
Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Date: Sat, 4 Jan 2003 21:41:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030104204131.GD1319@ppc.vc.cvut.cz>
References: <1041672313.958.17.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1041672313.958.17.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>

On Sat, Jan 04, 2003 at 05:25:14PM +0800, Antonino Daplas wrote:
> Attached is a patch against 2.5.54 in an attempt to add putcs() and
> setfont() methods for fbdev drivers that require them:

Looks good.
 
> ...
> struct fb_char {
> 	__u32 dx;               /* where to place chars, in pixels */
> 	__u32 dy;               /* where to place chars, in scanline */

These two are questionable. I do not know what DaveM will need, but
I'll be happier with character coordinates for text mode. So for me it is
just question whether I'll do divide by width/height stored from setfont
in text mode, or multiply when in graphics mode. So I must remember
character cell size in any case. But having multiply in matroxfb could 
save multiply here in generic code.

I have strong feeling that doing multiply in generic code, and then divide
in fbdev driver is waste of time, but if Dave is happier with pixel
coordinates, I can definitely live with it.

> 	__u32 len;              /* number of characters */
> 	__u32 fg_color;
> 	__u32 bg_color;        
> 	__u32 *data;            /* array of indices to fontdata */
> };
> 
> struct fb_fontdata {
> 	__u32 width;            /* font width */
> 	__u32 height;           /* font height */
> 	__u32 len;              /* number of characters */
> 	__u8  *data;            /* character map */
> };
> 
> ...
> 
>     /* upload character map */
>     int (*fb_setfont)(struct fb_info *info, const struct fb_fontdata
> *font);
>     /* write characters */
>     int (*fb_putcs)(struct fb_info *info, const struct fb_char *chars);
> 

It would be nice to have old accel_putcs() available for modules, so driver 
could decide on case-by-case basis whether it will use its own code or 
generic without touching pointer (without modifying potentially constant
fb_ops structure common to all fbdev instances).
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

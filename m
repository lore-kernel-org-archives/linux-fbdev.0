From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Patch 2] Console Rotation
Date: 08 Oct 2002 03:44:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034018779.572.22.camel@daplas>
References: <Pine.GSO.4.21.0210062238180.923-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xP02ods6k9xb5j6bin8X"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ydoN-0001ZC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Oct 2002 12:45:03 -0700
In-Reply-To: <Pine.GSO.4.21.0210062238180.923-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-xP02ods6k9xb5j6bin8X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-10-07 at 04:41, Geert Uytterhoeven wrote:
> 
> The fillrect() for arbitrary bitdepths is in fbtest now. I also added fast
> support for planar screens. Well, now I can start porting amifb to the accel
> framework.
> 
I modified your fillrect for cfbfillrect.c.  Just added support for
ROP_XOR.

Here's also some rudimentary benchmarks:

fill/copy a 256x256 rectangle 1000 times (8bpp):

                           old          new
copyarea                   4.930s       5.151s
fillrect(ROP_COPY)         0.136s       0.256s
fillrect(ROP_XOR)          4.059s       3.903s

Tony




--=-xP02ods6k9xb5j6bin8X
Content-Disposition: attachment; filename=cfbfillrect.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=cfbfillrect.c; charset=ISO-8859-1

/*
 *  Generic fillrect for frame buffers with packed pixels of any depth.=20
 *
 *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org)=20
 *
 *  This file is subject to the terms and conditions of the GNU General Pub=
lic
 *  License.  See the file COPYING in the main directory of this archive fo=
r
 *  more details.
 *
 * NOTES:
 * ++Tony: Based on fbtest (cfb.c bitstream.c) by Geert Uytterhoeven.
 *
 */
#include <linux/string.h>
#include <linux/fb.h>
#include <asm/types.h>
#include <video/fbcon.h>

#if BITS_PER_LONG =3D=3D 32
#define FB_WRITEL fb_writel
#define FB_READL  fb_readl
#define BYTES_PER_LONG 4
#define SHIFT_PER_LONG 5
#else
#define FB_WRITEL fb_writeq
#define FB_READL  fb_readq
#define BYTES_PER_LONG 8
#define SHIFT_PER_LONG 6
#endif

#define EXP1(x)		0xffffffffU*x
#define EXP2(x)		0x55555555U*x
#define EXP4(x)		0x11111111U*0x ## x

typedef u32 pixel_t;

static const u32 bpp1tab[2] =3D {
    EXP1(0), EXP1(1)
};

static const u32 bpp2tab[4] =3D {
    EXP2(0), EXP2(1), EXP2(2), EXP2(3)
};

static const u32 bpp4tab[16] =3D {
    EXP4(0), EXP4(1), EXP4(2), EXP4(3), EXP4(4), EXP4(5), EXP4(6), EXP4(7),
    EXP4(8), EXP4(9), EXP4(a), EXP4(b), EXP4(c), EXP4(d), EXP4(e), EXP4(f)
};

    /*
     *  Compose two values, using a bitmask as decision value
     *  This is equivalent to (a & mask) | (b & ~mask)
     */

static inline unsigned long comp(unsigned long a, unsigned long b,
				 unsigned long mask)
{
    return ((a ^ b) & mask) ^ b;
}

static inline u32 pixel_to_pat32(const struct fb_info *p, pixel_t pixel)
{
    u32 pat =3D pixel;

    switch (p->var.bits_per_pixel) {
	case 1:
	    pat =3D bpp1tab[pat];
	    break;

	case 2:
	    pat =3D bpp2tab[pat];
	    break;

	case 4:
	    pat =3D bpp4tab[pat];
	    break;

	case 8:
	    pat |=3D pat << 8;
	    // Fall through
	case 16:
	    pat |=3D pat << 16;
	    // Fall through
	case 32:
	    break;
    }
    return pat;
}

    /*
     *  Expand a pixel value to a generic 32/64-bit pattern and rotate it t=
o
     *  the correct start position
     */

static inline unsigned long pixel_to_pat(const struct fb_info *p, pixel_t p=
ixel, int left)
{
    unsigned long pat =3D pixel;
    u32 bpp =3D p->var.bits_per_pixel;
    int i;

    /* expand pixel value */
    for (i =3D bpp; i < BITS_PER_LONG; i *=3D 2)
	pat |=3D pat << i;

    /* rotate pattern to correct start position */
    pat =3D pat << left | pat >> (bpp-left);
    return pat;
}

    /*
     *  Unaligned 32-bit pattern fill using 32/64-bit memory accesses
     */

void bitfill32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
{
	unsigned long val =3D pat;
	unsigned long first, last;
=09
	if (!n)
		return;
=09
#if BITS_PER_LONG =3D=3D 64
	val |=3D val << 32;
#endif
=09
	first =3D ~0UL >> dst_idx;
	last =3D ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
=09
	if (dst_idx+n <=3D BITS_PER_LONG) {
		// Single word
		if (last)
			first &=3D last;
		FB_WRITEL(comp(val, FB_READL(dst), first), dst);
	} else {
		// Multiple destination words
		// Leading bits
		if (first) {
			FB_WRITEL(comp(val, FB_READL(dst), first), dst);
			dst++;
			n -=3D BITS_PER_LONG-dst_idx;
		}
	=09
		// Main chunk
		n /=3D BITS_PER_LONG;
		while (n >=3D 8) {
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			FB_WRITEL(val, dst++);
			n -=3D 8;
		}
		while (n--)
			FB_WRITEL(val, dst++);
	=09
		// Trailing bits
		if (last)
			FB_WRITEL(comp(val, FB_READL(dst), first), dst);
	}
}


    /*
     *  Unaligned generic pattern fill using 32/64-bit memory accesses
     *  The pattern must have been expanded to a full 32/64-bit value
     *  Left/right are the appropriate shifts to convert to the pattern to =
be
     *  used for the next 32/64-bit word
     */

void bitfill(unsigned long *dst, int dst_idx, unsigned long pat, int left,
	     int right, u32 n)
{
	unsigned long first, last;

	if (!n)
		return;
=09
	first =3D ~0UL >> dst_idx;
	last =3D ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
=09
	if (dst_idx+n <=3D BITS_PER_LONG) {
		// Single word
		if (last)
			first &=3D last;
		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
	} else {
		// Multiple destination words
		// Leading bits
		if (first) {
			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
			dst++;
			pat =3D pat << left | pat >> right;
			n -=3D BITS_PER_LONG-dst_idx;
		}
	=09
		// Main chunk
		n /=3D BITS_PER_LONG;
		while (n >=3D 4) {
			FB_WRITEL(pat, dst++);
			pat =3D pat << left | pat >> right;
			FB_WRITEL(pat, dst++);
			pat =3D pat << left | pat >> right;
			FB_WRITEL(pat, dst++);
			pat =3D pat << left | pat >> right;
			FB_WRITEL(pat, dst++);
			pat =3D pat << left | pat >> right;
			n -=3D 4;
		}
		while (n--) {
			FB_WRITEL(pat, dst++);
			pat =3D pat << left | pat >> right;
		}
	=09
		// Trailing bits
		if (last)
			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
	}
}

void bitfill32_xor(unsigned long *dst, int dst_idx, u32 pat, u32 n)
{
	unsigned long val =3D pat, dat;
	unsigned long first, last;
=09
	if (!n)
		return;
=09
#if BITS_PER_LONG =3D=3D 64
	val |=3D val << 32;
#endif
=09
	first =3D ~0UL >> dst_idx;
	last =3D ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
=09
	if (dst_idx+n <=3D BITS_PER_LONG) {
		// Single word
		if (last)
			first &=3D last;
		dat =3D FB_READL(dst);
		FB_WRITEL(comp(dat ^ val, dat, first), dst);
	} else {
		// Multiple destination words
		// Leading bits
		if (first) {
			dat =3D FB_READL(dst);
			FB_WRITEL(comp(dat ^ val, dat, first), dst);
			dst++;
			n -=3D BITS_PER_LONG-dst_idx;
		}
	=09
		// Main chunk
		n /=3D BITS_PER_LONG;
		while (n >=3D 8) {
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
			n -=3D 8;
		}
		while (n--) {
			FB_WRITEL(FB_READL(dst) ^ val, dst);
			dst++;
		}	=09
		// Trailing bits
		if (last) {
			dat =3D FB_READL(dst);
			FB_WRITEL(comp(dat ^ val, dat, first), dst);
		}
	}
}


    /*
     *  Unaligned generic pattern fill using 32/64-bit memory accesses
     *  The pattern must have been expanded to a full 32/64-bit value
     *  Left/right are the appropriate shifts to convert to the pattern to =
be
     *  used for the next 32/64-bit word
     */

void bitfill_xor(unsigned long *dst, int dst_idx, unsigned long pat, int le=
ft,
	     int right, u32 n)
{
	unsigned long first, last, dat;

	if (!n)
		return;
=09
	first =3D ~0UL >> dst_idx;
	last =3D ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
=09
	if (dst_idx+n <=3D BITS_PER_LONG) {
		// Single word
		if (last)
			first &=3D last;
		dat =3D FB_READL(dst);
		FB_WRITEL(comp(dat ^ pat, dat, first), dst);
	} else {
		// Multiple destination words
		// Leading bits
		if (first) {
			dat =3D FB_READL(dst);
			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
			dst++;
			pat =3D pat << left | pat >> right;
			n -=3D BITS_PER_LONG-dst_idx;
		}
	=09
		// Main chunk
		n /=3D BITS_PER_LONG;
		while (n >=3D 4) {
			FB_WRITEL(FB_READL(dst) ^ pat, dst);
			dst++;
			pat =3D pat << left | pat >> right;
			FB_WRITEL(FB_READL(dst) ^ pat, dst);
			dst++;
			pat =3D pat << left | pat >> right;
			FB_WRITEL(FB_READL(dst) ^ pat, dst);
			dst++;
			pat =3D pat << left | pat >> right;
			FB_WRITEL(FB_READL(dst) ^ pat, dst);
			dst++;
			pat =3D pat << left | pat >> right;
			n -=3D 4;
		}
		while (n--) {
			FB_WRITEL(FB_READL(dst) ^ pat, dst);
			dst++;
			pat =3D pat << left | pat >> right;
		}
	=09
		// Trailing bits
		if (last) {
			dat =3D FB_READL(dst);
			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
		}
	}
}

void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)
{
	unsigned long height, fg;
	unsigned long x2, y2, vxres, vyres;
	unsigned long *dst;
	int dst_idx, left;
	u32 bpp =3D p->var.bits_per_pixel;
=09
	vxres =3D p->var.xres_virtual;
	vyres =3D p->var.yres_virtual;

	if (!rect->width || !rect->height ||
	    rect->dx > vxres ||
	    rect->dy > vyres)
		return;

	/* We could use hardware clipping but on many cards you get around
	 * hardware clipping by writing to framebuffer directly. */
=09
	x2 =3D rect->dx + rect->width;
	y2 =3D rect->dy + rect->height;
	x2 =3D x2 < vxres ? x2 : vxres;
	y2 =3D y2 < vyres ? y2 : vyres;
	rect->width =3D x2 - rect->dx;
	height =3D y2 - rect->dy;
=09
	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
		fg =3D ((u32 *) (p->pseudo_palette))[rect->color];
	else
		fg =3D rect->color;
=09
	dst =3D (unsigned long *)((unsigned long)p->screen_base & ~(BYTES_PER_LONG=
-1));
	dst_idx =3D ((unsigned long)p->screen_base & (BYTES_PER_LONG-1))*8;
	dst_idx +=3D rect->dy*p->fix.line_length*8+rect->dx*bpp;
	/* FIXME For now we support 1-32 bpp only */
	left =3D BITS_PER_LONG % bpp;
	if (!left) {
		u32 pat =3D pixel_to_pat32(p, fg);
		void (*fill_op32)(unsigned long *dst, int dst_idx, u32 pat, u32 n) =3D NU=
LL;
	=09
		switch (rect->rop) {
		case ROP_XOR:
			fill_op32 =3D bitfill32_xor;
			break;
		case ROP_COPY:
		default:
			fill_op32 =3D bitfill32;
			break;
		}
		while (height--) {
			dst +=3D dst_idx >> SHIFT_PER_LONG;
			dst_idx &=3D (BITS_PER_LONG-1);
			fill_op32(dst, dst_idx, pat, rect->width*bpp);
			dst_idx +=3D p->fix.line_length*8;
		}
	} else {
		unsigned long pat =3D pixel_to_pat(p, fg, (left-dst_idx) % bpp);
		int right =3D bpp-left;
		int r;
		void (*fill_op)(unsigned long *dst, int dst_idx, unsigned long pat,=20
				int left, int right, u32 n) =3D NULL;
	=09
		switch (rect->rop) {
		case ROP_XOR:
			fill_op =3D bitfill_xor;
			break;
		case ROP_COPY:
		default:
			fill_op =3D bitfill;
			break;
		}
		while (height--) {
			dst +=3D dst_idx >> SHIFT_PER_LONG;
			dst_idx &=3D (BITS_PER_LONG-1);
			fill_op(dst, dst_idx, pat, left, right, rect->width*bpp);
			r =3D (p->fix.line_length*8) % bpp;
			pat =3D pat << (bpp-r) | pat >> r;
			dst_idx +=3D p->fix.line_length*8;
		}
	}
}

--=-xP02ods6k9xb5j6bin8X--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

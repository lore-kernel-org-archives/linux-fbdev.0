From: Antonino Daplas <adaplas@pol.net>
Subject: cfbimgblt.c
Date: 22 Aug 2002 07:23:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1029972099.551.3.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RjBUSP1HtfCkvcvSxmRI"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hep8-0002AZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Aug 2002 16:23:38 -0700
Received: from [202.70.99.5] (AP-202-70-99-5.compass.com.ph [202.70.99.5])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id HAA93544
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 07:23:33 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-RjBUSP1HtfCkvcvSxmRI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, 

I want to address some of the limitations of cfbimgblt.c, but
unfortunately I ended up practically rewriting the whole code.  In
theory, the code (slow_imageblit): 

a. supports all possible bit depths 
b. should be able to handle destination writes that are not aligned by
an unsigned long 
c.  should be able to handle fix->line_length not a multiple of an
unsigned long 
d. framebuffer access is always the size of an unsigned long and aligned
e. preliminary code for drawing the logo. 
f. added Paul Mackerra's endianness patch (plus some of my own), but I
have no big-endian machine, so it's untested, and perhaps incorrect. 

The only tests I've done for slow_imageblit is at 8, 16, 24, and 32 bpp,
and forcibly misaligning image->dx by 1 pixel. The code is slow, so I
included fast_imageblit for 8, 16 and 32 bpp which is an implementation
of fbcon-cfb8/16/32.c. 

Tony 


--=-RjBUSP1HtfCkvcvSxmRI
Content-Disposition: attachment; filename=cfbimgblt.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=cfbimgblt.c; charset=ISO-8859-1

/*
 *  Generic BitBLT function for frame buffer with packed pixels of any dept=
h.
 *
 *      Copyright (C)  June 1999 James Simmons
 *
 *  This file is subject to the terms and conditions of the GNU General Pub=
lic
 *  License.  See the file COPYING in the main directory of this archive fo=
r
 *  more details.
 *
 * NOTES:
 *
 *    This function copys a image from system memory to video memory. The
 *  image can be a bitmap where each 0 represents the background color and
 *  each 1 represents the foreground color. Great for font handling. It can
 *  also be a color image. This is determined by image_depth. The color ima=
ge
 *  must be laid out exactly in the same format as the framebuffer. Yes I k=
now
 *  their are cards with hardware that coverts images of various depths to =
the
 *  framebuffer depth. But not every card has this. All images must be roun=
ded
 *  up to the nearest byte. For example a bitmap 12 bits wide must be two=20
 *  bytes width.=20
 *
 *  FIXME
 *  The code for 24 bit is horrible. It copies byte by byte size instead of
 *  longs like the other sizes. Needs to be optimized.
 * =20
 *  Tony:=20
 *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speed=
s=20
 *  up the code significantly.
 * =20
 *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which i=
s
 *  still processed a bit at a time.  =20
 *
 *  Also need to add code to deal with cards endians that are different tha=
n
 *  the native cpu endians. I also need to deal with MSB position in the wo=
rd.
 *
 */
#include <linux/string.h>
#include <linux/fb.h>
#include <asm/types.h>

#include <video/fbcon.h>

#define DEBUG

#ifdef DEBUG
#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt,__FUNCTION__,## =
args)
#else
#define DPRINTK(fmt, args...)
#endif

static u32 cfb_tab8[] =3D {
#if defined(__BIG_ENDIAN)
    0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
    0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
    0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
    0xffff0000,0xffff00ff,0xffffff00,0xffffffff
#elif defined(__LITTLE_ENDIAN)
    0x00000000,0xff000000,0x00ff0000,0xffff0000,
    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
#else
#error FIXME: No endianness??
#endif
};

static u32 cfb_tab16[] =3D {
#if defined(__BIG_ENDIAN)
    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
#elif defined(__LITTLE_ENDIAN)
    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
#else
#error FIXME: No endianness??
#endif
};

static u32 cfb_tab32[] =3D {
	0x00000000, 0xffffffff
};

#if BITS_PER_LONG =3D=3D 32
#define FB_WRITEL(x,y) fb_writel(x,y)
#define FB_READL(x)    fb_readl(x)
#else
#define FB_WRITEL(x,y) fb_writeq(x,y)
#define FB_READL(x)    fb_readq(x)
#endif=20

#if defined (__BIG_ENDIAN)
#define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
#define NEXT_POS(pos, bpp)     ((pos) -=3D (bpp))
#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
#define SHIFT_LOW(val, bits)   ((val) << (bits))
#else
#define LEFT_POS(bpp)          (0)
#define NEXT_POS(pos, bpp)     ((pos) +=3D (bpp))
#define SHIFT_HIGH(val, bits)  ((val) << (bits))
#define SHIFT_LOW(val, bits)   ((val) >> (bits))
#endif

static inline void color_imageblit(struct fb_image *image, struct fb_info *=
p, u8 *dst1,=20
				   unsigned long start_index, unsigned long pitch_index)
{
	/* Draw the penguin */
	int i, n;
	unsigned long bitmask =3D SHIFT_LOW(~0UL, BITS_PER_LONG - p->var.bits_per_=
pixel);
	unsigned long *palette =3D (unsigned long *) p->pseudo_palette;
	unsigned long *dst, *dst2, color =3D 0, val, shift;
	unsigned long null_bits =3D BITS_PER_LONG - p->var.bits_per_pixel;=20
	u8 *src =3D image->data;

	dst2 =3D (unsigned long *) dst1;
	for (i =3D image->height; i--; ) {
		n =3D image->width;
		dst =3D (unsigned long *) dst1;
		shift =3D 0;
		val =3D 0;
	=09
		if (start_index) {
			unsigned long start_mask =3D ~(SHIFT_HIGH(~0UL, start_index));

			val =3D FB_READL(dst) & start_mask;
			shift =3D start_index;
		}
		while (n--) {
			if (p->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR)
				color =3D *src & bitmask;=20
			if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
			    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
				color =3D palette[*src] & bitmask;=20
			val |=3D SHIFT_HIGH(color, shift);
			if (shift >=3D null_bits) {
				FB_WRITEL(val, dst++);
				if (shift =3D=3D null_bits)
					val =3D 0;
				else
					val =3D SHIFT_LOW(color, BITS_PER_LONG - shift);
			}
			shift +=3D p->var.bits_per_pixel;
			shift &=3D (BITS_PER_LONG - 1);
			src++;
		}
		if (shift) {
			unsigned long  end_mask =3D SHIFT_HIGH(~0UL, shift);

			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
		}
		dst1 +=3D p->fix.line_length;
		if (pitch_index) {
			dst2 +=3D p->fix.line_length;
			dst1 =3D (char *) dst2;
			(unsigned long) dst1 &=3D ~(sizeof(unsigned long) - 1);

			start_index +=3D pitch_index;
			start_index &=3D BITS_PER_LONG - 1;
		}
	}
}

static inline void slow_imageblit(struct fb_image *image, struct fb_info *p=
, u8 *dst1,
				  unsigned long fgcolor, unsigned long bgcolor,=20
				  unsigned long start_index, unsigned long pitch_index)
{
	unsigned long i, j, l =3D 8;
	unsigned long shift, color, bpp =3D p->var.bits_per_pixel;
	unsigned long *dst, *dst2, val, pitch =3D p->fix.line_length;
	unsigned long null_bits =3D BITS_PER_LONG - bpp;
	u8 *src =3D image->data;
=09
	dst2 =3D (unsigned long *) dst1;

	for (i =3D image->height; i--; ) {
		shift =3D 0;
		val =3D 0;
		j =3D image->width;
		dst =3D (unsigned long *) dst1;

		/* write start bits, if any */
		if (start_index) {
			unsigned long start_mask =3D ~(SHIFT_HIGH(~0UL, start_index));

			val =3D FB_READL(dst) & start_mask;
			shift =3D start_index;
		}
		while (j--) {
			l--;
			if (*src & (1 << l))=20
				color =3D fgcolor;
			else=20
				color =3D bgcolor;
			val |=3D SHIFT_HIGH(color, shift);
		=09
			/* Did the bitshift spill bits to the next long? */
			if (shift >=3D null_bits) {
				FB_WRITEL(val, dst++);
				if (shift =3D=3D null_bits)
					val =3D 0;
				else
					val =3D SHIFT_LOW(color, BITS_PER_LONG - shift);
			}
			shift +=3D bpp;
			shift &=3D (BITS_PER_LONG - 1);
			if (!l) { l =3D 8; src++; };
		}
		/* write end bits, if any*/
 		if (shift) {
			unsigned long end_mask =3D SHIFT_HIGH(~0UL, shift);

			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
		}
		dst1 +=3D pitch;=09

		if (pitch_index) {
			dst2 +=3D pitch;
			dst1 =3D (char *) dst2;
			(unsigned long) dst1 &=3D ~(sizeof(unsigned long) - 1);

			start_index +=3D pitch_index;
			start_index &=3D BITS_PER_LONG - 1;
		}
	=09
	}
}

static inline void fast_imageblit(struct fb_image *image, struct fb_info *p=
, u8 *dst1,=20
				  unsigned long fgcolor, unsigned long bgcolor)=20
{
	int i, j, k, l =3D 8, n;
	unsigned long bit_mask, end_mask, eorx;=20
	unsigned long fgx =3D fgcolor, bgx =3D bgcolor, pad, bpp =3D p->var.bits_p=
er_pixel;
	unsigned long tmp =3D (1 << bpp) - 1;
	unsigned long ppw =3D BITS_PER_LONG/bpp, ppos;
	unsigned long *dst;
	u32 *tab =3D NULL;
	char *src =3D image->data;
	=09
	switch (ppw) {
	case 4:
		tab =3D cfb_tab8;
		break;
	case 2:
		tab =3D cfb_tab16;
		break;
	case 1:
		tab =3D cfb_tab32;
		break;
	}

	for (i =3D ppw-1; i--; ) {
		fgx <<=3D bpp;
		bgx <<=3D bpp;
		fgx |=3D fgcolor;
		bgx |=3D bgcolor;
	}
=09
	n =3D ((image->width + 7) / 8);
	pad =3D (n * 8) - image->width;
	n =3D image->width % ppw;
=09
	bit_mask =3D (1 << ppw) - 1;
	eorx =3D fgx ^ bgx;

	k =3D image->width/ppw;

	for (i =3D image->height; i--; ) {
		dst =3D (unsigned long *) dst1;
	=09
		for (j =3D k; j--; ) {
			l -=3D ppw;
			end_mask =3D tab[(*src >> l) & bit_mask];=20
			FB_WRITEL((end_mask & eorx)^bgx, dst++);
			if (!l) { l =3D 8; src++; }
		}
		if (n) {
			end_mask =3D 0;=09
			ppos =3D LEFT_POS(bpp);
			for (j =3D n; j > 0; j--) {
				l--;
				if (*src & (1 << l))
					end_mask |=3D tmp << ppos;
				NEXT_POS(ppos, bpp);
				if (!l) { l =3D 8; src++; }
			}
			FB_WRITEL((end_mask & eorx)^bgx, dst++);
		}
		l -=3D pad;	=09
		dst1 +=3D p->fix.line_length;=09
	}
}=09
=09
void cfb_imageblit(struct fb_info *p, struct fb_image *image)
{
	int x2, y2;
	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index =3D 0;
	unsigned long bpl =3D sizeof(unsigned long), bpp =3D p->var.bits_per_pixel=
;
	u8 *dst1;

	/*=20
	 * We could use hardware clipping but on many cards you get around hardwar=
e
	 * clipping by writing to framebuffer directly like we are doing here.=20
	 */
	x2 =3D image->dx + image->width;
	y2 =3D image->dy + image->height;
	image->dx =3D image->dx > 0 ? image->dx : 0;
	image->dy =3D image->dy > 0 ? image->dy : 0;
	x2 =3D x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
	y2 =3D y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
	image->width  =3D x2 - image->dx;
	image->height =3D y2 - image->dy;

	bitstart =3D (image->dy * p->fix.line_length * 8) + (image->dx * bpp);
	start_index =3D bitstart & (BITS_PER_LONG - 1);
	pitch_index =3D (p->fix.line_length & (bpl - 1)) * 8;

	bitstart /=3D 8;
	bitstart &=3D ~(bpl - 1);
	dst1 =3D p->screen_base + bitstart;

	if (image->depth =3D=3D 1) {
		if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
		    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
			fgcolor =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
			bgcolor =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
		} else {
			fgcolor =3D image->fg_color;
			bgcolor =3D image->bg_color;
		}=09
=20
		if (BITS_PER_LONG % bpp =3D=3D 0 && !start_index && !pitch_index &&=20
		    bpp >=3D 8 && bpp <=3D 32)=20
			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
		else=20
			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_inde=
x);
	}
	else if (image->depth =3D=3D bpp)=20
		color_imageblit(image, p, dst1, start_index, pitch_index);
}

--=-RjBUSP1HtfCkvcvSxmRI--




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

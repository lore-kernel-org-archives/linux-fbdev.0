From: Antonino Daplas <adaplas@pol.net>
Subject: Re: RFC: Optimizing putcs()
Date: 07 Aug 2002 13:25:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028697994.561.3.camel@daplas>
References: <1028584418.556.29.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z9XGX2oo3DeYZDzemGo1"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cJGV-0007eG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 22:21:48 -0700
Received: from AP-203.167.30.67.sysads.com (cwd67.compass.com.ph [203.167.30.67])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id NAA10517
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 7 Aug 2002 13:21:28 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <1028584418.556.29.camel@daplas>
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


--=-z9XGX2oo3DeYZDzemGo1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

One of the reason why 2.4 console performance is good especially at low
bit depths is its ability to process more than 1 pixel per iteration and
its usage of mask arrays.  

I tried to generalize the above in cfbimgblt.c by incorporating the idea
in fbcon-cfb*.c. It's significantly faster but still not as fast as the
2.4 API. 

time cat /usr/src/linux/MAINTAINERs (40K text file) 
1024x768-8bpp, y-panning disabled 

2.5 old (with offscreen buffers) 

real    0m10.708s 
user    0m0.001s 
sys     0m10.707s 

2.5 new 

real    0m4.378s 
user    0m0.002s 
sys     0m4.375s 

2.4 

real    0m2.098s 
user    0m0.000s 
sys     0m2.070s 

I've only tested the implementation at 8, 16, 24, and 32 bpp.  24bpp is
slightly slower than 32 bpp :( 

Tony 




--=-z9XGX2oo3DeYZDzemGo1
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

static u32 cfb_tabdef[2];

void cfb_imageblit(struct fb_info *p, struct fb_image *image)
{
	int pad, ppw;
	int x2, y2, n, i, j, l =3D 8;
	unsigned long tmp =3D ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;=09
	unsigned long end_mask, bit_mask, bytes =3D 4;
	u32 *tab =3D NULL;
	u8 *dst =3D NULL, *dst1;
	u8 *src;

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

	dst1 =3D p->screen_base + image->dy * p->fix.line_length +=20
		((image->dx * p->var.bits_per_pixel) >> 3);
 =20
	ppw =3D BITS_PER_LONG/p->var.bits_per_pixel;

	src =3D image->data;=09

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

	if (image->depth =3D=3D 1) {

		if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
			fgx =3D fgcolor =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
			bgx =3D bgcolor =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
		} else {
			fgx =3D fgcolor =3D image->fg_color;
			bgx =3D bgcolor =3D image->bg_color;
		}=09
=20
		for (i =3D 0; i < ppw-1; i++) {
			fgx <<=3D p->var.bits_per_pixel;
			bgx <<=3D p->var.bits_per_pixel;
			fgx |=3D fgcolor;
			bgx |=3D bgcolor;
		}

		/*
		 * BPP kludge, should be generalized/optimized later
		 */
		if (BITS_PER_LONG % p->var.bits_per_pixel) {
			bytes =3D (p->var.bits_per_pixel + 7) >> 3;
			tmp =3D ~0UL >> (BITS_PER_LONG - p->var.bits_per_pixel);
			tab =3D cfb_tabdef;
			tab[0] =3D 0;
			tab[1] =3D tmp;
			fgx =3D fgcolor;
			bgx =3D bgcolor;
			ppw =3D 1;
		}

		bit_mask =3D (1 << ppw) - 1;

		n =3D ((image->width + 7) >> 3);
		pad =3D (n << 3) - image->width;
		n =3D image->width % ppw;

		eorx =3D fgx ^ bgx;
	=09
		for (i =3D 0; i < image->height; i++) {
			dst =3D dst1;
	=09
			for (j =3D image->width/ppw; j--; ) {
				l -=3D ppw;
				end_mask =3D tab[(*src >> l) & bit_mask];=20
				fb_writel((end_mask & eorx)^bgx, (unsigned long *) dst);
				dst +=3D bytes;
				if (!l) { l =3D 8; src++; }
			}
	=09
			if (n) {
				end_mask =3D 0;=09
				for (j =3D n; j > 0; j--) {
					l--;
					if (test_bit(l, (unsigned long *) src))
						end_mask |=3D (tmp >> (p->var.bits_per_pixel*(j-1)));
					if (!l) { l =3D 8; src++; }
				}
				fb_writel((end_mask & eorx)^bgx, (unsigned long *) dst);
				dst +=3D bytes;
			}
			l -=3D pad;	=09
			dst1 +=3D p->fix.line_length;=09
		}=09
	} else {
		/* Draw the penguin */
		n =3D ((image->width * p->var.bits_per_pixel) >> 3);
		end_mask =3D 0;
	}
}

--=-z9XGX2oo3DeYZDzemGo1--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: 2.5.42 compiler error in
	video/vga16fb.c
Date: 19 Oct 2002 18:56:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1035024946.1283.7.camel@daplas>
References: <Pine.LNX.4.33.0210180944520.10832-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kwGr4NZ2T/Gq0VMdXOJ5"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182rPi-0007rY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Oct 2002 04:05:03 -0700
In-Reply-To: <Pine.LNX.4.33.0210180944520.10832-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-kwGr4NZ2T/Gq0VMdXOJ5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-10-19 at 00:47, James Simmons wrote:
> 
> > It looks like that nobody is interested in VGA anymore. Are there
> > any objections against patch below? It is for current 2.5.42-bk,
> > and it fixes vga16fb compilability, and adds -depth 8 (to get 320x200, or
> > 360x480 in planar mode) and -depth 0 (to get fast textmode) to the vga16fb.
> 
> I'm working on it.
> 
> > If there are no objections, I'll split it up and send to Linus. But as
> 
> Wait. I have your work already in the fbdev BK tree. I'm porting it to the
> new api. I just need to write up a fillrect and copy area function for vga
> planes mode.
> 
I have a fillrect, copyarea and imageblit for vga16 since it was one of
the first drivers I tested with the new framework.  If you're too busy,
you may want to use them instead. Never posted it because I don't want
to preempt Petr.

Tony


--=-kwGr4NZ2T/Gq0VMdXOJ5
Content-Disposition: attachment; filename=vgacopyarea.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=vgacopyarea.c; charset=ISO-8859-1

/*
 *  linux/drivers/video/fbcon-vga-planes.c -- Low level frame buffer operat=
ions
 *				  for VGA 4-plane modes
 *
 * Copyright 1999 Ben Pfaff <pfaffben@debian.org> and Petr Vandrovec <VANDR=
OVE@vc.cvut.cz>
 * Based on code by Michael Schmitz
 * Based on the old macfb.c 4bpp code by Alan Cox
 *
 * This file is subject to the terms and conditions of the GNU General
 * Public License.  See the file COPYING in the main directory of this
 * archive for more details.  */

#include <linux/module.h>
#include <linux/tty.h>
#include <linux/console.h>
#include <linux/string.h>
#include <linux/fb.h>
#include <linux/vt_buffer.h>

#include <asm/io.h>

#include <video/fbcon.h>
#include <video/fbcon-vga-planes.h>

#include "vgaops.h"

void vgaplanes_copyarea(struct fb_info *p, struct fb_copyarea *area)
{
	int x, x2, y2, old_dx, old_dy, vxres, vyres;
	int height, width, line_ofs;
	char *dst =3D NULL, *src =3D NULL;

	vxres =3D p->var.xres_virtual;
	vyres =3D p->var.yres_virtual;
#ifdef FBCON_HAS_ROTATE
	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
		vxres =3D p->var.yres_virtual;
		vyres =3D p->var.xres_virtual;
	}
#endif

	if (area->dx > vxres ||=20
	    area->sx > vxres ||
	    area->dy > vyres ||
	    area->sy > vyres)
		return;

	/* clip the destination */
	old_dx =3D area->dx;
	old_dy =3D area->dy;

	/*
	 * We could use hardware clipping but on many cards you get around
	 * hardware clipping by writing to framebuffer directly.
	 */
	x2 =3D area->dx + area->width;
	y2 =3D area->dy + area->height;
	area->dx =3D area->dx > 0 ? area->dx : 0;
	area->dy =3D area->dy > 0 ? area->dy : 0;
	x2 =3D x2 < vxres ? x2 : vxres;
	y2 =3D y2 < vyres ? y2 : vyres;
	area->width =3D x2 - area->dx;
	area->height =3D y2 - area->dy;

	/* update sx1,sy1 */
	area->sx +=3D (area->dx - old_dx);
	area->sy +=3D (area->dy - old_dy);

	/* the source must be completely inside the virtual screen */
	if (area->sx < 0 || area->sy < 0 ||
	    (area->sx + area->width) > vxres ||
	    (area->sy + area->height) > vyres)
		return;

	width =3D area->width/8;
	height =3D area->height;
	line_ofs =3D p->fix.line_length - width;

	setmode(1);
	setop(0);
	setsr(0xf);

	if (area->dy < area->sy || (area->dy =3D=3D area->sy && area->dx < area->s=
x)) {
		dst =3D p->screen_base + (area->dx/8) + area->dy * p->fix.line_length;
		src =3D p->screen_base + (area->sx/8) + area->sy * p->fix.line_length;
		while (height--) {
			for (x =3D 0; x < width; x++) {
				readb(src);
				writeb(0, dst);
				dst++;
				src++;
			}
			src +=3D line_ofs;
			dst +=3D line_ofs;
		}
	} else {
		dst =3D p->screen_base + (area->dx/8) + width + (area->dy + height - 1) *=
 p->fix.line_length;
		src =3D p->screen_base + (area->sx/8) + width + (area->sy + height - 1) *=
 p->fix.line_length;
		while (height--) {
			for (x =3D 0; x < width; x++) {
				dst--;
				src--;
				readb(src);
				writeb(0, dst);
			}
			src -=3D line_ofs;
			dst -=3D line_ofs;
		}
	}
}

--=-kwGr4NZ2T/Gq0VMdXOJ5
Content-Disposition: attachment; filename=vgafillrect.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=vgafillrect.c; charset=ISO-8859-1

/*
 *  linux/drivers/video/fbcon-vga-planes.c -- Low level frame buffer operat=
ions
 *				  for VGA 4-plane modes
 *
 * Copyright 1999 Ben Pfaff <pfaffben@debian.org> and Petr Vandrovec <VANDR=
OVE@vc.cvut.cz>
 * Based on code by Michael Schmitz
 * Based on the old macfb.c 4bpp code by Alan Cox
 *
 * This file is subject to the terms and conditions of the GNU General
 * Public License.  See the file COPYING in the main directory of this
 * archive for more details.  */

#include <linux/module.h>
#include <linux/tty.h>
#include <linux/console.h>
#include <linux/string.h>
#include <linux/fb.h>
#include <linux/vt_buffer.h>

#include <asm/io.h>

#include <video/fbcon.h>
#include <video/fbcon-vga-planes.h>

#include "vgaops.h"

void vgaplanes_fillrect(struct fb_info *p, struct fb_fillrect *rect)
{
	int x, x2, y2, vxres, vyres;
	int width, height;
	int line_ofs;
	char *dst;

	vxres =3D p->var.xres_virtual;
	vyres =3D p->var.yres_virtual;
#ifdef FBCON_HAS_ROTATE
	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
		vxres =3D p->var.yres_virtual;
		vyres =3D p->var.xres_virtual;
	}
#endif

	if (!rect->width || !rect->height ||
	    rect->dx > vxres ||
	    rect->dy > vyres)
		return;

	/* We could use hardware clipping but on many cards you get around
	 * hardware clipping by writing to framebuffer directly. */

	x2 =3D rect->dx + rect->width;
	y2 =3D rect->dy + rect->height;
	x2 =3D x2 < vxres ? x2 : vxres;
	y2 =3D y2 < vyres ? y2 : vyres;
	rect->width =3D x2 - rect->dx;

	height =3D y2 - rect->dy;
	width =3D rect->width/8;

	line_ofs =3D p->fix.line_length - width;
	dst =3D p->screen_base + (rect->dx/8) + rect->dy * p->fix.line_length;

	switch (rect->rop) {
	case ROP_COPY:
		setmode(0);
		setop(0);
		setsr(0xf);
		setcolor(rect->color);
		selectmask();
	=09
		setmask(0xff);
	=09
		while (height--) {
			for (x =3D 0; x < width; x++) {
				writeb(0, dst);
				dst++;
			}
			dst +=3D line_ofs;
		}
		break;
	case ROP_XOR:
		setmode(0);
		setop(0x18);
		setsr(0xf);
		setcolor(0xf);
		selectmask();
	=09
		setmask(0xff);
		while (height--) {
			for (x =3D 0; x < width; x++) {
				rmw(dst);
				dst++;
			}
			dst +=3D line_ofs;
		}
		break;
	}
}

--=-kwGr4NZ2T/Gq0VMdXOJ5
Content-Disposition: attachment; filename=vgaimgblt.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=vgaimgblt.c; charset=ISO-8859-1

/*
 *  linux/drivers/video/fbcon-vga-planes.c -- Low level frame buffer operat=
ions
 *				  for VGA 4-plane modes
 *
 * Copyright 1999 Ben Pfaff <pfaffben@debian.org> and Petr Vandrovec <VANDR=
OVE@vc.cvut.cz>
 * Based on code by Michael Schmitz
 * Based on the old macfb.c 4bpp code by Alan Cox
 *
 * This file is subject to the terms and conditions of the GNU General
 * Public License.  See the file COPYING in the main directory of this
 * archive for more details.  */

#include <linux/module.h>
#include <linux/tty.h>
#include <linux/console.h>
#include <linux/string.h>
#include <linux/fb.h>
#include <linux/vt_buffer.h>

#include <asm/io.h>

#include <video/fbcon.h>
#include <video/fbcon-vga-planes.h>

#include "vgaops.h"

void vgaplanes_imageblit(struct fb_info *p, struct fb_image *image)
{
	int x2, y2, vxres, vyres, i, j;
	int fg =3D image->fg_color;
	int bg =3D image->bg_color;
	int width, height;
	char *src =3D image->data, *dst;

	vxres =3D p->var.xres_virtual;
	vyres =3D p->var.yres_virtual;

	/*=20
	 * We could use hardware clipping but on many cards you get around hardwar=
e
	 * clipping by writing to framebuffer directly like we are doing here.=20
	 */
	if (image->dx > vxres ||
	    image->dy > vyres)
		return;

	x2 =3D image->dx + image->width;
	y2 =3D image->dy + image->height;
	image->dx =3D image->dx > 0 ? image->dx : 0;
	image->dy =3D image->dy > 0 ? image->dy : 0;
	x2 =3D x2 < vxres ? x2 : vxres;
	y2 =3D y2 < vyres ? y2 : vyres;
	image->width  =3D x2 - image->dx;
	image->height =3D y2 - image->dy;

	width =3D image->width/8;
	height =3D image->height;

	setmode(2);
	setop(0);
	setsr(0xf);
	setcolor(fg);
	selectmask();

	setmask(0xff);
	dst =3D p->screen_base + (image->dx/8) + image->dy * p->fix.line_length;
	writeb(bg, dst);
	rmb();
	readb(dst);
	setmode(3);
	wmb();

	for (i =3D 0; i < height; i++) {
		char *dst1;

		dst1 =3D dst;
		for (j =3D 0; j < width; j++)=20
			writeb(*src++, dst1++);

		dst +=3D p->fix.line_length;
	}
	wmb();
}

void egaplanes_imageblit(struct fb_info *p, struct fb_image *image)
{
	int x2, y2, vxres, vyres, i, j;
	int fg =3D image->fg_color;
	int bg =3D image->bg_color;
	int width, height;
	char *src =3D image->data, *dst;

	vxres =3D p->var.xres_virtual;
	vyres =3D p->var.yres_virtual;

	/*=20
	 * We could use hardware clipping but on many cards you get around hardwar=
e
	 * clipping by writing to framebuffer directly like we are doing here.=20
	 */
	if (image->dx > vxres ||
	    image->dy > vyres)
		return;

	x2 =3D image->dx + image->width;
	y2 =3D image->dy + image->height;
	image->dx =3D image->dx > 0 ? image->dx : 0;
	image->dy =3D image->dy > 0 ? image->dy : 0;
	x2 =3D x2 < vxres ? x2 : vxres;
	y2 =3D y2 < vyres ? y2 : vyres;
	image->width  =3D x2 - image->dx;
	image->height =3D y2 - image->dy;

	width =3D image->width/8;
	height =3D image->height;

	setmode(2);
	setop(0);
	selectmask();

	setmask(0xff);
	dst =3D p->screen_base + (image->dx/8) + image->dy * p->fix.line_length;
	writeb(bg, dst);
	rmb();
	readb(dst);
	wmb();
	selectmask();
	for (i =3D 0; i < height; i++) {
		char *dst1;

		dst1 =3D dst;
		for (j =3D 0; j < width; j++) {
			outb(*src++, GRAPHICS_DATA_REG);
			wmb();
			writeb(fg, dst1++);
		}
		dst +=3D p->fix.line_length;
	}
	wmb();
}
		=09
		=09
	=09

--=-kwGr4NZ2T/Gq0VMdXOJ5
Content-Disposition: attachment; filename=vgaops.h
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=vgaops.h; charset=ISO-8859-1

/*
 *  linux/drivers/video/vgaops.h -- Low level frame buffer operations
 *				     for VGA 4-plane modes
 *
 * Copyright 1999 Ben Pfaff <pfaffben@debian.org> and Petr Vandrovec <VANDR=
OVE@vc.cvut.cz>
 * Based on code by Michael Schmitz
 * Based on the old macfb.c 4bpp code by Alan Cox
 *
 * This file is subject to the terms and conditions of the GNU General
 * Public License.  See the file COPYING in the main directory of this
 * archive for more details.  */


#define GRAPHICS_ADDR_REG 0x3ce		/* Graphics address register. */
#define GRAPHICS_DATA_REG 0x3cf		/* Graphics data register. */

#define SET_RESET_INDEX 0		/* Set/Reset Register index. */
#define ENABLE_SET_RESET_INDEX 1	/* Enable Set/Reset Register index. */
#define DATA_ROTATE_INDEX 3		/* Data Rotate Register index. */
#define GRAPHICS_MODE_INDEX 5		/* Graphics Mode Register index. */
#define BIT_MASK_INDEX 8		/* Bit Mask Register index. */

/* The VGA's weird architecture often requires that we read a byte and
   write a byte to the same location.  It doesn't matter *what* byte
   we write, however.  This is because all the action goes on behind
   the scenes in the VGA's 32-bit latch register, and reading and writing
   video memory just invokes latch behavior.

   To avoid race conditions (is this necessary?), reading and writing
   the memory byte should be done with a single instruction.  One
   suitable instruction is the x86 bitwise OR.  The following
   read-modify-write routine should optimize to one such bitwise
   OR. */
#define rmw(p) \
{ \
	readb(p); \
	writeb(1, p); \
} \

/* Set the Graphics Mode Register.  Bits 0-1 are write mode, bit 3 is
   read mode. */
#define setmode(mode)                                 \
{                                                     \
	outb(GRAPHICS_MODE_INDEX, GRAPHICS_ADDR_REG); \
	outb(mode, GRAPHICS_DATA_REG);                \
}

/* Select the Bit Mask Register. */
#define selectmask()                                  \
{                                                     \
	outb(BIT_MASK_INDEX, GRAPHICS_ADDR_REG);      \
}

/* Set the value of the Bit Mask Register.  It must already have been
   selected with selectmask(). */
#define setmask(mask)                                 \
{                                                     \
	outb(mask, GRAPHICS_DATA_REG);                \
}

/* Set the Data Rotate Register.  Bits 0-2 are rotate count, bits 3-4
   are logical operation (0=3DNOP, 1=3DAND, 2=3DOR, 3=3DXOR). */
#define setop(op)                                    \
{                                                    \
	outb(DATA_ROTATE_INDEX, GRAPHICS_ADDR_REG);  \
	outb(op, GRAPHICS_DATA_REG);                 \
}

/* Set the Enable Set/Reset Register.  The code here always uses value
   0xf for this register.  */
#define setsr(sr)                                        \
{                                                        \
	outb(ENABLE_SET_RESET_INDEX, GRAPHICS_ADDR_REG); \
	outb(sr, GRAPHICS_DATA_REG);                     \
}

/* Set the Set/Reset Register. */
#define setcolor(color)                              \
{                                                    \
	outb(SET_RESET_INDEX, GRAPHICS_ADDR_REG);    \
	outb(color, GRAPHICS_DATA_REG);              \
}

/* Set the value in the Graphics Address Register. */
#define setindex(index)                              \
{                                                    \
	outb(index, GRAPHICS_ADDR_REG);              \
}

--=-kwGr4NZ2T/Gq0VMdXOJ5--




-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD

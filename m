From: James Simmons <jsimmons@infradead.org>
Subject: New cfbimageblit
Date: Wed, 14 Apr 2004 19:45:54 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404141940460.14895-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDpOZ-0002aa-5Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:45:59 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BDpOY-0004l9-04
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:45:58 -0700
Received: from localhost ([127.0.0.1])
	by phoenix.infradead.org with esmtp (Exim 4.30 #5 (Red Hat Linux))
	id 1BDpOV-0003wN-MG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 19:45:55 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



Hi folks!!!

   I have been quite recently because I have been working on fixing 
cfb_imageblit. It had some nasty bugs. I pounded out all the bugs except 
for drawinfonts like 12x222 Sun fonts. I haven't fixed the problem yet so 
if anyone wants to give it a shot here it is.

/*
 *  Generic BitBLT function for frame buffer with packed pixels of any depth.
 *
 *      Copyright (C)  June 1999 James Simmons
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License.  See the file COPYING in the main directory of this archive for
 *  more details.
 *
 * NOTES:
 *
 *    This function copys a image from system memory to video memory. The
 *  image can be a bitmap where each 0 represents the background color and
 *  each 1 represents the foreground color. Great for font handling. It can
 *  also be a color image. This is determined by image_depth. The color image
 *  must be laid out exactly in the same format as the framebuffer. Yes I know
 *  their are cards with hardware that coverts images of various depths to the
 *  framebuffer depth. But not every card has this. All images must be rounded
 *  up to the nearest byte. For example a bitmap 12 bits wide must be two
 *  bytes width. 
 *
 *  Tony: 
 *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
 *  up the code significantly.
 *  
 *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which is
 *  still processed a bit at a time.   
 *
 *  Also need to add code to deal with cards endians that are different than
 *  the native cpu endians. I also need to deal with MSB position in the word.
 */
#include <linux/config.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/fb.h>
#include <asm/byteorder.h>
#include <asm/types.h>

#define DEBUG

#ifdef DEBUG
#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt,__FUNCTION__,## args)
#else
#define DPRINTK(fmt, args...)
#endif

static u32 cfb_tab8[] = {
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

static u32 cfb_tab16[] = {
#if defined(__BIG_ENDIAN)
    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
#elif defined(__LITTLE_ENDIAN)
    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
#else
#error FIXME: No endianness??
#endif
};

static u32 cfb_tab32[] = {
	0x00000000, 0xffffffff
};

#define FB_WRITEL fb_writel
#define FB_READL  fb_readl

#define SHIFT_HIGH(val, bits)	((val) << (bits))
#define SHIFT_LOW(val, bits)	((val) >> (bits))

static inline void slow_imageblit(const struct fb_image *image,
				struct fb_info *p, u8 *dst1,
				u32 start_index, u32 pitch_index)
{
	/* Draw the penguin */
	int spitch = (image->width * image->depth + 7) >> 3;
	int scan_align = p->pixmap.scan_align - 1;
	u32 *dst, *dst2, color = 0, val, shift;
	int i, n, bpp = p->var.bits_per_pixel;
	u32 *palette = (u32 *) p->pseudo_palette;
	int bits = p->pixmap.access_align << 3;
	u32 null_bits = bits - bpp;
	const u32 *src = (const u32 *) image->data;
	int mask = (1 << image->depth) - 1;
	u32 l = bits - image->depth;
	
	spitch = (spitch + scan_align) & ~scan_align;

	dst2 = (u32 *) dst1;
	for (i = image->height; i--; ) {
		dst = (u32 *) dst1;
		shift = 0, val = 0;
		n = image->width;
		
		/* write leading bits */
		if (start_index) {
			u32 start_mask = ~(SHIFT_HIGH(~(u32)0, start_index));
			val = FB_READL(dst) & start_mask;
			shift -= start_index;
		}

		while (n--) {
			if (image->depth == 1)
				color = (be32_to_cpu(*src) & (1 << l)) ? image->fg_color : image->bg_color;
			else
				color = (be32_to_cpu(*src) & (mask << l)) >> l;
				
			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
			    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
				color = palette[color];

			val |= SHIFT_HIGH(color, shift);

			/* Did the bitshift spill bits into the next long? */
			if (shift >= null_bits) {
				FB_WRITEL(val, dst++);
				val = (shift == null_bits) ? 0 : SHIFT_LOW(color, bits - shift);
			}
			shift += bpp;
			shift &= (bits - 1);

			if (!l) { src++; l = bits; }
			l -= image->depth;
		}

		l -= (8 - (image->width & 7)) * image->depth;
		
		/* write trailing bits */
		if (shift) {
			u32 end_mask = SHIFT_HIGH(~(u32)0, shift);

			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
		}

		dst1 += p->fix.line_length;
		if (pitch_index) {
			dst2 += p->fix.line_length;
			dst1 = (u8 *)((long)dst2 & ~(p->pixmap.access_align - 1));

			start_index += pitch_index;
			start_index &= bits - 1;
		}
	}
}

/*
 * fast_imageblit - optimized monochrome color expansion
 *
 * Only if:  bits_per_pixel == 8, 16, or 32
 *           image->width is divisible by pixel/dword (ppw);
 *           fix->line_legth is divisible by 4;
 *           beginning and end of a scanline is dword aligned
 */
static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p,
				  u8 *dst1)
{
	u32 fgx, fgcolor, bgx, bgcolor, bpp = p->var.bits_per_pixel;
	int bit_access = p->pixmap.access_align << 3;
	int scan_align = p->pixmap.scan_align - 1;
	int ppw = 32/bpp, spitch = (image->width + 7) >> 3;
	u32 bit_mask, end_mask, eorx, shift;
	const char *s = image->data, *src;
	u32 *dst, *tab = NULL;
	int i, j, k;

	spitch = (spitch + scan_align) & ~scan_align;

	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
	    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
		fgx = fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
		bgx = bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
	} else {
		fgx = fgcolor = image->fg_color;
		bgx = bgcolor = image->bg_color;
	}

	switch (bpp) {
	case 8:
		tab = cfb_tab8;
		break;
	case 16:
		tab = cfb_tab16;
		break;
	case 32:
		tab = cfb_tab32;
		break;
	}

	for (i = ppw-1; i--; ) {
		fgx <<= bpp;
		bgx <<= bpp;
		fgx |= fgcolor;
		bgx |= bgcolor;
	}

	bit_mask = (1 << ppw) - 1;
	eorx = fgx ^ bgx;
	k = (image->width * bpp)/bit_access;

	for (i = image->height; i--; ) {
		dst = (u32 *) dst1, shift = 8; src = s;

		for (j = k; j--; ) {
			shift -= ppw;
			end_mask = tab[(*src >> shift) & bit_mask];
			FB_WRITEL((end_mask & eorx)^bgx, dst++);
			if (!shift) { shift = 8; src++; }
		}
		dst1 += p->fix.line_length;
		s += spitch;
	}
}

void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
{
	u32 bpl = p->pixmap.access_align, bpp = p->var.bits_per_pixel;
	u32 width = image->width, height = image->height;
	u32 start_index, bitstart, pitch_index = 0;
	int x2, y2, vxres, vyres, bits = bpl << 3;
	u32 dx = image->dx, dy = image->dy;
	u8 *dst1;

	if (p->state != FBINFO_STATE_RUNNING)
		return;

	vxres = p->var.xres_virtual;
	vyres = p->var.yres_virtual;
	/*
	 * We could use hardware clipping but on many cards you get around
	 * hardware clipping by writing to framebuffer directly like we are
	 * doing here.
	 */
	if (image->dx > vxres || image->dy > vyres)
		return;

	x2 = image->dx + image->width;
	y2 = image->dy + image->height;
	dx = image->dx > 0 ? image->dx : 0;
	dy = image->dy > 0 ? image->dy : 0;
	x2 = x2 < vxres ? x2 : vxres;
	y2 = y2 < vyres ? y2 : vyres;
	width  = x2 - dx;
	height = y2 - dy;

	bitstart = ((dy * p->fix.line_length) << 3) + (dx * bpp);
	start_index = bitstart & (bits - 1);
	pitch_index = (p->fix.line_length & (bpl - 1)) << 3;

	bitstart >>= 3;
	bitstart &= ~(bpl - 1);
	dst1 = p->screen_base + bitstart;

	if (p->fbops->fb_sync)
		p->fbops->fb_sync(p);
/*
	if (bits % bpp == 0 && image->depth == 1 && !start_index && !pitch_index &&
	    bpp >= 8 && bpp <= 32 && ((width & (bits/bpp-1)) == 0)) {
		fast_imageblit(image, p, dst1);
	} else {
		if (image->depth <= bpp) */
			slow_imageblit(image, p, dst1, start_index, pitch_index);
	//}
}

EXPORT_SYMBOL(cfb_imageblit);

MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
MODULE_LICENSE("GPL");




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

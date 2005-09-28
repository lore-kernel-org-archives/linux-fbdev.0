From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: New driver: s3d2xfb
Date: Wed, 28 Sep 2005 16:46:02 +0600
Message-ID: <433A746A.1070202@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_ums.usu.ru-23515-1127904651-0001-2"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKZWi-0004UN-2W
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 03:51:04 -0700
Received: from relay4.usu.ru ([194.226.235.39])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKZWg-0001EC-5U
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 03:51:04 -0700
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 1356816BE8
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:51:00 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 068B516BE8
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:50:58 +0600 (YEKST)
Received: from localhost.usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 08C69A7A32
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:50:53 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 6C7E9A7A31
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:50:52 +0600 (YEKST)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ums.usu.ru-23515-1127904651-0001-2
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached is a (completely unaccelerated) framebuffer driver for S3 Trio 
3D/2X video cards. This is currently for out-of-tree testing, not for 
merging (although the license doesn't prohibit merging). Reason: this is 
my first kernel driver, and it has been tested only with my video card 
so far.

Signed-off-by: Alexander E. Patrakov

What works:

This driver works on my old video card with 2.6.14-rc1-mm1 and 2.6.12.5 
kernels. Applications tested: fbcon, jfbterm (has red <-> blue glitch), 
mplayer (doesn't like DirectColor modes, "fbset -nonstd 1"), fbxine 
(works perfectly), Xorg's "fbdev" driver.

Known bugs:

The "rom" file in sysfs is unreadable
"Snow" in high-resolution modes (but the MS Certified Win98 driver just 
gives pixel corruption in the same modes)
YWRAP may or may not work with cards that have 8MB of video memory.

Please send testing reports, including the "it just works" ones. Be sure 
to include the kernel version, driver messages and "lspci -n" output.

-- 
Alexander E. Patrakov

--=_ums.usu.ru-23515-1127904651-0001-2
Content-Type: text/plain; name=Makefile; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

KERNEL_DIR := /lib/modules/`uname -r`/build

module:
	make -C $(KERNEL_DIR) SUBDIRS=$(PWD) modules

obj-m += s3d2xfb.o

--=_ums.usu.ru-23515-1127904651-0001-2
Content-Type: text/x-csrc; name="s3d2xfb.c"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s3d2xfb.c"

/*
 * linux/drivers/video/s3d2xfb.c -- Framebuffer driver for S3 Trio 3D/2X
 *
 *  Created by Alexander E. Patrakov <patrakov at ums dot usu dot ru>
 *
 * Version history:
 *   20050928:
 *     First released version. Tested with my video card only. No acceleration.
 *     Support for all progressive non-doublescan resolutions
 *     Support for 8, 15, 16, 24 and 32 bpp
 *     Support for PseudoColor, TrueColor and DirectColor visuals
 *       (note: DirectColor is not supported in X.Org "s3virge" driver)
 *     Signed-off-by: Alexander E. Patrakov
 *
 *  My enhancements over the X.Org "s3virge" driver are marked by the
 *  "not in X.Org" label
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License. See the file COPYING in the main directory of Linux source for
 *  more details.
 *
 *  As a special exception, X.Org developers can use this file as if it
 *  carried the same license as X.Org.
 *
 */

#define VERSION "20050928"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/tty.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/pci.h>
#include <linux/fb.h>
#include <video/vga.h>
#include <linux/init.h>
#include <asm/mtrr.h>

#define S3_NEWMMIO_REGBASE      0x1000000	/* 16MB */
#define S3_NEWMMIO_REGSIZE        0x10000	/* 64KB */
#define S3V_MMIO_REGSIZE           0x8000	/* 32KB */
#define S3_NEWMMIO_VGAOFFSET       0x8000
#define S3_NEWMMIO_VGABASE      (S3_NEWMMIO_REGBASE + S3_NEWMMIO_VGAOFFSET)

#define QUARTZ_PERIOD KHZ2PICOS(14318)
#define DCLK_MIN_PERIOD KHZ2PICOS(270000)
#define DCLK_MAX_PERIOD KHZ2PICOS(16875)
#define PLL_MIN_PERIOD KHZ2PICOS(270000)
#define PLL_MAX_PERIOD KHZ2PICOS(135000)

/* These values match the bytes that one has
   to put into CR67 for a given depth */

#define FBBPP_8  0x00
#define FBBPP_15 0x30
#define FBBPP_16 0x50
#define FBBPP_24 0x70
/* 32 bpp: not in X.Org */
#define FBBPP_32 0xd0

/* Forward declarations */
static struct pci_driver s3d2xfb_driver;

struct parsed_mode {
	int hbstart, hsstart, hsend, htotal;	/* in characters */
	int line_length;
	int vbstart, vsstart, vsend, vtotal;	/* in lines */
	int fb_bpp;		/* see FBBPP_* above */
	int dot_n1, dot_n2, dot_m;
};

struct s3d2xfb_par {
	struct pci_dev *dev;
	void __iomem *io_virt;
	void __iomem *vgabase;
	size_t vram_size;
	size_t offscreen_size;	/* currently unused */
	atomic_t ref_count;
	int mtrr;
	u32 pseudo_palette[17];
	struct parsed_mode mode;
	struct fb_cmap cmap_mirror;	/* mirrors the hardware CLUT */

	struct vgastate vga_state;
	u8 CR35, CR38, CR39, CR53, CR58, SR08;
	u8 saved_VRAM[0x10000];
};

/* Saving and restoring registers {{{ */

/*
 * The basic idea is to pass all the work to save_vga()/restore_vga() pair.
 * This, however, doesn't work out of the box, because some registers
 * ("lockers") prevent/allow reading/writing of other registers. So
 * actually the save_vga()/restore_vga() pair works on the modified state
 * where lockers do allow reading/writing of all other registers. The
 * lockers themselves are saved/restored separately.
 *
 * Text is also saved separately because save_vga()/restore_vga() pair
 * assumes banked VGA addressing, while adressing is in fact linear.
 */

static void s3d2xfb_unlock_regs(struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	u8 vram_megs = par->vram_size / (1024 * 1024);

	vga_mm_wcrt(par->vgabase, 0x35, 0x00);
	vga_mm_wcrt(par->vgabase, 0x38, 0x48);
	vga_mm_wcrt(par->vgabase, 0x39, 0xa5);	/* XXX: not needed? */
	vga_mm_wcrt(par->vgabase, 0x53, 0x08);
	vga_mm_wcrt(par->vgabase, 0x58,
		    (vram_megs >= 4) ? 0x17 : (vram_megs == 2) ? 0x16 : 0x15);

	vga_mm_wseq(par->vgabase, 0x08, 0x06);
}

static void s3d2xfb_save_lockers(struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	par->CR35 = vga_mm_rcrt(par->vgabase, 0x35);
	par->CR38 = vga_mm_rcrt(par->vgabase, 0x38);
	par->CR39 = vga_mm_rcrt(par->vgabase, 0x39);
	par->CR53 = vga_mm_rcrt(par->vgabase, 0x53);
	par->CR58 = vga_mm_rcrt(par->vgabase, 0x58);

	par->SR08 = vga_mm_rseq(par->vgabase, 0x08);

}

static void s3d2xfb_restore_lockers(struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	vga_mm_wseq(par->vgabase, 0x08, par->SR08);

	vga_mm_wcrt(par->vgabase, 0x58, par->CR58);
	vga_mm_wcrt(par->vgabase, 0x53, par->CR53);
	vga_mm_wcrt(par->vgabase, 0x39, par->CR39);
	vga_mm_wcrt(par->vgabase, 0x38, par->CR38);
	vga_mm_wcrt(par->vgabase, 0x35, par->CR35);
}

static void save_s3(struct fb_info *info)
{
	int i;
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;

	s3d2xfb_save_lockers(info);
	s3d2xfb_unlock_regs(info);

	/* Fonts and text live in the first 64K */
	for (i = 0; i < sizeof(par->saved_VRAM); i++)
		par->saved_VRAM[i] = readb(info->screen_base + i);

	memset(&par->vga_state, 0, sizeof(par->vga_state));
	par->vga_state.vgabase = par->vgabase;
	par->vga_state.membase = info->fix.smem_start;
	par->vga_state.memsize = info->fix.smem_len;
	par->vga_state.flags = VGA_SAVE_MODE | VGA_SAVE_CMAP;
	par->vga_state.num_crtc = 0xa0;
	par->vga_state.num_seq = 0x28;
	save_vga(&par->vga_state);

	s3d2xfb_restore_lockers(info);
}

static void restore_s3(struct fb_info *info)
{
	int i;
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	s3d2xfb_unlock_regs(info);

	restore_vga(&par->vga_state);

	/* Restore fonts and text */
	for (i = 0; i < sizeof(par->saved_VRAM); i++)
		writeb(par->saved_VRAM[i], info->screen_base + i);

	s3d2xfb_restore_lockers(info);
}

static int s3d2xfb_open(struct fb_info *info, int user)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	int cnt = atomic_read(&par->ref_count);

	if (!cnt) {
		save_s3(info);
	}
	atomic_inc(&par->ref_count);
	return 0;
}

static int s3d2xfb_release(struct fb_info *info, int user)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	int cnt = atomic_read(&par->ref_count);

	if (!cnt)
		return -EINVAL;
	if (cnt == 1) {
		restore_s3(info);
	}
	atomic_dec(&par->ref_count);
	return 0;
}

/* }}} */

/* Mode parsing and validation {{{ */

static int s3d2xfb_parse_horiz_var(struct fb_var_screeninfo *var,
				   struct parsed_mode *mode, int write_back)
{
	int hbstart = var->xres;
	int hsstart = hbstart + var->right_margin;
	int hsend = hsstart + var->hsync_len;
	int htotal = hsend + var->left_margin;

	/* For simplicity with line_length - not a hardware limitation */
	int hvirt = (var->xres_virtual + 0x07) & (~0x07);
	int line_length = (hvirt * (var->bits_per_pixel / 8));

	/* The card accepts those values in "characters",
	 * 1 character = 8 pixels.
	 */

	mode->hbstart = (hbstart + 7) >> 3;
	mode->hsstart = (hsstart + 7) >> 3;
	mode->hsend = (hsend + 7) >> 3;
	mode->htotal = (htotal + 7) >> 3;
	mode->line_length = (line_length + 7) >> 3;

	/* Check bounds */

	if ((mode->htotal >= 0x200) || (mode->hbstart >= 0x200) || (mode->hsstart >= 0x200) || (mode->hsend <= mode->hsstart) || (mode->hsend >= mode->hsstart + 0x40) || (mode->htotal <= mode->hbstart) || (mode->htotal >= mode->hbstart + 0x80) || (mode->line_length >= 0x400))	/* FIXME: check line_length */
		return -EINVAL;

	if (write_back) {
		var->xres = mode->hbstart << 3;
		var->right_margin = (mode->hsstart - mode->hbstart) << 3;
		var->hsync_len = (mode->hsend - mode->hsstart) << 3;
		var->left_margin = (mode->htotal - mode->hsend) << 3;
		var->xres_virtual = hvirt;
	}
	return 0;
}

static int s3d2xfb_parse_vert_var(struct fb_var_screeninfo *var,
				  struct parsed_mode *mode, int write_back)
{
	mode->vbstart = var->yres;
	mode->vsstart = mode->vbstart + var->lower_margin;
	mode->vsend = mode->vsstart + var->vsync_len;
	mode->vtotal = mode->vsend + var->upper_margin;

	/* Check bounds */

	if ((mode->vtotal >= 0x800) ||
	    (mode->vbstart >= 0x800) ||
	    (mode->vsstart >= 0x800) ||
	    (mode->vsend <= mode->vsstart) ||
	    (mode->vsend >= mode->vsstart + 0x10) ||
	    (mode->vtotal <= mode->vbstart) ||
	    (mode->vtotal >= mode->vbstart + 0x100))
		return -EINVAL;
	/* Nothing is ever corrected in var */
	return 0;
}

static int s3d2xfb_parse_bpp(struct fb_var_screeninfo *var,
			     struct parsed_mode *mode, int write_back)
{
	switch (var->bits_per_pixel) {
	case 8:
		if (write_back) {
			var->red.offset = var->green.offset =
			    var->blue.offset = var->transp.offset = 0;
			var->red.length = var->green.length =
			    var->blue.length = var->transp.length = 8;
		}
		mode->fb_bpp = FBBPP_8;
		break;
	case 16:
		if (var->green.length < 6) {
			if (write_back) {
				var->blue.offset = 0;
				var->green.offset = 5;
				var->red.offset = 10;
				var->transp.offset = 15;
				var->red.length = var->green.length =
				    var->blue.length = 5;
				var->transp.length = 1;
			}
			mode->fb_bpp = FBBPP_15;
		} else {
			if (write_back) {
				var->blue.offset = 0;
				var->green.offset = 5;
				var->red.offset = 11;
				var->red.length = var->blue.length = 5;
				var->green.length = 6;
				var->transp.offset = 0;
				var->transp.length = 0;
			}
			mode->fb_bpp = FBBPP_16;
		}
		break;
	case 24:
		if (write_back) {
			var->blue.offset = 0;
			var->green.offset = 8;
			var->red.offset = 16;
			var->red.length = var->green.length =
			    var->blue.length = 8;
			var->transp.offset = 0;
			var->transp.length = 0;
		}
		mode->fb_bpp = FBBPP_24;
		break;
	case 32:
		if (write_back) {
			var->blue.offset = 0;
			var->green.offset = 8;
			var->red.offset = 16;
			var->transp.offset = 24;
			var->transp.length = var->red.length =
			    var->green.length = var->blue.length = 8;
		}
		mode->fb_bpp = FBBPP_32;
		break;
	default:
		return -EINVAL;
	}
	return 0;
}

static int s3d2xfb_parse_timing(struct fb_var_screeninfo *var,
				struct parsed_mode *mode, int write_back)
{
	/* The period is QUARTZ_PERIOD * (1 << n2) * n1 / m, constraints:
	   n1 / m * QUARTZ_PERIOD must be within the PLL limits
	   3 <= n1 <= 33, 0 <= n2 <=3, 3 <= m <= 129 */
	int psec = var->pixclock;
	int n1, m;
	int best_n1 = 3, best_m = 3;	/* Silence gcc "uninitialized" warning */
	int best_diff;
	int n2 = 0;
	if ((psec < DCLK_MIN_PERIOD) || (psec > DCLK_MAX_PERIOD))
		return -EINVAL;
	while (psec > DCLK_MIN_PERIOD * 2) {
		psec /= 2;
		n2++;
	}

	best_diff = psec;
	for (n1 = 3; n1 <= 33; n1++) {
		int period1 = QUARTZ_PERIOD * n1;
		int period2, diff;
		m = (2 * period1 + psec) / (2 * psec);
		if ((m < 3) || (m > 129))
			continue;
		period2 = period1 / m;
		diff = psec - period2;
		if (diff < 0)
			diff = -diff;
		if (diff < best_diff) {
			best_n1 = n1;
			best_m = m;
			best_diff = diff;
		}
	}
	mode->dot_n1 = best_n1;
	mode->dot_n2 = n2;
	mode->dot_m = best_m;
	if (write_back)
		var->pixclock = QUARTZ_PERIOD * (1 << n2) * best_n1 / best_m;
	return 0;
}

static int s3d2xfb_check_var(struct fb_var_screeninfo *var,
			     struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	struct parsed_mode tmp_mode;

	/* adjust timings and geometry, complain if the card won't accept them */
	if (s3d2xfb_parse_horiz_var(var, &tmp_mode, 1))
		return -EINVAL;
	if (s3d2xfb_parse_vert_var(var, &tmp_mode, 1))
		return -EINVAL;
	if ((var->xres_virtual < var->xres) || (var->yres_virtual < var->yres))
		return -EINVAL;
	if (s3d2xfb_parse_bpp(var, &tmp_mode, 1))
		return -EINVAL;
	if (s3d2xfb_parse_timing(var, &tmp_mode, 1))
		return -EINVAL;
	if (8 * tmp_mode.line_length * var->yres_virtual > par->vram_size)
		return -EINVAL;

	/* Not a hardware limitation */
	if ((var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
		return -EINVAL;

	/* FIXME: more checks here */
	return 0;
}

/* }}} */

/* Writing mode into the card's registers {{{ */

static void s3d2xfb_misc_regs(struct fb_info *info)
{
	int i;
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	/* VGA */
	vga_mm_wcrt(par->vgabase, 0x11, vga_mm_rcrt(par->vgabase, 0x11) & 0x7f);

	vga_mm_wcrt(par->vgabase, 0x08, 0x00);
	vga_mm_wcrt(par->vgabase, 0x0a, 0x00);
	vga_mm_wcrt(par->vgabase, 0x0b, 0x00);
	vga_mm_wcrt(par->vgabase, 0x0e, 0x00);
	vga_mm_wcrt(par->vgabase, 0x0f, 0x00);
	vga_mm_wcrt(par->vgabase, 0x14, 0x00);
	vga_mm_wcrt(par->vgabase, 0x17, 0xc3);

	vga_mm_wseq(par->vgabase, 0x00, 0x00);
	vga_mm_wseq(par->vgabase, 0x01, 0x01);
	vga_mm_wseq(par->vgabase, 0x02, 0x0f);
	vga_mm_wseq(par->vgabase, 0x03, 0x00);
	vga_mm_wseq(par->vgabase, 0x04, 0x0e);

	vga_mm_r(par->vgabase, 0x3da);
	for (i = 0; i <= 0x0f; i++)
		vga_mm_wattr(par->vgabase, i | 0x20, i);
	vga_mm_wattr(par->vgabase, 0x10 | 0x20, 0x41);
	vga_mm_wattr(par->vgabase, 0x11 | 0x20, 0x0f);
	vga_mm_wattr(par->vgabase, 0x12 | 0x20, 0x00);
	vga_mm_wattr(par->vgabase, 0x13 | 0x20, 0x00);
	vga_mm_wattr(par->vgabase, 0x14 | 0x20, 0x00);

	vga_mm_wgfx(par->vgabase, 0x00, 0x00);
	vga_mm_wgfx(par->vgabase, 0x01, 0x00);
	vga_mm_wgfx(par->vgabase, 0x02, 0x00);
	vga_mm_wgfx(par->vgabase, 0x03, 0x00);
	vga_mm_wgfx(par->vgabase, 0x04, 0x00);
	vga_mm_wgfx(par->vgabase, 0x05, 0x40);
	vga_mm_wgfx(par->vgabase, 0x06, 0x05);
	vga_mm_wgfx(par->vgabase, 0x07, 0x0f);
	vga_mm_wgfx(par->vgabase, 0x08, 0xff);

	vga_mm_w(par->vgabase, VGA_MIS_W, 0x2f |
		 ((info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x40) |
		 ((info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x80));

	/* S3 extended, the bare minimum */
	vga_mm_wcrt(par->vgabase, 0x31, 0x0c);	/* Is 0x8c just as good? */
	vga_mm_wcrt(par->vgabase, 0x32, 0x40);	/* Is 0x00 just as good? */
	vga_mm_wcrt(par->vgabase, 0x33, 0x20);
	vga_mm_wcrt(par->vgabase, 0x34, 0x10);	/* is 0x00 just as good? */
	vga_mm_wcrt(par->vgabase, 0x3a, 0x15);	/* is 0x10 just as good? */
	vga_mm_wcrt(par->vgabase, 0x66, 0x89);

}

static void s3d2xfb_set_horiz_par(struct fb_info *info)
{
	/* vgaHW.c from XFree86 sugests that there are some off-by-one errors */

	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	int CR3Bext;

	s3d2xfb_parse_horiz_var(&info->var, &par->mode, 0);

	CR3Bext = (par->mode.hsstart + par->mode.htotal - 5) / 2;	/* FIXME: check against win98 */

	vga_mm_wcrt(par->vgabase, 0x00, (par->mode.htotal - 5) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x01, (par->mode.hbstart - 1) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x02, (par->mode.hbstart - 1) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x03, (par->mode.htotal & 0x1f) | 0x80);
	vga_mm_wcrt(par->vgabase, 0x04, par->mode.hsstart & 0xff);
	vga_mm_wcrt(par->vgabase, 0x05,
		    ((par->mode.htotal & 0x20) << 2) | (par->mode.
							hsend & 0x1f));
	vga_mm_wcrt(par->vgabase, 0x13, par->mode.line_length & 0xff);
	vga_mm_wcrt(par->vgabase, 0x3b, CR3Bext & 0xff);
	vga_mm_wcrt(par->vgabase, 0x3c, par->mode.htotal / 2);
	vga_mm_wcrt(par->vgabase, 0x5d,
		    (((par->mode.htotal -
		       5) & 0x100) >> 8) | (((par->mode.hbstart -
					      1) & 0x100) >> 7) | (((par->mode.
								     hbstart -
								     1) & 0x100)
								   >> 6) |
		    (par->mode.htotal - par->mode.hbstart >=
		     64 ? 0x08 : 0) | ((par->mode.
					hsstart & 0x100) >> 4) | (par->mode.
								  hsend -
								  par->mode.
								  hsstart >
								  32 ? 0x20 : 0)
		    | ((CR3Bext & 0x100) >> 2));
	vga_mm_wcrt(par->vgabase, 0x43, 0x08);
	vga_mm_wcrt(par->vgabase, 0x51, (par->mode.line_length & 0x300) >> 4);	/* WARNING: bit 7 enables EPROM write */
	vga_mm_wcrt(par->vgabase, 0x90, (par->mode.line_length >> 8) | 0x80);
	vga_mm_wcrt(par->vgabase, 0x91, par->mode.line_length & 0xff);
	info->fix.line_length = par->mode.line_length << 3;
}

static void s3d2xfb_set_vert_par(struct fb_info *info)
{
	/* vgaHW.c from XFree86 sugests that there are some off-by-one errors */

	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;

	s3d2xfb_parse_vert_var(&info->var, &par->mode, 0);

	vga_mm_wcrt(par->vgabase, 0x06, (par->mode.vtotal - 2) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x10, par->mode.vsstart & 0xff);
	vga_mm_wcrt(par->vgabase, 0x11, (par->mode.vsend & 0x0f) | 0x20);
	vga_mm_wcrt(par->vgabase, 0x12, (par->mode.vbstart - 1) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x15, par->mode.vbstart & 0xff);
	vga_mm_wcrt(par->vgabase, 0x16, par->mode.vtotal & 0xff);
	vga_mm_wcrt(par->vgabase, 0x18, 0xff);
	vga_mm_wcrt(par->vgabase, 0x07,
		    (((par->mode.vtotal -
		       2) & 0x100) >> 8) | (((par->mode.vbstart -
					      1) & 0x100) >> 7) | ((par->mode.
								    vsstart &
								    0x100) >> 6)
		    | ((par->mode.vbstart & 0x100) >> 5) | 0x10 |
		    (((par->mode.vtotal -
		       2) & 0x200) >> 4) | (((par->mode.vbstart -
					      1) & 0x200) >> 3) | ((par->mode.
								    vsstart &
								    0x200) >>
								   2));
	vga_mm_wcrt(par->vgabase, 0x09,
		    ((par->mode.vbstart & 0x200) >> 4) | 0x40);
	vga_mm_wcrt(par->vgabase, 0x5e,
		    (((par->mode.vtotal -
		       2) & 0x400) >> 10) | (((par->mode.vbstart -
					       1) & 0x400) >> 9) | ((par->mode.
								     vbstart &
								     0x400) >>
								    8) | ((par->
									   mode.
									   vsstart
									   &
									   0x400)
									  >> 7)
		    | 0x40);
}

static int s3d2xfb_set_bpp(struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;

	s3d2xfb_parse_bpp(&info->var, &par->mode, 0);
	vga_mm_wcrt(par->vgabase, 0x67, par->mode.fb_bpp);

	info->fix.xpanstep = (info->var.bits_per_pixel == 24) ?
	    4 : (32 / info->var.bits_per_pixel);

	if (par->mode.fb_bpp == FBBPP_8) {
		vga_mm_wseq(par->vgabase, 0x1b, 0x00);
		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
	} else {
		if (info->var.nonstd) {
			/* DirectColor: not in X.Org */
			vga_mm_wseq(par->vgabase, 0x1b, 0x18);
			info->fix.visual = FB_VISUAL_DIRECTCOLOR;
		} else {
			vga_mm_wseq(par->vgabase, 0x1b, 0);
			info->fix.visual = FB_VISUAL_TRUECOLOR;
		}
	}
	return 0;
}

static void s3d2xfb_set_timings(struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	s3d2xfb_parse_timing(&info->var, &par->mode, 0);

	vga_mm_wseq(par->vgabase, 0x12, (par->mode.dot_n2 << 6) |
		    (par->mode.dot_n1 - 2));
	vga_mm_wseq(par->vgabase, 0x13, par->mode.dot_m - 2);

	/* Make sure that timings apply */
	vga_mm_wseq(par->vgabase, 0x15, 0x00);
	vga_mm_wseq(par->vgabase, 0x15, 0x20);
	vga_mm_wseq(par->vgabase, 0x15, 0x00);

}

static int s3d2xfb_set_par(struct fb_info *info)
{
	s3d2xfb_unlock_regs(info);
	s3d2xfb_misc_regs(info);
	s3d2xfb_set_horiz_par(info);
	s3d2xfb_set_vert_par(info);
	s3d2xfb_set_timings(info);
	s3d2xfb_set_bpp(info);
	return 0;
}

/* }}} */

/* Setting colormap {{{ */

static int s3d2xfb_write_clut(unsigned regno, unsigned red, unsigned green,
			      unsigned blue, struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	vga_mm_w(par->vgabase, 0x3c8, regno);
	vga_mm_w(par->vgabase, 0x3c9, red);
	vga_mm_w(par->vgabase, 0x3c9, green);
	vga_mm_w(par->vgabase, 0x3c9, blue);
	par->cmap_mirror.red[regno] = red;
	par->cmap_mirror.green[regno] = green;
	par->cmap_mirror.blue[regno] = blue;
	return 0;
}

static int s3d2xfb_setcolreg(unsigned regno, unsigned red, unsigned green,
			     unsigned blue, unsigned transp,
			     struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	int i;

	red >>= 8;
	green >>= 8;
	blue >>= 8;
	transp >>= 8;

	if (regno >= 256)
		return -EINVAL;

	switch (par->mode.fb_bpp) {
	case FBBPP_8:
		if (regno < 16)
			((u32 *) (info->pseudo_palette))[regno] =
			    regno * 0x1010101;
		/* FIXME is there any way for this card to accept 8-bit
		   values for colormap entries? Right now they are rounded
		   down to 6 bits */
		s3d2xfb_write_clut(regno, red >> 2, green >> 2, blue >> 2,
				   info);
		break;
	case FBBPP_15:
		if (regno >= 32)
			return -EINVAL;
		if (regno < 16)
			((u32 *) (info->pseudo_palette))[regno] =
			    ((red & 0xf8) << 7) |
			    ((green & 0xf8) << 2) | ((blue & 0xf8) >> 3);
		for (i = regno << 3; i < (regno + 1) << 3; i++)
			s3d2xfb_write_clut(i, red, green, blue, info);
		break;
	case FBBPP_16:
		if (regno >= 64)
			return -EINVAL;
		if (regno < 16)
			((u32 *) (info->pseudo_palette))[regno] =
			    ((red & 0xf8) << 8) |
			    ((green & 0xfc) << 3) | ((blue & 0xf8) >> 3);
		/* The stuff below is written under the assumption that
		   Xorg issues proper ioctls on /dev/fb0 here */

		if (regno < 32)
			for (i = regno << 3; i < (regno + 1) << 3; i++) {
				s3d2xfb_write_clut(i, red,
						   par->cmap_mirror.green[i],
						   blue, info);
			}

		for (i = regno << 2; i < (regno + 1) << 2; i++) {
			s3d2xfb_write_clut(i, par->cmap_mirror.red[i],
					   green, par->cmap_mirror.blue[i],
					   info);
		}
		break;
	case FBBPP_24:
	case FBBPP_32:
		if (regno < 16)
			((u32 *) (info->pseudo_palette))[regno] =
			    (red << 16) | (green << 8) | (blue);
		s3d2xfb_write_clut(regno, red, green, blue, info);
		break;
	}
	return 0;
}

/* }}} */

/* Panning the display {{{ */

static int s3d2xfb_pan_display(struct fb_var_screeninfo *var,
			       struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	unsigned yend = (var->vmode & FB_VMODE_YWRAP) ?
	    var->yoffset : (var->yoffset + info->var.yres);

	if ((var->xoffset + info->var.xres > info->var.xres_virtual) ||
	    (yend > info->var.yres_virtual))
		return -EINVAL;
	int start_address =
	    var->xoffset + (info->var.xres_virtual * var->yoffset);
	start_address = (start_address * info->var.bits_per_pixel) / 32;
	if (info->var.bits_per_pixel == 24)
		start_address = (start_address / 3) * 3;
	vga_mm_wcrt(par->vgabase, 0x0c, (start_address >> 8) & 0xff);
	vga_mm_wcrt(par->vgabase, 0x0d, start_address & 0xff);
	vga_mm_wcrt(par->vgabase, 0x69, ((start_address & 0xf0000) >> 16));

	return 0;
}

/* }}} */

/* Blanking the display {{{ */

static int s3d2xfb_blank(int blank, struct fb_info *info)
{
	struct s3d2xfb_par *par = (struct s3d2xfb_par *)info->par;
	switch (blank) {
	case FB_BLANK_UNBLANK:
	case FB_BLANK_NORMAL:
		vga_mm_wseq(par->vgabase, 0x0d, 0x00);
		break;
	case FB_BLANK_VSYNC_SUSPEND:
		vga_mm_wseq(par->vgabase, 0x0d, 0x10);
		break;
	case FB_BLANK_HSYNC_SUSPEND:
		vga_mm_wseq(par->vgabase, 0x0d, 0x40);
		break;
	case FB_BLANK_POWERDOWN:
		vga_mm_wseq(par->vgabase, 0x0d, 0x50);
		break;
	default:
		return -EINVAL;
	}
	return (blank == FB_BLANK_NORMAL) ? 1 : 0;
}

/* }}} */

/* Enable MMIO using VGA registers */
static void s3d2xfb_enable_mmio(const struct pci_dev *dev)
{
	unsigned char val, val1;
	/* Enable VGA display */
	val = inb(0x3c3);
	outb(val | 0x01, 0x3c3);
	/* Set Color mode */
	val = inb(0x3cc);
	outb(val | 0x01, 0x3c2);

	/* Enable new MMIO? Disagrees with S3.TXT */
	outb(0x53, 0x3d4);
	val1 = inb(0x3d5);
	outb(val1 | 0x08, 0x3d5);

	/* Restore Color/Monochrome mode as it was before this function */
	outb(val, 0x3c2);
}

static int s3d2xfb_get_vram_size(struct s3d2xfb_par *par)
{
	u8 config1 = vga_mm_rcrt(par->vgabase, 0x36);

	switch ((config1 & 0xE0) >> 5) {
	case 0:		/* 8MB -- only 4MB usable for display/cursor */
		par->vram_size = 4 * 1024 * 1024;
		par->offscreen_size = 4 * 1024 * 1024;
		break;
	case 1:		/* 32 bit interface -- yuck */
		par->vram_size = 4 * 1024 * 1024;
		par->offscreen_size = 0;
		break;
	case 2:
		par->vram_size = 4 * 1024 * 1024;
		par->offscreen_size = 0;
		break;
	case 6:
		par->vram_size = 2 * 1024 * 1024;
		par->offscreen_size = 0;
		break;
	default:
		printk(KERN_ERR "s3d2xfb: can't determine VRAM size\n");
		return -ENODEV;
	}
	return 0;
}

int __init s3d2xfb_init(void)
{
	printk(KERN_INFO "s3d2xfb: version %s loaded\n", VERSION);
	/*
	 *  For kernel boot options (in 'video=xxxfb:<options>' format)
	 */
#ifndef MODULE
	char *option = NULL;

	if (fb_get_options("s3d2xfb", &option))
		return -ENODEV;
	s3d2xfb_setup(option);
#endif
	return pci_register_driver(&s3d2xfb_driver);
}

static void __exit s3d2xfb_cleanup(void)
{
	pci_unregister_driver(&s3d2xfb_driver);
}

static char *mode __devinitdata = NULL;
static int nomtrr __devinitdata = 0;

int __init s3d2xfb_setup(char *options)
{
	char *this_opt;

	if (!options || !*options)
		return 0;

	while ((this_opt = strsep(&options, ",")) != NULL) {
		if (!strncmp(this_opt, "nomtrr", 6)) {
			nomtrr = 1;
		} else {
			mode = this_opt;
		}
	}
	return 0;
}

static struct fb_ops s3d2xfb_ops = {
	.owner = THIS_MODULE,
	.fb_open = s3d2xfb_open,
	.fb_release = s3d2xfb_release,
	.fb_check_var = s3d2xfb_check_var,
	.fb_set_par = s3d2xfb_set_par,
	.fb_setcolreg = s3d2xfb_setcolreg,
	.fb_blank = s3d2xfb_blank,
	.fb_pan_display = s3d2xfb_pan_display,
	.fb_fillrect = cfb_fillrect,	/* Needed !!! */
	.fb_copyarea = cfb_copyarea,	/* Needed !!! */
	.fb_imageblit = cfb_imageblit,	/* Needed !!! */
	.fb_cursor = soft_cursor,	/* Needed !!! */
};

static struct fb_fix_screeninfo s3d2xfb_fix __initdata = {
	.id = "S3 Trio 3D/2X",
	.type = FB_TYPE_PACKED_PIXELS,
	.visual = FB_VISUAL_PSEUDOCOLOR,
	.xpanstep = 4,
	.ypanstep = 1,
	.ywrapstep = 1,
	.accel = FB_ACCEL_NONE,
};

/* PCI stuff */

static struct pci_device_id s3d2xfb_pci_tbl[] = {
	{PCI_VENDOR_ID_S3, 0x8A13,
	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{0,}			/* terminate list */
};

MODULE_DEVICE_TABLE(pci, s3d2xfb_pci_tbl);

static struct fb_var_screeninfo __devinitdata s3d2xfb_default_var = {
	.xres = 640,
	.yres = 480,
	.xres_virtual = 640,
	.yres_virtual = 480,
	.bits_per_pixel = 8,
	.red = {0, 8, 0},
	.green = {0, 8, 0},
	.blue = {0, 8, 0},
	.transp = {0, 0, 0},
	.activate = FB_ACTIVATE_NOW,
	.height = -1,
	.width = -1,
	.pixclock = 39721,
	.left_margin = 40,
	.right_margin = 24,
	.upper_margin = 32,
	.lower_margin = 11,
	.hsync_len = 96,
	.vsync_len = 2,
	.vmode = FB_VMODE_NONINTERLACED
};

static int __devinit s3d2xfb_pci_probe(struct pci_dev *dev,
				       const struct pci_device_id *id)
{
	struct fb_info *info;
	struct s3d2xfb_par *par;
	int err;

	err = pci_enable_device(dev);
	if (err) {
		printk(KERN_ERR "s3d2xfb: could not enable device!\n");
		goto err_enable_device;
	}
	/* Ignore failures in the following line */
	request_region(0x3c0, 32, "s3d2xfb");

	err = pci_request_regions(dev, "s3d2xfb");
	if (err) {
		printk(KERN_ERR "s3d2xfb: could not request regions!\n");
		goto err_request_regions;
	}

	err = -ENOMEM;
	info = framebuffer_alloc(sizeof(struct s3d2xfb_par), &dev->dev);
	if (!info) {
		printk(KERN_ERR "s3d2xfb: failed to allocate memory\n");
		goto err_alloc;
	}
	/* error checking goes here */
	info->fix = s3d2xfb_fix;

	par = (struct s3d2xfb_par *)(info->par);
	par->dev = dev;

	s3d2xfb_enable_mmio(dev);

	info->fix.mmio_start = pci_resource_start(dev, 0) + S3_NEWMMIO_REGBASE;
	info->fix.mmio_len = S3_NEWMMIO_REGSIZE;
	par->io_virt = ioremap(info->fix.mmio_start, info->fix.mmio_len);
	par->vgabase = par->io_virt + S3_NEWMMIO_VGAOFFSET;

	if (!par->io_virt) {
		printk(KERN_ERR "s3d2xfb: failed to ioremap mmio registers\n");
		goto err_ioremap1;
	}

	if (!s3d2xfb_get_vram_size(par))
		printk(KERN_INFO
		       "s3d2xfb: found S3 Trio 3D/2X video card, VRAM size = %d MB"
		       " (plus %d MB offscreen)\n",
		       par->vram_size / (1024 * 1024),
		       par->offscreen_size / (1024 * 1024));
	else {
		printk(KERN_ERR "s3d2xfb: could not determine VRAM size\n");
		goto err_vram_size;
	}

	info->fix.smem_start = pci_resource_start(dev, 0);
	info->fix.smem_len = par->vram_size + par->offscreen_size;

	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
	if (!info->screen_base) {
		printk(KERN_ERR "s3d2xfb: failed to ioremap framebuffer\n");
		goto err_ioremap2;
	}
	info->screen_size = par->vram_size;

	par->mtrr = nomtrr ? -1 : mtrr_add(info->fix.smem_start,
					   info->fix.smem_len,
					   MTRR_TYPE_WRCOMB, 1);

	info->fbops = &s3d2xfb_ops;
	info->pseudo_palette = &par->pseudo_palette;
	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_XPAN |
	    FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_YWRAP;
	if (fb_alloc_cmap(&info->cmap, 256, 0))
		goto err_cmap1;
	if (fb_alloc_cmap(&par->cmap_mirror, 256, 0))
		goto err_cmap2;

	info->var = s3d2xfb_default_var;

	if (!mode)
		mode = "640x480-8@60";
	err = fb_find_mode(&info->var, info, mode, NULL, 0, NULL, 8);
	if (!err || err == 4)
		info->var = s3d2xfb_default_var;

	pci_set_drvdata(dev, info);

	if (register_framebuffer(info) < 0)
		return -EINVAL;
	return 0;

      err_cmap2:
	fb_dealloc_cmap(&info->cmap);
      err_cmap1:
	iounmap(info->screen_base);
      err_ioremap2:
	iounmap(par->io_virt);
      err_vram_size:
      err_ioremap1:
	framebuffer_release(info);
      err_alloc:
	pci_release_regions(dev);
      err_request_regions:
	pci_disable_device(dev);
      err_enable_device:
	return err;
}

void s3d2xfb_remove(struct pci_dev *dev)
{
	struct fb_info *info;
	struct s3d2xfb_par *par;

	info = pci_get_drvdata(dev);
	par = (struct s3d2xfb_par *)(info->par);

	if (par->mtrr >= 0)
		mtrr_del(par->mtrr, 0, 0);

	iounmap(par->io_virt);
	iounmap(info->screen_base);
	unregister_framebuffer(info);
	fb_dealloc_cmap(&par->cmap_mirror);
	fb_dealloc_cmap(&info->cmap);
	framebuffer_release(info);

	pci_release_regions(dev);
	pci_disable_device(dev);
}

static struct pci_driver s3d2xfb_driver = {
	.name = "s3d2xfb",
	.id_table = s3d2xfb_pci_tbl,
	.probe = s3d2xfb_pci_probe,
	.remove = __exit_p(s3d2xfb_remove),
};

module_param(mode, charp, 0);
MODULE_PARM_DESC(mode, "Preferred video mode e.g. '648x480-8@60'");

module_param(nomtrr, int, 0);
MODULE_PARM_DESC(nomtrr, "Disables MTRR support");

module_init(s3d2xfb_init);
module_exit(s3d2xfb_cleanup);
MODULE_LICENSE("GPL");

--=_ums.usu.ru-23515-1127904651-0001-2--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

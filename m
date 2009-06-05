From: amaora <nemashinist@rambler.ru>
Subject: True color framebuffer
Date: Sat, 6 Jun 2009 01:25:17 +0400
Message-ID: <20090605212517.GA19565@core>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nemashinist@rambler.ru>) id 1MCgrY-00059Y-Vk
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 21:22:08 +0000
Received: from maild.rambler.ru ([81.19.66.33])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCgqH-0002l9-Sj for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 21:22:03 +0000
Received: from localhost (unknown [83.149.41.16])
	(Authenticated sender: nemashinist@rambler.ru)
	by maild.rambler.ru (Postfix) with ESMTP id 8C91584415
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  6 Jun 2009 01:20:40 +0400 (MSD)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

I write framebuffer driver for the PCF8833, it work, but only if
xxx_fix.visual == FB_VISUAL_PSEUDOCOLOR, TRUECOLOR/DIRECTCOLOR don't work.
Kernel is blocked (stalled) in function register_framebuffer on line
fb_notifier_call_chain(...), i don't know how to find stall point more deep.
Why this happening?

Thanks,

Roman Belov


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="pcf8833.c"

/*
 * Copyright (C) 2009, Roman Belov
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License. See the file COPYING in the main directory of this archive for
 * more details.
 *
 * Layout is based on pcf8833.c by Alexander Kudjashev
 *
 * This driver was written to be used with nokia 6100 lcd
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/delay.h>
#include <linux/fb.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>
#include <linux/spinlock.h>

#define PCF8833_FB_MIRROR_X		0x00000040
#define PCF8833_FB_MIRROR_Y		0x00000080
#define PCF8833_FB_SWAP_XY		0x00000020

#define PCF8833_FB_3R3G2B		0x00000200
#define PCF8833_FB_4R4G4B		0x00000300
#define PCF8833_FB_5R6G5B		0x00000500

#define PCF8833_FB_WIDTH		130
#define PCF8833_FB_HEIGHT		130
#define PCF8833_FB_XOFF			1
#define PCF8833_FB_YOFF			1
#define PCF8833_FB_DEFCBITS		16

#define PCF8833_FB_MEMSIZE		(PCF8833_FB_WIDTH*PCF8833_FB_HEIGHT*PCF8833_FB_DEFCBITS/8)
#define PCF8833_FB_BUFFSIZE		(PCF8833_FB_MEMSIZE*2 + 7*2)

#define PCF8833_FB_QUEUESIZE		1024
#define PCF8833_FB_QUEUE_INC(val)	(((val)+1)&(PCF8833_FB_QUEUESIZE-1))

union pcf8833_rect {
	u32 _32;
	u8 _8[4];
};

struct pcf8833_queue {
	u32 buff[PCF8833_FB_QUEUESIZE];
	volatile int r, w;
};

static inline void
pcf8833_queue_init(struct pcf8833_queue *q)
{
	q->r = 0;
	q->w = 0;
}

static inline int
pcf8833_queue_read(struct pcf8833_queue *q, u32 *ret)
{
	int r = q->r;

	if (r != q->w) {
		*ret = q->buff[r];
		q->r = PCF8833_FB_QUEUE_INC(r);
		return 0;
	}

	return -1;
}

static inline int
pcf8833_queue_write(struct pcf8833_queue *q, u32 val)
{
	int w = q->w;
	int wn = PCF8833_FB_QUEUE_INC(w);

	if (q->r != wn) {
		q->buff[w] = val;
		q->w = wn;
		return 0;
	}

	return -1;
}

typedef u16 pixel_t;

struct pcf8833_par {
	struct spi_device *spi;
	struct spi_message msg;
	struct spi_transfer xfer;
	struct pcf8833_queue queue;
	u16 *buffer;
	pixel_t *screen;
};

static struct fb_fix_screeninfo pcf8833_fix __devinitdata = {
	.id             = "pcf8833",
	.type           = FB_TYPE_PACKED_PIXELS,
	.visual         = FB_VISUAL_PSEUDOCOLOR,
	.xpanstep       = 0,
	.ypanstep       = 0,
	.ywrapstep      = 0,
	.line_length    = PCF8833_FB_WIDTH * PCF8833_FB_DEFCBITS / 8,
	.accel          = FB_ACCEL_NONE
};

static struct fb_var_screeninfo pcf8833_var __devinitdata = {
	.xres           = PCF8833_FB_WIDTH,
	.yres           = PCF8833_FB_HEIGHT,
	.xres_virtual   = PCF8833_FB_WIDTH,
	.yres_virtual   = PCF8833_FB_HEIGHT,
	.height         = -1,
	.width          = -1,
	.activate       = FB_ACTIVATE_NOW,
	.vmode          = FB_VMODE_NONINTERLACED,
	.bits_per_pixel = PCF8833_FB_DEFCBITS,
	.red            = { 11, 5, 0 },
	.green          = { 5, 6, 0 },
	.blue           = { 0, 5, 0 },
	.nonstd         = 0
};

static void
pcf8833_command(struct spi_device *spi, u8 cmd)
{
	u16 w = (u16) cmd;
	spi_write(spi, (u8*)&w, 2);
}

static void
pcf8833_data(struct spi_device *spi, u8 data)
{
	u16 w = (u16) data | 0x0100;
	spi_write(spi, (u8*)&w, 2);
}

static int
pcf8833_blank(int blank_mode, struct fb_info *info)
{
	struct pcf8833_par *par = info->par;

	switch (blank_mode) {
		case FB_BLANK_UNBLANK:
			pcf8833_command(par->spi, 0x29);
			break;
		case FB_BLANK_NORMAL:
		case FB_BLANK_VSYNC_SUSPEND:
		case FB_BLANK_HSYNC_SUSPEND:
		case FB_BLANK_POWERDOWN:
			pcf8833_command(par->spi, 0x28);
			break;
		default:
			return -EINVAL;
	}

	return 0;
}

static int
pcf8833_add_rect(const pixel_t *screen,
		u16 *ptr,
		int xs,
		int ys,
		int xe,
		int ye)
{
	u16 *sv_ptr = ptr;
	const pixel_t *lptr;
	pixel_t col;
	int x, y;

	*ptr++ = 0x002a;
	*ptr++ = (u16) (xs + PCF8833_FB_XOFF) | 0x0100;
	*ptr++ = (u16) (xe + PCF8833_FB_XOFF) | 0x0100;
	*ptr++ = 0x002b;
	*ptr++ = (u16) (ys + PCF8833_FB_YOFF) | 0x0100;
	*ptr++ = (u16) (ye + PCF8833_FB_YOFF) | 0x0100;
	*ptr++ = 0x002c;

	for (y = ys; y <= ye; ++y) {
		lptr = screen + y * PCF8833_FB_WIDTH;
		for (x = xs; x <= xe; ++x) {
			col = *(lptr + x);
			*ptr++ = (u16) (col & 0x00ff) | 0x0100;
			*ptr++ = (u16) ((col >> 8) & 0x00ff) | 0x0100;
		}
	}

	return (ptr - sv_ptr) * 2;
}

static void
pcf8833_spi_callback(void *param)
{
	struct pcf8833_par *par = (struct pcf8833_par *) param;
	union pcf8833_rect rect;
	int ret;

	ret = pcf8833_queue_read(&par->queue, &rect._32);

	if (!ret) {
		ret = pcf8833_add_rect(par->screen, par->buffer,
				(int) rect._8[0],
				(int) rect._8[1],
				(int) rect._8[2],
				(int) rect._8[3]);

		par->xfer.len = ret;
		spi_async(par->spi, &par->msg);
	}
}

static void
pcf8833_vram_update(struct pcf8833_par *par,
		int xs,
		int ys,
		int xe,
		int ye)
{
	int ret;
	union pcf8833_rect rect;

	rect._8[0] = (u8) xs;
	rect._8[1] = (u8) ys;
	rect._8[2] = (u8) xe;
	rect._8[3] = (u8) ye;

	ret = pcf8833_queue_write(&par->queue, rect._32);

	if (ret < 0) {
		// wait for queue and try to write again 
	}

	if (par->msg.status == 0) {
		pcf8833_spi_callback(par);
	}
}

static int
pcf8833_loinit(struct spi_device *spi, int flags)
{
	int ret;
	spi->mode = SPI_MODE_0;
	spi->bits_per_word = 9;

	ret = spi_setup(spi);
	if (ret < 0)
		return ret;

	pcf8833_command(spi, 0x01);
	mdelay(10);

	pcf8833_command(spi, 0x11);
	mdelay(10);

	pcf8833_command(spi, 0x03);
	mdelay(10);

	pcf8833_command(spi, 0x20);
	mdelay(10);

	pcf8833_command(spi, 0x36);
	pcf8833_data(spi, flags & 0x000000ff);
	mdelay(10);

	pcf8833_command(spi, 0x3a);
	pcf8833_data(spi, (flags >> 8) & 0x000000ff);
	mdelay(10);

	pcf8833_command(spi, 0x29);
	mdelay(10);

	return 0;
}

void pcf8833_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
{
	sys_fillrect(p, rect);
	pcf8833_vram_update(p->par, rect->dx, rect->dy,
			rect->dx + rect->width - 1,
			rect->dy + rect->height - 1);
}

void pcf8833_copyarea(struct fb_info *p, const struct fb_copyarea *rect)
{
	sys_copyarea(p, rect);
	pcf8833_vram_update(p->par, rect->dx, rect->dy,
			rect->dx + rect->width - 1,
			rect->dy + rect->height - 1);
}

void pcf8833_imageblit(struct fb_info *p, const struct fb_image *rect)
{
	sys_imageblit(p, rect);
	pcf8833_vram_update(p->par, rect->dx, rect->dy,
			rect->dx + rect->width - 1,
			rect->dy + rect->height - 1);
}

static struct fb_ops pcf8833_ops = {
	.owner          = THIS_MODULE,
	.fb_read        = fb_sys_read,
	.fb_write       = fb_sys_write,
	.fb_fillrect    = pcf8833_fillrect,
	.fb_copyarea    = pcf8833_copyarea,
	.fb_imageblit   = pcf8833_imageblit,
	.fb_blank       = pcf8833_blank,
};

static int __devinit pcf8833_probe(struct spi_device *spi)
{
	struct fb_info *info;
	struct pcf8833_par *par;
	int ret;

	printk(KERN_INFO "Philips PCF8833 framebuffer driver\n");

	ret = pcf8833_loinit(spi, PCF8833_FB_5R6G5B | PCF8833_FB_MIRROR_X | PCF8833_FB_MIRROR_Y);
	if (ret < 0)
		return ret;

	ret = -ENOMEM;

	info = framebuffer_alloc(sizeof(struct pcf8833_par), &spi->dev);
	if (!info)
		return ret;

	info->fbops = &pcf8833_ops;
	info->var = pcf8833_var;
	info->fix = pcf8833_fix;
	info->flags = FBINFO_FLAG_DEFAULT;

	par = info->par;
	par->spi = spi;

	pcf8833_queue_init(&par->queue);

	par->screen = vmalloc(PCF8833_FB_MEMSIZE);
	if (!par->screen)
		goto err_fb_release;

	memset(par->screen, 0, PCF8833_FB_MEMSIZE);
	info->screen_base = (char __iomem *) par->screen;
	info->screen_size = PCF8833_FB_MEMSIZE;

	par->buffer = kmalloc(PCF8833_FB_BUFFSIZE, GFP_KERNEL | GFP_DMA);
	if (!par->buffer)
		goto err_screen_free;

	spi_message_init(&par->msg);
	spi_message_add_tail(&par->xfer, &par->msg);

	par->xfer.tx_buf = par->buffer;
	par->msg.complete = pcf8833_spi_callback;
	par->msg.context = par;

	ret = register_framebuffer(info);
	if (ret < 0)
		goto err_buffer_free;

	dev_set_drvdata(&spi->dev, info);

	printk(KERN_INFO "fb%d: %s fb device, %dK of video memory\n",
	       info->node, info->fix.id, PCF8833_FB_MEMSIZE >> 10);

	return 0;

err_buffer_free:
	kfree(par->buffer);
err_screen_free:
	vfree(par->screen);
err_fb_release:
	framebuffer_release(info);

	return ret;
}

static int __devexit pcf8833_remove(struct spi_device *spi)
{
	struct fb_info *info = dev_get_drvdata(&spi->dev);

	if (info) {
		struct pcf8833_par *par = info->par;

		pcf8833_command(spi, 0x28);

		unregister_framebuffer(info);
		kfree(par->buffer);
		vfree(par->screen);
		framebuffer_release(info);
	}

	return 0;
}

static struct spi_driver pcf8833_driver = {
	.driver = {
		.name       = "pcf8833",
		.bus        = &spi_bus_type,
		.owner      = THIS_MODULE,
	},
	.probe      = pcf8833_probe,
	.remove     = __devexit_p(pcf8833_remove),
};

static int __init pcf8833_init(void)
{
	return spi_register_driver(&pcf8833_driver);
}

static void __exit pcf8833_exit(void)
{
	spi_unregister_driver(&pcf8833_driver);
}

module_init(pcf8833_init);
module_exit(pcf8833_exit);

MODULE_AUTHOR("Roman Belov");
MODULE_DESCRIPTION("PCF8833 fb driver");
MODULE_LICENSE("GPL");


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--tThc/1wpZn/ma/RB--

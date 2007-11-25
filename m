From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver integration
Date: Sun, 25 Nov 2007 12:21:50 +0100
Message-ID: <20071125112150.GJ3183@pruts.nl>
References: <20071124214325.GD3183@pruts.nl> <20071124221447.GF3183@pruts.nl>
	<45a44e480711241449l5c368250q40e5adc1fab117fa@mail.gmail.com>
	<20071125090525.GG3183@pruts.nl>
	<45a44e480711250248x692c3d2p8b5bade876a36d26@mail.gmail.com>
	<20071125105356.GI3183@pruts.nl>
	<45a44e480711250312g54e7092j51e27c5e0011a2a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwFYn-00076m-1A for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 03:22:01 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwFYm-0006ce-0u
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 03:22:00 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id 7C68F12E42C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 12:21:58 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mR+Dk5oMurBs
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 12:21:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <45a44e480711250312g54e7092j51e27c5e0011a2a@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

> On Nov 25, 2007 5:53 AM, Ico Doornekamp <fbdev@zevv.nl> wrote:
> >
> > I'm running 2.6.23.8 on i386. I can post the driver code if this would
> > be of any help.
> >
> 
> Yes, I think it'll help. I'll try to upgrade to top of tree as well.

The driver uses on-chip GPIO for communication with the LCD, which is
handled by the v86sxgpio_* functions.

mbarcfb_dpy_update() does a complete screen update; the layout of the
LCD is different from the fbdev, so the 'transpose' function is doing
some logic to find the proper pixels. This code is still far from
optimal.

The code needs some cleanup and #defines for magic numbers here and
there, but the general idea should be clear.

write() and mmap() from userspace both work fine at this moment, I'm
still working on getting the console to display.

Ico

/*
 * linux/drivers/video/mbarcfb.c -- FB driver for mbarc display
 *
 * Copyright (C) 2007, Ico Doornekamp
 * Based on the Hecuba driver
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License. See the file COPYING in the main directory of this archive for
 * more details.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/fb.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/list.h>
#include <asm/uaccess.h>

#include <linux/v86sxgpio.h>

#define DPY_W 128
#define DPY_H 64

struct mbarcfb_par {
	struct v86sxgpio *gpio_data;
	struct v86sxgpio *gpio_ctrl;
	int ctrl_bits;
	struct fb_info *info;
};

static struct fb_fix_screeninfo mbarcfb_fix __devinitdata = {
	.id =		"mbarcfb",
	.type =		FB_TYPE_PACKED_PIXELS,
	.visual =	FB_VISUAL_MONO01,
	.xpanstep =	0,
	.ypanstep =	0,
	.ywrapstep =	0,
	.accel =	FB_ACCEL_NONE,
};

static struct fb_var_screeninfo mbarcfb_var __devinitdata = {
	.xres		= DPY_W,
	.yres		= DPY_H,
	.xres_virtual	= DPY_W,
	.yres_virtual	= DPY_H,
	.bits_per_pixel	= 1,
	.nonstd		= 1,
};

static DECLARE_WAIT_QUEUE_HEAD(mbarcfb_waitq);
static struct platform_device *mbarcfb_device;

#define DI_INSTR 0
#define DI_DATA 1

#define RW_WRITE 0
#define RW_READ 1

#define BIT_DI  (1<<0)
#define BIT_RW  (1<<1)
#define BIT_EN  (1<<2)
#define BIT_CS1 (1<<3)
#define BIT_CS2 (1<<4)
#define BIT_RST (1<<5)


static void mbarc_set(struct mbarcfb_par *par, int mask, int val)
{
	if(val) {
		par->ctrl_bits |= mask;
	} else {
		par->ctrl_bits &= ~mask;
	}
	v86sxgpio_set(par->gpio_ctrl, par->ctrl_bits);
}

static void mbarc_send(struct mbarcfb_par *par, int di, int val)
{
	mbarc_set(par, BIT_DI, di);
	mbarc_set(par, BIT_RW, RW_WRITE);
	v86sxgpio_set(par->gpio_data, val);
	mbarc_set(par, BIT_EN, 1);
	mbarc_set(par, BIT_EN, 0);
}

static int __devinit mbarc_init_control(struct mbarcfb_par *par)
{
	mbarc_set(par, BIT_RST, 0);
	mbarc_set(par, BIT_RST, 1);

	mbarc_send(par, DI_DATA, 0xff);
	mbarc_send(par, DI_DATA, 0xff);
	mbarc_send(par, DI_DATA, 0xff);
	mbarc_send(par, DI_INSTR, 0xe2);

	return 0;
}


u8 transpose(u8 *src, unsigned x, unsigned y)
{
	u8 b;
	int i;
	u8 mask;
	unsigned offset;

	mask = 1 << ( 7 - (x%8));

	b = 0;

	for(i=0; i<8; i++) {
		offset = (x + (y+i)*DPY_W) / 8;
		if( src[offset] & mask ) b |= (1<<i);
	}
	return b;
}


/* main mbarcfb functions */

static void mbarcfb_dpy_update(struct mbarcfb_par *par)
{
	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
	unsigned c, x, cx, y;
	u8 *p;
	u8 b;

	p = buf;

	for(c=0; c<2; c++) {

		mbarc_set(par, BIT_CS1, c==0);
		mbarc_set(par, BIT_CS2, c==1);

		for(y=0; y<64; y+=8) {

			mbarc_send(par, DI_INSTR, 0x40);
			mbarc_send(par, DI_INSTR, 0xb8 + y/8);
			mbarc_send(par, DI_INSTR, 0xc0); /* display start line */
			
			for(cx=0; cx<64; cx++) {
				x = cx + c*64;
				b = transpose(buf, x, y);
				mbarc_send(par, DI_DATA, b);
				mbarc_send(par, DI_INSTR, 0x3f); /* wtf! */
			}
		}
	}
	
	for(c=0; c<2; c++) {
		mbarc_set(par, BIT_CS1, c==0);
		mbarc_set(par, BIT_CS2, c==1);
		mbarc_send(par, DI_INSTR, 0x3f); /* wtf! */
	}
}


/* this is called back from the deferred io workqueue */

static void mbarcfb_dpy_deferred_io(struct fb_info *info, struct list_head *pagelist)
{
	mbarcfb_dpy_update(info->par);
}


static void mbarcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
{
	struct mbarcfb_par *par = info->par;

	sys_fillrect(info, rect);

	mbarcfb_dpy_update(par);
}


static void mbarcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
{
	struct mbarcfb_par *par = info->par;

	sys_copyarea(info, area);

	mbarcfb_dpy_update(par);
}


static void mbarcfb_imageblit(struct fb_info *info, const struct fb_image *image)
{
	struct mbarcfb_par *par = info->par;

	sys_imageblit(info, image);

	mbarcfb_dpy_update(par);
}


/*
 * this is the slow path from userspace. they can seek and write to
 * the fb. it's inefficient to do anything less than a full screen draw
 */

static ssize_t mbarcfb_write(struct fb_info *info, const char __user *buf, size_t count, loff_t *ppos)
{
	unsigned long p;
	int err=-EINVAL;
	struct mbarcfb_par *par;
	unsigned int xres;
	unsigned int fbmemlength;

	p = *ppos;
	par = info->par;
	xres = info->var.xres;
	fbmemlength = (xres * info->var.yres)/8;

	if (p > fbmemlength)
		return -ENOSPC;

	err = 0;
	if ((count + p) > fbmemlength) {
		count = fbmemlength - p;
		err = -ENOSPC;
	}

	if (count) {
		char *base_addr;

		base_addr = (char __force *)info->screen_base;
		count -= copy_from_user(base_addr + p, buf, count);
		*ppos += count;
		err = -EFAULT;
	}

	mbarcfb_dpy_update(par);

	if (count)
		return count;

	return err;
}


static struct fb_ops mbarcfb_ops = {
	.owner		= THIS_MODULE,
	.fb_read        = fb_sys_read,
	.fb_write	= mbarcfb_write,
	.fb_fillrect	= mbarcfb_fillrect,
	.fb_copyarea	= mbarcfb_copyarea,
	.fb_imageblit	= mbarcfb_imageblit,
};


static struct fb_deferred_io mbarcfb_defio = {
	.delay		= HZ / 5,
	.deferred_io	= mbarcfb_dpy_deferred_io,
};


static int __devinit mbarcfb_probe(struct platform_device *dev)
{
	struct fb_info *info;
	int retval = -ENOMEM;
	int videomemorysize;
	unsigned char *videomemory;
	struct mbarcfb_par *par;

	videomemorysize = (DPY_W*DPY_H)/8;

	if (!(videomemory = vmalloc(videomemorysize)))
		return retval;

	memset(videomemory, 0, videomemorysize);

	info = framebuffer_alloc(sizeof(struct mbarcfb_par), &dev->dev);
	if (!info)
		goto err;

	info->screen_base = (char __iomem *) videomemory;
	info->fbops = &mbarcfb_ops;

	info->var = mbarcfb_var;
	info->fix = mbarcfb_fix;
	info->fix.smem_len = videomemorysize;
	par = info->par;
	par->info = info;

	par->gpio_ctrl = v86sxgpio_request("mbarcfb-ctrl", 0, 0, 6);
	if(!par->gpio_ctrl) {
		printk(KERN_WARNING "cant get ctrl gpio\n");
		goto err1;
	}
	v86sxgpio_ddr(par->gpio_ctrl, 0x3f);
	par->ctrl_bits = 0;
	
	par->gpio_data = v86sxgpio_request("mbarcfb-data", 1, 0, 8);
	if(!par->gpio_data) {
		printk(KERN_WARNING "cant get data gpio\n");
		goto err2;
	}
	v86sxgpio_ddr(par->gpio_data, 0xff);

	info->flags = FBINFO_FLAG_DEFAULT;
	info->fbdefio = &mbarcfb_defio;
	fb_deferred_io_init(info);

	retval = register_framebuffer(info);
	if (retval < 0)
		goto err3;
	platform_set_drvdata(dev, info);

	printk(KERN_INFO
	       "fb%d: Mbarc frame buffer device, using %dK of video memory\n",
	       info->node, videomemorysize >> 10);

	/* this inits the dpy */

	mbarc_init_control(par);

	return 0;


err3:
	v86sxgpio_release(par->gpio_data);
err2:
	v86sxgpio_release(par->gpio_ctrl);
err1:
	framebuffer_release(info);
err:
	vfree(videomemory);
	return retval;
}

static int __devexit mbarcfb_remove(struct platform_device *dev)
{
	struct fb_info *info = platform_get_drvdata(dev);
	struct mbarcfb_par *par;

	if (info) {
		fb_deferred_io_cleanup(info);
		unregister_framebuffer(info);
		vfree((void __force *)info->screen_base);
		framebuffer_release(info);

		par = info->par;
		v86sxgpio_release(par->gpio_data);
		v86sxgpio_release(par->gpio_ctrl);
	}
	

	return 0;
}


static struct platform_driver mbarcfb_driver = {
	.probe	= mbarcfb_probe,
	.remove = mbarcfb_remove,
	.driver	= {
		.name	= "mbarcfb",
	},
};


static int __init mbarcfb_init(void)
{
	int ret;

	ret = platform_driver_register(&mbarcfb_driver);
	if (!ret) {
		mbarcfb_device = platform_device_alloc("mbarcfb", 0);
		if (mbarcfb_device)
			ret = platform_device_add(mbarcfb_device);
		else
			ret = -ENOMEM;

		if (ret) {
			platform_device_put(mbarcfb_device);
			platform_driver_unregister(&mbarcfb_driver);
		}
	}
	return ret;

}


static void __exit mbarcfb_exit(void)
{
	platform_device_unregister(mbarcfb_device);
	platform_driver_unregister(&mbarcfb_driver);
}


module_init(mbarcfb_init);
module_exit(mbarcfb_exit);

MODULE_DESCRIPTION("fbdev driver for Mbarc board");
MODULE_AUTHOR("Ico Doornekamp");
MODULE_LICENSE("GPL");


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

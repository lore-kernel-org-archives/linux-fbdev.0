From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Wed, 12 Nov 2008 09:25:51 +0100
Message-ID: <491A930F.2040507@cetrtapot.si>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
	<1210.137.237.242.125.1226419828.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020607030302090703020408"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hinko.kocevar@cetrtapot.si>) id 1L0B6Y-0005l3-5s
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 08:29:38 +0000
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0B6T-0006JE-88 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 08:29:38 +0000
In-Reply-To: <1210.137.237.242.125.1226419828.squirrel@webmail.nuvox.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jkimble@one.net
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020607030302090703020408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

jkimble@one.net wrote:
> I thought it looked OK because it looks the same as the flexCAN stuff.
> However I just noticed that flexCAN has a .0 and .1 whereas the s1d13 a=
re
> both .0. Yeah, I hope an expert weighs in on this because I'm not sure
> now.
>=20
> I didn't get your attachement.
>=20

Maybe I forgot to attach it :P
Here it is.


HTH,
HK


--=20
Hinko Ko=C4=8Devar, OSS developer
=C4=8CETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si


--------------020607030302090703020408
Content-Type: text/x-csrc;
 name="carneol-s1d13706fb.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="carneol-s1d13706fb.c"

/*
 *  drivers/cpot/carneol-s1d13706fb.c
 *
 *  Carneol Epson S1D13706 frame buffer driver.
 *
 *  Copyright (C) 2006, 2007 Simon Posnjak <simon.posnjak@cetrtapot.si>
 *  Copyright (C) 2008 Hinko Kocevar <hinko.kocevar@cetrtapot.si>
 *
 * Adapted from:
 *
 *  -linux/drivers/video/skeletonfb.c
 *		Modified to new api Jan 2001 by James Simmons (jsimmons@infradead.org)
 *		Created 28 Dec 1997 by Geert Uytterhoeven
 *
 *  -linux/drivers/video/epson1355fb.c
 *		Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org> (2.4 driver)
 *		Copyright (C) Hewlett-Packard Company.  All rights reserved. (2.6 driver)
 *
 *  -Epson Linux drivers 2.4
 * 
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License.  See the file COPYING in the main directory of the Linux
 *  distribution for more details.
 *
 *  Changelog:
 *   11 Nov 2008	added splash support with automatic rotation of image
 *                  according to detected panel. Bitmap data is stored in
 *                  header file containg only bitmap pixels (top->bottom)
 *                  in uncompreesed, 8bpp (max 240 indexed colors), 320x240
 *                  pixels format
 */

#include <linux/version.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/fb.h>

#include <asm/io.h>

#include <asm/cpot/carneol-platform.h>
#include <asm/cpot/carneol-s1d13706fb.h>
#include <asm/cpot/carneol-splash.h>

/* YYMMDDRR - year, month, day, release */
static unsigned char mod_name[]		= "carneol-s1d13706fb";
static unsigned char mod_version[]	= "08111114";

static unsigned char panel_type = CARNEOL_LCD_NONE;
static unsigned char platform_ver = CARNEOL_PLATFORM_VER_10;

static inline u8 s1d13706fb_readreg (struct s1d13706fb_par *par, u16 regno)
{
	return readb((const volatile void __iomem *)(par->RegAddr + regno));
}

static inline void s1d13706fb_writereg (struct s1d13706fb_par *par,
											u16 regno, u8 value)
{
	writeb(value, (volatile unsigned char *)(par->RegAddr + regno));
}

/* Sets splash from static bitmap data found in header file.
 * Bitmap is expected to be 320x240 px - same as framebuffer/LCD size, 8bpp,
 * with indexed colors (max 240 colors).
 */
static void display_splash (struct fb_info *info)
{
	struct s1d13706fb_par *par = info->par;
	u8 *src;
	u8 *dst;
	u32 i;
	u32 r, g, b;
	u32 w, h, dx, dy;
	u8 buf[BMP_LOGO_WIDTH];

	printk("%s: enter\n", __func__);

	/* Clear the palette to avoid sliding effect when drawing on screen. */
	for (i = 0; i < BMP_LOGO_COLORS; i++)
		S1D_WRITE_PALETTE(par->RegAddr,	i + BMP_LOGO_OFFSET, 0, 0, 0);

	w = BMP_LOGO_WIDTH;
	h = BMP_LOGO_HEIGHT;
	dst = (u8 *) info->screen_base;
	switch (panel_type)
	{
	case CARNEOL_LCD_SHARP:
		/* Normal. */
		printk("%s: fixing bitmap data for LCD: Sharp\n", __func__);
		src = (u8 *) bmp_logo_bitmap;
		dx = 1;
		dy = 1;
		break;
	case CARNEOL_LCD_AMPIRE:
		/* 180 degrees rotate. */
		printk("%s: fixing bitmap data for LCD: Ampire\n", __func__);
		src = (u8 *) bmp_logo_bitmap + h * w - 1;
		dx = -1;
		dy = -1;
		break;
	default:
		printk("%s: unknown LCD panel type %d\n", __func__, panel_type);
		return;
	}

	while (h--)
	{
		for (i = 0; i < w; i++)
		{
			buf[i] = *src;
			src += dx;
		}
		
		memcpy(dst, buf, w);
		dst += w;
	}

	/* Get bitmap colors and set the hardware palette. Skip first 16
	 * colors. */
	for (i = 0; i < BMP_LOGO_COLORS; i++)
	{
		r = (bmp_logo_palette[i] & 0x0f00) >> 4;
		g = (bmp_logo_palette[i] & 0x00f0);
		b = (bmp_logo_palette[i] & 0x000f) << 4;

		S1D_WRITE_PALETTE(par->RegAddr,	i + BMP_LOGO_OFFSET, r, g, b);
	}
	
	printk("%s: exit\n", __func__);
}

static int control_backlight (struct device *dev, int state)
{
	u_int16_t val;
	struct fb_info *info = dev_get_drvdata(dev);
	struct s1d13706fb_par *par = info->par;

	val = 0;
	switch (platform_ver)
	{
		case CARNEOL_PLATFORM_VER_10:
		case CARNEOL_PLATFORM_VER_11:
			val = (state) ? 0x00 : 0x80;
			break;
		case CARNEOL_PLATFORM_VER_15:
			val = (state) ? 0x80 : 0x00;
			break;
		default:
			return -1;
			break;
	}
	
	if (state)
		printk("Backlight ON %X\n", val);
	else
		printk("Backlight OFF %x\n", val);
		
	s1d13706fb_writereg(par, 0xAD, val);

	return 0;
}

#define show_reg(reg)													\
static ssize_t __show_reg_##reg (struct device *dev, 					\
		struct device_attribute *attr, char *buf)						\
{																		\
	unsigned char val;													\
	struct fb_info *info = dev_get_drvdata(dev);						\
	struct s1d13706fb_par *par = info->par;								\
																		\
	val = s1d13706fb_readreg(par, reg);									\
	return sprintf(buf, "HEX 0x%02X DEC %d\n", val, val);				\
}

show_reg(0x12); // Horizontal Total Register
show_reg(0x14); // Horizontal Display Period Register
show_reg(0x16); // Horizontal Display Period Start Pos Register 0
show_reg(0x17); // Horizontal Display Period Start Pos Register 1
show_reg(0x18); // Vertical Total Register 0
show_reg(0x19); // Vertical Total Register 1
show_reg(0x1C); // Vertical Display Period Register 0
show_reg(0x1D); // Vertical Display Period Register 1
show_reg(0x1E); // Vertical Display Period Start Pos Register 0
show_reg(0x1F); // Vertical Display Period Start Pos Register 1
show_reg(0x20); // Horizontal Sync Pulse Width Register
show_reg(0x22); // Horizontal Sync Pulse Start Pos Register 0
show_reg(0x23); // Horizontal Sync Pulse Start Pos Register 1
show_reg(0x24); // Vertical Sync Pulse Width Register
show_reg(0x26); // Vertical Sync Pulse Start Pos Register 0
show_reg(0x27); // Vertical Sync Pulse Start Pos Register 1

show_reg(0xA8); // GPIO Config Register 0
show_reg(0xA9); // GPIO Config Register 1
show_reg(0xAC); // GPIO Status Control Register 0
show_reg(0xAD);	// GPIO Status Control Register 1

#define set_reg(reg)													\
static ssize_t __set_reg_##reg (struct device *dev, 					\
		struct device_attribute *attr, const char *buf, size_t count)	\
{																		\
	struct fb_info *info = dev_get_drvdata(dev);						\
	struct s1d13706fb_par *par = info->par;								\
	unsigned char val = simple_strtoul(buf, NULL, 16);					\
																		\
	if (reg == 0xAD)													\
		control_backlight (dev, val);											\
	else																\
		s1d13706fb_writereg(par, reg, val);								\
	return count;														\
}																		\
static DEVICE_ATTR(reg_##reg, S_IWUSR | S_IRUGO,						\
				__show_reg_##reg, __set_reg_##reg);

set_reg(0x12);	// Horizontal Total Register
set_reg(0x14);	// Horizontal Display Period Register
set_reg(0x16);	// Horizontal Display Period Start Pos Register 0
set_reg(0x17);	// Horizontal Display Period Start Pos Register 1
set_reg(0x18);	// Vertical Total Register 0
set_reg(0x19);	// Vertical Total Register 1
set_reg(0x1C);	// Vertical Display Period Register 0
set_reg(0x1D);	// Vertical Display Period Register 1
set_reg(0x1E);	// Vertical Display Period Start Pos Register 0
set_reg(0x1F);	// Vertical Display Period Start Pos Register 1
set_reg(0x20);	// Horizontal Sync Pulse Width Register
set_reg(0x22);	// Horizontal Sync Pulse Start Pos Register 0
set_reg(0x23);	// Horizontal Sync Pulse Start Pos Register 1
set_reg(0x24);	// Vertical Sync Pulse Width Register
set_reg(0x26);	// Vertical Sync Pulse Start Pos Register 0
set_reg(0x27);	// Vertical Sync Pulse Start Pos Register 1

set_reg(0xA8);	// GPIO Config Register 0
set_reg(0xA9);	// GPIO Config Register 1
set_reg(0xAC);	// GPIO Status Control Register 0
set_reg(0xAD);	// GPIO Status Control Register 1

static int s1d13706fb_setcolreg (unsigned regno, unsigned r, unsigned g,
					unsigned b, unsigned transp, struct fb_info *info)
{
	struct s1d13706fb_par *par = info->par;
	
	if (regno >= S1D_PALETTE_SIZE)
		return 1;
		
	S1D_WRITE_PALETTE(par->RegAddr, regno, r>>8, g>>8, b>>8);

	return (0);			
}

static int s1d13706fb_blank (int blank_mode, struct fb_info *info)
{
	return (0);
}


static int s1d13706fb_pan_display (struct fb_var_screeninfo *var,
									struct fb_info *info)
{
	return (0);
}


static void s1d13706fb_rotate (struct fb_info *info, int angle)
{
	printk("%s: angle %d\n", __func__, angle);
}

static struct fb_ops s1d13706fb_fbops =
{
	.owner			= THIS_MODULE,
	.fb_setcolreg	= s1d13706fb_setcolreg,
	.fb_pan_display	= s1d13706fb_pan_display,
	.fb_blank		= s1d13706fb_blank,
	.fb_fillrect	= cfb_fillrect,
	.fb_copyarea	= cfb_copyarea,
	.fb_imageblit	= cfb_imageblit,
	.fb_rotate		= s1d13706fb_rotate,
};

static int s1d13706fb_remove (struct platform_device *dev)
{
	struct fb_info *info = dev_get_drvdata(&dev->dev);
	struct s1d13706fb_par *par = info->par;
			
	if (par)
	{
		if (par && par->RegAddr)
			iounmap((void *) par->RegAddr);
	}
	
	if (info)
	{
		fb_dealloc_cmap(&info->cmap);
		if (info->screen_base)
			iounmap(info->screen_base);
		
		framebuffer_release(info);
	}
	
	release_mem_region(S1D_PHYSICAL_REG_ADDR, S1D_PHYSICAL_REG_SIZE);
	release_mem_region(S1D_PHYSICAL_VMEM_ADDR, S1D_PHYSICAL_VMEM_SIZE);
	
	return 0;
}

static int __init s1d13706fb_probe (struct platform_device *dev)
{
	struct s1d13706fb_par *default_par;
	struct fb_info *info;
	S1D_INDEX s1dReg;
	S1D_VALUE s1dValue;
	int rc, i;
	u8 revision;
	int nrregs;

	i = tsc2301_gpio_get_level(TSC2301_GPIO_IN3);
	if (i)
	{
		printk("Carneol platform detect: version 1.5\n");
		platform_ver = CARNEOL_PLATFORM_VER_15;
	}
	else
	{
		printk("Carneol platform detect: version 1.0 or 1.1\n");
		platform_ver = CARNEOL_PLATFORM_VER_11;
	}
	
	i = tsc2301_gpio_get_level(TSC2301_GPIO_IN4);
	if (i)
	{
		panel_type = CARNEOL_LCD_AMPIRE;
		printk("Carneol LCD detect: Ampire\n");
	}
	else
	{
		panel_type = CARNEOL_LCD_SHARP;
		printk("Carneol LCD detect: Sharp\n");
	}

	if (!request_mem_region(S1D_PHYSICAL_REG_ADDR, S1D_PHYSICAL_REG_SIZE,
		"S1D13706 registers"))
	{
		printk(KERN_ERR "s1d13706fb: unable to reserve registers at 0x%0lx\n",
			S1D_PHYSICAL_REG_ADDR);
		rc = -EBUSY;
		goto bail;
	}

	if (!request_mem_region(S1D_PHYSICAL_VMEM_ADDR, S1D_PHYSICAL_VMEM_SIZE,
		"S1D13706 framebuffer"))
	{
		printk(KERN_ERR "s1d13706fb: unable to reserve framebuffer at 0x%0lx\n",
			S1D_PHYSICAL_VMEM_ADDR);
		rc = -EBUSY;
		goto bail;
	}

	info = framebuffer_alloc(sizeof(struct s1d13706fb_par) + sizeof(u32) * 256,
								&dev->dev);
	if (!info)
	{
		rc = -ENOMEM;
		goto bail;
	}					

	default_par = info->par;
	default_par->RegAddr = (u8 *) ioremap(S1D_PHYSICAL_REG_ADDR,
		S1D_PHYSICAL_REG_SIZE);
	if (!default_par->RegAddr)
	{
		printk(KERN_ERR "s1d13706fb: unable to map registers\n");
		rc = -ENOMEM;
		goto bail;
	}
	
	info->pseudo_palette = (void *)(default_par + 1);

	info->screen_base = ioremap(S1D_PHYSICAL_VMEM_ADDR,
		S1D_PHYSICAL_VMEM_SIZE);
	if (!info->screen_base)
	{
		printk(KERN_ERR "s1d13706fb: unable to map framebuffer\n");
		rc = -ENOMEM;
		goto bail;
	}

	info->fix.mmio_start = S1D_PHYSICAL_REG_ADDR;
	info->fix.mmio_len = S1D_PHYSICAL_REG_SIZE;
	info->fix.smem_start = S1D_PHYSICAL_VMEM_ADDR;
	info->fix.smem_len = S1D_PHYSICAL_VMEM_SIZE;
	
	nrregs = sizeof(sharp_S1DRegs);
	for (i = 0; i < nrregs/sizeof(S1D_REGS); i++)
	{
		switch (panel_type)
		{
		case CARNEOL_LCD_SHARP:
			s1dReg = sharp_S1DRegs[i].Index;
			s1dValue = sharp_S1DRegs[i].Value;
			break;
		case CARNEOL_LCD_AMPIRE:
			s1dReg = ampire_S1DRegs[i].Index;
			s1dValue = ampire_S1DRegs[i].Value;
			break;
		default:
			rc = -EINVAL;
			goto bail;
			break;
		}
			
		if (s1dReg == S1D_REGDELAYOFF || s1dReg == S1D_REGDELAYON)
			mdelay((int)s1dValue);
		else
			((S1D_VALUE*)default_par->RegAddr)[s1dReg/sizeof(S1D_VALUE)] =
				s1dValue;
	}
	
	strcpy(info->fix.id, "S1D13706");
	info->par = default_par;
	info->fbops = &s1d13706fb_fbops;
	info->flags = FBINFO_DEFAULT;

	revision = s1d13706fb_readreg (default_par, 0);
	
	if (register_framebuffer(info) < 0)
	{
		rc = -EINVAL;
		goto bail;
	}
	
	info->fix.type = FB_TYPE_PACKED_PIXELS;
	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
	info->var.bits_per_pixel = 8;
	info->var.red.offset = info->var.green.offset = info->var.blue.offset = 0;
	info->var.red.length = info->var.green.length = info->var.blue.length = 8;
	fb_alloc_cmap(&info->cmap, 256, 0);
	/* Make sure first color is black - 0,0,0 */
	s1d13706fb_setcolreg(0, 0, 0, 0, 0, info);
	
	info->var.xres = S1D_DISPLAY_WIDTH;
	info->var.yres = S1D_DISPLAY_HEIGHT;
	info->var.xres_virtual = info->var.xres;
	info->var.yres_virtual = info->var.yres;
	info->var.xoffset = info->var.yoffset = 0;
	info->fix.line_length = 320;

	info->fix.xpanstep = 0;
	info->fix.ypanstep = 0;
	info->fix.ywrapstep = 0;
	info->fix.accel = FB_ACCEL_NONE;
	
	info->var.grayscale = 0;
	
	info->var.pixclock = S1D_DISPLAY_PCLK;
	info->var.sync = 0;
	info->var.vmode = FB_VMODE_NONINTERLACED;
	info->var.activate = FB_ACTIVATE_NOW;
	
	dev_set_drvdata(&dev->dev, info);
	
	/*
	 * Set Backlight power ON according to carneol board type detected.
	 * Board r1.1 has backlight permanently on, while on board r1.5 we
	 * have to turn it on with GP0 pin on S1D13706.
	 * Newer 1.5 boards dont't have a backlight converter at all - boards
	 * with Ampire LCD panels.
	 */
	control_backlight(&dev->dev, 1);

	/* Show nice logo from bitmap pixel array. */
	display_splash(info);
	
	return 0;
	
bail:
	s1d13706fb_remove(dev);
	return rc;	
}

static struct platform_driver s1d13706fb_driver =
{
	.probe		= s1d13706fb_probe,
	.remove		= s1d13706fb_remove,
	.driver		= {
					.owner = THIS_MODULE,
					.name = mod_name,
				}
};

static void s1d13706fb_release (struct device *device)
{
	return;
}

static struct platform_device s1d13706fb_device =
{
	.name	= mod_name,
	.id		= -1,
	.dev	= {
				.release = s1d13706fb_release,
			}
};

static int __init s1d13706fb_init (void)
{
	int ret;

	printk("Carneol %s module %s, (C) 2005 - 2008 Simon Posnjak\n", mod_name, mod_version);
	
	if (fb_get_options("s1d13706fb", NULL))
		return -ENODEV;

	ret = platform_driver_register(&s1d13706fb_driver);
	if (ret == 0)
	{
		ret = platform_device_register(&s1d13706fb_device);
		if (ret)
		{
			printk(KERN_ERR "Failed to register device for Carneol %s\n", mod_name);
			goto error;
		}
	}
	else
	{
		printk(KERN_ERR "Failed to register driver for Carneol %s\n", mod_name);	
		goto error;
	}

	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x12);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x14);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x16);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x17);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x18);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x19);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x1C);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x1D);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x1E);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x1F);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x20);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x22);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x23);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x24);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x26);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x27);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0xA8);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0xA9);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0xAC);
	device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0xAD);

	return 0;

error:
	platform_driver_unregister(&s1d13706fb_driver);
	return ret;
}
																									
static void __exit s1d13706fb_exit (void)
{
	/* Turn backlight off */
	control_backlight(&s1d13706fb_device.dev, 0);
	
	platform_device_unregister(&s1d13706fb_device);
	platform_driver_unregister(&s1d13706fb_driver);
	printk("Carneol %s module version %s removed\n", mod_name, mod_version);
}

module_init(s1d13706fb_init);
module_exit(s1d13706fb_exit);
		
MODULE_AUTHOR("Simon Posnjak <simon.posnjak@cetrtapot.si>, Hinko Kocevar <hinko.kocevar@cetrtapot.si>");
MODULE_DESCRIPTION("CPOT Carneol framebuffer module for Epson S1D13706");
MODULE_LICENSE("GPL");

--------------020607030302090703020408
Content-Type: text/x-chdr;
 name="carneol-s1d13706fb.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="carneol-s1d13706fb.h"

#ifndef _CARNEOL_S1D13706FB_H_
#define _CARNEOL_S1D13706FB_H_
/*
 * Generated with Epson configuration generator
 *
 * BIG NOTE
 *
 * Must use un-cached area when accessing framebuffer memory,
 * otherwise cached lines corrupt screen image - screen ripping.
 * Add 0x80000000 to addresses to use uncached access!
 */
#define S1D_PHYSICAL_VMEM_ADDR		0x88020000L
#define S1D_PHYSICAL_VMEM_SIZE		0x14000L
#define S1D_PHYSICAL_REG_ADDR		0x88000000L
#define S1D_PHYSICAL_REG_SIZE		0x100

#define S1D_DISPLAY_WIDTH			320
#define S1D_DISPLAY_HEIGHT			240

/* SHARP panels works fine with 12.5 MHz PCLK, Ampire panels *only* work fine
 * with 12.5 MHz!
 */
#define S1D_DISPLAY_PCLK			12500000

#define S1DREG_LCD_MEM_OFF0			0x80
#define S1DREG_LCD_MEM_OFF1			0x81

#define S1DREG_DISP_MODE			0x70
#define S1D_PALETTE_SIZE			256
#define S1D_REGDELAYOFF				0xFFFE
#define S1D_REGDELAYON				0xFFFF

#define S1D_WRITE_PALETTE(p,i,r,g,b) \
{ \
	((volatile S1D_VALUE*)(p))[0x0A/sizeof(S1D_VALUE)] = (S1D_VALUE)(r); \
	((volatile S1D_VALUE*)(p))[0x09/sizeof(S1D_VALUE)] = (S1D_VALUE)(g); \
	((volatile S1D_VALUE*)(p))[0x08/sizeof(S1D_VALUE)] = (S1D_VALUE)(b); \
	((volatile S1D_VALUE*)(p))[0x0B/sizeof(S1D_VALUE)] = (S1D_VALUE)(i); \
}

struct s1d13706fb_par
{
	u_int8_t * RegAddr;
};

typedef unsigned short S1D_INDEX;
typedef unsigned char S1D_VALUE;

typedef struct
{
	S1D_INDEX Index;
	S1D_VALUE Value;
} S1D_REGS;

/* Each panel has its own special settings that make scren look ideal. Specify
 * settings below..
 */
static S1D_REGS sharp_S1DRegs[] =
{
	{0x04,0x00},	/* BUSCLK MEMCLK Config Register */
	{0x05,0x33},	/* PCLK Config	Register */
	{0x10,0x61},	/* PANEL Type Register */
	{0x11,0x00},	/* MOD Rate Register */
	{0x12,0x2F},	/* Horizontal Total Register */
	{0x14,0x27},	/* Horizontal Display Period Register */
	{0x16,0x38},	/* Horizontal Display Period Start Pos Register 0 */
	{0x17,0x00},	/* Horizontal Display Period Start Pos Register 1 */
	{0x18,0x05},	/* Vertical Total Register 0 */
	{0x19,0x01},	/* Vertical Total Register 1 */
	{0x1C,0xEF},	/* Vertical Display Period Register 0 */
	{0x1D,0x00},	/* Vertical Display Period Register 1 */
	{0x1E,0x07},	/* Vertical Display Period Start Pos Register 0 */
	{0x1F,0x00},	/* Vertical Display Period Start Pos Register 1 */
	{0x20,0x07},	/* Horizontal Sync Pulse Width Register */
	{0x22,0x00},	/* Horizontal Sync Pulse Start Pos Register 0 */
	{0x23,0x00},	/* Horizontal Sync Pulse Start Pos Register 1 */
	{0x24,0x03},	/* Vertical Sync Pulse Width Register */
	{0x26,0x00},	/* Vertical Sync Pulse Start Pos Register 0 */
	{0x27,0x00},	/* Vertical Sync Pulse Start Pos Register 1 */
	{0x70,0x03},	/* Display Mode Register */
	{0x71,0x00},	/* Special Effects Register */
	{0x74,0x00},	/* Main Window Display Start Address Register 0 */
	{0x75,0x00},	/* Main Window Display Start Address Register 1 */
	{0x76,0x00},	/* Main Window Display Start Address Register 2 */
	{0x78,0x50},	/* Main Window Address Offset Register 0 */
	{0x79,0x00},	/* Main Window Address Offset Register 1 */
	{0x7C,0x00},	/* Sub Window Display Start Address Register 0 */
	{0x7D,0x00},	/* Sub Window Display Start Address Register 1 */
	{0x7E,0x00},	/* Sub Window Display Start Address Register 2 */
	{0x80,0x50},	/* Sub Window Address Offset Register 0 */
	{0x81,0x00},	/* Sub Window Address Offset Register 1 */
	{0x84,0x00},	/* Sub Window X Start Pos Register 0 */
	{0x85,0x00},	/* Sub Window X Start Pos Register 1 */
	{0x88,0x00},	/* Sub Window Y Start Pos Register 0 */
	{0x89,0x00},	/* Sub Window Y Start Pos Register 1 */
	{0x8C,0x4F},	/* Sub Window X End Pos Register 0 */
	{0x8D,0x00},	/* Sub Window X End Pos Register 1 */
	{0x90,0xEF},	/* Sub Window Y End Pos Register 0 */
	{0x91,0x00},	/* Sub Window Y End Pos Register 1 */
	{0xA0,0x00},	/* Power Save Config Register */
	{0xA1,0x00},	/* CPU Access Control Register */
	{0xA2,0x00},	/* Software Reset Register */
	{0xA3,0x00},	/* BIG Endian Support Register */
	{0xA4,0x00},	/* Scratch Pad Register 0 */
	{0xA5,0x00},	/* Scratch Pad Register 1 */
	{0xA8,0x06},	/* GPIO Config Register 0 */
	{0xA9,0x80},	/* GPIO Config Register 1 */
	{0xAC,0x04},	/* GPIO Status Control Register 0 */
	{0xAD,0x00},	/* GPIO Status Control Register 1 */
	{0xB0,0x00},	/* PWM CV Clock Control Register */
	{0xB1,0x00},	/* PWM CV Clock Config Register */
	{0xB2,0x00},	/* CV Clock Burst Length Register */
	{0xB3,0x00},	/* PWM Clock Duty Cycle Register */
};

static S1D_REGS ampire_S1DRegs[] =
{
	{0x04,0x00},	/* BUSCLK MEMCLK Config Register */
	{0x05,0x33},	/* PCLK Config	Register */
	{0x10,0x61},	/* PANEL Type Register */
	{0x11,0x00},	/* MOD Rate Register */
	{0x12,0x32},	/* Horizontal Total Register */
	{0x14,0x27},	/* Horizontal Display Period Register */
	{0x16,0x40},	/* Horizontal Display Period Start Pos Register 0 */
	{0x17,0x00},	/* Horizontal Display Period Start Pos Register 1 */
	{0x18,0x13},	/* Vertical Total Register 0 */
	{0x19,0x01},	/* Vertical Total Register 1 */
	{0x1C,0xEF},	/* Vertical Display Period Register 0 */
	{0x1D,0x00},	/* Vertical Display Period Register 1 */
	{0x1E,0x21},	/* Vertical Display Period Start Pos Register 0 */
	{0x1F,0x00},	/* Vertical Display Period Start Pos Register 1 */
	{0x20,0x13},	/* Horizontal Sync Pulse Width Register */
	{0x22,0x00},	/* Horizontal Sync Pulse Start Pos Register 0 */
	{0x23,0x00},	/* Horizontal Sync Pulse Start Pos Register 1 */
	{0x24,0x02},	/* Vertical Sync Pulse Width Register */
	{0x26,0x0F},	/* Vertical Sync Pulse Start Pos Register 0 */
	{0x27,0x00},	/* Vertical Sync Pulse Start Pos Register 1 */
	{0x70,0x03},	/* Display Mode Register */
	{0x71,0x00},	/* Special Effects Register */
	{0x74,0x00},	/* Main Window Display Start Address Register 0 */
	{0x75,0x00},	/* Main Window Display Start Address Register 1 */
	{0x76,0x00},	/* Main Window Display Start Address Register 2 */
	{0x78,0x50},	/* Main Window Address Offset Register 0 */
	{0x79,0x00},	/* Main Window Address Offset Register 1 */
	{0x7C,0x00},	/* Sub Window Display Start Address Register 0 */
	{0x7D,0x00},	/* Sub Window Display Start Address Register 1 */
	{0x7E,0x00},	/* Sub Window Display Start Address Register 2 */
	{0x80,0x50},	/* Sub Window Address Offset Register 0 */
	{0x81,0x00},	/* Sub Window Address Offset Register 1 */
	{0x84,0x00},	/* Sub Window X Start Pos Register 0 */
	{0x85,0x00},	/* Sub Window X Start Pos Register 1 */
	{0x88,0x00},	/* Sub Window Y Start Pos Register 0 */
	{0x89,0x00},	/* Sub Window Y Start Pos Register 1 */
	{0x8C,0x4F},	/* Sub Window X End Pos Register 0 */
	{0x8D,0x00},	/* Sub Window X End Pos Register 1 */
	{0x90,0xEF},	/* Sub Window Y End Pos Register 0 */
	{0x91,0x00},	/* Sub Window Y End Pos Register 1 */
	{0xA0,0x00},	/* Power Save Config Register */
	{0xA1,0x00},	/* CPU Access Control Register */
	{0xA2,0x00},	/* Software Reset Register */
	{0xA3,0x00},	/* BIG Endian Support Register */
	{0xA4,0x00},	/* Scratch Pad Register 0 */
	{0xA5,0x00},	/* Scratch Pad Register 1 */
	{0xA8,0x06},	/* GPIO Config Register 0 */
	{0xA9,0x80},	/* GPIO Config Register 1 */
	{0xAC,0x04},	/* GPIO Status Control Register 0 */
	{0xAD,0x00},	/* GPIO Status Control Register 1 */
	{0xB0,0x00},	/* PWM CV Clock Control Register */
	{0xB1,0x00},	/* PWM CV Clock Config Register */
	{0xB2,0x00},	/* CV Clock Burst Length Register */
	{0xB3,0x00},	/* PWM Clock Duty Cycle Register */
};

#endif /* _CARNEOL_S1D13706FB_H_ */

--------------020607030302090703020408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------020607030302090703020408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------020607030302090703020408--

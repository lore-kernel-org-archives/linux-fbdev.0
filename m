From: "hinko.kocevar@cetrtapot.si" <hinko.kocevar@cetrtapot.si>
Subject: Kernel upgrade...
Date: Fri, 02 Feb 2007 15:43:08 +0100
Message-ID: <45C34DFC.7070100@cetrtapot.si>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020805000703050108090403"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCzdN-0004s4-9a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 06:43:25 -0800
Received: from n1.cetrtapot.si ([89.212.80.162])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCzdK-0008Lj-6s
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 06:43:24 -0800
Received: from localhost (localhost.dmz.cetrtapot.si [127.0.0.1])
	by n1.cetrtapot.si (Postfix) with ESMTP id 4D17EBC80
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  2 Feb 2007 15:43:13 +0100 (CET)
Received: from n1.cetrtapot.si ([127.0.0.1])
	by localhost (n1.dmz.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58980-03 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  2 Feb 2007 15:43:08 +0100 (CET)
Received: from [172.31.65.127] (unknown [192.168.66.2])
	by n1.cetrtapot.si (Postfix) with ESMTP id 42201BC5E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  2 Feb 2007 15:43:08 +0100 (CET)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020805000703050108090403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello all,

I'm using EPSON SED3706 graphics chip connected to my embedded device.=20
Im' running 2.6.12 kernel at the moment. I would like to upgrade to=20
2.6.15 (certain bug fixes in cris arch). When trying to use SDL=20
applications that work fine on 2.6.12, on 2.6.15 kernel I colors are not=20
displayed correctly.

I've tested the cases with:
- SDL 1.2.8, 1.2.11
- linux kernel 2.6.12, 2.6.15

Any SDL and only kernel 2.6.12 is operating correctly for me. As soon as=20
I use kernel 2.6.15 colors on the LCD get weird. Eg. I using black BG=20
and printing some text on the screen several white pixels are present=20
where they should not be - as if transparent pixels are drawn - where=20
color changes from one to another. This only around red,=20
white,yellow,green, .. text printed on the black surface. On the other=20
hand white text printed on the red surface is rendered fine..

When testing with native console application, none of this transparent=20
pixel 'errors' can be seen?!

I'm also attaching my fb driver for Epson SED3706 chip I'm using on my=20
embedded platform (it is similar to Epsons driver, with lowlevel=20
modifications for our cris arch).

I was wondering if there were any changes to the fddev subsystem between=20
2.6.12 and 2.6.15 that might break something for me?
Looking at the diff between the two versions there is a lot of updates=20
for 2.6.15 but I have trouble finding the part where it went wrong for me=
...

thanx,
hinko

--=20
=C4=8CETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si

--------------020805000703050108090403
Content-Type: text/x-csrc;
 name="s1d13706fb.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s1d13706fb.c"

/*
 * linux/drivers/video/s1d13706fb.c -- Epson S1D13706 frame buffer for 2.6.
 *
 * Epson Research S1D13706 Embedded LCD Controller
 *   (previously known as SED1355)
 *
 * Cf. http://www.erd.epson.com/vdc/html/S1D13706.html
 *
 */
					   
#include <linux/config.h>
#include <linux/module.h>
//#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/delay.h>
#include <linux/slab.h>

#include <linux/types.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/fb.h>

#include <asm/io.h>

//FROM the header file
#define S1D_DISPLAY_WIDTH           320
#define S1D_DISPLAY_HEIGHT          240

#define S1DREG_LCD_MEM_OFF0         0x80
#define S1DREG_LCD_MEM_OFF1         0x81

#define S1DREG_DISP_MODE            0x70
#define S1D_PALETTE_SIZE            256
#define S1D_REGDELAYOFF             0xFFFE
#define S1D_REGDELAYON              0xFFFF

#define S1D_WRITE_PALETTE(p,i,r,g,b)  \
{  \
    ((volatile S1D_VALUE*)(p))[0x0A/sizeof(S1D_VALUE)] = (S1D_VALUE)(r);  \
    ((volatile S1D_VALUE*)(p))[0x09/sizeof(S1D_VALUE)] = (S1D_VALUE)(g);  \
    ((volatile S1D_VALUE*)(p))[0x08/sizeof(S1D_VALUE)] = (S1D_VALUE)(b);  \
    ((volatile S1D_VALUE*)(p))[0x0B/sizeof(S1D_VALUE)] = (S1D_VALUE)(i);  \
}

struct s1d13706fb_par
{
    u8 * RegAddr;
};


/*******************************************************************************
 *                                                                             *
 *                            R E G S   R E A D                                *
 *                                                                             *
 *******************************************************************************/

static inline u8
s1d13706fb_readreg (struct s1d13706fb_par *par, u16 regno)
{
       return readb ((const volatile void __iomem *)(par->RegAddr + regno));
}

static inline void
s1d13706fb_writereg (struct s1d13706fb_par *par, u16 regno, u8 value)
{
       writeb (value, (volatile unsigned char *)(par->RegAddr + regno));
}

static void 
clearfb16 (struct fb_info *info)
{
    u16 *dst = (u16 *) info->screen_base;
    unsigned long n = info->fix.smem_len;
		
    while (n > 1) 
    {
        fb_writew(0, dst);
        dst++;
	n -= 2;
    }
    
    if (n)
	fb_writeb(0, dst);
}

/*
 * SYSFS STUFF
 */
#define show_reg(reg)												\
static ssize_t show_reg_##reg (struct device *dev,					\
				struct device_attribute *attr,						\
				char *buf)											\
{																	\
	unsigned char val;												\
	struct fb_info *info = dev_get_drvdata(dev);					\
	struct s1d13706fb_par *par = info->par;							\
																	\
	val = s1d13706fb_readreg(par, reg);								\
	return sprintf(buf, "%s: (reg) 0x%04x (val) 0x%02x\n",			\
			  __FUNCTION__, reg, val);								\
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

#define set_reg(reg)												\
static ssize_t set_reg_##reg (struct device *dev,					\
			struct device_attribute *attr,							\
			const char *buf, size_t count)							\
{																	\
	struct fb_info *info = dev_get_drvdata(dev);					\
	struct s1d13706fb_par *par = info->par;							\
	unsigned char val = simple_strtoul(buf, NULL, 16);				\
																	\
	printk("%s: (reg) 0x%04x (val) 0x%02x\n",						\
			  __FUNCTION__, reg, val);								\
	if (reg == 0xAD)												\
		set_bl_reg (dev, val);										\
	else															\
		s1d13706fb_writereg(par, reg, val);							\
	return count;													\
}																	\
static DEVICE_ATTR(s1d_reg_##reg, S_IWUSR | S_IRUGO,				\
				show_reg_##reg, set_reg_##reg);

set_reg(0x12);  // Horizontal Total Register
set_reg(0x14);  // Horizontal Display Period Register
set_reg(0x16);  // Horizontal Display Period Start Pos Register 0
set_reg(0x17);  // Horizontal Display Period Start Pos Register 1
set_reg(0x18);  // Vertical Total Register 0
set_reg(0x19);  // Vertical Total Register 1
set_reg(0x1C);  // Vertical Display Period Register 0
set_reg(0x1D);  // Vertical Display Period Register 1
set_reg(0x1E);  // Vertical Display Period Start Pos Register 0
set_reg(0x1F);  // Vertical Display Period Start Pos Register 1
set_reg(0x20);  // Horizontal Sync Pulse Width Register
set_reg(0x22);  // Horizontal Sync Pulse Start Pos Register 0
set_reg(0x23);  // Horizontal Sync Pulse Start Pos Register 1
set_reg(0x24);  // Vertical Sync Pulse Width Register
set_reg(0x26);  // Vertical Sync Pulse Start Pos Register 0
set_reg(0x27);  // Vertical Sync Pulse Start Pos Register 1

set_reg(0xA8);  // GPIO Config Register 0
set_reg(0xA9);  // GPIO Config Register 1
set_reg(0xAC);  // GPIO Status Control Register 0
set_reg(0xAD);	// GPIO Status Control Register 1

/* LCD ripping DEBUG */


/*******************************************************************************
 *                                                                             *
 *                                F O P S                                      *
 *                                                                             *
 *******************************************************************************/
static int 
s1d13706fb_setcolreg (unsigned regno, unsigned r, unsigned g,
                       unsigned b, unsigned transp,
                       struct fb_info *info)
{
    struct s1d13706fb_par *par = info->par;
    
    if (regno >= S1D_PALETTE_SIZE)
        return 1;
		
    S1D_WRITE_PALETTE(par->RegAddr, regno, r>>8, g>>8, b>>8);

    return (0);		    
}

static int 
s1d13706fb_blank (int blank_mode, struct fb_info *info)
{
    return (0);
}

static int 
s1d13706fb_pan_display (struct fb_var_screeninfo *var,
                       struct fb_info *info)
{
    return (0);
}			   
																												
static struct fb_ops s1d13706fb_fbops = 
{
    .owner          = THIS_MODULE,
    .fb_setcolreg   = s1d13706fb_setcolreg,
    .fb_pan_display = s1d13706fb_pan_display,
    .fb_blank       = s1d13706fb_blank,
    .fb_fillrect    = cfb_fillrect,
    .fb_copyarea    = cfb_copyarea,
    .fb_imageblit   = cfb_imageblit,
};

/*******************************************************************************
 *                                                                             *
 *                                 I N I T                                     *
 *                                                                             *
 *******************************************************************************/

static int 
s1d13706fb_remove(struct device *device)
{
    struct fb_info *info = dev_get_drvdata(device);
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

int __init 
s1d13706fb_probe(struct device *device)
{
    struct platform_device *dev = to_platform_device(device);
    struct s1d13706fb_par *default_par;
    struct fb_info *info;
    S1D_INDEX s1dReg;
    S1D_VALUE s1dValue;
    int rc, i;
    u8 revision;
//    u16 offset;
        
    if (!request_mem_region(S1D_PHYSICAL_REG_ADDR, S1D_PHYSICAL_REG_SIZE, "S1D13706 registers")) 
    {
	printk(KERN_ERR "s1d13706fb: unable to reserve registers at 0x%0lx\n", S1D_PHYSICAL_REG_ADDR);
	rc = -EBUSY;
	goto bail;
    }

    if (!request_mem_region(S1D_PHYSICAL_VMEM_ADDR, S1D_PHYSICAL_VMEM_SIZE, "S1D13706 framebuffer")) 
    {
	printk(KERN_ERR "s1d13706fb: unable to reserve framebuffer at 0x%0lx\n", S1D_PHYSICAL_VMEM_ADDR);
	rc = -EBUSY;
	goto bail;
    }

    info = framebuffer_alloc (sizeof(struct s1d13706fb_par) + sizeof(u32) * 256, &dev->dev);
    if (!info)
    {
        rc = -ENOMEM;
        goto bail;
    }				    

    default_par = info->par;
    default_par->RegAddr = (u8 *) ioremap (S1D_PHYSICAL_REG_ADDR, S1D_PHYSICAL_REG_SIZE);
    if (!default_par->RegAddr) 
    {
        printk(KERN_ERR "s1d13706fb: unable to map registers\n");
        rc = -ENOMEM;
        goto bail;
    }
    
    info->pseudo_palette = (void *)(default_par + 1);	// ???

    info->screen_base = ioremap (S1D_PHYSICAL_VMEM_ADDR, S1D_PHYSICAL_VMEM_SIZE);
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
			    
    printk(KERN_INFO "s1d13706fb: regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
	   default_par->RegAddr, info->fix.smem_len / 1024, info->screen_base);

    for (i = 0; i < sizeof(aS1DRegs)/sizeof(aS1DRegs[0]); i++)
    {
	s1dReg   = aS1DRegs[i].Index;
	s1dValue = aS1DRegs[i].Value;
	  
	if (s1dReg == S1D_REGDELAYOFF || s1dReg == S1D_REGDELAYON)
	{
	    mdelay((int)s1dValue);
	}
	else
	{
	    ((S1D_VALUE*)default_par->RegAddr)[s1dReg/sizeof(S1D_VALUE)] = s1dValue;
	}
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

    clearfb16 (info);

    info->var.activate = FB_ACTIVATE_NOW;
    
    dev_set_drvdata(&dev->dev, info);

	/* SYSFS stuff */
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x12);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x14);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x16);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x17);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x18);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x19);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x1C);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x1D);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x1E);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x1F);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x20);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x22);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x23);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x24);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x26);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0x27);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0xA8);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0xA9);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0xAC);
	device_create_file(&dev->dev, &dev_attr_s1d_reg_0xAD);
	
    printk (KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
    
    return (0);
    
bail:
    s1d13706fb_remove(device);
    return rc;    
}

static void 
s1d13706fb_platform_release(struct device *device)
{
}

static struct device_driver s1d13706fb_driver = 
{
    .name   = "s1d13706fb",
    .bus    = &platform_bus_type,
    .probe  = s1d13706fb_probe,
    .remove = s1d13706fb_remove,
};

static struct platform_device s1d13706fb_device = 
{
    .name   = "s1d13706fb",
    .id     = -1,
    .dev    = {
		.release = s1d13706fb_platform_release,
	      }
};

int __init s1d13706fb_init(void)
{
    int ret;
    
    if (fb_get_options("s1d13706fb", NULL))
        return -ENODEV;

    ret = driver_register(&s1d13706fb_driver);
    if (!ret)
    {
	ret = platform_device_register (&s1d13706fb_device);
	if (ret)
	    driver_unregister (&s1d13706fb_driver);
    }

    return (ret);
}
																									
module_init(s1d13706fb_init);

#ifdef MODULE
static void __exit s1d13706fb_exit(void)
{
    platform_device_unregister (&s1d13706fb_device);
    driver_unregister(&s1d13706fb_driver);
}
		
module_exit(s1d13706fb_exit);
#endif

MODULE_AUTHOR("Simon Posnjak <simon.posnjak@cetrtapot.si>");
MODULE_DESCRIPTION("Framebuffer driver for Epson S1D13706");
MODULE_LICENSE("GPL");

--------------020805000703050108090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------020805000703050108090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------020805000703050108090403--

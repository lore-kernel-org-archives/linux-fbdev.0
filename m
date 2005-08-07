From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: [PATCH 2/3] DEC PMAG BA frame buffer
 update
Date: Sun, 07 Aug 2005 18:24:34 +0800
Message-ID: <42F5E162.4070400@gmail.com>
References: <20050803215954.47d3cfc1.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1iKQ-0001S1-K7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:24:26 -0700
Received: from rproxy.gmail.com ([64.233.170.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1iKP-0000Tf-Ti
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:24:26 -0700
Received: by rproxy.gmail.com with SMTP id j1so785927rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 03:24:24 -0700 (PDT)
In-Reply-To: <20050803215954.47d3cfc1.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>

Andrew Morton wrote:
> for reviewing pleasure (Ralf is shy)

Looks good.

Acked-by: Antonino Daplas <adaplas@pol.net>

PS: Is it possible to port this to the driver model?

> 
> Begin forwarded message:
> 
> Date: Tue, 2 Aug 2005 11:37:34 +0100
> From: Ralf Baechle <ralf@linux-mips.org>
> To: Andrew Morton <akpm@osdl.org>
> Subject: [PATCH 2/3] DEC PMAG BA frame buffer update
> 
> 
> Rewrite PMAG BA frame buffer driver for 2.6.
> 
> diff -urN linux-2.6.13-rc4/drivers/video/pmag-ba-fb.c linux-cvs/drivers/video/pmag-ba-fb.c
> --- linux-2.6.13-rc4/drivers/video/pmag-ba-fb.c	2005-03-17 11:53:40.000000000 +0000
> +++ linux-cvs/drivers/video/pmag-ba-fb.c	2005-07-11 21:55:31.000000000 +0100
> @@ -1,57 +1,55 @@
>  /*
> - *      linux/drivers/video/pmag-ba-fb.c
> + *	linux/drivers/video/pmag-ba-fb.c
>   *
> - *	PMAG-BA TurboChannel framebuffer card support ... derived from:
> + *	PMAG-BA TURBOchannel Color Frame Buffer (CFB) card support,
> + *	derived from:
>   *	"HP300 Topcat framebuffer support (derived from macfb of all things)
>   *	Phil Blundell <philb@gnu.org> 1998", the original code can be
> - *      found in the file hpfb.c in the same directory.
> + *	found in the file hpfb.c in the same directory.
>   *
>   *	Based on digital document:
>   * 	"PMAG-BA TURBOchannel Color Frame Buffer
>   *	 Functional Specification", Revision 1.2, August 27, 1990
>   *
> - *      DECstation related code Copyright (C) 1999, 2000, 2001 by
> - *      Michael Engel <engel@unix-ag.org>, 
> - *      Karsten Merker <merker@linuxtag.org> and
> + *	DECstation related code Copyright (C) 1999, 2000, 2001 by
> + *	Michael Engel <engel@unix-ag.org>,
> + *	Karsten Merker <merker@linuxtag.org> and
>   *	Harald Koerfgen.
> - *      This file is subject to the terms and conditions of the GNU General
> - *      Public License.  See the file COPYING in the main directory of this
> - *      archive for more details.
> + *	Copyright (c) 2005  Maciej W. Rozycki
>   *
> + *	This file is subject to the terms and conditions of the GNU General
> + *	Public License.  See the file COPYING in the main directory of this
> + *	archive for more details.
>   */
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/sched.h>
> +
> +#include <linux/compiler.h>
>  #include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/timer.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
>  #include <linux/fb.h>
> -#include <asm/bootinfo.h>
> -#include <asm/dec/machtype.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#include <asm/bug.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +
>  #include <asm/dec/tc.h>
> +
>  #include <video/pmag-ba-fb.h>
>  
> -struct pmag_ba_ramdac_regs {
> -	unsigned char addr_low;
> -	unsigned char pad0[3];
> -	unsigned char addr_hi;
> -	unsigned char pad1[3];
> -	unsigned char data;
> -	unsigned char pad2[3];
> -	unsigned char cmap;
> +
> +struct pmagbafb_par {
> +	struct fb_info *next;
> +	volatile void __iomem *mmio;
> +	volatile u32 __iomem *dac;
> +	int slot;
>  };
>  
> -/*
> - * Max 3 TURBOchannel slots -> max 3 PMAG-BA :)
> - */
> -static struct fb_info pmagba_fb_info[3];
>  
> -static struct fb_var_screeninfo pmagbafb_defined = {
> +static struct fb_info *root_pmagbafb_dev;
> +
> +static struct fb_var_screeninfo pmagbafb_defined __initdata = {
>  	.xres		= 1024,
>  	.yres		= 864,
>  	.xres_virtual	= 1024,
> @@ -61,58 +59,71 @@
>  	.green.length	= 8,
>  	.blue.length	= 8,
>  	.activate	= FB_ACTIVATE_NOW,
> -	.height		= 274,
> -	.width		= 195,
> -	.accel		= FB_ACCEL_NONE,
> +	.height		= -1,
> +	.width		= -1,
> +	.accel_flags	= FB_ACCEL_NONE,
> +	.pixclock	= 14452,
> +	.left_margin	= 116,
> +	.right_margin	= 12,
> +	.upper_margin	= 34,
> +	.lower_margin	= 12,
> +	.hsync_len	= 128,
> +	.vsync_len	= 3,
> +	.sync		= FB_SYNC_ON_GREEN,
>  	.vmode		= FB_VMODE_NONINTERLACED,
>  };
>  
> -static struct fb_fix_screeninfo pmagbafb_fix = {
> +static struct fb_fix_screeninfo pmagbafb_fix __initdata = {
>  	.id		= "PMAG-BA",
> -	.smem_len	= (1024 * 864),
> +	.smem_len	= (1024 * 1024),
>  	.type		= FB_TYPE_PACKED_PIXELS,
>  	.visual		= FB_VISUAL_PSEUDOCOLOR,
>  	.line_length	= 1024,
> +	.mmio_len	= PMAG_BA_SIZE - PMAG_BA_BT459,
>  };
>  
> -/*
> - * Turn hardware cursor off
> - */
> -void pmagbafb_erase_cursor(struct pmag_ba_ramdac_regs *bt459_regs)
> +
> +static inline void dac_write(struct pmagbafb_par *par, unsigned int reg, u8 v)
>  {
> -	bt459_regs->addr_low = 0;
> -	bt459_regs->addr_hi = 3;
> -	bt459_regs->data = 0;
> +	writeb(v, par->dac + reg / 4);
>  }
>  
> +static inline u8 dac_read(struct pmagbafb_par *par, unsigned int reg)
> +{
> +	return readb(par->dac + reg / 4);
> +}
> +
> +
>  /*
> - * Set the palette. 
> + * Set the palette.
>   */
> -static int pmagbafb_setcolreg(unsigned regno, unsigned red, unsigned green,
> -			      unsigned blue, unsigned transp,
> -			      struct fb_info *info)
> +static int pmagbafb_setcolreg(unsigned int regno, unsigned int red,
> +			      unsigned int green, unsigned int blue,
> +			      unsigned int transp, struct fb_info *info)
>  {
> -	struct pmag_ba_ramdac_regs *bt459_regs = (struct pmag_ba_ramdac_regs *) info->par;
> +	struct pmagbafb_par *par = info->par;
>  
> -	if (regno >= info->cmap.len)
> -		return 1;
> +	BUG_ON(regno >= info->cmap.len);
>  
>  	red   >>= 8;	/* The cmap fields are 16 bits    */
> -	green >>= 8;	/* wide, but the harware colormap */
> +	green >>= 8;	/* wide, but the hardware colormap */
>  	blue  >>= 8;	/* registers are only 8 bits wide */
>  
> -	bt459_regs->addr_low = (__u8) regno;
> -	bt459_regs->addr_hi = 0;
> -	bt459_regs->cmap = red;
> -	bt459_regs->cmap = green;
> -	bt459_regs->cmap = blue;
> +	mb();
> +	dac_write(par, BT459_ADDR_LO, regno);
> +	dac_write(par, BT459_ADDR_HI, 0x00);
> +	wmb();
> +	dac_write(par, BT459_CMAP, red);
> +	wmb();
> +	dac_write(par, BT459_CMAP, green);
> +	wmb();
> +	dac_write(par, BT459_CMAP, blue);
> +
>  	return 0;
>  }
>  
>  static struct fb_ops pmagbafb_ops = {
>  	.owner		= THIS_MODULE,
> -	.fb_get_fix	= gen_get_fix,
> -	.fb_get_var	= gen_get_var,
>  	.fb_setcolreg	= pmagbafb_setcolreg,
>  	.fb_fillrect	= cfb_fillrect,
>  	.fb_copyarea	= cfb_copyarea,
> @@ -120,63 +131,133 @@
>  	.fb_cursor	= soft_cursor,
>  };
>  
> -int __init pmagbafb_init_one(int slot)
> +
> +/*
> + * Turn the hardware cursor off.
> + */
> +static void __init pmagbafb_erase_cursor(struct fb_info *info)
> +{
> +	struct pmagbafb_par *par = info->par;
> +
> +	mb();
> +	dac_write(par, BT459_ADDR_LO, 0x00);
> +	dac_write(par, BT459_ADDR_HI, 0x03);
> +	wmb();
> +	dac_write(par, BT459_DATA, 0x00);
> +}
> +
> +
> +static int __init pmagbafb_init_one(int slot)
>  {
> -	unsigned long base_addr = get_tc_base_addr(slot);
> -	struct fb_info *info = &pmagba_fb_info[slot]; 
> -	struct display *disp = &pmagba_disp[slot];
> -
> -	printk("PMAG-BA framebuffer in slot %d\n", slot);
> -	/*
> -	 * Framebuffer display memory base address and friends
> -	 */
> -	pmagbafb_fix.smem_start = base_addr + PMAG_BA_ONBOARD_FBMEM_OFFSET;
> -	info->par = (base_addr + PMAG_BA_BT459_OFFSET);
> -
> -	/*
> -	 * Configure the Bt459 RAM DAC
> -	 */
> -	pmagbafb_erase_cursor((struct pmag_ba_ramdac_regs *) info->par);
> -
> -	/*
> -	 *      Let there be consoles..
> -	 */
> +	struct fb_info *info;
> +	struct pmagbafb_par *par;
> +	unsigned long base_addr;
> +
> +	info = framebuffer_alloc(sizeof(struct pmagbafb_par), NULL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	par = info->par;
> +	par->slot = slot;
> +	claim_tc_card(par->slot);
> +
> +	base_addr = get_tc_base_addr(par->slot);
> +
> +	par->next = root_pmagbafb_dev;
> +	root_pmagbafb_dev = info;
> +
> +	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
> +		goto err_alloc;
> +
>  	info->fbops = &pmagbafb_ops;
> +	info->fix = pmagbafb_fix;
>  	info->var = pmagbafb_defined;
> -	info->fix = pmagbafb_fix; 
> -	info->screen_base = pmagbafb_fix.smem_start;
>  	info->flags = FBINFO_DEFAULT;
>  
> -	fb_alloc_cmap(&fb_info.cmap, 256, 0);
> +	/* MMIO mapping setup.  */
> +	info->fix.mmio_start = base_addr;
> +	par->mmio = ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
> +	if (!par->mmio)
> +		goto err_cmap;
> +	par->dac = par->mmio + PMAG_BA_BT459;
> +
> +	/* Frame buffer mapping setup.  */
> +	info->fix.smem_start = base_addr + PMAG_BA_FBMEM;
> +	info->screen_base = ioremap_nocache(info->fix.smem_start,
> +					    info->fix.smem_len);
> +	if (!info->screen_base)
> +		goto err_mmio_map;
> +	info->screen_size = info->fix.smem_len;
> +
> +	pmagbafb_erase_cursor(info);
>  
>  	if (register_framebuffer(info) < 0)
> -		return 1;
> +		goto err_smem_map;
> +
> +	pr_info("fb%d: %s frame buffer device in slot %d\n",
> +		info->node, info->fix.id, par->slot);
> +
>  	return 0;
> +
> +
> +err_smem_map:
> +	iounmap(info->screen_base);
> +
> +err_mmio_map:
> +	iounmap(par->mmio);
> +
> +err_cmap:
> +	fb_dealloc_cmap(&info->cmap);
> +
> +err_alloc:
> +	root_pmagbafb_dev = par->next;
> +	release_tc_card(par->slot);
> +	framebuffer_release(info);
> +	return -ENXIO;
> +}
> +
> +static void __exit pmagbafb_exit_one(void)
> +{
> +	struct fb_info *info = root_pmagbafb_dev;
> +	struct pmagbafb_par *par = info->par;
> +
> +	unregister_framebuffer(info);
> +	iounmap(info->screen_base);
> +	iounmap(par->mmio);
> +	fb_dealloc_cmap(&info->cmap);
> +	root_pmagbafb_dev = par->next;
> +	release_tc_card(par->slot);
> +	framebuffer_release(info);
>  }
>  
> -/* 
> - * Initialise the framebuffer
> - */
>  
> -int __init pmagbafb_init(void)
> +/*
> + * Initialise the framebuffer.
> + */
> +static int __init pmagbafb_init(void)
>  {
> -	int sid;
> -	int found = 0;
> +	int count = 0;
> +	int slot;
>  
>  	if (fb_get_options("pmagbafb", NULL))
> -		return -ENODEV;
> +		return -ENXIO;
>  
> -	if (TURBOCHANNEL) {
> -		while ((sid = search_tc_card("PMAG-BA")) >= 0) {
> -			found = 1;
> -			claim_tc_card(sid);
> -			pmagbafb_init_one(sid);
> -		}
> -		return found ? 0 : -ENODEV;
> -	} else {
> -		return -ENODEV;
> +	while ((slot = search_tc_card("PMAG-BA")) >= 0) {
> +		if (pmagbafb_init_one(slot) < 0)
> +			break;
> +		count++;
>  	}
> +	return (count > 0) ? 0 : -ENXIO;
>  }
>  
> +static void __exit pmagbafb_exit(void)
> +{
> +	while (root_pmagbafb_dev)
> +		pmagbafb_exit_one();
> +}
> +
> +
>  module_init(pmagbafb_init);
> +module_exit(pmagbafb_exit);
> +
>  MODULE_LICENSE("GPL");
> diff -urN linux-2.6.13-rc4/include/video/pmag-ba-fb.h linux-cvs/include/video/pmag-ba-fb.h
> --- linux-2.6.13-rc4/include/video/pmag-ba-fb.h	2004-12-24 21:34:48.000000000 +0000
> +++ linux-cvs/include/video/pmag-ba-fb.h	2005-07-11 21:56:17.000000000 +0100
> @@ -1,24 +1,27 @@
>  /*
> - *      linux/drivers/video/pmag-ba-fb.h
> + *	linux/include/video/pmag-ba-fb.h
>   *
> - *      TurboChannel PMAG-BA framebuffer card support,
> - *      Copyright (C) 1999,2000,2001 by
> - *      Michael Engel <engel@unix-ag.org>,
> - *      Karsten Merker <merker@linuxtag.org>
> - *      This file is subject to the terms and conditions of the GNU General
> - *      Public License.  See the file COPYING in the main directory of this
> - *      archive for more details.
> - */
> -
> -/*
> - * Bt459 RAM DAC register base offset (rel. to TC slot base address)
> + *	TURBOchannel PMAG-BA Color Frame Buffer (CFB) card support,
> + *	Copyright (C) 1999, 2000, 2001 by
> + *	Michael Engel <engel@unix-ag.org>,
> + *	Karsten Merker <merker@linuxtag.org>
> + *	Copyright (c) 2005  Maciej W. Rozycki
> + *
> + *	This file is subject to the terms and conditions of the GNU General
> + *	Public License.  See the file COPYING in the main directory of this
> + *	archive for more details.
>   */
>  
> -#define PMAG_BA_BT459_OFFSET                    0x00200000
> -
> -/*
> - * Begin of PMAG-BA framebuffer memory relative to TC slot address,
> - * resolution is 1024x864x8
> - */
> +/* IOmem resource offsets.  */
> +#define PMAG_BA_FBMEM		0x000000	/* frame buffer */
> +#define PMAG_BA_BT459		0x200000	/* Bt459 RAMDAC */
> +#define PMAG_BA_IRQ		0x300000	/* IRQ acknowledge */
> +#define PMAG_BA_ROM		0x380000	/* REX option ROM */
> +#define PMAG_BA_BT438		0x380000	/* Bt438 clock chip reset */
> +#define PMAG_BA_SIZE		0x400000	/* address space size */
>  
> -#define PMAG_BA_ONBOARD_FBMEM_OFFSET    0x00000000
> +/* Bt459 register offsets, byte-wide registers.  */
> +#define BT459_ADDR_LO		0x0		/* address low */
> +#define BT459_ADDR_HI		0x4		/* address high */
> +#define BT459_DATA		0x8		/* data window register */
> +#define BT459_CMAP		0xc		/* color map window register */
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

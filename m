From: Kronos <kronos@people.it>
Subject: Re: [patch] Add w100 framebuffer driver
Date: Thu, 6 Jan 2005 19:05:11 +0100
Message-ID: <20050106180511.GA8050@dreamland.darkstar.lan>
References: <200501031947.33925.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cmc0Z-0001Cq-TM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 10:05:15 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cmc0V-0006kJ-H5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 10:05:15 -0800
Content-Disposition: inline
In-Reply-To: <200501031947.33925.rpurdie@rpsys.net>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "adaplas@hotpop.com" <adaplas@hotpop.com>

Il Mon, Jan 03, 2005 at 07:47:33PM +0000, Richard Purdie ha scritto:=20
> Add a framebuffer driver for the ATI w100 as found on several Sharp PDA=
s

Some minor comments:

> --- /dev/null
> +++ linux-2.6.10/drivers/video/w100fb.c
> @@ -0,0 +1,1848 @@
> +/*
> + * linux/drivers/video/w100fb.c
> + *
> + * Frame Buffer Device for ATI Imageon w100 (Wallaby)
> + *
> + * Copyright (C) 2002, ATI Corp.
> + * Copyright (C) 2004-2005 Richard Purdie
> + *
> + * Rewritten for 2.6 by Richard Purdie <rpurdie@rpsys.net>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <asm/io.h>
> +#include <asm/uaccess.h>
> +#include <linux/delay.h>=20
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/device.h>
> +#include <linux/string.h>
> +#include <linux/proc_fs.h>
> +#include <video/w100fb.h>
> +#include "w100fb.h"

Usualy asm headers are included after linux ones.

> +/* General frame buffer data structures */
> +static struct fb_info w100info;

fb layers is (slowly) migrating to dinamically allocated fb_info in
order to integrate with the driver model. Please use framebuffer_alloc
and framebuffer_release.

> +static int w100fb_blank(int blank_mode, struct fb_info *info)
> +{
> +	switch(blank_mode) {
> +
> + 	case FB_BLANK_NORMAL: /* Normal blanking */
> +	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
> +	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
> + 	case FB_BLANK_POWERDOWN: /* Poweroff */ =20
> +  		if (current_par.blanking_flag =3D=3D 0) {
> +    		w100fb_save_buffer();
> +    		lcdtg_suspend();
> +    		current_par.blanking_flag =3D 1;
> +  		}
> +  		break;

Ops, block indentation has gone fubar.

> + =09
> + 	case FB_BLANK_UNBLANK: /* Unblanking */
> +  		if (current_par.blanking_flag !=3D 0) {
> +    		w100fb_restore_buffer();
> +    		lcdtg_resume();
> +    		current_par.blanking_flag =3D 0;    	=09
> +  		}
> +  		break;

Ditto.

> +static int w100fb_check_var(struct fb_var_screeninfo *var, struct fb_i=
nfo=20
> *info)
> +{
> +	if (var->xres < var->yres) { /* Portrait mode */
> +		if ((var->xres > 480) || (var->yres > 640)) {
> +			return -EINVAL;
> +		} else if ((var->xres > 240) || (var->yres > 320)) {
> +			var->xres =3D 480;
> +			var->yres =3D 640;
> +		} else {
> +			var->xres =3D 240;
> +			var->yres =3D 320;
> +		}=09
> +	} else { /* Landscape mode */
> +		if ((var->xres > 640) || (var->yres > 480)) {
> +			return -EINVAL;
> +		} else if ((var->xres > 320) || (var->yres > 240)) {
> +			var->xres =3D 640;
> +			var->yres =3D 480;
> +		} else {
> +			var->xres =3D 320;
> +			var->yres =3D 240;
> +		}=09
> +	}=20
> +
> +	var->xres_virtual =3D max(var->xres_virtual, var->xres);
> +	var->yres_virtual =3D max(var->yres_virtual, var->yres);
> +
> +	if (var->bits_per_pixel > BITS_PER_PIXEL) return -EINVAL;
> +	else var->bits_per_pixel =3D BITS_PER_PIXEL;

Please use something like this:

if (cond)
        exp1;
else
        exp2;

it's much easier to read. I've noticed more of this below...

> +static int w100fb_set_par(struct fb_info *info)
> +{
> +	current_par.xres =3D info->var.xres;
> +	current_par.yres =3D info->var.yres;
> +
> +	info->fix.visual =3D FB_VISUAL_TRUECOLOR;
> +
> +	info->fix.ypanstep =3D 0;
> +	info->fix.ywrapstep =3D 0;
> +=09
> +	if (current_par.blanking_flag) w100fb_clear_buffer();

;)

> +static void w100fb_save_buffer(void)
> +{
> +	int i, j;
> +
> +	for (i =3D 0; i < 640; i++) {
> +		if (gSaveImagePtr[i] !=3D NULL) {
> +			kfree(gSaveImagePtr[i]);
> +			gSaveImagePtr[i] =3D NULL;
> +		}
> +		if (i < current_par.yres) {
> +			gSaveImagePtr[i] =3D kmalloc(current_par.xres * BITS_PER_PIXEL / 8,=
=20
> GFP_KERNEL);

Hmmm, you may end up allocating up to 640 blocks of 960 bytes each (or
480 blocks, 1280 bytes each). It may be better to vmalloc a big chunk
and use that. Not sure about this though...

> +			if (gSaveImagePtr[i] !=3D NULL) {
> +				for (j =3D 0; j < (current_par.xres); j++)
> +					*(gSaveImagePtr[i] + j) =3D readw(remapped_fbuf + (2*j)+=20
> (i*current_par.xres*2));
> +			} else {
> +				printk("can't alloc pre-off image buffer %d\n", i);

Missing prefix, maybe KERN_WARN?

> +int __init w100fb_probe(struct device *dev)
> +{
> +	struct w100fb_mach_info *inf;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct resource *mem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> +=09
> +	if (!mem) return -EINVAL;

Indentation.

> +
> +	/* remap the areas we're going to use */
> +	remapped_base =3D ioremap_nocache(mem->start+W100_CFG_BASE, W100_CFG_=
LEN);
> +	if (remapped_base =3D=3D NULL) return -EIO;

Ditto.

> +static int w100fb_remove(struct device *dev)
> +{
> +     device_remove_file(dev, &dev_attr_fastsysclk);
> +     device_remove_file(dev, &dev_attr_reg_read);
> +     device_remove_file(dev, &dev_attr_reg_write);
> +     device_remove_file(dev, &dev_attr_rotation);
> +
> +     kfree(w100info.pseudo_palette);

Clean up should be done _after_ unregister_framebuffer.

> +     w100fb_clear_buffer();
> +
> +     unregister_framebuffer(&w100info);
> +
> +     iounmap(remapped_base);
> +     iounmap(remapped_regs);
> +     iounmap(remapped_fbuf);
> +
> +     return 0;
> +}


> +static power_state_t gPowerState;

mixedCaseVarsAndFuncAreEvil ;)

> +static uint8_t w100_GetPLLTestCount(uint8_t testclk_sel)
> +{
> +	udelay(5);
> +
> +	gPowerState.clk_test_cntl.f.start_check_freq =3D 0x0;
> +	gPowerState.clk_test_cntl.f.testclk_sel =3D testclk_sel;
> +	gPowerState.clk_test_cntl.f.tstcount_rst =3D 0x1;	/*reset test count =
*/
> +	writel((uint32_t) (gPowerState.clk_test_cntl.val), remapped_regs +=20
> mmCLK_TEST_CNTL);
> +	gPowerState.clk_test_cntl.f.tstcount_rst =3D 0x0;
> +	writel((uint32_t) (gPowerState.clk_test_cntl.val), remapped_regs +=20
> mmCLK_TEST_CNTL);
> +
> +	gPowerState.clk_test_cntl.f.start_check_freq =3D 0x1;
> +	writel((uint32_t) (gPowerState.clk_test_cntl.val), remapped_regs +=20
> mmCLK_TEST_CNTL);
> +
> +	udelay(20);=09
> +
> +	gPowerState.clk_test_cntl.val =3D readl(remapped_regs + mmCLK_TEST_CN=
TL);
> +	gPowerState.clk_test_cntl.f.start_check_freq =3D 0x0;
> +	writel((uint32_t) (gPowerState.clk_test_cntl.val), remapped_regs +=20
> mmCLK_TEST_CNTL);
> +
> +	return(gPowerState.clk_test_cntl.f.test_count);

return is not a function.

> +/* data structure definitions */
> +
> +typedef struct _wrap_top_dir_t {
> +     unsigned long top_addr         : 23;
> +     unsigned long    				: 9;
> +     } wrap_top_dir_t;

Are you sure that the compiler does the right thing? Don't you need
__attribute__((packed)) for this and the following structures?


Luca
--=20
Home: http://kronoz.cjb.net
"Vorrei morire ucciso dagli agi. Vorrei che di me si dicesse: ``Com'=E8
morto?'' ``Gli =E8 scoppiato il portafogli''" -- Marcello Marchesi


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

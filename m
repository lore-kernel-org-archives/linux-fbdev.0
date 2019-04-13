From: kbuild test robot <lkp@intel.com>
Date: Sat, 13 Apr 2019 00:02:02 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: add COMPILE_TEST support
Message-Id: <201904130754.VFH41dfZ%lkp@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <57884bfc-efc3-371c-f99c-7fd2ed02f5fc@samsung.com>
In-Reply-To: <57884bfc-efc3-371c-f99c-7fd2ed02f5fc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, kbuild-all@01.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>

Hi Bartlomiej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc4 next-20190412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/video-fbdev-imxfb-add-COMPILE_TEST-support/20190413-050928
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/imxfb.c:380:35: sparse: expression using sizeof(void)
>> drivers/video/fbdev/imxfb.c:380:35: sparse: expression using sizeof(void)
   drivers/video/fbdev/imxfb.c:381:35: sparse: expression using sizeof(void)
   drivers/video/fbdev/imxfb.c:381:35: sparse: expression using sizeof(void)
   include/linux/slab.h:666:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/video/fbdev/imxfb.c:926:38: sparse: expression using sizeof(void)
   drivers/video/fbdev/imxfb.c:926:38: sparse: expression using sizeof(void)
>> drivers/video/fbdev/imxfb.c:977:27: sparse: incorrect type in assignment (different address spaces) @@    expected char [noderef] <asn:2>*screen_base @@    got sn:2>*screen_base @@
   drivers/video/fbdev/imxfb.c:977:27:    expected char [noderef] <asn:2>*screen_base
   drivers/video/fbdev/imxfb.c:977:27:    got void *
>> drivers/video/fbdev/imxfb.c:1049:52: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <avoid *cpu_addr @@
   drivers/video/fbdev/imxfb.c:1049:52:    expected void *cpu_addr
   drivers/video/fbdev/imxfb.c:1049:52:    got char [noderef] <asn:2>*screen_base
   drivers/video/fbdev/imxfb.c:1080:52: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <avoid *cpu_addr @@
   drivers/video/fbdev/imxfb.c:1080:52:    expected void *cpu_addr
   drivers/video/fbdev/imxfb.c:1080:52:    got char [noderef] <asn:2>*screen_base
   include/linux/slab.h:666:13: sparse: call with no type!

vim +380 drivers/video/fbdev/imxfb.c

343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  344  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  345  /*
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  346   *  imxfb_check_var():
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  347   *    Round up in the following order: bits_per_pixel, xres,
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  348   *    yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  349   *    bitfields, horizontal timing, vertical timing.
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  350   */
66c8719b2 drivers/video/imxfb.c       Sascha Hauer  2008-12-16  351  static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  352  {
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  353  	struct imxfb_info *fbi = info->par;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  354  	struct imxfb_rgb *rgb;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  355  	const struct imx_fb_videomode *imxfb_mode;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  356  	unsigned long lcd_clk;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  357  	unsigned long long tmp;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  358  	u32 pcr = 0;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  359  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  360  	if (var->xres < MIN_XRES)
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  361  		var->xres = MIN_XRES;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  362  	if (var->yres < MIN_YRES)
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  363  		var->yres = MIN_YRES;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  364  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  365  	imxfb_mode = imxfb_find_mode(fbi);
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  366  	if (!imxfb_mode)
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  367  		return -EINVAL;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  368  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  369  	var->xres		= imxfb_mode->mode.xres;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  370  	var->yres		= imxfb_mode->mode.yres;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  371  	var->bits_per_pixel	= imxfb_mode->bpp;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  372  	var->pixclock		= imxfb_mode->mode.pixclock;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  373  	var->hsync_len		= imxfb_mode->mode.hsync_len;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  374  	var->left_margin	= imxfb_mode->mode.left_margin;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  375  	var->right_margin	= imxfb_mode->mode.right_margin;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  376  	var->vsync_len		= imxfb_mode->mode.vsync_len;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  377  	var->upper_margin	= imxfb_mode->mode.upper_margin;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  378  	var->lower_margin	= imxfb_mode->mode.lower_margin;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  379  	var->sync		= imxfb_mode->mode.sync;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01 @380  	var->xres_virtual	= max(var->xres_virtual, var->xres);
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  381  	var->yres_virtual	= max(var->yres_virtual, var->yres);
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  382  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  383  	pr_debug("var->bits_per_pixel=%d\n", var->bits_per_pixel);
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  384  
13aaea03b drivers/video/imxfb.c       Sascha Hauer  2012-03-07  385  	lcd_clk = clk_get_rate(fbi->clk_per);
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  386  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  387  	tmp = var->pixclock * (unsigned long long)lcd_clk;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  388  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  389  	do_div(tmp, 1000000);
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  390  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  391  	if (do_div(tmp, 1000000) > 500000)
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  392  		tmp++;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  393  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  394  	pcr = (unsigned int)tmp;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  395  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  396  	if (--pcr > 0x3F) {
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  397  		pcr = 0x3F;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  398  		printk(KERN_WARNING "Must limit pixel clock to %luHz\n",
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  399  				lcd_clk / pcr);
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  400  	}
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  401  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  402  	switch (var->bits_per_pixel) {
1512222b1 drivers/video/imxfb.c       Sascha Hauer  2009-01-26  403  	case 32:
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  404  		pcr |= PCR_BPIX_18;
1512222b1 drivers/video/imxfb.c       Sascha Hauer  2009-01-26  405  		rgb = &def_rgb_18;
1512222b1 drivers/video/imxfb.c       Sascha Hauer  2009-01-26  406  		break;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  407  	case 16:
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  408  	default:
e69dc9a91 drivers/video/imxfb.c       Shawn Guo     2012-09-16  409  		if (is_imx1_fb(fbi))
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  410  			pcr |= PCR_BPIX_12;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  411  		else
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  412  			pcr |= PCR_BPIX_16;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  413  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  414  		if (imxfb_mode->pcr & PCR_TFT)
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  415  			rgb = &def_rgb_16_tft;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  416  		else
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  417  			rgb = &def_rgb_16_stn;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  418  		break;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  419  	case 8:
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  420  		pcr |= PCR_BPIX_8;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  421  		rgb = &def_rgb_8;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  422  		break;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  423  	}
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  424  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  425  	/* add sync polarities */
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  426  	pcr |= imxfb_mode->pcr & ~(0x3f | (7 << 25));
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  427  
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  428  	fbi->pcr = pcr;
b62ea4112 drivers/video/fbdev/imxfb.c Martin Kaiser 2017-04-21  429  	/*
b62ea4112 drivers/video/fbdev/imxfb.c Martin Kaiser 2017-04-21  430  	 * The LCDC AUS Mode Control Register does not exist on imx1.
b62ea4112 drivers/video/fbdev/imxfb.c Martin Kaiser 2017-04-21  431  	 */
b62ea4112 drivers/video/fbdev/imxfb.c Martin Kaiser 2017-04-21  432  	if (!is_imx1_fb(fbi) && imxfb_mode->aus_mode)
b62ea4112 drivers/video/fbdev/imxfb.c Martin Kaiser 2017-04-21  433  		fbi->lauscr = LAUSCR_AUS_MODE;
343684ffb drivers/video/imxfb.c       Sascha Hauer  2009-03-19  434  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  435  	/*
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  436  	 * Copy the RGB parameters for this display
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  437  	 * from the machine specific parameters.
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  438  	 */
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  439  	var->red    = rgb->red;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  440  	var->green  = rgb->green;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  441  	var->blue   = rgb->blue;
80eee6bca drivers/video/imxfb.c       Sascha Hauer  2008-12-16  442  	var->transp = rgb->transp;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  443  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  444  	pr_debug("RGBT length = %d:%d:%d:%d\n",
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  445  		var->red.length, var->green.length, var->blue.length,
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  446  		var->transp.length);
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  447  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  448  	pr_debug("RGBT offset = %d:%d:%d:%d\n",
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  449  		var->red.offset, var->green.offset, var->blue.offset,
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  450  		var->transp.offset);
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  451  
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  452  	return 0;
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  453  }
7c2f891cb drivers/video/imxfb.c       Sascha Hauer  2005-05-01  454  

:::::: The code at line 380 was first introduced by commit
:::::: 7c2f891cb64b0b9c8d389da97c221ee4288f1307 [PATCH] imxfb: Add Freescale i.MX framebuffer driver

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

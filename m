Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAC401A27;
	Mon, 11 May 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513859; cv=none; b=hWIYJOUcH4aZGJKbFytygjaQfdSeBRS6s8jcA8yDB4A74Y3czQvtQe3WpEwhlhelyi3VSQ3gRHjSa6jEs9lYr7P1VZWTcWbf+9D5nCMdtgjhrDFEGp6BKfzvOZX6hC/7wJTWlgty21MtlTgCuj7W1DhlqzdOnysNLrbWHLFVYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513859; c=relaxed/simple;
	bh=1ERw2JJII0ku0hkcgXCz/y4DJh9UBIO4f8+Qt+0NEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlIl43o08PoZgWbi7mrjbAkEPTOFReFh2xMnkagrgkZrGg3o3e7pJkbDEpFoE95jfkKweTr1cb1d+F/1WEHtE06uE4oh3uxC6ySqapI4VUmktFp4kJBlyl6/lT9nEDIsos+rSRls8yne+kRc4F87P0QGsO6UIS/iC153vSfRgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXGjlPyT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXGjlPyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778513857; x=1810049857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ERw2JJII0ku0hkcgXCz/y4DJh9UBIO4f8+Qt+0NEy8=;
  b=eXGjlPyTNkteHwO2plo7shvCzyymcjwhfW3Ht3o3azT0UMRMXXVFQ7xL
   vsa3TgKm5P8uFKqxK+xSt6vzqAZb3ylAZQeELUp2yJQTUvG81Myjphwid
   eOjRrqrpNhmfoEs35PQv5BumCayHvvxEdZ9fuIEBsopNGrWzXo0rLqGGS
   QxF0fcSU+0sDxCFPPCCE78pE6ppRfP/o+nXgChEJGnWbniF1BbQx5lsZQ
   nYkXHcAFFkg2sW8+qV5JbkifZO38SYTc3+X/xCDyf8t5itolNCQWvR7Kt
   3AgpIgPQf4/XKyKDDPSU9EQngwDmZbY3yGlqDFINtyZgsFut/SKoySiUX
   w==;
X-CSE-ConnectionGUID: F2d7WghrTkSEa2UFPLDXgA==
X-CSE-MsgGUID: LCM5oY5DTrS3sebUppeRfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79351102"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79351102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:37:37 -0700
X-CSE-ConnectionGUID: hjDAa8esRQeyNS1Qi6P0nA==
X-CSE-MsgGUID: WzG47hM2T4CNA3NMdbSqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="236632493"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 May 2026 08:37:33 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMShH-000000000lt-0msj;
	Mon, 11 May 2026 15:37:31 +0000
Date: Mon, 11 May 2026 23:37:26 +0800
From: kernel test robot <lkp@intel.com>
To: Alone <yogeshdangal66@gmail.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: Add const to g_fbmode array
Message-ID: <202605112333.ORNyLXKe-lkp@intel.com>
References: <20260509164057.71722-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509164057.71722-1-yogeshdangal66@gmail.com>

Hi Alone,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Alone/staging-sm750fb-Add-const-to-g_fbmode-array/20260511-155715
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260509164057.71722-1-yogeshdangal66%40gmail.com
patch subject: [PATCH] staging: sm750fb: Add const to g_fbmode array
config: arm64-randconfig-003-20260511 (https://download.01.org/0day-ci/archive/20260511/202605112333.ORNyLXKe-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260511/202605112333.ORNyLXKe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605112333.ORNyLXKe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:785:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     785 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:787:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     787 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:896:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     896 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:900:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     900 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +785 drivers/staging/sm750fb/sm750.c

81dee67e215b23f Sudip Mukherjee      2015-03-03  719  
81dee67e215b23f Sudip Mukherjee      2015-03-03  720  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23f Sudip Mukherjee      2015-03-03  721  {
81dee67e215b23f Sudip Mukherjee      2015-03-03  722  	int i;
81dee67e215b23f Sudip Mukherjee      2015-03-03  723  	struct lynxfb_par *par;
e359b6a863e19f2 Mike Rapoport        2015-10-26  724  	struct sm750_dev *sm750_dev;
81dee67e215b23f Sudip Mukherjee      2015-03-03  725  	struct lynxfb_crtc *crtc;
81dee67e215b23f Sudip Mukherjee      2015-03-03  726  	struct lynxfb_output *output;
81dee67e215b23f Sudip Mukherjee      2015-03-03  727  	struct fb_var_screeninfo *var;
81dee67e215b23f Sudip Mukherjee      2015-03-03  728  	struct fb_fix_screeninfo *fix;
81dee67e215b23f Sudip Mukherjee      2015-03-03  729  
81dee67e215b23f Sudip Mukherjee      2015-03-03  730  	const struct fb_videomode *pdb[] = {
81dee67e215b23f Sudip Mukherjee      2015-03-03  731  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23f Sudip Mukherjee      2015-03-03  732  	};
81dee67e215b23f Sudip Mukherjee      2015-03-03  733  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d0856045f0e9fc9 Hungyu Lin           2026-04-01  734  	static const char * const fix_id[2] = {
81dee67e215b23f Sudip Mukherjee      2015-03-03  735  		"sm750_fb1", "sm750_fb2",
81dee67e215b23f Sudip Mukherjee      2015-03-03  736  	};
81dee67e215b23f Sudip Mukherjee      2015-03-03  737  
81dee67e215b23f Sudip Mukherjee      2015-03-03  738  	int ret, line_length;
81dee67e215b23f Sudip Mukherjee      2015-03-03  739  
81dee67e215b23f Sudip Mukherjee      2015-03-03  740  	ret = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  741  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f2 Mike Rapoport        2015-10-26  742  	sm750_dev = par->dev;
81dee67e215b23f Sudip Mukherjee      2015-03-03  743  	crtc = &par->crtc;
81dee67e215b23f Sudip Mukherjee      2015-03-03  744  	output = &par->output;
81dee67e215b23f Sudip Mukherjee      2015-03-03  745  	var = &info->var;
81dee67e215b23f Sudip Mukherjee      2015-03-03  746  	fix = &info->fix;
81dee67e215b23f Sudip Mukherjee      2015-03-03  747  
81dee67e215b23f Sudip Mukherjee      2015-03-03  748  	/* set index */
81dee67e215b23f Sudip Mukherjee      2015-03-03  749  	par->index = index;
81dee67e215b23f Sudip Mukherjee      2015-03-03  750  	output->channel = &crtc->channel;
81dee67e215b23f Sudip Mukherjee      2015-03-03  751  	sm750fb_set_drv(par);
81dee67e215b23f Sudip Mukherjee      2015-03-03  752  
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  753  	/*
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  754  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  755  	 * must be set after crtc member initialized
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  756  	 */
fdc234d85210d91 Benjamin Philip      2021-07-28  757  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f2 Mike Rapoport        2015-10-26  758  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f2 Mike Rapoport        2015-10-26  759  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23f Sudip Mukherjee      2015-03-03  760  
cd33da26036ea54 Christopher Carbone  2022-08-23  761  	crtc->cursor.max_h = 64;
cd33da26036ea54 Christopher Carbone  2022-08-23  762  	crtc->cursor.max_w = 64;
39f9137268ee3df Benjamin Philip      2021-07-26  763  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f2 Mike Rapoport        2015-10-26  764  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23f Sudip Mukherjee      2015-03-03  765  
3de08a2d14ff8c7 Lorenzo Stoakes      2015-03-20  766  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09d Thomas Zimmermann    2023-11-27  767  	if (!g_hwcursor)
52d0744d751d8f1 Arnd Bergmann        2016-11-09  768  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23f Sudip Mukherjee      2015-03-03  769  
81dee67e215b23f Sudip Mukherjee      2015-03-03  770  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f2 Mike Rapoport        2015-10-26  771  	if (!sm750_dev->accel_off) {
81dee67e215b23f Sudip Mukherjee      2015-03-03  772  		/* use 2d acceleration */
f7c8a046577e09d Thomas Zimmermann    2023-11-27  773  		if (!g_hwcursor)
f7c8a046577e09d Thomas Zimmermann    2023-11-27  774  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  775  		else
f7c8a046577e09d Thomas Zimmermann    2023-11-27  776  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  777  	} else {
f7c8a046577e09d Thomas Zimmermann    2023-11-27  778  		if (!g_hwcursor)
81dee67e215b23f Sudip Mukherjee      2015-03-03  779  			info->fbops = &lynxfb_ops;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  780  		else
f7c8a046577e09d Thomas Zimmermann    2023-11-27  781  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  782  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  783  
81dee67e215b23f Sudip Mukherjee      2015-03-03  784  	if (!g_fbmode[index]) {
81dee67e215b23f Sudip Mukherjee      2015-03-03 @785  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23f Sudip Mukherjee      2015-03-03  786  		if (index)
81dee67e215b23f Sudip Mukherjee      2015-03-03  787  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23f Sudip Mukherjee      2015-03-03  788  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  789  
81dee67e215b23f Sudip Mukherjee      2015-03-03  790  	for (i = 0; i < 3; i++) {
81dee67e215b23f Sudip Mukherjee      2015-03-03  791  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23f Sudip Mukherjee      2015-03-03  792  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23f Sudip Mukherjee      2015-03-03  793  
db7fb3588ab4920 Artem Lytkin         2026-02-23  794  		if (ret == 1 || ret == 2)
81dee67e215b23f Sudip Mukherjee      2015-03-03  795  			break;
81dee67e215b23f Sudip Mukherjee      2015-03-03  796  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  797  
81dee67e215b23f Sudip Mukherjee      2015-03-03  798  	/* set par */
81dee67e215b23f Sudip Mukherjee      2015-03-03  799  	par->info = info;
81dee67e215b23f Sudip Mukherjee      2015-03-03  800  
81dee67e215b23f Sudip Mukherjee      2015-03-03  801  	/* set info */
e3a3f9f5123683b Mike Rapoport        2015-10-26  802  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683b Mike Rapoport        2015-10-26  803  			    crtc->line_pad);
81dee67e215b23f Sudip Mukherjee      2015-03-03  804  
81dee67e215b23f Sudip Mukherjee      2015-03-03  805  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab6 Benjamin Philip      2021-07-28  806  	info->screen_base = crtc->v_screen;
81dee67e215b23f Sudip Mukherjee      2015-03-03  807  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23f Sudip Mukherjee      2015-03-03  808  
81dee67e215b23f Sudip Mukherjee      2015-03-03  809  	/* set info->fix */
81dee67e215b23f Sudip Mukherjee      2015-03-03  810  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23f Sudip Mukherjee      2015-03-03  811  	fix->type_aux = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  812  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  813  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  814  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  815  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23f Sudip Mukherjee      2015-03-03  816  
8c475735085a7db Tim Wassink          2025-12-21  817  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23f Sudip Mukherjee      2015-03-03  818  
fdc234d85210d91 Benjamin Philip      2021-07-28  819  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  820  	/*
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  821  	 * according to mmap experiment from user space application,
81dee67e215b23f Sudip Mukherjee      2015-03-03  822  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23f Sudip Mukherjee      2015-03-03  823  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23f Sudip Mukherjee      2015-03-03  824  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23f Sudip Mukherjee      2015-03-03  825  	 * data into the bound over virtual size
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  826  	 */
81dee67e215b23f Sudip Mukherjee      2015-03-03  827  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23f Sudip Mukherjee      2015-03-03  828  	info->screen_size = fix->smem_len;
81dee67e215b23f Sudip Mukherjee      2015-03-03  829  	fix->line_length = line_length;
e359b6a863e19f2 Mike Rapoport        2015-10-26  830  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f2 Mike Rapoport        2015-10-26  831  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f4 Matej Dujava         2020-04-30  832  
b610e1193a917f4 Matej Dujava         2020-04-30  833  	lynxfb_set_visual_mode(info);
81dee67e215b23f Sudip Mukherjee      2015-03-03  834  
81dee67e215b23f Sudip Mukherjee      2015-03-03  835  	/* set var */
81dee67e215b23f Sudip Mukherjee      2015-03-03  836  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23f Sudip Mukherjee      2015-03-03  837  	var->accel_flags = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  838  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23f Sudip Mukherjee      2015-03-03  839  
61c507cf652da1b Michel von Czettritz 2015-03-26  840  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1b Michel von Czettritz 2015-03-26  841  	if (ret < 0) {
fbab250eb51d6d6 Artem Lytkin         2026-02-07  842  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23f Sudip Mukherjee      2015-03-03  843  		goto exit;
81dee67e215b23f Sudip Mukherjee      2015-03-03  844  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  845  
81dee67e215b23f Sudip Mukherjee      2015-03-03  846  exit:
81dee67e215b23f Sudip Mukherjee      2015-03-03  847  	lynxfb_ops_check_var(var, info);
81dee67e215b23f Sudip Mukherjee      2015-03-03  848  	return ret;
81dee67e215b23f Sudip Mukherjee      2015-03-03  849  }
81dee67e215b23f Sudip Mukherjee      2015-03-03  850  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

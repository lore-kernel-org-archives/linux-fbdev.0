Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A915B998;
	Sun,  8 Mar 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934395; cv=none; b=G0A7HDOVitC6ozzdRHg1ytGvRVTvIakBj2IB6nIjVu9Hc1HtaVHwqT9/3JRlM1XY8Ja+dbRBQXgdnh8ts37IfVzaPomvlMtLgkxLKyS7oBQMHZC8i+oBZUCystS2tf8SmWTYyHbUQN1Or/qkOWzJIPicdX0j1jAf5qWpGJ+C5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934395; c=relaxed/simple;
	bh=JuKrpdeAXiz+uHlpk4oCoHahV6Z5B4HuXYS5XNM/TmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfoQqRgtsd7m8HlTUirzpwJDjK6RJ865VQBF2Jks214c4l46QL+kvHiWaJCyfhq9By8TG5eaPSUkMiigDRQLl7TYG60a3DVzaPnfSTqWEzJkGnQkUUnhPlQZK8uOONcVrJfToOsh/hXxeW6xo/KSfnwaAzFCd1GQaA+9R8Hm2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJjPf+dy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJjPf+dy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772934393; x=1804470393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuKrpdeAXiz+uHlpk4oCoHahV6Z5B4HuXYS5XNM/TmE=;
  b=lJjPf+dyd8fCu93Kxwu+bD5w6fKhtWaIYSnRkQEYwmtn4Ixo1/uJHLCJ
   MFh7rEXxkHavJ6fZtPbGYsZ8DmVMBq64NGmekFtWNNXOmF0ndqxbKpK4c
   ysWlYFYqwRyVHc77ObAzOYYdbH+EgAfsYugRIUAKVQPMVI5s9qQKhlOxe
   y156c2inejYTjRn9yrlcPou9fp65CLhUvkizuog4uVQHRGnW5TLW+8r9I
   1+QilvwFBpfOJse0Nb8w5X/8L/E+oY2iK1jfsJ/PnaTQuBJEI//mr0OjX
   VYEiFUe/iolOOtDWJXt6/cOksmRH/+MgFwIHUH0i0Cy3OL9ywky179PiM
   w==;
X-CSE-ConnectionGUID: k+Zvlm6mTni1Zj8IKTiNNA==
X-CSE-MsgGUID: J0Eh98+fT7m/+kzOPkoVGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73023465"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73023465"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 17:46:33 -0800
X-CSE-ConnectionGUID: 9guqWbkSRw2oUxLi2nOdqg==
X-CSE-MsgGUID: azmyA512QD6t7XNcwgzTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="216416294"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2026 17:46:31 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz3Dw-000000002mr-1frU;
	Sun, 08 Mar 2026 01:46:28 +0000
Date: Sun, 8 Mar 2026 09:45:41 +0800
From: kernel test robot <lkp@intel.com>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: add missing const qualifier to char
 pointer array
Message-ID: <202603080944.rMPCAhoj-lkp@intel.com>
References: <20260307131833.1138-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307131833.1138-1-rayfraytech@gmail.com>

Hi Oskar,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Oskar-Ray-Frayssinet/staging-sm750fb-add-missing-const-qualifier-to-char-pointer-array/20260307-212030
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260307131833.1138-1-rayfraytech%40gmail.com
patch subject: [PATCH] staging: sm750fb: add missing const qualifier to char pointer array
config: i386-buildonly-randconfig-003-20260308 (https://download.01.org/0day-ci/archive/20260308/202603080944.rMPCAhoj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080944.rMPCAhoj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080944.rMPCAhoj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:782:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     782 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:784:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     784 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:893:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     893 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:897:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     897 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +782 drivers/staging/sm750fb/sm750.c

81dee67e215b23f Sudip Mukherjee      2015-03-03  716  
81dee67e215b23f Sudip Mukherjee      2015-03-03  717  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23f Sudip Mukherjee      2015-03-03  718  {
81dee67e215b23f Sudip Mukherjee      2015-03-03  719  	int i;
81dee67e215b23f Sudip Mukherjee      2015-03-03  720  	struct lynxfb_par *par;
e359b6a863e19f2 Mike Rapoport        2015-10-26  721  	struct sm750_dev *sm750_dev;
81dee67e215b23f Sudip Mukherjee      2015-03-03  722  	struct lynxfb_crtc *crtc;
81dee67e215b23f Sudip Mukherjee      2015-03-03  723  	struct lynxfb_output *output;
81dee67e215b23f Sudip Mukherjee      2015-03-03  724  	struct fb_var_screeninfo *var;
81dee67e215b23f Sudip Mukherjee      2015-03-03  725  	struct fb_fix_screeninfo *fix;
81dee67e215b23f Sudip Mukherjee      2015-03-03  726  
81dee67e215b23f Sudip Mukherjee      2015-03-03  727  	const struct fb_videomode *pdb[] = {
81dee67e215b23f Sudip Mukherjee      2015-03-03  728  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23f Sudip Mukherjee      2015-03-03  729  	};
81dee67e215b23f Sudip Mukherjee      2015-03-03  730  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
8c475735085a7db Tim Wassink          2025-12-21  731  	static const char *fix_id[2] = {
81dee67e215b23f Sudip Mukherjee      2015-03-03  732  		"sm750_fb1", "sm750_fb2",
81dee67e215b23f Sudip Mukherjee      2015-03-03  733  	};
81dee67e215b23f Sudip Mukherjee      2015-03-03  734  
81dee67e215b23f Sudip Mukherjee      2015-03-03  735  	int ret, line_length;
81dee67e215b23f Sudip Mukherjee      2015-03-03  736  
81dee67e215b23f Sudip Mukherjee      2015-03-03  737  	ret = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  738  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f2 Mike Rapoport        2015-10-26  739  	sm750_dev = par->dev;
81dee67e215b23f Sudip Mukherjee      2015-03-03  740  	crtc = &par->crtc;
81dee67e215b23f Sudip Mukherjee      2015-03-03  741  	output = &par->output;
81dee67e215b23f Sudip Mukherjee      2015-03-03  742  	var = &info->var;
81dee67e215b23f Sudip Mukherjee      2015-03-03  743  	fix = &info->fix;
81dee67e215b23f Sudip Mukherjee      2015-03-03  744  
81dee67e215b23f Sudip Mukherjee      2015-03-03  745  	/* set index */
81dee67e215b23f Sudip Mukherjee      2015-03-03  746  	par->index = index;
81dee67e215b23f Sudip Mukherjee      2015-03-03  747  	output->channel = &crtc->channel;
81dee67e215b23f Sudip Mukherjee      2015-03-03  748  	sm750fb_set_drv(par);
81dee67e215b23f Sudip Mukherjee      2015-03-03  749  
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  750  	/*
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  751  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  752  	 * must be set after crtc member initialized
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  753  	 */
fdc234d85210d91 Benjamin Philip      2021-07-28  754  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f2 Mike Rapoport        2015-10-26  755  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f2 Mike Rapoport        2015-10-26  756  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23f Sudip Mukherjee      2015-03-03  757  
cd33da26036ea54 Christopher Carbone  2022-08-23  758  	crtc->cursor.max_h = 64;
cd33da26036ea54 Christopher Carbone  2022-08-23  759  	crtc->cursor.max_w = 64;
39f9137268ee3df Benjamin Philip      2021-07-26  760  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f2 Mike Rapoport        2015-10-26  761  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23f Sudip Mukherjee      2015-03-03  762  
3de08a2d14ff8c7 Lorenzo Stoakes      2015-03-20  763  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09d Thomas Zimmermann    2023-11-27  764  	if (!g_hwcursor)
52d0744d751d8f1 Arnd Bergmann        2016-11-09  765  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23f Sudip Mukherjee      2015-03-03  766  
81dee67e215b23f Sudip Mukherjee      2015-03-03  767  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f2 Mike Rapoport        2015-10-26  768  	if (!sm750_dev->accel_off) {
81dee67e215b23f Sudip Mukherjee      2015-03-03  769  		/* use 2d acceleration */
f7c8a046577e09d Thomas Zimmermann    2023-11-27  770  		if (!g_hwcursor)
f7c8a046577e09d Thomas Zimmermann    2023-11-27  771  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  772  		else
f7c8a046577e09d Thomas Zimmermann    2023-11-27  773  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  774  	} else {
f7c8a046577e09d Thomas Zimmermann    2023-11-27  775  		if (!g_hwcursor)
81dee67e215b23f Sudip Mukherjee      2015-03-03  776  			info->fbops = &lynxfb_ops;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  777  		else
f7c8a046577e09d Thomas Zimmermann    2023-11-27  778  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09d Thomas Zimmermann    2023-11-27  779  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  780  
81dee67e215b23f Sudip Mukherjee      2015-03-03  781  	if (!g_fbmode[index]) {
81dee67e215b23f Sudip Mukherjee      2015-03-03 @782  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23f Sudip Mukherjee      2015-03-03  783  		if (index)
81dee67e215b23f Sudip Mukherjee      2015-03-03  784  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23f Sudip Mukherjee      2015-03-03  785  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  786  
81dee67e215b23f Sudip Mukherjee      2015-03-03  787  	for (i = 0; i < 3; i++) {
81dee67e215b23f Sudip Mukherjee      2015-03-03  788  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23f Sudip Mukherjee      2015-03-03  789  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23f Sudip Mukherjee      2015-03-03  790  
db7fb3588ab4920 Artem Lytkin         2026-02-23  791  		if (ret == 1 || ret == 2)
81dee67e215b23f Sudip Mukherjee      2015-03-03  792  			break;
81dee67e215b23f Sudip Mukherjee      2015-03-03  793  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  794  
81dee67e215b23f Sudip Mukherjee      2015-03-03  795  	/* set par */
81dee67e215b23f Sudip Mukherjee      2015-03-03  796  	par->info = info;
81dee67e215b23f Sudip Mukherjee      2015-03-03  797  
81dee67e215b23f Sudip Mukherjee      2015-03-03  798  	/* set info */
e3a3f9f5123683b Mike Rapoport        2015-10-26  799  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683b Mike Rapoport        2015-10-26  800  			    crtc->line_pad);
81dee67e215b23f Sudip Mukherjee      2015-03-03  801  
81dee67e215b23f Sudip Mukherjee      2015-03-03  802  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab6 Benjamin Philip      2021-07-28  803  	info->screen_base = crtc->v_screen;
81dee67e215b23f Sudip Mukherjee      2015-03-03  804  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23f Sudip Mukherjee      2015-03-03  805  
81dee67e215b23f Sudip Mukherjee      2015-03-03  806  	/* set info->fix */
81dee67e215b23f Sudip Mukherjee      2015-03-03  807  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23f Sudip Mukherjee      2015-03-03  808  	fix->type_aux = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  809  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  810  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  811  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23f Sudip Mukherjee      2015-03-03  812  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23f Sudip Mukherjee      2015-03-03  813  
8c475735085a7db Tim Wassink          2025-12-21  814  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23f Sudip Mukherjee      2015-03-03  815  
fdc234d85210d91 Benjamin Philip      2021-07-28  816  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  817  	/*
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  818  	 * according to mmap experiment from user space application,
81dee67e215b23f Sudip Mukherjee      2015-03-03  819  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23f Sudip Mukherjee      2015-03-03  820  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23f Sudip Mukherjee      2015-03-03  821  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23f Sudip Mukherjee      2015-03-03  822  	 * data into the bound over virtual size
d11ac7cbcc266c6 Sudip Mukherjee      2015-08-07  823  	 */
81dee67e215b23f Sudip Mukherjee      2015-03-03  824  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23f Sudip Mukherjee      2015-03-03  825  	info->screen_size = fix->smem_len;
81dee67e215b23f Sudip Mukherjee      2015-03-03  826  	fix->line_length = line_length;
e359b6a863e19f2 Mike Rapoport        2015-10-26  827  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f2 Mike Rapoport        2015-10-26  828  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f4 Matej Dujava         2020-04-30  829  
b610e1193a917f4 Matej Dujava         2020-04-30  830  	lynxfb_set_visual_mode(info);
81dee67e215b23f Sudip Mukherjee      2015-03-03  831  
81dee67e215b23f Sudip Mukherjee      2015-03-03  832  	/* set var */
81dee67e215b23f Sudip Mukherjee      2015-03-03  833  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23f Sudip Mukherjee      2015-03-03  834  	var->accel_flags = 0;
81dee67e215b23f Sudip Mukherjee      2015-03-03  835  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23f Sudip Mukherjee      2015-03-03  836  
61c507cf652da1b Michel von Czettritz 2015-03-26  837  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1b Michel von Czettritz 2015-03-26  838  	if (ret < 0) {
fbab250eb51d6d6 Artem Lytkin         2026-02-07  839  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23f Sudip Mukherjee      2015-03-03  840  		goto exit;
81dee67e215b23f Sudip Mukherjee      2015-03-03  841  	}
81dee67e215b23f Sudip Mukherjee      2015-03-03  842  
81dee67e215b23f Sudip Mukherjee      2015-03-03  843  exit:
81dee67e215b23f Sudip Mukherjee      2015-03-03  844  	lynxfb_ops_check_var(var, info);
81dee67e215b23f Sudip Mukherjee      2015-03-03  845  	return ret;
81dee67e215b23f Sudip Mukherjee      2015-03-03  846  }
81dee67e215b23f Sudip Mukherjee      2015-03-03  847  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

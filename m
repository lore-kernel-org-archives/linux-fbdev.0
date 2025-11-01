Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22B1F872D;
	Sat,  1 Nov 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983236; cv=none; b=lm0b+WRUDAzmy4ppnn6NZ5XxCejpUgQmZ9c6B9FhGy2QATuST+fZUO8TwS33UbDAoUOlaqXi9btTOUgZyZAtMB98z/A1sOXGVnieNoSQHL9ghZeUjlNJolXj/UiIBkPmg4pRPnclcAbVXVgTetMr8a5+Z58FYUT+UqYupVhqERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983236; c=relaxed/simple;
	bh=A3W2E0SUrPVSLWouN5YZmhJj7aFbRuzAbbQHp8R29yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVvHUahOD+M4IXzEf/npGqx6y2d/F/t5GvrH8edPdKv/+iu3yws5dMiNNSjL1nNkjBVWkp30XgtPk3JxTjwJTAKbCBt9QHyt0Yab2K7BjrMzE7lfu29grVfNs1lV7O6glBzTNDtT/tUVxP9k7jRyNXBpOXbFQUJ4KRjmUZvI9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTxuJW9S; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTxuJW9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761983234; x=1793519234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3W2E0SUrPVSLWouN5YZmhJj7aFbRuzAbbQHp8R29yI=;
  b=eTxuJW9SXVuJT1BWjqjm3A2YTaeHpA5Bes+2zI+BDOS0OdeX7R/e72q/
   GP8VFTIhP+VY2gpRQdCwwLWmWlbyVdejbbUYD8JpGFDuXcqK8Q19EXfUh
   lR5Hd3iLzBvgjb2NnuZJm7scAvWkwoB/WyYhKj0kn4elTy/iouAesBY7y
   5wGXRIQjADR7k/QoLoCa39VT8onES+ilb1P0OQxNmhPgKl6/7t2zqr3xl
   8tpTP7SBVJLwvc0LrJD4XSMjtTAqfTXq53wm9+a5TfarcAlPmylVyL7oI
   QhPSgK01kzf8k0z7P5rtqrh6VdLVb3GIiW8OeCY5lb9/J4kE5QTT+AiKr
   w==;
X-CSE-ConnectionGUID: LsfIqTCfSpCvH9EoeAEZ7Q==
X-CSE-MsgGUID: m1et9fWBQcODeubpzaPQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64026697"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="64026697"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 00:47:12 -0700
X-CSE-ConnectionGUID: Ihl5j/DRSGO4jXTMSxKXOQ==
X-CSE-MsgGUID: w9yiYmx6RXCSLUQ3ihv5RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="190503345"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2025 00:47:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF6KI-000O0i-2b;
	Sat, 01 Nov 2025 07:47:06 +0000
Date: Sat, 1 Nov 2025 15:46:33 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	sudip.mukherjee@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode0 an array of const
 pointers
Message-ID: <202511011532.LFS4SZtE-lkp@intel.com>
References: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Del-Gobbo/staging-sm750fb-make-g_fbmode0-an-array-of-const-pointers/20251027-073648
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20251026233432.1707-1-cristiandelgobbo87%40gmail.com
patch subject: [PATCH] staging: sm750fb: make g_fbmode0 an array of const pointers
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20251101/202511011532.LFS4SZtE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011532.LFS4SZtE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011532.LFS4SZtE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:790:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     790 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:792:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     792 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:953:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     953 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:957:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     957 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +790 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee         2015-03-03  717  
81dee67e215b23 Sudip Mukherjee         2015-03-03  718  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee         2015-03-03  719  {
81dee67e215b23 Sudip Mukherjee         2015-03-03  720  	int i;
81dee67e215b23 Sudip Mukherjee         2015-03-03  721  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport           2015-10-26  722  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee         2015-03-03  723  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee         2015-03-03  724  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee         2015-03-03  725  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee         2015-03-03  726  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee         2015-03-03  727  
81dee67e215b23 Sudip Mukherjee         2015-03-03  728  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  729  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee         2015-03-03  730  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  731  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d5d66cfea2ca28 Kelsey Skunberg         2019-04-27  732  	static const char * const mdb_desc[] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  733  		"driver prepared modes",
81dee67e215b23 Sudip Mukherjee         2015-03-03  734  		"kernel prepared default modedb",
81dee67e215b23 Sudip Mukherjee         2015-03-03  735  		"kernel HELPERS prepared vesa_modes",
81dee67e215b23 Sudip Mukherjee         2015-03-03  736  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  737  
70407df77665c0 Michel von Czettritz    2015-03-26  738  	static const char *fixId[2] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  739  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee         2015-03-03  740  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  741  
81dee67e215b23 Sudip Mukherjee         2015-03-03  742  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee         2015-03-03  743  
81dee67e215b23 Sudip Mukherjee         2015-03-03  744  	ret = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  745  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport           2015-10-26  746  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee         2015-03-03  747  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee         2015-03-03  748  	output = &par->output;
81dee67e215b23 Sudip Mukherjee         2015-03-03  749  	var = &info->var;
81dee67e215b23 Sudip Mukherjee         2015-03-03  750  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee         2015-03-03  751  
81dee67e215b23 Sudip Mukherjee         2015-03-03  752  	/* set index */
81dee67e215b23 Sudip Mukherjee         2015-03-03  753  	par->index = index;
81dee67e215b23 Sudip Mukherjee         2015-03-03  754  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee         2015-03-03  755  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee         2015-03-03  756  
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  757  	/*
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  758  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  759  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  760  	 */
fdc234d85210d9 Benjamin Philip         2021-07-28  761  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport           2015-10-26  762  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport           2015-10-26  763  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee         2015-03-03  764  
81dee67e215b23 Sudip Mukherjee         2015-03-03  765  	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
cd33da26036ea5 Christopher Carbone     2022-08-23  766  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone     2022-08-23  767  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip         2021-07-26  768  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f Mike Rapoport           2015-10-26  769  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee         2015-03-03  770  
3de08a2d14ff8c Lorenzo Stoakes         2015-03-20  771  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann       2023-11-27  772  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann           2016-11-09  773  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee         2015-03-03  774  
81dee67e215b23 Sudip Mukherjee         2015-03-03  775  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport           2015-10-26  776  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  777  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann       2023-11-27  778  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann       2023-11-27  779  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  780  		else
f7c8a046577e09 Thomas Zimmermann       2023-11-27  781  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  782  	} else {
f7c8a046577e09 Thomas Zimmermann       2023-11-27  783  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee         2015-03-03  784  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  785  		else
f7c8a046577e09 Thomas Zimmermann       2023-11-27  786  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  787  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  788  
81dee67e215b23 Sudip Mukherjee         2015-03-03  789  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee         2015-03-03 @790  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee         2015-03-03  791  		if (index)
81dee67e215b23 Sudip Mukherjee         2015-03-03  792  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee         2015-03-03  793  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  794  
81dee67e215b23 Sudip Mukherjee         2015-03-03  795  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  796  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  797  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee         2015-03-03  798  
81dee67e215b23 Sudip Mukherjee         2015-03-03  799  		if (ret == 1) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  800  			pr_info("success! use specified mode:%s in %s\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  801  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  802  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  803  			break;
81dee67e215b23 Sudip Mukherjee         2015-03-03  804  		} else if (ret == 2) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  805  			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  806  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  807  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  808  			break;
81dee67e215b23 Sudip Mukherjee         2015-03-03  809  		} else if (ret == 3) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  810  			pr_warn("wanna use default mode\n");
4bd9503d0becdb Michel von Czettritz    2015-03-26  811  			/*break;*/
81dee67e215b23 Sudip Mukherjee         2015-03-03  812  		} else if (ret == 4) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  813  			pr_warn("fall back to any valid mode\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  814  		} else {
3318bb5e945f70 Michel von Czettritz    2015-03-26  815  			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
3318bb5e945f70 Michel von Czettritz    2015-03-26  816  				ret,
3318bb5e945f70 Michel von Czettritz    2015-03-26  817  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  818  		}
81dee67e215b23 Sudip Mukherjee         2015-03-03  819  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  820  
81dee67e215b23 Sudip Mukherjee         2015-03-03  821  	/* some member of info->var had been set by fb_find_mode */
81dee67e215b23 Sudip Mukherjee         2015-03-03  822  
271dbae3c6a1da Prasant Jalan           2017-04-01  823  	pr_info("Member of info->var is :\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  824  		"xres=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  825  		"yres=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  826  		"xres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  827  		"yres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  828  		"xoffset=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  829  		"yoffset=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  830  		"bits_per_pixel=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  831  		" ...\n",
3318bb5e945f70 Michel von Czettritz    2015-03-26  832  		var->xres,
3318bb5e945f70 Michel von Czettritz    2015-03-26  833  		var->yres,
3318bb5e945f70 Michel von Czettritz    2015-03-26  834  		var->xres_virtual,
3318bb5e945f70 Michel von Czettritz    2015-03-26  835  		var->yres_virtual,
3318bb5e945f70 Michel von Czettritz    2015-03-26  836  		var->xoffset,
3318bb5e945f70 Michel von Czettritz    2015-03-26  837  		var->yoffset,
3318bb5e945f70 Michel von Czettritz    2015-03-26  838  		var->bits_per_pixel);
81dee67e215b23 Sudip Mukherjee         2015-03-03  839  
81dee67e215b23 Sudip Mukherjee         2015-03-03  840  	/* set par */
81dee67e215b23 Sudip Mukherjee         2015-03-03  841  	par->info = info;
81dee67e215b23 Sudip Mukherjee         2015-03-03  842  
81dee67e215b23 Sudip Mukherjee         2015-03-03  843  	/* set info */
e3a3f9f5123683 Mike Rapoport           2015-10-26  844  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport           2015-10-26  845  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee         2015-03-03  846  
81dee67e215b23 Sudip Mukherjee         2015-03-03  847  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip         2021-07-28  848  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee         2015-03-03  849  	pr_debug("screen_base vaddr = %p\n", info->screen_base);
81dee67e215b23 Sudip Mukherjee         2015-03-03  850  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee         2015-03-03  851  
81dee67e215b23 Sudip Mukherjee         2015-03-03  852  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee         2015-03-03  853  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee         2015-03-03  854  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  855  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  856  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  857  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  858  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee         2015-03-03  859  
9c15db83a86bf8 Kumar Kartikeya Dwivedi 2021-01-31  860  	strscpy(fix->id, fixId[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee         2015-03-03  861  
fdc234d85210d9 Benjamin Philip         2021-07-28  862  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
81dee67e215b23 Sudip Mukherjee         2015-03-03  863  	pr_info("fix->smem_start = %lx\n", fix->smem_start);
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  864  	/*
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  865  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee         2015-03-03  866  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee         2015-03-03  867  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee         2015-03-03  868  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee         2015-03-03  869  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  870  	 */
81dee67e215b23 Sudip Mukherjee         2015-03-03  871  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee         2015-03-03  872  	pr_info("fix->smem_len = %x\n", fix->smem_len);
81dee67e215b23 Sudip Mukherjee         2015-03-03  873  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee         2015-03-03  874  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport           2015-10-26  875  	fix->mmio_start = sm750_dev->vidreg_start;
81dee67e215b23 Sudip Mukherjee         2015-03-03  876  	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
e359b6a863e19f Mike Rapoport           2015-10-26  877  	fix->mmio_len = sm750_dev->vidreg_size;
81dee67e215b23 Sudip Mukherjee         2015-03-03  878  	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
b610e1193a917f Matej Dujava            2020-04-30  879  
b610e1193a917f Matej Dujava            2020-04-30  880  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee         2015-03-03  881  
81dee67e215b23 Sudip Mukherjee         2015-03-03  882  	/* set var */
81dee67e215b23 Sudip Mukherjee         2015-03-03  883  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee         2015-03-03  884  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  885  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee         2015-03-03  886  
81dee67e215b23 Sudip Mukherjee         2015-03-03  887  	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  888  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee         2015-03-03  889  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee         2015-03-03  890  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee         2015-03-03  891  
61c507cf652da1 Michel von Czettritz    2015-03-26  892  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz    2015-03-26  893  	if (ret < 0) {
008272072d61a8 Masanari Iida           2015-05-28  894  		pr_err("Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  895  		goto exit;
81dee67e215b23 Sudip Mukherjee         2015-03-03  896  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  897  
81dee67e215b23 Sudip Mukherjee         2015-03-03  898  	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  899  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee         2015-03-03  900  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee         2015-03-03  901  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee         2015-03-03  902  
81dee67e215b23 Sudip Mukherjee         2015-03-03  903  exit:
81dee67e215b23 Sudip Mukherjee         2015-03-03  904  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee         2015-03-03  905  	return ret;
81dee67e215b23 Sudip Mukherjee         2015-03-03  906  }
81dee67e215b23 Sudip Mukherjee         2015-03-03  907  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

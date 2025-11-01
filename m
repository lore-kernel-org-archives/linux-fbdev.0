Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1522DA1C;
	Sat,  1 Nov 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761985037; cv=none; b=MonYTS5qyW+6FMHL/LmykUTvDIz8p74gCAzfM61DmVNKuPcJ71V03IKGMa3kgZOtYxN3Y0FCeGf53o5H97uH+ujsaK6CQe1pJSdWBqXU1xjg18X9PMXAtdqA37fnyETWq2m5m3m9YD+025KZXA3RQ0Ml6ukL3s/9C1mCRB1ZUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761985037; c=relaxed/simple;
	bh=5oao/6iFuGGyP8/mBEXaG8vrNL5uomRn6IOQZKlBnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkRtiwz6wnxCzYYS4XuagVGO9D2f2gMmZXDFNCDFdbRzas1x8U4gGUpCij3iIWqEePgKf5zQGhOkCZQ9VGS9QtdBl1rWUQrtW6lSIUUyhcbZZrjUvWnvJpyC2DYkiQv9QvhFpfUadUPGGJo0iADUpA4aHaIemFPrw1knNDpZAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVJCA9pM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVJCA9pM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761985035; x=1793521035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oao/6iFuGGyP8/mBEXaG8vrNL5uomRn6IOQZKlBnwY=;
  b=aVJCA9pM6puuK/nN0kZ8+3dgQrH+vvL30nV7eSi/OnMUMyOw8kizaLLg
   ydo1n4r+Ib9NIPC8OBJQmbtMIXj9J2fJXVinOnwIerMmeuPhv4GIcMPVz
   0xeapKzbFaVoFWkiQru22/tqGsqBJj5Ir2+OwXP7VFK5S30J5U/i2QR1Z
   S7zrHgqx7QZcU3qeg7//5d6WI2IBJJkiazoLkAN2CK5pNreUDPr+/B5qK
   ktC5nFFDNEU72FcXgfzkmx2ebYBwlC48JtuwfavDVCf2/wJVd15tK0rui
   Ls2acg29Q6JyBviBUEV2Tt1wmvPP1e5LVyXMjwdiTF24dOR4kyazBL2Yi
   A==;
X-CSE-ConnectionGUID: 0XYQV68fR3WvwHpB9TBuoA==
X-CSE-MsgGUID: l215RGs3RcmlNtCeA+o07A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64043266"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64043266"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 01:17:14 -0700
X-CSE-ConnectionGUID: 36EunP9ORYCbKygJH/Li1Q==
X-CSE-MsgGUID: D5NjXt8pQZmoOXwxTzZaQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="187161485"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Nov 2025 01:17:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF6nN-000O28-2N;
	Sat, 01 Nov 2025 08:17:09 +0000
Date: Sat, 1 Nov 2025 16:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	sudip.mukherjee@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode0 an array of const
 pointers
Message-ID: <202511011552.WuM3PEPs-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20251101/202511011552.WuM3PEPs-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011552.WuM3PEPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011552.WuM3PEPs-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> drivers/staging/sm750fb/sm750.c:790:33: error: assignment of read-only location 'g_fbmode[index]'
     790 |                 g_fbmode[index] = g_def_fbmode;
         |                                 ^
   drivers/staging/sm750fb/sm750.c:792:41: error: assignment of read-only location 'g_fbmode[index]'
     792 |                         g_fbmode[index] = g_fbmode[0];
         |                                         ^
   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:953:45: error: assignment of read-only location 'g_fbmode[0]'
     953 |                                 g_fbmode[0] = opt;
         |                                             ^
   drivers/staging/sm750fb/sm750.c:957:45: error: assignment of read-only location 'g_fbmode[1]'
     957 |                                 g_fbmode[1] = opt;
         |                                             ^


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
81dee67e215b23 Sudip Mukherjee         2015-03-03  908  /*	chip specific g_option configuration routine */
700591a9adc8b1 Mike Rapoport           2015-10-26  909  static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
81dee67e215b23 Sudip Mukherjee         2015-03-03  910  {
81dee67e215b23 Sudip Mukherjee         2015-03-03  911  	char *opt;
81dee67e215b23 Sudip Mukherjee         2015-03-03  912  	int swap;
81dee67e215b23 Sudip Mukherjee         2015-03-03  913  
81dee67e215b23 Sudip Mukherjee         2015-03-03  914  	swap = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  915  
1757d106a9ce8c Mike Rapoport           2015-10-26  916  	sm750_dev->initParm.chip_clk = 0;
1757d106a9ce8c Mike Rapoport           2015-10-26  917  	sm750_dev->initParm.mem_clk = 0;
1757d106a9ce8c Mike Rapoport           2015-10-26  918  	sm750_dev->initParm.master_clk = 0;
1757d106a9ce8c Mike Rapoport           2015-10-26  919  	sm750_dev->initParm.powerMode = 0;
1757d106a9ce8c Mike Rapoport           2015-10-26  920  	sm750_dev->initParm.setAllEngOff = 0;
1757d106a9ce8c Mike Rapoport           2015-10-26  921  	sm750_dev->initParm.resetMemory = 1;
81dee67e215b23 Sudip Mukherjee         2015-03-03  922  
81dee67e215b23 Sudip Mukherjee         2015-03-03  923  	/* defaultly turn g_hwcursor on for both view */
81dee67e215b23 Sudip Mukherjee         2015-03-03  924  	g_hwcursor = 3;
81dee67e215b23 Sudip Mukherjee         2015-03-03  925  
81dee67e215b23 Sudip Mukherjee         2015-03-03  926  	if (!src || !*src) {
c56de0967a658c Elise Lennion           2016-10-31  927  		dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  928  		goto NO_PARAM;
81dee67e215b23 Sudip Mukherjee         2015-03-03  929  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  930  
0fa96e39279988 Sudip Mukherjee         2015-03-10  931  	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
c56de0967a658c Elise Lennion           2016-10-31  932  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
c56de0967a658c Elise Lennion           2016-10-31  933  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
81dee67e215b23 Sudip Mukherjee         2015-03-03  934  
144634a6b42146 Katie Dunne             2017-02-19  935  		if (!strncmp(opt, "swap", strlen("swap"))) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  936  			swap = 1;
144634a6b42146 Katie Dunne             2017-02-19  937  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
1757d106a9ce8c Mike Rapoport           2015-10-26  938  			sm750_dev->nocrt = 1;
144634a6b42146 Katie Dunne             2017-02-19  939  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
1757d106a9ce8c Mike Rapoport           2015-10-26  940  			sm750_dev->pnltype = sm750_doubleTFT;
144634a6b42146 Katie Dunne             2017-02-19  941  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
1757d106a9ce8c Mike Rapoport           2015-10-26  942  			sm750_dev->pnltype = sm750_dualTFT;
144634a6b42146 Katie Dunne             2017-02-19  943  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
1757d106a9ce8c Mike Rapoport           2015-10-26  944  			sm750_dev->pnltype = sm750_24TFT;
144634a6b42146 Katie Dunne             2017-02-19  945  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  946  			g_hwcursor &= ~0x1;
144634a6b42146 Katie Dunne             2017-02-19  947  		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  948  			g_hwcursor &= ~0x2;
144634a6b42146 Katie Dunne             2017-02-19  949  		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  950  			g_hwcursor = 0;
144634a6b42146 Katie Dunne             2017-02-19  951  		} else {
81dee67e215b23 Sudip Mukherjee         2015-03-03  952  			if (!g_fbmode[0]) {
81dee67e215b23 Sudip Mukherjee         2015-03-03 @953  				g_fbmode[0] = opt;
cee9ba1c30d051 Abdul Rauf              2017-01-08  954  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf              2017-01-08  955  					 "find fbmode0 : %s\n", g_fbmode[0]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  956  			} else if (!g_fbmode[1]) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  957  				g_fbmode[1] = opt;
cee9ba1c30d051 Abdul Rauf              2017-01-08  958  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf              2017-01-08  959  					 "find fbmode1 : %s\n", g_fbmode[1]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  960  			} else {
c56de0967a658c Elise Lennion           2016-10-31  961  				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  962  			}
81dee67e215b23 Sudip Mukherjee         2015-03-03  963  		}
81dee67e215b23 Sudip Mukherjee         2015-03-03  964  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  965  
81dee67e215b23 Sudip Mukherjee         2015-03-03  966  NO_PARAM:
e359b6a863e19f Mike Rapoport           2015-10-26  967  	if (sm750_dev->revid != SM750LE_REVISION_ID) {
a3f92cc94c6126 Mike Rapoport           2016-01-17  968  		if (sm750_dev->fb_count > 1) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  969  			if (swap)
1757d106a9ce8c Mike Rapoport           2015-10-26  970  				sm750_dev->dataflow = sm750_dual_swap;
81dee67e215b23 Sudip Mukherjee         2015-03-03  971  			else
1757d106a9ce8c Mike Rapoport           2015-10-26  972  				sm750_dev->dataflow = sm750_dual_normal;
81dee67e215b23 Sudip Mukherjee         2015-03-03  973  		} else {
81dee67e215b23 Sudip Mukherjee         2015-03-03  974  			if (swap)
1757d106a9ce8c Mike Rapoport           2015-10-26  975  				sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee         2015-03-03  976  			else
1757d106a9ce8c Mike Rapoport           2015-10-26  977  				sm750_dev->dataflow = sm750_simul_pri;
81dee67e215b23 Sudip Mukherjee         2015-03-03  978  		}
81dee67e215b23 Sudip Mukherjee         2015-03-03  979  	} else {
81dee67e215b23 Sudip Mukherjee         2015-03-03  980  		/* SM750LE only have one crt channel */
1757d106a9ce8c Mike Rapoport           2015-10-26  981  		sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee         2015-03-03  982  		/* sm750le do not have complex attributes */
1757d106a9ce8c Mike Rapoport           2015-10-26  983  		sm750_dev->nocrt = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  984  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  985  }
81dee67e215b23 Sudip Mukherjee         2015-03-03  986  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

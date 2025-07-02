Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9711B0439;
	Wed,  2 Jul 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424241; cv=none; b=CM10SRAMGhFOR8mpm2iSgeuhEK/xpnorLuaSU6UX0ytA+13a4RD2EoYlyDHwpmt6bIsMK1sDSYWbA44NC6C2EDUvhAIg0mCpdAonbQojkjtxd8TTm5jM5Rr8ak+AwhcNtUJFwHlLooTb+fapAesi9NfTa86oGc8pOLw8JKnr7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424241; c=relaxed/simple;
	bh=WY/UF0Kz4fdyrIcGhIYv72DnhRYvkYh1HFe585W8SDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCDcSr/QQkJyUR6uN/X0iegtM7D2xh9mKRm/BRHCok+H88GBgPC3+TM1Vz3LjDJ8O0uOmvdRH9rhwjN1AwkJDPwy6qB3kg8XnSZbCNDr9J5Lx6t2I8pwTT6ERrCw0mmwyWD40r92ag+mTJR0sleHOU6LWjtXyb9nUmqG3Lv47Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egJq4t98; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egJq4t98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751424239; x=1782960239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WY/UF0Kz4fdyrIcGhIYv72DnhRYvkYh1HFe585W8SDU=;
  b=egJq4t98sShXb99WpjokcTqBeKXbTjulPjSgY3R9gHiSUDLo+zy+tno+
   bbJWGIZmjaW93SMNVF6QwDvlRXmc8HM02qTPSBEnUzRaPai/sT5E4/Y/4
   7ls+zw/0pfpcQSYPc60k96ub/rVKPxOpuiX+vgbTziX9f0bguA02hMnFh
   muhpVI2UExh8lho0dYuxOQZ7G3r9RMW2xVRtTf15IYjEoY8c5UPOAZlgO
   GTgbnaWfzgwBwCSBXkAizLMtQtsWD1svFW0FhVgKDuCtyKyBw4pAcQWdS
   57X1nQslnR4Kp7q7SPPxmdVnHd+Fk7hEp0Rktd+kPordCJmWFEbTkkrMe
   g==;
X-CSE-ConnectionGUID: 3YRDry3eTd+xtkSMGd/bCg==
X-CSE-MsgGUID: 0iLuFUV+TW6ULMdd2cV1Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71131398"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="71131398"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:43:59 -0700
X-CSE-ConnectionGUID: pMCYd+4KS2WjbIz8LBlYYQ==
X-CSE-MsgGUID: s5PIGkm0RfmDcBf6KILl1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153404495"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2025 19:43:56 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWnRx-00003f-25;
	Wed, 02 Jul 2025 02:43:53 +0000
Date: Wed, 2 Jul 2025 10:43:45 +0800
From: kernel test robot <lkp@intel.com>
To: Pratibimba Khadka <pratibimbakhadka@gmail.com>,
	sudipm.mukherjee@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pratibimba Khadka <pratibimbakhadka@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Mark g_fbmode as a pointer to const
 pointer
Message-ID: <202507021020.PinpEoBX-lkp@intel.com>
References: <20250625045526.82758-1-pratibimbakhadka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625045526.82758-1-pratibimbakhadka@gmail.com>

Hi Pratibimba,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Pratibimba-Khadka/staging-sm750fb-Mark-g_fbmode-as-a-pointer-to-const-pointer/20250625-125713
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250625045526.82758-1-pratibimbakhadka%40gmail.com
patch subject: [PATCH] staging: sm750fb: Mark g_fbmode as a pointer to const pointer
config: i386-buildonly-randconfig-003-20250702 (https://download.01.org/0day-ci/archive/20250702/202507021020.PinpEoBX-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507021020.PinpEoBX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507021020.PinpEoBX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:786:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     786 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:26: note: variable 'g_fbmode' declared const here
      36 | static const char *const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:788:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     788 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:26: note: variable 'g_fbmode' declared const here
      36 | static const char *const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:949:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     949 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:26: note: variable 'g_fbmode' declared const here
      36 | static const char *const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:953:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     953 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:26: note: variable 'g_fbmode' declared const here
      36 | static const char *const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +786 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee         2015-03-03  713  
81dee67e215b23 Sudip Mukherjee         2015-03-03  714  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee         2015-03-03  715  {
81dee67e215b23 Sudip Mukherjee         2015-03-03  716  	int i;
81dee67e215b23 Sudip Mukherjee         2015-03-03  717  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport           2015-10-26  718  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee         2015-03-03  719  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee         2015-03-03  720  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee         2015-03-03  721  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee         2015-03-03  722  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee         2015-03-03  723  
81dee67e215b23 Sudip Mukherjee         2015-03-03  724  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  725  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee         2015-03-03  726  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  727  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d5d66cfea2ca28 Kelsey Skunberg         2019-04-27  728  	static const char * const mdb_desc[] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  729  		"driver prepared modes",
81dee67e215b23 Sudip Mukherjee         2015-03-03  730  		"kernel prepared default modedb",
81dee67e215b23 Sudip Mukherjee         2015-03-03  731  		"kernel HELPERS prepared vesa_modes",
81dee67e215b23 Sudip Mukherjee         2015-03-03  732  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  733  
70407df77665c0 Michel von Czettritz    2015-03-26  734  	static const char *fixId[2] = {
81dee67e215b23 Sudip Mukherjee         2015-03-03  735  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee         2015-03-03  736  	};
81dee67e215b23 Sudip Mukherjee         2015-03-03  737  
81dee67e215b23 Sudip Mukherjee         2015-03-03  738  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee         2015-03-03  739  
81dee67e215b23 Sudip Mukherjee         2015-03-03  740  	ret = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  741  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport           2015-10-26  742  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee         2015-03-03  743  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee         2015-03-03  744  	output = &par->output;
81dee67e215b23 Sudip Mukherjee         2015-03-03  745  	var = &info->var;
81dee67e215b23 Sudip Mukherjee         2015-03-03  746  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee         2015-03-03  747  
81dee67e215b23 Sudip Mukherjee         2015-03-03  748  	/* set index */
81dee67e215b23 Sudip Mukherjee         2015-03-03  749  	par->index = index;
81dee67e215b23 Sudip Mukherjee         2015-03-03  750  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee         2015-03-03  751  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee         2015-03-03  752  
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  753  	/*
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  754  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  755  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  756  	 */
fdc234d85210d9 Benjamin Philip         2021-07-28  757  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport           2015-10-26  758  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport           2015-10-26  759  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee         2015-03-03  760  
81dee67e215b23 Sudip Mukherjee         2015-03-03  761  	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
cd33da26036ea5 Christopher Carbone     2022-08-23  762  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone     2022-08-23  763  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip         2021-07-26  764  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f Mike Rapoport           2015-10-26  765  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee         2015-03-03  766  
3de08a2d14ff8c Lorenzo Stoakes         2015-03-20  767  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann       2023-11-27  768  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann           2016-11-09  769  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee         2015-03-03  770  
81dee67e215b23 Sudip Mukherjee         2015-03-03  771  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport           2015-10-26  772  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  773  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann       2023-11-27  774  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann       2023-11-27  775  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  776  		else
f7c8a046577e09 Thomas Zimmermann       2023-11-27  777  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  778  	} else {
f7c8a046577e09 Thomas Zimmermann       2023-11-27  779  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee         2015-03-03  780  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  781  		else
f7c8a046577e09 Thomas Zimmermann       2023-11-27  782  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann       2023-11-27  783  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  784  
81dee67e215b23 Sudip Mukherjee         2015-03-03  785  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee         2015-03-03 @786  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee         2015-03-03  787  		if (index)
81dee67e215b23 Sudip Mukherjee         2015-03-03  788  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee         2015-03-03  789  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  790  
81dee67e215b23 Sudip Mukherjee         2015-03-03  791  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  792  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  793  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee         2015-03-03  794  
81dee67e215b23 Sudip Mukherjee         2015-03-03  795  		if (ret == 1) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  796  			pr_info("success! use specified mode:%s in %s\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  797  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  798  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  799  			break;
81dee67e215b23 Sudip Mukherjee         2015-03-03  800  		} else if (ret == 2) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  801  			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  802  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee         2015-03-03  803  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  804  			break;
81dee67e215b23 Sudip Mukherjee         2015-03-03  805  		} else if (ret == 3) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  806  			pr_warn("wanna use default mode\n");
4bd9503d0becdb Michel von Czettritz    2015-03-26  807  			/*break;*/
81dee67e215b23 Sudip Mukherjee         2015-03-03  808  		} else if (ret == 4) {
81dee67e215b23 Sudip Mukherjee         2015-03-03  809  			pr_warn("fall back to any valid mode\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  810  		} else {
3318bb5e945f70 Michel von Czettritz    2015-03-26  811  			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
3318bb5e945f70 Michel von Czettritz    2015-03-26  812  				ret,
3318bb5e945f70 Michel von Czettritz    2015-03-26  813  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee         2015-03-03  814  		}
81dee67e215b23 Sudip Mukherjee         2015-03-03  815  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  816  
81dee67e215b23 Sudip Mukherjee         2015-03-03  817  	/* some member of info->var had been set by fb_find_mode */
81dee67e215b23 Sudip Mukherjee         2015-03-03  818  
271dbae3c6a1da Prasant Jalan           2017-04-01  819  	pr_info("Member of info->var is :\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  820  		"xres=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  821  		"yres=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  822  		"xres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  823  		"yres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  824  		"xoffset=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  825  		"yoffset=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  826  		"bits_per_pixel=%d\n"
271dbae3c6a1da Prasant Jalan           2017-04-01  827  		" ...\n",
3318bb5e945f70 Michel von Czettritz    2015-03-26  828  		var->xres,
3318bb5e945f70 Michel von Czettritz    2015-03-26  829  		var->yres,
3318bb5e945f70 Michel von Czettritz    2015-03-26  830  		var->xres_virtual,
3318bb5e945f70 Michel von Czettritz    2015-03-26  831  		var->yres_virtual,
3318bb5e945f70 Michel von Czettritz    2015-03-26  832  		var->xoffset,
3318bb5e945f70 Michel von Czettritz    2015-03-26  833  		var->yoffset,
3318bb5e945f70 Michel von Czettritz    2015-03-26  834  		var->bits_per_pixel);
81dee67e215b23 Sudip Mukherjee         2015-03-03  835  
81dee67e215b23 Sudip Mukherjee         2015-03-03  836  	/* set par */
81dee67e215b23 Sudip Mukherjee         2015-03-03  837  	par->info = info;
81dee67e215b23 Sudip Mukherjee         2015-03-03  838  
81dee67e215b23 Sudip Mukherjee         2015-03-03  839  	/* set info */
e3a3f9f5123683 Mike Rapoport           2015-10-26  840  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport           2015-10-26  841  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee         2015-03-03  842  
81dee67e215b23 Sudip Mukherjee         2015-03-03  843  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip         2021-07-28  844  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee         2015-03-03  845  	pr_debug("screen_base vaddr = %p\n", info->screen_base);
81dee67e215b23 Sudip Mukherjee         2015-03-03  846  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee         2015-03-03  847  
81dee67e215b23 Sudip Mukherjee         2015-03-03  848  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee         2015-03-03  849  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee         2015-03-03  850  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  851  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  852  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  853  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee         2015-03-03  854  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee         2015-03-03  855  
9c15db83a86bf8 Kumar Kartikeya Dwivedi 2021-01-31  856  	strscpy(fix->id, fixId[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee         2015-03-03  857  
fdc234d85210d9 Benjamin Philip         2021-07-28  858  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
81dee67e215b23 Sudip Mukherjee         2015-03-03  859  	pr_info("fix->smem_start = %lx\n", fix->smem_start);
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  860  	/*
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  861  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee         2015-03-03  862  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee         2015-03-03  863  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee         2015-03-03  864  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee         2015-03-03  865  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee         2015-08-07  866  	 */
81dee67e215b23 Sudip Mukherjee         2015-03-03  867  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee         2015-03-03  868  	pr_info("fix->smem_len = %x\n", fix->smem_len);
81dee67e215b23 Sudip Mukherjee         2015-03-03  869  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee         2015-03-03  870  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport           2015-10-26  871  	fix->mmio_start = sm750_dev->vidreg_start;
81dee67e215b23 Sudip Mukherjee         2015-03-03  872  	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
e359b6a863e19f Mike Rapoport           2015-10-26  873  	fix->mmio_len = sm750_dev->vidreg_size;
81dee67e215b23 Sudip Mukherjee         2015-03-03  874  	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
b610e1193a917f Matej Dujava            2020-04-30  875  
b610e1193a917f Matej Dujava            2020-04-30  876  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee         2015-03-03  877  
81dee67e215b23 Sudip Mukherjee         2015-03-03  878  	/* set var */
81dee67e215b23 Sudip Mukherjee         2015-03-03  879  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee         2015-03-03  880  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee         2015-03-03  881  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee         2015-03-03  882  
81dee67e215b23 Sudip Mukherjee         2015-03-03  883  	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  884  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee         2015-03-03  885  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee         2015-03-03  886  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee         2015-03-03  887  
61c507cf652da1 Michel von Czettritz    2015-03-26  888  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz    2015-03-26  889  	if (ret < 0) {
008272072d61a8 Masanari Iida           2015-05-28  890  		pr_err("Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee         2015-03-03  891  		goto exit;
81dee67e215b23 Sudip Mukherjee         2015-03-03  892  	}
81dee67e215b23 Sudip Mukherjee         2015-03-03  893  
81dee67e215b23 Sudip Mukherjee         2015-03-03  894  	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee         2015-03-03  895  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee         2015-03-03  896  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee         2015-03-03  897  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee         2015-03-03  898  
81dee67e215b23 Sudip Mukherjee         2015-03-03  899  exit:
81dee67e215b23 Sudip Mukherjee         2015-03-03  900  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee         2015-03-03  901  	return ret;
81dee67e215b23 Sudip Mukherjee         2015-03-03  902  }
81dee67e215b23 Sudip Mukherjee         2015-03-03  903  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

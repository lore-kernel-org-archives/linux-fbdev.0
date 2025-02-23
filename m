Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C41FFC6F;
	Sun, 23 Feb 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303283; cv=none; b=qGUIvzt7ei0eol9RiBF3R+IAQ65MmbFi3walEshFCHVYkndu5IQxaKJMhx+5kMQn4nE50WjT6wNStT+GS38Hwn0Twx0HrUh/IPPzELUynkUXWkKvOKb9dIZz/e3/4n3rLIHNKttw5dQj127jU/Yo1ac8V2kAJ77/pHABF87OrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303283; c=relaxed/simple;
	bh=k2WTSfIJwvn+jHWTG/yn8iznz0V9yHCRx8Q7t1N+PPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2DNvKT0Yya+ALoqwGGlopOeFvaxOMmM9Jtzv5TYO3An72suUv7f1sZrPeWIirJClA/AldmNowvkd27oyVG6M3jI5j/iVR+qUpWZo7oKC7vC6JlbI8De2JXqRDba1EUUmxkI1WzXx5SkUK9A7va5K4akuWB+k72L5jloss8yWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g85AzItM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g85AzItM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740303281; x=1771839281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2WTSfIJwvn+jHWTG/yn8iznz0V9yHCRx8Q7t1N+PPc=;
  b=g85AzItM1mQtz91GZhYgLj4OmquWTGVX6IKaN/iYtC8JTVapwoCflML+
   NQ2vGFbA90jrsgkGl+Ic/JYOrylgb874fImlp/J16q6uq/YdcqeJ4ZDiF
   ANHMq8SVpgvb5xZU+vVyTo3g5ESkWRfz8yuvRxGMuBbkqnbUxObGpNMlT
   EZJhH1oWWoq7aXTqq+lHXed8D6SjQHhOAA3QLTAMHeyf9UgLoQxt+t2nv
   D5a/4WuQCAa1osCz6Y0mLOtjdO98m7p/wFjoTKZilGeP3qAKUyUzCS8cW
   mucO3Wk/c7P0tQVsFlN65B9U5kw3CNsKA+6diW8rvRpsWfe2arbNjOXwE
   w==;
X-CSE-ConnectionGUID: bK4IN3FoSOeRFXjjXQUbnA==
X-CSE-MsgGUID: +dnxCoXCScK/9O0p2Yxy3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52501876"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52501876"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 01:34:40 -0800
X-CSE-ConnectionGUID: 4j7ppbQaRxOYbP9gXxOlIQ==
X-CSE-MsgGUID: T1S5J+AXSK+lKMUxKAxbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115809270"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Feb 2025 01:34:38 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm8Nf-0007F1-2t;
	Sun, 23 Feb 2025 09:34:35 +0000
Date: Sun, 23 Feb 2025 17:34:20 +0800
From: kernel test robot <lkp@intel.com>
To: Madhur Kumar <madhurkumar004@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] [PATCH v2] staging: sm750fb: Make g_fbmode truly constant
Message-ID: <202502231754.pnnw8mMg-lkp@intel.com>
References: <20250222201514.15730-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222201514.15730-1-madhurkumar004@gmail.com>

Hi Madhur,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Madhur-Kumar/staging-sm750fb-Make-g_fbmode-truly-constant/20250223-041638
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250222201514.15730-1-madhurkumar004%40gmail.com
patch subject: [PATCH] [PATCH v2] staging: sm750fb: Make g_fbmode truly constant
config: x86_64-buildonly-randconfig-001-20250223 (https://download.01.org/0day-ci/archive/20250223/202502231754.pnnw8mMg-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231754.pnnw8mMg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231754.pnnw8mMg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/staging/sm750fb/sm750.c:7:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/sm750fb/sm750.c:788:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     788 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:790:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     790 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:951:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     951 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:955:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     955 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 4 errors generated.


vim +788 drivers/staging/sm750fb/sm750.c

81dee67e215b23f Sudip Mukherjee         2015-03-03  715  
81dee67e215b23f Sudip Mukherjee         2015-03-03  716  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23f Sudip Mukherjee         2015-03-03  717  {
81dee67e215b23f Sudip Mukherjee         2015-03-03  718  	int i;
81dee67e215b23f Sudip Mukherjee         2015-03-03  719  	struct lynxfb_par *par;
e359b6a863e19f2 Mike Rapoport           2015-10-26  720  	struct sm750_dev *sm750_dev;
81dee67e215b23f Sudip Mukherjee         2015-03-03  721  	struct lynxfb_crtc *crtc;
81dee67e215b23f Sudip Mukherjee         2015-03-03  722  	struct lynxfb_output *output;
81dee67e215b23f Sudip Mukherjee         2015-03-03  723  	struct fb_var_screeninfo *var;
81dee67e215b23f Sudip Mukherjee         2015-03-03  724  	struct fb_fix_screeninfo *fix;
81dee67e215b23f Sudip Mukherjee         2015-03-03  725  
81dee67e215b23f Sudip Mukherjee         2015-03-03  726  	const struct fb_videomode *pdb[] = {
81dee67e215b23f Sudip Mukherjee         2015-03-03  727  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23f Sudip Mukherjee         2015-03-03  728  	};
81dee67e215b23f Sudip Mukherjee         2015-03-03  729  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d5d66cfea2ca281 Kelsey Skunberg         2019-04-27  730  	static const char * const mdb_desc[] = {
81dee67e215b23f Sudip Mukherjee         2015-03-03  731  		"driver prepared modes",
81dee67e215b23f Sudip Mukherjee         2015-03-03  732  		"kernel prepared default modedb",
81dee67e215b23f Sudip Mukherjee         2015-03-03  733  		"kernel HELPERS prepared vesa_modes",
81dee67e215b23f Sudip Mukherjee         2015-03-03  734  	};
81dee67e215b23f Sudip Mukherjee         2015-03-03  735  
70407df77665c0e Michel von Czettritz    2015-03-26  736  	static const char *fixId[2] = {
81dee67e215b23f Sudip Mukherjee         2015-03-03  737  		"sm750_fb1", "sm750_fb2",
81dee67e215b23f Sudip Mukherjee         2015-03-03  738  	};
81dee67e215b23f Sudip Mukherjee         2015-03-03  739  
81dee67e215b23f Sudip Mukherjee         2015-03-03  740  	int ret, line_length;
81dee67e215b23f Sudip Mukherjee         2015-03-03  741  
81dee67e215b23f Sudip Mukherjee         2015-03-03  742  	ret = 0;
81dee67e215b23f Sudip Mukherjee         2015-03-03  743  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f2 Mike Rapoport           2015-10-26  744  	sm750_dev = par->dev;
81dee67e215b23f Sudip Mukherjee         2015-03-03  745  	crtc = &par->crtc;
81dee67e215b23f Sudip Mukherjee         2015-03-03  746  	output = &par->output;
81dee67e215b23f Sudip Mukherjee         2015-03-03  747  	var = &info->var;
81dee67e215b23f Sudip Mukherjee         2015-03-03  748  	fix = &info->fix;
81dee67e215b23f Sudip Mukherjee         2015-03-03  749  
81dee67e215b23f Sudip Mukherjee         2015-03-03  750  	/* set index */
81dee67e215b23f Sudip Mukherjee         2015-03-03  751  	par->index = index;
81dee67e215b23f Sudip Mukherjee         2015-03-03  752  	output->channel = &crtc->channel;
81dee67e215b23f Sudip Mukherjee         2015-03-03  753  	sm750fb_set_drv(par);
81dee67e215b23f Sudip Mukherjee         2015-03-03  754  
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  755  	/*
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  756  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  757  	 * must be set after crtc member initialized
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  758  	 */
fdc234d85210d91 Benjamin Philip         2021-07-28  759  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f2 Mike Rapoport           2015-10-26  760  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f2 Mike Rapoport           2015-10-26  761  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23f Sudip Mukherjee         2015-03-03  762  
81dee67e215b23f Sudip Mukherjee         2015-03-03  763  	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
cd33da26036ea54 Christopher Carbone     2022-08-23  764  	crtc->cursor.max_h = 64;
cd33da26036ea54 Christopher Carbone     2022-08-23  765  	crtc->cursor.max_w = 64;
39f9137268ee3df Benjamin Philip         2021-07-26  766  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f2 Mike Rapoport           2015-10-26  767  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23f Sudip Mukherjee         2015-03-03  768  
3de08a2d14ff8c7 Lorenzo Stoakes         2015-03-20  769  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09d Thomas Zimmermann       2023-11-27  770  	if (!g_hwcursor)
52d0744d751d8f1 Arnd Bergmann           2016-11-09  771  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23f Sudip Mukherjee         2015-03-03  772  
81dee67e215b23f Sudip Mukherjee         2015-03-03  773  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f2 Mike Rapoport           2015-10-26  774  	if (!sm750_dev->accel_off) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  775  		/* use 2d acceleration */
f7c8a046577e09d Thomas Zimmermann       2023-11-27  776  		if (!g_hwcursor)
f7c8a046577e09d Thomas Zimmermann       2023-11-27  777  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09d Thomas Zimmermann       2023-11-27  778  		else
f7c8a046577e09d Thomas Zimmermann       2023-11-27  779  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09d Thomas Zimmermann       2023-11-27  780  	} else {
f7c8a046577e09d Thomas Zimmermann       2023-11-27  781  		if (!g_hwcursor)
81dee67e215b23f Sudip Mukherjee         2015-03-03  782  			info->fbops = &lynxfb_ops;
f7c8a046577e09d Thomas Zimmermann       2023-11-27  783  		else
f7c8a046577e09d Thomas Zimmermann       2023-11-27  784  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09d Thomas Zimmermann       2023-11-27  785  	}
81dee67e215b23f Sudip Mukherjee         2015-03-03  786  
81dee67e215b23f Sudip Mukherjee         2015-03-03  787  	if (!g_fbmode[index]) {
81dee67e215b23f Sudip Mukherjee         2015-03-03 @788  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23f Sudip Mukherjee         2015-03-03  789  		if (index)
81dee67e215b23f Sudip Mukherjee         2015-03-03  790  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23f Sudip Mukherjee         2015-03-03  791  	}
81dee67e215b23f Sudip Mukherjee         2015-03-03  792  
81dee67e215b23f Sudip Mukherjee         2015-03-03  793  	for (i = 0; i < 3; i++) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  794  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23f Sudip Mukherjee         2015-03-03  795  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23f Sudip Mukherjee         2015-03-03  796  
81dee67e215b23f Sudip Mukherjee         2015-03-03  797  		if (ret == 1) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  798  			pr_info("success! use specified mode:%s in %s\n",
81dee67e215b23f Sudip Mukherjee         2015-03-03  799  				g_fbmode[index],
81dee67e215b23f Sudip Mukherjee         2015-03-03  800  				mdb_desc[i]);
81dee67e215b23f Sudip Mukherjee         2015-03-03  801  			break;
81dee67e215b23f Sudip Mukherjee         2015-03-03  802  		} else if (ret == 2) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  803  			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
81dee67e215b23f Sudip Mukherjee         2015-03-03  804  				g_fbmode[index],
81dee67e215b23f Sudip Mukherjee         2015-03-03  805  				mdb_desc[i]);
81dee67e215b23f Sudip Mukherjee         2015-03-03  806  			break;
81dee67e215b23f Sudip Mukherjee         2015-03-03  807  		} else if (ret == 3) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  808  			pr_warn("wanna use default mode\n");
4bd9503d0becdb6 Michel von Czettritz    2015-03-26  809  			/*break;*/
81dee67e215b23f Sudip Mukherjee         2015-03-03  810  		} else if (ret == 4) {
81dee67e215b23f Sudip Mukherjee         2015-03-03  811  			pr_warn("fall back to any valid mode\n");
81dee67e215b23f Sudip Mukherjee         2015-03-03  812  		} else {
3318bb5e945f700 Michel von Czettritz    2015-03-26  813  			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
3318bb5e945f700 Michel von Czettritz    2015-03-26  814  				ret,
3318bb5e945f700 Michel von Czettritz    2015-03-26  815  				mdb_desc[i]);
81dee67e215b23f Sudip Mukherjee         2015-03-03  816  		}
81dee67e215b23f Sudip Mukherjee         2015-03-03  817  	}
81dee67e215b23f Sudip Mukherjee         2015-03-03  818  
81dee67e215b23f Sudip Mukherjee         2015-03-03  819  	/* some member of info->var had been set by fb_find_mode */
81dee67e215b23f Sudip Mukherjee         2015-03-03  820  
271dbae3c6a1daa Prasant Jalan           2017-04-01  821  	pr_info("Member of info->var is :\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  822  		"xres=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  823  		"yres=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  824  		"xres_virtual=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  825  		"yres_virtual=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  826  		"xoffset=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  827  		"yoffset=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  828  		"bits_per_pixel=%d\n"
271dbae3c6a1daa Prasant Jalan           2017-04-01  829  		" ...\n",
3318bb5e945f700 Michel von Czettritz    2015-03-26  830  		var->xres,
3318bb5e945f700 Michel von Czettritz    2015-03-26  831  		var->yres,
3318bb5e945f700 Michel von Czettritz    2015-03-26  832  		var->xres_virtual,
3318bb5e945f700 Michel von Czettritz    2015-03-26  833  		var->yres_virtual,
3318bb5e945f700 Michel von Czettritz    2015-03-26  834  		var->xoffset,
3318bb5e945f700 Michel von Czettritz    2015-03-26  835  		var->yoffset,
3318bb5e945f700 Michel von Czettritz    2015-03-26  836  		var->bits_per_pixel);
81dee67e215b23f Sudip Mukherjee         2015-03-03  837  
81dee67e215b23f Sudip Mukherjee         2015-03-03  838  	/* set par */
81dee67e215b23f Sudip Mukherjee         2015-03-03  839  	par->info = info;
81dee67e215b23f Sudip Mukherjee         2015-03-03  840  
81dee67e215b23f Sudip Mukherjee         2015-03-03  841  	/* set info */
e3a3f9f5123683b Mike Rapoport           2015-10-26  842  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683b Mike Rapoport           2015-10-26  843  			    crtc->line_pad);
81dee67e215b23f Sudip Mukherjee         2015-03-03  844  
81dee67e215b23f Sudip Mukherjee         2015-03-03  845  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab6 Benjamin Philip         2021-07-28  846  	info->screen_base = crtc->v_screen;
81dee67e215b23f Sudip Mukherjee         2015-03-03  847  	pr_debug("screen_base vaddr = %p\n", info->screen_base);
81dee67e215b23f Sudip Mukherjee         2015-03-03  848  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23f Sudip Mukherjee         2015-03-03  849  
81dee67e215b23f Sudip Mukherjee         2015-03-03  850  	/* set info->fix */
81dee67e215b23f Sudip Mukherjee         2015-03-03  851  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23f Sudip Mukherjee         2015-03-03  852  	fix->type_aux = 0;
81dee67e215b23f Sudip Mukherjee         2015-03-03  853  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23f Sudip Mukherjee         2015-03-03  854  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23f Sudip Mukherjee         2015-03-03  855  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23f Sudip Mukherjee         2015-03-03  856  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23f Sudip Mukherjee         2015-03-03  857  
9c15db83a86bf83 Kumar Kartikeya Dwivedi 2021-01-31  858  	strscpy(fix->id, fixId[index], sizeof(fix->id));
81dee67e215b23f Sudip Mukherjee         2015-03-03  859  
fdc234d85210d91 Benjamin Philip         2021-07-28  860  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
81dee67e215b23f Sudip Mukherjee         2015-03-03  861  	pr_info("fix->smem_start = %lx\n", fix->smem_start);
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  862  	/*
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  863  	 * according to mmap experiment from user space application,
81dee67e215b23f Sudip Mukherjee         2015-03-03  864  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23f Sudip Mukherjee         2015-03-03  865  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23f Sudip Mukherjee         2015-03-03  866  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23f Sudip Mukherjee         2015-03-03  867  	 * data into the bound over virtual size
d11ac7cbcc266c6 Sudip Mukherjee         2015-08-07  868  	 */
81dee67e215b23f Sudip Mukherjee         2015-03-03  869  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23f Sudip Mukherjee         2015-03-03  870  	pr_info("fix->smem_len = %x\n", fix->smem_len);
81dee67e215b23f Sudip Mukherjee         2015-03-03  871  	info->screen_size = fix->smem_len;
81dee67e215b23f Sudip Mukherjee         2015-03-03  872  	fix->line_length = line_length;
e359b6a863e19f2 Mike Rapoport           2015-10-26  873  	fix->mmio_start = sm750_dev->vidreg_start;
81dee67e215b23f Sudip Mukherjee         2015-03-03  874  	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
e359b6a863e19f2 Mike Rapoport           2015-10-26  875  	fix->mmio_len = sm750_dev->vidreg_size;
81dee67e215b23f Sudip Mukherjee         2015-03-03  876  	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
b610e1193a917f4 Matej Dujava            2020-04-30  877  
b610e1193a917f4 Matej Dujava            2020-04-30  878  	lynxfb_set_visual_mode(info);
81dee67e215b23f Sudip Mukherjee         2015-03-03  879  
81dee67e215b23f Sudip Mukherjee         2015-03-03  880  	/* set var */
81dee67e215b23f Sudip Mukherjee         2015-03-03  881  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23f Sudip Mukherjee         2015-03-03  882  	var->accel_flags = 0;
81dee67e215b23f Sudip Mukherjee         2015-03-03  883  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23f Sudip Mukherjee         2015-03-03  884  
81dee67e215b23f Sudip Mukherjee         2015-03-03  885  	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23f Sudip Mukherjee         2015-03-03  886  		 info->cmap.start, info->cmap.len,
81dee67e215b23f Sudip Mukherjee         2015-03-03  887  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23f Sudip Mukherjee         2015-03-03  888  		 info->cmap.transp);
81dee67e215b23f Sudip Mukherjee         2015-03-03  889  
61c507cf652da1b Michel von Czettritz    2015-03-26  890  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1b Michel von Czettritz    2015-03-26  891  	if (ret < 0) {
008272072d61a8c Masanari Iida           2015-05-28  892  		pr_err("Could not allocate memory for cmap.\n");
81dee67e215b23f Sudip Mukherjee         2015-03-03  893  		goto exit;
81dee67e215b23f Sudip Mukherjee         2015-03-03  894  	}
81dee67e215b23f Sudip Mukherjee         2015-03-03  895  
81dee67e215b23f Sudip Mukherjee         2015-03-03  896  	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23f Sudip Mukherjee         2015-03-03  897  		 info->cmap.start, info->cmap.len,
81dee67e215b23f Sudip Mukherjee         2015-03-03  898  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23f Sudip Mukherjee         2015-03-03  899  		 info->cmap.transp);
81dee67e215b23f Sudip Mukherjee         2015-03-03  900  
81dee67e215b23f Sudip Mukherjee         2015-03-03  901  exit:
81dee67e215b23f Sudip Mukherjee         2015-03-03  902  	lynxfb_ops_check_var(var, info);
81dee67e215b23f Sudip Mukherjee         2015-03-03  903  	return ret;
81dee67e215b23f Sudip Mukherjee         2015-03-03  904  }
81dee67e215b23f Sudip Mukherjee         2015-03-03  905  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

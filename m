Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0B2D061B;
	Sat,  7 Mar 2026 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772924786; cv=none; b=e8WdvkIydnpDo2qWuYnltnEa160RflLBc6MiqK/QAr/cJbrAfJpmLG5MR6lO1dMQsL77T40dvdunGU7o2M4TZpzxOLquHcUZPttAFrWhdAfbrVgedLqZBbuMasX9WefpdZr8uOigWXozXT4lQ+kctUiW90PJUov92T0JLqw4Kgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772924786; c=relaxed/simple;
	bh=uUyz/GFBIceQ9N90GDOML2IhwOZGuDF06716jN823H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsy8i47Q3Q8zemjaAK/9jhFyDEbQEFAB1tlf8ypiTBLneDjYsj0W8eLa7TVcvBBQdic8E+M1zMz2SCTGRJcsVm7GBwKmnCt5yFUra5ZfpV/gyoQ/ST6rNneXm6WvfQ1gfxwd0K0kvei+LHGR/+GqIivtB5BT9ECLnMdJsfws2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yr2PxIfQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yr2PxIfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772924784; x=1804460784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uUyz/GFBIceQ9N90GDOML2IhwOZGuDF06716jN823H0=;
  b=Yr2PxIfQxTabQUgxDPEopT8PV5bicQd+VwJUl43g88/1NU+oFHR+10iY
   U152WkMxA7hWVQOyDduMfGfVOpvcW8mHGNopewiRRx9tWMnTgER+eu68+
   kFgz+HqdmDd7xWr062zcJzUqrMKO8y6t6KSVJ+W3Bmipi9wwnxQo70sns
   N58GqtR2HRpd8vT4vwbDfZdnE1KBNGBLol5AYn+fSuK86QmDQAxl9N7Qs
   yN2Vq5OYgzdEM91oPiUmVXgt7a3fvIAaGgRLzRb9eiu8HM5Bz4xYSQDdG
   lrF844clpNnstu97pkPjDC+Wi8aQ2MTDLn/2Kh9F0okSrwq4Fe51S997c
   A==;
X-CSE-ConnectionGUID: 4ovq4KXgTbuhbDGKM5m3Jg==
X-CSE-MsgGUID: 419hAZB8RQqfE58Jm3Tejg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73964834"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73964834"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 15:06:24 -0800
X-CSE-ConnectionGUID: uSOIQIUHQruDxwdceY2wrA==
X-CSE-MsgGUID: ZEQcEgeBR9+UU+sTGR/FlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="215961980"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2026 15:06:21 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz0iw-000000002hl-0m3w;
	Sat, 07 Mar 2026 23:06:18 +0000
Date: Sun, 8 Mar 2026 07:05:45 +0800
From: kernel test robot <lkp@intel.com>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: add missing const qualifier to char
 pointer array
Message-ID: <202603080719.feszwgV8-lkp@intel.com>
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
config: parisc-randconfig-r073-20260308 (https://download.01.org/0day-ci/archive/20260308/202603080719.feszwgV8-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.4.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080719.feszwgV8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080719.feszwgV8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> drivers/staging/sm750fb/sm750.c:782:33: error: assignment of read-only location 'g_fbmode[index]'
     782 |                 g_fbmode[index] = g_def_fbmode;
         |                                 ^
   drivers/staging/sm750fb/sm750.c:784:41: error: assignment of read-only location 'g_fbmode[index]'
     784 |                         g_fbmode[index] = g_fbmode[0];
         |                                         ^
   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:893:45: error: assignment of read-only location 'g_fbmode[0]'
     893 |                                 g_fbmode[0] = opt;
         |                                             ^
   drivers/staging/sm750fb/sm750.c:897:45: error: assignment of read-only location 'g_fbmode[1]'
     897 |                                 g_fbmode[1] = opt;
         |                                             ^


vim +782 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  716  
81dee67e215b23 Sudip Mukherjee      2015-03-03  717  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  718  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  719  	int i;
81dee67e215b23 Sudip Mukherjee      2015-03-03  720  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport        2015-10-26  721  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  722  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  723  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  724  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  725  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  726  
81dee67e215b23 Sudip Mukherjee      2015-03-03  727  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  728  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee      2015-03-03  729  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  730  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
8c475735085a7d Tim Wassink          2025-12-21  731  	static const char *fix_id[2] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  732  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee      2015-03-03  733  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  734  
81dee67e215b23 Sudip Mukherjee      2015-03-03  735  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee      2015-03-03  736  
81dee67e215b23 Sudip Mukherjee      2015-03-03  737  	ret = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  738  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport        2015-10-26  739  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  740  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  741  	output = &par->output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  742  	var = &info->var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  743  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  744  
81dee67e215b23 Sudip Mukherjee      2015-03-03  745  	/* set index */
81dee67e215b23 Sudip Mukherjee      2015-03-03  746  	par->index = index;
81dee67e215b23 Sudip Mukherjee      2015-03-03  747  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee      2015-03-03  748  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee      2015-03-03  749  
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  750  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  751  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  752  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  753  	 */
fdc234d85210d9 Benjamin Philip      2021-07-28  754  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport        2015-10-26  755  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport        2015-10-26  756  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee      2015-03-03  757  
cd33da26036ea5 Christopher Carbone  2022-08-23  758  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone  2022-08-23  759  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip      2021-07-26  760  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f Mike Rapoport        2015-10-26  761  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee      2015-03-03  762  
3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  763  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann    2023-11-27  764  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann        2016-11-09  765  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  766  
81dee67e215b23 Sudip Mukherjee      2015-03-03  767  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport        2015-10-26  768  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  769  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann    2023-11-27  770  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann    2023-11-27  771  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  772  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  773  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  774  	} else {
f7c8a046577e09 Thomas Zimmermann    2023-11-27  775  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  776  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  777  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  778  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  779  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  780  
81dee67e215b23 Sudip Mukherjee      2015-03-03  781  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @782  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee      2015-03-03  783  		if (index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  784  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee      2015-03-03  785  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  786  
81dee67e215b23 Sudip Mukherjee      2015-03-03  787  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  788  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  789  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee      2015-03-03  790  
db7fb3588ab492 Artem Lytkin         2026-02-23  791  		if (ret == 1 || ret == 2)
81dee67e215b23 Sudip Mukherjee      2015-03-03  792  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  793  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  794  
81dee67e215b23 Sudip Mukherjee      2015-03-03  795  	/* set par */
81dee67e215b23 Sudip Mukherjee      2015-03-03  796  	par->info = info;
81dee67e215b23 Sudip Mukherjee      2015-03-03  797  
81dee67e215b23 Sudip Mukherjee      2015-03-03  798  	/* set info */
e3a3f9f5123683 Mike Rapoport        2015-10-26  799  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport        2015-10-26  800  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee      2015-03-03  801  
81dee67e215b23 Sudip Mukherjee      2015-03-03  802  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip      2021-07-28  803  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee      2015-03-03  804  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee      2015-03-03  805  
81dee67e215b23 Sudip Mukherjee      2015-03-03  806  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee      2015-03-03  807  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee      2015-03-03  808  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  809  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  810  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  811  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  812  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee      2015-03-03  813  
8c475735085a7d Tim Wassink          2025-12-21  814  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee      2015-03-03  815  
fdc234d85210d9 Benjamin Philip      2021-07-28  816  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  817  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  818  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee      2015-03-03  819  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee      2015-03-03  820  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee      2015-03-03  821  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee      2015-03-03  822  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  823  	 */
81dee67e215b23 Sudip Mukherjee      2015-03-03  824  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  825  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee      2015-03-03  826  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport        2015-10-26  827  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f Mike Rapoport        2015-10-26  828  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f Matej Dujava         2020-04-30  829  
b610e1193a917f Matej Dujava         2020-04-30  830  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  831  
81dee67e215b23 Sudip Mukherjee      2015-03-03  832  	/* set var */
81dee67e215b23 Sudip Mukherjee      2015-03-03  833  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee      2015-03-03  834  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  835  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee      2015-03-03  836  
61c507cf652da1 Michel von Czettritz 2015-03-26  837  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz 2015-03-26  838  	if (ret < 0) {
fbab250eb51d6d Artem Lytkin         2026-02-07  839  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  840  		goto exit;
81dee67e215b23 Sudip Mukherjee      2015-03-03  841  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  842  
81dee67e215b23 Sudip Mukherjee      2015-03-03  843  exit:
81dee67e215b23 Sudip Mukherjee      2015-03-03  844  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  845  	return ret;
81dee67e215b23 Sudip Mukherjee      2015-03-03  846  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  847  
81dee67e215b23 Sudip Mukherjee      2015-03-03  848  /*	chip specific g_option configuration routine */
700591a9adc8b1 Mike Rapoport        2015-10-26  849  static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
81dee67e215b23 Sudip Mukherjee      2015-03-03  850  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  851  	char *opt;
81dee67e215b23 Sudip Mukherjee      2015-03-03  852  	int swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  853  
81dee67e215b23 Sudip Mukherjee      2015-03-03  854  	swap = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  855  
cc34db609ff98c Madhumitha Sundar    2026-01-27  856  	sm750_dev->init_parm.chip_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  857  	sm750_dev->init_parm.mem_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  858  	sm750_dev->init_parm.master_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  859  	sm750_dev->init_parm.powerMode = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  860  	sm750_dev->init_parm.setAllEngOff = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  861  	sm750_dev->init_parm.resetMemory = 1;
81dee67e215b23 Sudip Mukherjee      2015-03-03  862  
81dee67e215b23 Sudip Mukherjee      2015-03-03  863  	/* defaultly turn g_hwcursor on for both view */
81dee67e215b23 Sudip Mukherjee      2015-03-03  864  	g_hwcursor = 3;
81dee67e215b23 Sudip Mukherjee      2015-03-03  865  
81dee67e215b23 Sudip Mukherjee      2015-03-03  866  	if (!src || !*src) {
c56de0967a658c Elise Lennion        2016-10-31  867  		dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  868  		goto NO_PARAM;
81dee67e215b23 Sudip Mukherjee      2015-03-03  869  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  870  
0fa96e39279988 Sudip Mukherjee      2015-03-10  871  	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
c56de0967a658c Elise Lennion        2016-10-31  872  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
c56de0967a658c Elise Lennion        2016-10-31  873  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
81dee67e215b23 Sudip Mukherjee      2015-03-03  874  
144634a6b42146 Katie Dunne          2017-02-19  875  		if (!strncmp(opt, "swap", strlen("swap"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  876  			swap = 1;
144634a6b42146 Katie Dunne          2017-02-19  877  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  878  			sm750_dev->nocrt = 1;
144634a6b42146 Katie Dunne          2017-02-19  879  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  880  			sm750_dev->pnltype = sm750_doubleTFT;
144634a6b42146 Katie Dunne          2017-02-19  881  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  882  			sm750_dev->pnltype = sm750_dualTFT;
144634a6b42146 Katie Dunne          2017-02-19  883  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  884  			sm750_dev->pnltype = sm750_24TFT;
144634a6b42146 Katie Dunne          2017-02-19  885  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  886  			g_hwcursor &= ~0x1;
144634a6b42146 Katie Dunne          2017-02-19  887  		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  888  			g_hwcursor &= ~0x2;
144634a6b42146 Katie Dunne          2017-02-19  889  		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  890  			g_hwcursor = 0;
144634a6b42146 Katie Dunne          2017-02-19  891  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  892  			if (!g_fbmode[0]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @893  				g_fbmode[0] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  894  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  895  					 "find fbmode0 : %s\n", g_fbmode[0]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  896  			} else if (!g_fbmode[1]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  897  				g_fbmode[1] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  898  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  899  					 "find fbmode1 : %s\n", g_fbmode[1]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  900  			} else {
c56de0967a658c Elise Lennion        2016-10-31  901  				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  902  			}
81dee67e215b23 Sudip Mukherjee      2015-03-03  903  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  904  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  905  
81dee67e215b23 Sudip Mukherjee      2015-03-03  906  NO_PARAM:
e359b6a863e19f Mike Rapoport        2015-10-26  907  	if (sm750_dev->revid != SM750LE_REVISION_ID) {
a3f92cc94c6126 Mike Rapoport        2016-01-17  908  		if (sm750_dev->fb_count > 1) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  909  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  910  				sm750_dev->dataflow = sm750_dual_swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  911  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  912  				sm750_dev->dataflow = sm750_dual_normal;
81dee67e215b23 Sudip Mukherjee      2015-03-03  913  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  914  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  915  				sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  916  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  917  				sm750_dev->dataflow = sm750_simul_pri;
81dee67e215b23 Sudip Mukherjee      2015-03-03  918  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  919  	} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  920  		/* SM750LE only have one crt channel */
1757d106a9ce8c Mike Rapoport        2015-10-26  921  		sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  922  		/* sm750le do not have complex attributes */
1757d106a9ce8c Mike Rapoport        2015-10-26  923  		sm750_dev->nocrt = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  924  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  925  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  926  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

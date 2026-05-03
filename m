Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F828FFF6;
	Sun,  3 May 2026 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782968; cv=none; b=Pd+RLJ9uJ6yKHCx9bcyLsOwEpYEBD92lnO2Uls2h3XqtaiGTs3H33Uh7/BrtCKo/MkwxFyW/J2OJeQiujnl8Ff5oQbYdj72TNIc/JvrKFIDsSgBNXTxKET4q1iBL99/dZPR22woM8YhJPdcHicGUzla24ijgTYK11kV/dOCcqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782968; c=relaxed/simple;
	bh=/pyQZj7FC8oNhzRhXoOBMmrjWxg1NmrQl/03YK4qAY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX0CB2NAn0RgQmgfEFPIdPqdOHQKTzwPgJ6gHEAu9621IZPssRXYo/NAUok8NZrpTVt14o3WaVbIXCGKPc3+rCXI13DjRXqty6GI8mZTJAn3kpN22dh6G1WXbV8vWGEiOW9vsP6U3dqD9fnc/PrUft2qNPM/OpY/QaO0Z9igFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDbHxfXS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDbHxfXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777782967; x=1809318967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/pyQZj7FC8oNhzRhXoOBMmrjWxg1NmrQl/03YK4qAY0=;
  b=CDbHxfXSxlJuZOWTfktJwUtTNywSVd2PodC5qVHXx4qKmCsSzHpzOTnR
   cSQOjEx7Ugw0LvXCxUTGvAIGDEbmPJp6KZKQnTE5Qc3ANydMG5pZ7z3L+
   7Kx2zkCFHfAa5NC1aOWBxiHX7fDw0hTAcP61Cv3WLov74eX6A3Y1Eain+
   zNiOnNESA35d1Z4kdNNjsVKjShZCBWQbTOzV96JhTw5smRMzrJqq5Lxg3
   3GP8AEoYMPtm5QnrRFZ7Gt9bFi2/IwE6YSjuH8zL3OPPw84DZpv9428Mq
   3XYq/ejgjtuXT9F0B6bsjNqNdfOJbWhxabKRuXoUrynXysTLC5K0534hq
   g==;
X-CSE-ConnectionGUID: wujM91/uRCuqRRkj0qGZaQ==
X-CSE-MsgGUID: 6scep1IxQUmYT9HeHmjxkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82536754"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="82536754"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 21:36:06 -0700
X-CSE-ConnectionGUID: VntB84jRR9OB6wJc95WZeg==
X-CSE-MsgGUID: 5HQ1XK+YQ3qkGJb7vxhCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="234345644"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2026 21:36:03 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJOYi-0000000029N-3bGY;
	Sun, 03 May 2026 04:36:00 +0000
Date: Sun, 3 May 2026 12:35:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ilai Levin <levinilai972@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ilai Levin <levinilai972@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: fix const pointer array declaration
Message-ID: <202605031219.ZJk8DDJm-lkp@intel.com>
References: <20260428122501.100696-1-levinilai972@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428122501.100696-1-levinilai972@gmail.com>

Hi Ilai,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilai-Levin/staging-sm750fb-fix-const-pointer-array-declaration/20260501-103116
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260428122501.100696-1-levinilai972%40gmail.com
patch subject: [PATCH] staging: sm750fb: fix const pointer array declaration
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260503/202605031219.ZJk8DDJm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605031219.ZJk8DDJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605031219.ZJk8DDJm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> drivers/staging/sm750fb/sm750.c:785:33: error: assignment of read-only location 'g_fbmode[index]'
     785 |                 g_fbmode[index] = g_def_fbmode;
         |                                 ^
   drivers/staging/sm750fb/sm750.c:787:41: error: assignment of read-only location 'g_fbmode[index]'
     787 |                         g_fbmode[index] = g_fbmode[0];
         |                                         ^
   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:896:45: error: assignment of read-only location 'g_fbmode[0]'
     896 |                                 g_fbmode[0] = opt;
         |                                             ^
   drivers/staging/sm750fb/sm750.c:900:45: error: assignment of read-only location 'g_fbmode[1]'
     900 |                                 g_fbmode[1] = opt;
         |                                             ^


vim +785 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  719  
81dee67e215b23 Sudip Mukherjee      2015-03-03  720  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  721  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  722  	int i;
81dee67e215b23 Sudip Mukherjee      2015-03-03  723  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport        2015-10-26  724  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  725  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  726  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  727  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  728  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  729  
81dee67e215b23 Sudip Mukherjee      2015-03-03  730  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  731  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee      2015-03-03  732  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  733  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d0856045f0e9fc Hungyu Lin           2026-04-01  734  	static const char * const fix_id[2] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  735  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee      2015-03-03  736  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  737  
81dee67e215b23 Sudip Mukherjee      2015-03-03  738  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee      2015-03-03  739  
81dee67e215b23 Sudip Mukherjee      2015-03-03  740  	ret = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  741  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport        2015-10-26  742  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  743  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  744  	output = &par->output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  745  	var = &info->var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  746  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  747  
81dee67e215b23 Sudip Mukherjee      2015-03-03  748  	/* set index */
81dee67e215b23 Sudip Mukherjee      2015-03-03  749  	par->index = index;
81dee67e215b23 Sudip Mukherjee      2015-03-03  750  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee      2015-03-03  751  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee      2015-03-03  752  
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  753  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  754  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  755  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  756  	 */
fdc234d85210d9 Benjamin Philip      2021-07-28  757  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport        2015-10-26  758  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport        2015-10-26  759  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee      2015-03-03  760  
cd33da26036ea5 Christopher Carbone  2022-08-23  761  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone  2022-08-23  762  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip      2021-07-26  763  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f Mike Rapoport        2015-10-26  764  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee      2015-03-03  765  
3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  766  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann    2023-11-27  767  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann        2016-11-09  768  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  769  
81dee67e215b23 Sudip Mukherjee      2015-03-03  770  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport        2015-10-26  771  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  772  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann    2023-11-27  773  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann    2023-11-27  774  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  775  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  776  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  777  	} else {
f7c8a046577e09 Thomas Zimmermann    2023-11-27  778  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  779  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  780  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  781  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  782  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  783  
81dee67e215b23 Sudip Mukherjee      2015-03-03  784  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @785  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee      2015-03-03  786  		if (index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  787  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee      2015-03-03  788  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  789  
81dee67e215b23 Sudip Mukherjee      2015-03-03  790  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  791  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  792  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee      2015-03-03  793  
db7fb3588ab492 Artem Lytkin         2026-02-23  794  		if (ret == 1 || ret == 2)
81dee67e215b23 Sudip Mukherjee      2015-03-03  795  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  796  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  797  
81dee67e215b23 Sudip Mukherjee      2015-03-03  798  	/* set par */
81dee67e215b23 Sudip Mukherjee      2015-03-03  799  	par->info = info;
81dee67e215b23 Sudip Mukherjee      2015-03-03  800  
81dee67e215b23 Sudip Mukherjee      2015-03-03  801  	/* set info */
e3a3f9f5123683 Mike Rapoport        2015-10-26  802  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport        2015-10-26  803  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee      2015-03-03  804  
81dee67e215b23 Sudip Mukherjee      2015-03-03  805  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip      2021-07-28  806  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee      2015-03-03  807  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee      2015-03-03  808  
81dee67e215b23 Sudip Mukherjee      2015-03-03  809  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee      2015-03-03  810  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee      2015-03-03  811  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  812  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  813  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  814  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  815  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee      2015-03-03  816  
8c475735085a7d Tim Wassink          2025-12-21  817  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee      2015-03-03  818  
fdc234d85210d9 Benjamin Philip      2021-07-28  819  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  820  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  821  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee      2015-03-03  822  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee      2015-03-03  823  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee      2015-03-03  824  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee      2015-03-03  825  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  826  	 */
81dee67e215b23 Sudip Mukherjee      2015-03-03  827  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  828  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee      2015-03-03  829  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport        2015-10-26  830  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f Mike Rapoport        2015-10-26  831  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f Matej Dujava         2020-04-30  832  
b610e1193a917f Matej Dujava         2020-04-30  833  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  834  
81dee67e215b23 Sudip Mukherjee      2015-03-03  835  	/* set var */
81dee67e215b23 Sudip Mukherjee      2015-03-03  836  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee      2015-03-03  837  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  838  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee      2015-03-03  839  
61c507cf652da1 Michel von Czettritz 2015-03-26  840  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz 2015-03-26  841  	if (ret < 0) {
fbab250eb51d6d Artem Lytkin         2026-02-07  842  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  843  		goto exit;
81dee67e215b23 Sudip Mukherjee      2015-03-03  844  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  845  
81dee67e215b23 Sudip Mukherjee      2015-03-03  846  exit:
81dee67e215b23 Sudip Mukherjee      2015-03-03  847  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  848  	return ret;
81dee67e215b23 Sudip Mukherjee      2015-03-03  849  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  850  
81dee67e215b23 Sudip Mukherjee      2015-03-03  851  /*	chip specific g_option configuration routine */
700591a9adc8b1 Mike Rapoport        2015-10-26  852  static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
81dee67e215b23 Sudip Mukherjee      2015-03-03  853  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  854  	char *opt;
81dee67e215b23 Sudip Mukherjee      2015-03-03  855  	int swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  856  
81dee67e215b23 Sudip Mukherjee      2015-03-03  857  	swap = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  858  
cc34db609ff98c Madhumitha Sundar    2026-01-27  859  	sm750_dev->init_parm.chip_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  860  	sm750_dev->init_parm.mem_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  861  	sm750_dev->init_parm.master_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  862  	sm750_dev->init_parm.powerMode = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  863  	sm750_dev->init_parm.setAllEngOff = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  864  	sm750_dev->init_parm.resetMemory = 1;
81dee67e215b23 Sudip Mukherjee      2015-03-03  865  
81dee67e215b23 Sudip Mukherjee      2015-03-03  866  	/* defaultly turn g_hwcursor on for both view */
81dee67e215b23 Sudip Mukherjee      2015-03-03  867  	g_hwcursor = 3;
81dee67e215b23 Sudip Mukherjee      2015-03-03  868  
81dee67e215b23 Sudip Mukherjee      2015-03-03  869  	if (!src || !*src) {
c56de0967a658c Elise Lennion        2016-10-31  870  		dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  871  		goto NO_PARAM;
81dee67e215b23 Sudip Mukherjee      2015-03-03  872  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  873  
0fa96e39279988 Sudip Mukherjee      2015-03-10  874  	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
c56de0967a658c Elise Lennion        2016-10-31  875  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
c56de0967a658c Elise Lennion        2016-10-31  876  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
81dee67e215b23 Sudip Mukherjee      2015-03-03  877  
144634a6b42146 Katie Dunne          2017-02-19  878  		if (!strncmp(opt, "swap", strlen("swap"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  879  			swap = 1;
144634a6b42146 Katie Dunne          2017-02-19  880  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  881  			sm750_dev->nocrt = 1;
144634a6b42146 Katie Dunne          2017-02-19  882  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  883  			sm750_dev->pnltype = SM750_DOUBLE_TFT;
144634a6b42146 Katie Dunne          2017-02-19  884  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  885  			sm750_dev->pnltype = SM750_DUAL_TFT;
144634a6b42146 Katie Dunne          2017-02-19  886  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  887  			sm750_dev->pnltype = SM750_24TFT;
144634a6b42146 Katie Dunne          2017-02-19  888  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  889  			g_hwcursor &= ~0x1;
144634a6b42146 Katie Dunne          2017-02-19  890  		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  891  			g_hwcursor &= ~0x2;
144634a6b42146 Katie Dunne          2017-02-19  892  		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  893  			g_hwcursor = 0;
144634a6b42146 Katie Dunne          2017-02-19  894  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  895  			if (!g_fbmode[0]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @896  				g_fbmode[0] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  897  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  898  					 "find fbmode0 : %s\n", g_fbmode[0]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  899  			} else if (!g_fbmode[1]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  900  				g_fbmode[1] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  901  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  902  					 "find fbmode1 : %s\n", g_fbmode[1]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  903  			} else {
c56de0967a658c Elise Lennion        2016-10-31  904  				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  905  			}
81dee67e215b23 Sudip Mukherjee      2015-03-03  906  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  907  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  908  
81dee67e215b23 Sudip Mukherjee      2015-03-03  909  NO_PARAM:
e359b6a863e19f Mike Rapoport        2015-10-26  910  	if (sm750_dev->revid != SM750LE_REVISION_ID) {
a3f92cc94c6126 Mike Rapoport        2016-01-17  911  		if (sm750_dev->fb_count > 1) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  912  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  913  				sm750_dev->dataflow = sm750_dual_swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  914  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  915  				sm750_dev->dataflow = sm750_dual_normal;
81dee67e215b23 Sudip Mukherjee      2015-03-03  916  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  917  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  918  				sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  919  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  920  				sm750_dev->dataflow = sm750_simul_pri;
81dee67e215b23 Sudip Mukherjee      2015-03-03  921  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  922  	} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  923  		/* SM750LE only have one crt channel */
1757d106a9ce8c Mike Rapoport        2015-10-26  924  		sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  925  		/* sm750le do not have complex attributes */
1757d106a9ce8c Mike Rapoport        2015-10-26  926  		sm750_dev->nocrt = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  927  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  928  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  929  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

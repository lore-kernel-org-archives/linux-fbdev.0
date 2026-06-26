Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DC381AF;
	Fri, 26 Jun 2026 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433362; cv=none; b=fi463qUTKGLCFE6+dNckajsfmLrsdDqkxHRK5w6LAhU7K+yPkZgbjuB7DRRFGN87isYe73RwkuqWJTELv58tXTbOo7PbvTwCv5LrHM4MWTlD3bHX3SbJG+gZ9Af/Dg2REEtCYHRVAYwSZ6ZMGXdoLh34oAwv4RIiKjyLCV7ldM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433362; c=relaxed/simple;
	bh=/YzvnUgMomeC9bfr7RZMmDdlB2HqRKl9n5FGfrXi5yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRQSSypOm+EpIjWCAfqPEt7/lLszUzTVLgOu421S3SppEVOmtl4pNw+LmE4dEmNSZjysM2nHSufzA7pIIDXexSak/KpIWaFTK1sUMV0wnsl7ONIem8ktolYfelLShund+lBUdHBtqoS6fmE+p0N9y950BrPVDQCJ75v2F1RAvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibNSASPA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibNSASPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782433360; x=1813969360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YzvnUgMomeC9bfr7RZMmDdlB2HqRKl9n5FGfrXi5yQ=;
  b=ibNSASPAWRhgtCqLfQJozvDK5seYmfcrTjlR9w8acuuQNLit6YoEDdei
   M3uaCiKgKsspvL7xAMNt/86tARTFaVmYtXFBDPJaAp2r/EvjrOztuJ+0f
   6mQz08a3VLgIYYAgv0KjfyxUyXJyqixwRUSo63c4K9hMbW5ohTj01n5ZT
   3/b7yX9MAVTPaqgf6SoSIWifAEG05pC4+PqbyHDK2IdIQyohxm1xePjjg
   fpmV5Gbnf9sS05olY+MiFdcoiJ5c2ZpKMqxMmb3xt9cNTvX4+YPtWNNND
   B8R5UOMiHYnlAsZJ4P6PJGXhMvircnu3s6PlbijWGGnb3K5LqtjH1JMt4
   w==;
X-CSE-ConnectionGUID: NBt6eIXxQS+nODibG6ASqg==
X-CSE-MsgGUID: jyVlCumxTjCmiekhZimREw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94619712"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="94619712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:22:40 -0700
X-CSE-ConnectionGUID: 0bJ9tS4lSTWSUjazD0/K4A==
X-CSE-MsgGUID: td0+kThGSiaQ99ftWBPUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="251823298"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2026 17:22:38 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcuL4-000000004fl-3zKz;
	Fri, 26 Jun 2026 00:22:34 +0000
Date: Fri, 26 Jun 2026 08:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: fix const pointer declaration
Message-ID: <202606260825.72C9EkKG-lkp@intel.com>
References: <20260625071348.132880-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625071348.132880-1-suryasaimadhu369@gmail.com>

Hi suryasaimadhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/suryasaimadhu/staging-sm750fb-fix-const-pointer-declaration/20260625-151537
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260625071348.132880-1-suryasaimadhu369%40gmail.com
patch subject: [PATCH] staging: sm750fb: fix const pointer declaration
config: i386-buildonly-randconfig-001-20260626 (https://download.01.org/0day-ci/archive/20260626/202606260825.72C9EkKG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260626/202606260825.72C9EkKG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606260825.72C9EkKG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_set_fbinfo':
>> drivers/staging/sm750fb/sm750.c:773:33: error: assignment of read-only location 'g_fbmode[index]'
     773 |                 g_fbmode[index] = g_def_fbmode;
         |                                 ^
   drivers/staging/sm750fb/sm750.c:775:41: error: assignment of read-only location 'g_fbmode[index]'
     775 |                         g_fbmode[index] = g_fbmode[0];
         |                                         ^
   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:884:45: error: assignment of read-only location 'g_fbmode[0]'
     884 |                                 g_fbmode[0] = opt;
         |                                             ^
   drivers/staging/sm750fb/sm750.c:888:45: error: assignment of read-only location 'g_fbmode[1]'
     888 |                                 g_fbmode[1] = opt;
         |                                             ^


vim +773 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  707  
81dee67e215b23 Sudip Mukherjee      2015-03-03  708  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  709  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  710  	int i;
81dee67e215b23 Sudip Mukherjee      2015-03-03  711  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport        2015-10-26  712  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  713  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  714  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  715  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  716  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  717  
81dee67e215b23 Sudip Mukherjee      2015-03-03  718  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  719  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee      2015-03-03  720  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  721  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d0856045f0e9fc Hungyu Lin           2026-04-01  722  	static const char * const fix_id[2] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  723  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee      2015-03-03  724  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  725  
81dee67e215b23 Sudip Mukherjee      2015-03-03  726  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee      2015-03-03  727  
81dee67e215b23 Sudip Mukherjee      2015-03-03  728  	ret = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  729  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport        2015-10-26  730  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  731  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  732  	output = &par->output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  733  	var = &info->var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  734  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  735  
81dee67e215b23 Sudip Mukherjee      2015-03-03  736  	/* set index */
81dee67e215b23 Sudip Mukherjee      2015-03-03  737  	par->index = index;
81dee67e215b23 Sudip Mukherjee      2015-03-03  738  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee      2015-03-03  739  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee      2015-03-03  740  
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  741  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  742  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  743  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  744  	 */
fdc234d85210d9 Benjamin Philip      2021-07-28  745  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport        2015-10-26  746  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport        2015-10-26  747  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee      2015-03-03  748  
cd33da26036ea5 Christopher Carbone  2022-08-23  749  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone  2022-08-23  750  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip      2021-07-26  751  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
f50b4602fea62f Jennifer Guo         2026-05-09  752  	crtc->cursor.vstart = sm750_dev->vmem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee      2015-03-03  753  
3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  754  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann    2023-11-27  755  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann        2016-11-09  756  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  757  
81dee67e215b23 Sudip Mukherjee      2015-03-03  758  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport        2015-10-26  759  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  760  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann    2023-11-27  761  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann    2023-11-27  762  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  763  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  764  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  765  	} else {
f7c8a046577e09 Thomas Zimmermann    2023-11-27  766  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  767  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  768  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  769  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  770  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  771  
81dee67e215b23 Sudip Mukherjee      2015-03-03  772  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @773  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee      2015-03-03  774  		if (index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  775  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee      2015-03-03  776  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  777  
81dee67e215b23 Sudip Mukherjee      2015-03-03  778  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  779  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  780  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee      2015-03-03  781  
db7fb3588ab492 Artem Lytkin         2026-02-23  782  		if (ret == 1 || ret == 2)
81dee67e215b23 Sudip Mukherjee      2015-03-03  783  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  784  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  785  
81dee67e215b23 Sudip Mukherjee      2015-03-03  786  	/* set par */
81dee67e215b23 Sudip Mukherjee      2015-03-03  787  	par->info = info;
81dee67e215b23 Sudip Mukherjee      2015-03-03  788  
81dee67e215b23 Sudip Mukherjee      2015-03-03  789  	/* set info */
e3a3f9f5123683 Mike Rapoport        2015-10-26  790  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport        2015-10-26  791  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee      2015-03-03  792  
81dee67e215b23 Sudip Mukherjee      2015-03-03  793  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip      2021-07-28  794  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee      2015-03-03  795  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee      2015-03-03  796  
81dee67e215b23 Sudip Mukherjee      2015-03-03  797  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee      2015-03-03  798  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee      2015-03-03  799  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  800  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  801  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  802  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  803  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee      2015-03-03  804  
8c475735085a7d Tim Wassink          2025-12-21  805  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee      2015-03-03  806  
fdc234d85210d9 Benjamin Philip      2021-07-28  807  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  808  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  809  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee      2015-03-03  810  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee      2015-03-03  811  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee      2015-03-03  812  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee      2015-03-03  813  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  814  	 */
81dee67e215b23 Sudip Mukherjee      2015-03-03  815  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  816  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee      2015-03-03  817  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport        2015-10-26  818  	fix->mmio_start = sm750_dev->vidreg_start;
e359b6a863e19f Mike Rapoport        2015-10-26  819  	fix->mmio_len = sm750_dev->vidreg_size;
b610e1193a917f Matej Dujava         2020-04-30  820  
b610e1193a917f Matej Dujava         2020-04-30  821  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  822  
81dee67e215b23 Sudip Mukherjee      2015-03-03  823  	/* set var */
81dee67e215b23 Sudip Mukherjee      2015-03-03  824  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee      2015-03-03  825  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  826  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee      2015-03-03  827  
61c507cf652da1 Michel von Czettritz 2015-03-26  828  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz 2015-03-26  829  	if (ret < 0) {
fbab250eb51d6d Artem Lytkin         2026-02-07  830  		dev_err(info->device, "Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  831  		goto exit;
81dee67e215b23 Sudip Mukherjee      2015-03-03  832  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  833  
81dee67e215b23 Sudip Mukherjee      2015-03-03  834  exit:
81dee67e215b23 Sudip Mukherjee      2015-03-03  835  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  836  	return ret;
81dee67e215b23 Sudip Mukherjee      2015-03-03  837  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  838  
81dee67e215b23 Sudip Mukherjee      2015-03-03  839  /*	chip specific g_option configuration routine */
700591a9adc8b1 Mike Rapoport        2015-10-26  840  static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
81dee67e215b23 Sudip Mukherjee      2015-03-03  841  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  842  	char *opt;
81dee67e215b23 Sudip Mukherjee      2015-03-03  843  	int swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  844  
81dee67e215b23 Sudip Mukherjee      2015-03-03  845  	swap = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  846  
cc34db609ff98c Madhumitha Sundar    2026-01-27  847  	sm750_dev->init_parm.chip_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  848  	sm750_dev->init_parm.mem_clk = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  849  	sm750_dev->init_parm.master_clk = 0;
45a337c12624fc Jennifer Guo         2026-05-09  850  	sm750_dev->init_parm.power_mode = 0;
cc34db609ff98c Madhumitha Sundar    2026-01-27  851  	sm750_dev->init_parm.setAllEngOff = 0;
45a337c12624fc Jennifer Guo         2026-05-09  852  	sm750_dev->init_parm.reset_memory = 1;
81dee67e215b23 Sudip Mukherjee      2015-03-03  853  
81dee67e215b23 Sudip Mukherjee      2015-03-03  854  	/* defaultly turn g_hwcursor on for both view */
81dee67e215b23 Sudip Mukherjee      2015-03-03  855  	g_hwcursor = 3;
81dee67e215b23 Sudip Mukherjee      2015-03-03  856  
81dee67e215b23 Sudip Mukherjee      2015-03-03  857  	if (!src || !*src) {
c56de0967a658c Elise Lennion        2016-10-31  858  		dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  859  		goto NO_PARAM;
81dee67e215b23 Sudip Mukherjee      2015-03-03  860  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  861  
0fa96e39279988 Sudip Mukherjee      2015-03-10  862  	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
c56de0967a658c Elise Lennion        2016-10-31  863  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
c56de0967a658c Elise Lennion        2016-10-31  864  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
81dee67e215b23 Sudip Mukherjee      2015-03-03  865  
144634a6b42146 Katie Dunne          2017-02-19  866  		if (!strncmp(opt, "swap", strlen("swap"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  867  			swap = 1;
144634a6b42146 Katie Dunne          2017-02-19  868  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
1757d106a9ce8c Mike Rapoport        2015-10-26  869  			sm750_dev->nocrt = 1;
144634a6b42146 Katie Dunne          2017-02-19  870  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  871  			sm750_dev->pnltype = SM750_DOUBLE_TFT;
144634a6b42146 Katie Dunne          2017-02-19  872  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  873  			sm750_dev->pnltype = SM750_DUAL_TFT;
144634a6b42146 Katie Dunne          2017-02-19  874  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
94c938a0c15863 Shubham Chakraborty  2026-04-07  875  			sm750_dev->pnltype = SM750_24TFT;
144634a6b42146 Katie Dunne          2017-02-19  876  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  877  			g_hwcursor &= ~0x1;
144634a6b42146 Katie Dunne          2017-02-19  878  		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  879  			g_hwcursor &= ~0x2;
144634a6b42146 Katie Dunne          2017-02-19  880  		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  881  			g_hwcursor = 0;
144634a6b42146 Katie Dunne          2017-02-19  882  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  883  			if (!g_fbmode[0]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @884  				g_fbmode[0] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  885  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  886  					 "find fbmode0 : %s\n", g_fbmode[0]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  887  			} else if (!g_fbmode[1]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  888  				g_fbmode[1] = opt;
cee9ba1c30d051 Abdul Rauf           2017-01-08  889  				dev_info(&sm750_dev->pdev->dev,
cee9ba1c30d051 Abdul Rauf           2017-01-08  890  					 "find fbmode1 : %s\n", g_fbmode[1]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  891  			} else {
c56de0967a658c Elise Lennion        2016-10-31  892  				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  893  			}
81dee67e215b23 Sudip Mukherjee      2015-03-03  894  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  895  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  896  
81dee67e215b23 Sudip Mukherjee      2015-03-03  897  NO_PARAM:
e359b6a863e19f Mike Rapoport        2015-10-26  898  	if (sm750_dev->revid != SM750LE_REVISION_ID) {
a3f92cc94c6126 Mike Rapoport        2016-01-17  899  		if (sm750_dev->fb_count > 1) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  900  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  901  				sm750_dev->dataflow = sm750_dual_swap;
81dee67e215b23 Sudip Mukherjee      2015-03-03  902  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  903  				sm750_dev->dataflow = sm750_dual_normal;
81dee67e215b23 Sudip Mukherjee      2015-03-03  904  		} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  905  			if (swap)
1757d106a9ce8c Mike Rapoport        2015-10-26  906  				sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  907  			else
1757d106a9ce8c Mike Rapoport        2015-10-26  908  				sm750_dev->dataflow = sm750_simul_pri;
81dee67e215b23 Sudip Mukherjee      2015-03-03  909  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  910  	} else {
81dee67e215b23 Sudip Mukherjee      2015-03-03  911  		/* SM750LE only have one crt channel */
1757d106a9ce8c Mike Rapoport        2015-10-26  912  		sm750_dev->dataflow = sm750_simul_sec;
81dee67e215b23 Sudip Mukherjee      2015-03-03  913  		/* sm750le do not have complex attributes */
1757d106a9ce8c Mike Rapoport        2015-10-26  914  		sm750_dev->nocrt = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  915  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  916  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  917  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

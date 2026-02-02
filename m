Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5D2D7DF6
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022958; cv=none; b=lMFabaef/lZbxheVaFXorlySc35Olo5XjbEzn6ZNRMSVvEHTGatS2fT/7qdQonbXsZvBbx72DHuu4DDwxUegRX7CIcjszgTs8JgVpxHZFMuL2DNFCAapb1UX8IaQme40F5gYn1TkaaH2aLvrZFqMJX8Y5BWPbqfEDrTZVz2pMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022958; c=relaxed/simple;
	bh=y6eQlkCCz8V80w2JCLSs7G77L7RIf0augO69ad6i3g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLEpzgV+KAuUvBGaktEnde6f7nFtVdeckFJOEJIqBaHc53sunR3scB9tLfXvlgL27iMJqoBIbpcE1Pi7f/Rj8/rhHhkF2iFY/nwKa2K1W6eiilekkPCojsHyYALotaD21HnyrWB+rfA5XWFEhm8AT411n4qkVgtC3LrkRfiMYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd68LgRr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd68LgRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770022956; x=1801558956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y6eQlkCCz8V80w2JCLSs7G77L7RIf0augO69ad6i3g0=;
  b=gd68LgRry7pB2LO8tZf3usWVhItC25S7XvjX3/QIPJPjE4XtlzPTbpnz
   6Bf0N0w+msQMSPlKZvSAzBpGMl2p5bCgl7so967QauGwUmfSilYK5zDsA
   9Rb1CM7gRoV8SVWuR+VMTNBBnj1FOkeEItXtbsexu6bXZMhbun4UnmdL6
   eP1pgMBm5CrK6JuopuhfM4RIIzAGFtXNVkw5p0GH3V0P1ED7mZmgBA3ko
   OIu3ShbL+8cJfyDlldL4+ztwDOdIYWYHT1/UYRS54K35lYbE56Hf7IXGO
   FexERgpa/HKBVo0n8QPsGt3ZPDBw+kEsq0bBgGCSWF59lzgmGCjyLGNCJ
   w==;
X-CSE-ConnectionGUID: V7vsmttgQBGI9QBGU+vFLg==
X-CSE-MsgGUID: +yX4yt0oR46woEYgstMgNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82545175"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="82545175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 01:02:35 -0800
X-CSE-ConnectionGUID: WrIiLyKNTzqrk1MSAqMDig==
X-CSE-MsgGUID: Qw5kSUbaQeG1YLDinqplDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="214397114"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Feb 2026 01:02:32 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmppF-00000000fMq-0SkN;
	Mon, 02 Feb 2026 09:02:29 +0000
Date: Mon, 2 Feb 2026 17:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: James <supernitsuasnowpee@gmail.com>, sudipm.mukherjee@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
	James <supernitsuasnowpee@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array const
Message-ID: <202602021649.9bGhL8np-lkp@intel.com>
References: <20260202023253.67552-1-supernitsuasnowpee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202023253.67552-1-supernitsuasnowpee@gmail.com>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/James/staging-sm750fb-make-g_fbmode-array-const/20260202-103616
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260202023253.67552-1-supernitsuasnowpee%40gmail.com
patch subject: [PATCH] staging: sm750fb: make g_fbmode array const
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20260202/202602021649.9bGhL8np-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602021649.9bGhL8np-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602021649.9bGhL8np-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:795:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     795 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:797:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     797 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:958:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     958 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:962:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     962 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +795 drivers/staging/sm750fb/sm750.c

81dee67e215b23 Sudip Mukherjee      2015-03-03  722  
81dee67e215b23 Sudip Mukherjee      2015-03-03  723  static int lynxfb_set_fbinfo(struct fb_info *info, int index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  724  {
81dee67e215b23 Sudip Mukherjee      2015-03-03  725  	int i;
81dee67e215b23 Sudip Mukherjee      2015-03-03  726  	struct lynxfb_par *par;
e359b6a863e19f Mike Rapoport        2015-10-26  727  	struct sm750_dev *sm750_dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  728  	struct lynxfb_crtc *crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  729  	struct lynxfb_output *output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  730  	struct fb_var_screeninfo *var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  731  	struct fb_fix_screeninfo *fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  732  
81dee67e215b23 Sudip Mukherjee      2015-03-03  733  	const struct fb_videomode *pdb[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  734  		lynx750_ext, NULL, vesa_modes,
81dee67e215b23 Sudip Mukherjee      2015-03-03  735  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  736  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
d5d66cfea2ca28 Kelsey Skunberg      2019-04-27  737  	static const char * const mdb_desc[] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  738  		"driver prepared modes",
81dee67e215b23 Sudip Mukherjee      2015-03-03  739  		"kernel prepared default modedb",
81dee67e215b23 Sudip Mukherjee      2015-03-03  740  		"kernel HELPERS prepared vesa_modes",
81dee67e215b23 Sudip Mukherjee      2015-03-03  741  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  742  
8c475735085a7d Tim Wassink          2025-12-21  743  	static const char *fix_id[2] = {
81dee67e215b23 Sudip Mukherjee      2015-03-03  744  		"sm750_fb1", "sm750_fb2",
81dee67e215b23 Sudip Mukherjee      2015-03-03  745  	};
81dee67e215b23 Sudip Mukherjee      2015-03-03  746  
81dee67e215b23 Sudip Mukherjee      2015-03-03  747  	int ret, line_length;
81dee67e215b23 Sudip Mukherjee      2015-03-03  748  
81dee67e215b23 Sudip Mukherjee      2015-03-03  749  	ret = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  750  	par = (struct lynxfb_par *)info->par;
e359b6a863e19f Mike Rapoport        2015-10-26  751  	sm750_dev = par->dev;
81dee67e215b23 Sudip Mukherjee      2015-03-03  752  	crtc = &par->crtc;
81dee67e215b23 Sudip Mukherjee      2015-03-03  753  	output = &par->output;
81dee67e215b23 Sudip Mukherjee      2015-03-03  754  	var = &info->var;
81dee67e215b23 Sudip Mukherjee      2015-03-03  755  	fix = &info->fix;
81dee67e215b23 Sudip Mukherjee      2015-03-03  756  
81dee67e215b23 Sudip Mukherjee      2015-03-03  757  	/* set index */
81dee67e215b23 Sudip Mukherjee      2015-03-03  758  	par->index = index;
81dee67e215b23 Sudip Mukherjee      2015-03-03  759  	output->channel = &crtc->channel;
81dee67e215b23 Sudip Mukherjee      2015-03-03  760  	sm750fb_set_drv(par);
81dee67e215b23 Sudip Mukherjee      2015-03-03  761  
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  762  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  763  	 * set current cursor variable and proc pointer,
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  764  	 * must be set after crtc member initialized
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  765  	 */
fdc234d85210d9 Benjamin Philip      2021-07-28  766  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
e359b6a863e19f Mike Rapoport        2015-10-26  767  	crtc->cursor.mmio = sm750_dev->pvReg +
e359b6a863e19f Mike Rapoport        2015-10-26  768  		0x800f0 + (int)crtc->channel * 0x140;
81dee67e215b23 Sudip Mukherjee      2015-03-03  769  
81dee67e215b23 Sudip Mukherjee      2015-03-03  770  	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
cd33da26036ea5 Christopher Carbone  2022-08-23  771  	crtc->cursor.max_h = 64;
cd33da26036ea5 Christopher Carbone  2022-08-23  772  	crtc->cursor.max_w = 64;
39f9137268ee3d Benjamin Philip      2021-07-26  773  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
e359b6a863e19f Mike Rapoport        2015-10-26  774  	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
81dee67e215b23 Sudip Mukherjee      2015-03-03  775  
3de08a2d14ff8c Lorenzo Stoakes      2015-03-20  776  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
f7c8a046577e09 Thomas Zimmermann    2023-11-27  777  	if (!g_hwcursor)
52d0744d751d8f Arnd Bergmann        2016-11-09  778  		sm750_hw_cursor_disable(&crtc->cursor);
81dee67e215b23 Sudip Mukherjee      2015-03-03  779  
81dee67e215b23 Sudip Mukherjee      2015-03-03  780  	/* set info->fbops, must be set before fb_find_mode */
e359b6a863e19f Mike Rapoport        2015-10-26  781  	if (!sm750_dev->accel_off) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  782  		/* use 2d acceleration */
f7c8a046577e09 Thomas Zimmermann    2023-11-27  783  		if (!g_hwcursor)
f7c8a046577e09 Thomas Zimmermann    2023-11-27  784  			info->fbops = &lynxfb_ops_accel;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  785  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  786  			info->fbops = &lynxfb_ops_accel_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  787  	} else {
f7c8a046577e09 Thomas Zimmermann    2023-11-27  788  		if (!g_hwcursor)
81dee67e215b23 Sudip Mukherjee      2015-03-03  789  			info->fbops = &lynxfb_ops;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  790  		else
f7c8a046577e09 Thomas Zimmermann    2023-11-27  791  			info->fbops = &lynxfb_ops_with_cursor;
f7c8a046577e09 Thomas Zimmermann    2023-11-27  792  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  793  
81dee67e215b23 Sudip Mukherjee      2015-03-03  794  	if (!g_fbmode[index]) {
81dee67e215b23 Sudip Mukherjee      2015-03-03 @795  		g_fbmode[index] = g_def_fbmode;
81dee67e215b23 Sudip Mukherjee      2015-03-03  796  		if (index)
81dee67e215b23 Sudip Mukherjee      2015-03-03  797  			g_fbmode[index] = g_fbmode[0];
81dee67e215b23 Sudip Mukherjee      2015-03-03  798  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  799  
81dee67e215b23 Sudip Mukherjee      2015-03-03  800  	for (i = 0; i < 3; i++) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  801  		ret = fb_find_mode(var, info, g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  802  				   pdb[i], cdb[i], NULL, 8);
81dee67e215b23 Sudip Mukherjee      2015-03-03  803  
81dee67e215b23 Sudip Mukherjee      2015-03-03  804  		if (ret == 1) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  805  			pr_info("success! use specified mode:%s in %s\n",
81dee67e215b23 Sudip Mukherjee      2015-03-03  806  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  807  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  808  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  809  		} else if (ret == 2) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  810  			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
81dee67e215b23 Sudip Mukherjee      2015-03-03  811  				g_fbmode[index],
81dee67e215b23 Sudip Mukherjee      2015-03-03  812  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  813  			break;
81dee67e215b23 Sudip Mukherjee      2015-03-03  814  		} else if (ret == 3) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  815  			pr_warn("wanna use default mode\n");
4bd9503d0becdb Michel von Czettritz 2015-03-26  816  			/*break;*/
81dee67e215b23 Sudip Mukherjee      2015-03-03  817  		} else if (ret == 4) {
81dee67e215b23 Sudip Mukherjee      2015-03-03  818  			pr_warn("fall back to any valid mode\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  819  		} else {
3318bb5e945f70 Michel von Czettritz 2015-03-26  820  			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
3318bb5e945f70 Michel von Czettritz 2015-03-26  821  				ret,
3318bb5e945f70 Michel von Czettritz 2015-03-26  822  				mdb_desc[i]);
81dee67e215b23 Sudip Mukherjee      2015-03-03  823  		}
81dee67e215b23 Sudip Mukherjee      2015-03-03  824  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  825  
81dee67e215b23 Sudip Mukherjee      2015-03-03  826  	/* some member of info->var had been set by fb_find_mode */
81dee67e215b23 Sudip Mukherjee      2015-03-03  827  
271dbae3c6a1da Prasant Jalan        2017-04-01  828  	pr_info("Member of info->var is :\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  829  		"xres=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  830  		"yres=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  831  		"xres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  832  		"yres_virtual=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  833  		"xoffset=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  834  		"yoffset=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  835  		"bits_per_pixel=%d\n"
271dbae3c6a1da Prasant Jalan        2017-04-01  836  		" ...\n",
3318bb5e945f70 Michel von Czettritz 2015-03-26  837  		var->xres,
3318bb5e945f70 Michel von Czettritz 2015-03-26  838  		var->yres,
3318bb5e945f70 Michel von Czettritz 2015-03-26  839  		var->xres_virtual,
3318bb5e945f70 Michel von Czettritz 2015-03-26  840  		var->yres_virtual,
3318bb5e945f70 Michel von Czettritz 2015-03-26  841  		var->xoffset,
3318bb5e945f70 Michel von Czettritz 2015-03-26  842  		var->yoffset,
3318bb5e945f70 Michel von Czettritz 2015-03-26  843  		var->bits_per_pixel);
81dee67e215b23 Sudip Mukherjee      2015-03-03  844  
81dee67e215b23 Sudip Mukherjee      2015-03-03  845  	/* set par */
81dee67e215b23 Sudip Mukherjee      2015-03-03  846  	par->info = info;
81dee67e215b23 Sudip Mukherjee      2015-03-03  847  
81dee67e215b23 Sudip Mukherjee      2015-03-03  848  	/* set info */
e3a3f9f5123683 Mike Rapoport        2015-10-26  849  	line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
e3a3f9f5123683 Mike Rapoport        2015-10-26  850  			    crtc->line_pad);
81dee67e215b23 Sudip Mukherjee      2015-03-03  851  
81dee67e215b23 Sudip Mukherjee      2015-03-03  852  	info->pseudo_palette = &par->pseudo_palette[0];
cc59bde1c920ab Benjamin Philip      2021-07-28  853  	info->screen_base = crtc->v_screen;
81dee67e215b23 Sudip Mukherjee      2015-03-03  854  	pr_debug("screen_base vaddr = %p\n", info->screen_base);
81dee67e215b23 Sudip Mukherjee      2015-03-03  855  	info->screen_size = line_length * var->yres_virtual;
81dee67e215b23 Sudip Mukherjee      2015-03-03  856  
81dee67e215b23 Sudip Mukherjee      2015-03-03  857  	/* set info->fix */
81dee67e215b23 Sudip Mukherjee      2015-03-03  858  	fix->type = FB_TYPE_PACKED_PIXELS;
81dee67e215b23 Sudip Mukherjee      2015-03-03  859  	fix->type_aux = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  860  	fix->xpanstep = crtc->xpanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  861  	fix->ypanstep = crtc->ypanstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  862  	fix->ywrapstep = crtc->ywrapstep;
81dee67e215b23 Sudip Mukherjee      2015-03-03  863  	fix->accel = FB_ACCEL_SMI;
81dee67e215b23 Sudip Mukherjee      2015-03-03  864  
8c475735085a7d Tim Wassink          2025-12-21  865  	strscpy(fix->id, fix_id[index], sizeof(fix->id));
81dee67e215b23 Sudip Mukherjee      2015-03-03  866  
fdc234d85210d9 Benjamin Philip      2021-07-28  867  	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
81dee67e215b23 Sudip Mukherjee      2015-03-03  868  	pr_info("fix->smem_start = %lx\n", fix->smem_start);
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  869  	/*
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  870  	 * according to mmap experiment from user space application,
81dee67e215b23 Sudip Mukherjee      2015-03-03  871  	 * fix->mmio_len should not larger than virtual size
81dee67e215b23 Sudip Mukherjee      2015-03-03  872  	 * (xres_virtual x yres_virtual x ByPP)
81dee67e215b23 Sudip Mukherjee      2015-03-03  873  	 * Below line maybe buggy when user mmap fb dev node and write
81dee67e215b23 Sudip Mukherjee      2015-03-03  874  	 * data into the bound over virtual size
d11ac7cbcc266c Sudip Mukherjee      2015-08-07  875  	 */
81dee67e215b23 Sudip Mukherjee      2015-03-03  876  	fix->smem_len = crtc->vidmem_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  877  	pr_info("fix->smem_len = %x\n", fix->smem_len);
81dee67e215b23 Sudip Mukherjee      2015-03-03  878  	info->screen_size = fix->smem_len;
81dee67e215b23 Sudip Mukherjee      2015-03-03  879  	fix->line_length = line_length;
e359b6a863e19f Mike Rapoport        2015-10-26  880  	fix->mmio_start = sm750_dev->vidreg_start;
81dee67e215b23 Sudip Mukherjee      2015-03-03  881  	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
e359b6a863e19f Mike Rapoport        2015-10-26  882  	fix->mmio_len = sm750_dev->vidreg_size;
81dee67e215b23 Sudip Mukherjee      2015-03-03  883  	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
b610e1193a917f Matej Dujava         2020-04-30  884  
b610e1193a917f Matej Dujava         2020-04-30  885  	lynxfb_set_visual_mode(info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  886  
81dee67e215b23 Sudip Mukherjee      2015-03-03  887  	/* set var */
81dee67e215b23 Sudip Mukherjee      2015-03-03  888  	var->activate = FB_ACTIVATE_NOW;
81dee67e215b23 Sudip Mukherjee      2015-03-03  889  	var->accel_flags = 0;
81dee67e215b23 Sudip Mukherjee      2015-03-03  890  	var->vmode = FB_VMODE_NONINTERLACED;
81dee67e215b23 Sudip Mukherjee      2015-03-03  891  
81dee67e215b23 Sudip Mukherjee      2015-03-03  892  	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee      2015-03-03  893  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee      2015-03-03  894  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee      2015-03-03  895  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee      2015-03-03  896  
61c507cf652da1 Michel von Czettritz 2015-03-26  897  	ret = fb_alloc_cmap(&info->cmap, 256, 0);
61c507cf652da1 Michel von Czettritz 2015-03-26  898  	if (ret < 0) {
008272072d61a8 Masanari Iida        2015-05-28  899  		pr_err("Could not allocate memory for cmap.\n");
81dee67e215b23 Sudip Mukherjee      2015-03-03  900  		goto exit;
81dee67e215b23 Sudip Mukherjee      2015-03-03  901  	}
81dee67e215b23 Sudip Mukherjee      2015-03-03  902  
81dee67e215b23 Sudip Mukherjee      2015-03-03  903  	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
81dee67e215b23 Sudip Mukherjee      2015-03-03  904  		 info->cmap.start, info->cmap.len,
81dee67e215b23 Sudip Mukherjee      2015-03-03  905  		 info->cmap.red, info->cmap.green, info->cmap.blue,
81dee67e215b23 Sudip Mukherjee      2015-03-03  906  		 info->cmap.transp);
81dee67e215b23 Sudip Mukherjee      2015-03-03  907  
81dee67e215b23 Sudip Mukherjee      2015-03-03  908  exit:
81dee67e215b23 Sudip Mukherjee      2015-03-03  909  	lynxfb_ops_check_var(var, info);
81dee67e215b23 Sudip Mukherjee      2015-03-03  910  	return ret;
81dee67e215b23 Sudip Mukherjee      2015-03-03  911  }
81dee67e215b23 Sudip Mukherjee      2015-03-03  912  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

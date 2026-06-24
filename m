Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAA30C150;
	Wed, 24 Jun 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782261842; cv=none; b=trhoJYso/2KGyyQb+9qLDnQsa1dtnBMnU6dlbHWIVuBTWM1BuG3iaDnkhqRTtKCOJVOxHk1fnD4OJX7Utrz+e+S0wA+KcFlGYq+rEpQA6xWcCHIdWCVDJHIqV0wYr/5kUyZH/z7nLKMe2C1j6S+BxHcTwaLG017fAmr5fTNiG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782261842; c=relaxed/simple;
	bh=0kJgBdQZwqTp6CCPuGIVCZDVrN5TpaPVbyPSlpqbtH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGAM8viVTQml4nKKv6LfvPWu9iLjK7NeCHqCsXQMY7BMc6lxxJhON8APFMpSkvKS+3xfajhogqYPT0pFIqF9/urL+6F8Wb4b9J582yp7eIB56D0C6eed0lUG5NZys7jr79dtNKBCr8ML5L9g74Ji1Wyz8dNj3Wo74ZV/pHR4B+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8k23vh4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8k23vh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782261841; x=1813797841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0kJgBdQZwqTp6CCPuGIVCZDVrN5TpaPVbyPSlpqbtH0=;
  b=h8k23vh4toY/ox9Ydy//A3qVtHUli0J5tkdwOWraXQIoeEHaZUAmp2W1
   Yy+/hks2QMXRf4NThpnACJyeF1JMPSvnRxaO3Mh+tbpB39ckmlJnUSmPD
   gtOwX062kLSrIyfjSfjucXKekPmZEHh4/VseV921nLBXt0DzUBu6c6l9k
   YIx8YlOq93/Z6bDpt4oIfIgI7ckS3nweh8fIr+q2fZcKYz5qyEAECeWnG
   DtPWIXHrgEDSysPoe97t2PlGBL7DymLftgbtRUUgPKEmW2nKm5ZTQky08
   vN7sUxIxa79hLpIWLggntSPal7yKTXrdnhZPxWPocO56EQZhGBOlIgnXA
   w==;
X-CSE-ConnectionGUID: 4pyaoAQqTKKn1wLSDHZf8g==
X-CSE-MsgGUID: L2bXEdFGRTWX6pLr2e2Xwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82898962"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82898962"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 17:44:00 -0700
X-CSE-ConnectionGUID: oR+PeYKnQUSTfgz9f7Npzg==
X-CSE-MsgGUID: QoriA6SrRkC8nw8w5ASfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248776199"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Jun 2026 17:43:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcBic-0000000031p-3q05;
	Wed, 24 Jun 2026 00:43:54 +0000
Date: Wed, 24 Jun 2026 08:43:00 +0800
From: kernel test robot <lkp@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [staging] staging: sm750fb: rename pvMem to vram and pvReg to reg
Message-ID: <202606240823.hWXfYyPf-lkp@intel.com>
References: <20260621045050.63460-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621045050.63460-1-kapoorarnav43@gmail.com>

Hi Arnav,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-linus]
[also build test ERROR on v7.1]
[cannot apply to staging/staging-testing staging/staging-next linus/master next-20260623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnav-Kapoor/staging-sm750fb-rename-pvMem-to-vram-and-pvReg-to-reg/20260622-235607
base:   staging/staging-linus
patch link:    https://lore.kernel.org/r/20260621045050.63460-1-kapoorarnav43%40gmail.com
patch subject: [staging] staging: sm750fb: rename pvMem to vram and pvReg to reg
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260624/202606240823.hWXfYyPf-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606240823.hWXfYyPf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606240823.hWXfYyPf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:625:31: error: no member named 'vram' in 'struct sm750_dev'
     625 |                 crtc->v_screen = sm750_dev->vram;
         |                                  ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:631:31: error: no member named 'vram' in 'struct sm750_dev'
     631 |                 crtc->v_screen = sm750_dev->vram;
         |                                  ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:638:32: error: no member named 'vram' in 'struct sm750_dev'
     638 |                         crtc->v_screen = sm750_dev->vram;
         |                                          ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:644:32: error: no member named 'vram' in 'struct sm750_dev'
     644 |                         crtc->v_screen = sm750_dev->vram + crtc->o_screen;
         |                                          ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:652:32: error: no member named 'vram' in 'struct sm750_dev'
     652 |                         crtc->v_screen = sm750_dev->vram;
         |                                          ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:660:32: error: no member named 'vram' in 'struct sm750_dev'
     660 |                         crtc->v_screen = sm750_dev->vram + crtc->o_screen;
         |                                          ~~~~~~~~~  ^
>> drivers/staging/sm750fb/sm750.c:758:33: error: no member named 'reg' in 'struct sm750_dev'
     758 |         crtc->cursor.mmio = sm750_dev->reg +
         |                             ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:764:35: error: no member named 'vram' in 'struct sm750_dev'
     764 |         crtc->cursor.vstart = sm750_dev->vram + crtc->cursor.offset;
         |                               ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:1031:23: error: no member named 'vram' in 'struct sm750_dev'
    1031 |         memset_io(sm750_dev->vram, 0, sm750_dev->vidmem_size);
         |                   ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:1062:21: error: no member named 'reg' in 'struct sm750_dev'
    1062 |         iounmap(sm750_dev->reg);
         |                 ~~~~~~~~~  ^
   drivers/staging/sm750fb/sm750.c:1063:21: error: no member named 'vram' in 'struct sm750_dev'
    1063 |         iounmap(sm750_dev->vram);
         |                 ~~~~~~~~~  ^
   11 errors generated.


vim +625 drivers/staging/sm750fb/sm750.c

   591	
   592	static int sm750fb_set_drv(struct lynxfb_par *par)
   593	{
   594		int ret;
   595		struct sm750_dev *sm750_dev;
   596		struct lynxfb_output *output;
   597		struct lynxfb_crtc *crtc;
   598	
   599		ret = 0;
   600	
   601		sm750_dev = par->dev;
   602		output = &par->output;
   603		crtc = &par->crtc;
   604	
   605		crtc->vidmem_size = sm750_dev->vidmem_size;
   606		if (sm750_dev->fb_count > 1)
   607			crtc->vidmem_size >>= 1;
   608	
   609		/* setup crtc and output member */
   610		sm750_dev->hw_cursor = g_hwcursor;
   611	
   612		crtc->line_pad = 16;
   613		crtc->xpanstep = 8;
   614		crtc->ypanstep = 1;
   615		crtc->ywrapstep = 0;
   616	
   617		/* chip specific phase */
   618		sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
   619					    hw_sm750le_de_wait : hw_sm750_de_wait;
   620		switch (sm750_dev->dataflow) {
   621		case sm750_simul_pri:
   622			output->paths = sm750_pnc;
   623			crtc->channel = sm750_primary;
   624			crtc->o_screen = 0;
 > 625			crtc->v_screen = sm750_dev->vram;
   626			break;
   627		case sm750_simul_sec:
   628			output->paths = sm750_pnc;
   629			crtc->channel = sm750_secondary;
   630			crtc->o_screen = 0;
   631			crtc->v_screen = sm750_dev->vram;
   632			break;
   633		case sm750_dual_normal:
   634			if (par->index == 0) {
   635				output->paths = sm750_panel;
   636				crtc->channel = sm750_primary;
   637				crtc->o_screen = 0;
   638				crtc->v_screen = sm750_dev->vram;
   639			} else {
   640				output->paths = sm750_crt;
   641				crtc->channel = sm750_secondary;
   642				/* not consider of padding stuffs for o_screen,need fix */
   643				crtc->o_screen = sm750_dev->vidmem_size >> 1;
   644				crtc->v_screen = sm750_dev->vram + crtc->o_screen;
   645			}
   646			break;
   647		case sm750_dual_swap:
   648			if (par->index == 0) {
   649				output->paths = sm750_panel;
   650				crtc->channel = sm750_secondary;
   651				crtc->o_screen = 0;
   652				crtc->v_screen = sm750_dev->vram;
   653			} else {
   654				output->paths = sm750_crt;
   655				crtc->channel = sm750_primary;
   656				/* not consider of padding stuffs for o_screen,
   657				 * need fix
   658				 */
   659				crtc->o_screen = sm750_dev->vidmem_size >> 1;
   660				crtc->v_screen = sm750_dev->vram + crtc->o_screen;
   661			}
   662			break;
   663		default:
   664			ret = -EINVAL;
   665		}
   666	
   667		return ret;
   668	}
   669	
   670	static const struct fb_ops lynxfb_ops = {
   671		.owner = THIS_MODULE,
   672		FB_DEFAULT_IOMEM_OPS,
   673		.fb_check_var =  lynxfb_ops_check_var,
   674		.fb_set_par = lynxfb_ops_set_par,
   675		.fb_setcolreg = lynxfb_ops_setcolreg,
   676		.fb_blank = lynxfb_ops_blank,
   677		.fb_pan_display = lynxfb_ops_pan_display,
   678	};
   679	
   680	static const struct fb_ops lynxfb_ops_with_cursor = {
   681		.owner = THIS_MODULE,
   682		FB_DEFAULT_IOMEM_OPS,
   683		.fb_check_var =  lynxfb_ops_check_var,
   684		.fb_set_par = lynxfb_ops_set_par,
   685		.fb_setcolreg = lynxfb_ops_setcolreg,
   686		.fb_blank = lynxfb_ops_blank,
   687		.fb_pan_display = lynxfb_ops_pan_display,
   688		.fb_cursor = lynxfb_ops_cursor,
   689	};
   690	
   691	static const struct fb_ops lynxfb_ops_accel = {
   692		.owner = THIS_MODULE,
   693		__FB_DEFAULT_IOMEM_OPS_RDWR,
   694		.fb_check_var =  lynxfb_ops_check_var,
   695		.fb_set_par = lynxfb_ops_set_par,
   696		.fb_setcolreg = lynxfb_ops_setcolreg,
   697		.fb_blank = lynxfb_ops_blank,
   698		.fb_pan_display = lynxfb_ops_pan_display,
   699		.fb_fillrect = lynxfb_ops_fillrect,
   700		.fb_copyarea = lynxfb_ops_copyarea,
   701		.fb_imageblit = lynxfb_ops_imageblit,
   702		__FB_DEFAULT_IOMEM_OPS_MMAP,
   703	};
   704	
   705	static const struct fb_ops lynxfb_ops_accel_with_cursor = {
   706		.owner = THIS_MODULE,
   707		__FB_DEFAULT_IOMEM_OPS_RDWR,
   708		.fb_check_var =  lynxfb_ops_check_var,
   709		.fb_set_par = lynxfb_ops_set_par,
   710		.fb_setcolreg = lynxfb_ops_setcolreg,
   711		.fb_blank = lynxfb_ops_blank,
   712		.fb_pan_display = lynxfb_ops_pan_display,
   713		.fb_fillrect = lynxfb_ops_fillrect,
   714		.fb_copyarea = lynxfb_ops_copyarea,
   715		.fb_imageblit = lynxfb_ops_imageblit,
   716		.fb_cursor = lynxfb_ops_cursor,
   717		__FB_DEFAULT_IOMEM_OPS_MMAP,
   718	};
   719	
   720	static int lynxfb_set_fbinfo(struct fb_info *info, int index)
   721	{
   722		int i;
   723		struct lynxfb_par *par;
   724		struct sm750_dev *sm750_dev;
   725		struct lynxfb_crtc *crtc;
   726		struct lynxfb_output *output;
   727		struct fb_var_screeninfo *var;
   728		struct fb_fix_screeninfo *fix;
   729	
   730		const struct fb_videomode *pdb[] = {
   731			lynx750_ext, NULL, vesa_modes,
   732		};
   733		int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
   734		static const char *fix_id[2] = {
   735			"sm750_fb1", "sm750_fb2",
   736		};
   737	
   738		int ret, line_length;
   739	
   740		ret = 0;
   741		par = (struct lynxfb_par *)info->par;
   742		sm750_dev = par->dev;
   743		crtc = &par->crtc;
   744		output = &par->output;
   745		var = &info->var;
   746		fix = &info->fix;
   747	
   748		/* set index */
   749		par->index = index;
   750		output->channel = &crtc->channel;
   751		sm750fb_set_drv(par);
   752	
   753		/*
   754		 * set current cursor variable and proc pointer,
   755		 * must be set after crtc member initialized
   756		 */
   757		crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
 > 758		crtc->cursor.mmio = sm750_dev->reg +
   759			0x800f0 + (int)crtc->channel * 0x140;
   760	
   761		crtc->cursor.max_h = 64;
   762		crtc->cursor.max_w = 64;
   763		crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
   764		crtc->cursor.vstart = sm750_dev->vram + crtc->cursor.offset;
   765	
   766		memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
   767		if (!g_hwcursor)
   768			sm750_hw_cursor_disable(&crtc->cursor);
   769	
   770		/* set info->fbops, must be set before fb_find_mode */
   771		if (!sm750_dev->accel_off) {
   772			/* use 2d acceleration */
   773			if (!g_hwcursor)
   774				info->fbops = &lynxfb_ops_accel;
   775			else
   776				info->fbops = &lynxfb_ops_accel_with_cursor;
   777		} else {
   778			if (!g_hwcursor)
   779				info->fbops = &lynxfb_ops;
   780			else
   781				info->fbops = &lynxfb_ops_with_cursor;
   782		}
   783	
   784		if (!g_fbmode[index]) {
   785			g_fbmode[index] = g_def_fbmode;
   786			if (index)
   787				g_fbmode[index] = g_fbmode[0];
   788		}
   789	
   790		for (i = 0; i < 3; i++) {
   791			ret = fb_find_mode(var, info, g_fbmode[index],
   792					   pdb[i], cdb[i], NULL, 8);
   793	
   794			if (ret == 1 || ret == 2)
   795				break;
   796		}
   797	
   798		/* set par */
   799		par->info = info;
   800	
   801		/* set info */
   802		line_length = ALIGN((var->xres_virtual * var->bits_per_pixel / 8),
   803				    crtc->line_pad);
   804	
   805		info->pseudo_palette = &par->pseudo_palette[0];
   806		info->screen_base = crtc->v_screen;
   807		info->screen_size = line_length * var->yres_virtual;
   808	
   809		/* set info->fix */
   810		fix->type = FB_TYPE_PACKED_PIXELS;
   811		fix->type_aux = 0;
   812		fix->xpanstep = crtc->xpanstep;
   813		fix->ypanstep = crtc->ypanstep;
   814		fix->ywrapstep = crtc->ywrapstep;
   815		fix->accel = FB_ACCEL_SMI;
   816	
   817		strscpy(fix->id, fix_id[index], sizeof(fix->id));
   818	
   819		fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
   820		/*
   821		 * according to mmap experiment from user space application,
   822		 * fix->mmio_len should not larger than virtual size
   823		 * (xres_virtual x yres_virtual x ByPP)
   824		 * Below line maybe buggy when user mmap fb dev node and write
   825		 * data into the bound over virtual size
   826		 */
   827		fix->smem_len = crtc->vidmem_size;
   828		info->screen_size = fix->smem_len;
   829		fix->line_length = line_length;
   830		fix->mmio_start = sm750_dev->vidreg_start;
   831		fix->mmio_len = sm750_dev->vidreg_size;
   832	
   833		lynxfb_set_visual_mode(info);
   834	
   835		/* set var */
   836		var->activate = FB_ACTIVATE_NOW;
   837		var->accel_flags = 0;
   838		var->vmode = FB_VMODE_NONINTERLACED;
   839	
   840		ret = fb_alloc_cmap(&info->cmap, 256, 0);
   841		if (ret < 0) {
   842			dev_err(info->device, "Could not allocate memory for cmap.\n");
   843			goto exit;
   844		}
   845	
   846	exit:
   847		lynxfb_ops_check_var(var, info);
   848		return ret;
   849	}
   850	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

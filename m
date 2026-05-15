Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC9385539;
	Fri, 15 May 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884556; cv=none; b=pAa7McLSvSkhKS/ylhuIhEpecCyXeSNyFjEkKygcjleVDK3On1VesCzOcoU+59ghWcQOg6/9jbQp1xn/LZzJn6sLuaf65HXKOnzi9d7g0y95PSrEbFXpGaPKjTN8MBfoLrtslMTO/wfcOZZ8fU3WAc6WXOsKo4sXPZE3r8tHSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884556; c=relaxed/simple;
	bh=ZLma/H6ELmnkcoiyQ0o01HFGuCYj6H1K9UncyvKSe50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+IO58gpL9qR6QYLrng5vd/Xm34iPCCChH8NUgi5XRzQou/YAXL8G+Szz+hfIwXL4+jJL1vjsEs/U/dluRiy+jq48+1fqhGOFfKdJTL3JmhXIwPF94RuCVPbWk1gEGB9tYO7BxzHK85XHqN4Ky9oDkt141uUwM7yNCNC6GDDV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcjKnZg4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcjKnZg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778884555; x=1810420555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZLma/H6ELmnkcoiyQ0o01HFGuCYj6H1K9UncyvKSe50=;
  b=kcjKnZg4dL25Nt4vMRsRgPqe41ZY3cSVYs9L34BPppJcd2P4jhDThaXm
   ddwStflOnVoL2XFXGBxjmJcyae6DFOfx0pugbtI/ZuelJH3Brma13wtb9
   w7pRDLHz76QjP7yxE+zmJtaV0QXb/Z+nM/cZsghDYu9tu/SUaP6zMgyRb
   3e8dwily6YIob0L4Q6hhHLN8kDtZmAKeflAgHiHd6rM9/uR1vbcUTVXAL
   iHhc4+zOGgBx5IYVRTEOoZQ9h+5xuQtK04n1u0mzprrx6gku/yFChJeaY
   VgeWIbXJelrdjZT8zqvqDjV9VY0tltYX3oiSEFi23Sa05hIFNXEIHU2KZ
   A==;
X-CSE-ConnectionGUID: lpynC2T6RiSbXrCKCGBh3A==
X-CSE-MsgGUID: 6pff5jvHRYysTkw5/FHNKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90542475"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="90542475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:35:54 -0700
X-CSE-ConnectionGUID: xxC8lg0KTzuiZ9OQU4WCHg==
X-CSE-MsgGUID: 7mRHL75DTaK2Ki/HxjXdSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="269178747"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 May 2026 15:35:52 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wO18H-000000000BF-17wQ;
	Fri, 15 May 2026 22:35:49 +0000
Date: Sat, 16 May 2026 06:35:42 +0800
From: kernel test robot <lkp@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>, gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
Message-ID: <202605160624.pd29nXG5-lkp@intel.com>
References: <20260515103811.2808620-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515103811.2808620-1-zoone.rupert@gmail.com>

Hi Rupesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Rupesh-Majhi/staging-sm750-rename-CamelCase-variable-in-sm750-c/20260515-213450
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260515103811.2808620-1-zoone.rupert%40gmail.com
patch subject: [PATCH] staging: sm750: rename CamelCase variable in sm750.c
config: powerpc64-randconfig-002-20260516 (https://download.01.org/0day-ci/archive/20260516/202605160624.pd29nXG5-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605160624.pd29nXG5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605160624.pd29nXG5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:758:33: error: no member named 'pv_reg' in 'struct sm750_dev'
     758 |         crtc->cursor.mmio = sm750_dev->pv_reg +
         |                             ~~~~~~~~~  ^
>> drivers/staging/sm750fb/sm750.c:863:23: error: no member named 'set_all_eng_off' in 'struct init_status'
     863 |         sm750_dev->init_parm.set_all_eng_off = 0;
         |         ~~~~~~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:1062:21: error: no member named 'pv_reg' in 'struct sm750_dev'
    1062 |         iounmap(sm750_dev->pv_reg);
         |                 ~~~~~~~~~  ^
   3 errors generated.


vim +758 drivers/staging/sm750fb/sm750.c

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
   734		static const char * const fix_id[2] = {
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
 > 758		crtc->cursor.mmio = sm750_dev->pv_reg +
   759			0x800f0 + (int)crtc->channel * 0x140;
   760	
   761		crtc->cursor.max_h = 64;
   762		crtc->cursor.max_w = 64;
   763		crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
   764		crtc->cursor.vstart = sm750_dev->vmem + crtc->cursor.offset;
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
   851	/*	chip specific g_option configuration routine */
   852	static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
   853	{
   854		char *opt;
   855		int swap;
   856	
   857		swap = 0;
   858	
   859		sm750_dev->init_parm.chip_clk = 0;
   860		sm750_dev->init_parm.mem_clk = 0;
   861		sm750_dev->init_parm.master_clk = 0;
   862		sm750_dev->init_parm.power_mode = 0;
 > 863		sm750_dev->init_parm.set_all_eng_off = 0;
   864		sm750_dev->init_parm.reset_memory = 1;
   865	
   866		/* defaultly turn g_hwcursor on for both view */
   867		g_hwcursor = 3;
   868	
   869		if (!src || !*src) {
   870			dev_warn(&sm750_dev->pdev->dev, "no specific g_option.\n");
   871			goto NO_PARAM;
   872		}
   873	
   874		while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
   875			dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
   876			dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
   877	
   878			if (!strncmp(opt, "swap", strlen("swap"))) {
   879				swap = 1;
   880			} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
   881				sm750_dev->nocrt = 1;
   882			} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
   883				sm750_dev->pnltype = SM750_DOUBLE_TFT;
   884			} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
   885				sm750_dev->pnltype = SM750_DUAL_TFT;
   886			} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
   887				sm750_dev->pnltype = SM750_24TFT;
   888			} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
   889				g_hwcursor &= ~0x1;
   890			} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
   891				g_hwcursor &= ~0x2;
   892			} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
   893				g_hwcursor = 0;
   894			} else {
   895				if (!g_fbmode[0]) {
   896					g_fbmode[0] = opt;
   897					dev_info(&sm750_dev->pdev->dev,
   898						 "find fbmode0 : %s\n", g_fbmode[0]);
   899				} else if (!g_fbmode[1]) {
   900					g_fbmode[1] = opt;
   901					dev_info(&sm750_dev->pdev->dev,
   902						 "find fbmode1 : %s\n", g_fbmode[1]);
   903				} else {
   904					dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
   905				}
   906			}
   907		}
   908	
   909	NO_PARAM:
   910		if (sm750_dev->revid != SM750LE_REVISION_ID) {
   911			if (sm750_dev->fb_count > 1) {
   912				if (swap)
   913					sm750_dev->dataflow = sm750_dual_swap;
   914				else
   915					sm750_dev->dataflow = sm750_dual_normal;
   916			} else {
   917				if (swap)
   918					sm750_dev->dataflow = sm750_simul_sec;
   919				else
   920					sm750_dev->dataflow = sm750_simul_pri;
   921			}
   922		} else {
   923			/* SM750LE only have one crt channel */
   924			sm750_dev->dataflow = sm750_simul_sec;
   925			/* sm750le do not have complex attributes */
   926			sm750_dev->nocrt = 0;
   927		}
   928	}
   929	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

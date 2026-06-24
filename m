Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701217993;
	Wed, 24 Jun 2026 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271646; cv=none; b=ubXlgYQxxCFB8BesO43+/kbDzVQobZrA6E2hjkr1KXVsF4xNQzPjTduC0NEhO8X0cUGjRhdqt1fUWcm8Ld3OUmUumHqvA1Nz4lkjALUG7cmbe+Kbhu3p/KBUGcMCrvi89JKwFHXgjsoRlJkEx+y2SnJIacJOkpsPatog0bbeOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271646; c=relaxed/simple;
	bh=2SS3ol4ylJdY7CvZq08xhkuj5RZgxQvy20V6aDvoQac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAGhpXgLJX5eJ/fTq7sK8eEaZaLPXsGdo2SKPFmIm/BTeIDvzY2rugB55tuaLnzR1qOwlV9qucCI4rHhAr/5g5r/lAkJ4qSX6MrlQ7xW9ZxJZ+Ud16LCSxI0pjtqM52NWJ5CirWYFJOcSXSt7OCYco4XFpweYtnftd9Bb8pmp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXeVr+8R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXeVr+8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782271645; x=1813807645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SS3ol4ylJdY7CvZq08xhkuj5RZgxQvy20V6aDvoQac=;
  b=MXeVr+8RHOxParSdSqlvFLGxnkRYhs8IEkwSbxMeYWUkXiC0VfcPBXL5
   1bglD95ONhgawTT/EuFVCsl6C/qSUb9Yyr295LwohAW5F+3R9APpQp/bM
   C7oTg+mNmutkOWcKGZ96fnbW3kyq0OTXvFOCzt0eJ6ZMzv5e1ng0Mj/p9
   0d6RKEdAaeFxfHf9tvkevzQd01S2TL9dgMrfu5l8hUJgjx8IhpKH48T+t
   1cWkIthip2VuBLsXuumh3YW/2jwC38AnAt3OaT3eWL+UWg7G4nNUBsCem
   maQ4TSusGFlIlqKqBfJB/vt8rm4ljS870SQx7/ECE7dGhIDoIoBtvUu0f
   A==;
X-CSE-ConnectionGUID: jV6hARhHSLSXai2P5Bc7jQ==
X-CSE-MsgGUID: 9Y2VIh1QQ1GFctCAdw0bsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85578764"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="85578764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:27:24 -0700
X-CSE-ConnectionGUID: QJ9MHrLBQLuEAJi7Ow/kyg==
X-CSE-MsgGUID: G5PvuoVCQSKsJM4vqRFECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248803287"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Jun 2026 20:27:22 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcEGl-0000000035x-18lo;
	Wed, 24 Jun 2026 03:27:19 +0000
Date: Wed, 24 Jun 2026 11:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [staging] staging: sm750fb: fix remaining CamelCase issues
Message-ID: <202606241142.LlZq0AN1-lkp@intel.com>
References: <20260621045340.65872-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621045340.65872-1-kapoorarnav43@gmail.com>

Hi Arnav,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-linus]
[also build test ERROR on v7.1]
[cannot apply to staging/staging-testing staging/staging-next linus/master next-20260623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnav-Kapoor/staging-sm750fb-fix-remaining-CamelCase-issues/20260622-235207
base:   staging/staging-linus
patch link:    https://lore.kernel.org/r/20260621045340.65872-1-kapoorarnav43%40gmail.com
patch subject: [staging] staging: sm750fb: fix remaining CamelCase issues
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260624/202606241142.LlZq0AN1-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241142.LlZq0AN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241142.LlZq0AN1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'sm750fb_setup':
>> drivers/staging/sm750fb/sm750.c:862:30: error: 'struct init_status' has no member named 'power_mode'; did you mean 'powerMode'?
     862 |         sm750_dev->init_parm.power_mode = 0;
         |                              ^~~~~~~~~~
         |                              powerMode
>> drivers/staging/sm750fb/sm750.c:863:30: error: 'struct init_status' has no member named 'set_all_eng_off'; did you mean 'setAllEngOff'?
     863 |         sm750_dev->init_parm.set_all_eng_off = 0;
         |                              ^~~~~~~~~~~~~~~
         |                              setAllEngOff
>> drivers/staging/sm750fb/sm750.c:864:30: error: 'struct init_status' has no member named 'reset_memory'; did you mean 'resetMemory'?
     864 |         sm750_dev->init_parm.reset_memory = 1;
         |                              ^~~~~~~~~~~~
         |                              resetMemory
>> drivers/staging/sm750fb/sm750.c:883:46: error: 'SM750_DOUBLE_TFT' undeclared (first use in this function); did you mean 'sm750_doubleTFT'?
     883 |                         sm750_dev->pnltype = SM750_DOUBLE_TFT;
         |                                              ^~~~~~~~~~~~~~~~
         |                                              sm750_doubleTFT
   drivers/staging/sm750fb/sm750.c:883:46: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/sm750fb/sm750.c:885:46: error: 'SM750_DUAL_TFT' undeclared (first use in this function); did you mean 'sm750_dualTFT'?
     885 |                         sm750_dev->pnltype = SM750_DUAL_TFT;
         |                                              ^~~~~~~~~~~~~~
         |                                              sm750_dualTFT


vim +862 drivers/staging/sm750fb/sm750.c

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
 > 862		sm750_dev->init_parm.power_mode = 0;
 > 863		sm750_dev->init_parm.set_all_eng_off = 0;
 > 864		sm750_dev->init_parm.reset_memory = 1;
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
 > 883				sm750_dev->pnltype = SM750_DOUBLE_TFT;
   884			} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
 > 885				sm750_dev->pnltype = SM750_DUAL_TFT;
   886			} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
   887				sm750_dev->pnltype = sm750_24TFT;
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

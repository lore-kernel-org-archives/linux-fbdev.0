Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8A235364
	for <linux-fbdev@vger.kernel.org>; Fri, 15 Aug 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268987; cv=none; b=kmM54fELjoaLd/psHI5NWQBIgEetR8GjOAnB3ehsL4FNhaUyqSBwCstZKCGceDzM/jyMKC1oYuUzrlF+tzXRty2ehK1MdR+PZ2p88e85HUA8v7QqakI8WRxGenlGuuej9TvrjOO+4Td5I+DyTy/1ABJnNo+94i2kIelBM8hIUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268987; c=relaxed/simple;
	bh=PDbt4o4k4p5SM1Gt0+Fj01ep6nfTfi7vRmc73604jks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU65Sfsh1XXwGovjU5C4hqtniYWovbE77oyC9ZrHUBWFHzKHTi6IK+xb+vm4HRWJ1UWG6cF7A/KI3MIEHR7pbR9u+XXd7qyjxvl0JM/byf6kp9zaW9udrbtgXmEG213D7UKsbLzkB6NsxY0rMykkmivJad46SMkxoK/6IC7nVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhpAWIDx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhpAWIDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755268984; x=1786804984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDbt4o4k4p5SM1Gt0+Fj01ep6nfTfi7vRmc73604jks=;
  b=hhpAWIDx9MR1A1zuIo7dMr6EX6iFZUkTDou2nb1SD+ofwUGDQRl6suKU
   lmICYfnc0qwfQFQY4/gp1PbJrF7HwnagJQQKHV2bZisq3S0zNsMkSSi7y
   JUCjfAaGGyfBrjV17sYXEXsbapSgyO9D+LsWMfn8bf914G1eLIOQ8p//+
   ahNTaxs+QosGAKruC8J7N02DNLrtWnojNj9e11yElZc7it3ByZV1sOZs0
   e924cbu1/8L03tefDqCHV664r7Jd4Opldv3YrS4GfLXGZ1h0NvQ2/XBkq
   49CIzu+f+fUo2bbdmjK8aIw34McuUdhKuHWyeEHIpLFwSIUocjMmSKJLS
   g==;
X-CSE-ConnectionGUID: IhgoM3EKQ16e0ng0bSur6g==
X-CSE-MsgGUID: hA/zAie5SP2mbK+PPCnE4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57697495"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57697495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 07:43:04 -0700
X-CSE-ConnectionGUID: HDI3bAhtQse1u7hHErNCdw==
X-CSE-MsgGUID: WIzvz/EGQqij0YcCFKnAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167378577"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Aug 2025 07:43:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umvdw-000C2G-15;
	Fri, 15 Aug 2025 14:42:58 +0000
Date: Fri, 15 Aug 2025 22:41:59 +0800
From: kernel test robot <lkp@intel.com>
To: Willem Grant <willemgrant@mailfence.com>, linux-fbdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem Grant <willemgrant@mailfence.com>
Subject: Re: [PATCH] Cleared out formatting warnings/errors for
 drivers/staging/sm750fb
Message-ID: <202508152258.xosReYAn-lkp@intel.com>
References: <20250815011754.18078-1-willemgrant@mailfence.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815011754.18078-1-willemgrant@mailfence.com>

Hi Willem,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on staging/staging-next staging/staging-linus linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-Grant/Cleared-out-formatting-warnings-errors-for-drivers-staging-sm750fb/20250815-092113
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250815011754.18078-1-willemgrant%40mailfence.com
patch subject: [PATCH] Cleared out formatting warnings/errors for drivers/staging/sm750fb
config: arm-randconfig-002-20250815 (https://download.01.org/0day-ci/archive/20250815/202508152258.xosReYAn-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508152258.xosReYAn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508152258.xosReYAn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750.c:543:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     543 |                 red = gray;
         |                 ^
   drivers/staging/sm750fb/sm750.c:540:2: note: previous statement is here
     540 |         if (info->var.grayscale)
         |         ^
>> drivers/staging/sm750fb/sm750.c:541:7: warning: unused variable 'gray' [-Wunused-variable]
     541 |                 int gray = (red * 77 + green * 151 + blue * 28) >> 8;
         |                     ^~~~
   drivers/staging/sm750fb/sm750.c:543:9: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     543 |                 red = gray;
         |                       ^~~~
         |                       igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:544:11: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     544 |                 green = gray;
         |                         ^~~~
         |                         igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:545:10: error: use of undeclared identifier 'gray'; did you mean 'igrab'?
     545 |                 blue = gray;
         |                        ^~~~
         |                        igrab
   include/linux/fs.h:3313:23: note: 'igrab' declared here
    3313 | extern struct inode * igrab(struct inode *);
         |                       ^
   drivers/staging/sm750fb/sm750.c:794:19: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     794 |                 g_fbmode[index] = g_def_fbmode;
         |                 ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:796:20: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     796 |                         g_fbmode[index] = g_fbmode[0];
         |                         ~~~~~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:957:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     957 |                                 g_fbmode[0] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/sm750fb/sm750.c:961:17: error: cannot assign to variable 'g_fbmode' with const-qualified type 'const char *const[2]'
     961 |                                 g_fbmode[1] = opt;
         |                                 ~~~~~~~~~~~ ^
   drivers/staging/sm750fb/sm750.c:36:27: note: variable 'g_fbmode' declared const here
      36 | static const char * const g_fbmode[] = {NULL, NULL};
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings and 7 errors generated.


vim +/if +543 drivers/staging/sm750fb/sm750.c

   517	
   518	static int lynxfb_ops_setcolreg(unsigned int regno,
   519					unsigned int red,
   520					unsigned int green,
   521					unsigned int blue,
   522					unsigned int transp,
   523					struct fb_info *info)
   524	{
   525		struct lynxfb_par *par;
   526		struct lynxfb_crtc *crtc;
   527		struct fb_var_screeninfo *var;
   528		int ret;
   529	
   530		par = info->par;
   531		crtc = &par->crtc;
   532		var = &info->var;
   533		ret = 0;
   534	
   535		if (regno > 256) {
   536			pr_err("regno = %d\n", regno);
   537			return -EINVAL;
   538		}
   539	
   540		if (info->var.grayscale)
 > 541			int gray = (red * 77 + green * 151 + blue * 28) >> 8;
   542	
 > 543			red = gray;
   544			green = gray;
   545			blue = gray;
   546	
   547		if (var->bits_per_pixel == 8 &&
   548		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
   549			red >>= 8;
   550			green >>= 8;
   551			blue >>= 8;
   552			ret = hw_sm750_set_col_reg(crtc, regno, red, green, blue);
   553			goto exit;
   554		}
   555	
   556		if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 256) {
   557			u32 val;
   558	
   559			if (var->bits_per_pixel == 16 ||
   560			    var->bits_per_pixel == 32 ||
   561			    var->bits_per_pixel == 24) {
   562				val = chan_to_field(red, &var->red);
   563				val |= chan_to_field(green, &var->green);
   564				val |= chan_to_field(blue, &var->blue);
   565				par->pseudo_palette[regno] = val;
   566				goto exit;
   567			}
   568		}
   569	
   570		ret = -EINVAL;
   571	
   572	exit:
   573		return ret;
   574	}
   575	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

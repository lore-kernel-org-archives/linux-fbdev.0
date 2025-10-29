Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53F23C513;
	Wed, 29 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742174; cv=none; b=lzxKwrieLLJMhpNDMnMn0DLUzU1A9wNKESrUzvJctUZjmc2Kh6PDfjXHBG7HBN4d3lPIxwXIEIs1YTNr1BMzpvalQHs0WCCbx7aNc3VslxHPwYwzrQoL0aGIQ61U9HbXqJuKbPqgItSLT7FUt2WgZqMHbz2LepFItDZSo1sov8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742174; c=relaxed/simple;
	bh=HhgfBkD9obpAIcb9cqabm6VDny1KY5DjLfeLlwP3zn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETbhd6O2RTLtNotGQgx+ocE1tb6GabyKa3t+lRh4zvH046s9pIrIx2SdmH+vdoY7Mnv9Rym6xel0euu8/salZDvDyume1PhdQIq9vQJqNwYH1tjdEcQDaEFFZ18DpN/BLdXp0pGejvLZ+wtaOFvPNSbkBnTYpcxOqTh+udpAh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1aIR7DH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1aIR7DH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761742173; x=1793278173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhgfBkD9obpAIcb9cqabm6VDny1KY5DjLfeLlwP3zn8=;
  b=C1aIR7DHxu8Eh3+/uCeHrY7G532NU1ChgMilSncM7TEJkqph2UN82/J/
   IsmESV+ansmaKp6ajfqHTzfVEedSN07FtGqgCPHFruDOfowpNLEt883RF
   rOY3SWFWhv4rgeNTQZ39rd2fdh9W3/L9ENfzy25FPLXWleBSk4KTOXKae
   gUehIxLvc87PZBB81rEilqlWlaOMBJyLu7v3kECY2MUnGaEZbYEelLIso
   rQhbfdWLuuK+S3QVyHZOlswQ8SRU/Inot8gX4ekCgqYh90Pmu6lD1hMiX
   pdO1imua7//Z0iVNukYReIEIJgqBcK4gKhljZTYz8S+K7VmP5jaZVKhfn
   A==;
X-CSE-ConnectionGUID: m5j8P544RmOKrgwQjDwNiw==
X-CSE-MsgGUID: NFpR1vwJQEC+Tewq+c1qiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74537535"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74537535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:49:32 -0700
X-CSE-ConnectionGUID: BTudI+XZSJ6yLF1pYV4s4g==
X-CSE-MsgGUID: aMahW1C5SBuCuOV8RwHDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185353090"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2025 05:49:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE5cF-000KbL-0J;
	Wed, 29 Oct 2025 12:49:27 +0000
Date: Wed, 29 Oct 2025 20:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	sudip.mukherjee@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] staging: sm750fb: style fixes: align call and split
 chained assignment
Message-ID: <202510292010.GP8WnOne-lkp@intel.com>
References: <20251029022002.5812-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029022002.5812-1-cristiandelgobbo87@gmail.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Del-Gobbo/staging-sm750fb-style-fixes-align-call-and-split-chained-assignment/20251029-102311
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20251029022002.5812-1-cristiandelgobbo87%40gmail.com
patch subject: [PATCH v2] staging: sm750fb: style fixes: align call and split chained assignment
config: powerpc64-randconfig-002-20251029 (https://download.01.org/0day-ci/archive/20251029/202510292010.GP8WnOne-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292010.GP8WnOne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292010.GP8WnOne-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c:541:3: error: expected expression
     541 |                 int y = (red * 77 + green * 151 + blue * 28) >> 8;
         |                 ^
   drivers/staging/sm750fb/sm750.c:543:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     543 |                 red = y;
         |                 ^
   drivers/staging/sm750fb/sm750.c:540:2: note: previous statement is here
     540 |         if (info->var.grayscale)
         |         ^
>> drivers/staging/sm750fb/sm750.c:543:9: error: use of undeclared identifier 'y'
     543 |                 red = y;
         |                       ^
   drivers/staging/sm750fb/sm750.c:544:11: error: use of undeclared identifier 'y'
     544 |                 green = y;
         |                         ^
   drivers/staging/sm750fb/sm750.c:545:10: error: use of undeclared identifier 'y'
     545 |                 blue = y;
         |                        ^
   1 warning and 4 errors generated.


vim +/y +543 drivers/staging/sm750fb/sm750.c

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
   541			int y = (red * 77 + green * 151 + blue * 28) >> 8;
   542	
 > 543			red = y;
   544			green = y;
   545			blue = y;
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

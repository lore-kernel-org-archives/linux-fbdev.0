Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821766BFCB
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Feb 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385660; cv=none; b=lGNtkN0GTDhL/A7VCHcXqGCWLbybY/b/scAodtBSvjqiK+rg2UyI+x+uc6LnfhYXbGKmjfDp2SLTCKqboulNAdYh4IwU/fea77YaQh+ksypfYTYzjm6SL35drWEIIAN7m6z5qKbl0xR/7zryR4+ieyYGqmJoQIXZFQ2GeV/H8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385660; c=relaxed/simple;
	bh=B8cqTdsl61hbTwAme0/u6L8Z4DeauMK0xgKqDax73kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn3bgiOltt4mSZbK943uZuYcS+bfqIcSDUId0AepJUTtIgQ/EsBuD+OQApkC1tLqugiPugCkyndw7rNnTuTr0adDF8Fd7H2g4CTQ2qlBLOgtf+9dlEM8sSQKl5ur9CxlWQx2Cr/2LOOPQS97i5uA+mf96pxoPBZI8aTm34h3MyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTRp3018; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTRp3018"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707385659; x=1738921659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8cqTdsl61hbTwAme0/u6L8Z4DeauMK0xgKqDax73kI=;
  b=KTRp3018Rk526Wr9DHJktcCozpsd/VsS7Y7MZDtfBH3vTAqObXm+l/lK
   Gukqs8Udh1kTe8hUpyE0ajRaqFZnk5/KtzuPhyjkcDgZfRXQ83CPNZXMp
   uGvo2XVimE2ICkOFYOf6WmFppFTp5vsMBWByrTvrFDPAT1d6KiNQxBsvL
   Q9a80g/dAhyJVc4NbnLac/e41prFhBK7N3n6WfxO/TcSrPj6eHYMw/sxz
   gKNfz/tkXuZ5rgA19jujtw2iDX0biI8A/z2kiIL2iEJSeYFHKT/5FJJQL
   T3VoIKnfKgR417OrocORarmZdBrbL74yNgK88F4IeJAK6e1i6sEPxIMXg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="23663291"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="23663291"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1894976"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Feb 2024 01:47:35 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY10G-0003aQ-0h;
	Thu, 08 Feb 2024 09:47:32 +0000
Date: Thu, 8 Feb 2024 17:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
	sui.jingfeng@linux.dev, pjones@redhat.com, deller@gmx.de,
	ardb@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/8] firmware/sysfb: Set firmware-framebuffer parent
 device
Message-ID: <202402081758.cylLKURZ-lkp@intel.com>
References: <20240207134932.7321-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207134932.7321-4-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.8-rc3 next-20240208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/video-Add-helpers-for-decoding-screen_info/20240207-215100
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240207134932.7321-4-tzimmermann%40suse.de
patch subject: [PATCH v3 3/8] firmware/sysfb: Set firmware-framebuffer parent device
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240208/202402081758.cylLKURZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081758.cylLKURZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402081758.cylLKURZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/sysfb.c:36:
>> include/linux/sysfb.h:108:1: error: expected identifier or '('
     108 | {
         | ^
   1 error generated.


vim +108 include/linux/sysfb.h

e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  104  
9e121040e54abe include/linux/sysfb.h        Javier Martinez Canillas 2022-06-07  105  static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
c0a4e7e120d3e9 include/linux/sysfb.h        Thomas Zimmermann        2024-02-07  106  							    const struct simplefb_platform_data *mode,
c0a4e7e120d3e9 include/linux/sysfb.h        Thomas Zimmermann        2024-02-07  107  							    struct device *parent);
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02 @108  {
9e121040e54abe include/linux/sysfb.h        Javier Martinez Canillas 2022-06-07  109  	return ERR_PTR(-EINVAL);
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  110  }
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  111  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

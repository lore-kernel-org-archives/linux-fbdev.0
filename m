Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151E202990;
	Thu, 26 Jun 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972671; cv=none; b=kPruAzZvh2CSy0o9VcAaYD6wanVmNoPvgQzMT2Du/S/N9u+XYw1lTSlL97PMsavgAUYACM/cWtItnLDW+/9Ep24IoJk3+lSsxS9ZfFjXeM+7M03r4qBBuRETHcLhvBiD2k1t6em01nPVVCL0TW4LVd7qK/ijd+0dpCxiIwKxAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972671; c=relaxed/simple;
	bh=DPGbdcd9vclbsYIiVx5hqUl+jmswuth2sO6XH6ET4wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSKTKkHe/+NuE/1/tZgHwfFianyDTzFpypDu4z53v/bnzDyBfuS+tJHgDF7aGZBkTM52FUHdCBp6199q8nX8S0BRFXsm8YIIe5lKi0C6GTPaKm0Aiz3vuKSAT0X81v7T8M62vo4b2CZMF8cGwLgkLPK0A52AvgZNeBB2VnbbKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4Y/Z4Hl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4Y/Z4Hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750972670; x=1782508670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPGbdcd9vclbsYIiVx5hqUl+jmswuth2sO6XH6ET4wM=;
  b=R4Y/Z4HloCX3CG2JRq5fJJRhRzDVVrO2QzzRtlM9zUMByx2N0bl/gJAP
   +fiJabVBi6pOvplHs4Gk/Lm2t5FU23UZXbWMjF2V7wYda75rUPWrlIk7V
   iS0W3InuBKoA00tOTjqtITh+13s/2zyqRxQataIbiqhknQzcEoyNKjv14
   V9e/0DeaXMGvcbpxRrlCYURiO9qxNp3c9e0p9HE7u8mqoVk86hD1RLKBZ
   /FSmkX94luLALRGQetAWfoSFj3ttzGwxZIE8CeTgbVOSHj18drqmZUpQ+
   xqpkdcOiuugCcCTsMxp7sB3042wWG6GmvprhSnowKxGmTtqS24/1D32fX
   g==;
X-CSE-ConnectionGUID: I+V6tmzMRXC4xn2ny5pQCw==
X-CSE-MsgGUID: Tv/U0doUS5Ks/owoeupx6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53155804"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53155804"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 14:17:49 -0700
X-CSE-ConnectionGUID: 1Y6XCKs3TFm8z2bMPAl13w==
X-CSE-MsgGUID: NMU24re8RCaaocz74piHvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152799196"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2025 14:17:48 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUtyb-000VXu-0M;
	Thu, 26 Jun 2025 21:17:45 +0000
Date: Fri, 27 Jun 2025 05:17:43 +0800
From: kernel test robot <lkp@intel.com>
To: oushixiong1025@163.com, Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Peter Jones <pjones@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] fbdev: efifb: do not load efifb if PCI BAR has changed
 but not fixuped
Message-ID: <202506270544.iEP67RCm-lkp@intel.com>
References: <20250626094937.515552-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626094937.515552-1-oushixiong1025@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc3 next-20250626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong1025-163-com/fbdev-efifb-do-not-load-efifb-if-PCI-BAR-has-changed-but-not-fixuped/20250626-175111
base:   linus/master
patch link:    https://lore.kernel.org/r/20250626094937.515552-1-oushixiong1025%40163.com
patch subject: [PATCH] fbdev: efifb: do not load efifb if PCI BAR has changed but not fixuped
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250627/202506270544.iEP67RCm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270544.iEP67RCm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270544.iEP67RCm-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/video/console/dummycon.o: in function `screen_info_is_useful':
>> dummycon.c:(.text+0x90): multiple definition of `screen_info_is_useful'; arch/arm64/kernel/setup.o:setup.c:(.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

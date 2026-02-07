Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF72222582
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505502; cv=none; b=KfCsM6EP/yHZlAYeTvh2P841yMIROR9rtleCKNV5x4F/TId0Pwvvoi/vEFvj0n+an2Nl3Ejmkga29PxGAvGX82y6tFZ7D+jMqGuSy4cz+jpBsXCichpXqp5DDXqek6FTL0DIqHt/UXw9+gyX46zTtJnW2QhB/0YSYc4OkHVxzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505502; c=relaxed/simple;
	bh=m+VN/OQZTHSoYlmzSsExz3e9qfTXW1hXW9zeX8jPSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG38mAlUnWsMb/OA36eMjhS4rCIq4iGMZsmMHrgdPak4BUPeLHNSZFwt+WbVlQnh+tiWi37GWvHYs/gIfm0Th93e5FA72ZwQtQy7vSBQR9LG3+XDjhkYNvZRfaKVDOI98orYXwHcH3FB/WNQeQF9NV4roweSIm8niiT5DlY0jEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7GsxG/T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7GsxG/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770505501; x=1802041501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m+VN/OQZTHSoYlmzSsExz3e9qfTXW1hXW9zeX8jPSGQ=;
  b=d7GsxG/TaKAiwHbWe+/TwopRB2gEsNToSJAZSuJDHSYoHMQ+0roiRj6G
   +xNIPdVVU4gfQdQue85cXphqzHT7D+q+/Wl2PH6KEO5FCkEuhVv8mOgnr
   Ml0/aOGm2AujaCaYU7hObXTduCcUUr3swIn8IaBi+pwFKoRHZ7AWJ8mol
   ig6wATQsFmQeOyW9EFsS/l/ZLcz3IK4VuRfOvlFo/bojystpsWtCktTHA
   PLnzLSDvbLwUYE/MKU1+oKBBw946e3YC8xkQjiqLEcCJap3fjDkwj6PwK
   TDXTk79UAg+q65Ok1OvwjYJlGrCUgVz26Z64mi36mYNcUC/5ZPNvTVXoE
   g==;
X-CSE-ConnectionGUID: iB224qoaRYWeZ0H0W67GSw==
X-CSE-MsgGUID: N3dbzGkmSgKB2C1kyr5rHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="89247592"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="89247592"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 15:05:01 -0800
X-CSE-ConnectionGUID: lZph8QtEQs2QLXCGZ+6Yjw==
X-CSE-MsgGUID: Z0CVQe6TQC2j8UDwc+tYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="211023916"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Feb 2026 15:04:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vorMG-00000000lvw-2M0V;
	Sat, 07 Feb 2026 23:04:56 +0000
Date: Sun, 8 Feb 2026 07:04:01 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Helge Deller <deller@gmx.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] fbdev: au1100fb: Make driver compilable on
 non-mips platforms
Message-ID: <202602080617.eBFEo4gK-lkp@intel.com>
References: <b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0636e6205beed850d985276dc56fd73d785bea5c]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fbdev-au1100fb-Don-t-store-device-specific-data-in-global-variables/20260208-011505
base:   0636e6205beed850d985276dc56fd73d785bea5c
patch link:    https://lore.kernel.org/r/b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig%40baylibre.com
patch subject: [PATCH v2 4/4] fbdev: au1100fb: Make driver compilable on non-mips platforms
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260208/202602080617.eBFEo4gK-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602080617.eBFEo4gK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602080617.eBFEo4gK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/au1100fb.c:551:29: warning: unused variable 'fbregs' [-Wunused-variable]
     551 | static struct au1100fb_regs fbregs;
         |                             ^~~~~~
   1 warning generated.


vim +/fbregs +551 drivers/video/fbdev/au1100fb.c

^1da177e4c3f415 drivers/video/au1100fb.c Linus Torvalds   2005-04-16  549  
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26  550  #ifdef CONFIG_PM
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26 @551  static struct au1100fb_regs fbregs;
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26  552  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

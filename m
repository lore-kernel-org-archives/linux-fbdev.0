Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3ED33121D;
	Thu, 26 Feb 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149085; cv=none; b=rmLE2gPPB37W80C7dgFABLkDSt0DzC1PYzbFR9HgqYRtTuOsrfqBXk65bhkutCIb/epx0gziY2d8tQT5UWvOz80AwRw15Gq8D6IFEJfKPOxQ0tWKG0api8Dm06n0pBrAzueAkQqsYSq31EVyJXCDw6V/by+fri7xLmm3YDx+BqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149085; c=relaxed/simple;
	bh=ycrKLDU4IpRTv1hmXNWpEDbPGZFK9jRLJ8UpYmjOn3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbJNtmObOEYt/0fw9e6ZfU7dfT3ho0oYygzkJGlS4cl7UnUHdpq6eaZntKuM9vheVGade6QabHAiS1sCbo9UWqHdIyQCo+6+wdTzTOYXdAa4tVwZp6pvTKcDmxtRLBRaBGjM1HF0J/YHErTFZdrojdIwXWerU8wwEH0oRrhS1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aES+IuGY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aES+IuGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772149084; x=1803685084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycrKLDU4IpRTv1hmXNWpEDbPGZFK9jRLJ8UpYmjOn3w=;
  b=aES+IuGYDLEDHdGKcX+T8b63u7sfmyAlNr5De705Ez6746b5yUrqmwqG
   UNBUWvhkycx0ORa3aPk/vTjn5VaQzxcGrqX9DPc5NZ4Ii40HvAfZWiaan
   8Y+AZN0siDUwxyLkCCB+37pw3WpUfdxBqxKNpBkaMTatKoS7VQjfOke7k
   JZ/wKaQV4DkyyFovvKERwnno7Zh+xglPHCxaLROPSM2+yZNp3/nJCL42i
   9CcPkGpafauV2HWjsGl9AQZ2P9OKT/tJRxurHL4jilFGeDrSGqBY0AZXy
   1Z29WIjFOzEy4e8omFOC6QuduPyWzra8VL8s7seQxDhP76VAjI/lUPDoi
   Q==;
X-CSE-ConnectionGUID: Ab5dWzCrTBOwAFDrWnXhTw==
X-CSE-MsgGUID: okFAw6aTTGOQMpq1f9b4vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72433808"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="72433808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:38:04 -0800
X-CSE-ConnectionGUID: +Qj5ItRiRouYZ/kocrgejA==
X-CSE-MsgGUID: j7DXUfKnRi6gS8lI5hcXuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="220859566"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 15:37:58 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvkti-00000000A0R-3SDC;
	Thu, 26 Feb 2026 23:37:21 +0000
Date: Fri, 27 Feb 2026 07:35:08 +0800
From: kernel test robot <lkp@intel.com>
To: dhyan19022009@gmail.com, Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jason Donenfeld <Jason@zx2c4.com>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix macro whitespace errors
Message-ID: <202602270720.2J4j3gHF-lkp@intel.com>
References: <20260226172531.13714-1-dhyan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226172531.13714-1-dhyan19022009@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/dhyan19022009-gmail-com/staging-fbtft-fix-macro-whitespace-errors/20260227-021646
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260226172531.13714-1-dhyan19022009%40gmail.com
patch subject: [PATCH] staging: fbtft: fix macro whitespace errors
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260227/202602270720.2J4j3gHF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270720.2J4j3gHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270720.2J4j3gHF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:65:53: error: too few arguments provided to function-like macro invocation
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                                                     ^
   drivers/staging/fbtft/fbtft-bus.c:14:9: note: macro 'define_fbtft_write_reg' defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         |         ^
>> drivers/staging/fbtft/fbtft-bus.c:65:1: error: unknown type name 'define_fbtft_write_reg'
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         | ^
   drivers/staging/fbtft/fbtft-bus.c:67:57: error: too few arguments provided to function-like macro invocation
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                                                         ^
   drivers/staging/fbtft/fbtft-bus.c:14:9: note: macro 'define_fbtft_write_reg' defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         |         ^
   drivers/staging/fbtft/fbtft-bus.c:67:1: error: unknown type name 'define_fbtft_write_reg'
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         | ^
   4 errors generated.


vim +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

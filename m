Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AE1FDD;
	Sun, 14 Sep 2025 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757808638; cv=none; b=g4RoblqF0X6u8HSOdS7DE9kQK3h9glUR+i+oXcP6SQw7Nwq1H2xJ4uFe6FGod3mixR2Gu9iYsZpb5CE9TUhAzycWBPlPYcPJRhsfVM92KRRQCaurQdybExo3lFIThxD0gDTnPO/ZbeymHFzchu78iG6qDNCdIJ6xKz3ywJ7xLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757808638; c=relaxed/simple;
	bh=W9ZIOfyNi/P8gcrhWZeTBJmG0AG5kAWmh7vlYZSE3kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNNG6w/3iPKR64TF2oMFaWMYRVnIsnv9RX6YtU2LoLuDDlViTrABdYnLjJkJpWTe5PjxzgDXdHTbMutDQAV9kld2GEEm3oQ2b1GnQ3ELoUjiDNL2q/8VB0DecasR7ozLbh0n7FPOn0HtjYy3A65Z/jilOWFN32JkPVO2WRcWbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDCYYgsH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDCYYgsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757808636; x=1789344636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9ZIOfyNi/P8gcrhWZeTBJmG0AG5kAWmh7vlYZSE3kc=;
  b=XDCYYgsHttml7NPirvTJ70Y8KGDGpaatDcd6RnbrXCKoB9hm3qJd+UpJ
   larnMLHHbQFB6zaSMaWVa7SnZYnZdR2SkCCC2brDsM2KE39ziZCxl7YUn
   EaFqsOBkWRR/D0Kv4kW7pvbVmSFgP8lO5UChDLPfW/UaUEFHGevgLUwO7
   MHHFFdBofQjAGM5mHAiI7CRfWJjv4twAcDsgiD+y4xH/4gprRzbe0coG/
   oiHF32pfTOAeRhvkBLYeZGITcSkqNEqwswzV0Mb3dvhUXJ9ORNoe09YEf
   vQ2WnDy00bDILSjgl/MRJAfQqwMA1kEiMnRrETfkOsh8yT6lkpy47jrX+
   A==;
X-CSE-ConnectionGUID: IjOysGdoTiiab47TmL3GqQ==
X-CSE-MsgGUID: eZ84ADbzT32lCDcTPSS2bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="59805803"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="59805803"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 17:10:36 -0700
X-CSE-ConnectionGUID: cQy8dHMTQbid9or6wsK6Ig==
X-CSE-MsgGUID: NCueaxNrTeaxkfiIFBYUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="174749576"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 13 Sep 2025 17:10:34 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxaK8-0001xw-0a;
	Sun, 14 Sep 2025 00:10:32 +0000
Date: Sun, 14 Sep 2025 08:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Shay Power <shaythomaspower@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org,
	linux-fbdev@vger.kernel.org, Shay Power <shaythomaspower@gmail.com>
Subject: Re: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
Message-ID: <202509140751.ZWyZhali-lkp@intel.com>
References: <20250913210600.36986-1-shaythomaspower@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913210600.36986-1-shaythomaspower@gmail.com>

Hi Shay,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Shay-Power/staging-fbtft-fbtft-bus-remove-empty-macro-argument/20250914-050734
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250913210600.36986-1-shaythomaspower%40gmail.com
patch subject: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
config: arc-randconfig-002-20250914 (https://download.01.org/0day-ci/archive/20250914/202509140751.ZWyZhali-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509140751.ZWyZhali-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509140751.ZWyZhali-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:65:53: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                                                     ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
>> drivers/staging/fbtft/fbtft-bus.c:65:23: error: expected ';' before 'void'
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                       ^
         |                       ;
   drivers/staging/fbtft/fbtft-bus.c:67:57: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                                                         ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
   drivers/staging/fbtft/fbtft-bus.c:67:23: error: expected ';' before 'void'
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                       ^
         |                       ;
      68 | 
      69 | void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
         | ~~~~                   


vim +/define_fbtft_write_reg +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

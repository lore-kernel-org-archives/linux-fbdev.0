Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAC3E0224;
	Tue, 14 Apr 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167086; cv=none; b=QQ73R6RnOWM7Xnuz/Yxjwks5XZz92i2Fq/wrEa7JovMx54/XqONJFf8ZLcMW0hVdA/dI4y2XorKLVPezMB+ArhgLecWJGRas4gPF12UDzlbsl/a6FuGCLrbWjC27U/Ndv/KN+J5Xu8tZ7iWiUjfDu8FRGmmE6R79qj/7xqA8Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167086; c=relaxed/simple;
	bh=/uifXYhjkpn2JIQXVjganr+ngHnaC65t/JIBOoBeA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXTIuiqSSsRgcsk5dApV9ZVXUkiHjajqqA7Xxsl+XaZtbehfF/NnKGCqnBQlRHAhqRV8xGqLMxXmF7o+JVpFghEv0wIefRliTjNSGlB9DEPRdZgjn/7IyGnW+SSvcPd3fLxejdWDI7mtHg0R2Q3Stgzp+23rhzs1FT86MfjnZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSTPwk4Y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSTPwk4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776167084; x=1807703084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/uifXYhjkpn2JIQXVjganr+ngHnaC65t/JIBOoBeA2s=;
  b=eSTPwk4Ys48p22f0FooDaxOgVEzNZZ4Uae2lVUxsvBVxDgO4+CAtv5ud
   ZbgdFyV5lukVuSO2dR4YwJhGfWdpcomKF5T6DxUC810dr6e5V6474Xppu
   78LEHmDhbxvdQd5L83JwXxLk/I9bPd4YU5l8c9ZkX/samKskPmCMMzugO
   aCO0Y2jS38RdSelMUJYss2K8OsHEtHo8d3boO5/LyBPrs4ZJM7jtbMOC2
   pK1+RjKrFRV45RzBEp3NgjnTYS6auBvdtv8A1NXcdTq/EzeeXa+prVBM5
   Hq62Y4YhwpOfqpk7N/JEBj6aq0OuOXlQXMJRnmlNxHc5Zw3NAR+u4wiPu
   w==;
X-CSE-ConnectionGUID: Uvl++ka4RUGdED2L4n5+Yg==
X-CSE-MsgGUID: Bb8atBLURP+oUfcILaBW8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64656948"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64656948"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:44:41 -0700
X-CSE-ConnectionGUID: T3APFrp+ROWWVa0psOuu0g==
X-CSE-MsgGUID: ViKU/xG9TGy2574E8oN0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227419138"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Apr 2026 04:44:38 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCcC4-000000001PR-0SFf;
	Tue, 14 Apr 2026 11:44:36 +0000
Date: Tue, 14 Apr 2026 19:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Baker <mzndmzn@gmail.com>, andy@kernel.org, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Baker <mzndmzn@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Message-ID: <202604141939.LhzKrfey-lkp@intel.com>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412173317.3329-1-mzndmzn@gmail.com>

Hi Baker,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Baker/staging-fbtft-fix-coding-style-issue-in-fbtft-bus-c/20260414-101811
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260412173317.3329-1-mzndmzn%40gmail.com
patch subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
config: arm-randconfig-r072-20260414 (https://download.01.org/0day-ci/archive/20260414/202604141939.LhzKrfey-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260414/202604141939.LhzKrfey-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604141939.LhzKrfey-lkp@intel.com/

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

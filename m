Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E03D994
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218213; cv=none; b=TUUFjCTOzWrEVoAWSXMH/5uXfLRm1Q1UmVWXDRIU9LH1B0mcbsVq5zQhVrnUOli6IWwFGHNj0XAgZLYtJP0CEABximPFUnVQNcMvXmN4P55fReQAvPvqJebVeKccj9olsy+SS7a47NMIUlZmC8N3UOyXgzhHjt+ztqZdAS5ch8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218213; c=relaxed/simple;
	bh=LAS0EkVBgtrNL60SSrA5BOjIsofdR08gLvcrjcrN/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilUbkakqrFdtCSvnx8f8DFxpXgJStk3Na3Zo8fVNNaDydJ9IgP/sgIrWTjSFiSGqhqIRZvm3zXkNq624YmnDJMa2IFhcaYCHxDK123sqjwtBJnmrasslPUQmU+sOo8q4GM2kj3ObMMY1vEOT7KOGllubKYLI08O6Zp+XijpgR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caItZR+n; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caItZR+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770218213; x=1801754213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAS0EkVBgtrNL60SSrA5BOjIsofdR08gLvcrjcrN/r0=;
  b=caItZR+nAk+LdmkjMi2l0RSWfXrVhlbXNG5pjjGBWML+I1qYcUs7r9Fw
   JbOYj5Aaxb6RgRA8bHOujzsEuWBK9Ib81Wz7w1Vi1LrkJ/d3mRTd1OrI2
   gpC4yxY8ZAZD7ZdNz6lG/KTTuNN83gKLtS6NZPqmPr5e5NYBDc0NZiMx4
   L5F8fcqFVM7z4y2HRf+J3wFLeQnQi2aWweOPEbhXYrzmiLGoBTgGoUlPv
   akTUcYTrZVMN75xtpWAjNwI5XB22YcHav9gTfLIm5s9kgWsy2DFLvpcV6
   2owCtxN5G4H5+FUjYXQHRXf+LousvRwVqF7t/t6CELe7FMLx8rID/6iHG
   w==;
X-CSE-ConnectionGUID: 6BobUj6gTEiCIcLhKRfr8Q==
X-CSE-MsgGUID: kPWmoZYRSYWQfuSu8VM42A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71391213"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71391213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:16:52 -0800
X-CSE-ConnectionGUID: YsXuTrHrR5OvoMFxxH70BQ==
X-CSE-MsgGUID: d1cXLsZCSf2uiD2pONH8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="240967509"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Feb 2026 07:16:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vneca-00000000iLA-25QB;
	Wed, 04 Feb 2026 15:16:48 +0000
Date: Wed, 4 Feb 2026 23:16:23 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/3] fbdev: au1100fb: Make driver compilable on
 non-mips platforms
Message-ID: <202602042342.RXu7sDV7-lkp@intel.com>
References: <474eca0c9ecb8a2e610e82922ad22ad7e8ff0b8b.1770196161.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474eca0c9ecb8a2e610e82922ad22ad7e8ff0b8b.1770196161.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0636e6205beed850d985276dc56fd73d785bea5c]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fbdev-au1100fb-Mark-several-local-functions-as-static/20260204-171704
base:   0636e6205beed850d985276dc56fd73d785bea5c
patch link:    https://lore.kernel.org/r/474eca0c9ecb8a2e610e82922ad22ad7e8ff0b8b.1770196161.git.u.kleine-koenig%40baylibre.com
patch subject: [PATCH v1 2/3] fbdev: au1100fb: Make driver compilable on non-mips platforms
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260204/202602042342.RXu7sDV7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602042342.RXu7sDV7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602042342.RXu7sDV7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/au1100fb.c: In function 'au1100fb_fb_mmap':
   drivers/video/fbdev/au1100fb.c:354:39: error: lvalue required as left operand of assignment
     354 |         pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
         |                                       ^~
   In file included from include/asm-generic/bug.h:31,
                    from arch/s390/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from arch/s390/include/asm/cmpxchg.h:11,
                    from arch/s390/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/s390/include/asm/bitops.h:75,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23,
                    from include/linux/clk.h:13,
                    from drivers/video/fbdev/au1100fb.c:44:
   drivers/video/fbdev/au1100fb.c: In function 'au1100fb_drv_probe':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 2 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   drivers/video/fbdev/au1100fb.h:33:30: note: in expansion of macro 'printk'
      33 | #define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
         |                              ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   drivers/video/fbdev/au1100fb.h:33:37: note: in expansion of macro 'KERN_ERR'
      33 | #define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
         |                                     ^~~~~~~~
   drivers/video/fbdev/au1100fb.c:472:17: note: in expansion of macro 'print_err'
     472 |                 print_err("fail to allocate framebuffer (size: %dK))",
         |                 ^~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

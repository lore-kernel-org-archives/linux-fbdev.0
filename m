Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1622FE0A;
	Sat, 20 Dec 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766237758; cv=none; b=KWl5xXoP3tGCmOkZIgxptwLv9yne3rIHdI9QUG5oPTs0l023KR/dJQmLyWT/GtnQxUnty2iNsMDBX8lrtPn+YPNkriixyvIXdTMfbge2g3VWvif6sOwafNa8ayChNEFhwelyLiS4WdoTGsmkzMm04jmWcWHjkQzyfCeplc8PkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766237758; c=relaxed/simple;
	bh=ezskSz0sv7K80z23n0Tip2Rc9GWmtbbYwI9uNkg5LOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft1gAABHsunGjceaDDrcabD68HMvkXceKlV0OG92B1ZYwVhGEWbfVx7vfta6pf6E+4XeW+u/lZASRCV3+Lbk/eE7OFlkERD2aY8Pjp9e4NSRfhxvYbrM4JSKW+eVHPmtLDCZSQEBnvwgUWJ2sbUxgleEJBc+CvdZpIwDH0Uw7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nebk8W2Z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nebk8W2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766237756; x=1797773756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezskSz0sv7K80z23n0Tip2Rc9GWmtbbYwI9uNkg5LOQ=;
  b=nebk8W2ZVyyeOsujCdiEfafF+e00cQMdKaJlM2JZNDDqbizKG26TlNgx
   Cb9vlD9Kvv56Y1k8mVPWk6ioFKGHCCEd63dk7arlV9MOHKL6f0cnRaYCC
   ejD3QBqt6zmZR4UANlIp25RtGgYxVA/cL3BOsDs2HSbjmNu0WQe8GbKkx
   sbZ/Gr57lW7o2nl2XZ2+scnqXbyXLclfl/Z+yQQvVGjDrSWD6q+p6EMmK
   fxVFXkLtcs548MCQplX71JEo5nCBKGFZBxd85rDWkR8P6ZBaXQ1QEj6Qc
   rFPPJvDELmkJfcEla5XwoXJoq7rZVuoRNrCfAAfjYMFBVWsVuk3FRBLOI
   g==;
X-CSE-ConnectionGUID: hEft2TUXS9K1tayPsOUZmQ==
X-CSE-MsgGUID: mhEO7GpwTCSjs1fSn0NFew==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67371182"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67371182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 05:35:56 -0800
X-CSE-ConnectionGUID: 03wkJFNkR/mGIr9S7WRaUQ==
X-CSE-MsgGUID: ijjdsMViRjGA1kk4akL3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="204039160"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Dec 2025 05:35:53 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWx7f-000000004Yv-39vv;
	Sat, 20 Dec 2025 13:35:51 +0000
Date: Sat, 20 Dec 2025 21:35:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arjun Changla <arjunchangla7@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arjun Changla <arjunchangla7@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
Message-ID: <202512202155.mVhDoKTO-lkp@intel.com>
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061406.8043-1-arjunchangla7@gmail.com>

Hi Arjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Arjun-Changla/staging-fbtft-fix-spacing-before-close-parenthesis/20251218-141736
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20251218061406.8043-1-arjunchangla7%40gmail.com
patch subject: [PATCH] staging: fbtft: fix spacing before close parenthesis
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202155.mVhDoKTO-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202155.mVhDoKTO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202155.mVhDoKTO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/fbtft/fbtft-bus.c:65:53: error: macro 'define_fbtft_write_reg' requires 4 arguments, but only 3 given
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                                                     ^
   drivers/staging/fbtft/fbtft-bus.c:14:9: note: macro 'define_fbtft_write_reg' defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         |         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/fbtft/fbtft-bus.c:65:23: error: expected ';' before 'void'
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                       ^
         |                       ;


vim +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

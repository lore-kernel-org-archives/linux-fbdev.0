Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36014EC7E;
	Sat, 21 Sep 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726962614; cv=none; b=Rn9rNRXgKW1ZAgrk3wnQghtz6vn3cN4RdhrKwzUIfBge8XIP5WFqGAlV6LkvgpXFdHyyABpkMOSXyr4ga1xoVt7AeuJ2VH25cAQ+9pVDbWecw3S72QkgMCEqiTqtRjWrQRBoLceHCcMcCq5kVMrWphchWxWMXROIuGM1s2YGLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726962614; c=relaxed/simple;
	bh=Tot4drm5qTnCFQzRPkGAWUK9uG5MeaXdN7y1JGa8fEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/SmRzyORGk4QdpjPjVRXmKK5BBuLc1lDYsCXCegUJNZCuNj8GrbBL4M1jXug+3PIo0pxPsx1xaCSkCzNvwI8KgiwC3MUsSCtXtEXfLJMJqeQiF8gua32ElfuagoNlgZ1uEztJ/WAvdmH7q/d5HK2fRbgFh+Y2kr99nwN9soBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Glmel5/F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Glmel5/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726962612; x=1758498612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tot4drm5qTnCFQzRPkGAWUK9uG5MeaXdN7y1JGa8fEk=;
  b=Glmel5/FHEqj8umXmdYKGUVrIvJH7rlY3WeILKBsys9wNY/PqJn7JPR2
   PfnVubtqz8eRkrcXp8jjBLOpiXvRKyDZbZsB6P5Qr/pZdIC3m1+SVMCww
   QwJzsiwshVqkqyyuPiq2jqT6Pdj7fSDKbHhQiMeXTepRyPnLShzngkF3d
   z/7aCYSBpN1bTGz4EA6TjVbVnFC1bgK8WAg/BLLrxBd0YIsoFnTMfMtV3
   ba1JfG+xgCB8WcgiFxSCi2kQNCqmn8/CtpmuP4tm6PKFXWFduIzjsrc0t
   rVddtsgQw5RajHDKpF//R+4lAufXXM8p2yMJ8GxYlIp/zRl1yHmOnmk4G
   w==;
X-CSE-ConnectionGUID: a2Blw5kYRaqjxtYQfP9hzg==
X-CSE-MsgGUID: KU3Ab3XET6Cl3X7zrCgJcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43409368"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="43409368"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 16:50:12 -0700
X-CSE-ConnectionGUID: khLwQGLARwq7p964KjTuZA==
X-CSE-MsgGUID: KS7lRIMcThaWW/rPPsS2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70558343"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Sep 2024 16:50:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss9rb-000Ft0-1l;
	Sat, 21 Sep 2024 23:50:07 +0000
Date: Sun, 22 Sep 2024 07:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Fabricio Gasperin <fgasperin@lkcamp.dev>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: Rename variable
 sm750_hw_cursor_setData2
Message-ID: <202409220704.MXWsOMfL-lkp@intel.com>
References: <20240921152124.11560-1-fgasperin@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921152124.11560-1-fgasperin@lkcamp.dev>

Hi Fabricio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabricio-Gasperin/staging-sm750fb-Rename-variable-sm750_hw_cursor_setData2/20240921-232248
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240921152124.11560-1-fgasperin%40lkcamp.dev
patch subject: [PATCH] staging: sm750fb: Rename variable sm750_hw_cursor_setData2
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240922/202409220704.MXWsOMfL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220704.MXWsOMfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220704.MXWsOMfL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/sm750fb/sm750_cursor.c:134:6: warning: no previous prototype for 'sm750_hw_cursor_setdata2' [-Wmissing-prototypes]
     134 | void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/sm750_hw_cursor_setdata2 +134 drivers/staging/sm750fb/sm750_cursor.c

   133	
 > 134	void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

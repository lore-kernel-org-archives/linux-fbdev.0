Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBF2E0B5C
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382777; cv=none; b=kSeFLF5/LCJBA2Gffx7kMRxsQqukQj0xrPtR6lVL9u9v0CFptn2DBokKS4Yie4M/9Eze7DKLCJ/0rhvJ4zQG955vL3fQ2Cnwxuyi1jvcrG9PGgLSaDPRVSSP1Km8eTqtRyKZqr3kQgm383YuELDUPTA4y5yYbTbviohhxFXl1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382777; c=relaxed/simple;
	bh=niuXczVw9UyuJfgM6O2yuJfHwKJsCyLBry0VcLEay0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJashnVwcZSsSbDfB9d6S6TUFYT8/YgZ2k3+28WHRFQ5bdTBaCb1NnFBH5YPuyusp0+n2LfyAduTbo6GJQg+2fZ7XXHAOmMHpBll8pwxek9v7BDgIwPui1tPMZaDOEhTmovskFU8TQUwT2+eyvxrP7eXBy8r/XiZzCdSbhLZi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHuoMhsC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHuoMhsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792382775; x=1823918775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=niuXczVw9UyuJfgM6O2yuJfHwKJsCyLBry0VcLEay0M=;
  b=WHuoMhsCnX6mKnrTDADOMy5ylNRttcFrRf/z8y9TR/jPAFVfDQYlwOu0
   mptlFftipQrDgfHvGkAn/aCp0mr/RaPFH7dj/tFqul1exVYuxLq5CxpZ9
   wxfAITyjdCxB95y+OktJ0LI+NGUi/iY8O2fj+l3hJeOB8F/noZJQcZLHT
   bCybUTYDhwLyx+alKjOCf3jl329q1/Zu1tIqabWd4sR6m1pQT2Judu6AK
   BO2/v/x5ZzFelfXUM5hxBNxFCvGqJrUI4HqHUqny4OB/TmgP2xvcTkWTq
   IDo59cQ2HvcjaxVZEqTOGc3HIjPf/FTrbEV9o4J4csja+HngcR5TSTiPZ
   Q==;
X-CSE-ConnectionGUID: zSokGLCKSW2TpzSnmyv+Qw==
X-CSE-MsgGUID: SeXhzt+TSL2HPEaVFtBbAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1091867"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1091867"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 21:06:14 -0700
X-CSE-ConnectionGUID: 4MM7OqqDRKGoC+ydh0pWoA==
X-CSE-MsgGUID: N+nYoWIHTRKs5XNqkme6uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="4183413"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 18 Oct 2026 21:06:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIedV-00000000LFW-0pyl;
	Mon, 19 Oct 2026 04:06:09 +0000
Date: Mon, 19 Oct 2026 12:05:59 +0800
From: kernel test robot <lkp@intel.com>
To: Comfort Oyewole <coyewole7@gmail.com>, gregkh@linuxfoundation.org,
	andy@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, Julia.Lawall@inria.fr
Subject: Re: [PATCH v2] staging: fbtft: remove trailing semicolons from macro
 definitionsandy@kernel.org
Message-ID: <202610191134.V2WS3LLd-lkp@intel.com>
References: <atUG5LbCbePRNn5M@ubuntu>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUG5LbCbePRNn5M@ubuntu>

Hi Comfort,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Comfort-Oyewole/staging-fbtft-remove-trailing-semicolons-from-macro-definitionsandy-kernel-org/20261018-185028
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/atUG5LbCbePRNn5M%40ubuntu
patch subject: [PATCH v2] staging: fbtft: remove trailing semicolons from macro definitionsandy@kernel.org
config: arm64-randconfig-1003-20261019 (https://download.01.org/0day-ci/archive/20261019/202610191134.V2WS3LLd-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 6719b9e31d6a93099612c474eec76d9f41d0275a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261019/202610191134.V2WS3LLd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610191134.V2WS3LLd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fb_uc1611.c:325:1: error: expected ';' after top level declarator
     325 | FBTFT_REGISTER_DRIVER(DRVNAME, "ultrachip,uc1611", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_uc1611.c:325:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_ili9320.c:256:1: error: expected ';' after top level declarator
     256 | FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9320", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_ili9320.c:256:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_upd161704.c:175:1: error: expected ';' after top level declarator
     175 | FBTFT_REGISTER_DRIVER(DRVNAME, "nec,upd161704", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_upd161704.c:175:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_hx8347d.c:174:1: error: expected ';' after top level declarator
     174 | FBTFT_REGISTER_DRIVER(DRVNAME, "himax,hx8347d", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_hx8347d.c:174:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_ssd1331.c:193:1: error: expected ';' after top level declarator
     193 | FBTFT_REGISTER_DRIVER(DRVNAME, "solomon,ssd1331", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_ssd1331.c:193:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_tinylcd.c:84:1: error: expected ';' after top level declarator
      84 | FBTFT_REGISTER_DRIVER(DRVNAME, "neosec,tinylcd", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_tinylcd.c:84:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_ili9163.c:251:1: error: expected ';' after top level declarator
     251 | FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9163", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_ili9163.c:251:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_ssd1351.c:230:1: error: expected ';' after top level declarator
     230 | FBTFT_REGISTER_DRIVER(DRVNAME, "solomon,ssd1351", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_ssd1351.c:230:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_hx8353d.c:126:1: error: expected ';' after top level declarator
     126 | FBTFT_REGISTER_DRIVER(DRVNAME, "himax,hx8353d", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_hx8353d.c:126:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_ssd1305.c:198:1: error: expected ';' after top level declarator
     198 | FBTFT_REGISTER_DRIVER(DRVNAME, "solomon,ssd1305", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_ssd1305.c:198:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
--
>> drivers/staging/fbtft/fb_st7735r.c:165:1: error: expected ';' after top level declarator
     165 | FBTFT_REGISTER_DRIVER(DRVNAME, "sitronix,st7735r", &display);
         | ^
   drivers/staging/fbtft/fbtft.h:321:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     321 |                                                                            \
         |                                                                            ^
   drivers/staging/fbtft/fbtft.h:283:11: note: expanded from macro '\
   FBTFT_SPI_DRIVER'
     283 |                                                                                 \
         |                                                                                 ^
>> drivers/staging/fbtft/fb_st7735r.c:165:1: error: expected ';' after top level declarator
   drivers/staging/fbtft/fbtft.h:323:13: note: expanded from macro 'FBTFT_REGISTER_DRIVER'
     323 |                                                                            \
         |                                                                            ^
   2 errors generated.
..


vim +325 drivers/staging/fbtft/fb_uc1611.c

a1560f9bec8b927 Henri Chain 2015-07-14  324  
a1560f9bec8b927 Henri Chain 2015-07-14 @325  FBTFT_REGISTER_DRIVER(DRVNAME, "ultrachip,uc1611", &display);
a1560f9bec8b927 Henri Chain 2015-07-14  326  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

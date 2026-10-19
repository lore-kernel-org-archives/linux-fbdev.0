Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043C36F428
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381516; cv=none; b=IW1nZhCHTmWoj59GSJcgv5OZEZUGp4PNlgLlbv474iMESijxBV2f1lJn4LTdBFlZRNsdFhdk4zCsPP6W346K1y9DMSbUjRBaOof1llE+mszOipzDPDnF2conlwMKzTaOt4sI4Ac3hBEv4bEv0fZlTnLKVkDt/SEq6bi3NK50dI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381516; c=relaxed/simple;
	bh=pt+iJ+VsIoqD89756qoIkLcFkYk6gvl3O7wxRe8v+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu6GF8tEubA7rCUy1zVFD0ocG+m/+NQ7rz7R2SQGjPJv9dmN5Hgq8z7OpT5JjqPnVPTWbzodZ4bKMeihZW/rPdo3W/UISts+elCiGb7aNzU0EK5PvICN0tyA55mEehAuyq/YhKPaYT1vNaTa62lnC74gAkpXnXruNftShh38Y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz2MzE3u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz2MzE3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792381515; x=1823917515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pt+iJ+VsIoqD89756qoIkLcFkYk6gvl3O7wxRe8v+3E=;
  b=Mz2MzE3uP7Q7OuX+RJQIHBD8Z/WDSv6NllFY9IwXL98eSqBJBPv9nB+E
   M+zqDSEnpYcmiyQ8lAXiPG5+riW6mbERJT2M1wqb0JxhNrrWUIQbClFgy
   jwTsxTSLfBPD8IwPIYEJi1TMwUtxlbjG2SEV+7/PQ1qqbX2r9ijJUSJBj
   agepwHjNFDiIaixj0w5/dUQc3lD1pdpGPgddYDTOXxmVtcDk0VqOePi/m
   Mxj2GtCu512mSH0UguNSZ90uB3Oocw2s3ZrYSvR8WNRUuxC1r8RJYTTxC
   LXYknVH7+g68uEPaVjboaj4mPOeleK3Rn0ChmSshJjcqNfNwcTlcxppug
   Q==;
X-CSE-ConnectionGUID: +RUreFvqQICuA5a4SH8NYQ==
X-CSE-MsgGUID: /3h1UoVGTNSV6eRgc4QcrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="957627"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="957627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 20:45:14 -0700
X-CSE-ConnectionGUID: kg7nIjGQRp+sVIyaI1Cfhg==
X-CSE-MsgGUID: JNdWni0VTbWOEoRKUrnKwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2423665"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2026 20:45:12 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIeJA-00000000LEc-1jrQ;
	Mon, 19 Oct 2026 03:45:08 +0000
Date: Mon, 19 Oct 2026 11:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Comfort Oyewole <coyewole7@gmail.com>, gregkh@linuxfoundation.org,
	andy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, outreachy@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	Julia.Lawall@inria.fr
Subject: Re: [PATCH v2] staging: fbtft: remove trailing semicolons from macro
 definitionsandy@kernel.org
Message-ID: <202610191356.9yPxs182-lkp@intel.com>
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
config: sh-randconfig-1001-20261019 (https://download.01.org/0day-ci/archive/20261019/202610191356.9yPxs182-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261019/202610191356.9yPxs182-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610191356.9yPxs182-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

     284 | static int fbtft_driver_probe_spi(struct spi_device *spi)                       \
         | ^~~~~~
   drivers/staging/fbtft/fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
     366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
         | ^~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:302:18: error: 'fbtft_driver_probe_spi' undeclared here (not in a function); did you mean 'fbtft_driver_remove_spi'?
     302 |         .probe = fbtft_driver_probe_spi,                                        \
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
     366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
         | ^~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from include/uapi/linux/fb.h:6,
                    from include/linux/fb.h:5,
                    from drivers/staging/fbtft/fbtft.h:7:
   include/linux/device/driver.h:267:1: error: expected ',' or ';' before 'static'
     267 | static int __init __driver##_init(void) \
         | ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c: In function '__inittest':
   drivers/staging/fbtft/fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared (first use in this function); did you mean 'fbtft_driver_spi_driver'?
     368 | module_spi_driver(fbtft_driver_spi_driver)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:18: note: in definition of macro 'module_init'
     133 |         { return initfn; }                                      \
         |                  ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:19: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/module.h:133:18: note: in definition of macro 'module_init'
     133 |         { return initfn; }                                      \
         |                  ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:88,
                    from <command-line>:
   drivers/staging/fbtft/fb_sh1106.c: At top level:
   drivers/staging/fbtft/fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared here (not in a function); did you mean 'fbtft_driver_spi_driver'?
     368 | module_spi_driver(fbtft_driver_spi_driver)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:92:65: note: in definition of macro '__copy'
      92 | # define __copy(symbol)                 __attribute__((__copy__(symbol)))
         |                                                                 ^~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
     271 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:134:13: error: 'init_module' aliased to undefined symbol 'fbtft_driver_spi_driver_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
     271 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:247:17: error: '__mod_device_table__kmod_fb_sh1106__spi__spi_ids' aliased to undefined symbol 'spi_ids'
     247 |         __PASTE(__mod_device_table__,   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   include/linux/module.h:247:9: note: in expansion of macro '__PASTE'
     247 |         __PASTE(__mod_device_table__,   \
         |         ^~~~~~~
   include/linux/module.h:256:21: note: in expansion of macro '__mod_device_table'
     256 | static typeof(name) __mod_device_table(type, name)                      \
         |                     ^~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:364:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     364 | MODULE_DEVICE_TABLE(spi, spi_ids)                                               \
         | ^~~~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/fbtft/fb_sh1106.c:154:29: warning: 'display' defined but not used [-Wunused-variable]
     154 | static struct fbtft_display display = {
         |                             ^~~~~~~
--
     284 | static int fbtft_driver_probe_spi(struct spi_device *spi)                       \
         | ^~~~~~
   fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
     366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
         | ^~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   fbtft.h:302:18: error: 'fbtft_driver_probe_spi' undeclared here (not in a function); did you mean 'fbtft_driver_remove_spi'?
     302 |         .probe = fbtft_driver_probe_spi,                                        \
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
     366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
         | ^~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from include/uapi/linux/fb.h:6,
                    from include/linux/fb.h:5,
                    from fbtft.h:7:
   include/linux/device/driver.h:267:1: error: expected ',' or ';' before 'static'
     267 | static int __init __driver##_init(void) \
         | ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   fb_sh1106.c: In function '__inittest':
   fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared (first use in this function); did you mean 'fbtft_driver_spi_driver'?
     368 | module_spi_driver(fbtft_driver_spi_driver)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:18: note: in definition of macro 'module_init'
     133 |         { return initfn; }                                      \
         |                  ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   fbtft.h:368:19: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/module.h:133:18: note: in definition of macro 'module_init'
     133 |         { return initfn; }                                      \
         |                  ^~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:88,
                    from <command-line>:
   fb_sh1106.c: At top level:
   fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared here (not in a function); did you mean 'fbtft_driver_spi_driver'?
     368 | module_spi_driver(fbtft_driver_spi_driver)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:92:65: note: in definition of macro '__copy'
      92 | # define __copy(symbol)                 __attribute__((__copy__(symbol)))
         |                                                                 ^~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
     271 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:134:13: error: 'init_module' aliased to undefined symbol 'fbtft_driver_spi_driver_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
     271 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
     408 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
     368 | module_spi_driver(fbtft_driver_spi_driver)
         | ^~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:247:17: error: '__mod_device_table__kmod_fb_sh1106__spi__spi_ids' aliased to undefined symbol 'spi_ids'
     247 |         __PASTE(__mod_device_table__,   \
         |                 ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   include/linux/module.h:247:9: note: in expansion of macro '__PASTE'
     247 |         __PASTE(__mod_device_table__,   \
         |         ^~~~~~~
   include/linux/module.h:256:21: note: in expansion of macro '__mod_device_table'
     256 | static typeof(name) __mod_device_table(type, name)                      \
         |                     ^~~~~~~~~~~~~~~~~~
   fbtft.h:364:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     364 | MODULE_DEVICE_TABLE(spi, spi_ids)                                               \
         | ^~~~~~~~~~~~~~~~~~~
   fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
     173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   fb_sh1106.c:154:29: warning: 'display' defined but not used [-Wunused-variable]
     154 | static struct fbtft_display display = {
         |                             ^~~~~~~


vim +247 include/linux/module.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  240  
83fb49389bbe07d Alexey Gladkov 2025-09-18  241  /*
83fb49389bbe07d Alexey Gladkov 2025-09-18  242   * Format: __mod_device_table__kmod_<modname>__<type>__<name>
83fb49389bbe07d Alexey Gladkov 2025-09-18  243   * Parts of the string `__kmod_` and `__` are used as delimiters when parsing
83fb49389bbe07d Alexey Gladkov 2025-09-18  244   * a symbol in file2alias.c
83fb49389bbe07d Alexey Gladkov 2025-09-18  245   */
83fb49389bbe07d Alexey Gladkov 2025-09-18  246  #define __mod_device_table(type, name)	\
83fb49389bbe07d Alexey Gladkov 2025-09-18 @247  	__PASTE(__mod_device_table__,	\
9025688bf6d427e Josh Poimboeuf 2025-10-20  248  	__PASTE(kmod_,			\
83fb49389bbe07d Alexey Gladkov 2025-09-18  249  	__PASTE(__KBUILD_MODNAME,	\
83fb49389bbe07d Alexey Gladkov 2025-09-18  250  	__PASTE(__,			\
83fb49389bbe07d Alexey Gladkov 2025-09-18  251  	__PASTE(type,			\
9025688bf6d427e Josh Poimboeuf 2025-10-20  252  	__PASTE(__, name))))))
83fb49389bbe07d Alexey Gladkov 2025-09-18  253  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB064E2F14
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408091; cv=none; b=KsV1FzkITQI4bwm3mn3sNQVNmbujKJmzI1DeUaXpZYuC8iwoJf/FdxQeVe/oV8XDH6aQTdgAfR5LIDmdwm+ghQgWZxRNYojAd2mOAehFAom0r9eCg1mxGWY3vehkKGRksYSAfx0jup7i+Gzvpu99h380YItUi2VCAqfKYEfoa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408091; c=relaxed/simple;
	bh=k0JfvF3jECqJI4CtleIap8awyvC1tcdGB5u0jGyqdSE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J8vqhgcuIE0FYSIPa+NJPkIBj8u56seWV8BShZvGS1ENt+iGhMLhnimNkomkJT7dzGJF5b2ESVZDuQqykmGVNuz6QF+JA8sb8anBk5Z8JZz5WiRQSCYikKJwiZYdLvayRMtabQ44MPmB5NORNkWc6fs10CWqrfPmVhop4SdYYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fc0h3hl2; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fc0h3hl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=coLnxrFvFhTSWxpuGzwR//kpT+0QAR1BEIa7BulpPXU=;
  b=fc0h3hl2c1JIyt7a8thKeVYMAuEY+cXoYADg+q+7FvOZS/q1nILRJwo8
   xqd0v2QOLSNyH/HUD5zTQQngzeMkNaQBVgzSzVgp7E/TC699kOufZWMY8
   a7JtoN0fTG33HkWohO9loAjtRNTogdWX06RRAPFsx+tBAlgPNzdMqTtkW
   E=;
X-CSE-ConnectionGUID: dku0JJ9oTviHeOMLzCmWFw==
X-CSE-MsgGUID: v2ZihvHBQC66AIDWxNtRMw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,167,1787004000"; 
   d="scan'208";a="300870915"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:08:03 +0200
Date: Mon, 19 Oct 2026 07:08:00 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Comfort Oyewole <coyewole7@gmail.com>
cc: gregkh@linuxfoundation.org, andy@kernel.org, oe-kbuild-all@lists.linux.dev, 
    outreachy@lists.linux.dev, linux-staging@lists.linux.dev, 
    linux-fbdev@vger.kernel.org, Julia.Lawall@inria.fr
Subject: Re: [PATCH v2] staging: fbtft: remove trailing semicolons from macro
 definitionsandy@kernel.org
In-Reply-To: <202610191356.9yPxs182-lkp@intel.com>
Message-ID: <f647826f-2686-dc67-cff6-9e8810aa565@inria.fr>
References: <atUG5LbCbePRNn5M@ubuntu> <202610191356.9yPxs182-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 19 Oct 2026, kernel test robot wrote:

> Hi Comfort,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on staging/staging-testing]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Comfort-Oyewole/staging-fbtft-remove-trailing-semicolons-from-macro-definitionsandy-kernel-org/20261018-185028
> base:   staging/staging-testing
> patch link:    https://lore.kernel.org/r/atUG5LbCbePRNn5M%40ubuntu
> patch subject: [PATCH v2] staging: fbtft: remove trailing semicolons from macro definitionsandy@kernel.org
> config: sh-randconfig-1001-20261019 (https://download.01.org/0day-ci/archive/20261019/202610191356.9yPxs182-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 16.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261019/202610191356.9yPxs182-lkp@intel.com/reproduce)

Comfort,

Did you compile your kernel?  You need to check that you get a .o file for
every files that you modify.  But that is not a 100% guarantee, when the
change you make are under an #ifdef.  In that case, you have to check that
the containing #ifdefs resolve to true so the code is compiled.  If it
seems complex, you can try adding an error at the point of the code you
modified to be sure that compiling gives the corresponding error message.

julia


>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610191356.9yPxs182-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>      284 | static int fbtft_driver_probe_spi(struct spi_device *spi)                       \
>          | ^~~~~~
>    drivers/staging/fbtft/fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
>      366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
>          | ^~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:302:18: error: 'fbtft_driver_probe_spi' undeclared here (not in a function); did you mean 'fbtft_driver_remove_spi'?
>      302 |         .probe = fbtft_driver_probe_spi,                                        \
>          |                  ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
>      366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
>          | ^~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/device.h:32,
>                     from include/linux/acpi.h:15,
>                     from include/linux/i2c.h:13,
>                     from include/uapi/linux/fb.h:6,
>                     from include/linux/fb.h:5,
>                     from drivers/staging/fbtft/fbtft.h:7:
>    include/linux/device/driver.h:267:1: error: expected ',' or ';' before 'static'
>      267 | static int __init __driver##_init(void) \
>          | ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c: In function '__inittest':
>    drivers/staging/fbtft/fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared (first use in this function); did you mean 'fbtft_driver_spi_driver'?
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/module.h:133:18: note: in definition of macro 'module_init'
>      133 |         { return initfn; }                                      \
>          |                  ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:19: note: each undeclared identifier is reported only once for each function it appears in
>    include/linux/module.h:133:18: note: in definition of macro 'module_init'
>      133 |         { return initfn; }                                      \
>          |                  ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/compiler_types.h:88,
>                     from <command-line>:
>    drivers/staging/fbtft/fb_sh1106.c: At top level:
>    drivers/staging/fbtft/fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared here (not in a function); did you mean 'fbtft_driver_spi_driver'?
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_attributes.h:92:65: note: in definition of macro '__copy'
>       92 | # define __copy(symbol)                 __attribute__((__copy__(symbol)))
>          |                                                                 ^~~~~~
>    include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
>      271 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/module.h:134:13: error: 'init_module' aliased to undefined symbol 'fbtft_driver_spi_driver_init'
>      134 |         int init_module(void) __copy(initfn)                    \
>          |             ^~~~~~~~~~~
>    include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
>      271 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/module.h:247:17: error: '__mod_device_table__kmod_fb_sh1106__spi__spi_ids' aliased to undefined symbol 'spi_ids'
>      247 |         __PASTE(__mod_device_table__,   \
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
>       15 | #define ___PASTE(a, b) a##b
>          |                        ^
>    include/linux/module.h:247:9: note: in expansion of macro '__PASTE'
>      247 |         __PASTE(__mod_device_table__,   \
>          |         ^~~~~~~
>    include/linux/module.h:256:21: note: in expansion of macro '__mod_device_table'
>      256 | static typeof(name) __mod_device_table(type, name)                      \
>          |                     ^~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fbtft.h:364:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
>      364 | MODULE_DEVICE_TABLE(spi, spi_ids)                                               \
>          | ^~~~~~~~~~~~~~~~~~~
>    drivers/staging/fbtft/fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/staging/fbtft/fb_sh1106.c:154:29: warning: 'display' defined but not used [-Wunused-variable]
>      154 | static struct fbtft_display display = {
>          |                             ^~~~~~~
> --
>      284 | static int fbtft_driver_probe_spi(struct spi_device *spi)                       \
>          | ^~~~~~
>    fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
>      366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
>          | ^~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    fbtft.h:302:18: error: 'fbtft_driver_probe_spi' undeclared here (not in a function); did you mean 'fbtft_driver_remove_spi'?
>      302 |         .probe = fbtft_driver_probe_spi,                                        \
>          |                  ^~~~~~~~~~~~~~~~~~~~~~
>    fbtft.h:366:1: note: in expansion of macro 'FBTFT_SPI_DRIVER'
>      366 | FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)            \
>          | ^~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/device.h:32,
>                     from include/linux/acpi.h:15,
>                     from include/linux/i2c.h:13,
>                     from include/uapi/linux/fb.h:6,
>                     from include/linux/fb.h:5,
>                     from fbtft.h:7:
>    include/linux/device/driver.h:267:1: error: expected ',' or ';' before 'static'
>      267 | static int __init __driver##_init(void) \
>          | ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    fb_sh1106.c: In function '__inittest':
>    fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared (first use in this function); did you mean 'fbtft_driver_spi_driver'?
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/module.h:133:18: note: in definition of macro 'module_init'
>      133 |         { return initfn; }                                      \
>          |                  ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    fbtft.h:368:19: note: each undeclared identifier is reported only once for each function it appears in
>    include/linux/module.h:133:18: note: in definition of macro 'module_init'
>      133 |         { return initfn; }                                      \
>          |                  ^~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/compiler_types.h:88,
>                     from <command-line>:
>    fb_sh1106.c: At top level:
>    fbtft.h:368:19: error: 'fbtft_driver_spi_driver_init' undeclared here (not in a function); did you mean 'fbtft_driver_spi_driver'?
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_attributes.h:92:65: note: in definition of macro '__copy'
>       92 | # define __copy(symbol)                 __attribute__((__copy__(symbol)))
>          |                                                                 ^~~~~~
>    include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
>      271 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/module.h:134:13: error: 'init_module' aliased to undefined symbol 'fbtft_driver_spi_driver_init'
>      134 |         int init_module(void) __copy(initfn)                    \
>          |             ^~~~~~~~~~~
>    include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
>      271 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:408:9: note: in expansion of macro 'module_driver'
>      408 |         module_driver(__spi_driver, spi_register_driver, \
>          |         ^~~~~~~~~~~~~
>    fbtft.h:368:1: note: in expansion of macro 'module_spi_driver'
>      368 | module_spi_driver(fbtft_driver_spi_driver)
>          | ^~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/module.h:247:17: error: '__mod_device_table__kmod_fb_sh1106__spi__spi_ids' aliased to undefined symbol 'spi_ids'
>      247 |         __PASTE(__mod_device_table__,   \
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
>       15 | #define ___PASTE(a, b) a##b
>          |                        ^
>    include/linux/module.h:247:9: note: in expansion of macro '__PASTE'
>      247 |         __PASTE(__mod_device_table__,   \
>          |         ^~~~~~~
>    include/linux/module.h:256:21: note: in expansion of macro '__mod_device_table'
>      256 | static typeof(name) __mod_device_table(type, name)                      \
>          |                     ^~~~~~~~~~~~~~~~~~
>    fbtft.h:364:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
>      364 | MODULE_DEVICE_TABLE(spi, spi_ids)                                               \
>          | ^~~~~~~~~~~~~~~~~~~
>    fb_sh1106.c:173:1: note: in expansion of macro 'FBTFT_REGISTER_SPI_DRIVER'
>      173 | FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    fb_sh1106.c:154:29: warning: 'display' defined but not used [-Wunused-variable]
>      154 | static struct fbtft_display display = {
>          |                             ^~~~~~~
>
>
> vim +247 include/linux/module.h
>
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  240
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  241  /*
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  242   * Format: __mod_device_table__kmod_<modname>__<type>__<name>
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  243   * Parts of the string `__kmod_` and `__` are used as delimiters when parsing
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  244   * a symbol in file2alias.c
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  245   */
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  246  #define __mod_device_table(type, name)	\
> 83fb49389bbe07d Alexey Gladkov 2025-09-18 @247  	__PASTE(__mod_device_table__,	\
> 9025688bf6d427e Josh Poimboeuf 2025-10-20  248  	__PASTE(kmod_,			\
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  249  	__PASTE(__KBUILD_MODNAME,	\
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  250  	__PASTE(__,			\
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  251  	__PASTE(type,			\
> 9025688bf6d427e Josh Poimboeuf 2025-10-20  252  	__PASTE(__, name))))))
> 83fb49389bbe07d Alexey Gladkov 2025-09-18  253
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

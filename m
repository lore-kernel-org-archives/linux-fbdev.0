Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F22258ED4
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Feb 2026 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618648; cv=none; b=DrocoS7VcV4romUg8mQnOkx68DNoRyRC76oefpqmH7xI8MFCylN659dvWclg84S87dKGe3DWaSsmAjXvIS168Jo4YuBNO88yULypqiE8Ncxpx2THilnSnNbKM9SFrO8GL4UfsuVLy90TUgB/nA1VaWxUJoSQbTWFFZSg05pgDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618648; c=relaxed/simple;
	bh=dh+fb6XzsJt1cp4AMc0cC7Q8+klw9ZHu4lNBecMgYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orvxkcgl73v+a9NmhoxwLJfygqxa01vTR62XnXPP4AEJ/l0LOg0EIZic5vadayddsRBAD66+MBaA2UMWuozC35ugzqJuPrxMVGXcBjKCeWtL7VlIoZ29bbPIhQwbrzHF9kK23rwAWFZT8PoTJGW5XTML8id1BIUeM5RH0E3kGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxquKAcL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxquKAcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770618649; x=1802154649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dh+fb6XzsJt1cp4AMc0cC7Q8+klw9ZHu4lNBecMgYpA=;
  b=XxquKAcLp7S8miQKxr4PEviOsXMdf5WQrKijZBQfcgacJGHviY4kBmsZ
   DcPOS4VNLc02qPaTTIk9FsPD636uVHzemugT6JhOaJ6atVg5+/noxY8oX
   Gtu/cFcChw07Bz7C81UPcdTNx8sRXDToXAsMWVqtsCWiupjB+SgUE8Bu/
   2ZebKjhUELXatnaSjgMIT+SuBJdQO8TkZwbhWU6vLU789bRZbZzVcrv5u
   +a41hcdPjBiPxD7Meuye3VMlFoXWsFOIi5+TNmEJF60NcX0fDfrkDPNTF
   LXDJRU2Lclrg0usGvLbEngfGMHTuC1XmzWCC7uXeKwCqOg/CtrdBW6m/2
   Q==;
X-CSE-ConnectionGUID: XQTFUP34TlGLu6kqZxENWw==
X-CSE-MsgGUID: u8fpZNv2SvSc4LpnGLbrMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82048951"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="82048951"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 22:30:48 -0800
X-CSE-ConnectionGUID: O088DlCgQdC/BW5r5rKpcw==
X-CSE-MsgGUID: q8o/2qmoRgyZDTQ9EeDC1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="210574153"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Feb 2026 22:30:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpKnD-00000000mes-3BZz;
	Mon, 09 Feb 2026 06:30:43 +0000
Date: Mon, 9 Feb 2026 14:30:13 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 5/6] fbdev: au1100fb: Make driver compilable on
 non-mips platforms
Message-ID: <202602091447.3HeLynhy-lkp@intel.com>
References: <67b7aa0157b9cf5de111ab6b2725d207ec98aae9.1770572936.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b7aa0157b9cf5de111ab6b2725d207ec98aae9.1770572936.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0636e6205beed850d985276dc56fd73d785bea5c]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fbdev-au1100fb-Don-t-store-device-specific-data-in-global-variables/20260209-015956
base:   0636e6205beed850d985276dc56fd73d785bea5c
patch link:    https://lore.kernel.org/r/67b7aa0157b9cf5de111ab6b2725d207ec98aae9.1770572936.git.u.kleine-koenig%40baylibre.com
patch subject: [PATCH v3 5/6] fbdev: au1100fb: Make driver compilable on non-mips platforms
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260209/202602091447.3HeLynhy-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602091447.3HeLynhy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602091447.3HeLynhy-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/video/fbdev/au1100fb.o: in function `au1100fb_drv_remove':
   au1100fb.c:(.text+0x21c): undefined reference to `unregister_framebuffer'
>> csky-linux-ld: au1100fb.c:(.text+0x224): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: drivers/video/fbdev/au1100fb.o: in function `au1100fb_fb_mmap':
   au1100fb.c:(.text+0x2bc): undefined reference to `unregister_framebuffer'
   csky-linux-ld: au1100fb.c:(.text+0x2c0): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: drivers/video/fbdev/au1100fb.o: in function `au1100fb_drv_probe':
   au1100fb.c:(.text+0x540): undefined reference to `fb_get_options'
>> csky-linux-ld: au1100fb.c:(.text+0x6e4): undefined reference to `fb_get_options'
>> csky-linux-ld: au1100fb.c:(.text+0x7bc): undefined reference to `fb_alloc_cmap'
>> csky-linux-ld: au1100fb.c:(.text+0x7d8): undefined reference to `register_framebuffer'
   csky-linux-ld: au1100fb.c:(.text+0x818): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: au1100fb.c:(.text+0x850): undefined reference to `fb_alloc_cmap'
   csky-linux-ld: au1100fb.c:(.text+0x860): undefined reference to `register_framebuffer'
   csky-linux-ld: au1100fb.c:(.text+0x874): undefined reference to `fb_dealloc_cmap'
>> csky-linux-ld: drivers/video/fbdev/au1100fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>> csky-linux-ld: drivers/video/fbdev/au1100fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>> csky-linux-ld: drivers/video/fbdev/au1100fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>> csky-linux-ld: drivers/video/fbdev/au1100fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>> csky-linux-ld: drivers/video/fbdev/au1100fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73F246355
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Dec 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926752; cv=none; b=ryZ7ACmJBIceVeNG5IS7aYPbAegL3j+lVlhmFUUYYqc21LEQU3eYeceaPiJYaDYX+vWtCjBE4JNguAMeJS/NHZDSOC5rcOC6APx7DA+/W+4bJqJprJIMz1+PGNB8nhpiXwYSkNOOaAmDHGzpZxtGwgkHNPMYYb01hS86ngH44RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926752; c=relaxed/simple;
	bh=n/bW5X2P50IWGPskV8bddp7mr3+Mz84TOOqK8/Bw/oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmykREvi99miHQTG00AECaRSww5jNi2kHu0jUxy8xkWBcqxzul8+57oAdc+08WcktukXdU93MKUmb8ajhjYz/mxc4RdQaSPMrIZ//RkMVdMHc7OWQIIZy9Rp3lCPdGAxD5bYT9l+5ml3FR/KCkHoYIM9bngPdCzuDOxyoNDBSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnXptYsC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnXptYsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733926750; x=1765462750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n/bW5X2P50IWGPskV8bddp7mr3+Mz84TOOqK8/Bw/oE=;
  b=YnXptYsCDuCz67z68OVhd+q6IgWg25VH2cA3Dj9ZEJuSv4mCkhwMCeme
   CLaXoodKYM1vUgNoqdSZiiOei0pqwB7FvfRs2uSP17/fowO8cGYkGnoa0
   /Z74sQTsz4M5lm10Iu2uJSW5mIzoenBtUlvbTx7Q4LYzPdbziczaaG5aV
   eO/B8G4kIarIHtAd5gV8tDhwsDKIOjvuW/XK3x3UzZuU+qL30Z+v40SP8
   2szoybsT/voFWQdCX2K8D2lEn3Z7kzfMnSCDy9+u+Wh5akfUOQpmtWwTy
   TgqzUG64wyAL5ECIW9nkXMEdHfAmuxZ+WFA3mOxOcQ8EoX51RBoR4sxh0
   A==;
X-CSE-ConnectionGUID: Ls4uOoIyRzOSqm9HosvUig==
X-CSE-MsgGUID: 4zTuR5WvRFey8mh+7ZGDLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38239162"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38239162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:19:09 -0800
X-CSE-ConnectionGUID: V+dO8e6fQuaP7J/uGnbsQg==
X-CSE-MsgGUID: 0Hp/6ujnREedJDCTms2R+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95885459"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Dec 2024 06:19:07 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLNYO-0006jh-1F;
	Wed, 11 Dec 2024 14:19:04 +0000
Date: Wed, 11 Dec 2024 22:18:44 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
	arnd@arndb.de, deller@gmx.de, simona@ffwll.ch, airlied@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/3] fbdev: Fix recursive dependencies wrt
 BACKLIGHT_CLASS_DEVICE
Message-ID: <202412112135.pzFeIjEo-lkp@intel.com>
References: <20241210142329.660801-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210142329.660801-2-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus drm/drm-next drm-exynos/exynos-drm-next linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/fbdev-Fix-recursive-dependencies-wrt-BACKLIGHT_CLASS_DEVICE/20241210-222618
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20241210142329.660801-2-tzimmermann%40suse.de
patch subject: [PATCH 1/3] fbdev: Fix recursive dependencies wrt BACKLIGHT_CLASS_DEVICE
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20241211/202412112135.pzFeIjEo-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112135.pzFeIjEo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112135.pzFeIjEo-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/video/fbdev/aty/radeon_backlight.o: in function `radeonfb_bl_init':
>> radeon_backlight.c:(.text+0x424): undefined reference to `backlight_device_register'
   loongarch64-linux-ld: drivers/video/fbdev/aty/radeon_backlight.o: in function `radeonfb_bl_exit':
>> radeon_backlight.c:(.text+0x560): undefined reference to `backlight_device_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

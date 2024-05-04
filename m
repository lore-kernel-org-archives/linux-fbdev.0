Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD171CF8D;
	Sat,  4 May 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823193; cv=none; b=kmUr91DhmifZyoMtZQ58+abWZLR1sgTQqthkUkdac9Lavsf9b/JUWzP9vvYzB/de+XCMxck45hBUMGAZxLHZawgTjpZ9j33sYfLxCB52Akf03biV5jZMKNn9wAK6tdfWy72AEx0ELor08lg9wM/pNnPPPM07+iiAPcfKtggZUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823193; c=relaxed/simple;
	bh=qQXVDmyCOh7VCNUbBBWBaLbWHRimpTQLcNFH0D/M+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOzqM452ywJFpgtn0bUXeynVDlPsLe71aVhaPLHkh8OyEBa1IsL7EeGBZeNv7G0dnDrqDyMoE8HBkBtawVo6XOIjBRM/29RiqFnWc/xCl6fK0DFEhoqX78tJQVUlsYze10KSLNovH+kdgaLCZtvg7qia5wPBhBOxuqY6Jlylbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwFTIK/Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwFTIK/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714823192; x=1746359192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qQXVDmyCOh7VCNUbBBWBaLbWHRimpTQLcNFH0D/M+ts=;
  b=jwFTIK/Q8JsDVy6kkVuGtgbMPOZ4ea1BUwd2SyIAnaFU/f5RG+QZ0puu
   0L3SKgt590mJFihgxhlrs+oARx+uUl6CD6pkubNIv0gnWCQju96TJjGVA
   LZCIiLadje7QoBWsaSwSQ83kyKSaKE+/tLtmZc+XvIXC05HZbv4mZ1DrA
   A1InqydvaQSjeEmkTC8Js6AUzs3i5/TEMa8js8CsIJd9peBV1JjMs6UXd
   EyfuYxvJkuD5hgngsxs2ze1Wrmy9PBwUSULYX1Y8uYVXRSeFgGFnRVuK+
   U+uJqx6F29H1UqUpstdaAcImp5CMBELslq3FxxOp1F8FhnCuOVv226h93
   A==;
X-CSE-ConnectionGUID: 58UNHcDbSH6k7DQME4FR4Q==
X-CSE-MsgGUID: Q/h1b0sjQdeQMBhczRl6Sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="36012712"
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="36012712"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 04:46:31 -0700
X-CSE-ConnectionGUID: UwtQGMebQa+3N6cKVb31yQ==
X-CSE-MsgGUID: S5sYHNEeRVSJl+dF0XdkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="32506763"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 May 2024 04:46:27 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3DqT-000CjU-1h;
	Sat, 04 May 2024 11:46:25 +0000
Date: Sat, 4 May 2024 19:46:10 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Message-ID: <202405041939.MNsieCv5-lkp@intel.com>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192858.103640-1-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/fbdev-Have-CONFIG_FB_NOTIFY-be-tristate/20240504-033139
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240503192858.103640-1-florian.fainelli%40broadcom.com
patch subject: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
config: powerpc-randconfig-001-20240504 (https://download.01.org/0day-ci/archive/20240504/202405041939.MNsieCv5-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405041939.MNsieCv5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405041939.MNsieCv5-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/leds/trigger/ledtrig-backlight.o: in function `bl_trig_deactivate':
>> ledtrig-backlight.c:(.text+0x360): undefined reference to `fb_unregister_client'
   powerpc-linux-ld: drivers/leds/trigger/ledtrig-backlight.o: in function `bl_trig_activate':
>> ledtrig-backlight.c:(.text+0x3e8): undefined reference to `fb_register_client'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

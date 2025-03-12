Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741723BCFC;
	Wed, 12 Mar 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774897; cv=none; b=NFz8jICsgL0LmgoF5S/LPccKlSuj0uNxR1GIwdMv/K+aVUeFFPHgBwNvFrb7r7uDlGkecNHTd45Iv7955cn9secKYIJceTeUQTQXSPMP4q2YCHr3xGaj69i+9eLbjHfdnurxesi4DLU+Wl/MaYZrNRzbC1dV7WrJfiiNt25FRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774897; c=relaxed/simple;
	bh=41QWwJfAFHDyzTTvXUw28+dvX6bb0jw45B0uM9j0CvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjBf0Db9XbCSoEIWgYz4oZSezLvDWLRFsidfsCgy7ekZcgcdowAP9nXseVml5dmEy9JQmoAdnb3LzaIVgZshjBIpb/xl4hKi2YttRZRPExriD67fyq4V056cMyDKVvYOedU809k8k5/kHGAg1XsxA/dZDIxDWvcY0J+e/kg3tFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJ0SkTcu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJ0SkTcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741774894; x=1773310894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41QWwJfAFHDyzTTvXUw28+dvX6bb0jw45B0uM9j0CvY=;
  b=aJ0SkTcu4SiwLvSXwGyXgUBkygC9cuWlDY+n3JIdhvnFYsLbBAU5OGSb
   /g84wcQFPl5o9KlZ50S/tqq638C59k35vr3f3c7pjGzWTBg3mBaKe4yH+
   t8eGFTiDLYXo33fIlcGBWbEEILxoSqnEp8sI8+lQh/x9CDlGq1KLXB97j
   dSduoMRJKHLaj73C7EZF9AYKQ7R0jCHAl43SL8t/wjY+hnkGpKLYvXlEQ
   vZbkO10S4DvnO3YoiQBaB+SSod4hhZ7iufuEAg4Dl9AMkMO1qstFAxh/1
   XWzqtAgJwILYG7slhxEsHHTt2vxZZXNQb3H2m0wuHaH4vhfcdnd0eDga3
   w==;
X-CSE-ConnectionGUID: 5ADEMC3CQBuyc+K0VfgdVw==
X-CSE-MsgGUID: grHeGf8ORnyKYG0TMB9zTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="65306440"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="65306440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:21:34 -0700
X-CSE-ConnectionGUID: B/5+MFx7QrW63VAKxIyfyg==
X-CSE-MsgGUID: g4KEu2WDSN6abvwq00/fpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125643020"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 03:21:31 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsJDM-0008O0-2h;
	Wed, 12 Mar 2025 10:21:28 +0000
Date: Wed, 12 Mar 2025 18:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: oushixiong1025@163.com, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
Message-ID: <202503121852.0x6J0c7a-lkp@intel.com>
References: <20250311112856.1020095-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311112856.1020095-1-oushixiong1025@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong1025-163-com/fbcon-Change-return-value-type-to-void/20250311-193230
base:   linus/master
patch link:    https://lore.kernel.org/r/20250311112856.1020095-1-oushixiong1025%40163.com
patch subject: [PATCH 1/2] fbcon: Register sysfs groups through device_add_group
config: sparc-randconfig-001-20250312 (https://download.01.org/0day-ci/archive/20250312/202503121852.0x6J0c7a-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121852.0x6J0c7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121852.0x6J0c7a-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_deinit_device':
>> drivers/video/fbdev/core/fbcon.c:3390:37: error: 'fb_info' undeclared (first use in this function)
    3390 |                 device_remove_group(fb_info->dev, &fbcon_device_attr_group);
         |                                     ^~~~~~~
   drivers/video/fbdev/core/fbcon.c:3390:37: note: each undeclared identifier is reported only once for each function it appears in


vim +/fb_info +3390 drivers/video/fbdev/core/fbcon.c

  3388	
  3389		if (fbcon_has_sysfs) {
> 3390			device_remove_group(fb_info->dev, &fbcon_device_attr_group);
  3391	
  3392			fbcon_has_sysfs = 0;
  3393		}
  3394	}
  3395	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

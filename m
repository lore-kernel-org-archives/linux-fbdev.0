Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776226FA77
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501780; cv=none; b=K+CRQK/vLM+iC2maU5MLeh1fjGRXagMTWUoNSlT9/ebMkcN+1b9ECDBC8XUNcYlM0etyp90JtD6krZCQ8jZURtIEGoWTuvsg5sXa4p7ircv/Hsq5S/Uc5AR7o9JPsNAaiUI2dFwC3lUACyPhihIgpC595BkKz5hlwRknPiF9Wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501780; c=relaxed/simple;
	bh=aGSHk5h8a4Od06LiU+U1O3nBJuXGoWX6fO+wbq/Ogvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it/eZ94g1KWlC7y8woTFnyaxbMTeV1jri6L/lDGFLHlEzfzUxdy0+SMeteBayQ/c6Mrgx1iS3Ko7/1ohx5bFDNipLywTxAfu8w62Yl2TCJeLbRaJsB2IVQ/MZutZabicwYQmcNYZ64DtErwErm3XiKo7CtqCLmQeSskDggNg94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFrqCZGg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFrqCZGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770501780; x=1802037780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aGSHk5h8a4Od06LiU+U1O3nBJuXGoWX6fO+wbq/Ogvo=;
  b=CFrqCZGgoRW5dPSs7PlPcORDzkwONM2pRVs4cXQb3DcFK0NRmMQrKZRM
   BLCoFyzFUTHcKVslwl5qYn6S9Uwtjus3XYWqvY3SfRnbyTMVhu43XplTP
   SqS2VeG3G5FMH04dsmOkuOlwQMIPGl96xX5O3KtAiBX4ACWpk6KMZL8Xq
   wm16dA+7pyrfHPcYDzFtwjAKeqQBvKfjCofXbTg6VGmj0YfgJk/rME2VD
   pDeLOhmfz5+h/h1klYhsN8nPkC2blDCVYw1SmZtCsrcFpfsBZAF6vdEsJ
   caV+ZpAtM8iy8s6bj+VGlRKe99P0hCZQrs3zZoxUjs3hYghUINK/edQK8
   g==;
X-CSE-ConnectionGUID: R4HbKeGyRlatLfY622nFVg==
X-CSE-MsgGUID: cGuA2YeeQ2yC7l6MfI3ahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="71568423"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="71568423"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 14:03:00 -0800
X-CSE-ConnectionGUID: pyaCtHXAQ46+PFmUa4BY9A==
X-CSE-MsgGUID: 5qTiilBwSCCs3RiwNWA2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="241514582"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Feb 2026 14:02:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voqOF-00000000luK-0tqF;
	Sat, 07 Feb 2026 22:02:55 +0000
Date: Sun, 8 Feb 2026 06:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] fbdev: au1100fb: Make driver compilable on
 non-mips platforms
Message-ID: <202602080635.w8n9dF6S-lkp@intel.com>
References: <b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0636e6205beed850d985276dc56fd73d785bea5c]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fbdev-au1100fb-Don-t-store-device-specific-data-in-global-variables/20260208-011505
base:   0636e6205beed850d985276dc56fd73d785bea5c
patch link:    https://lore.kernel.org/r/b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig%40baylibre.com
patch subject: [PATCH v2 4/4] fbdev: au1100fb: Make driver compilable on non-mips platforms
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260208/202602080635.w8n9dF6S-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602080635.w8n9dF6S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602080635.w8n9dF6S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/au1100fb.c:551:29: warning: 'fbregs' defined but not used [-Wunused-variable]
     551 | static struct au1100fb_regs fbregs;
         |                             ^~~~~~


vim +/fbregs +551 drivers/video/fbdev/au1100fb.c

^1da177e4c3f415 drivers/video/au1100fb.c Linus Torvalds   2005-04-16  549  
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26  550  #ifdef CONFIG_PM
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26 @551  static struct au1100fb_regs fbregs;
f77f50ca1a236ae drivers/video/au1100fb.c Rodolfo Giometti 2006-06-26  552  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

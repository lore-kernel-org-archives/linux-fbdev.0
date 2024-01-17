Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3E25621
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528404; cv=none; b=BGVIbgboFjnI8A0wAul5E3TR5y1qANzy0TUo5GMMUtggD6NzFsPxoQDrIwKGSVqK5VM2h8toBJ5gEvzEGU7QEYx+SxML1oVwNkdm8bMFbVnX5D1TNSpVHZM/zc5/kMOdy4imzJGh2zdXb2H4pqvDBn3lapIxbGyE8r7/v0FHSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528404; c=relaxed/simple;
	bh=CZFomuzaELJmIoa5gpuAsnH07X7XzQXCFB1I2qrnzNg=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GsmPgRIaDaQs+eolI7X9AFWKvQQ4lIAfcpKRkKqK1ASZWzGzcjw+CsPYs4PT6U0dguvkzA80F+I9KJGrC91IMhBAPkFmvp0ZHgn94NDO80MOhmDx6pYvjTGXr0zqvD3NHprJWM+XED01XIts/cAY6KoDucdabctzM8qQ3ulHF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkP/a1pv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkP/a1pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705528403; x=1737064403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CZFomuzaELJmIoa5gpuAsnH07X7XzQXCFB1I2qrnzNg=;
  b=RkP/a1pvsy7iuU88/gEdnPXdJb7Q1e1p+zkGYA1Dch1krGcSutD88UT0
   dWquapE4XimNiWYhEzjzLjSY3/jEfwKlYSxmmkVHCG16EE2Vcwhcba6DC
   Gazx8ohlgw0R/gxEGtUie2r8kJSnjXsx6mymOYimFQ1OCArFcBsqKt7X6
   c8csywghSVp/P1qofvXCnguKGzX9nnrmewdvztATxHnIC7bxsqRs1CEPH
   yYmrt1yXhikoepwFMsWXNVTzFeHgtjI+t0UT47jE2uyDBNEbVN7X7L1/y
   dIMo0hSMRb2b53VYDbL066WVUZK31HY9X1k2JiXp9vKYia8yN+CYf0mkp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="6982467"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="6982467"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 13:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="874908487"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="874908487"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2024 13:53:19 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQDqX-0002Mk-1L;
	Wed, 17 Jan 2024 21:53:17 +0000
Date: Thu, 18 Jan 2024 05:52:20 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
	deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] video/cmdline: Hide __video_get_options() behind
 CONFIG_FB_CORE
Message-ID: <202401180531.K8mdBrAu-lkp@intel.com>
References: <20240115100939.21562-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115100939.21562-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 05b317e8457c8e2bd1a797c9440ec07b7f341584]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/video-cmdline-Introduce-CONFIG_VIDEO-for-video-parameter/20240115-181419
base:   05b317e8457c8e2bd1a797c9440ec07b7f341584
patch link:    https://lore.kernel.org/r/20240115100939.21562-3-tzimmermann%40suse.de
patch subject: [PATCH 2/3] video/cmdline: Hide __video_get_options() behind CONFIG_FB_CORE
config: i386-randconfig-011-20240118 (https://download.01.org/0day-ci/archive/20240118/202401180531.K8mdBrAu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401180531.K8mdBrAu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180531.K8mdBrAu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/video/fbdev/core/fb_cmdline.c: In function 'fb_get_options':
>> drivers/video/fbdev/core/fb_cmdline.c:45:19: error: implicit declaration of function '__video_get_options'; did you mean 'video_get_options'? [-Werror=implicit-function-declaration]
      45 |         enabled = __video_get_options(name, &options, is_of);
         |                   ^~~~~~~~~~~~~~~~~~~
         |                   video_get_options
   cc1: some warnings being treated as errors


vim +45 drivers/video/fbdev/core/fb_cmdline.c

367221793d4796 Thomas Zimmermann 2023-02-09  23  
ea6763c104c93a Daniel Vetter     2014-08-06  24  /**
ea6763c104c93a Daniel Vetter     2014-08-06  25   * fb_get_options - get kernel boot parameters
ea6763c104c93a Daniel Vetter     2014-08-06  26   * @name:   framebuffer name as it would appear in
ea6763c104c93a Daniel Vetter     2014-08-06  27   *          the boot parameter line
ea6763c104c93a Daniel Vetter     2014-08-06  28   *          (video=<name>:<options>)
ea6763c104c93a Daniel Vetter     2014-08-06  29   * @option: the option will be stored here
ea6763c104c93a Daniel Vetter     2014-08-06  30   *
73ce73c30ba9ae Thomas Zimmermann 2023-02-09  31   * The caller owns the string returned in @option and is
73ce73c30ba9ae Thomas Zimmermann 2023-02-09  32   * responsible for releasing the memory.
73ce73c30ba9ae Thomas Zimmermann 2023-02-09  33   *
ea6763c104c93a Daniel Vetter     2014-08-06  34   * NOTE: Needed to maintain backwards compatibility
ea6763c104c93a Daniel Vetter     2014-08-06  35   */
ea6763c104c93a Daniel Vetter     2014-08-06  36  int fb_get_options(const char *name, char **option)
ea6763c104c93a Daniel Vetter     2014-08-06  37  {
93604a5ade3a02 Thomas Zimmermann 2023-02-09  38  	const char *options = NULL;
93604a5ade3a02 Thomas Zimmermann 2023-02-09  39  	bool is_of = false;
93604a5ade3a02 Thomas Zimmermann 2023-02-09  40  	bool enabled;
cedaf7cddd7339 Thomas Zimmermann 2023-02-09  41  
93604a5ade3a02 Thomas Zimmermann 2023-02-09  42  	if (name)
93604a5ade3a02 Thomas Zimmermann 2023-02-09  43  		is_of = strncmp(name, "offb", 4);
ea6763c104c93a Daniel Vetter     2014-08-06  44  
93604a5ade3a02 Thomas Zimmermann 2023-02-09 @45  	enabled = __video_get_options(name, &options, is_of);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8ED10F1
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Feb 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707012972; cv=none; b=XzMgOFE097sqv/QSi4E1WPN2hRplPTcqi6v40CrpT1OcY1MGFpV4Eh5LOCCRpscxHqCbZ16e/CfXND4ob8Mza1ZKvc+QH3xFINeUEYu+jrgH+M9P5qSZoLF9m2e26Fl54/IIv1hxh2Kj4osYg7IbWNUJ+7ZKf3uKk95nGqfPNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707012972; c=relaxed/simple;
	bh=vjhvToWHnh83ymJbga+ySukmrzU3KaiIfJGjjnavqxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIAwZHj702mhF79RIU33PCrZAAfABCuSrlU1buAlcoFSCj3wEaG73CF3sfoZb62/G8BKHqQtTARSSgx1DlhH+CbYdZieZmqt35x1JKy/H3Zs4aEh541D266VDFZz/c5x/J/VymrJ9Lr3t45JeQfzFm6e3NSRpkJ8R49t4Mb7lPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+CltAjp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+CltAjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707012969; x=1738548969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjhvToWHnh83ymJbga+ySukmrzU3KaiIfJGjjnavqxs=;
  b=Q+CltAjpZhErpVu/oC1Z2wTAWKO3ACYnntJWVYYZ8Nqu88G4lkOL9tLt
   ApCh6YoZr1MgYkPIVsfZIDrgHesIXOvVVrgVa5vJNIIpLwBrdIjwBy2LR
   owOJhUrdnPwC8MM50FU1RcbGmeTkKQPjQSitL1prQF88OlWQkLynFor5r
   uAKEmBLCgLtE25vLwMoGmIQizK9p4bTRd0DXua0aO202ACHOARm47+09A
   Ltaagt1oWrPJWoKeaYDZO+vXUApg3ghJOpQUsppSpADDu6JrZr4RbgKFT
   eYcpoJRF7/pCImXni1A7mklGy15d05zkh/maNCeGIxghbl7OtNLd9hTGV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="508507"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="508507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 18:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="932832617"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="932832617"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2024 18:16:06 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWS1o-0005so-0A;
	Sun, 04 Feb 2024 02:15:01 +0000
Date: Sun, 4 Feb 2024 10:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
	pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/8] firmware/sysfb: Set firmware-framebuffer parent
 device
Message-ID: <202402041001.rJrT47HE-lkp@intel.com>
References: <20240202120140.3517-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202120140.3517-4-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/video-Add-helpers-for-decoding-screen_info/20240202-200314
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240202120140.3517-4-tzimmermann%40suse.de
patch subject: [PATCH v2 3/8] firmware/sysfb: Set firmware-framebuffer parent device
config: i386-buildonly-randconfig-003-20240203 (https://download.01.org/0day-ci/archive/20240204/202402041001.rJrT47HE-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041001.rJrT47HE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041001.rJrT47HE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/sysfb.c:104:41: error: too many arguments to function call, expected 2, have 3
     104 |                 pd = sysfb_create_simplefb(si, &mode, parent);
         |                      ~~~~~~~~~~~~~~~~~~~~~            ^~~~~~
   include/linux/sysfb.h:105:39: note: 'sysfb_create_simplefb' declared here
     105 | static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
         |                                       ^                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     106 |                                                             const struct simplefb_platform_data *mode)
         |                                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +104 drivers/firmware/sysfb.c

    83	
    84	static __init int sysfb_init(void)
    85	{
    86		struct screen_info *si = &screen_info;
    87		struct device *parent;
    88		struct simplefb_platform_data mode;
    89		const char *name;
    90		bool compatible;
    91		int ret = 0;
    92	
    93		mutex_lock(&disable_lock);
    94		if (disabled)
    95			goto unlock_mutex;
    96	
    97		sysfb_apply_efi_quirks();
    98	
    99		parent = sysfb_parent_dev(si);
   100	
   101		/* try to create a simple-framebuffer device */
   102		compatible = sysfb_parse_mode(si, &mode);
   103		if (compatible) {
 > 104			pd = sysfb_create_simplefb(si, &mode, parent);
   105			if (!IS_ERR(pd))
   106				goto unlock_mutex;
   107		}
   108	
   109		/* if the FB is incompatible, create a legacy framebuffer device */
   110		if (si->orig_video_isVGA == VIDEO_TYPE_EFI)
   111			name = "efi-framebuffer";
   112		else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
   113			name = "vesa-framebuffer";
   114		else if (si->orig_video_isVGA == VIDEO_TYPE_VGAC)
   115			name = "vga-framebuffer";
   116		else if (si->orig_video_isVGA == VIDEO_TYPE_EGAC)
   117			name = "ega-framebuffer";
   118		else
   119			name = "platform-framebuffer";
   120	
   121		pd = platform_device_alloc(name, 0);
   122		if (!pd) {
   123			ret = -ENOMEM;
   124			goto unlock_mutex;
   125		}
   126	
   127		pd->dev.parent = parent;
   128	
   129		sysfb_set_efifb_fwnode(pd);
   130	
   131		ret = platform_device_add_data(pd, si, sizeof(*si));
   132		if (ret)
   133			goto err;
   134	
   135		ret = platform_device_add(pd);
   136		if (ret)
   137			goto err;
   138	
   139		goto unlock_mutex;
   140	err:
   141		platform_device_put(pd);
   142	unlock_mutex:
   143		mutex_unlock(&disable_lock);
   144		return ret;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

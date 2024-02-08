Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857CC6F539
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Feb 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394006; cv=none; b=q3JvsFywHpJqpjNcMhkzUAqmplzFjmJ0fVZvIRLQshtMYsoGGumh3ZLWBsbJpS5goCGAY2zUu1eUjSE2kwKdNHgxM9+QQPkuraZulSgBnfCR5PMFI9Mz1gODCEwydwv/hKmJqOXR8n6C5kqcEKcSfQRCvkr+f+US9RfOtIQLgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394006; c=relaxed/simple;
	bh=X3RpNgRFWg4hYHY+7/7QHHs4Uc4xM4YTy5Dg8CxGXPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWr2lnbp5xnBa8dbvoCIFdTSjcjEHVxpfPoO/N/GzxtUn844GFme3uZgVhuUxpHtpHp8tR3sOwTDVn01clMT6QltQ4fKqsW97/GIV9i9HR0piwtxQx8mA4vco0dTiERe1MM8DVe//3oEOR1JrtUI1TCkcE1LW4+Bd4Vva4skFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+DznDxE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+DznDxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394005; x=1738930005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3RpNgRFWg4hYHY+7/7QHHs4Uc4xM4YTy5Dg8CxGXPc=;
  b=J+DznDxEqeIQKJ2hS8gBp3gVryBtLNgBYoD81hAnNMQ/KiBA/5wIbi6l
   Crfq3baBJbEuCIVZ0sY++uxVa1Wz+an07GNzzydamKV7HF44FZy576Pn7
   d2Qy6e745YJLYR1HGwsEw0sovb74sKyar+jtD+Gn4R14IEUbmkcY5HPUi
   c1a3IsiKxlSDIaJXgFZX3k8NeJscBiqXjPAybrWzkPXMRJkAE1cis/sMb
   VHWz0151GeLASbvwwBwKmm6l6lMhaB2nymaHPJccTYVXXL99p2I3awOZ4
   yhlv1b01NrcZj6J2J72xh95Y6vD3CDcPggHdbRIYuh2gHWJksHqt4iZ5V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4185568"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4185568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="32449826"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 04:06:40 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY3Ar-0003iu-2n;
	Thu, 08 Feb 2024 12:06:37 +0000
Date: Thu, 8 Feb 2024 20:06:26 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
	sui.jingfeng@linux.dev, pjones@redhat.com, deller@gmx.de,
	ardb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/8] firmware/sysfb: Set firmware-framebuffer parent
 device
Message-ID: <202402081952.wLKLCXmW-lkp@intel.com>
References: <20240207134932.7321-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207134932.7321-4-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-tip/drm-tip linus/master v6.8-rc3 next-20240208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/video-Add-helpers-for-decoding-screen_info/20240207-215100
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240207134932.7321-4-tzimmermann%40suse.de
patch subject: [PATCH v3 3/8] firmware/sysfb: Set firmware-framebuffer parent device
config: i386-randconfig-141-20240208 (https://download.01.org/0day-ci/archive/20240208/202402081952.wLKLCXmW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081952.wLKLCXmW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402081952.wLKLCXmW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/sysfb.c:36:
   include/linux/sysfb.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
>> include/linux/sysfb.h:105:39: warning: 'sysfb_create_simplefb' used but never defined
     105 | static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
         |                                       ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/video/aperture.c:10:
   include/linux/sysfb.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
>> include/linux/sysfb.h:105:39: warning: 'sysfb_create_simplefb' declared 'static' but never defined [-Wunused-function]
     105 | static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
         |                                       ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/firmware/efi/sysfb_efi.c:26:
   include/linux/sysfb.h:108:1: error: expected identifier or '(' before '{' token
     108 | {
         | ^
>> include/linux/sysfb.h:105:39: warning: 'sysfb_create_simplefb' declared 'static' but never defined [-Wunused-function]
     105 | static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
         |                                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/sysfb_efi.c:345:39: warning: 'efifb_fwnode_ops' defined but not used [-Wunused-const-variable=]
     345 | static const struct fwnode_operations efifb_fwnode_ops = {
         |                                       ^~~~~~~~~~~~~~~~
   drivers/firmware/efi/sysfb_efi.c:238:35: warning: 'efifb_dmi_swap_width_height' defined but not used [-Wunused-const-variable=]
     238 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/sysfb_efi.c:188:35: warning: 'efifb_dmi_system_table' defined but not used [-Wunused-const-variable=]
     188 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~


vim +/sysfb_create_simplefb +105 include/linux/sysfb.h

e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  104  
9e121040e54abe include/linux/sysfb.h        Javier Martinez Canillas 2022-06-07 @105  static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
c0a4e7e120d3e9 include/linux/sysfb.h        Thomas Zimmermann        2024-02-07  106  							    const struct simplefb_platform_data *mode,
c0a4e7e120d3e9 include/linux/sysfb.h        Thomas Zimmermann        2024-02-07  107  							    struct device *parent);
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02 @108  {
9e121040e54abe include/linux/sysfb.h        Javier Martinez Canillas 2022-06-07  109  	return ERR_PTR(-EINVAL);
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  110  }
e3263ab389a7bc arch/x86/include/asm/sysfb.h David Rheinsberg         2013-08-02  111  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

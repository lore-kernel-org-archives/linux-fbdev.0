Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D823DD;
	Sun, 22 Jun 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750558973; cv=none; b=oOAuBVt5l41GF0V9TJFSe12VKRHpMlQnkKzNv4Zl06iPE2ZV0iW+CFS5omN2GPRl6GAkxHI+UiPY30BCZIhMxhAdPC68ncA0ZUXACLfBD6Z/fJOR++/rg2jv+5U58TF0t+1Z1JLoP9AKJnk+AS1QpIMDT6ky6Oq4invWCXK7h/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750558973; c=relaxed/simple;
	bh=smT81ZGikL0XcHJsLT8lEppkH+fN2eauAFmorGIVhYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f91BjeolmLKJyjlpszS/+M5160b8J1qXw/8s4+ZaW1w3+C7TRuVgUdOJs3zmMrL7PGRQtj/3NX/isAxVRVQYl4dLS+KYMp3g6W/azHgzLCgdvMmc5Xc2wrNtJ8Rl0wMWNcK75wWALPI2S+OZVxmEr/Bb+S7e+FB1nAPQ2ieZgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF4hJt2J; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF4hJt2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750558971; x=1782094971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smT81ZGikL0XcHJsLT8lEppkH+fN2eauAFmorGIVhYQ=;
  b=gF4hJt2Jdgc4ItUSf9T8n9DOf7j+DzVjsfGafvafKoaY8TwGprBehI4f
   N8+1BwWXdcHzoMefykYmz1a91CExg21280zflgfNT6cFuAxG7jyiMUiam
   srTfj8OrY7I7oL4mEEukKnP58HS1n1c054vxv/4HVQX70gfBQ6auoiI9d
   yv51Ude9lqkCeUxik6SzA9WZ5uLNYjrhiEWEZ63iVJVLepgM9ue1HXh9P
   cNtu5JuasvxBklSlBdQ7LEytwLkgMGy4k8coCmEcj6PSi6AyfqrBJ1W22
   sk7ZfyfSckRnKKG5LRHAzq1Njj7/KE0pkyltBijyaZtCLyebNqWkj9iNW
   g==;
X-CSE-ConnectionGUID: ODGdPXiBRcOfZkDiWVr5zg==
X-CSE-MsgGUID: NhHsfJ1hQjiixNvF1gVp1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="51895306"
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="51895306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 19:22:50 -0700
X-CSE-ConnectionGUID: r9sRgp3PR7evIMRC0XykFQ==
X-CSE-MsgGUID: jWAxPm+4Qau9LxeZXkF/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="182127439"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jun 2025 19:22:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTAM0-000MzG-1C;
	Sun, 22 Jun 2025 02:22:44 +0000
Date: Sun, 22 Jun 2025 10:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] fbdev/simplefb: Add support for interconnect paths
Message-ID: <202506221019.ooLo1xBw-lkp@intel.com>
References: <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>

Hi Luca,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Weiss/dt-bindings-display-simple-framebuffer-Add-interconnects-property/20250620-183302
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250620-simple-drm-fb-icc-v1-3-d92142e8f74f%40fairphone.com
patch subject: [PATCH 3/3] fbdev/simplefb: Add support for interconnect paths
config: sparc-randconfig-r063-20250622 (https://download.01.org/0day-ci/archive/20250622/202506221019.ooLo1xBw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506221019.ooLo1xBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506221019.ooLo1xBw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/video/fbdev/simplefb.c: In function 'simplefb_detach_icc':
>> drivers/video/fbdev/simplefb.c:542:14: error: 'struct simplefb_par' has no member named 'icc_count'
     542 |  for (i = par->icc_count - 1; i >= 0; i--) {
         |              ^~
>> drivers/video/fbdev/simplefb.c:543:26: error: 'struct simplefb_par' has no member named 'icc_paths'
     543 |   if (!IS_ERR_OR_NULL(par->icc_paths[i]))
         |                          ^~
   drivers/video/fbdev/simplefb.c:544:15: error: 'struct simplefb_par' has no member named 'icc_paths'
     544 |    icc_put(par->icc_paths[i]);
         |               ^~
   drivers/video/fbdev/simplefb.c: In function 'simplefb_attach_icc':
   drivers/video/fbdev/simplefb.c:564:5: error: 'struct simplefb_par' has no member named 'icc_count'
     564 |  par->icc_count = count / 2;
         |     ^~
   drivers/video/fbdev/simplefb.c:566:5: error: 'struct simplefb_par' has no member named 'icc_paths'
     566 |  par->icc_paths = devm_kcalloc(dev, par->icc_count,
         |     ^~
   drivers/video/fbdev/simplefb.c:566:40: error: 'struct simplefb_par' has no member named 'icc_count'
     566 |  par->icc_paths = devm_kcalloc(dev, par->icc_count,
         |                                        ^~
   drivers/video/fbdev/simplefb.c:567:22: error: 'struct simplefb_par' has no member named 'icc_paths'
     567 |           sizeof(*par->icc_paths),
         |                      ^~
   drivers/video/fbdev/simplefb.c:569:10: error: 'struct simplefb_par' has no member named 'icc_paths'
     569 |  if (!par->icc_paths)
         |          ^~
   drivers/video/fbdev/simplefb.c:572:21: error: 'struct simplefb_par' has no member named 'icc_count'
     572 |  for (i = 0; i < par->icc_count; i++) {
         |                     ^~
   drivers/video/fbdev/simplefb.c:573:6: error: 'struct simplefb_par' has no member named 'icc_paths'
     573 |   par->icc_paths[i] = of_icc_get_by_index(dev, i);
         |      ^~
   drivers/video/fbdev/simplefb.c:574:25: error: 'struct simplefb_par' has no member named 'icc_paths'
     574 |   if (IS_ERR_OR_NULL(par->icc_paths[i])) {
         |                         ^~
   drivers/video/fbdev/simplefb.c:575:21: error: 'struct simplefb_par' has no member named 'icc_paths'
     575 |    ret = PTR_ERR(par->icc_paths[i]);
         |                     ^~
   drivers/video/fbdev/simplefb.c:582:23: error: 'struct simplefb_par' has no member named 'icc_paths'
     582 |   ret = icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
         |                       ^~
   drivers/video/fbdev/simplefb.c:594:26: error: 'struct simplefb_par' has no member named 'icc_paths'
     594 |   if (!IS_ERR_OR_NULL(par->icc_paths[i]))
         |                          ^~
   drivers/video/fbdev/simplefb.c:595:15: error: 'struct simplefb_par' has no member named 'icc_paths'
     595 |    icc_put(par->icc_paths[i]);
         |               ^~


vim +542 drivers/video/fbdev/simplefb.c

   532	
   533	#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
   534	/*
   535	 * Generic interconnect path handling code.
   536	 */
   537	static void simplefb_detach_icc(void *res)
   538	{
   539		struct simplefb_par *par = res;
   540		int i;
   541	
 > 542		for (i = par->icc_count - 1; i >= 0; i--) {
 > 543			if (!IS_ERR_OR_NULL(par->icc_paths[i]))
   544				icc_put(par->icc_paths[i]);
   545		}
   546	}
   547	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

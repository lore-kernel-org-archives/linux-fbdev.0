Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853B1F584C;
	Wed, 26 Nov 2025 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140213; cv=none; b=SgZ6KFP2d+sO/TgOrc5Yl1h29LHAqV55u7Ca7lEnwN0PNI+aVkKSRf1TsJbWJkvAMvx7wHh5TrELFg//bWN5PoDbBjE+v6NbOPGmNqh9k4sDcLe+YXyzmJQ/TY7gwm/o59julLRXidXGFrvGWHCEnwk3CcAuflelngNPy4kpQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140213; c=relaxed/simple;
	bh=mu/A6WTwOPzOFtjJtzxiGOLlJpJakjKpzGHoz5XkpY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+itmw7eUjSHxmJogdUk8QyIG0Lw+KvpExhQMLbmKJVO1mGMd+nJk8U5qBaPELU58vMD93w0Tk5a2uqiSwwWKTPIOsNUgnNU4i67NjuikiggurKihE69Z0fxf/VAfTjIWafUhmZbpw2uKYDCF0d+9A0aHpg3nf2v1llOWkx+70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwqvo+Fy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwqvo+Fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764140212; x=1795676212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mu/A6WTwOPzOFtjJtzxiGOLlJpJakjKpzGHoz5XkpY4=;
  b=Bwqvo+Fy3LrvkWdZy2XYSj/faMA4orGSKSJvgwVW/x06axBby2B3o6f+
   4ZEws5m8Ksg7p1zEHLZjPmjgawun8WamnN6wyCRhTDnhbfLDDV8enggzz
   zDI27is0mNvN8D3soNE0i42jz13m75l+dgRLoOTtVUxWOW58wt6Elq/6t
   XvywcntXXekJh2ZWETzv3dNdZt5PC4id5fiCLCMsRL6+hdzqx4ty/DpO5
   CLpjnIOvkWlrqxUwKRtT3gAk9Ey8Pfk5QgzqvpSsPjqDqDuDmtt1zpIbT
   P2oAXIGTofEg4qvaVqOXybAN7o2O6r1UjpUZd5CkOnzb+nqqrYQMSkjGA
   g==;
X-CSE-ConnectionGUID: wjh5h5AQR5aoWCA4l6BLeQ==
X-CSE-MsgGUID: IIPHRYz/S/6Cmu80MnYdJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77279923"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="77279923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:56:52 -0800
X-CSE-ConnectionGUID: o31zWgfrRUqmgMMDa8YZVQ==
X-CSE-MsgGUID: I2GaolsOQWKolPUqR1HrYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="230118861"
Received: from igk-lkp-server01.igk.intel.com (HELO 1f7de368ad0d) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 25 Nov 2025 22:56:50 -0800
Received: from kbuild by 1f7de368ad0d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO9SJ-000000000ej-1a9N;
	Wed, 26 Nov 2025 06:56:47 +0000
Date: Wed, 26 Nov 2025 07:55:50 +0100
From: kernel test robot <lkp@intel.com>
To: ssrane_b23@ee.vjti.ac.in, Zsolt Kajtar <soci@c64.rulez.org>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Subject: Re: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
Message-ID: <202511260749.KJgv3MyF-lkp@intel.com>
References: <20251119133821.89998-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133821.89998-1-ssranevjti@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.18-rc7 next-20251126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ssrane_b23-ee-vjti-ac-in/fbdev-core-Fix-vmalloc-out-of-bounds-in-fb_imageblit/20251119-215054
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251119133821.89998-1-ssranevjti%40gmail.com
patch subject: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251126/202511260749.KJgv3MyF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260749.KJgv3MyF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260749.KJgv3MyF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/video/fbdev/core/cfbimgblt.c:17:
   drivers/video/fbdev/core/fb_imageblit.h: In function 'fb_imageblit':
>> drivers/video/fbdev/core/fb_imageblit.h:490:23: warning: unused variable 'max_offset_bytes' [-Wunused-variable]
     490 |         unsigned long max_offset_bytes;
         |                       ^~~~~~~~~~~~~~~~


vim +/max_offset_bytes +490 drivers/video/fbdev/core/fb_imageblit.h

   480	
   481	static inline void fb_imageblit(struct fb_info *p, const struct fb_image *image)
   482	{
   483		int bpp = p->var.bits_per_pixel;
   484		unsigned int bits_per_line = BYTES_TO_BITS(p->fix.line_length);
   485		struct fb_address dst = fb_address_init(p);
   486		struct fb_reverse reverse = fb_reverse_init(p);
   487		const u32 *palette = fb_palette(p);
   488		struct fb_image clipped_image;
   489		u32 max_x, max_y;
 > 490		unsigned long max_offset_bytes;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

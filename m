Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8630F537;
	Thu, 20 Nov 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630694; cv=none; b=aWAvsZ2ZlNQ5+nK9z1vp4wCerqM1oojL/c0S5GdxrqWIGOeuG7lufNEQBf1tqBOia1g2Suv2qeQLpadwWQgFDWGhtzR+lgo2vE5u2mlbwsg2USE9Ea6qmllZQos5WlAli+ozAszFKnBwF7WC3u/n/ACFMTAnmlRZsX7rbrV4t4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630694; c=relaxed/simple;
	bh=OPjNc/gUByCFqZ8Vixc1KLela/ta95EHDRNxS4C1lGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/mOrlYI0PS80blwoaocSrKAA6y5THkZPcwqmme5IfCYimNjkt2/DTQYgGo5mddlYoSgBiBFvDC6FQ7jN459baLxMmfqIkDcKZnbhC1j1VoAUjtTcJPUU0iAj6gwcJTqVMOvJpjUTNKOONIf3Da3mcqeGeKJyUEgPZolmVPAbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV20VqFq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CV20VqFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763630692; x=1795166692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPjNc/gUByCFqZ8Vixc1KLela/ta95EHDRNxS4C1lGg=;
  b=CV20VqFq89ihkJjPyfW+oerCjks9HKS86+SVzFyRYcCQEncZhwrl3WF6
   HVnHSdPGDXGv3ZAzfQNA/P2PAfdcfkqWUeZa6iSo/FkVSZe+xSUBPrVKn
   pYkE425FghOB/kXcatSBMp5I3OGrV9+jENP3EAzQFS2jFHKZf8QcdEhNX
   RL7Rgmdu3GFK8m8G0wVf+TdQTMwP5M131k5/qEhZRPTxq144x3p6xRWzy
   kpHmF2Y0ZinbyM7COW10H3yFTrbqtR5WNQ/gy48LndWnjpPN9+MS+iOuv
   ocNtLrUReM0tr487Rv6R82cyU/S6x+TGs/IK6LdoqfHyLzMqNwlq5p3G7
   w==;
X-CSE-ConnectionGUID: GWtwdQTMQFWAT1jyLuyG7w==
X-CSE-MsgGUID: lfbjL8SJTLOaNFSv4H52dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572011"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65572011"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:24:51 -0800
X-CSE-ConnectionGUID: c33I7xXpT0ibIp+AOLBl8w==
X-CSE-MsgGUID: 2SrIl1SnRwWseOQT7lVhaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="221957870"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2025 01:24:49 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM0uD-0003oF-2q;
	Thu, 20 Nov 2025 09:24:45 +0000
Date: Thu, 20 Nov 2025 17:23:58 +0800
From: kernel test robot <lkp@intel.com>
To: ssrane_b23@ee.vjti.ac.in, Zsolt Kajtar <soci@c64.rulez.org>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Subject: Re: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
Message-ID: <202511201752.4fVbQwPc-lkp@intel.com>
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
[also build test WARNING on drm-tip/drm-tip linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ssrane_b23-ee-vjti-ac-in/fbdev-core-Fix-vmalloc-out-of-bounds-in-fb_imageblit/20251119-215054
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251119133821.89998-1-ssranevjti%40gmail.com
patch subject: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
config: nios2-randconfig-r073-20251120 (https://download.01.org/0day-ci/archive/20251120/202511201752.4fVbQwPc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201752.4fVbQwPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201752.4fVbQwPc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/video/fbdev/core/cfbimgblt.c:17:
   drivers/video/fbdev/core/fb_imageblit.h: In function 'fb_imageblit':
>> drivers/video/fbdev/core/fb_imageblit.h:490:16: warning: unused variable 'max_offset_bytes' [-Wunused-variable]
     490 |  unsigned long max_offset_bytes;
         |                ^~~~~~~~~~~~~~~~


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

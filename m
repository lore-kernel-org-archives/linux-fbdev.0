Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844E22DF8E
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Mar 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622222; cv=none; b=EQsRqP6qBwCs7H79fTIr+9Guj5bputhWoCcHtN4a65v/R2Kf7KMBx/1Vh3hbmssh+V77dAied+cOSc3iVpIOW86dHgkpqtpQnDeGaSHMkC5YRdH7OuUc4fBtagio0mkfOO2zqnDCyIItObwxf/xvXB2CH7wiOdXbDxTGtL2eIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622222; c=relaxed/simple;
	bh=HUOoS96yEGNDr6tmWxBEsNiNGsOwUXnMZoZqjoX9vAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqxnxf1CLLxi1AfCYLADGlEJ78xJDNn2nu4Z/bCUa4/LBoSMpTBKeT6V0Eb4t+t1q14Utzb2BBQaplab3oiQwb+tX+btIXdzxpBL/eI+PdDyME1Lcm/kzZDcu+D0B6jZILRolcsOhvKbFy51d+MUMLYdzpo5RP1Jhp0BSsDedOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVGCPUE2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVGCPUE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741622220; x=1773158220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUOoS96yEGNDr6tmWxBEsNiNGsOwUXnMZoZqjoX9vAA=;
  b=jVGCPUE2yavaZ6Ej4W6xwNBOM/G+mAAiMgjk25ZeAyzE4o3OURIJLwOa
   DbH/cxjtkpQi1ze8COSd24mvEET73nfydGkqs2jxuCK6oFp1/6Bc2wZO4
   mV0Kv8NLV3ydvdp6tDY+dH6VPjDkAsRwSj2wEdR0yuopafyW2tXx08sJ0
   7mDIKtkSE0Wk1M4QKHAjTQUpYeQcJScmbhU5Tk/R7aZBaJMa72G9QuNOB
   Pe+0gJ/pLD8Ln14wglTelVqi+3UAdmzi8ZqZB0uOI7ZfxLx2zZ1klqN9J
   216rYHA1gItlS/ytbZCXn/RuhMqqIslpDEziL7D4I/+O9Hj+6J0SjnDXa
   w==;
X-CSE-ConnectionGUID: zVxi/Um0SbimEX1SGoQz8Q==
X-CSE-MsgGUID: RGcD/Tf9QS2Y3R/ZaWHbxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65081037"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="65081037"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:56:59 -0700
X-CSE-ConnectionGUID: h9n+icFATluKVx9K7ImYmQ==
X-CSE-MsgGUID: pgat/bVPTj+l6ZZfBU3B7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125260838"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 10 Mar 2025 08:56:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trfUs-0004Pw-35;
	Mon, 10 Mar 2025 15:56:54 +0000
Date: Mon, 10 Mar 2025 23:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zsolt Kajtar <soci@c64.rulez.org>
Subject: Re: [PATCH RESEND 1/2] Refactoring the fbcon packed pixel drawing
 routines
Message-ID: <202503102312.rSGvBwl1-lkp@intel.com>
References: <20250309184716.13732-2-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309184716.13732-2-soci@c64.rulez.org>

Hi Zsolt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zsolt-Kajtar/Refactoring-the-fbcon-packed-pixel-drawing-routines/20250310-025619
base:   linus/master
patch link:    https://lore.kernel.org/r/20250309184716.13732-2-soci%40c64.rulez.org
patch subject: [PATCH RESEND 1/2] Refactoring the fbcon packed pixel drawing routines
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250310/202503102312.rSGvBwl1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503102312.rSGvBwl1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503102312.rSGvBwl1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/video/fbdev/wmt_ge_rops.c:15:
>> drivers/video/fbdev/core/fb_draw.h:16:48: warning: declaration of 'struct fb_address' will not be visible outside of this function [-Wvisibility]
      16 | static inline void fb_address_move_long(struct fb_address *adr, int offset)
         |                                                ^
   drivers/video/fbdev/core/fb_draw.h:18:5: error: incomplete definition of type 'struct fb_address'
      18 |         adr->address += offset * (BITS_PER_LONG / BITS_PER_BYTE);
         |         ~~~^
   drivers/video/fbdev/core/fb_draw.h:16:48: note: forward declaration of 'struct fb_address'
      16 | static inline void fb_address_move_long(struct fb_address *adr, int offset)
         |                                                ^
   drivers/video/fbdev/core/fb_draw.h:22:46: warning: declaration of 'struct fb_address' will not be visible outside of this function [-Wvisibility]
      22 | static inline void fb_address_forward(struct fb_address *adr, unsigned int offset)
         |                                              ^
   drivers/video/fbdev/core/fb_draw.h:24:39: error: incomplete definition of type 'struct fb_address'
      24 |         unsigned int bits = (unsigned int)adr->bits + offset;
         |                                           ~~~^
   drivers/video/fbdev/core/fb_draw.h:22:46: note: forward declaration of 'struct fb_address'
      22 | static inline void fb_address_forward(struct fb_address *adr, unsigned int offset)
         |                                              ^
   drivers/video/fbdev/core/fb_draw.h:26:5: error: incomplete definition of type 'struct fb_address'
      26 |         adr->bits = bits & (BITS_PER_LONG - 1u);
         |         ~~~^
   drivers/video/fbdev/core/fb_draw.h:22:46: note: forward declaration of 'struct fb_address'
      22 | static inline void fb_address_forward(struct fb_address *adr, unsigned int offset)
         |                                              ^
   drivers/video/fbdev/core/fb_draw.h:27:5: error: incomplete definition of type 'struct fb_address'
      27 |         adr->address += (bits & ~(BITS_PER_LONG - 1u)) / BITS_PER_BYTE;
         |         ~~~^
   drivers/video/fbdev/core/fb_draw.h:22:46: note: forward declaration of 'struct fb_address'
      22 | static inline void fb_address_forward(struct fb_address *adr, unsigned int offset)
         |                                              ^
   drivers/video/fbdev/core/fb_draw.h:31:47: warning: declaration of 'struct fb_address' will not be visible outside of this function [-Wvisibility]
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:33:16: error: incomplete definition of type 'struct fb_address'
      33 |         int bits = adr->bits - (int)offset;
         |                    ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:35:5: error: incomplete definition of type 'struct fb_address'
      35 |         adr->bits = bits & (BITS_PER_LONG - 1);
         |         ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:37:6: error: incomplete definition of type 'struct fb_address'
      37 |                 adr->address -= (adr->bits - bits) / BITS_PER_BYTE;
         |                 ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:37:23: error: incomplete definition of type 'struct fb_address'
      37 |                 adr->address -= (adr->bits - bits) / BITS_PER_BYTE;
         |                                  ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:39:6: error: incomplete definition of type 'struct fb_address'
      39 |                 adr->address += (bits - adr->bits) / BITS_PER_BYTE;
         |                 ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:39:30: error: incomplete definition of type 'struct fb_address'
      39 |                 adr->address += (bits - adr->bits) / BITS_PER_BYTE;
         |                                         ~~~^
   drivers/video/fbdev/core/fb_draw.h:31:47: note: forward declaration of 'struct fb_address'
      31 | static inline void fb_address_backward(struct fb_address *adr, unsigned int offset)
         |                                               ^
   drivers/video/fbdev/core/fb_draw.h:50:34: warning: declaration of 'struct fb_address' will not be visible outside of this function [-Wvisibility]
      50 |                                     int offset, const struct fb_address *dst)
         |                                                              ^
   drivers/video/fbdev/core/fb_draw.h:52:2: error: call to undeclared function 'fb_write_offset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      52 |         fb_write_offset(fb_comp(val, fb_read_offset(offset, dst), mask), offset, dst);
         |         ^
   drivers/video/fbdev/core/fb_draw.h:52:2: note: did you mean 'fb_modify_offset'?
   drivers/video/fbdev/core/fb_draw.h:49:20: note: 'fb_modify_offset' declared here
      49 | static inline void fb_modify_offset(unsigned long val, unsigned long mask,
         |                    ^
      50 |                                     int offset, const struct fb_address *dst)
      51 | {
      52 |         fb_write_offset(fb_comp(val, fb_read_offset(offset, dst), mask), offset, dst);
         |         ~~~~~~~~~~~~~~~
         |         fb_modify_offset
   drivers/video/fbdev/core/fb_draw.h:52:31: error: call to undeclared function 'fb_read_offset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      52 |         fb_write_offset(fb_comp(val, fb_read_offset(offset, dst), mask), offset, dst);
         |                                      ^
   drivers/video/fbdev/wmt_ge_rops.c:57:8: error: call to undeclared function 'pixel_to_pat'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      57 |         pat = pixel_to_pat(p->var.bits_per_pixel, fg);
         |               ^
   4 warnings and 13 errors generated.


vim +16 drivers/video/fbdev/core/fb_draw.h

    14	
    15	/* move the address pointer by the number of words */
  > 16	static inline void fb_address_move_long(struct fb_address *adr, int offset)
    17	{
    18		adr->address += offset * (BITS_PER_LONG / BITS_PER_BYTE);
    19	}
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

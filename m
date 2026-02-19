Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0A22CBF1;
	Thu, 19 Feb 2026 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771466961; cv=none; b=jzVjdd5MrAy0De5iqLmA/TCus+IY3m5ffffRtYw+9jpZJia4mAEiEsoMGVFQHn+QwpCkSQKnsow7m2UWI/0z+9fyx5Lf2okRA5uzLquTTnaWMcI11Y4ZGcCg9OsdvI96nBZIEKS74aIWzlQWTScLm/iRUv7I+zhoDj9MNhJ46yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771466961; c=relaxed/simple;
	bh=7m30KQ51G2XBIZqrYYiXK7MzBNceBX0PbiFcf364MuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6/ft6lGtyZWg9yu7REvawqUNCS2BSkmBjUb5oF1liMprhes/AEaExKEO7ZYzsdF04FmHuK57kuIvjOYN70K9K0mQReenh73MUNikzKJjJoFnx3yD+R7F64J4MQu9M0Lotp8ac5GGv9PGtw53V6GHiOS+hQQrvedVjRXwCoOvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByYpSEL1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByYpSEL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771466960; x=1803002960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7m30KQ51G2XBIZqrYYiXK7MzBNceBX0PbiFcf364MuU=;
  b=ByYpSEL1J/FBgKYw55EkWiG0pu5dcHbBAsiOLE7+1bqfgGiMuBkLMTvp
   tMmYHAjZh2OqSfZPYUMFWGwPQP1W1+hbaiFijoCb7FZNju4FeO0yBqStW
   fKfoYlfbpbtrhxV+fd92LpkCTi9k6tGWV62YSv6Rih2mbgF0tsNoP6f59
   7vY5CibhICb710D906WkK+0uFQu/g3V/7Ws9u8HLPGjkKF4osWJQW4YWj
   4bobHpfTCMmw1XZ9WLsn+/XBDvfTpLuJyX7nRi82MFM6wr3tkWXSMPT3/
   ByVMhHbCnF0E4ubYFx1ci/XkZirP1tRZYuq4F4NIgXK0h9mKaJLsjHfsl
   w==;
X-CSE-ConnectionGUID: QcuPhHeDSeuqKstC44C5mg==
X-CSE-MsgGUID: xM+nN6HeQhqG5Zo0vdD0Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="71753752"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="71753752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 18:09:19 -0800
X-CSE-ConnectionGUID: pLBckp4rS0C2M5q/V9Eabg==
X-CSE-MsgGUID: XgxoqCM3QVmbKj/kGVpR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="252075932"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Feb 2026 18:09:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vstTe-000000012tE-3GYS;
	Thu, 19 Feb 2026 02:09:14 +0000
Date: Thu, 19 Feb 2026 10:08:49 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
	deller@gmx.de, sam@ravnborg.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 13/13] lib/fonts: Remove internal symbols and macros from
 public header file
Message-ID: <202602191044.XKx5ACdn-lkp@intel.com>
References: <20260218083855.10743-14-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218083855.10743-14-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0082025812a31eda451fb14f13f52683ed375c49]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/fbdev-Declare-src-parameter-of-fb_pad_-helpers-as-constant/20260218-164243
base:   0082025812a31eda451fb14f13f52683ed375c49
patch link:    https://lore.kernel.org/r/20260218083855.10743-14-tzimmermann%40suse.de
patch subject: [PATCH 13/13] lib/fonts: Remove internal symbols and macros from public header file
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260219/202602191044.XKx5ACdn-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602191044.XKx5ACdn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602191044.XKx5ACdn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/btext.c:23:
   arch/powerpc/kernel/btext.c: In function 'draw_byte':
>> arch/powerpc/kernel/btext.c:467:46: error: 'font_sun_8x16' undeclared (first use in this function); did you mean 'font_vga_8x16'?
     467 |         const unsigned char *font = PTRRELOC(font_sun_8x16.data) + font_index;
         |                                              ^~~~~~~~~~~~~
   arch/powerpc/include/asm/setup.h:19:34: note: in definition of macro 'PTRRELOC'
      19 | #define PTRRELOC(x)     ((typeof(x)) add_reloc_offset((unsigned long)(x)))
         |                                  ^
   arch/powerpc/kernel/btext.c:467:46: note: each undeclared identifier is reported only once for each function it appears in
     467 |         const unsigned char *font = PTRRELOC(font_sun_8x16.data) + font_index;
         |                                              ^~~~~~~~~~~~~
   arch/powerpc/include/asm/setup.h:19:34: note: in definition of macro 'PTRRELOC'
      19 | #define PTRRELOC(x)     ((typeof(x)) add_reloc_offset((unsigned long)(x)))
         |                                  ^


vim +467 arch/powerpc/kernel/btext.c

7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  462  
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  463  static noinline void draw_byte(unsigned char c, long locX, long locY)
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  464  {
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  465  	unsigned char *base	= calc_base(locX << 3, locY << 4);
0ebc7feae79ac0 Dr. David Alan Gilbert 2023-08-25  466  	unsigned int font_index = c * 16;
b94b7356756164 Finn Thain             2025-11-10 @467  	const unsigned char *font = PTRRELOC(font_sun_8x16.data) + font_index;
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  468  	int rb			= dispDeviceRowBytes;
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  469  
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  470  	rmci_maybe_on();
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  471  	switch(dispDeviceDepth) {
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  472  	case 24:
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  473  	case 32:
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  474  		draw_byte_32(font, (unsigned int *)base, rb);
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  475  		break;
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  476  	case 15:
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  477  	case 16:
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  478  		draw_byte_16(font, (unsigned int *)base, rb);
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  479  		break;
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  480  	case 8:
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  481  		draw_byte_8(font, (unsigned int *)base, rb);
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  482  		break;
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  483  	}
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  484  	rmci_maybe_off();
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  485  }
7191b615759ec1 Benjamin Herrenschmidt 2013-07-25  486  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

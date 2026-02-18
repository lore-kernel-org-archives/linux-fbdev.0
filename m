Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02A2BD01B;
	Wed, 18 Feb 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451295; cv=none; b=RZUa055hebpn65tzBq6QAKEltESYXPMRZJLzRRTJTsl9KWq3VI9civVmxEEh+ISP9PL59TfiGzffR1DrX4YQb6EfV4AU6ZfVFiWvJFnnmbl8Uwss3xNcOkEDaWofsvzfn/2Vxd2sQqnwyxbOFAUtwXWaz19uSuVyfEHERFAnk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451295; c=relaxed/simple;
	bh=IWjVj/f0p/cVs98D/JBHnUR2ir7uqscmcLwif2ekJKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS/SeyX+o1st7q90Da2wkza2vuk65L5I/7bAsqnTa5l0FsmYcJ9iwEb+U4XkQRDeeN/yNqj4eNiSxMFPhovU2N71H7Qz8kDirK16CwF3pt0qbKxiVjeaipiDWm/15Ggs2bIviMtOpXaXg4pHtmh5GAAlek92TRajcDXgxLPxcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHbqLbNY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHbqLbNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771451293; x=1802987293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IWjVj/f0p/cVs98D/JBHnUR2ir7uqscmcLwif2ekJKs=;
  b=cHbqLbNYvzxqkRlrHhUj62KuVHCL9OQ+f/+W3FMFeed7f9whRCatcndF
   n/tXMmjxj9Lc7GUbw7vU3KY04ClHnNI+E1Rjxk8F5vNS6zGOFxjvZkwK0
   T3ODQYCKqdY0ns36vyq6X5eSDnF+ouEcl8lKD/ntLFeYeI3K8PQ2KWGOU
   DYrxWFbn74WQanxmAC/6Sp2uBNq2K1vp2tcE1n87XbX8TAtTeYcd7ZzzV
   s3MsWB4gQ8ewLInZKuV8fUIoxcoUJklabA/YQk8diJmBgu3Ph5CmMIVkf
   FJNfwi/v6MYsZNWxCoya/hQIiZBajbcoH1u3r22mx4yENdIM35OrLbSAZ
   A==;
X-CSE-ConnectionGUID: ENz2MpPJRnmCoqGxwBUjyw==
X-CSE-MsgGUID: knFM3OueTwmEkfR+SkUVPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72438596"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72438596"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:48:13 -0800
X-CSE-ConnectionGUID: grLfGY/1RCSDZnjnbhpJaw==
X-CSE-MsgGUID: ycPOfQM0SR2vfb7xMqWRNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218465029"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2026 13:48:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vspOy-000000012l2-0cJj;
	Wed, 18 Feb 2026 21:48:08 +0000
Date: Thu, 19 Feb 2026 05:47:36 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
	deller@gmx.de, sam@ravnborg.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 13/13] lib/fonts: Remove internal symbols and macros from
 public header file
Message-ID: <202602190548.KwDrx2RS-lkp@intel.com>
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
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260219/202602190548.KwDrx2RS-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602190548.KwDrx2RS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602190548.KwDrx2RS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/sparc/kernel/btext.c:195:30: error: use of undeclared identifier 'font_sun_8x16'; did you mean 'font_vga_8x16'?
     195 |         const unsigned char *font       = font_sun_8x16.data + font_index;
         |                                           ^~~~~~~~~~~~~
         |                                           font_vga_8x16
   include/linux/font.h:99:31: note: 'font_vga_8x16' declared here
      99 | extern const struct font_desc font_vga_8x16;
         |                               ^
   1 error generated.


vim +195 arch/sparc/kernel/btext.c

c57ec52f2647e5 David S. Miller        2009-11-27  190  
c57ec52f2647e5 David S. Miller        2009-11-27  191  static void draw_byte(unsigned char c, long locX, long locY)
c57ec52f2647e5 David S. Miller        2009-11-27  192  {
c57ec52f2647e5 David S. Miller        2009-11-27  193  	unsigned char *base	= calc_base(locX << 3, locY << 4);
0f1991949d9bd5 Dr. David Alan Gilbert 2023-08-07  194  	unsigned int font_index = c * 16;
0f1991949d9bd5 Dr. David Alan Gilbert 2023-08-07 @195  	const unsigned char *font	= font_sun_8x16.data + font_index;
c57ec52f2647e5 David S. Miller        2009-11-27  196  	int rb			= dispDeviceRowBytes;
c57ec52f2647e5 David S. Miller        2009-11-27  197  
c57ec52f2647e5 David S. Miller        2009-11-27  198  	switch(dispDeviceDepth) {
c57ec52f2647e5 David S. Miller        2009-11-27  199  	case 24:
c57ec52f2647e5 David S. Miller        2009-11-27  200  	case 32:
c57ec52f2647e5 David S. Miller        2009-11-27  201  		draw_byte_32(font, (unsigned int *)base, rb);
c57ec52f2647e5 David S. Miller        2009-11-27  202  		break;
c57ec52f2647e5 David S. Miller        2009-11-27  203  	case 15:
c57ec52f2647e5 David S. Miller        2009-11-27  204  	case 16:
c57ec52f2647e5 David S. Miller        2009-11-27  205  		draw_byte_16(font, (unsigned int *)base, rb);
c57ec52f2647e5 David S. Miller        2009-11-27  206  		break;
c57ec52f2647e5 David S. Miller        2009-11-27  207  	case 8:
c57ec52f2647e5 David S. Miller        2009-11-27  208  		draw_byte_8(font, (unsigned int *)base, rb);
c57ec52f2647e5 David S. Miller        2009-11-27  209  		break;
c57ec52f2647e5 David S. Miller        2009-11-27  210  	}
c57ec52f2647e5 David S. Miller        2009-11-27  211  }
c57ec52f2647e5 David S. Miller        2009-11-27  212  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

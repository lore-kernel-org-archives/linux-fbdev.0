Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306C3446CE;
	Thu, 25 Jun 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395638; cv=none; b=NiXGOvFffILBoDPOgIWkQwRa27sjqda/MLiDuuHVkWzmL8ME8vx9+gB8ub5P67pE124VPnzuPzTJoq0Qtqm+F0aLu61XmykB4uPfIi36XSyFRGRcUwLCG+T8A/LwDlrbgcVF5Us6aHdcyD1nbNfy/X0XgBoAr9YXwgRlUIuMOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395638; c=relaxed/simple;
	bh=3gWE6pRjmf5/L6XWnC/tL1qHBu5WeuMP/6/gGEEEuw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/WwLs/lWcTZsuMmGQ4hlPNd44x5wDSmQn6wA4XK0hE17WyOnhyPVIPyfF1sRLTxnpxgYSNlRe+1HfpCG9xtGb/k5QxSwWSQtjBHTmN0eHg/MZXdfEl9puHZBDJ8ZI2HPeXXB3vhx5n/SBWTmbmzdiL9wY2X/aoSnlIEyVVIyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+ijcK4G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+ijcK4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782395637; x=1813931637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gWE6pRjmf5/L6XWnC/tL1qHBu5WeuMP/6/gGEEEuw8=;
  b=P+ijcK4GfnVRUfE1ZcdTUNrcYkXZVxytKe4XpjHFT2wcGNqjvQynGa+J
   y9juChZ2xY3auu1YZzwtlZis96oN0GYzelfK8K/ZAMweTaeHCGgiv3Pfr
   NGAZFzOileAGvgn7TtAR7uNboytmzEegiv9T7Flj/4LGeoIeL2mgthVcU
   +JC71LkIMe8mPUb9S2vq5AueDyZod9vCKj+sOR1+0AfKjYOjZb3QnXBlO
   U3RKzXv4gEN97Jh3t7LdW+DE9NsNXQiNVrqfxwtmUTYYEnAl75D/3+nq+
   YYhO6IlZvTg9jHx1EqOVzLwVybzE+BXEQBmRAwuBk2hEhPwOCsHSQUabi
   A==;
X-CSE-ConnectionGUID: 5ecxpy7YQUCiktEAKEPWLQ==
X-CSE-MsgGUID: ZJlWQFtmRau/9jrO1SI6zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83055821"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83055821"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:53:56 -0700
X-CSE-ConnectionGUID: KXNGTLFPTSmmQt5eKAQ+dA==
X-CSE-MsgGUID: 1RD6EuwfTpGnvlK/Rk39WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="248158427"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 Jun 2026 06:53:53 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wckWd-000000004AL-0Nhy;
	Thu, 25 Jun 2026 13:53:51 +0000
Date: Thu, 25 Jun 2026 21:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>, andy@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Message-ID: <202606252144.F56jkpaD-lkp@intel.com>
References: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625110237.304435-1-suryasaimadhu369@gmail.com>

Hi suryasaimadhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/suryasaimadhu/staging-fbtft-fix-unaligned-vmem-writes-when-txbuf-is-byte-offset/20260625-190423
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260625110237.304435-1-suryasaimadhu369%40gmail.com
patch subject: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is byte-offset
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260625/202606252144.F56jkpaD-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 6cc609bb250b21b47fc7d394b4019101e9983597)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606252144.F56jkpaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606252144.F56jkpaD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:157:4: error: call to undeclared function 'put_unaligned'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     157 |                         put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
         |                         ^
   1 error generated.


vim +/put_unaligned +157 drivers/staging/fbtft/fbtft-bus.c

   113	
   114	/*****************************************************************************
   115	 *
   116	 *   int (*write_vmem)(struct fbtft_par *par);
   117	 *
   118	 *****************************************************************************/
   119	
   120	/* 16 bit pixel over 8-bit databus */
   121	int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
   122	{
   123		u16 *vmem16;
   124		__be16 *txbuf16 = par->txbuf.buf;
   125		size_t remain;
   126		size_t to_copy;
   127		size_t tx_array_size;
   128		int i;
   129		int ret = 0;
   130		size_t startbyte_size = 0;
   131	
   132		remain = len / 2;
   133		vmem16 = (u16 *)(par->info->screen_buffer + offset);
   134	
   135		gpiod_set_value(par->gpio.dc, 1);
   136	
   137		/* non buffered write */
   138		if (!par->txbuf.buf)
   139			return par->fbtftops.write(par, vmem16, len);
   140	
   141		/* buffered write */
   142		tx_array_size = par->txbuf.len / 2;
   143	
   144		if (par->startbyte) {
   145			txbuf16 = par->txbuf.buf + 1;
   146			tx_array_size -= 2;
   147			*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
   148			startbyte_size = 1;
   149		}
   150	
   151		while (remain) {
   152			to_copy = min(tx_array_size, remain);
   153			dev_dbg(par->info->device, "to_copy=%zu, remain=%zu\n",
   154				to_copy, remain - to_copy);
   155	
   156			for (i = 0; i < to_copy; i++)
 > 157				put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
   158	
   159			vmem16 = vmem16 + to_copy;
   160			ret = par->fbtftops.write(par, par->txbuf.buf,
   161							startbyte_size + to_copy * 2);
   162			if (ret < 0)
   163				return ret;
   164			remain -= to_copy;
   165		}
   166	
   167		return ret;
   168	}
   169	EXPORT_SYMBOL(fbtft_write_vmem16_bus8);
   170	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

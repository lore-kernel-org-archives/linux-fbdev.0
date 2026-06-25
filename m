Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE3324B24;
	Thu, 25 Jun 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393717; cv=none; b=UPRcJcG+FRnCZZbncm/+wf6+PxcqYmb8ukPtfKeCl9gN8cD2VB9Mn+B0vsjJr7A1ILmN+2sQvIMFWUM006m5up2D+swhw9AjRho1OLG6s0l8D1X3CLgVJOW50K+3n9ZGi3ioWv1r4N/s52ASeBqRB2cugM07U8M1NYiWQmqxc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393717; c=relaxed/simple;
	bh=/clckuDznykys0MUCbzF0O2r6zO6B0BkqHBx4uqj4Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwtoc4Srzrz+2gF9l0siqsRWy1+4IO/t7pcsDRWgBo4gl4JLM3D4Z7oUWefy0r7CrCps6seSaF9uBDtiuo9ur4cqK7IYpyLujJitNyuPnoLuYK0ZjI8NKhL5Yj/LJh49C7lNQh26kAdjF97bbsLoh6AOusDACfv7Iv/+qHtLfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOPPXudh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOPPXudh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782393715; x=1813929715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/clckuDznykys0MUCbzF0O2r6zO6B0BkqHBx4uqj4Ms=;
  b=lOPPXudh9G1ayRHPc8jyjtzo1sV93Mw1msolKhLqs7bfmETtt0p+4nIA
   So56R9H0+5CnYB0rvAEL+9fuYaD/wIF/Ndz1Wi+mrmFGAWPTXNaJs2RfO
   5p0SHQQqx5J5DJd3xo05ncm66W4zaowFa6EfKqkeNIjttGZAudAr54thr
   rJaXnJLmIyJRnRK6EWBNHmStECpO/GI2ganiXNXAoppdb1CnQDZIqKGVq
   m6s9HwnXg4l9U3TzrHzzEUy4Thm8yPRNdDrgywkNl64UzZynQiTJwWrcD
   AeIdZ8c14nlZNH7adn15SmXqRZ04uPlsthp9uEf2wiRIwXXcl/RrXE6QO
   g==;
X-CSE-ConnectionGUID: M8Kpbl8pTd6jG7u4rW2buw==
X-CSE-MsgGUID: GYI5l4OIT36sOZQaEQglfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94661086"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94661086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:21:55 -0700
X-CSE-ConnectionGUID: tETcVABsRg2gG+V9oRv3DA==
X-CSE-MsgGUID: YBB0oqC7Q3GdMyglW6aueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="252652467"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2026 06:21:53 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wck1e-0000000049Z-0mAG;
	Thu, 25 Jun 2026 13:21:50 +0000
Date: Thu, 25 Jun 2026 21:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>, andy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Message-ID: <202606252119.rClVa8On-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260625/202606252119.rClVa8On-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606252119.rClVa8On-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606252119.rClVa8On-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/fbtft/fbtft-bus.c: In function 'fbtft_write_vmem16_bus8':
>> drivers/staging/fbtft/fbtft-bus.c:157:25: error: implicit declaration of function 'put_unaligned' [-Wimplicit-function-declaration]
     157 |                         put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
         |                         ^~~~~~~~~~~~~


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

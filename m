Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7662980A5;
	Fri, 27 Jun 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022467; cv=none; b=ieCkh0Yt/9rjIJZgnqeQfzjE16u0OuqfkspD9nt7j4clFnyCSkeGDXtbWjZsxRZczDvYknvyruSgKb0IhfqCdOjGS8GN3tylopDkUkj8CEm5sZv2w9saVOqdidEBHUBIBjvc2gXoNjzVphZPsqqmBg2bRw4i5c0CYN3+LRiK5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022467; c=relaxed/simple;
	bh=+F4+PRH6RZeS8ugoToiy4TCKLKkcYPK+TGHSXOUNJ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mskfV7IjoiFEA46IbGGGEfdglrZdfQo9LMQxM0kfHnJp3L+DTWjMmEScqa2R8o72qnUeraivqrgla4IRMC2UCQIJcUfaCwlmC704x2buAbTPj/9jdDnnPAPA8/JCunFfZandbhOoGpLuT2Jhprkhm4vz9jNRbtmOFuKg9f9OkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhrvX4V6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhrvX4V6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751022467; x=1782558467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+F4+PRH6RZeS8ugoToiy4TCKLKkcYPK+TGHSXOUNJ18=;
  b=NhrvX4V6DkzlA6WcbF8LuqO3gQ1pX/5MaVdAGCgPPV0z5Hp5+QDtxMUv
   ESkDvLJyBSBSx4ODcm7DCNx1VsBAtdCx/x4fM24GfEW4uPZ8EgNAhMGRj
   b5HuBlPwCB2N03fPeai4KDswkUfGkfRpPIqw8obqVsSlM80Swz8nbRFVj
   iCfX+nDgwp49YozuNfkkdnkYw0TEeGnKIcFLRek/WVaUyzcQRrs6OWsqM
   0kbzps/Ln4Ts1lfVa+zOi0BGreQ2K7u6L1/JJrj+eYvll1O2pWzyRGfd7
   o+Gmh45oAh7hHxvgG78Anc8R2MVkbsXITCL2pIpn/fFt+i1yH6aGoJhGV
   w==;
X-CSE-ConnectionGUID: h8WznA35ScC42ywar9RMmA==
X-CSE-MsgGUID: ezpQrNjwQzWQYxh/qEo2CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64772542"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="64772542"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 04:07:45 -0700
X-CSE-ConnectionGUID: 6KDakIrXREWbY/0lrldFZA==
X-CSE-MsgGUID: Fpu8o9HZTqm4cjPeGaFeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="153494856"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 04:07:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uV6vh-0000000ASaL-04jT;
	Fri, 27 Jun 2025 14:07:37 +0300
Date: Fri, 27 Jun 2025 14:07:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix potential memory leak in
 fbtft_framebuffer_alloc()
Message-ID: <aF57eMeNafg1w9Qw@smile.fi.intel.com>
References: <20250626172412.18355-1-abdun.nihaal@gmail.com>
 <aF2Ic8BP0zWS6R19@smile.fi.intel.com>
 <0327da98-8a7c-4db8-8bcd-4179b87a9486@suswa.mountain>
 <aF3CwnHyW5HHzDSG@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF3CwnHyW5HHzDSG@surfacebook.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 12:59:30AM +0300, Andy Shevchenko wrote:
> Thu, Jun 26, 2025 at 11:11:39PM +0300, Dan Carpenter kirjoitti:
> > On Thu, Jun 26, 2025 at 08:50:43PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 26, 2025 at 10:54:10PM +0530, Abdun Nihaal wrote:

...

> Ah, you have a point. Yes, the moving vmem allocation will solve the ordering
> issue.

...with moving from devm for the txbuf. Otherwise we would still have a
problematic ordering with it.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90F3FF1B9;
	Wed,  3 Jun 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472963; cv=none; b=BxKH9M+ArcWUMKMV3OfBJIgEiY9wOtXnH4BVKJ3/cCfdJZMn/fvn/55XpU7pGitVaiKedKopSYev9pw2rwrzppz67sZla6SSdd5vqcKpP6SbXdYjYbb1SIJacY0g/QdAe4qYsz92nKaM4ExVx5FYn6QJdlaqWE5esaklUUnHc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472963; c=relaxed/simple;
	bh=YJk+GNWjFh/CK4jio5r8wPylzH3wGu9XWpulsn/tGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lni1r/pheaulnVmJvfNJ+8gof+j79/WmbnBTCucEnkt/jFd5yve5xmKoCANYrXddPwy26bfowcQ1BsNDDlHSt2byhA49dYM3nU20JeQ7vfOdPAw7HKB0uxclTz0QBdr6/1bjo+ShwDNGqvEu5kOuKdUVzz85m5BhyzqnvdvhS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6u9//ll; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6u9//ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780472959; x=1812008959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJk+GNWjFh/CK4jio5r8wPylzH3wGu9XWpulsn/tGw0=;
  b=N6u9//llPjKdKyTDwYGZdG+9ZnRyt1+ka9cPcTTGrFR6KLHR0CaIwbJS
   VWcSdeZReWDAODi5J7wvBZbB9Rvfxe0EBlN2YisQ2fYzaVfYi4e9VlqWw
   cMEgzjBZHB6jZkcBbeJmytaF0ODqfvCG3tE1WwQy6mSUUzbzMugDCHOIA
   r8CG2rQe7OxgErmwIDtjaJ6wNyRZJN3WQLIRkdsKG9wzUaqcftkrMLORW
   G1ZGz67MdZURlzCMDpqwFuqCE/UBJXAq1AI+et8XDwKz3NCPbJShUdxwk
   Usm29W6AUAO4mCT0TezTWCnkpD8cgsh2cNem5ffGUa6HcZXRgRDHP0M8A
   A==;
X-CSE-ConnectionGUID: rkFxHZsMRo+Sp/gaAJxoRA==
X-CSE-MsgGUID: 9/C4HuYEQS2yfW5qJ0f0JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81268650"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81268650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:49:17 -0700
X-CSE-ConnectionGUID: PCLuX4qET0+zXvW9H90qYQ==
X-CSE-MsgGUID: Gl7WtXZgSPOGLNVeHVWrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237790888"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:49:13 -0700
Date: Wed, 3 Jun 2026 10:49:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Chintan Patel <chintanlike@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use sysfs_emit_at() to print to sysfs
 file
Message-ID: <ah_cd9Ax4fzOhBp7@ashevche-desk.local>
References: <ah_Y_Y2RtqeGxchF@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_Y_Y2RtqeGxchF@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 10:34:21AM +0300, Dan Carpenter wrote:
> This scnprintf() uses the wrong limit.  It should be "PAGE_SIZE - len"
> instead of just PAGE_SIZE.  We're not going to hit the limit in real
> life since we are printing at most FBTFT_GAMMA_MAX_VALUES_TOTAL (128)
> u32 values, however, it's still worth fixing.
> 
> Use sysfs_emit_at() to fix this since this is a sysfs file.

OK,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	for (i = 0; i < par->gamma.num_curves; i++) {
>  		for (j = 0; j < par->gamma.num_values; j++)
> -			len += scnprintf(&buf[len], PAGE_SIZE,
> +			len += sysfs_emit_at(buf, len,
>  			     "%04x ", curves[i * par->gamma.num_values + j]);

Can we switch to use hex_dump_to_buffer() at some point?

-- 
With Best Regards,
Andy Shevchenko



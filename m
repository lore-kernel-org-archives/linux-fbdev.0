Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12525A62B;
	Tue, 10 Jun 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551209; cv=none; b=djrAG5MLDJ4O2lg9iSgq1lkswCQkqMZQhnBrxfOUOGIIZXBdsKO20D0sUAehEpK6tDwA3tH62JACzJHDNgn+NQndvY30Nr7FHm2gGw0xX7feyVym0/mNNqXvV1L/gZ/npjeV8ye/yHbTovYmVvr+9/eyzSxodBl2pQTsueYSUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551209; c=relaxed/simple;
	bh=xj4Bk+QtP4Xe69OFwGbfLYunFjAhUgQvako1o9IrDtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu8J6pgQ6kH2jjoZO+TAFSZsQG0YOtFMDXBLQwvlx5ufa0xY2iMF8q8vkMnVxavO+cnoPs5IOK3LOTGrHweeDfs1crsUKQWHYcAwEjbrZCZ8BcSSNeW3+Z0gQizQfOjDtk9+VPZMoQWUC6R9Twxis/ErJXBm8nrUlc9tEIYcQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9V4Sd/B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9V4Sd/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749551208; x=1781087208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xj4Bk+QtP4Xe69OFwGbfLYunFjAhUgQvako1o9IrDtw=;
  b=L9V4Sd/B5lZVEM5lvinRVs6nb3hM5nkC2YWnAwXq7gP21mQ7bfAIEihK
   1zjdE7k+hmU32R5QYQnxk+o2rp+l3IBcD3fz4uPjzbVPYekAw+ChNqh4J
   xs1uDXb5aHE9zJKayXwLLHX4uqBTY3CdzZyN6zyEWlfBJjgyGuR5GY0Na
   DYqxBkpDFhO+n5xIPXhAw+RDA2FVRoWiY6r2Ly8iSP3O0LyvkjjiGdgLN
   yuTRs6rFMDcYsm9zgKG9vVFQ6ivrtzlLdgkNaL4bQqWDr50QuSJzCV6An
   sEqE12mrbbRUjdxmUfVmxaDe4/J3/PhjcA5K5fhxWbJjNbr9LIQPndJMm
   w==;
X-CSE-ConnectionGUID: G+484nyLTZK94yFWJKdv8g==
X-CSE-MsgGUID: 7fY7cQn5TAWIDNiGX1mZFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="39271737"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="39271737"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:26:47 -0700
X-CSE-ConnectionGUID: T+GOp6Q7Ta66D4mv0ATegA==
X-CSE-MsgGUID: ODHchsrkR7WUYMpiy6C/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="183977231"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:26:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOwBj-00000005Jum-2oTR;
	Tue, 10 Jun 2025 13:26:39 +0300
Date: Tue, 10 Jun 2025 13:26:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Paolo Perego <pperego@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbtft: reduce stack usage
Message-ID: <aEgIX221QIt5k0zY@smile.fi.intel.com>
References: <20250610092445.2640575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610092445.2640575-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 11:24:38AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The use of vararg function pointers combined with a huge number of
> arguments causes some configurations to exceed the stack size warning
> limit:
> 
> drivers/staging/fbtft/fbtft-core.c:863:12: error: stack frame size (1512) exceeds limit (1280) in 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
> 
> drivers/staging/fbtft/fb_ssd1331.c:131:30: error: stack frame size (1392) exceeds limit (1280) in 'set_gamma' [-Werror,-Wframe-larger-than]
>                   ^
> drivers/staging/fbtft/fb_ssd1351.c:120:30: error: stack frame size (1392) exceeds limit (1280) in 'set_gamma' [-Werror,-Wframe-larger-than]
> 
> Move the varargs handling into a separate noinline function so each
> individual function stays below the limit. A better approach might be to
> replace the varargs function with one that takes an array of arguments,
> but that would be a much larger rework of the other callers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +static noinline_for_stack void fbtft_write_register_64(struct fbtft_par *par,
> +							int i, int buf[64])

Perhaps int i, int buf[64] should be u32?

> +{
> +	par->fbtftops.write_register(par, i,
> +		buf[0], buf[1], buf[2], buf[3],
> +		buf[4], buf[5], buf[6], buf[7],
> +		buf[8], buf[9], buf[10], buf[11],
> +		buf[12], buf[13], buf[14], buf[15],
> +		buf[16], buf[17], buf[18], buf[19],
> +		buf[20], buf[21], buf[22], buf[23],
> +		buf[24], buf[25], buf[26], buf[27],
> +		buf[28], buf[29], buf[30], buf[31],
> +		buf[32], buf[33], buf[34], buf[35],
> +		buf[36], buf[37], buf[38], buf[39],
> +		buf[40], buf[41], buf[42], buf[43],
> +		buf[44], buf[45], buf[46], buf[47],
> +		buf[48], buf[49], buf[50], buf[51],
> +		buf[52], buf[53], buf[54], buf[55],
> +		buf[56], buf[57], buf[58], buf[59],
> +		buf[60], buf[61], buf[62], buf[63]);
> +}

Wondering if we may reuse this in other cases (by providing the additional
length parameter). But it may be done later on.

-- 
With Best Regards,
Andy Shevchenko



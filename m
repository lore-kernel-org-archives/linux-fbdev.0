Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936452E040D;
	Thu, 25 Jun 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396358; cv=none; b=uPPPW27gzYyG0914P0xw61h5bk0dCwgoj8pVfmp/ONIm9rIIFyiNUGHtZkyfkoMkPgqsTyMk1vLySgXzj8NIrkbl2T1fDYsGx//tnNnSvf5S4TZggZInu6nfvxCIApPzAzYpwNiAN7i4cx8l2ms7Acc3Q5oimDKvxHugQLREQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396358; c=relaxed/simple;
	bh=GKEm6b80+r1vDXYXchZ+aaxsCPgPgJZjefpNfb7f9fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9y4oTOqbPFEZv6lfI7pmrygESFgOI+8Zjv6lbJAYtbkcWCI7P226yi46E7ypM6paent6bUYpSK+5mw5YjZvE/kyIIR3P3WgS0HMrlM/NN0QH2KdFeoWxbYalIPkXfdtKURAEoUSJR0f61Sj4HpX0aA4rmuoFM9unJADZmClfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3hQNI9t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3hQNI9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782396357; x=1813932357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKEm6b80+r1vDXYXchZ+aaxsCPgPgJZjefpNfb7f9fo=;
  b=a3hQNI9tNjD+sXdD3Zkq1z1/0vstsVUCDNVRTWn1oR4hfpNQKKRSVUOJ
   jnpm4N/JMhBiDiWfZSt6TLGd2y4oIu9+NgWx/aZORiW50DtDsNYly/6A2
   PfSQIYEnNjGUX4hLiwC43CAo0DHZrFUWUZz5aF72IqEqtmbLpdMqj565A
   QeMukHt8jQl5YsK8u+jebT0BVajBa3DSED/gBmb4dwQd6Y7N/Gq7CoBKe
   FgOmq/XyCcc3EzlKsJAyp5ti5ANvBz7GlAxTa95/DZfBR1gAu/2DqmiCo
   N354wE7IZ56fiEFYRhqjO3X8rvyJdDAVf7qgiBbdP7TD8AzNeqs4dCGwZ
   g==;
X-CSE-ConnectionGUID: SGokTaVXR9CPLCcBibbTCQ==
X-CSE-MsgGUID: TgsPItIOTzqcbnVoOPpgxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87017901"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="87017901"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:05:56 -0700
X-CSE-ConnectionGUID: +F3WgD6nSfGd0Z38Y+vp9w==
X-CSE-MsgGUID: B+UsbCpSRwqoloCK96MxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250913376"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:05:55 -0700
Date: Thu, 25 Jun 2026 17:05:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and txbuf safety
 issues
Message-ID: <aj01wD1MwpRJTZQv@ashevche-desk.local>
References: <20260625111602.438761F000E9@smtp.kernel.org>
 <20260625114215.325973-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625114215.325973-1-suryasaimadhu369@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:42:15PM +0800, suryasaimadhu wrote:
> This patch addresses several pre-existing issues in the fbtft driver:
> 
> 1. define_fbtft_write_reg(): when par->startbyte is set, buf is
>    advanced by one byte creating a misaligned pointer for 16-bit types.
>    Use put_unaligned() for register writes and fix the SPI transfer
>    size from len * (sizeof(data_type) + offset) to
>    len * sizeof(data_type) + offset.
> 
> 2. fbtft_write_vmem16_bus8() and fb_ra8875 write_vmem16_bus8(): same
>    unaligned 16-bit stores when txbuf is byte-offset for a start
>    prefix. Use put_unaligned() for pixel data copies.
> 
> 3. tx_array_size underflow: both vmem helpers subtract 2 from
>    tx_array_size when a startbyte prefix is used. A small txbuflen
>    device property causes unsigned underflow and out-of-bounds heap
>    writes. Fall back to the non-buffered write path when the buffer
>    is too small.
> 
> 4. fb_ra8875 write_vmem16_bus8(): missing NULL check for
>    par->txbuf.buf, which remains NULL on big-endian when txbuflen is
>    0 because the PAGE_SIZE fallback is little-endian only. Fall back
>    to direct write when the buffer is missing.
> 
> Also replace empty modifier arguments in define_fbtft_write_reg() with
> a no-op macro to fix checkpatch warnings.

This looks like v2 of the thing without changelog and addressing the comments
that have been given against v1. I'm not even going to review that.
Please, consolidate feedback, take your time to study process documentation
(Documentation/process/* in the Linux kernel source tree) and try again a bit
later.

(The fix and report are valuable in general, thanks for doing that.)

-- 
With Best Regards,
Andy Shevchenko



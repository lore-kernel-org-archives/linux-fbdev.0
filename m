Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526318A6DB;
	Sun,  8 Feb 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558420; cv=none; b=Y/GjpoaFpbkj2eCXGMHInlBFazBXGsMZrWEmoaYmGsopQFUK/hxJ8qL/hPcKI4LLyFb5dvqvg2HTpgpVM25o0YDseHXl8jnSA/klaM8IlwotoFLUlfQlWrTN/vKMzRDx5SlWZ+kDrYv0lB5+3xYNS/hvlcZSxm5cJfZwiTtfUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558420; c=relaxed/simple;
	bh=IfCx8FuhXcmPUmvEZWLLSa3nIj7MtGEd1V5PX3u5lZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqDUE6O5ozYcg1YZIBku3+kz5LqQzBZD6Kmu3Tny/dgJPckY5At6NSR6dgdMHxcrmWFBmMdO4z78MDuPqrrY1Hfw/YtVWVohkyMgepscjInf4cDLJbMKVXzbCZLtK0aGiwTjN0HxaD3Ay7Givcs3FJeyJC3lyna+24LXIF+eWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmR/N6Og; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmR/N6Og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770558420; x=1802094420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfCx8FuhXcmPUmvEZWLLSa3nIj7MtGEd1V5PX3u5lZM=;
  b=jmR/N6OgyXmxRbPI/PLTwTH4UhsifF4j1IQbHGmf3XNPXg07pSmI30C3
   2qspCKZDbd2HlHgQs8YYnr8bB/KdhPHcjrNLnWkJiDe3VWRpAvYUtttJg
   VP+eMViLqTItUO8s8tx51yfzeJPUPTsQXbcDrp6c36BUh08t0UEFVUnoS
   RtQnjy9CtaUciENYf0TRGsUcMWRQZKginjuGTQH90vp+z9hDCJ0H8OHuM
   MrxgsJnmw65wV1Th9H53DTnMsVwYNFCJOFbPX7QOUiXC7oqbmq/9mc0fP
   9uZqFtuNuixBP8/pkqcgre/4ZO4uEB3UJRL53k16IITSgeLCOKPSCE1G/
   A==;
X-CSE-ConnectionGUID: NmnoE9mdSaSNg887CBxQJA==
X-CSE-MsgGUID: QzIwzcp+RE2g3kB7oeT3kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75311514"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="75311514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:47:00 -0800
X-CSE-ConnectionGUID: U8Xf+RzOT8mH95qaZlMQEg==
X-CSE-MsgGUID: xz95bUBSTYSkoWwIuVgdUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="211390967"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:46:57 -0800
Date: Sun, 8 Feb 2026 15:46:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unchecked write return value in
 fb_agm1264k-fl
Message-ID: <aYiTz5_OUhwJ9Vhs@smile.fi.intel.com>
References: <20260207220523.3816-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207220523.3816-1-iprintercanon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 07, 2026 at 10:05:23PM +0000, Artem Lytkin wrote:
> The second call to par->fbtftops.write() does not capture the return
> value, so the subsequent error check tests a stale value from the
> first write call. Add the missing assignment so the error check
> applies to the correct write operation.

Hmm... Sounds about right, but it was like that from the day 1.
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1425C6E2
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Oct 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808859; cv=none; b=BOitN3Fwdvc83ElX1EmxEaStNQjFSk7DQQMMSXcqmDlUzi0nHxMgSpVdbmosrVp5iw4EvJvCS4LcETZHqxDw4Hm8GDEwqrGkh43g4yt51K66lbMISYYZQeB83QNtAyODJ0qFqtNZrKEfhpQO07SClShAs1cVbp7ySYyuyB4QUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808859; c=relaxed/simple;
	bh=RJ5KIkMJIdV/yBi8CkjP5HLVKkDZSkWUq8PX0/Pcz0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB0BTuGPy+1yay4panxY20tQgOaIijQbBT3JInHaV8HpX2O64/jCwkwCskmdHqqfHRHeK+utWfVNMpxI+cEf/lRR2XRCCNTPttoO+b1fOTjXPMfaSt22jzeZTr6QiAay22FdJKOPvuK2YSPZbopg/Xw45uG0Hef8VFNpAbPb1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMmtuHOU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMmtuHOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808858; x=1792344858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJ5KIkMJIdV/yBi8CkjP5HLVKkDZSkWUq8PX0/Pcz0U=;
  b=nMmtuHOUh/j932Ho0a2O+nqthYn+eDquwgnsSGnggQAhymYqSvHpuF3D
   U8KnaBPG7+7SRkqc65rzrU1lOsMY+kgRhirEOneue47/1Pyqn4K/FjyNf
   injg+13lK18FZk4HaZQAgj4KWCpH/xfJic0WbH3nHOMonMVSe2yiiQZXn
   DAj2sS2SJC/3BR8qG3NULr2IAt3Q2HVG79v1xkHAwlMsXwqATpAN3q5xI
   L3Y7lVdAfmSUp3dymCFE4YRs1E2BgWmeRIkq9Ew8gXQ5O1KWdZffVCMLS
   sOJL3N6YX765CTeIdl49Xcf3uQw5HN6WEYxghW3+06In3ZNVvzd13JHkg
   A==;
X-CSE-ConnectionGUID: zb/svY9iTUekLOcuBUCTlg==
X-CSE-MsgGUID: BK168pUjQJmd4eCiOwNz4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63086756"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63086756"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:16 -0700
X-CSE-ConnectionGUID: WHdI2lB5T8SS9QNrPq6EOw==
X-CSE-MsgGUID: RnMIvm3yRVacyah8szT1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183749980"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:15 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v8PVf-000000002rj-2iH5;
	Mon, 13 Oct 2025 23:51:11 +0300
Date: Mon, 13 Oct 2025 23:51:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: DeepanshuPratik <deepanshu.pratik@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix macro usage and style warnings
Message-ID: <aO1mPzy6vjg3tnrh@smile.fi.intel.com>
References: <20250919212938.822374-1-deepanshu.pratik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919212938.822374-1-deepanshu.pratik@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 20, 2025 at 02:59:38AM +0530, DeepanshuPratik wrote:
> This patch fixes the trailing comma issue in the
> define_fbtft_write_reg() macro calls, which caused
> checkpatch.pl to complain with:
> 
>   ERROR: space prohibited before that close parenthesis ')'

Please. go and fix checkpatch instead.

> The affected macro invocations were updated to pass an
> identity modifier instead of leaving the argument empty.
> This resolves build errors while ensuring compliance
> with kernel coding style.
> 
> No functional changes are introduced; this patch only
> addresses build and style issues.

-- 
With Best Regards,
Andy Shevchenko



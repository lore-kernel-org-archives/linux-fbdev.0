Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C2194C98;
	Wed, 24 Jun 2026 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300703; cv=none; b=QJetQ1GeCTkKnH4xWDWG6DXFtHEPRNC4UfF10XE7dkDKR6+3Q1fyWvprFbKJGM7NIWQrBizitfMxSTMoDQjC7lIzIdrBmPb1Wy/m4unsqX4EHWzUpLOaSgrvkpJHgD0eVXPJ2KmvrrNmiGReaR73yaOQsWiRCdrOePXoGSVkxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300703; c=relaxed/simple;
	bh=d5HyWw/v+MgocWmiFJGhqAbm8vl8c80N0u9O+M8mTY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwG7z4jcTQdR+9AUfKtBfCta0PDNkxByrlr5q1MmVVRYUhlxyFY8CoedHZetsWAVNzxKrqj3pHBbnkEJ/ChlwaYNrXlAwRQr20m+FM9ck8+h4J3FV6FHRwG2jmZmo4HrAIQB+bhGE/EanQSiRwP07DXjakNVPEAYsCF10geok48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l38ZyQB2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l38ZyQB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782300702; x=1813836702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5HyWw/v+MgocWmiFJGhqAbm8vl8c80N0u9O+M8mTY4=;
  b=l38ZyQB25nom/AKrlcWWaFZxC1cqTUnqBezR2J5gQtgQ2ZlymsL8UNif
   EqVPHJkcPxF2fpY6K6MkDqEjVE7jwMvkAFmgmbXW2c9ucy2ma9unvyjTh
   0qPujSLK3Fh5N7S9vx1KNWW7iD+oDEhXDzq07oClPI+omgRe8ySzLileY
   KWD+nRsnH4bKqRvxNAj10tHRgECsZJ+U0W3Qch/+eLctAu19tqMA/BTnO
   k2+VSBeY1OV/PDs1Iq2cz0Fk0VtHdXcetnosAPyIPnra7fUjr7JbSBLUV
   lF31qn5j3TCJYaHJzbvNu0sO3Qj1GAjUDB0z1p+xAn6bMr9rl3y8WCZYg
   w==;
X-CSE-ConnectionGUID: 5P3kkip4S8eD/Xvacx0Ktg==
X-CSE-MsgGUID: eeI+IpGrSJ2DZprEkmD03w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94454223"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="94454223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:31:41 -0700
X-CSE-ConnectionGUID: OFM21aTwQy+Fi8Ylpx5HTw==
X-CSE-MsgGUID: GLjjPo9NSSS9kKrITL0FQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="254791087"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:31:39 -0700
Date: Wed, 24 Jun 2026 14:31:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joyeta Modak <joyetamdk@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <ajvAGK-0kCfkThcs@ashevche-desk.local>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624073804.4391-1-joyetamdk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote:
> NUMARGS() computes the number of arguments by dividing the size of a
> temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> macro is the correct way to count array elements in the kernel, and
> ARRAY_SIZE() also provides a __must_be_array() compile time check. There
> are no functional changes.

...

> -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
>  
>  #define write_reg(par, ...)                                            \
>  	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))

What is the maximum parameters .write_register() takes in practice in the
fbtft drivers? If it's less than or equal to 15, we may use args.h instead.

-- 
With Best Regards,
Andy Shevchenko



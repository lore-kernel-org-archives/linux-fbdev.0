Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9414B96E;
	Sat,  8 Mar 2025 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469929; cv=none; b=ZCAnrByhb0y00qSxHgJsmFJiUgca//CU73neVMH4YJ37lqXTkTnngdFMwkwI2x4IkLhXctiUT5St72LYnas6KLUEKQUC2uZ4Hh5vs1Z9AIMZcG4e9Mzty4rwRmPZja58GUEPenzJzPAnHPa6PZTdm/jRklZBdS72cqK2+tU3O8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469929; c=relaxed/simple;
	bh=nOy8jfsgTc7dDHaNQlc5vSqZxzYWe15zPz8u70mWr2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEG/Tx1/ifO6iFE8ZWGg5fe3XtlK57ryPwsSrWE8a0c8hFTFmwdPYs7KsAx/pWT2MJCHHN6N/CeNMqkBE1KXBIwRdH+cZFXqQPJYLslPxRPUDqeYrpFNb1SXfrOKYmgWvs96VtU6Cgbzq+CGuIuICE81zxn0sZ1TJSnON47WauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwbqye7d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwbqye7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741469928; x=1773005928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nOy8jfsgTc7dDHaNQlc5vSqZxzYWe15zPz8u70mWr2k=;
  b=Iwbqye7dLuHGNjc/FbfIuNgHxeYh/QuOkYN9znUEz37mXoCjMK3eOvL7
   EkD2aODaghqvcCIZv0mk644jEVq8qVv/Hc41uuq+0y2h8BWjYEuPBBSP5
   mLUr4aqB3P0YVfKkbz+u6s//55xS2n1jm2scZ0H6Gs2ZB3q5pFKe4qpEb
   544nimOxjmTWRMtmVIhRerQBlHRWJCw9PLfuDqTQ2N+QC+nRXdAaniQ00
   BI6r6GfjdoekILEi3zPNiLSzCRRy/tr2+XhmQsqDkxWUR+pRRxEcdjKGk
   LLPCditpidAcDHD7cF0ovVcf6HrVBiLYxfg+xbOHAWVycLOkmZypErpa5
   A==;
X-CSE-ConnectionGUID: Iy64PalxRZGiojrGfSXszA==
X-CSE-MsgGUID: qxh4M+PbRL2pBSU28SvbLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="53881114"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="53881114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:38:47 -0800
X-CSE-ConnectionGUID: Bb8ZtCuyRQ+WFV/KW89QxA==
X-CSE-MsgGUID: Gvd8YX6zRpaKFsfwIt8/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124716483"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:38:45 -0800
Date: Sat, 8 Mar 2025 23:38:42 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: pxafb: use devm_kmemdup*()
Message-ID: <Z8y44sYYCzM51YZe@black.fi.intel.com>
References: <20250228071009.150971-1-raag.jadav@intel.com>
 <Z8Gt8fg07Y-bFPGT@smile.fi.intel.com>
 <Z8ywEzFvWxb59LqK@black.fi.intel.com>
 <6c211340-037b-440d-b5ec-b4a5e2bd4ef9@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c211340-037b-440d-b5ec-b4a5e2bd4ef9@gmx.de>

On Sat, Mar 08, 2025 at 10:12:16PM +0100, Helge Deller wrote:
> On 3/8/25 22:01, Raag Jadav wrote:
> > On Fri, Feb 28, 2025 at 02:37:05PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 28, 2025 at 12:40:09PM +0530, Raag Jadav wrote:
> > > > Convert to use devm_kmemdup() and devm_kmemdup_array() which are
> > > > more robust.
> > > 
> > > FWIW,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thank you.
> > 
> > Anything I can do to move this forward?
> 
> Applied to fbdev git tree.

Thank you.

FYI: This depends on the immutable tag (mentioned with changelog).

Raag

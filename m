Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0643603C6;
	Thu, 26 Feb 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128432; cv=none; b=QzjfARDlBJa0jm82L+M5cQk3NWqsWDj+FNzEz14JTBWgoGpoh2YO9Pcnq1u4DdRIH2k8mTegVK2IJLxUZ/yHlYyn36tfP9PEdyG3ibfKm2mphiMyNwvixtttl8fdX3dtwmKqfDxddTXkiaU6dAORuauAccsvWUqAsHATWpW0nMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128432; c=relaxed/simple;
	bh=c4SC6HnKEEEgFEkog4c01jDAAwa4s1azeinGA5mlb7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYljZNQUL7bsEC6VfBXwqReXkvl1GW+uhO6p8g4L6l4xBCkJxd64TduJMKo6nQOCxNODLGn/wxcuj5cdw2Fy8M3bV7h+Q6kljbVHjrkmitWTGM0Gz0wTARUznY+RD9GVAuVw5ff6qh5jZGWaoND2JtJfh1482EFYcOeyNupi6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+EY9V2K; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+EY9V2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772128431; x=1803664431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4SC6HnKEEEgFEkog4c01jDAAwa4s1azeinGA5mlb7M=;
  b=H+EY9V2K/ciEGLbWcEurWpcsLpPy8u0mqrLnALNA8ar1qpnGO5xEdJjJ
   CHFA0HhFflHfLmrbpP71wvfmgkkuUi7j7jM9g/oMG3wwDzPohtmFxSxSf
   UcBHwfHsfrD/bQSNRcKuQ+yAgjYnDhW3wEfNhvf3zuyu/6UpmSnZ/f+N7
   ZmHmaD34eINmPJa2XMDCc8ZQMevraPI9m/fRZav+gzwMWAXS4ZR4wGkMA
   uI9rTjGd8/d0gVx42jVBYlTMFWiP9u5G4e4diStfHm7nmA5x5I5GVIKEg
   u9eukBDbYl73xvMQQbVGImDrdMOZSn1ymotxLG740L0AcMy/S/CZJA6t4
   w==;
X-CSE-ConnectionGUID: cR127TE/TUaZlU/Widhxqw==
X-CSE-MsgGUID: mcZWFoC9S16dU9qyPPyCow==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="60774193"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="60774193"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 09:53:50 -0800
X-CSE-ConnectionGUID: 9GRmV44XRB2nuVqxst7fMQ==
X-CSE-MsgGUID: QI8NyXopRkiabBVTo5zrrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="247160573"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 09:53:48 -0800
Date: Thu, 26 Feb 2026 19:53:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dhyan19022009@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Donenfeld <Jason@zx2c4.com>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix macro whitespace errors
Message-ID: <aaCIqUXPB75vR6rK@smile.fi.intel.com>
References: <20260226172531.13714-1-dhyan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226172531.13714-1-dhyan19022009@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 10:55:31PM +0530, dhyan19022009@gmail.com wrote:
> 
> Remove prohibited spaces before closing parentheses in macro calls in
> fbtft-bus.c, reported by checkpatch.pl

You haven't compiled this, have you?


-- 
With Best Regards,
Andy Shevchenko



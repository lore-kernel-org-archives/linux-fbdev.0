Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C85299AB1;
	Fri, 24 Apr 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024036; cv=none; b=UcDvN/WHFmvIRNdGrMWeVSu8v73mg8M3LMCDWpVJB5KYdP6fAIms+piBo2CevWi9TZOBj++4xWyJRKSUz+QOExmIT5xvT5i719QysXxHqnV6MB7acMLHk9ZdwtKuF1RlqLnZmu++2wC6/K07dwamaeTiJxq8PS8aaIwYjIOyn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024036; c=relaxed/simple;
	bh=aPZVVYExj8rGj87x79G1gLFlc2CTnEiwGYRXX2rdONg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilh5CdNCQv9XuVUdvSGzjCE38nVHqOV+8sA8VnqfHgjg3MNJmyl3GVLy/lpUbJSXETv1cBGBn5XIgqaHbAYy3XiT9/GyBXK1zmZGPqvXBkW0I3f3gjeoHqYvwxqY7PlXNSBu348UKE2Bpeay3MHppTO+q2L4LqJvuWojZyu56aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+R98wwJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+R98wwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777024035; x=1808560035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPZVVYExj8rGj87x79G1gLFlc2CTnEiwGYRXX2rdONg=;
  b=O+R98wwJRIUYpq3w+bATkte7vBKdvOLKbI849eRDygaYZK+chaZWkB/R
   97ROtJH38Y9ktUp9ERxxAFhC0uSWMuEfO6mg74SMtS+yA6U1ExEn9cV7f
   UlOBYFggArZonmTrVtUDqbmvXfrQcELyNqbLuFLEosofLscYbCYdnhBwA
   dbTZx3OyBv87jdvde/avYMGYiyYAbprf7rTHHFA8G7Jim1dF/sVqu9DTm
   POtRIg5lvI0sxZtBWiGyEJwrZjlY2Wg5+skLxyz4WXBx8dV+hfnVNicOY
   Dv32Q99qlg8us/dGPOmwNNqNXVDjKBiGYnZFPS84VADuOUXYf7KP5MRWQ
   g==;
X-CSE-ConnectionGUID: dmh1h8tmQgqXQeCs6JyFEA==
X-CSE-MsgGUID: Vnhy9yMZQ0GZkWXdGtWUow==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77989074"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77989074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:47:14 -0700
X-CSE-ConnectionGUID: scq+gQnQRFyvh1xiinS6CA==
X-CSE-MsgGUID: B2qnFBHfQpmKXHizg2k0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237912542"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:47:12 -0700
Date: Fri, 24 Apr 2026 12:47:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
Message-ID: <aes8Hql5Y6MrRD-l@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
 <aes6JY3Ht6p1VpFa@ashevche-desk.local>
 <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 09:40:48AM -0000, Alexandru Hossu wrote:
> On Fri, Apr 24, 2026 at 12:38:45PM +0300, Andy Shevchenko wrote:
> > I'm not sure this patch improves the code. What I see it's harder to follow.
> > NAK.
> 
> Fair point. Three near-identical functions hide the pattern the macro
> makes explicit. I'll drop this approach.
> 
> If there's appetite for a minimal fix, I can send a v2 that moves
> EXPORT_SYMBOL() outside the macro body only, leaving the function
> definition untouched. Otherwise I'll leave it as-is and wait for
> Greg's take.

You can try that, as I said it would be a compromise because at least I agree
with the awkwardness of having EXPORT_*() be hidden by the macro.

-- 
With Best Regards,
Andy Shevchenko



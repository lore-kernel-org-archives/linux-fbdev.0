Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB71C3BFC;
	Thu, 19 Feb 2026 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771486219; cv=none; b=YsMcFasTbOAyOuYuPoCtSWxFHrO97mtXX4tzc/AzwBQorVwynVZCil4xiKm7viXsvH43Bqj4r18hNJBtt0N/My+omaYXfuE3Iuy6ERK6q2OS2F9pTjBggCRFxZn4PldU1oVo9h8hfWHWKJ2ejEwDtnPxSKgljzkQYpcHud5iUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771486219; c=relaxed/simple;
	bh=NrBEuh/7ayAYMjnfF5iZ6pbCKqzPo3jm/LVOQv5Zd1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpfYt+AWjqC/HLOIMVhWjD+xnN1BVm2gFhNLtGo38+DsORRJv8C4BzFH78NQ/vEkVbIxfjRcT3GtHW2xgkKtl9F0F5VIpQ8KgyHiVNxnsaNuNebOWYRFYostFyc6FmFiUCqnCq9Rt+CcpvBueq/dHxtgMX+ujddP7137sTVz1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mg/QYjy+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mg/QYjy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771486217; x=1803022217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrBEuh/7ayAYMjnfF5iZ6pbCKqzPo3jm/LVOQv5Zd1g=;
  b=mg/QYjy+v8kY3ZKCiuSEpsS+YnlE1KkhcuqITw8Tua+qFZaHZU3Ky1ms
   uWpa1D5VbXfY0Fi5GeLrtU8e9vWjbGKtgHxjU0aDH4PA2QCHnKs8HbPUT
   fV/wGXxbwvXn0GfJgvNUpo6nCqSmn/6Ezv3ekaJF7d/kNUUJoFSvR/vr1
   GCyCTuiS0ZpVA9LKfOmejxl1lXvkf8cB2eKVjpHLioyOOKx/5Wfy9o5Xe
   EkvCCOOh4+mJIf8gBff3D4ZzbpkGtSJc2/iGwepUDHJLhh4EmRZ3+2edW
   HDUhMS3npWgoGzDMfbLcnF+h7tKBAtf9NTC9j6QLYpfYKnE005cVr6o8Z
   Q==;
X-CSE-ConnectionGUID: KqdQ4x7tQw2WC+Jb8d4w8w==
X-CSE-MsgGUID: /oeHKTfDTamTDvwmDStO7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72609597"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72609597"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:30:17 -0800
X-CSE-ConnectionGUID: V+r9DswlSqeZliaiHcVU0Q==
X-CSE-MsgGUID: 1/fOYUJGTrinwn2TGOkigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="212416634"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:30:15 -0800
Date: Thu, 19 Feb 2026 09:30:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: tomasz.unger@yahoo.pl
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Message-ID: <aZa8Baq8YW63q2W3@smile.fi.intel.com>
References: <20260218174737.86994-1-tomasz.unger.ref@yahoo.pl>
 <20260218174737.86994-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218174737.86994-1-tomasz.unger@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 06:47:37PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>

We do not accept changes without explanations.

Also where did you get this idea to convert udelay() to usleep_range()?
The API (in case it's okay to use) should be fsleep() nowadays.

(Note as well that we refer to the functions as 'func()' in the text.)

And last, but not least: have you checked carefully that this is even
possible change? This is quite a change in the behaviour and needs very
good justification and testing.

TL;DR: if any tool suggested this change to you, go and fix that tool
to stop spreading misleading ARs!

P.S.
NAK to all your three patches. Also check https://lore.kernel.org ML
archives on the similar changes in the past, they were all NAKed
(rejected).

-- 
With Best Regards,
Andy Shevchenko



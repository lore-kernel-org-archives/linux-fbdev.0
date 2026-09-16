Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7244A401;
	Wed, 16 Sep 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556780; cv=none; b=OWLkFDeyR8uKpiDbKwooibbkLlDbDSQNkrjrBa0Qhq+/tU1YQKocSFQFwgQk0lhpIAfnE0jfRWBYrpelGGU2+TBnWb4zoc3TdgELgoG2z4iuv4LQ0nkxoOGXr7ZM9UiHnjWlYUJxRXYA8vDrFAn/p58mnJrfq8VzuwGW5luKQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556780; c=relaxed/simple;
	bh=HzRpDUemKObzUrc8XbP7CS1ebBC8gLFixWIizYLS1YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OulSIVC0KAoDM8na97NhQohd4pO8q/kflMH73nFsAQ56do/vUde0hjP24B738OIUAKK8gPP+U1O19uQCXayrp0q0AGgtO4P+84Qe1B3PXNlQP0oXfb4XrcHpbuS9QhUyaPJ9Fl9A3bHgwhes1Ou3g0FqOClyOXx7T1IKtifwQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4ROJ7pW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4ROJ7pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789556770; x=1821092770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzRpDUemKObzUrc8XbP7CS1ebBC8gLFixWIizYLS1YQ=;
  b=E4ROJ7pWYtNqDb+0eDNUI7NnAJJpjKslEiNr7H4LNIz7azg/NjGARtdq
   hRg9BIdVbzCZs6JVdVxBKseUFALdx3gbrcPfrTdEcN6+Jv7dT1uHTPsPq
   Qtcwt5KSW89WM2B0wbKsDJaYlha34fYG2O2hkiFLywLzLSxH4tVT0nl5I
   C+EkbkJF8tLVCZPsxL72gODbrst0YeQlmf2SUTPIWMMR3Pv+VxJb9bNef
   OOxefOie9T+e0v4UmDvlZGFUIEcqHENdUQlvaUeidOefoFzszAPGjarjC
   GZDTzufhcszt3KfX3VRrBqkGAc9a/5hXn+dZtKth1YhKO0rIUR17R59Ez
   Q==;
X-CSE-ConnectionGUID: NNKAlvJoRSeck5CrrUpB4Q==
X-CSE-MsgGUID: XT6L5p6DRNOouNCWe12GSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100255070"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100255070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:06:04 -0700
X-CSE-ConnectionGUID: hL6MRQfjT8WMVh/W/Yapgw==
X-CSE-MsgGUID: 74I0UvttTXCxG+cNXNYKTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272832452"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:06:03 -0700
Date: Wed, 16 Sep 2026 14:06:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Omer PALA <palaomer100@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aqp4GA1q6cLKivZo@ashevche-desk.local>
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecet5xos.fsf@yellow.woof>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 11:53:55AM +0200, Nam Cao wrote:
> Omer PALA <palaomer100@gmail.com> writes:

...

> Btw, I am curious why we have these udelay(). Can we remove them?

Once again remind people that FBTFT works for both busses: SPI and parallel,
the latter one is usually GPIO-based and quite slow (I have one of the panel in
this mode, it gives me ~2-3fps at best on a 10y.o. x86_64 embedded device).

Maybe that's the reason? In any case, I think the datasheet on the panel should
answer the question.

-- 
With Best Regards,
Andy Shevchenko



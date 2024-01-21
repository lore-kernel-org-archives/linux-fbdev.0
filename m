Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DA374F0;
	Sun, 21 Jan 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705845306; cv=none; b=bkJoG5uCaKUyMrXFZhFEVAnPFFsowItacgs05oQDeSN4OV+tMG0WBBgLCUkIOQsfeO43qDjOmrbGYqc4qQ0AwjbrKejaUg58ieyqbxARIwsEL40qnldzB+wCrKx1KfC7TXXoKrt/0b2GODfGV5SLxBABxC8FJXCbKFaK2CydvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705845306; c=relaxed/simple;
	bh=R48NpmG84koS2tGZXQk7+5epMId7bmv44QQnOetSWZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2YSja7A6ugCwS1Rm8BFKZ3OY2HRYrGNZWj9HeqPzvlP3mGZeIadbGUbjroPHDkDhxk7Mtv+PUQZXKD+xOrrDKEzqEmEiZ9kA1sLhNq+QL7Bp0+AuoHS2beKeY19n+1NQPnq1WwbScaeKN4sZMNJ9P//KHo1n16egEscxr0h0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYYgPYo6; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYYgPYo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705845305; x=1737381305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R48NpmG84koS2tGZXQk7+5epMId7bmv44QQnOetSWZ8=;
  b=HYYgPYo6q4vC38shYL09M0TM6CjIeWtQHBoLPPTtnZOn2r7MMeHI5KtT
   Avvx0UrMCZPu95AK144VZCILR5r7GLRaAuyUhPTTlZsfvqd6hRj/qcJJD
   nkKTXax7fUiKyIRuMFe2NK16B2qIis6+1DA3kWdKWKxBf5Tvs17kfiZ11
   zSLeh/MNqh0ovI7w8MIS6dIDh/4h2G/GGlkDW7NdlxqSaSv7QBFICzh50
   FUiWySdjOwM45AtrNatrzGLPTHPsNcEVXkA+M0YsyOnOPvqx6KbdLOHCY
   vuhOMKBohrKFbRfK5iRPVOUlMhh40j/A8MlsH2O6iy39WzCNykDEFpuN7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="398192245"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="398192245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778363190"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="778363190"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:55:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRYCR-0000000FunQ-24vF;
	Sun, 21 Jan 2024 15:49:23 +0200
Date: Sun, 21 Jan 2024 15:49:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
Message-ID: <Za0g47CgOH4MhdRe@smile.fi.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
 <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 15, 2024 at 09:22:19AM +0100, Javier Martinez Canillas wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

...

> > +	{}
> 
> While at it, maybe add the { /* sentinel */ } convention to the last entry ?

Maybe. Is it a common for this subsystem?

...

> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



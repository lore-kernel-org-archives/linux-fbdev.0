Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9D22FE05;
	Tue, 10 Jun 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552816; cv=none; b=thyjRqYG/4WiHB50xNEFZ9sTOHhHZ6Q/ajpY65JsdlQy7w10V1YW84pGt39SGdvM4ZINkdtfjKOdv3+Z4Ttev28DYN+6xuzAUVDT1PB/0eCsCEdQxTgRcSG0S2m1EYqwBEEbyTU6tZs20I9lXRl8EyrzanOhkFBmun9R+5zq3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552816; c=relaxed/simple;
	bh=/DZZ8mmbF4Shhai4foKWvywv6MHjfAF5Mt342aSPnPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkKQs2g+5bHh/Hq/KIdOIAaqlaPyts48Z5lxmxcHhY7KRrnQyk3gOVgKAM/xwSRh86+JCkIEptOqBqXjLeEZTiW4Fyy+exbIeQZGoCaR/TzulQtY6A9HLiu4dbP6BdpYbIqtJcT9tyJjlIOt8KVQxUP8zpgSbsZyOOXXnoHjEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyipRd40; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyipRd40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749552815; x=1781088815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/DZZ8mmbF4Shhai4foKWvywv6MHjfAF5Mt342aSPnPY=;
  b=SyipRd40/fdxSsaBSdjHXqS1zO7wghQ+VSkqBPRvV6ePqTvtprCfVQ3j
   RBtA22LLfLdnHCilfcFWji1RRPbumXpZ7QWZ/hKAOZ8V8jMqEgZ1R6SDj
   4779eFNFYR2UiRn4kpGfZJHUPmj1EIF3+3UVtfQpzj4h/y6gUTigx97GW
   Yo2yQ2Brmgr+8kVaHU1mLKdumUWtMYOLSkoMu7fFLAyFoB9tD9SRxD/Gr
   e3Xnwt9zak0CxdJbu6VU0J1x1d9JSf+zaE5Skoqb/hScvOUHij0Wzbz8X
   hOLd+ku9E7FIYg+UQDzix9olmtfWZfeVNP1v52Hapr10pN8y7P22UXq04
   g==;
X-CSE-ConnectionGUID: uzAdt5paTPuJluybS5ht4g==
X-CSE-MsgGUID: UNh3fJ3UT52TE1fuVRFAUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="39274512"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="39274512"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:53:34 -0700
X-CSE-ConnectionGUID: 9mnfzALsSnyZDuqhQlSDHA==
X-CSE-MsgGUID: jGAGc6ndRf+bdO6YIrQc9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="151813579"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:53:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOwbf-00000005KIT-1Mi1;
	Tue, 10 Jun 2025 13:53:27 +0300
Date: Tue, 10 Jun 2025 13:53:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Paolo Perego <pperego@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbtft: reduce stack usage
Message-ID: <aEgOpxYVSROvbpl_@smile.fi.intel.com>
References: <20250610092445.2640575-1-arnd@kernel.org>
 <aEgIX221QIt5k0zY@smile.fi.intel.com>
 <088dc0a1-fc54-478c-b253-4ed5dd6d6bae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088dc0a1-fc54-478c-b253-4ed5dd6d6bae@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 12:35:14PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 10, 2025, at 12:26, Andy Shevchenko wrote:
> > On Tue, Jun 10, 2025 at 11:24:38AM +0200, Arnd Bergmann wrote:

...

> >> +static noinline_for_stack void fbtft_write_register_64(struct fbtft_par *par,
> >> +							int i, int buf[64])
> >
> > Perhaps int i, int buf[64] should be u32?
> 
> Right, I can send an updated patch, or this could be fixed up when applying
> the patch

Greg doesn't do that (or won't do anyway), so either a followup or a v2.

...

> > Wondering if we may reuse this in other cases (by providing the additional
> > length parameter). But it may be done later on.
> 
> I tried this and that quickly became a mess. It is probably a good
> idea to rework the code to completely avoid the varargs function
> pointer and instead take an array here, but this is not something
> I could easily do myself as that takes more time and needs better
> testing.

Right and this driver in any case in a frozen position, so it might never
happen, though.

-- 
With Best Regards,
Andy Shevchenko



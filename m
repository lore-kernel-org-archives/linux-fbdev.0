Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785425D527;
	Wed,  3 Dec 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757842; cv=none; b=kN4QT/S9qag1MU7XYGQF+hvgBBcvHae3XkA2xm3u1MLYM8MJQaTbfRrB7u2V3hhUXo6QudpLfVRLBHvhLbaVp46HWc3ESJKHoz9Jg/vi6z7RNxFu4GieVie3uSgyG7BVI2FWW4wmweEveutgUBN67/SO0hCvNloBpAkXrbhgNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757842; c=relaxed/simple;
	bh=ex4yp0DOTkoFkt2x0EIxntGcCcOHzUkfftORF0VeF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsDL8f3cukkntweH4d0QF+2qZgdV6W2gEvccxXKu7NpTwK7QfwsGW9OhPvynh0L42j2GGb1ln6di9Jo91uh9DbT68JH1Gcykf5HhKqgARSRhCn6Xgh6YTbkmutEPSAddLwRgmXw5yDG+vDNQEvVP8U2cdz1AhB6/hDFnixpomrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSrgFiEt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSrgFiEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764757841; x=1796293841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ex4yp0DOTkoFkt2x0EIxntGcCcOHzUkfftORF0VeF0k=;
  b=WSrgFiEtG7Gi/9ayObtwEPqLvLlf5Li8PGUbCmcr3W1FcE58BaLX1hlF
   UhiUCdkzTgaiz9NLFtyWC9YWa+sfuCzIVU797thz0cYL+2W8K4fzJi1w3
   ET+75oimKnE9IWKJnHIhrH2J8QwCiuYe80YhtpEtmGNqJxMZPJSP1MHBK
   ZMwUvXYe7331jXZVgSggquiD07+44fI6AAfEt5w/i0fJnLrK6eVB+M6Yz
   Yh0jxRQwhj8F14eX/pgIdJ3k6FwkhwTbPmhWacB/zlgFqPkxk3GcK5dgJ
   2jtJKE0TrfT+8WZ1MXyop06PAsbpqaLs0cREMSjehxVh6kZN6hywUMCCM
   A==;
X-CSE-ConnectionGUID: YlbCkWFJQtuTCkjAMo/yFg==
X-CSE-MsgGUID: I1Oe9arhRwKZEXx/KrQUtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54295791"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="54295791"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 02:30:40 -0800
X-CSE-ConnectionGUID: ZhJZdhKJSau9XettcOgwwA==
X-CSE-MsgGUID: nmR5KVlsS1i4rh21Y2R/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="195059310"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 02:30:38 -0800
Date: Wed, 3 Dec 2025 11:30:36 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Helge Deller <deller@gmx.de>, Thorsten Blum <thorsten.blum@linux.dev>,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/pxafb: Fix multiple clamped values in
 pxafb_adjust_timing
Message-ID: <aTARTP6VhZG7-JEf@black.igk.intel.com>
References: <20251202181600.511166-2-thorsten.blum@linux.dev>
 <a7213b69-f6ae-4975-8c8b-2783dbe9f9b3@gmx.de>
 <C3FDBCE7-14D9-4999-B463-C2E3E384E7DB@linux.dev>
 <77ac64e5-709d-4eb5-8b47-9fc15e579d1a@gmx.de>
 <aTAHkxg1_LDzZNSb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTAHkxg1_LDzZNSb@smile.fi.intel.com>

On Wed, Dec 03, 2025 at 11:49:07AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 02, 2025 at 08:36:08PM +0100, Helge Deller wrote:
> > On 12/2/25 19:36, Thorsten Blum wrote:
> > > On 2. Dec 2025, at 19:28, Helge Deller wrote:
> > > > On 12/2/25 19:15, Thorsten Blum wrote:
> 
> ...
> 
> > > > How did you notice? Do you actually have the hardware and tested it?
> > > 
> > > I only compile-tested it.
> > > 
> > > I stumbled upon another driver with the same bug and then used grep to
> > > search for other instances and found about 6 or 7, including this one.
> > 
> > Ok. But this then means, maybe the clamping isn't needed (since nobody complained),
> > or that nobody noticed because nobody uses the driver any longer.
> 
> I think it's a combination of factors: 1) rarely people have this hardware,
> especially nowadays, to run more or less new kernel; 2) there are no conditions
> happened that this patch fixes in their environments; 3) something else I
> missed.

I had a quick look at commit 3f16ff608a75 and seems like there wasn't much
happening either way.

Raag

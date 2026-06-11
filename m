Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F936D50D;
	Thu, 11 Jun 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164997; cv=none; b=alSzTu4+ru3hm2jk72Y1DvreNSqO6KTlNEbIcL8+44pLateBuLOVGILxwM+9d1wIT6D2AWSQ8BtgCKj/h8t842+ln+OnaVc4/IKJkaQweyk2C9wAFoMAK7wnbT0czP1dip/sDPf9r/TlavDNLcZNwMyBD0CWGzNGfO8i0cFWs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164997; c=relaxed/simple;
	bh=Ok2uxm/+RAQD10yVIEOzY444cIER//V8tOb/oha4UDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L63m5my6pGpYO5203g5xOWmi7zqVe8YF7Kcb79dgDLkoIZp365kpwz3f+KIMOfnPgTs9jOTrYxvsu+nG5L6BYT/b9PWdQw2ScGay2/0d7tfrrBtdh0WryDXaL0eCFvWHVRcZXx6vsu1UW1xztiUVBKZV9eqSTz6NzF6Tx7V7RrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpUE8LHi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpUE8LHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781164995; x=1812700995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ok2uxm/+RAQD10yVIEOzY444cIER//V8tOb/oha4UDY=;
  b=YpUE8LHio3/FNjO/hcPUUTCppKan2xPlurshgWrR0+AOx7ve64A1yLI/
   k1l/ZRraCvS/jwqOWRbmBywGsLC7cw02qkv9SoUtvp/c2ieOUBUabcw5E
   bBvGNBHyOrRgtOSq/fYxHUouob6+n0Gxk8D5p8dfkvS6W//ei1OpQcVi8
   6GRZ9+Sf6tUVZ1ERkZeICeB4YI1116wQtHXFNcjf6Vl4LnCUQqFyUYNYB
   ghrC1AisWNfTCJvEbuW7s8OMQKTJByAERNrVn6XA906MBHjsLTMJFnGD9
   QlPv3hmGPcNRYpNoIh5a3BU8otxMOoaw93UrYntwwe2RmiwvaZ5yC9GBG
   Q==;
X-CSE-ConnectionGUID: Y3V77NnrQ5qL70paPrsT5Q==
X-CSE-MsgGUID: zbosYHxjT36lw9cF7jELLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85869175"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85869175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:03:15 -0700
X-CSE-ConnectionGUID: YPsm1ZJRTO28vwiL+pNZiQ==
X-CSE-MsgGUID: 6+WXQ8+JTyCDmFqo5iVVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="248284111"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:03:12 -0700
Date: Thu, 11 Jun 2026 11:03:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix typo in comment in fb_upd161704.c
Message-ID: <aiprvmR0jK4B1Q68@ashevche-desk.local>
References: <20260611-upd161704-typo-v1-1-2e51387c3b28.ref@yahoo.pl>
 <20260611-upd161704-typo-v1-1-2e51387c3b28@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-upd161704-typo-v1-1-2e51387c3b28@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 09:53:40AM +0200, Tomasz Unger wrote:
> Fix spelling mistake found by codespell: "cencter" -> "center".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



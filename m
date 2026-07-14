Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FD2931DD;
	Tue, 14 Jul 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056624; cv=none; b=lWv1+FTH4J1Jsfz2hN/wVzxvIJD+QUZTteBYqmzKUWgvNVM/ukiaIdVXziDgp27t4ahcpuJGvnS5lwk4d2kuptiKZiN29jz8efovjiZXCJHdDz3TxqjgypwQ95ma5qbdp59Mu2i56E12NddjLZGWNvvhXhTQHWQxQw06bGEk/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056624; c=relaxed/simple;
	bh=gVE45JI2u55JH1T5FFCgHRknhGi34AOmMRt18ggclzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHYG30FXc1C7GP9K62J8F9gzWyl7ogrrQ+Kl7RJEVI0Sb+5Otbq6dzwqduspzefpv2XC6s6niZ3UQc0Qlg0K2GF525ZWQ8XbVx8IMyFEAHAWtbFYVwsMUAnmKf4QvbmrG6fZccVBTSCFN0qqExs5rCw4Q+4w3CVp9I3N418gy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Et5a6ebm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Et5a6ebm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784056623; x=1815592623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVE45JI2u55JH1T5FFCgHRknhGi34AOmMRt18ggclzw=;
  b=Et5a6ebmcq3zSLJeVD4ZZfAnhTip+11bTOrgy5OU1bn4myhnOX4RSFhl
   D2w6ohddr4sxFXzRRuouz6mEBgSxCMxm1qsuceLfwLMTUH5Sav0P/o0y9
   9ZMEzbw463J3JBZFkytinXUIZF7igu7NtMpM7/2al4FIg65lpl9foEp7j
   md698OGbzE83vwGjIUVk03EacynCl5YPbMpjMLgO+A5HO+1o3cvjpdI2n
   U897kCD1+MHkcz4QFBCFeYgxLzfWtH7i2Ki9ZXf6qjzBOpgXbCpyy3o2J
   LhB8KAkI2EZoxvjmDB+P9aTGZ4VEomc5CAwBpsgKRdW8B7spco5XDbI1L
   Q==;
X-CSE-ConnectionGUID: 8UxzsWrVQRO+NWDVcTq28Q==
X-CSE-MsgGUID: eQSTha6aToC5brA0GZs8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84732450"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84732450"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:17:02 -0700
X-CSE-ConnectionGUID: aw7kamuERVWCCBxZN8oMFQ==
X-CSE-MsgGUID: d9WJvSGSRD+kfBTsNTQBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259786742"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:17:00 -0700
Date: Tue, 14 Jul 2026 22:16:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
	tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging/fbtft: Align arguments to match open
 parenthesis
Message-ID: <alaLKv95e0KmKX_3@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 10:09:41PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch warning for alignment in write_reg() call to match
> the open parenthesis, improving code readability.

NAK.

-- 
With Best Regards,
Andy Shevchenko



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006685;
	b=pm3lZl9jtzwAfQTQBTSzjOUtm4JdlfuOWKG+dhql4CVm1sOHwvdL3Nu8RwQyuAOoEsQ3
	 SmJVLoSvDYv+Z8I1nQCl7mysg2UQXNBIjyYaMZDpisrjA3kHyyb5W9Z1vUs/Ih5L5hsFz
	 geI54gsdzbjJT42QLI4523ONMZU5oEsPj6QB2H2t1dNnbsrBu4tr/9fowva+vpmVwppvB
	 0ZAejEEyz0KqaKH9PvGfTauUNj/BXBB9HswujP3ObMnVCtEMIhISOp/qxqRSwMANVtQD9
	 K1sFQG//NY0j5fhcdDYihWNDIWq5sOzcv8ytO22HmWbI3WjJiKadnwGkuMIobAl0nfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006685;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=XyY6QwI5d5wBdkJzT0g/k8F7w00iljyIPp+DEpMbmXU=;
	b=UogqsuFU793T8kP26JwkYu//WB9bHacDytYv5B3AXSEDW96Fe7+bPbOPWNrUI1RIcE7V
	 igO2hv1DFN7nDc5WhBOTWJgfauVbj29OkIaYh+EuxVLo+jK9yyJzmdCFzYWTHTbU+4nFw
	 ZNVRFeWqjj0o/gnctG/FQMRJjQfUo0iZ7Gu/3qBnlLeXOdOB13ZWqjz4YMDxLJPgodF3M
	 FdFCWKJC6K9JWiHkl5bXqvLsAXhYGtzpQi6kKWeDpuxD/eymqEWRrOVoaiV1NAJrlfG/k
	 oYi2rklW6aLQcsfGLXmpx6aZadgxbmvLWkNmA/a7Q0QkV+8/kc/w7TCn1N54cspp28g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxHPWCFP;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F90606A336;
	Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F90606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxHPWCFP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793006685; x=1824542685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nLVdTbTG3BOOg0NKFoId7DXu+3MHSWUcFw4OvEb/0iI=;
  b=CxHPWCFPUb/ZL5e1sFsquhvWwEWNaZLl0e6mCh0votwKmf+B4qzPNrSb
   nikiaM7Wp1aSLm4/sr9mi4ROaCFD8GjyAnFVGMLOBVuteccULsGap63yC
   jePXfqTO2qZYLKbGwTu100lfwudj8nNDr6jGdBFzEEt+O4h1GJ/iaghdn
   qXC7TQfEhZdtDKFWtvdkEOdR07P1ASLco3oSeHShhuLe/EU+AqMZ7ye9K
   YMT0Z9PQse1bwR/Y/6pipkNRk2VpIs1Xn5aFvvoKRIYQKROE9F/xy99Du
   GFW0jBkEyEra1HE8Xp3LwmgrpX0P90gtxPvuV+6ncLTdnH6W53b3tzvHl
   A==;
X-CSE-ConnectionGUID: dIRvxLb0R/mWEXTZtLb5ZA==
X-CSE-MsgGUID: IYSQ9z8WTeCCuZ/5q9puMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1567574"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1567574"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:24:44 -0700
X-CSE-ConnectionGUID: SWD2y8FzSO+MtT9Rg6GkFA==
X-CSE-MsgGUID: vPTCfpkGTMOKogBsIiegLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6044272"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:24:41 -0700
Date: Mon, 26 Oct 2026 11:24:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
Message-ID: <at8cV1asiwO1FtQA@ashevche-desk.local>
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
 <at8cAMm6psyWsqbe@ashevche-desk.local>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at8cAMm6psyWsqbe@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 11:23:17AM +0200, Andy Shevchenko wrote:
> On Mon, Oct 26, 2026 at 01:48:32PM +0530, himanshu bakshi wrote:
> > 
> > fbtft_init_dbg is not used in drivers/staging/fbtft directory and
> 
> We refer to the functions and semantically similar macros as
> func() or macro() in the text and comments.
> 
> > since dev_dbg messages are good enough, fbtft_init_dbg should be
> 
> Ditto for both dev_dbg() and fbtft_init_dbg().
> 
> > removed. After compiling the driver, there are no undefined macro
> > issues.
> 
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
> 
> It doesn't say how you tested this, though.

Ah, after reading Dan's email I noticed that the last sentence in the commit
message actually should be located here, in the comment block.

-- 
With Best Regards,
Andy Shevchenko



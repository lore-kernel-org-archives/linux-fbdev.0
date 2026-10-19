Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E533E0758
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402380; cv=none; b=nkPDicVwhZ3uB8HPevEg9KVsRcpIbJy/RYzrFNLG0cMSdFGhFoa61gGR8WIUxAOn3OHMGKvU93Rh9PAJmA0d6zF+DyysmoezO4gWwwp0IqJwls4bRnkJ2XqptDK0LDypbUyZGTZAVAOWXTUcO0k2fAFClIKJOyzBWZXkoNkSY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402380; c=relaxed/simple;
	bh=ZhyEg7g3MPxYgitM/QU3nd+2tn4+kNnAmnRm3uc4nJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHY8LAPUK/MOl1Mq01yViaTOJS7fduukSDRFTiykjYp3PmDUpPSA4D6tLJQxSk3bqqdM0gnvL03yRoS0XV/H0MYAZJFGAr3d9NPmnwIfG8y5PskS3eTrO/nEb/IginbIuF1sAOjWo0463Jvldu+KFEahhviGTOk897zzhbVdzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJpB87ZB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJpB87ZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792402379; x=1823938379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZhyEg7g3MPxYgitM/QU3nd+2tn4+kNnAmnRm3uc4nJ4=;
  b=MJpB87ZBzzoSUePXTnXz39531owPNq+oD0dlQGaQp/vpH3gYAbtvqqkg
   /oLaI1O8xlfvlDIAvtjhawgYQGDcpiIcREeOz/eX0LY948iysaTpw7xRB
   NdWUIxP8lIRaK1d+ItcmbLy5oikFW9viDijIXtuvkfF7S9g0ejSNU68Vc
   RfXxRTdvmpvGoNBEbUzAiS3zY+j1Ury2MtKdAS+RMxDFbhutsVG2+O2Zo
   SzUR4OTXuYC16qeY0VLc06sIGleVN6lb031LTnxKERxrn7CqX19LQVRnj
   bn78bo3lo69R4Pj6U616z8CP4DZo8gEzp86bSic86IL68QT29e1EqQvm6
   w==;
X-CSE-ConnectionGUID: xA652XOkTZqpiNugTLZ1lQ==
X-CSE-MsgGUID: sFA1TvmnT++ibRz1SI2nJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="982712"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="982712"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:32:58 -0700
X-CSE-ConnectionGUID: XUApzBz6RvuCgQ5/r5IXhQ==
X-CSE-MsgGUID: LcgvO9mSQOSbvrYOtREEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2377382"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:32:57 -0700
Date: Mon, 19 Oct 2026 12:32:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Comfort Oyewole <coyewole7@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, outreachy@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	Julia.Lawall@inria.fr
Subject: Re: [PATCH v2] staging: fbtft: remove trailing semicolons from macro
 definitionsandy@kernel.org
Message-ID: <atXjxn9DzmXQCX8T@ashevche-desk.local>
References: <atUG5LbCbePRNn5M@ubuntu>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUG5LbCbePRNn5M@ubuntu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 06:50:28PM +0100, Comfort Oyewole wrote:
> Remove trailing semicolons from macro definitions to allow the
> macros to be used where callers provide their own trailing semicolon.
> Also confirmed that all current uses of these macros already include
> their own semicolons.

Yeah, it's v2 and you have still failed to even compile it. Don't bother.

-- 
With Best Regards,
Andy Shevchenko



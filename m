Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FC37FF5D;
	Fri,  2 Oct 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947569; cv=none; b=EgaEesYOJPbgLzCbpgvEbqz9/s69ZF498gv39A9cS91egPjpLpR3nanCYYpwxH3wZgy/oTXTyeNFbl17iM369NwVY+gK4BgLlvPFcNY10fVoJwiUxQ3VfUg+L8qFt1DEDX+vyHSZSjY/4CV3iWIbVekHxQ3OI0P2lLitAs29maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947569; c=relaxed/simple;
	bh=CWPptF2POV/5KDvdcCNlvnaNBA/ndWYIWDLd9SWVH2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx21HU2igUPRem6CFJtx1m50F7y6k9olizsYdtoxqZPgvpQJDQ35Q23sYF4Hc4CUGU0vOMBS6m1R7jnJxtVkXK0saQpN6Y01C+LAMFqKVnPHv3s23hHj1zMLjlS6DnD17bJBpT5i9r13HfLI8X/oNXS6qHVg9dIwYqSm+3l1XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfLVJ32v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfLVJ32v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947568; x=1822483568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CWPptF2POV/5KDvdcCNlvnaNBA/ndWYIWDLd9SWVH2g=;
  b=IfLVJ32vgXv+4pAUxSPQvFwH9ZGi6LcW2hODaEgaSCNxW1bHfR7suGts
   k2zV5pAdf23wHd4F8qeoDAhrcaqno9fLcDX18Mrmz21jRJfUJiDvLqQIk
   sKxUCgFo+IJ4ofaNzE/e1TdcViLBGlMoWNHoPlfF9vPFFKPzNpDWXavUt
   Ep+9sOtTnfk2AtKB25w8NdnlvhEy1BSZVnjLQ8zpzChx2ZN2gdBwEWCJP
   QmtoX+Z84tBJTro704fC9CMYYs+WXlAjzFIRRSWXmMeDrYV0W49unHNAW
   IIgSymQquWcpos99AYhHTPd8Jd6ixg8ke2mdDabEgNnYvQEtOfOpFMf1A
   A==;
X-CSE-ConnectionGUID: UJQ8X4JcTCSq5PvWuc2cMQ==
X-CSE-MsgGUID: o0oDqELWRUWNzggDtPPGqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90768478"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90768478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:26:08 -0700
X-CSE-ConnectionGUID: AszzBaCqSZ+UMEBZg/kajw==
X-CSE-MsgGUID: 8TCjU4HQR1SGXLQUZWjSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="272653951"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:26:03 -0700
Date: Fri, 2 Oct 2026 16:26:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, decui@microsoft.com,
	ssengar@linux.microsoft.com, andy@kernel.org,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 0/7] drm: Remove simple-display pipe
Message-ID: <ar-w6GUQqROQkdec@ashevche-desk.local>
References: <20261002124456.741011-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 02:41:50PM +0200, Thomas Zimmermann wrote:
> There are no drivers using struct drm_simple_display_pipe left. Remove
> the related helpers from DRM and clear any TODO items. Hyperv-drm needs
> a minor fix to include some additional headers.
> 
> Since we're at it, also remove include statements for the simple-kms
> header that are no longer needed. Most of them are likely left over from
> earlier usage of the simple-display pipe.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for the patches 3-7.

-- 
With Best Regards,
Andy Shevchenko



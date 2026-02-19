Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E92E093A;
	Thu, 19 Feb 2026 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771486255; cv=none; b=ngHUnSGK/A0SL3DTvl80n32YQv8HkpNXXB7Jce49+c1Xv7p+NayhCrNW3DD4u9wBjjo6Eg5181/3sfQFezgzhCmsJFXDPIQZx5JpoLpS91GBb+Q+WMqOZ46AU9Cbm2t4hxCnbK/gy4X555RDVu81zN+fFL5CUzjqOumnWWHSzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771486255; c=relaxed/simple;
	bh=6B+i4AmAQ6LDr8MyhM67PG9FcoE1UJyBcPeHZZ0PNUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/5ye7NCSVVIKDQwkNLprPQ0txFa7E02ZG6hPIb2hiUPRKeqAWBlfWBAvDwwrkQdmVGdIdGgPpG4yvNCceN74DwBPt+Vq09Z+ZhYFTnFhVCeyi7pm50FTUddmClZ+XOyzBT/FxMS1kAe4l96y2K88vV7uq8crQAVICbDrmurVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFlrS2nH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFlrS2nH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771486253; x=1803022253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6B+i4AmAQ6LDr8MyhM67PG9FcoE1UJyBcPeHZZ0PNUQ=;
  b=ZFlrS2nHpC6HA1B4Ce/aJTD0flo5MC/k+ur5gmrBpAObvjiAkwWkRHhA
   TuePZc6cy3VSqIiFerUC+iAX1Zyyclq+bhB7NwfurTUiw4dcrjmsojebV
   +Uc9NGDu3zSfOjJ3kCYNaleZe0Ha8tvLj41chhmGkgATPE1x3+W94p2sa
   HXg47sN7kS3gogZyObY0LKdKhYw2+5aqn3cYdThbYSL12lAoaTHuAjehe
   NvspHde0DN0bo1Ht1lwMnRRJdgVYGc52c3iVQ8+3ox4GNsySe62mlwM2d
   EWnnGe3EBFLfKG+cZLGqz8GrAKCgOYsflY0i3xiaizYkUwO7D9z81Rr6p
   g==;
X-CSE-ConnectionGUID: mbjNKf1lSjWn/hXX3dJGiw==
X-CSE-MsgGUID: E5QsMXmXQvO7SSu6kb9m6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72468892"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72468892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:30:53 -0800
X-CSE-ConnectionGUID: //TMpRJLQIWfCnzBl/ZAYg==
X-CSE-MsgGUID: vlsbxh1/Q6G7USl6VzfM4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214298280"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:30:51 -0800
Date: Thu, 19 Feb 2026 09:30:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: tomasz.unger@yahoo.pl
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aZa8KW-VHDTT4LQA@smile.fi.intel.com>
References: <20260218180347.88034-1-tomasz.unger.ref@yahoo.pl>
 <20260218180347.88034-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218180347.88034-1-tomasz.unger@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 07:03:47PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>

NAK.

-- 
With Best Regards,
Andy Shevchenko



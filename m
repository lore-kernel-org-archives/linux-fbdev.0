Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA333D6C0;
	Thu, 19 Feb 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499009; cv=none; b=DzDE2sARRzCKVyMZBqDtwdTlQSUB6TYqVG4uS58aglHCiOur6oZ2IhnkotB/BMbpaewdzjnMKjlBpCNOJlVxYtIgVCzqXzOphq+eAxP4yj3rS5M5HNDWCY8kYe4dj/uViPMOw4YEITsvwgXoqjBopOsEYtHCz3CxKHpdpivyY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499009; c=relaxed/simple;
	bh=sC3YFmUgY7TLec065mxzBDAdvfCKpKOL1CUQXl4JrZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0PNEFqm4jSawVa/FDDE7svVzYpmvQbP6Jc296fWYiWekSgPRgjChNvKCsnqeSmzxvvmcsKcmHxt9h9fdeWh2IinHBQ87ANusgC3zyW5AmoLXrFdqS92k6GpUjSU6EQ5biZoJ7ZpD7/gKPpvOlWmtImCumdzLJ6St3lVsHuMivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M07eXCH+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M07eXCH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771499008; x=1803035008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sC3YFmUgY7TLec065mxzBDAdvfCKpKOL1CUQXl4JrZA=;
  b=M07eXCH+5nzkqqT9pqlHd4YZPa6m7E4HjSJKhGNq5gy4ow6aJs9Xn1Yo
   ywjOn5+cnkKmW2xSKu/IaMKbHhbaTpuPMkGZVoP9v/G7wKeIlDJpwXXLO
   FBhfiyMqtKKMjtX4qqmH0Y4kMo25OlQmZsX+D3DGa48bFCvhEDImxRCzi
   FTZY752ssAAfIawpzqTvPMz+SdPvZLM+5tv3O9HQfVxLrOYgs17gDAkxz
   Q1eXT7YBD+DYruotdCC9VJI1KWc2yaXP/vly12zkvOfEmKHgEWkxWJGBA
   2BCrSxOXovHPSkX3reIzw3L9vOFU6IZzb41MfIZWqBl6r8uN6UjZXtCVO
   A==;
X-CSE-ConnectionGUID: Dq01QZy2RBSNcPnrJJe7LQ==
X-CSE-MsgGUID: pQUhX+UWSUW0la07YRBhuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="84032063"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="84032063"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 03:03:28 -0800
X-CSE-ConnectionGUID: Qo5BBQZBS7SpOV2yxX6ElQ==
X-CSE-MsgGUID: az7nC80uR6+WBQ7yV8LsXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214589467"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 03:03:25 -0800
Date: Thu, 19 Feb 2026 13:03:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: tomasz.unger@yahoo.pl
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with
 fsleep()
Message-ID: <aZbt-8ZHcfXacEl9@smile.fi.intel.com>
References: <20260219105628.43534-1-tomasz.unger.ref@yahoo.pl>
 <20260219105628.43534-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219105628.43534-1-tomasz.unger@yahoo.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 19, 2026 at 11:56:28AM +0100, tomasz.unger@yahoo.pl wrote:

> fsleep() is the preferred modern API for flexible sleeping as it
> automatically selects the best sleep mechanism based on the duration.
> Replace udelay() with fsleep() to improve power efficiency.

Is this sleeping context?

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615F31354C;
	Thu, 15 Jan 2026 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466839; cv=none; b=JOwNP4Jw+wvlAr3jOUULYx5aI0U8m8vjpi9Ozp6TfFyNfIPPdyP1u1MxzXcA1PPwd5Vaf1drLPDRwzQ/smmrsyeiBxQhnkMhpCx+G7y88+2FbWjugE7GPEdwKFq0DNpePI6frNZsKczGYwf8odMZJLhY+oL2BCMW68/103No9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466839; c=relaxed/simple;
	bh=VB3s4Vtnia94BYmzH5RpaIiyd/44mzLETLVflJuTnek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ6DAoD6OoP8vH0CMsIrlLTMRKwt8y57ic79DbV4BZ7J31c3KNW9fRDpov29GQYzAYLUyQPSH8ymC0P+uXQcsCrO+Z+go9kKZbmt1Jl0avEoJ0L0c+reEWMjaGup442trhzPDa9MGMJffcQQMFPu7pD27RU/CItF4JwjHY7yXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWwB+Uce; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWwB+Uce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768466837; x=1800002837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VB3s4Vtnia94BYmzH5RpaIiyd/44mzLETLVflJuTnek=;
  b=jWwB+UceVnl73wW+L2B6M50LSfkmoExxOYL9pwkNHfGKj0G+Ug7MENSm
   CcIlkqw8+BsIY8c5Jzb5czgZJ7BEhA792fJK83kHuTGyotHlNUHuG481j
   GrlBvIFZBQW8+azHCAy/Wr6hZ3NrCtIHFfJodJF+A/g7wSPdE0epHqpSY
   HzQJQ7/n7kdkDKxa2JUHauSSkmIihJ0uEN8qdPZHQQ0v7G3+uwW566IvG
   GFLAO5FWWZwlTa/RFEkHhm79l4KyOXs7iqeXj4C83EdMHDTMQnDpH9NLD
   xRkXxREpIyCujZOgVtUv5hviDJ/C23nmm+xQcb88N8Wt6nw03dc5TlCuQ
   Q==;
X-CSE-ConnectionGUID: t+EV4yUNSxKI2z6jEBZyQg==
X-CSE-MsgGUID: 0rqcoQCCSUGKowC5nOPJ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="92439706"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="92439706"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:47:16 -0800
X-CSE-ConnectionGUID: FPdCwKzhQaKIGTXzzgfHew==
X-CSE-MsgGUID: t4H+Il3eRNCelmQ6mJETmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204111066"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:47:15 -0800
Date: Thu, 15 Jan 2026 10:47:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: WooYoung Jeon <chococookieman1@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace udelay with usleep_range
Message-ID: <aWipkPM0pwqx3red@smile.fi.intel.com>
References: <20260115084019.28574-1-chococookieman1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115084019.28574-1-chococookieman1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 05:40:19PM +0900, WooYoung Jeon wrote:
> In the fb_ra8875 driver, udelay(100) is used for delay which
> causes busy-waiting. Replacing it with usleep_range(100, 120)
> allows the CPU to sleep during the delay, improving system
> resource efficiency.
> 
> This change was suggested by checkpatch.pl.

Without HW test it's no go. See the previous attempts to "fix" the same place
over and over. (https://lore.kernel.org/ is at your service to dive into mail
archives)

-- 
With Best Regards,
Andy Shevchenko



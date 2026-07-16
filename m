Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976203438BB;
	Thu, 16 Jul 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227051; cv=none; b=To+c/CnTUNxOBzpednusyVf3bUAFRv5uoFe9MfFVLJjH7ivrvDMNmnkd8Vs9HbmtFYF1l79yu1HWmXZIql2CUdCuw+dipctSFkD/8aaHI4fZ/Ud1B6qkNIx+TCrlIA4zIs8mj+k7WAFntEeTxC077kHCibgxhX60uaHth5QP/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227051; c=relaxed/simple;
	bh=Gp+OUefwokWpgHwdunzLQJOrzjxr3nWteQh1SnYFjOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eImo6kr2gnjTFNh3fvQguCKUhosHLiHEsSDdZ5xFfwyJRIBj26/6wuCcG6ykmJSr9MUgKa1B+lzCev8OkXRslpNS06B/vx+1jzF+TYQcpY2Oazm14Ohi/9sU7z8775TjMxLxEIQFn3UA2cbunx53BWj4gC4edFyuRjYaPVr4rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj3kgWQW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj3kgWQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784227050; x=1815763050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gp+OUefwokWpgHwdunzLQJOrzjxr3nWteQh1SnYFjOs=;
  b=dj3kgWQWygd/PvtZ+dBmNxqqZdoY/c8gnEFJ0tEfdRZbHTOcsQXqalbg
   ePzCd48MRrgDzqssQk9ld/64kcBn+X6/AcKzH34xJAqJ/eH9WcYVQ+cQZ
   rmnaZeI34dEsZXEtqvxLxTOaEDg3jIbOk4Mj6CHjiWfVnxLuqK0BBdIeT
   Hw1RDCO87elg+bXV8iPgIyZDlXJJ+N/pR59qTjINew7dGljFGa0p7Smzz
   YPt0JzARqSvDUp2Y/TUxb0Nd+riT9XuOln8lcgTh2KfJu0qEmZ/Yl/+dG
   2VzSH6L4bEahVPD/VSZGA8aKLCpWx9pvmgvL8m7N/EB4m0rd7HdBaZuHw
   g==;
X-CSE-ConnectionGUID: qVl5D8iOTeyk60+gNnl9Ew==
X-CSE-MsgGUID: Si/MgIaWSpm7vKAC4P8n0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="72432328"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="72432328"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:37:29 -0700
X-CSE-ConnectionGUID: +TT9WKXMRIuIU+56AVkQqg==
X-CSE-MsgGUID: iYAGxyBWSnKSCN9dwhK/Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="294795210"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:37:28 -0700
Date: Thu, 16 Jul 2026 21:37:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mashikiselby@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Message-ID: <alkk5CVmeEY6org0@ashevche-desk.local>
References: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 01:08:33PM +0200, Selby Mashiki via B4 Relay wrote:

> udelay() busy-waits for the specified duration, consuming CPU cycles
> unnecessarily. usleep_range() is preferred for delays that can sleep,
> as it allows the scheduler to run other tasks during the wait.
> 
> Replace two instances of udelay(100) with usleep_range(100, 200) to
> use the preferred sleeping delay function.

NAK. Read mailing list archives why.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D322301
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377746; cv=none; b=qL92aELnk2hIeWV2lEGf96IuU7oz7f9FuTKS7gYLLXunNV5F7wfEcssHKho2FDNg3dJ0b/5fSE/n5nTKtTIZgGkAx0+4nUFSHssPvJhQuHbmYFC+QmanhgEbenThYlxF+zFEwbpeXylIGQq7hTiXVKWEjT01sIUnSLzF1qfw9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377746; c=relaxed/simple;
	bh=JSF5pcLjyH9f13Yhs41JjhmwOxmO1Iv8GnJTsiRbMOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnqBWUh8Y1vQLgUMoJzNsfdwE+SKNNxyTlWN2s6sJP9pZW14yqcfCllHr5pqLItVnpSu6qA9Ec4yiqSEPDtt17207JT+E/Ih2JAEqaHABGzTfFsI65KF1UN613EQT8m45mtgAZ85i+OyKMFp1uWmUnqpLF3HTDMVqI8Noo4Kp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eg/JCpE9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eg/JCpE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770377746; x=1801913746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSF5pcLjyH9f13Yhs41JjhmwOxmO1Iv8GnJTsiRbMOw=;
  b=eg/JCpE9g5t40i7nVLpkk4QSuse0EVt1cQ0d2f306LJ1uJeShh6vGTaK
   /F0cTxN5liotOmzipqzG8Q/lcvtKPgQIsgwL294004YCLuZi0k9IpXZrD
   qChoF79FKvUg8Mqe6jwLPW8Dub/JbHsOqmpchdvmkLEae0I0w07euBJaN
   iIRD9HkaP96N3q7nc5hjgkvFLhEXotOJ4vSK8YYF/2GgQfIRA3bfI9Le8
   M6CB9iWciFdYyxmLrsvFSwd0KQnf7+9J2uISGInmlfzfLj59Y0RDPTKhh
   k/9N/q/Cq8QrbUR24nHDvpbnl5/VkgRuhouSmVn3x2pUlY1LSyD2qO9Co
   A==;
X-CSE-ConnectionGUID: TZPa0dQwRH2ExRJ4zjWqrQ==
X-CSE-MsgGUID: hpS9NwPKQWeQdCTaGlbFJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="59155896"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="59155896"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 03:35:45 -0800
X-CSE-ConnectionGUID: 1nv41lDjRwSzWGKgcYIsIg==
X-CSE-MsgGUID: yUeHcC10RAq2bTLXy4WjtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="241509383"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 03:35:43 -0800
Date: Fri, 6 Feb 2026 13:35:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: ChanSoo Shin <csshin9928@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] fbtft: limit dirty rows based on damage range
Message-ID: <aYXSDNxFZ3OQvP0C@smile.fi.intel.com>
References: <20260128203938.962414-1-csshin9928@gmail.com>
 <87y0l668ki.fsf@yellow.woof>
 <aYXEHajVeKvIMmL7@smile.fi.intel.com>
 <87ms1mb0vy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms1mb0vy.fsf@yellow.woof>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 05:51:45PM +0700, Nam Cao wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > Do you have an actual HW to test? If not, won't be applied either.
> 
> Yes, a pair with SPI interface.

Cool! Would be nice to have tested contribution, indeed.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321B25DD0F;
	Fri, 28 Feb 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746245; cv=none; b=GhTnCs6b9R1BJFqNznSc+XhAm7B8PDOWraUiQ5Lhsb+wGBaUscSwBaW8PAGw1hB1U+vUhUnJpDVbGpbQZV2ZJ+rzKEXxGkegKQYcPIye6OfgL8l8iaASHuyHudyrodU8vPphSWsHVngwDK7x8HLIVfYKds761PGhALTwsGyCj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746245; c=relaxed/simple;
	bh=eZLwNpeNsIOfYw3O6oLcTPodH0VaWyF2TpLhb+J3FMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpSlx3D8UoQ2gLrCLOBsOsyg5PjLUgrT59zoKERMNBK6vU7fKGsOh8VZgYN3zxgz8ZHtm71VwodeUxMyi8fj2O/1D+oVdbR8DFQFJbQCNPFfarEhy36vk7aJE5QY92a8h0oLunEzRUV29M7dn4YxJ4In0vwOZI0z/1gckht+DBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JI1THCZx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JI1THCZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740746244; x=1772282244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZLwNpeNsIOfYw3O6oLcTPodH0VaWyF2TpLhb+J3FMA=;
  b=JI1THCZxBE73fi1TFX0n5H4+aSc5ykgvFi3FFT6AjVlUJplcWLwabk6I
   n30/7M9TCLZhr5QhyF3HuLwpg5EZjcSVNKJINt9pxxgUexpppFQGH0GmN
   1WpsR1Qj9SMlmRtd+DxfkHwue+QWbb/JEj74ybhhd2dYJz80q7SY6JCWs
   qYxViIUUZ//O0cKFeeZ6XdD0uN8/7TDXqAWqDojuaAa2/crzcI6F3Qmul
   o4EtUb0cevWApWBhHxOiu2tuWh9cmnvymYYx6tnmIZt1V7r1dwwqdzUiW
   vbS9VH1yNryVoV9TgcoPIM0k4RPJ9MaLQqbtBDu1HShVDAHzPipRGPsKx
   Q==;
X-CSE-ConnectionGUID: NcXf9ZlNSNOGrBg1Cjxlkw==
X-CSE-MsgGUID: fpVLD2UqQzu6GWss5zOz4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41557334"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41557334"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:37:09 -0800
X-CSE-ConnectionGUID: ksK4qunjRKKfPXKubkRroQ==
X-CSE-MsgGUID: MUxzNjK2QBKU+C9nSsx3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154501358"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:37:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzc1-0000000FwfN-1qkh;
	Fri, 28 Feb 2025 14:37:05 +0200
Date: Fri, 28 Feb 2025 14:37:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: pxafb: use devm_kmemdup*()
Message-ID: <Z8Gt8fg07Y-bFPGT@smile.fi.intel.com>
References: <20250228071009.150971-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228071009.150971-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 12:40:09PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup() and devm_kmemdup_array() which are
> more robust.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



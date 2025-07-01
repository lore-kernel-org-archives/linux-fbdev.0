Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CC1DFD84;
	Tue,  1 Jul 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377735; cv=none; b=KUntaaWKCDJ/VTyWxdOURdBYy0UwhFPx6vJJrR+fwfVoQNxGhsUU6x9RIye/0s5qP2Cmuhnj4BckO/KruSmhZsC7O1p6vJReKGCtzUX8Qrvbgfz7re8VHxVGUECAvY4c8vm5qh4guMX9A9hbnzAGD8zdJwqK7rY8o/SDHZJLFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377735; c=relaxed/simple;
	bh=COcxqTJmLCQuqGNIIvXZW8XzPWpwkkkrB4it1BwU/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdkmGPTqvOVm5fpZ+w1YkSP3ebbAtD0gqZUXbcOpcVUZg52RA0o5PdS4oRxFG2mAq8/KIGIaMLCZjOj89TNmQ4s+npTC8aG2updZePPWpnLw1wk5iwDRnuxWl3rWlo2dyoWOYr9zdZnhsjHRofzh+hX59Lhl/t3LBxyy4ZrKewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e98RBByA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e98RBByA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751377733; x=1782913733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COcxqTJmLCQuqGNIIvXZW8XzPWpwkkkrB4it1BwU/rw=;
  b=e98RBByAmidyKcLppr5KThRntVRU+Objwyqc8QjmOVKaQculxTHyFnCa
   va530QJvwpOsiflfL+tqNSdwMl60e5CNXduPHq6gsifUaWHUSSPlZAFOg
   wxPHQ/XMLzmMo6iNBrnz5zmIXEhxa88w1CDZ+OPhCLvOd0hy2ZBw2e/oW
   35vPVzwDjpCDn+pk+vxBA2LLTjWxxJhFQhB7QWo39ns0UpD9TJYUDu0uA
   M79Apm5w0jE5NHOniKuCJpMatj86ah+efYOUDsPU+mkM1fULa6Ple1S4f
   5xZWsDIrYBGGPnW59BcZ4qVp+rPgW3QcEYeGKmF2kGP8NpzhhwOvW144k
   g==;
X-CSE-ConnectionGUID: qzQ/28G0Sc280fahzLyLZg==
X-CSE-MsgGUID: rwOr8wkdQ0iAZJbh66/dRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53579998"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53579998"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:48:52 -0700
X-CSE-ConnectionGUID: 7znLXOmqSLKgUFROLBP8PQ==
X-CSE-MsgGUID: +ro+hUc/Ta2CfGOwTALfIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153548388"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:48:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWbLp-0000000BbxK-2psc;
	Tue, 01 Jul 2025 16:48:45 +0300
Date: Tue, 1 Jul 2025 16:48:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de,
	riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Revert "staging: fbtft: fix potential memory leak
 in fbtft_framebuffer_alloc()"
Message-ID: <aGPnPVjB6bGKMkwV@smile.fi.intel.com>
References: <cover.1751361715.git.abdun.nihaal@gmail.com>
 <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 03:10:22PM +0530, Abdun Nihaal wrote:
> This reverts commit eb2cb7dab60f ("staging: fbtft: fix potential memory
> leak in fbtft_framebuffer_alloc()").
> 
> An updated patch has been added as commit 505bffe21233 ("staging:
> fbtft: fix potential memory leak in fbtft_framebuffer_alloc()"),
> and so reverting the old patch.

Revert has its automatic line, please do not remove it.

-- 
With Best Regards,
Andy Shevchenko



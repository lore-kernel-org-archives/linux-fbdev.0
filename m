Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10C2D6E75;
	Wed, 28 Jan 2026 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638132; cv=none; b=sXgxwpfqd24iG5h4p6dGjeBX+rrDJRuMNDH6NS2dNLdZJnPMG5p4BNaGEH4K4KUi5Ki3lyw7NXo3YRqOkvCKayOUMZdSnGcvQm8Tu23RcGn6gWns2VsesfWcuquVjkF+hlmtMPZfGFRP5ZEfjxSpoCcT+zdYF9s5fFPReYhvbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638132; c=relaxed/simple;
	bh=MKkq/+o6+JFhxH/lx1U+jyyO0F2kD83mOBwrBuwtSIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvki0zsdwKFgG3txJaUWSKWX6KTKAS+ZxK3e6Bs5YUcTM9J4IWYbCquq/NPzQBZaNIVsh08H0upDzkbJj3ifYy5lM0CQSu9ZOQbyxf/gCEyZ1lEL2/v2L/J+5O3V/2suMRls8VnBcDT0F5nn/Kgn+bTYUowguXlyw8d6c+cKrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYFWkmVr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYFWkmVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769638131; x=1801174131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MKkq/+o6+JFhxH/lx1U+jyyO0F2kD83mOBwrBuwtSIE=;
  b=UYFWkmVrfeOkv3gPsbCW+Ngxd13OsYcIw7QFMfV2eyWmty93PELowrXP
   CVFaqje6B97QH8mLEMNMXVkaRz4WPF0kVt0ZL3pIEBGT7e2S20e/F1pH4
   tQPjtf9Les7UlKs0Rq54U+UIGmkBINu3GchpzmUkgwAV3RTwKDeOh/Sks
   yB6qZ996zFloTP4f+WZq/P/8zsoP5rl9X0O9+fiIZwIlEOhGXQqDVRvfL
   yLYiOgwZvFsQFUce/tFRnZrwEeQZPG7WYycYCPjPhmzaLmmyiyCovt16L
   vqnPKfekhuskfb3zv+tJUNTZiu5MR8DpDZYAhUMi0ao9mjHYp9WLMvRIF
   g==;
X-CSE-ConnectionGUID: cHWvenJvQqmzD1iyA/U/Pg==
X-CSE-MsgGUID: pUJEggOXT6OPqFH9CPeGig==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93522747"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="93522747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:08:51 -0800
X-CSE-ConnectionGUID: u2Byrd5eRZOlS+yBtkhkAw==
X-CSE-MsgGUID: PGqYRV4MTwGsKD04vBBFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212474357"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:08:49 -0800
Date: Thu, 29 Jan 2026 00:08:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paul =?iso-8859-1?Q?Retourn=E9?= <paul.retourne@orange.fr>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use guard() to simplify code
Message-ID: <aXqI7qbxZEulU_GO@smile.fi.intel.com>
References: <20260128212644.1170970-1-paul.retourne@orange.fr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128212644.1170970-1-paul.retourne@orange.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 10:26:42PM +0100, Paul Retourné wrote:
> Use guard() to simplify mutex locking. No functional change.

...

>  #include <linux/init.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
> +#include <linux/cleanup.h>

Try to squeeze the new inclusion into the longest ordered chain with some
pieces left unordered. With the given context the lease is to put it before
delay.h, but maybe there is a better place.

...

>  	if (par->gamma.curves[0] == 0) {
> -		mutex_lock(&par->gamma.lock);
> +		guard(mutex)(&par->gamma.lock);
>  		if (par->info->var.yres == 64)
>  			par->gamma.curves[0] = 0xCF;
>  		else
>  			par->gamma.curves[0] = 0x8F;
> -		mutex_unlock(&par->gamma.lock);
>  	}

This has close to 0 added value. Don't do conversion just for fun.

...

> --- a/drivers/staging/fbtft/fb_ssd1306.c
> +++ b/drivers/staging/fbtft/fb_ssd1306.c

Ditto.

...

Sorry, but I don't see much value in this change.

-- 
With Best Regards,
Andy Shevchenko



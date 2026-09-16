Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593F4E80B9;
	Wed, 16 Sep 2026 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556636; cv=none; b=CVK/j20ItgO+OMFxQvQ0SBrN+5aRKpMCx49N3QOYokcJ2fgK1gWJs30pzoNH4vDixFvCVlclaN+FyD37T3wg7ZX4L40SKnfMR1r4La/a6UOVs33/aI0ar26nzbZVVS+u0iS8pRa4wCaAyGOvxXraDK/O0YyeW5Znf61yFsKpK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556636; c=relaxed/simple;
	bh=IWnV54RNLS5F9xKNa2KWOePuLIifnOT2PSpdpWwTw/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFGfatEuqjvsru3bZp7JsbVDdtMfNUIaDDTfr/zCv0i2jO4PCtoFDwMzpVhU/Xr0Qx/zn+QxIpSqFNqloHXc1hUsYd4lHlbu70538T++mfxbmBH+5j0IULgTJHuhDFVe0Vj/ckdr0ZEWmnJLbHc8OoD9PPIAaNbd/hyoIZpS9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyJ2mEb6; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyJ2mEb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789556627; x=1821092627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IWnV54RNLS5F9xKNa2KWOePuLIifnOT2PSpdpWwTw/M=;
  b=YyJ2mEb6K47iqNpE1kTMjmXu+4fzrfDHKU8X9DDKt3PAbnQsUfe19jia
   bbNCGibAeItZevTqxylTcLxQhDeXDyaSQuLMVg72moBkCC9YcvHGADnjV
   5nlT69z9NjLXLa+20HMquEVlNDP5lKB0gzWvVnWpmYbfYOYCzuuCfyn2t
   ERVKzlx1iFZaNlJPLZFlN0jiSh1zcsdU+1iSHD19MXoomc75yc4oADJN3
   J+S8ZrqfC6c3kuRtcC39In1cL/KsVWfEIR6VRj3CI7lX4wueggmVw3Mpi
   KRGj6N1wT7nNG8YCyfKC3TUuth9vAH8hI+Z4xG3tWpjspsAaVkTh8duyb
   w==;
X-CSE-ConnectionGUID: RolIMVEpSJ6BbrZJ0IpVFw==
X-CSE-MsgGUID: zMZ6eto1Ro2VDb/+9JuKvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="438858"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="438858"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:03:43 -0700
X-CSE-ConnectionGUID: sp8bFXe2Qju9twLMm3wY3g==
X-CSE-MsgGUID: OMGnJVYkR/ijCWfmFIVi5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1531519"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:03:41 -0700
Date: Wed, 16 Sep 2026 14:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Omer PALA <palaomer100@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aqp3ihtGN5-J9TPa@ashevche-desk.local>
References: <20260916093928.52057-1-palaomer100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093928.52057-1-palaomer100@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 12:39:28PM +0300, Omer PALA wrote:
> Replace udelay() calls with usleep_range()
> to avoid busy-waiting and allow the
> scheduler to sleep during delays.

First of all, too condensed commit message. We have as twice room on each line.
Second, do you understand the difference on what code is doing before and after
your change?

...

Please, instead of posting patches, read first, check email archives, understand
the code...

-- 
With Best Regards,
Andy Shevchenko



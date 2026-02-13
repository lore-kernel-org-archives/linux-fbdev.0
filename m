Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7832A3C8;
	Fri, 13 Feb 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977938; cv=none; b=hTbK35WgC1RXDfmB+zQz4/mBJhQ2iwzMq2khh3XmQSzytiLWiQbhGRx4gsmvi40cuML2nKJtBVEJ1P55RNScFPDLLqxYnEWb6BAmpSBJp9tA7a4rXuXtcod+UlGjPrhbSMEmyO8w1a0SJJwAL0DRL6+8am8lwZQ2lFUwLuiCyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977938; c=relaxed/simple;
	bh=P86JB5Zni+PGoOpigJg3FxB+a9oavX/tU1hPKbIxZ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ8bFIisbrTtY+a4vUUSjTDfmKMf7/43XpZZbOLqqfhdczWwPpiQQqsnJAp3pqqM2fZS9WKnyBQYn2zxjohdZ/2iVRRv56a/vclWx0YqmNd8bVhNrXQ+uSfRfZ2RbRnCix2RlBQdHimTS98OWOTcwI07yd9zgDgJdUDM3modzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJ1xsFGn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ1xsFGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770977937; x=1802513937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P86JB5Zni+PGoOpigJg3FxB+a9oavX/tU1hPKbIxZ7s=;
  b=DJ1xsFGnDUUVEHZt52NmuKakGVGYhjsvKM3BHJChUVvK9jm3FCSmtarj
   xFQyuS7c5Zs9nhaHy0iS4pENQRSB+pZfbNb2d57PEPEzFXshGni2peRCQ
   MQhl47xckQA+19mF3d/5PvGeTKHrFTxSwy8vaAHDe2GDxbonykoIWljzh
   cMHFDF6MKY0EtAQEPsx/KDY1mR15ae60ONkBu9EIqcGQqjemjG4qwpXti
   qmW2VKMAgYr16vZriYvP2pc5SkRrSrjra0PLWexc1E0WeMnKJLoy2NU79
   tLHBWg9bb1FeQzu5otxiuoyWvk2AQjKlcEo+ph++AfMUzCLWYw49sbkTK
   A==;
X-CSE-ConnectionGUID: 071pOl+DS6mLcHRn9p/XKg==
X-CSE-MsgGUID: HODwgpkrSBSavngwgxlujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83602623"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83602623"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 02:18:56 -0800
X-CSE-ConnectionGUID: sziJRZv4TMexr9OOgS/BIQ==
X-CSE-MsgGUID: /1hz4F7mTS+aWEoraqOdCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217026888"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 02:18:54 -0800
Date: Fri, 13 Feb 2026 12:18:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Optimize partial write()
Message-ID: <aY76ixvOUEkvoPk0@smile.fi.intel.com>
References: <20260213085946.3673695-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213085946.3673695-1-namcao@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 09:59:46AM +0100, Nam Cao wrote:
> When user write() only to part of the screen, the driver still updates the
> entire screen. That wastes CPU cycles.
> 
> Optimize by updating only the changed lines. Improvement is measured by a
> pair of trace_printk() at the beginning of fb_write() and at the end of
> fbtft_deferred_io().

Can you elaborate on the HW (the exact model of the panel and [sub]driver)
in use?

> Update type         Before     After
> ====================================
> full screen         196ms      200ms
> half screen         200ms      124ms
> quarter screen      193ms       81ms
> one pixle           199ms       43ms
> 
> It is interesting to note that if the deferred IO's delay time (40ms) is
> subtracted, then the time amount scales linearly with the write size.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Some questions below, but they probably won't affect the decision on this change.

...

> -	/* special case, needed ? */

Do you know the history of this comment? What is "special case" and when does it appear?

> -	if (y == -1) {
> -		y = 0;
> -		height = info->var.yres;
> -	}

...

>  static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>  {
>  	struct fbtft_par *par = info->par;
> +	u32 start, end;
> +
> +	start = off / info->fix.line_length;
> +	end = (off + len - 1) / info->fix.line_length;
>  
> -	/* TODO: only mark changed area update all for now */

Ah, this change actually targets the TODO!

> -	par->fbtftops.mkdirty(info, -1, 0);
> +	par->fbtftops.mkdirty(info, start, end - start + 1);
>  }

...

In light of the last TODO line I think that the change is desired by
the original author. Nevertheless I am wondering about these side effects
that might be (very unlikely?) considered if this code (partial refresh)
runs for a significant period of time:

- some bits of the screen (on non-updated part) might be flipped
- the static picture may lead to wearing of (decolourisation) the panel
- what is the thermal distribution (probably with backlight off)?

Maybe it makes sense to refresh a full screen from time to time, but
TBH my knowledge of TFT panels from last decade is quite limited. I only
think from the point of the general physics and common sense. That's
why this long footnote rather philosophical, but I would be glad to
learn the state of affairs of the modern TFT panels in terms of the
physical parameters lasting over the time under different application
cases.

-- 
With Best Regards,
Andy Shevchenko



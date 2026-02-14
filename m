Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF62BF006;
	Sat, 14 Feb 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092387; cv=none; b=LxucqRrc3xTG9Lio7IMD3e+h3lbJG0PvnV6Yc3EpZFXR7+Szq2DS9vPr+t6TewKGXSrOxBDM6qmRDJ0PAbM0xEqOQV4rs1L1pqAKbRtoMfhV5ikYlvt7Kw+iapjL5ivRe+7c0j8iNbU3fNXfqpGX6JtVoKLTd6jYIIpRWRihgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092387; c=relaxed/simple;
	bh=usd0K5keZeMOWvHWVSE7Ssn7zoDRX0rgTmbce/m4OqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBtUZHkpWFxU29r5s5hDvJS5KCmy6vIsI4gRTtLp02x0Tk6NdeX42v8xazYw4xuEz1NhYZdFOMDj5B54SLNhocFU0kv88Rp/OJfr4z6WtWdBu5zEG/dueQ+S2dZjibXeHLy1ZNI6BhnFrkk33TC+zPHSReyXqhh4Tbsjrxda/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9FiflZ4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9FiflZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771092386; x=1802628386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usd0K5keZeMOWvHWVSE7Ssn7zoDRX0rgTmbce/m4OqE=;
  b=m9FiflZ40HWL+MJu+1QLp8Fn9rK3sygvg1+u71im31j26EVDR81Xfg2v
   yV1s6V2B25w/5Ns4JME2Mkj5NLmY4ul8gVAWTUcKe8TyOEd7j0eP8GkUX
   Zp0G6U6ouuP2AVXwGJ2j7mdTkW28BMum0hSHD1zhEeNkl8agWMRdobBEo
   6RunIAnVcvfllgjTs4LkjK4OO7KPF8sAJzes+ddRLDg23qIF2ySnTAtXC
   gQUlM5TNJ7DZLUBccKH8iAjO/sTdMPZlEW9qyyRJrbJNUTD2KQuokpYm5
   NDMkkRRyD2lPUgjB3dJURReJVKRIfXao/Z4mGfMgOs6wwdB2fDKfntQLX
   Q==;
X-CSE-ConnectionGUID: bSNq+KyyTpSKTW+jh1Cnxg==
X-CSE-MsgGUID: sR4O3nx3TBqQdlwLBI5Efg==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="76099222"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="76099222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:06:25 -0800
X-CSE-ConnectionGUID: lGHamWo2SraaL/pLbWnHMg==
X-CSE-MsgGUID: EV5JJ2RpT9u2Dg9+1slFvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="212288613"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:06:24 -0800
Date: Sat, 14 Feb 2026 20:06:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Optimize partial write()
Message-ID: <aZC5nTK5wE7l8YAv@smile.fi.intel.com>
References: <20260213085946.3673695-1-namcao@linutronix.de>
 <aY76ixvOUEkvoPk0@smile.fi.intel.com>
 <87bjhsqe9y.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjhsqe9y.fsf@yellow.woof>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 08:56:09AM +0700, Nam Cao wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > On Fri, Feb 13, 2026 at 09:59:46AM +0100, Nam Cao wrote:
> >> When user write() only to part of the screen, the driver still updates the
> >> entire screen. That wastes CPU cycles.
> >> 
> >> Optimize by updating only the changed lines. Improvement is measured by a
> >> pair of trace_printk() at the beginning of fb_write() and at the end of
> >> fbtft_deferred_io().
> >
> > Can you elaborate on the HW (the exact model of the panel and [sub]driver)
> > in use?
> 
> My hardware is the Adafruit's ILI9340. Driver is fbtft/fb_ili9340.c.

Please, add that into commit message.
It will leave the trace that this change has been tested and how.

...

> >> -	/* special case, needed ? */
> >
> > Do you know the history of this comment? What is "special case" and when does it appear?
> 
> This allows caller to pass -1 to "make dirty" the entire screen. The
> only caller that uses this special case is removed in this patch.

Perhaps a small note (summary of the above) to the commit message as well?

...

> > In light of the last TODO line I think that the change is desired by
> > the original author. Nevertheless I am wondering about these side effects
> > that might be (very unlikely?) considered if this code (partial refresh)
> > runs for a significant period of time:
> >
> > - some bits of the screen (on non-updated part) might be flipped
> > - the static picture may lead to wearing of (decolourisation) the panel
> > - what is the thermal distribution (probably with backlight off)?
> >
> > Maybe it makes sense to refresh a full screen from time to time, but
> > TBH my knowledge of TFT panels from last decade is quite limited. I only
> > think from the point of the general physics and common sense. That's
> > why this long footnote rather philosophical, but I would be glad to
> > learn the state of affairs of the modern TFT panels in terms of the
> > physical parameters lasting over the time under different application
> > cases.
> 
> I can't tell you much about TFT panels, sorry. My company used to do a
> demo board with one of them, that's how I have some hardware to play with.
> 
> If user uses mmap() instead of write(), then full refresh is never done
> (well, unless user writes to the entire screen). So if lack of refresh
> is a problem, someone should have noticed already.

Right, that's why I asked more for my own learning.

-- 
With Best Regards,
Andy Shevchenko



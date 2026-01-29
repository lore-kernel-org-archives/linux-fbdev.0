Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACF385522
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Jan 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684381; cv=none; b=sR5+oIA4gH4TTHA3fbiyKVGW3VgeU+GqxdzSg62c0e4DrRkAqn5DB9lfGS0yr8FeBqDKXyPQ37MBmuFVOCZ5KsDFalxyd6UOVhTVt8/WQcT4AXDN3OMhwPnz5cTPqxg+9kYLTUZkNBTisd06LzhtJJApPypjDmuj2kNPnu84ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684381; c=relaxed/simple;
	bh=bQ0Q5APcgcKlSb7nEhSdvCM1gNhb+QfFD7Vv8Ooz8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZyyVdws1KGV8TgTyJ+R99oVpdMPD/mjJXlsd2ixVvXhty5HuKwjoGjvr7VN8II8CLS8+YRvcoHyVI5ash/3AluUIAz2xMOK4ETfoRQAUQnXXkNyLEp+GGju7xb391u+XJ0xlR/BcsNxTio9pwNtodn11OTs2RJbmupY2ZK63x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPURgkUL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPURgkUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769684379; x=1801220379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bQ0Q5APcgcKlSb7nEhSdvCM1gNhb+QfFD7Vv8Ooz8/A=;
  b=QPURgkULgfTPGs52MsNbGLPYGebNeVwYwTgclGbT9TaFj+LoXa1ZEORI
   sEyHIY8nAu0GzB4N0mMiRNtWqXVOXqEV+4KlIfcy5N9Z2x2J9OY2gJh0O
   b6mYGiQWK7YOpk0cXtQl6iaCOGOyO8DGAskcM7LGcropliLZMol5pgnZl
   MX4SY7Ix8yoWNT2uJrfjmlWJAs6zrEdKRt+E3c9N57yO9A0lWflflIZe1
   J0P6ftq1xbNb0EYtK0osm/SU4FL6zTk1+NbAuIAh0VWwwM/DYtJgeznnr
   d0EjGy1GyjRousbsuzHhg4FTe0sBColl48mR/IPU2k6wb5AQK7PNYUWVI
   A==;
X-CSE-ConnectionGUID: 1CSB0sgqRPWGIRIdchC14g==
X-CSE-MsgGUID: k1EmQVVUQpqfGcI1LEbJWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82287320"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="82287320"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:59:39 -0800
X-CSE-ConnectionGUID: yOlryslmRdOS3t3cmOkNeQ==
X-CSE-MsgGUID: Y3U8pILCSuiGKYjyhzcQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213420756"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:59:37 -0800
Date: Thu, 29 Jan 2026 12:59:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ChanSoo Shin <csshin9928@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] fbtft: limit dirty rows based on damage range
Message-ID: <aXs9lvhF9MIQASv0@smile.fi.intel.com>
References: <20260128203938.962414-1-csshin9928@gmail.com>
 <aXr-RhUXwIvMHYZI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXr-RhUXwIvMHYZI@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 09:29:26AM +0300, Dan Carpenter wrote:
> On Thu, Jan 29, 2026 at 05:39:38AM +0900, ChanSoo Shin wrote:
> > Instead of marking the entire display as dirty, calculate the start
> > and end rows based on the damage offset and length and only mark the
> > affected rows dirty. This reduces unnecessary full framebuffer updates
> > for partial writes.
> > 
> > Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>
> > ---
> 
> TL/DR:  I suck as a reviewer so I would be nervous to apply this
> without testing.  Andy is an expert here and we trust him so if he's
> okay with it then great.  Or if some other expert could sign off, but
> I don't know enough to sign off myself.

The rule of thumb for _this_ driver (or set of drivers under FBTFT) is
that: we are in maintenance mode and we only accept bugfixes or treewide
changes. The rest can be accepted but unlikely. Either way, we really
want to see this (kind of changes) being tested on real HW. It's not as
simple as renaming variable 'i' to 'j'.

> The problem for me is how do I review something like this?  Staging
> is a grab bag of different modules and I'm not an expert in any of
> the subsystems.  Normally, it's easy to review staging patches
> because they are clean up work which does change how the code works
> so I just look for unintentional side effects.
> 
> It's trickier to review a patch like this which changes runtime.  If
> it were fixing a bug, then I could verify the bug is real and say
> well, "Maybe the fix is wrong, but we were going to corrupt memory
> anyway, so the worst case is that it is as bad as before.  It can't
> make the problem worse."
> 
> This is your first kernel patch.  You don't work for a company that
> makes the hardware.  You said earlier in a private email that this
> hasn't been tested.

Unfortunately it is not the best driver to go with this. At some point I might
be able to test this when I setup my fbtft minilab at home, I have a few I²C,
SPI, and parallel panels.

> The patch looks reasonable to me, but it also looks simple.  If it
> were that easy why didn't the original author do it?

-- 
With Best Regards,
Andy Shevchenko



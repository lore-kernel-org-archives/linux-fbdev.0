Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF0281349
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Feb 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457747; cv=none; b=MUOvfcg1FYLWyaIqB9ubxI9rurc4wjduOsWlveUONSoqihs224Ea70XMlARITdxnuTcr3VXQUDJm3OFIifKjIiPNvt8JkzpCxO66Hr398zxGOs5l9i+P07x6iNE2v8OgCvMQpCCKaZs39VGvd4GIDMtRG/fdP3SROdoCvcg4dXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457747; c=relaxed/simple;
	bh=er1o0eyyYo2P9RGTb3I/Gv5RkqmtO3GI17fKDgB+d10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLh8CaH0r70DqTMSgnBEH/3WMMp3cus8Z+IKEH0EjuLzqubO5WZJjNJG+YMohAYWtUIlGxAEb/hlRCoOlY883cAwuj394WbSz2MOYWali674aODw9bWKQaKhI4RxrdGMIEaQEWEepzDgYi4Xen4NYBpR4PvEb6GO1Hb0Yb/U8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEihJ8Vx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEihJ8Vx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739457746; x=1770993746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=er1o0eyyYo2P9RGTb3I/Gv5RkqmtO3GI17fKDgB+d10=;
  b=oEihJ8VxKIc+lWgXl9N2NezNCRuvQEI/n8fxFlGyY6PV0bDcFatruaDu
   +UGJKElA4j8Tvvy0FwDhnJltdAD8vGCiGkxt+D/U07k4PHCicq6LqsbbY
   VNynIv3D7abip38az+137qAVMekUpk7K601sKAd1/TLniMSzHLGoM1/A5
   KETjDG46OYdAj+um74RcRITxr2h0t5DjVZVHZgUL2xvr2fo5cwsHXIBhH
   N+VxroECSnZ7pYO+zLtCuJIN1wA/oS4Wybqxlj9eAV/6nzEXx+6zUz30K
   SroekOmX35O65cjzTv45vJvemPiT55VFOo2jWo10SJxo0hmxkyHUzKGwd
   w==;
X-CSE-ConnectionGUID: B/mPj8/6S4ebKxJbDQCVig==
X-CSE-MsgGUID: 9Xg0ds0aSsiB9QONvg8V/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40423240"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40423240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:42:25 -0800
X-CSE-ConnectionGUID: BujpYyyvTcC3zLfRCGS0kw==
X-CSE-MsgGUID: 3AO13tUqT5WfVIzwdNn1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113346818"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 13 Feb 2025 06:42:23 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 13 Feb 2025 16:42:22 +0200
Date: Thu, 13 Feb 2025 16:42:22 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/6] fbcon: Make cursor_blink=0 work when configured
 before fb devices appear
Message-ID: <Z64EzooZqdfLg0pM@intel.com>
References: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
 <20240923155749.30846-2-ville.syrjala@linux.intel.com>
 <92ed9455-b175-46ef-b0c6-7c79e2b78371@gmx.de>
 <ZvUwCVNPzp1UGY6h@intel.com>
 <34a7d276-ee26-4a8d-b996-87faa5b224c4@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a7d276-ee26-4a8d-b996-87faa5b224c4@gmx.de>
X-Patchwork-Hint: comment

On Thu, Sep 26, 2024 at 12:13:04PM +0200, Helge Deller wrote:
> On 9/26/24 11:57, Ville Syrjälä wrote:
> > On Thu, Sep 26, 2024 at 08:08:07AM +0200, Helge Deller wrote:
> >> Hi Ville,
> >>
> >> On 9/23/24 17:57, Ville Syrjala wrote:
> >>> Currently setting cursor_blink attribute to 0 before any fb
> >>> devices are around does absolutely nothing. When fb devices appear
> >>> and fbcon becomes active the cursor starts blinking. Fix the problem
> >>> by recoding the desired state of the attribute even if no fb devices
> >>> are present at the time.
> >>>
> >>> Also adjust the show() method such that it shows the current
> >>> state of the attribute even when no fb devices are in use.
> >>>
> >>> Note that store_cursor_blink() is still a bit dodgy:
> >>> - seems to be missing some of the other checks that we do
> >>>     elsewhere when deciding whether the cursor should be
> >>>     blinking or not
> >>> - when set to 0 when the cursor is currently invisible due
> >>>     to blinking, the cursor will remains invisible. We should
> >>>     either explicitly make it visible here, or wait until the
> >>>     full blink cycle has finished.
> >>
> >> are you planning to send follow-up patches to address those shortcomings?
> >
> > Nope. I don't really care about those as I never plan to
> > turn the cursor blinking back on after turning it off via
> > udev.
> 
> Sad, but OK. I will look into this when I find time.
> I'd hoped to push those patches upstream during this merge window,
> but then I think I have to delay them at least until kernel 6.13.

What happened to these? Not seeing them anywhere...

-- 
Ville Syrjälä
Intel

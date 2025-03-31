Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DD215777;
	Mon, 31 Mar 2025 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450922; cv=none; b=qEO9QYqo5ORAQdZh0CSmEFg/2O7rg/Cr9LocZ+NA4VatHPULNwcqSCFxmj0xP11im73b0XCTZFiBHd4QQ0tKBylqOX5kKbfCFi6kP+qpxLxlfolURuxkO9uPxeWXIxVAFTxZ7y+UIpX+6hK0Y8LqnfJWfPxQCUWghjgrfTvG5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450922; c=relaxed/simple;
	bh=c7NzQUgJyQ6dXCaMlYVpOtWEnGAmsfB/UgZKrFbmZjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQzuyN07jYVHIdIi4n8J+cTsJnGQSnyQ2/31d2UThG2byLbGrNm37Ol7mnl1J5ZVV9nVRYG1ly9GVAv9Gqyz7C749HFSXqs5F9vhQip0DM3kjwfTz6mxbzYi3jiEJyY/MiyPRvgiyzdje9R39mDNoYrNzLHNBm3wyR8PMGXMH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ib0+ztnS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ib0+ztnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743450920; x=1774986920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c7NzQUgJyQ6dXCaMlYVpOtWEnGAmsfB/UgZKrFbmZjA=;
  b=Ib0+ztnS4SoahTnCw+qO4vWH9ZqKK1aWK7Uhvt9iHl7vmC/0kJ2q+DfU
   TBUC5hkxzacDTE8rzHKO34d9t4CazsXV0079Go+S9bL8qSpvbXWZUZEBx
   ePmUUL8wOCh1/3u5u2uGHdCTABGWHrACoA6YYnIBwfQSIZgF0Cao0gZXR
   dmrb0ebxH5B9mExfu5hh/FSRgCfrM12EliX1vJ4WfJEP5bO9FNXPXi/fF
   sprZhhrPVeInEL+RODSsL06vaq5ruQcrsTEg6G5Py4OuIYdcgVr7f8xWE
   fxzb1JPJ4NEC3hoEGeu5RVnxt58E4eXq68QON47ngogoXnj467c92QfYe
   g==;
X-CSE-ConnectionGUID: HXkT0Ir2Srm0xVYkvtiUBg==
X-CSE-MsgGUID: NaqEa/hDTV2ylLx07crV0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="55411194"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="55411194"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 12:55:18 -0700
X-CSE-ConnectionGUID: pkWiiMerQnuqaQO/d85r/w==
X-CSE-MsgGUID: ccVwXtgEQT2n4V/ycGhXXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="131397506"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 31 Mar 2025 12:55:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Mar 2025 22:55:13 +0300
Date: Mon, 31 Mar 2025 22:55:13 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Denis Arefev <arefev@swemel.ru>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
Message-ID: <Z-rzIfUMmOq1UZY1@intel.com>
References: <20250327100126.12585-1-arefev@swemel.ru>
 <20250327100126.12585-2-arefev@swemel.ru>
 <87pli26arh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pli26arh.fsf@intel.com>
X-Patchwork-Hint: comment

On Thu, Mar 27, 2025 at 12:14:26PM +0200, Jani Nikula wrote:
> On Thu, 27 Mar 2025, Denis Arefev <arefev@swemel.ru> wrote:
> > The value LCD_MISC_CNTL is used in the 'aty_st_lcd()' function to
> > calculate an index for accessing an array element of size 9.
> > This may cause a buffer overflow.
> 
> The fix is to fix it, not silently brush it under the carpet.

There's actually nothing to fix. The backlight code is only
used on Rage Mobility which has real indexed LCD registers.

Older chips do supposedly have backlight control as well,
but implemented differently. I was mildly curious about
this stuff, so I I poked at my Rage LT Pro a bit to see
if I could get backlight control working on it, but the
only things I was able to achieve were either backlight
completely off, or blinking horribly. So looks like at least
on this machine (Dell Insipiron 7000) the backlight is
implemented in a way that can't be controller via the
normal registers. The machine does have brightness keys that
do work (though the difference between the min and max is
barely noticeable) but they don't result in any changes in
the relevant registers.

> 
> BR,
> Jani.
> 
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > ---
> >  drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> > index 210fd3ac18a4..93eb5eb6042b 100644
> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > @@ -149,6 +149,8 @@ static const u32 lt_lcd_regs[] = {
> >  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
> >  {
> >  	if (M64_HAS(LT_LCD_REGS)) {
> > +		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
> > +			return;
> >  		aty_st_le32(lt_lcd_regs[index], val, par);
> >  	} else {
> >  		unsigned long temp;
> > @@ -164,6 +166,8 @@ void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
> >  u32 aty_ld_lcd(int index, const struct atyfb_par *par)
> >  {
> >  	if (M64_HAS(LT_LCD_REGS)) {
> > +		if ((u32)index >= ARRAY_SIZE(lt_lcd_regs))
> > +			return 0;
> >  		return aty_ld_le32(lt_lcd_regs[index], par);
> >  	} else {
> >  		unsigned long temp;
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel

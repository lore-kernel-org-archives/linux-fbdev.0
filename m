Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D1245030
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Feb 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554896; cv=none; b=m0MRHFL6OjAszR/emd2tzadhQTmc+eZch0xnoOTzQK7T2wKAO4hYEW9DdAvzgwA9AXOCWhwREuIsfYJEdpBMC6thvR78fsAcobYrgWe4KtxAlwVodGV0KE6Nd93ypcPWVqoIpqPfZOGfx1OlaIe57DCPbjq5CyWG2/c6ES++lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554896; c=relaxed/simple;
	bh=FLlT1lmIZZAzOsgsCw15DJ9e4diOdJyzbKQsrWxvO5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByQ+zXjv067OoDfNNv952zGWX6mgvcHxkoL1mBXabMkNvjpm+rq5GsBpt0IKogQaiRrFx6JpcEATcoebsPwSF7+vHxgCQmXaW8iCJ1XslbirVOjOMP8gY0M55TmVBSvBT1SMQYpmn4MpJqVqtarnMPufdI0pplE3aNVfVI6fD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ls+2pmTc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls+2pmTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739554895; x=1771090895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FLlT1lmIZZAzOsgsCw15DJ9e4diOdJyzbKQsrWxvO5o=;
  b=Ls+2pmTc0RG4qbM6LYuys+QoL4j+RTDluzWYd3Wdb/P2A/IDF6nk6C9D
   ev9JPw9CI/h06QuWkUVm6GlEzwlnnSS//tvwPPE1HIfNOi/9bM45Sbbx4
   8C1lF55jf7JQDo1ZHhb+fc5HhfDispR7WU457EClL+/tD/igLKTcJGYQp
   kU6At/YZwGin3Lg3oqN765UKWn19J6AkZ/vLdsSlVWgx3ml6lg7zKIiOS
   f573Bs4s8oiuw5K2niCqAPq2Qm31iGH6tt5UshlfOvkpbelktrTrLnxLb
   aTrg64sSpJPeC/Fvffl3HP8gRkEiI5RpTe2xJ6JTxLSMBqngK6dRfKlhE
   A==;
X-CSE-ConnectionGUID: Zh7/VuNjTMqMAFiUHNP3Mg==
X-CSE-MsgGUID: ET9FoDynSayqOJKumIdf1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="44077375"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="44077375"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:41:34 -0800
X-CSE-ConnectionGUID: ZJ+8fGyZRTKD+reQCLHTqA==
X-CSE-MsgGUID: n5OIn65zTqyYbBUfXUqvQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113713816"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 14 Feb 2025 09:41:31 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 14 Feb 2025 19:41:30 +0200
Date: Fri, 14 Feb 2025 19:41:30 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/6] fbcon: Make cursor_blink=0 work when configured
 before fb devices appear
Message-ID: <Z6-ASitAVCBD4QP-@intel.com>
References: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
 <20240923155749.30846-2-ville.syrjala@linux.intel.com>
 <92ed9455-b175-46ef-b0c6-7c79e2b78371@gmx.de>
 <ZvUwCVNPzp1UGY6h@intel.com>
 <34a7d276-ee26-4a8d-b996-87faa5b224c4@gmx.de>
 <Z64EzooZqdfLg0pM@intel.com>
 <f075b0f7-3d01-4eb7-b772-825de7a1e001@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f075b0f7-3d01-4eb7-b772-825de7a1e001@gmx.de>
X-Patchwork-Hint: comment

On Thu, Feb 13, 2025 at 11:47:42PM +0100, Helge Deller wrote:
> On 2/13/25 15:42, Ville Syrjälä wrote:
> > On Thu, Sep 26, 2024 at 12:13:04PM +0200, Helge Deller wrote:
> >> On 9/26/24 11:57, Ville Syrjälä wrote:
> >>> On Thu, Sep 26, 2024 at 08:08:07AM +0200, Helge Deller wrote:
> >>>> Hi Ville,
> >>>>
> >>>> On 9/23/24 17:57, Ville Syrjala wrote:
> >>>>> Currently setting cursor_blink attribute to 0 before any fb
> >>>>> devices are around does absolutely nothing. When fb devices appear
> >>>>> and fbcon becomes active the cursor starts blinking. Fix the problem
> >>>>> by recoding the desired state of the attribute even if no fb devices
> >>>>> are present at the time.
> >>>>>
> >>>>> Also adjust the show() method such that it shows the current
> >>>>> state of the attribute even when no fb devices are in use.
> >>>>>
> >>>>> Note that store_cursor_blink() is still a bit dodgy:
> >>>>> - seems to be missing some of the other checks that we do
> >>>>>      elsewhere when deciding whether the cursor should be
> >>>>>      blinking or not
> >>>>> - when set to 0 when the cursor is currently invisible due
> >>>>>      to blinking, the cursor will remains invisible. We should
> >>>>>      either explicitly make it visible here, or wait until the
> >>>>>      full blink cycle has finished.
> >>>>
> >>>> are you planning to send follow-up patches to address those shortcomings?
> >>>
> >>> Nope. I don't really care about those as I never plan to
> >>> turn the cursor blinking back on after turning it off via
> >>> udev.
> >>
> >> Sad, but OK. I will look into this when I find time.
> >> I'd hoped to push those patches upstream during this merge window,
> >> but then I think I have to delay them at least until kernel 6.13.
> >
> > What happened to these? Not seeing them anywhere...
> 
> The issues above are not fixed yet, so they are still parked in my for-next-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log/?h=for-next-next

Those issues are already present in the current code, so
I'm sure what's the point of holding this up due to them.

-- 
Ville Syrjälä
Intel

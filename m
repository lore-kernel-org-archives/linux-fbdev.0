Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482143A383B
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Mar 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905917; cv=none; b=J2JywM8ZwzLXm4pycQvXWcKK7fevnteEeRet5zsasvk3xoMpOTrgibGmDFdCb/fZ8q1TSGbWgdI3V3P+8Tttd6gVHEm59aAitCvruPdriOexABW2/2Z9dyHh7ca8ts3ApZNLFssUgU0iPT2HBlEDba/5ilc1FmanhQGX73/9Qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905917; c=relaxed/simple;
	bh=dPpdN8u+SML07SnvGR2+AIbmK6kEI0YZuMKYIxaP3i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrFyx14+1K3chG5wJEVREGj0IpQrdANqsOTKrrg2TcC61tovnU+EAt8a3hkU0c7VpLwGWtOlKpVsT5ulg2xpbIFFHuvf8MPD6+IV/gsHZYEOX/Ov4530v6FiAsCdakPBhcuuRTnmDYBAcml/k4xIZiyIE/xtHJavRpxC+fRPgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxWHrl9c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxWHrl9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773905915; x=1805441915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dPpdN8u+SML07SnvGR2+AIbmK6kEI0YZuMKYIxaP3i4=;
  b=WxWHrl9cafswNSR7B423a01TC4GAclymKtdOyRcqHYLyc74M0l/T9JTc
   57zZvMq4tMDoF2wENJUS2bkcaM4leyrs/96f3LYMYdUz0p28JW0v+RiJZ
   7k4vqb4hQuf6yJc0cVNCCReTkTk3AhyllJR2AHPIXumm/UfSRkS62eySg
   IgCzz7ZHlwJnCtaAKPwu02OB19YyVTWPfm9ssAT/g9sInApDluJQ/s6GK
   ejcBMYD+SijpTdEvZogfTOrGRBmRkxYrJrD5dRM+Vgx2eRvZ2Ds4VTIzy
   8pnYTPGWsRz7+SRPwlam2TfQyL+XUU4niXp4e3tyel0dDFA7j6kHBkJbV
   A==;
X-CSE-ConnectionGUID: t+Fbh7EYSJ+onI3uL7J0bQ==
X-CSE-MsgGUID: kUWvaKPjQpqAC/zBjNoHSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74668596"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74668596"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:38:34 -0700
X-CSE-ConnectionGUID: DzveBHIDRf277YVAG8uwrw==
X-CSE-MsgGUID: pDGffJpHTOCIIcN85P2ANg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:38:31 -0700
Date: Thu, 19 Mar 2026 09:38:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <abun9dwCYAWd1nIB@ashevche-desk.local>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
 <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
> 在 2026/3/18 15:45, Andy Shevchenko 写道:
> > On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
> > > On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
> > > > Fix the following gcc warning:
> > > > 
> > > > drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
> > > > ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
> > > >    unsigned int pixel_vco;
> > > >                 ^~~~~~~~~
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > 
> > > Thanks, committed and pushed to drm-misc-next.
> > > The fix will show up in upstream kernel at the next
> > > merge window.
> > 
> > The most of the patches from so called Hulk Robot appeared to be controversial.
> > 
> > First of all, even so called "dead code" may have side effects on the registers
> > in HW which may lead to other issues. Second, the mentioned dead code elimination
> > patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
> > I got into that, I still have a build error).
> 
> Sorry, I do not understand what side effects this may cause. Would you
> please explain it in detail?

Any IO (and specifically on PCI bus) may have side effects. If the removed code
did some HW accesses (especially reads), it affects the state of HW. You can
read more about PCI bus and what read from it does.

Helge, can we revert this change and start over, please? (I can also send
revert if you think it's a better way)

I do not believe this change was ever tested on real HW, and I see an evidence
that this most likely was blindly made as it led to the similar issue after
the change.

> > That said, for the starter I suggest to revert this change. After one need go
> > carefully through code to understand if it's exactly the case and what to do with
> > 'mnp' which involves some IO.
> > 
> > +Cc: current fbdev maintainers

-- 
With Best Regards,
Andy Shevchenko



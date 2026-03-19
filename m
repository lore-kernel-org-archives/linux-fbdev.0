Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D41EE033
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Mar 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908523; cv=none; b=ZMGghAjAoWCRghRa3cCImAvSady/fsyABApt5uPTG/IUS3ZZMTNHf+2vapAsZQ/8wDTNHZ0iSQyZGTbJZZgGgXD+PKsSE5XL/oOjkroDeTCW9wAFNzeZ/Ns4KJaz1Qsixkj363Th0tcs2Wj1Sav87HPaUIOxDcq9/doAMCkOEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908523; c=relaxed/simple;
	bh=yetkjL3pXRMN3sdV6EFledjFlQqnQct1kECMirWqyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxcEFIzjM19n0H1uZf62dxcpNVbor2uqf6yCeLvpidaQ1dRl6pcmzD1bknehsG9srvbl8z1mpLQtWGvpVIunWkpP2nEkJpSpSOR0szgNZTvOG30jY/Qi35qo/lEahKX94kiYl5ibg0f0xn36z42nxJGM67wQgOXFENs4pcMD8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSuexT9F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSuexT9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773908521; x=1805444521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yetkjL3pXRMN3sdV6EFledjFlQqnQct1kECMirWqyAw=;
  b=kSuexT9F06PAXOjmc21xXMvaagKjEjKRJkkEjHxz/ZeM3hqxo/Dk30Hq
   ZyGaGkhDuZ9m6LJkxd6zcLXjn2pA40qZbPyCjkBnnYJ6stS6YM9f86RFr
   ekQrfoKGHMsSs+3jKyVXE4WWtYLFg4WzF311EIeMN24ILeWnBO63f6rGW
   d1W80wqjIUo3c5FK1h2+4n5ySst3n0kh4dv/HGTDgcjZLvAJJLC1/cxjU
   shFF6ScMhH33pzO3Dh5W9CccIIuivJuv1pZYNl/aDfObyj77+QCMmJxPD
   Fh9m1r76FUCwDdjlICjKj9kmfSd1eMowAaR9rZJJAiVc+leE7TpWVS7Af
   Q==;
X-CSE-ConnectionGUID: lTaccoBXSa6Dk92YI6Song==
X-CSE-MsgGUID: Uj4D8WJkRuOSN3yl3FHOnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85602853"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85602853"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:22:01 -0700
X-CSE-ConnectionGUID: CHlLw4cKSRi9a2kEb/IwRA==
X-CSE-MsgGUID: hppVklP4QQi30tm1RDWkhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="245917501"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:21:59 -0700
Date: Thu, 19 Mar 2026 10:21:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <abuyJDK6E2aHA4rC@ashevche-desk.local>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
 <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
 <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 04:06:44PM +0800, Jason Yan wrote:
> 在 2026/3/19 15:38, Andy Shevchenko 写道:
> > On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
> > > 在 2026/3/18 15:45, Andy Shevchenko 写道:
> > > > On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
> > > > > On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
> > > > > > Fix the following gcc warning:
> > > > > > 
> > > > > > drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
> > > > > > ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
> > > > > >     unsigned int pixel_vco;
> > > > > >                  ^~~~~~~~~
> > > > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > > > 
> > > > > Thanks, committed and pushed to drm-misc-next.
> > > > > The fix will show up in upstream kernel at the next
> > > > > merge window.
> > > > 
> > > > The most of the patches from so called Hulk Robot appeared to be controversial.
> > > > 
> > > > First of all, even so called "dead code" may have side effects on the registers
> > > > in HW which may lead to other issues. Second, the mentioned dead code elimination
> > > > patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
> > > > I got into that, I still have a build error).
> > > 
> > > Sorry, I do not understand what side effects this may cause. Would you
> > > please explain it in detail?
> > 
> > Any IO (and specifically on PCI bus) may have side effects. If the removed code
> > did some HW accesses (especially reads), it affects the state of HW. You can
> > read more about PCI bus and what read from it does.
> 
> No, the removed code did not do any IO and will not affect the state of HW.

Excellent, but it leaves the code that does IO and now still breaks the
compilation.

> > Helge, can we revert this change and start over, please? (I can also send
> > revert if you think it's a better way)
> 
> I don't think we need to revert this patch. Please provide proof that this
> modification will lead to real issues.

It's not me, who should provide an evidence, it had to be the author
who must had provided testing and everything when submitting the change.

> > I do not believe this change was ever tested on real HW, and I see an evidence
> > that this most likely was blindly made as it led to the similar issue after
> > the change.

No answer here? That's what I expected based on my observations on the quality
of the patches from so called Hulk Robot.

> > > > That said, for the starter I suggest to revert this change. After one need go
> > > > carefully through code to understand if it's exactly the case and what to do with
> > > > 'mnp' which involves some IO.
> > > > 
> > > > +Cc: current fbdev maintainers

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2823C4542
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Mar 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017460; cv=none; b=KeYO4+YfmsTaicwX9eGGLa5l/qCVJis15Q0yDWg7a0+hT3yOzSV+uF2FGTUSi4Nc1RbV3HY98nvdp+/JxABnfoJrBJzIiZ6DlqJ/zwC0uIBnDbbonUKzjEPSNvOtcXyb+LSp3eorIEJ8rws+I/hqrO70/5ZcFdGuGz1puLKyKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017460; c=relaxed/simple;
	bh=PemtLJ3DRnw8X7gI4HwLQwobiYg8zhRWonIN/4X1v1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImQ39jz0mXKMJuy3Jq0GX1+q437vn/jpf3qKIKjDTrF3BAVC2ah5zzpVGzvs813EYRvPGXjWjC/9wN57Op4I+accA3FzZ8JPKDvfx+W6n1ZQnk0yquDjYiGqnVWhv1jxB7gY2i5KP65DRAMeBr7CBXWOsE+vYSKAzeZKK+pVyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8YiqH+b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8YiqH+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774017459; x=1805553459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PemtLJ3DRnw8X7gI4HwLQwobiYg8zhRWonIN/4X1v1M=;
  b=a8YiqH+bkwVuWzzKvVHE6Li5SWWMlGLQ+ST4/2g/4VPg+oZt+ivF5E1A
   rXEFrXfdt4BqOVEK4qXQF4sNAY3OzRwcjHqlAL1PvGbj/h7XePTdhsN0d
   9PfH5Mp0onKE32M/yzhVIykveR7z7fxwOP5iV7SPeztq3bjnuvDjKqIU1
   uBdoWhT7ZPXJhKgDYd7KnyM9THajTCIe+2VbxiK1YSt0fj7PFJE0ZqZTo
   2fwzxqvvAsYXTUZCpwtcopsiRQZ6Hb/ud83N0l/M6r/s0rLyCGgv1cQjD
   Q3z2QTzGbDs8nElVcU1HPGpgiLc/mCatj4yAiTixbSdwzzvJww+TYBqNt
   g==;
X-CSE-ConnectionGUID: wQotxWyPRYm6/Qt9uA9stA==
X-CSE-MsgGUID: Tw/E5g8CR+SS5YgqEMlmnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74988095"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74988095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:37:38 -0700
X-CSE-ConnectionGUID: 2gaEPfrpSQ+9w+SgBV2kSQ==
X-CSE-MsgGUID: JGCFd6t/Ru+vytnihBHn/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223285255"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:37:35 -0700
Date: Fri, 20 Mar 2026 16:37:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: Jason Yan <yanaijie@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <ab1brTQUiEJFkL-D@ashevche-desk.local>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
 <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
 <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
 <abuyJDK6E2aHA4rC@ashevche-desk.local>
 <c717b7b6-ffb6-47f9-b345-de0eddcfe7a4@gmx.de>
 <abu9DKMN660yd3Sd@ashevche-desk.local>
 <f13eab5d-bcf0-49ba-91ac-0903040438be@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f13eab5d-bcf0-49ba-91ac-0903040438be@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 01:44:28PM +0100, Helge Deller wrote:
> On 3/19/26 10:08, Andy Shevchenko wrote:
> > On Thu, Mar 19, 2026 at 09:35:33AM +0100, Helge Deller wrote:
> > > On 3/19/26 09:21, Andy Shevchenko wrote:
> > > > On Thu, Mar 19, 2026 at 04:06:44PM +0800, Jason Yan wrote:
> > > > > 在 2026/3/19 15:38, Andy Shevchenko 写道:
> > > > > > On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:

...

> > > > > > Helge, can we revert this change and start over, please? (I can also send
> > > > > > revert if you think it's a better way)
> > > 
> > > Andy, all points you make against removing relevant code is absolutely right.
> > > 
> > > But for this specific commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code and
> > > set but not used variable") I have to agree with Jason, that the patch is ok.
> > > I don't see any build errors either.
> > 
> > Just run on today's Linux Next (since the driver has not been changed in that
> > sense for a few years, the very same issue is present for a long time):
> > 
> > drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set but not used [-Werror,-Wunused-but-set-variable]
> >    412 |                                 unsigned int mnp;
> >        |                                              ^
> > 1 error generated.
> 
> Ok.
> 
> > > Are we mixing up things here maybe?
> > 
> > ...
> > 
> > FWIW, I dove to the history of the driver.
> > 
> > So, the code, that was guarded by #if 0 was introduced in the original commit
> > 213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guarded in the
> > commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on G450/G550.
> > Powerdown unused portions of G450/G550 DAC. Split G450/G550 DAC from older
> > DAC1064 handling. Modify PLL setting when both CRTCs use same pixel clocks.").
> > 
> > Even without that guard the modern compilers may see that the pixel_vco wasn't
> > ever used and seems a leftover after some debug or review made 25 years ago.
> > 
> > The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem to have
> > any side effects either than some unneeded CPU processing during runtime. I
> > agree that's unlikely that timeout (or heating up the CPU) has any effect on
> > the HW (GPU/display) functionality.
> > 
> > So, since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code
> > and set but not used variable") the 'mnp' became unused, but eliminating that
> > code might have side-effects. The question here is what should we do with mnp?
> > The easiest way out is just mark it with __maybe_unused which will shut the
> > compiler up and won't change any possible IO flow.
> 
> Yes, I think that's what I'd prefer.
> Do you mind sending a patch?

I have just sent 20260320143646.3218199-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko



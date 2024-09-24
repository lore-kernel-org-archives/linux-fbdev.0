Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB83398E
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166611; cv=none; b=R+qbMc/rAmnegmuMpTTkcmRWR7qZ1pdWBI7Ef3BcFH/HW8ra3gU0t8rn/nNTE/l+DgVGAb/J5/KnoI5I1QBVG5/mhlDzi7BFWDhNR1FOLuedPc+2OBeejfyk7pv5QxFt7AZF9/35PKad7VJFnWWqkfimPwSYhsbMoo3Wg9JVQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166611; c=relaxed/simple;
	bh=MW8yLfs1M2Ib46K8xqdSxahCJ8UTa1poRKjP8Gxs74k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJx9Tuus7tha94YOQwGU6HBfUjDQyroq+o3+93RjxvjGLXWeIv+UNu3YSZkD60A08VmW1Dsy+vXtjdKCczXte+RqfLhvkiNlcB4lipNY4coNz74w4KTUDIYpgbkdpFE8gl1VTUDgrdaI9mVfHLv8GTK4b3DY2Vp+K2Ftc7yTYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKVgJK9M; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKVgJK9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727166610; x=1758702610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MW8yLfs1M2Ib46K8xqdSxahCJ8UTa1poRKjP8Gxs74k=;
  b=GKVgJK9MCogWh3B8/uvqtXSY2QWtwV4/J+/Tzjaf6NOCzJO9CEmV/Tk5
   ZO7jIyydBkaMQ2lq4JsHqFFfx0xP8MO3AfmQCTRdxyR0cbMVPcm9WkV0d
   /toos8N9wfr72mDufn+kpHwz53zRvq265GsioRrFIwggSv4Ev0PBqRc0r
   MqT5I3Z1MxRGtnfcC+J/SlC43vTj65xpCM3SP+okx4IpaU0DqaY0utubt
   5sow3wAe0WJaTXpN7MbFCgOaXdoo2UrtKTbj7aQHfZ70AWnvUqAK83uTM
   79HhTQ+rLL/2mECp7Xu601tfgwxNy4iiYBotA5Z6+lzqPL/8NyDTSHxPj
   Q==;
X-CSE-ConnectionGUID: orRgh5oCQ92fSiYLsruGYg==
X-CSE-MsgGUID: NpLK+J4ETSSWyQvbpNH+Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26265263"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26265263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:30:09 -0700
X-CSE-ConnectionGUID: cUSAg6yYSriVgqBsedIoQw==
X-CSE-MsgGUID: d3EVjTOgSVa70Kg69XtRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71484533"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 24 Sep 2024 01:30:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Sep 2024 11:30:05 +0300
Date: Tue, 24 Sep 2024 11:30:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/6] fbcon: Make cursor_blink=0 work when configured
 before fb devices appear
Message-ID: <ZvJ4jS0ThljULq2v@intel.com>
References: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
 <20240923155749.30846-2-ville.syrjala@linux.intel.com>
 <3e3fac51-ee46-462e-9418-095845b18ccb@gmx.de>
 <ZvHd8VV6MO4kfLcL@intel.com>
 <93c63567-d183-402e-82e0-f64b97b74ba8@gmx.de>
 <a6369def-6076-4a9f-b8d8-ff32385235dc@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6369def-6076-4a9f-b8d8-ff32385235dc@gmx.de>
X-Patchwork-Hint: comment

On Tue, Sep 24, 2024 at 10:27:02AM +0200, Helge Deller wrote:
> Ville,
> 
> On 9/23/24 23:50, Helge Deller wrote:
> > I've added your patch series to the fbdev for-next git tree
> > to get some feedback from the autobuilders and testsuites.
> > I had to manually adjust patch #4 and #6 (after applying your v2
> > patches), so maybe you send a v3 of your whole series at some point.
> 
> Your (fixed) patch series was OK. I had to update to latest git head
> from Linus to get it applied.
> 
> I applied the series again, including Thomas Zimmermanns R-b tag, so
> no action needed from your side for now.

Cool. Thanks.

-- 
Ville Syrjälä
Intel

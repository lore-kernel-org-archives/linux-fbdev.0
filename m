Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D8262FE6
	for <linux-fbdev@vger.kernel.org>; Thu, 26 Jun 2025 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975177; cv=none; b=rUYolhaIpYdK6PLjHfM2XfZcHXkeiiytMg+B0jzzWvuRYeFRCDSWT9y0tLgnZCAsrFF/VtnG7En0qEknshtoTTgJCkcb6WUrDw1mt3b87uFtrQa3032ObxjWuGAh4fiOadgp4cJC+V+YwPWh3zdSzkHE58aTgtCaJc+ba/evXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975177; c=relaxed/simple;
	bh=W4UO3HjXnhwlsoocybFNQKYOaf64K89DJ1Due3lreUM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny8DKV45qXw8EC6X2pE9l3De/V0BajVjCnWPvbRpQtJ8ybQfhvthP2nahJL5lDYmPRf8ILhuLxFScZMLk6fNKIpRzPwZ4AZZ3lTDqVarcxRuFJoqxM/WGA1irOViOhQEPTFu6lH51XXIWAKKRuzoOd1wTLs8S2DPtFjqjk9I4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id d64cf432-52d8-11f0-a011-005056bd6ce9;
	Fri, 27 Jun 2025 00:59:31 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Jun 2025 00:59:30 +0300
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org,
	gregkh@linuxfoundation.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix potential memory leak in
 fbtft_framebuffer_alloc()
Message-ID: <aF3CwnHyW5HHzDSG@surfacebook.localdomain>
References: <20250626172412.18355-1-abdun.nihaal@gmail.com>
 <aF2Ic8BP0zWS6R19@smile.fi.intel.com>
 <0327da98-8a7c-4db8-8bcd-4179b87a9486@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0327da98-8a7c-4db8-8bcd-4179b87a9486@suswa.mountain>

Thu, Jun 26, 2025 at 11:11:39PM +0300, Dan Carpenter kirjoitti:
> On Thu, Jun 26, 2025 at 08:50:43PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 26, 2025 at 10:54:10PM +0530, Abdun Nihaal wrote:

...

> > >  release_framebuf:
> > > +	fb_deferred_io_cleanup(info);
> > >  	framebuffer_release(info);
> > 
> > While the fix sounds good, there are still problems in the driver in this area:
> > 
> > 1) managed resources allocation is mixed up with plain allocations
> > (as you discovery hints);
> > 
> > 2) the order in fbtft_framebuffer_release() is asymmetrical to what
> > we have in fbtft_framebuffer_alloc().
> > 
> > I would recommend to study this code a bit more and provide the following
> > patches as a result:
> > 
> > 1) fixing the order in fbtft_framebuffer_release();
> > 
> > 2) moving vmem allocation closer to when it's needed, i.e. just after
> > successful allocation of the info; at the same time move txbuf allocation
> > from managed to unmanaged (drop devm, add respective kfree() calls where
> > it's required);
> 
> Symetrical in this sense means that the cleanup in
> fbtft_framebuffer_release() and in fbtft_framebuffer_alloc() are
> similar:
> 
> 	fb_deferred_io_cleanup();
> 	vfree();
>  	framebuffer_release();
> 
> I feel like number 1 and 2 are sort of opposite approaches to making the
> order symmetrical.  #1 is changing fbtft_framebuffer_release() and #2 is
> changing fbtft_framebuffer_alloc().  #2 is the less awkward approach.
> 
> > 3) this patch.
> > 
> > All three should have the respective Fixes tags and hence may be backported.
> 
> Changing the order isn't a bug fix so it wouldn't get a Fixes tag.
> I agree with Andy that the code isn't beautiful.  But I think it's
> easier to just fix the bug, and do the cleanup later as an optional
> patch 2/2.  I would also have been fine with a larger patch that does
> the cleanup and the bug fix in one patch but I think other people
> won't like that.

Ah, you have a point. Yes, the moving vmem allocation will solve the ordering
issue.

-- 
With Best Regards,
Andy Shevchenko



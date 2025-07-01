Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7F19AD89;
	Tue,  1 Jul 2025 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346896; cv=none; b=LGelzNYdNY9XEC4LW6H9n3YFE4hEZxU8NSgWT5Qt2rZ3uOHpCakUgLEDPQAjcGMVdT5fZIqS7aPhivTUmgwS7dL8ZMqBOJz2bRfAncHHazuodSALJjwyOO+LRrpmG1StryKNJrQO2LA9ZX7Qn8/zxFmznS1lfczHbYlyc9rY0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346896; c=relaxed/simple;
	bh=DERyJgZKDAwVFBmoHSsrVpgzn5q2agZWzYJC0whttlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITWIBlbpJkNiTvfmibA33OkfAzUHDa18l3408aKGT8g0iyRVzByLD9D0x+B+8oxJZprb/hg082xsqY3kbDXbjaVj81Q8JMqhdQ+HaFLXvUYfmBpOsODuT1Ln7XM0W2Fc8y7JOSE5yV7dimeUJnJZS23DD4yJ+A/aSokYqgQ+cR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d4EphzzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d4EphzzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0798C4CEEB;
	Tue,  1 Jul 2025 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751346895;
	bh=DERyJgZKDAwVFBmoHSsrVpgzn5q2agZWzYJC0whttlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4EphzzFzWxbZDrDcNlQczILjHMZesyheqBZ5nFdPg9+v7vlz/KWP1454ly3b6kYw
	 spQp7goOnpmFTuqPs4gtvQdjltemnQk+KFcMEE0J7F6XPz9CQfuqP55/5mFv59WnyK
	 0Nryg6ul/A8YZzb/J7vExTDp0WYpoMhLPFMWIl4Y=
Date: Tue, 1 Jul 2025 07:14:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <2025070128-amplifier-hyphen-cb09@gregkh>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
 <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
 <2025063022-chump-pointless-6580@gregkh>
 <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>

On Tue, Jul 01, 2025 at 12:47:22AM +0530, Abdun Nihaal wrote:
> Hello Greg,
> 
> On Mon, Jun 30, 2025 at 07:16:38PM +0200, Greg KH wrote:
> > This patch does not apply to my tree, can you rebase and resend?
> 
> I think you have added both the V1 patch and this current V3 patchset to
> your tree, that's why this patch does not apply.
> 
> Commit eb2cb7dab60f ("staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()") 
> on staging-testing is an older version of this patchset, and so it has to be dropped.

I can't "drop" patches as my tree can not be rebased.  Can you send a
fix-up patch instead, OR a revert?

thanks,

greg k-h

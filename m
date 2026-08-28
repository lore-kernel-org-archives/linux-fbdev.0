Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852643C9ECF;
	Fri, 28 Aug 2026 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896064; cv=none; b=XUcZOZXLhBegB/XP4X8yTX+2JO12827wjzm1VwYIbr7OiRK6Dr/TKyDAQJlDjGLeZAa7moX1VJ1L8pxdAJRpZhZMWKWD0/GgASTntBp9+KGxWLLM/16uRKS7jnng+j/FAltSSiSf7xvGTXZd57e08mC/uIUVRjjSh99jK3rBTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896064; c=relaxed/simple;
	bh=mF1R4IqydT/BCY6zJAnhw2GVxTP3W0iAld5NJcOwJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Git9LgjCy54MIh+ZrAKFl0FHNpJumKKPEAML3rIEOEhHAl3MloBz5NZFcg6LFcmb4ETE2AfNb0b8E1JDHdrojWXUKKc7pFEgWE32J+njz0Ity5LzAf3SgpMvIGfEXflecYb2N1PBQODTjTf1Ot6K1n0DxCgMk7AMtm+O0rdkkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARVC/fWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARVC/fWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F1F1F000E9;
	Fri, 28 Aug 2026 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787896063;
	bh=/yqlHlAPjavdiFtaXHR1jSwfthvqrJDW2qjTGSZ2fOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ARVC/fWAHi4wbcaBwUHdVyxOFpA+zDP2vDza8dVzAz4w2GoKUXeSfJ+NxKyNdCxAc
	 RO8V8gxYpc5ggC75smc0LiNm78JB6wfP72uxbX5iSsgawi4t2Koj9yfjoEInAxX4k1
	 dORc3KGJw3ZVBt3vuMOkNBB1x/Z5wmSSAlSYMG1w=
Date: Fri, 28 Aug 2026 07:47:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Preetish Amballi <amballip@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, andy@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
Message-ID: <2026082818-finer-desecrate-d6b0@gregkh>
References: <20260809053253.14537-1-amballip@gmail.com>
 <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
 <CAEnJ0XJqjTDrV4Leq9ZGBQSRRJ8Gg0Nr9O8ZB90cCQftC5of=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnJ0XJqjTDrV4Leq9ZGBQSRRJ8Gg0Nr9O8ZB90cCQftC5of=w@mail.gmail.com>

On Fri, Aug 28, 2026 at 09:47:41AM +0530, Preetish Amballi wrote:
> Hi Team,
> 
> Could you please merge this.

It is the middle of the merge window, nothing can happen now.  If you
wish to see patches merged quicker, please help out in reviewing other
patches on the lists to reduce our workload.

Also, it's a comment change, not a major bugfix, so you want us to
handle regressions first, right?

thanks,

greg k-h

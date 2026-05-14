Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CB3C2797;
	Thu, 14 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759083; cv=none; b=jRNusAZuYX5BENxXJSI4kyCbsToJJJoFXDDleTJqOqx56aPQ/JIsikPoAu5ifrnsk5vUHas5Cu+Uo7m3h3tsLFXP395mWOd0te5fiLIafeAaj63oiuEAAaNW5JkRgSmydUZhWvlJQ6K084hILBmzCwg8o5wTta1fDuO6o0cLhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759083; c=relaxed/simple;
	bh=CcXestgFm3BIUMs1eN088Hh3mP9VlPacV7qqGhr3unc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGQERt38HqiqnO9YTH0B154fVihEQCcyWLiaDwG8rh0wFpVrwuyHPku9b2q5mvk96LdpVdwy9Ehg3iP6wOl2UUBVuNYPzCtKFsjiZmqJk33B9MhQJsgTFzWCd0qWm9QPYAjrR83gzrKG4D95djR4MD3egP7BL4gA7XCuMe4TTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6E1+9F+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6E1+9F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD86C2BCB3;
	Thu, 14 May 2026 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778759082;
	bh=CcXestgFm3BIUMs1eN088Hh3mP9VlPacV7qqGhr3unc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6E1+9F+JjP6MEJyPmEkzyPxxH0UjG+CTuRbny803v3TQ9f8bffNlfYPa/fRoLhsZ
	 Clyf13o29zQl9zmS7hj/hlW6xFnC+Ep9OieGBxpkJhOFPb6NImVEvpQWL1UkYDXPRJ
	 gcOTPDdjcnyztMHyupG+f+g49Ei7PhNqtOfnk/Vk=
Date: Thu, 14 May 2026 13:44:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add suspend checks to copyarea and
 imageblit
Message-ID: <2026051415-vineyard-antihero-ee6f@gregkh>
References: <20260514104924.60296-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514104924.60296-1-yogeshdangal66@gmail.com>

On Thu, May 14, 2026 at 04:34:24PM +0545, Chhabilal Dangal wrote:
> lynxfb_ops_fillrect() already checks info->state before accessing
> the hardware 2D engine, but lynxfb_ops_copyarea() and
> lynxfb_ops_imageblit() do not.
> 
> The suspend path calls fb_set_suspend(), which sets the framebuffer
> state to FBINFO_STATE_SUSPENDED. Add matching state checks in the
> remaining accelerated callbacks for consistency with fillrect().
> 
> This patch was developed with AI assistance and is compile-tested only.

Please read the documentation for how to properly document LLM
assistance.

also, you aren't sending this to the right lists :(

thanks,

greg k-h

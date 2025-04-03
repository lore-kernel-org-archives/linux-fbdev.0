Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5361EBA0D;
	Thu,  3 Apr 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689895; cv=none; b=otHiKaL8wCer7jnHe6MgjS+HcSWhe6QIFAMZHZca3qXjHlTqSRjaCHv34xitv4GE4XDQPRxyfPqNSJpf6HwdQwqQi9+7P+21EEPdOATo5f+Il60xx9aXMtyA+2dF+HgXHmi+t4XMMilgy5/kEkryQEREpLaocqfFXjVVyO0/4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689895; c=relaxed/simple;
	bh=Uy8VhtkwGnjgWhisPk852iAoDVSZJ1v9w+B0YXSVHg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyAg55GpeEfKkupd0ocFKO7e7QMyA4HkeZQ84a94IJjLEBBQMMdQdy5niE6XFJnWT+H9SqQiJ+4y4yzVmBgLTT9PUyLfbkHJw50TYdSQmx9+6lUf9gXXCiDdfPNFM0AktLWz98nkWvE9bjhIV0V4RgkODbCqKU20cj6ypH2rjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ic/2PwvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ic/2PwvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0047C4CEE3;
	Thu,  3 Apr 2025 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743689895;
	bh=Uy8VhtkwGnjgWhisPk852iAoDVSZJ1v9w+B0YXSVHg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ic/2PwvKwZFBLZja5vywSaemxyPGR/b+oYLjuRsfqN39ZyKJefDbR667Nji/IT4jM
	 j9XP1oaaivoqbkWl3yHJxmzM2xMR4UCMVBaz12MecRunGf1UKNlisFVQOllNV4Lnbz
	 LGnoWu5JiVQ9QBsdYcrq+rDtsnjJ2y9OopdAe8lw=
Date: Thu, 3 Apr 2025 15:16:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] staging: sm750fb: modify function name to kernel code
 style
Message-ID: <2025040301-tightness-giveaway-a568@gregkh>
References: <67ea5813.5d0a0220.293276.775e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ea5813.5d0a0220.293276.775e@mx.google.com>

On Mon, Mar 31, 2025 at 09:53:36AM +0100, Richard Akintola wrote:
> Change camelCase function name sii164ResetChip to sii164_reset_chip
> as reported by checkpatch.pl
> 
> CHECK: Avoid camelCase: <sii164ResetChip>
> 
> Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
>  drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
>  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

You sent 2 different patches with different subject lines, yet they
almost did the same thing?  Which one should I take or review?  Please
send a new one, as a version 3, and properly document what changed
between this one and the last 2 submissions.

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BF1EB9FA;
	Mon,  2 Feb 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044483; cv=none; b=pgITFjBoETMKO4+71HL4ncoYL7wawGSNi4hzPtnUDHNN2WOpdWWwqsIUCCfRofy+npWK8zgxi6WiycK8fHlmIEnnGrHnL8yZICQUgw3JJ/EmevTFAe2Y4Oezrv0rHzV8GByx0pXYy/mgK7xcYqG5x1CKFTRrMk5XxOiO7NrxSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044483; c=relaxed/simple;
	bh=c3u75pWcmcqcVT7QstGPGMl1crPrTIGN5HbAUC/P16E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ5LjvoT2zUnafmTI1T+6FI9D4m4OQS4BM4fQFWSRx7jhKNLAS1RrEXq8PAt10u+9YawjLL3bYPc5rAxPv+veWs/Q32wTV2T3qeywvHv8Y5AgLUYKzrs6D8YGg+uc+sstuEKGxKFsEy6Jjuxs0ttmclj5J0W0ZoAxDGsWWkIUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Osvwnv6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Osvwnv6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77134C116C6;
	Mon,  2 Feb 2026 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770044482;
	bh=c3u75pWcmcqcVT7QstGPGMl1crPrTIGN5HbAUC/P16E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Osvwnv6uu0Qo44hC9SQDuzQxbpw++LAU3ZD09pBP5lfZYd1La99VAeogQdXHU+B1G
	 u1sSfEUyHhFTn5ADJHz6YWkx+UjmfwH8h4CFbi+gAEYAU/K0yWVfwQtwZ23SFdCTDB
	 WQ/eTK2nFXsWWz6XgQ40ImAOzLNPrE+E+QBuoQ3o=
Date: Mon, 2 Feb 2026 16:01:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yehudis9982 <y0533159982@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename Bpp to bpp
Message-ID: <2026020201-monogamy-sash-4866@gregkh>
References: <20260202145413.132435-1-y0533159982@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202145413.132435-1-y0533159982@gmail.com>

On Mon, Feb 02, 2026 at 04:54:13PM +0200, yehudis9982 wrote:
> Rename the Bpp parameter to bpp to avoid CamelCase, as reported by
> checkpatch.pl.
> 
> Signed-off-by: yehudis9982 <y0533159982@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 046b9282b..866b12c2a 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
>  }
>  
>  int sm750_hw_fillrect(struct lynx_accel *accel,
> -		      u32 base, u32 pitch, u32 Bpp,
> +		      u32 base, u32 pitch, u32 bpp,

What does "bpp" stand for?  Perhaps spell it out further?

thanks,

greg k-h

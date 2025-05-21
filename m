Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841D25C71B;
	Wed, 21 May 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828063; cv=none; b=h1jqCIeTV7xHZfgblExHAhsWonUx9/VzRN35u2uMu64UHylB6q/XO4gV/3zzBHCIF1Ud/iy6GEcuc68/93RzaZvmY27FsEbzuU2oDXUNlvirZILBO9bV3xSngLIBfuLiXhZEAcGtLIayhJhdbDc/bVhN63S+GITiaP9/LDqBZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828063; c=relaxed/simple;
	bh=uXrilJHBDaHOBHpW7qJc4xMuL1Nc9bvJlaRVyvML5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrDHKYSaf4pYhqLd9U0VSz4A9mGCJRqf9gsDL/lSxorLXluy0cn5RpI+ovr0fjKl+4Sh4YfqjtJ9iXYdZ6fjQzYgJAnLKN5psNCW9qzwd4kty6dXgDWDy+C8UiZceTPBU6R6ppuTxOWLcQ47U/i7zIbgRulFfZ8Kv+SGoSPfTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1LJnR73k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1LJnR73k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947DAC4CEE4;
	Wed, 21 May 2025 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747828063;
	bh=uXrilJHBDaHOBHpW7qJc4xMuL1Nc9bvJlaRVyvML5Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1LJnR73kzLlIqm6VSqYPZvKZLw2mCLFscvebEB786L7MSylrCwut6cbNrJB7rVdlF
	 e4kv2mQDGfC1JBp/y7L7kM7BdxkFGxELgD+3jbOdQnOtFbMTeBu+uuupRmoYMR1Qqu
	 dS4aphEekR+v7zmySNOhsa0GlkCxpOr6/lAdnBvw=
Date: Wed, 21 May 2025 13:47:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: rename dpPortBase in lynx_accel
Message-ID: <2025052125-stew-customs-4ca9@gregkh>
References: <cover.1747605658.git.ericflorin@google.com>
 <97fcc39f3e63f465c49e8725d10f7c43fd35cd85.1747605658.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97fcc39f3e63f465c49e8725d10f7c43fd35cd85.1747605658.git.ericflorin@google.com>

On Sun, May 18, 2025 at 03:09:47PM -0700, Eric Florin wrote:
> Rename `dpPortBase` to `dp_port_base` to conform with kernel style
> guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <dpPortBase>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750.h       | 2 +-
>  drivers/staging/sm750fb/sm750_accel.c | 2 +-
>  drivers/staging/sm750fb/sm750_hw.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index a2342c69a65a..0ed1e18611ba 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -52,7 +52,7 @@ struct lynx_accel {
>  	/* base virtual address of DPR registers */
>  	volatile unsigned char __iomem *dpr_base;
>  	/* base virtual address of de data port */
> -	volatile unsigned char __iomem *dpPortBase;
> +	volatile unsigned char __iomem *dp_port_base;

Same here, are you sure this doesn't come directly from the hardware
spec?

thanks,

greg k-h

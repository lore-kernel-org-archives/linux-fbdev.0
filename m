Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195513DCD9A;
	Thu,  9 Apr 2026 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747109; cv=none; b=PndrwhiTNPLMMkplwO7xRJ4KX+Z8sFmnp6F6zbMrtukjQZ6FcoB0dJQcXK8fD8CFb0vRZVxBNW4+eODQxlp2NYNsUKux9pR+zoIDk48IVH2XGFoIi9bIYeCnvLRq+Wm4r7GWf1SPtsLHiaLA2yBv98pm54IbBMw4S3HWhC/3QC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747109; c=relaxed/simple;
	bh=gMsbHUoDzgCO9COY5x+FwldwPdxTA9yTOgHQ4P70/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBZzi9rkYH4Oj5c1d5Xe8X3jHknkB0CCbAOyt4TOwyJOXvwTdHVuWXNs+De+CktVVY6gGXByXEoBvmNblmET6U7GjhtAA5dOqYh/HjU+LaDKkqPNQaUW5eysF1TUcKqb9aVUPQ+fjzigO34xl0KvPaR3Qa+QIOXMIsp4d6d9aV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbzuCKaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SbzuCKaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B9DC4CEF7;
	Thu,  9 Apr 2026 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775747108;
	bh=gMsbHUoDzgCO9COY5x+FwldwPdxTA9yTOgHQ4P70/uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbzuCKaWLkhxxMb7A9Lko6b1Sol7TjVCBLBnmfljl8gbJpX51Cdex0wj+HKOaSbl6
	 VtUeVWYZvoq3eqMvl8v/jwXTb/CO7OAfovqhCHWpxpqLX/LUpPsHY+Qp9oNAYkWp+P
	 euLJYAkEmrX4AmDS37jGSy1ppihnnEyBR/G5NZ+c=
Date: Thu, 9 Apr 2026 17:05:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: propagate error codes from
 de_wait()
Message-ID: <2026040931-robust-siamese-4e11@gregkh>
References: <20260409144119.21500-1-dennylin0707@gmail.com>
 <20260409144119.21500-3-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409144119.21500-3-dennylin0707@gmail.com>

On Thu, Apr 09, 2026 at 02:41:19PM +0000, Hungyu Lin wrote:
> The sm750 acceleration functions currently return -1 when
> de_wait() fails, discarding the original error code.
> 
> Since de_wait() now returns proper errno values, propagate
> the error code instead of returning -1.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 0f94d859e91c..891d12a5e2cc 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -90,14 +90,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>  		      u32 color, u32 rop)
>  {
>  	u32 de_ctrl;
> +	int ret;
>  
> -	if (accel->de_wait() != 0) {
> -		/*
> -		 * int time wait and always busy,seems hardware
> -		 * got something error
> -		 */

Why did you delete the comment?

And when did de_wait() start returning correct values?

thanks,

greg k-h

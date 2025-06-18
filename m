Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926502BEFF3;
	Wed, 18 Jun 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256774; cv=none; b=HMmK8de99eVgnDAHiLpj8wZmpHLnXCt1iDFgPRuXhRrqZtYFufSE+rqcJwmGXqTEoWSn7eE5Mf00I1kPF4jbV2z3QRTXEYotJaWLyEcwIpAfGdvx/FfHmKlmjmKFzP8vwXZfdGHbZuPjg3u9kw7HwJrUSD3CmDaccdpbIPHchyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256774; c=relaxed/simple;
	bh=/blhL2akKmMq36380T/ib5fiIDzcnN30f9c4OMQ7E7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKpqHkfSteOA96C7eP7S41ZDrMP00frJWSfjjS9pvgC+JHEjmuAcGrUeZZ1Nq92cHrNJdmlwM300wHGML5/SdudPsPV5VOu8UgHDun026iQnY28e0qUbc8/OZKUJXSTa8H7oXhkHpaUmVWeRmkiVuGfFMAMtLts+FKvL7rYv5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1HirzRfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1HirzRfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A0C4CEE7;
	Wed, 18 Jun 2025 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750256773;
	bh=/blhL2akKmMq36380T/ib5fiIDzcnN30f9c4OMQ7E7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1HirzRfM7d3RMRSdE7eIMCKQJRWtEzOGGCW4r5ghcS9W1oaE0x9efow4ehPqvFO4n
	 MbOevEkhQdFl4tOCS5J2tZinzJ4VCG5+7vtIx0eylP5f1mX9fGmxmPvwHEdzfdWjiw
	 1QXYejMFPzenjFC93SsN/itPU0EgwTOB9kL9r6JI=
Date: Wed, 18 Jun 2025 16:26:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kisub Choe <kisub.choe.0x1@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename 'proc_setBLANK'
Message-ID: <2025061817-jacket-nacho-50d6@gregkh>
References: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>

On Wed, Jun 18, 2025 at 11:15:55PM +0900, Kisub Choe wrote:
> Rename 'proc_setBLANK' to 'proc_setBLANK' to

That doesn't rename anything :(



> conform with kernel style guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <proc_setBLANK>
> 
> Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  drivers/staging/sm750fb/sm750.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 1d929aca399c..bb2ade6030c2 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
>  	pr_debug("blank = %d.\n", blank);
>  	par = info->par;
>  	output = &par->output;
> -	return output->proc_setBLANK(output, blank);
> +	return output->proc_set_blank(output, blank);
>  }
>  
>  static int sm750fb_set_drv(struct lynxfb_par *par)
> @@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  	crtc->ypanstep = 1;
>  	crtc->ywrapstep = 0;
>  
> -	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> +	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
>  				 hw_sm750le_set_blank : hw_sm750_set_blank;

Why do we even need this function pointer?  Why not just do the check
above when it is called instead of this indirection?

thanks,

greg k-h

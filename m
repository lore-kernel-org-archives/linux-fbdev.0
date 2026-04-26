Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F9371049;
	Mon, 27 Apr 2026 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261843; cv=none; b=LB9MRQ37OU4nZPhiHCCrYkmdCWDrZm+dhJhz5RL+DOT71uc/Zuqm6lyZvC1mHJvqBT6/l97CuPZ80BAnyDdTMTgLnw5IUPyRFgejtOBPqAPjM16JvCt3HoQiptNouxGDH3XpvreI1exWW4a03iArqLMDVSOhIcHIyHHlOKm7UrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261843; c=relaxed/simple;
	bh=RcfcXYW51t/iPmoV3lUxNMrLOCattsjAxUBYfK9egwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MviACkUyhT/aSK59sPsRaNaWssJl3rru4XLxyl0u3YS+H6fY8f5+7Ckd510/tAtDw2VrV82ITuA+Q/SyPZ1glcoLDeLAvqOEMCHjYJGXqyobL4ulSc7BnMbZZ6P8TTSgl0yJ4LLB1IdBqQMvLVnGDJMzsO4D06ArvMLAZxWGtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LFeon8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LFeon8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78220C19425;
	Mon, 27 Apr 2026 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777261842;
	bh=RcfcXYW51t/iPmoV3lUxNMrLOCattsjAxUBYfK9egwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LFeon8XBN13MkmFgs2gk5N+prfbdNSiceYH6PjhANwxwMrn38zO5MiOIPTNEbMns
	 vjrl/aHaE1cSIz+CmelXxLVd16SfWPDuwr5FQu7yOJaygIwnmlkPFOUFpMdhJpUWH2
	 iMm+mzttg0g1b2FnB744Xq/hiF+4wntZKZsGUap8=
Date: Sun, 26 Apr 2026 21:20:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sachin Kumar <sachinkumar905846@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: clarify TODO comment in fbtft-core
Message-ID: <2026042631-resolved-outline-2946@gregkh>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
 <20260417093303.33670-1-sachinkumar905846@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417093303.33670-1-sachinkumar905846@gmail.com>

On Fri, Apr 17, 2026 at 03:03:03PM +0530, Sachin Kumar wrote:
> Improve wording of a TODO comment to better describe the
> intended optimization. The comment now clearly states that
> only the changed display area should be updated instead of
> refreshing the entire screen.
> 
> Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
> ---
> v3:
> - add missing changelog for previous version
> - simplify TODO comment to match kernel style
> 
>  drivers/staging/fbtft/fbtft-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index f427c0914..cff838955 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -414,7 +414,7 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>  {
>  	struct fbtft_par *par = info->par;
>  
> -	/* TODO: only mark changed area update all for now */
> +	/* TODO: update only changed area, not entire display */
>  	par->fbtftops.mkdirty(info, -1, 0);
>  }
>  
> -- 
> 2.43.0
> 

Does not apply to the tree anymore :(

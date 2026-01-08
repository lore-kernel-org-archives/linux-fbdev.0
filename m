Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9B347BA8;
	Thu,  8 Jan 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866277; cv=none; b=PVJI03LBlWEFTxRUVBcaTtJwI75IgjRCpYSRUideNZRcVfgmfR4lfTGfwGoqlTrw/FG6l1g1juQx7RQdUrMJD+FM4+GTmXkgZYmL68u0YknSf2ArI4lBmQkkAqwMrFwOc6GjxwPjN+bdd2XEcjZASgXgcRh7ToLUdp3/Jeb7QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866277; c=relaxed/simple;
	bh=KJMLKtgmBZCJWuHGsXbhRkAkjlHzsouDdRM0RG+aySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayulJJovhsIX4EEevsxAMNRdFOH2ehQx+pZH4C/cVwID0lTmklJZaGvm1T4Bvyt3bUBuBGrbh8VrRe/liWe1MRe8KVhi+oA+yei40AfJosYwLDGM/mGGf5XHm/Dc/Qec/A82yPQJfkk1MYbURvjqykrIRCBEKaCBgwa6p2AyseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=voJ74TeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="voJ74TeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE17DC116C6;
	Thu,  8 Jan 2026 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767866276;
	bh=KJMLKtgmBZCJWuHGsXbhRkAkjlHzsouDdRM0RG+aySw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=voJ74TeGuTkwCbMTG4VIwF7ZBwZyHb4NT8S94qGEHQk0yHJzG5q4U9jEPLNS0mKlk
	 f/hnYG61IX9aWBUG46ZnSzrASvEsvzuhOvuyAZsw+YFTVjwHVpBsZPpytA33KHPvaz
	 79YRDQrhvcJGeTk2ViyDEsaU/PtMkrVrN0Mobp4Q=
Date: Thu, 8 Jan 2026 10:57:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: align tinylcd write_reg args
Message-ID: <2026010823-floral-alphabet-4aef@gregkh>
References: <20260108094709.92561-1-chaitanyamishra.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108094709.92561-1-chaitanyamishra.ai@gmail.com>

On Thu, Jan 08, 2026 at 03:17:09PM +0530, Chaitanya Mishra wrote:
> Checkpatch reports a misaligned continuation line in the
> 
> fb_tinylcd init_display() write_reg() gamma table. Align the
> 
> continuation line with the open parenthesis to match kernel style.
> 
> No functional change.
> 
> Signed-off-by: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..60cda57bcb33 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

That kind of makes the code harder to read, right?

checkpatch is a guide, always use it as a hint, not as a rule.

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E53587C2;
	Tue, 27 Jan 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525350; cv=none; b=bKRtNzFrUfADMnylyyOzn5c5J6XFPrPTdSko4UloR6EFY6z1+uIHoQWuui3klU0r5KtTCWt3++xI5N4xSppaT54UZKLCRjgOms//ZwxPuA7LAissCAalBFcxqva9PfDby7daAdInca7wAsvQ4I9s8FFQKJ+KxfOgpZJ6HQkDwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525350; c=relaxed/simple;
	bh=48vWZ/4+BG9YwJ56E2KnU4acLxPmiexXS6A8kHskf10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueSpL9tlaAGzcq+Cw/c8Miui9+8y9uTJkAaqhf03TkCbY3dm4BvCGzZKQbOe3UCTtl4Loo0+snT835FKm+/N/dwJV4PX6nbxyJSvKdp8w7qYLqChz8gUYBjnCndunf6iRv0LjIHn/QKixBjxvUm1U99fo5Sx7W6UJBbzVnjB2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+zFHhhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+zFHhhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E04C16AAE;
	Tue, 27 Jan 2026 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769525350;
	bh=48vWZ/4+BG9YwJ56E2KnU4acLxPmiexXS6A8kHskf10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+zFHhhDRE2WihFrjwmrZjCnB5LqfOHBGyI5xsL8fujdInxowt7zeEkdTXWSqLEqW
	 iadR3dDO/CqNK0pZqR3Y4OYQte9aMn91fjods0LAMg7AE4dnxDs6XYOdxQGOZClNur
	 A+wa8FqvtwPh3UnN/H/UR2czihHF0PgGvOcbczmk=
Date: Tue, 27 Jan 2026 15:49:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhumitha Sundar <madhuananda18@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make fixId array const
Message-ID: <2026012755-motivate-sadden-8063@gregkh>
References: <20260127114232.29504-1-madhuananda18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127114232.29504-1-madhuananda18@gmail.com>

On Tue, Jan 27, 2026 at 11:42:32AM +0000, Madhumitha Sundar wrote:
> The fixId array contains constant string literals, but the array itself is
> currently mutable.
> 
> Make the array const so that the compiler can place it in the read-only
> data section (.rodata) instead of writable memory.
> 
> This fixes a warning detected by checkpatch.pl:
> WARNING: static const char * array should probably be static const char * const
> 
> Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index fecd7457e..ff590061c 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		"kernel HELPERS prepared vesa_modes",
>  	};
>  
> -	static const char *fixId[2] = {
> +	static const char * const fixId[2] = {
>  		"sm750_fb1", "sm750_fb2",
>  	};
>  
> -- 
> 2.43.0
> 
> 

Does not apply to my tree at all, please rebase and resend.

thanks,

greg k-h

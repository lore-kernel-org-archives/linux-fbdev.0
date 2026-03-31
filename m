Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1D3E92BB;
	Tue, 31 Mar 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946743; cv=none; b=Lok2BiycKsfPM4ZsBLvLRMjAPy7zOUwYV3FXFCnr86WazXvTa7voJPeFD0h4qqxIP2A0Zf1qG0NqI8f3hSrzCgL4LPBofHdv7p9cEMXIv+LejRvzbgnm5xCpJZNl2sfp85TKk2FS+tde0YCz39/3rL1mcnYoY0Sc6Hpn6xZjptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946743; c=relaxed/simple;
	bh=HquW+int6vpmfhLCgFZt1UroBe7dnLZgk9WqvFR5MB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtxSqyTqHY5oaVn7QkJBE2H6pjCB8x3r6AMTIYrrbaIukBzTjgXoxotyt/75XNcXFAqT9gisOW7Pby/JPwQxRApLx/RCfiXV84iu4DIHVGk5M2IFf4Pfa3yFHc8Rx7Rt/m6j2mQgAOKBg072LSSU/gSAOPDJgj6REMLASCxi4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xn/BISyj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xn/BISyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24674C19423;
	Tue, 31 Mar 2026 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774946743;
	bh=HquW+int6vpmfhLCgFZt1UroBe7dnLZgk9WqvFR5MB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn/BISyj0/pxwUa64rwFheylsXCUDuCXhLWz/4dmI1NfxuLYHuGadZbqTo0ykDHMU
	 ukTtufJDpgC2BqAi+j1Yy6spEe/2fn6gpM6sXwT1BfumPabTl0opd9sOtIDJEuuueF
	 v22X1JDmSrn7wSqfs6BzgRncm65zAYBHUvF10gUE=
Date: Tue, 31 Mar 2026 10:45:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: constify static char pointer arrays
Message-ID: <2026033116-possibly-reference-7ee1@gregkh>
References: <20260331050738.1547-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331050738.1547-1-dennylin0707@gmail.com>

On Tue, Mar 31, 2026 at 05:07:38AM +0000, Hungyu Lin wrote:
> The static const char * arrays 'g_fbmode' and 'fix_id' should be
> defined as 'static const char * const' to make the pointer arrays
> themselves constant. This allows the compiler to place them in the
> read-only data section.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9a42a08c8..b0bdfaeca 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> @@ -728,7 +728,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		lynx750_ext, NULL, vesa_modes,
>  	};
>  	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
> -	static const char *fix_id[2] = {
> +	static const char * const fix_id[2] = {
>  		"sm750_fb1", "sm750_fb2",
>  	};
>  
> -- 
> 2.34.1
> 
> 

Please always test-build your changes so you do not get grumpy kernel
maintainers asking you why you did not test-build your changes :(

thanks,

greg k-h

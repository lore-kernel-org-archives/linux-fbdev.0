Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D937BE74;
	Mon,  4 May 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887149; cv=none; b=iWuxhoB+J7B9A75ckrzaPjNk8lQCYpceSu/7WJEzl1NE2aiQfkzw5pSINIFJ2Zms8Qn78wxUs+f/AJ9+RjjcZFpyf5vfEV91gIdv/3ZiID+RN6bbtVv2mwcVdmHOPZj0uw1jpDTvNPK1lxWlLXJDd+1k2aP01wp8NmjSJIpovJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887149; c=relaxed/simple;
	bh=iFWW741N8v6QMD0wOrae5SV4vI1AZIZ8WmiSC3Pk47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmuhKqiYBnSCLQVOR0BnUW1yFlN+2M+/GTcunzhXleS8ILWmClfavwIxjbVq0y8vQZi6lHs84btWe57MPSW5IqpPlJ1CdoOb5w7H282cFVe4msYpx7vH3GwjPEYybqkhgx+Mrlzt3QCYo66mSlxoSOOMcIuzp6UZ269zdgxxn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yr/dDx9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yr/dDx9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4356FC2BCB9;
	Mon,  4 May 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777887149;
	bh=iFWW741N8v6QMD0wOrae5SV4vI1AZIZ8WmiSC3Pk47c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yr/dDx9Md4KtOpq6Wsb0p8wflez9KT7WNGDIJH4hsLaRnv743BcxjZGVmEPoyGrPG
	 7YiXGlzXSVn08p2XYQAFbE4W8zMTz7mFSyxJ5+MN0zLrINnpqZwA08eX4039slH3iy
	 SGSlqRICqZgloKlW0QByL54DllHk8vOMnrKAC+lU=
Date: Mon, 4 May 2026 11:32:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Francisco Maestre <francisco@maestretorreblanca.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: sm750fb: add const qualifier to string
 pointer arrays
Message-ID: <2026050410-mahogany-frozen-e870@gregkh>
References: <20260503004134.66693-1-francisco@maestretorreblanca.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503004134.66693-1-francisco@maestretorreblanca.com>

On Sat, May 02, 2026 at 07:41:34PM -0500, Francisco Maestre wrote:
> Add 'const' qualifier to 'g_fbmode' and 'g_def_fbmode' pointer
> declarations to make them 'static const char * const', as the
> pointers themselves are not modified after initialization.
> 
> This fixes the following checkpatch.pl warning:
>   WARNING: static const char * array should probably be
>   static const char * const
> 
> Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 62f6e0cdff4d..dc9653ed2108 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,8 +33,8 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> -static const char *g_def_fbmode = "1024x768-32@60";
> +static const char * const g_fbmode[] = {NULL, NULL};
> +static const char * const g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
>  static char *g_option;
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

These are not all threaded together, can you please resend them all as a
correct patch series?

thanks,

greg k-h

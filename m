Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB873DF019;
	Mon,  4 May 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906754; cv=none; b=aT0CWJHk7sMYnHYAzWJR4m5brEW8ksfXooQi20H1hgCXxW2D0ZD5cfd3jjv3sMS2dX+zkoRTVk2zzXlq79IkFaaRNx3yFCf1LA2gAdIIFZ1YhOKvVH2gCFgAtq9lN6hAj5zoS3Rl4b+/v6Mfmit9E4UfG/I7sqymtErF1opSh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906754; c=relaxed/simple;
	bh=SgzRQTnzKPXhoBbZSVqEKQqoUPBysO/3wr+yAp6wIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flYxJrbW3SpUEhsExVxrEhKMqFyDooGnCLUSZuW4D1sE954CSe09sodtxC5pYfuY6xdZLsY8SwcZjppdGw12lVP3a3yrALAGi05+568KM5jda3aG4EjV774mtLB4sfy30EL5ic+PT/zmU7zx5YPnFUV34NfPYWb81d3t+1O4gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oFKJKgzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oFKJKgzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED64C2BCF5;
	Mon,  4 May 2026 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777906753;
	bh=SgzRQTnzKPXhoBbZSVqEKQqoUPBysO/3wr+yAp6wIC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFKJKgzWCx92OUjWTe1fG5o4g+AXjOzVUAbVC6QKAi/HcH3hqfjgfEN+P0GLWdyAP
	 SNDbLn6e9a1ovRZrWAZVQaWeTbBiQsw8oL06Yu/fm8WtktyiIMrAW2BwM74iZHQJXq
	 H4jOODz0mJATx6uIqw/jD+ZPKZiHb5gyZMqsI5hk=
Date: Mon, 4 May 2026 16:55:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Francisco Maestre <francisco@maestretorreblanca.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: add const qualifier to string
 pointer arrays
Message-ID: <2026050401-opposite-contently-15eb@gregkh>
References: <20260503005744.68974-1-francisco@maestretorreblanca.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503005744.68974-1-francisco@maestretorreblanca.com>

On Sat, May 02, 2026 at 07:57:44PM -0500, Francisco Maestre wrote:
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
> v2: Resend as individual patch, not part of an unrelated series.
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

Any reason why you did not test build this patch?  Always do so so that
you don't get grumpy maintainers asking why you didn't test build your
patch :)

thanks,

greg k-h

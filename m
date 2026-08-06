Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669941F2B88;
	Thu,  6 Aug 2026 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991808; cv=none; b=SiwoNJzIEasSludPRqsGngVQxtbRcPgEHnO1umj2Fee5t5zh5p90iFFLc7/8LDvCkt3bPufd/4XM80dazc2glI1mfb0bJdVpH8YHJMTZdUKwC40X5dQeZRikn5TlsMKoKQo0GnfFdth0wBNY4+zWFQo6ZUo1n3fvm8oL+V/CMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991808; c=relaxed/simple;
	bh=EZf+vJhqSz6csPir/JjkCdabQTbJ5qG4drgghSirdCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlDS0zPjdgvf2ZUZXSo7c2wM4c7+wf/8mkXOlKTQDw5eYVcqIHhdD2fV8dUwPWAd5hN4TBSmxySoYxZZ/5RkKUox+giZxZK44EgN/iWrV/f5LIjmrDES5rEHehs6nC2lymuvkRAb2sRH5BFI7MknnYC4zkQGT3CfGxpMAJ259kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVr+ipO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVr+ipO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B4D1F000E9;
	Thu,  6 Aug 2026 04:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785991806;
	bh=5lIuzoGDWXzz9NJIb0Wk8g7wqTXY2T7fXs6ynkFuBuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sVr+ipO/hMowX1MzyJVGgZS8exci5ftLE4FmUZENYbjblPirzul/Zr5ruT9NrbaOv
	 2C+ZcTRSRqejd1Hi2hbWdcrHmjMfcFW/R3Bigg9t9M5vqAbE5ky6Jg/1g3fvHuVeyQ
	 SnXI/yGNMQYlu16fIuQhsig6wFAParXdTiHW7noA=
Date: Thu, 6 Aug 2026 06:49:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array pointers
 const;prevent accidental modification of entries.
Message-ID: <2026080634-catfish-basics-b381@gregkh>
References: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>

On Thu, Aug 06, 2026 at 03:43:25AM +0300, Alexandros Xanthakis wrote:
> Signed-off-by: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c..8f533f3b1b42 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -21,7 +21,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel __ro_after_init;
>  static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview __ro_after_init;
> -- 
> 2.55.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

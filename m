Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EED341060;
	Sat,  7 Feb 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770468194; cv=none; b=I4dZDpJ9jNDuogZiW+4DK/BNDQgWjsIX11wnt08WMpSi1Vcnp/D9QTeQQmYazH3k9IB0c2pB45xDeRE6Qi0UZcds5h29W845R3lt8IaRRrEnoSbboziR6/tZqfO0K/Qv12cCxtl81ZbQtOgmOnOWLB6jayoGQQhWPusNd6Kq494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770468194; c=relaxed/simple;
	bh=Ti5dENZLouyHWz6LbDbM4BBehkQyQLbhB8hzwkl6swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGKJI675ZbyucJ4O28Qge5/C1hY+bG6xch6wzt7DljwjD+ATNcdfSLqEA3iVgFPrRDV7VJTC4IMHwK0Zt8lUKfT7ClGpc79rDkm/ilUJflcCOwyaTN8ON9UzxpkZ7t6hNx4dkbzM6KUH3Y22UEdwzS3MXhB9tML0p++6HxMjKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+7szFl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+7szFl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F9BC116D0;
	Sat,  7 Feb 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770468194;
	bh=Ti5dENZLouyHWz6LbDbM4BBehkQyQLbhB8hzwkl6swk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+7szFl3hhr/xVJX3zmNx9OZC01z40LMpPESd8SHskSfRuCY1TPy458OOqol9VX0b
	 Mm5uqTtAfH68JLUw69VWZKz3Sts/uwJW7sn5kqfhA09Lxec8hF48UhJ7O6inHudVel
	 xuTWDu8XUNNIjThyO7ycBdzO+BZ+RMrY/JbAQO1M=
Date: Sat, 7 Feb 2026 13:43:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shreyas Ravi <shreyasravi320@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase and Hungarian prefix in
 variable names
Message-ID: <2026020717-unmarked-hundredth-6660@gregkh>
References: <20260204054753.3137479-1-shreyasravi320@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204054753.3137479-1-shreyasravi320@gmail.com>

On Tue, Feb 03, 2026 at 09:47:53PM -0800, Shreyas Ravi wrote:
> Fix multiple coding style issues:
> - Rename CamelCase variables to snake_case
> - Drop Hungarian prefixes on variable names
> 
> No functional changes.
> 
> Signed-off-by: Shreyas Ravi <shreyasravi320@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c       | 132 +++++++++++++-------------
>  drivers/staging/sm750fb/sm750.h       |  16 ++--
>  drivers/staging/sm750fb/sm750_accel.c | 132 +++++++++++++-------------
>  drivers/staging/sm750fb/sm750_accel.h |  44 ++++-----
>  drivers/staging/sm750fb/sm750_hw.c    |  26 ++---
>  5 files changed, 175 insertions(+), 175 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index dec1f6b88a7d..67cba3eb0422 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -30,14 +30,14 @@
>   */
>  
>  /* common var for all device */
> -static int g_hwcursor = 1;
> -static int g_noaccel;
> -static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> -static const char *g_def_fbmode = "1024x768-32@60";
> -static char *g_settings;
> -static int g_dualview;
> -static char *g_option;
> +static int sm750_hwcursor = 1;
> +static int sm750_noaccel;
> +static int sm750_nomtrr;
> +static const char *sm750_fbmode[] = {NULL, NULL};
> +static const char *sm750_def_fbmode = "1024x768-32@60";
> +static char *sm750_settings;
> +static int sm750_dualview;
> +static char *sm750_option;

Why are static variables prefixed with the driver name?  They previously
were not, why add the prefix here?

And you are doing multiple things here, changing Hungarian prefixes AND
CamelCase names, please only do one logical change per patch.

thanks,

greg k-h

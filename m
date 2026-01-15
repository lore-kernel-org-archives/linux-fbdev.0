Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA423358C4;
	Thu, 15 Jan 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467603; cv=none; b=I8JvB5+qzZGvymrdbrMg7qMHcCQ+64D1Pyo8KikXX4EB6fzqCOFqncmz6gyz+H3ppQL8gGwWNoae7rzOct1BXiimCaPjvFsJ0+SslqT3QG4dvn4kr+jq42Tc1bhfSUbJ7AB2btK9v01B9GZnYgU85cvmPGKRYIQ2Q8Ea+rLWyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467603; c=relaxed/simple;
	bh=w6ixnRCagNUi0vz0wh0mts+qkQG/hqAzSYNIgtIJX1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5iAYKkDbhTcy8HKTnyblHYaEV8H8qpGKkm5mpSb8WDYVGFGOiWLXMZTbhm7IwwR+lwCqOo1PM6tt3dxI3vBUO976m3aCCN6CH9afiQSPJ8kXYeTRE2sR1cJHu/+BauMG4Ryio7YGq/eGDZRSLUlh9TikgvlBEEDBYms7y+K8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vorLa2sM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vorLa2sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A4C116D0;
	Thu, 15 Jan 2026 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768467603;
	bh=w6ixnRCagNUi0vz0wh0mts+qkQG/hqAzSYNIgtIJX1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vorLa2sMqoLzUPZkGxiGzqqQc0c/2c/knsdiNq3WKJA5ZCqAGE51rL3cln2ZDBGGz
	 tc6DZsZB7z67uWWYy4oF+SpWisyfhJZ/Y33lK2cVy5eByRVMKIytjvp5zOpi7JHoW+
	 EkMA06qIryktCpXf1FTBrYCift0KL21KVKJ5vQFA=
Date: Thu, 15 Jan 2026 09:59:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: WooYoung Jeon <chococookieman1@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace udelay with usleep_range
Message-ID: <2026011528-campfire-disparate-c7f6@gregkh>
References: <20260115084019.28574-1-chococookieman1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115084019.28574-1-chococookieman1@gmail.com>

On Thu, Jan 15, 2026 at 05:40:19PM +0900, WooYoung Jeon wrote:
> In the fb_ra8875 driver, udelay(100) is used for delay which
> causes busy-waiting. Replacing it with usleep_range(100, 120)
> allows the CPU to sleep during the delay, improving system
> resource efficiency.
> 
> This change was suggested by checkpatch.pl.
> 
> Signed-off-by: WooYoung Jeon <chococookieman1@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ra8875.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
> index 0ab1de664..92c9e4e03 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  	}
>  	len--;
>  
> -	udelay(100);
> +	usleep_range(100, 120);
>  
>  	if (len) {
>  		buf = (u8 *)par->buf;
> -- 
> 2.43.0
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

- You sent a patch that has been sent multiple times in the past and is
  identical to ones that have been rejected.  Please always look at the
  mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

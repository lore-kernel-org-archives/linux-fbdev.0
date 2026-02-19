Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0E285060;
	Thu, 19 Feb 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499775; cv=none; b=mP2X8cUetUhv76JOmzzm22jsIRZS0Z7hwODmNVxDJO4G76BzirdaHcZQpHOktVtE5WqtTQjoIsHge+OsyG2btBFbUtSz5MbOL7o0TH1Mkq9i3heAZHQcoFQNCcPDDDtUffCvd7OS/xNVU9BBMeXpL8LJ5xTMmUtlDCGDXTiWqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499775; c=relaxed/simple;
	bh=hKW+A2twJwbGJtXTpMPZ1GvZ9Cz2FltYpqcssNnXmt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgapLrKdOnVD7XliXKkwu4rQCGel7ObGBkdIxeHzrieae/O2NRWtltZt6iJtDsBIm9S2q0Y9QiFk843DJnbJ64i6/TopXXlcjADQfPJcb6Xvf/FCTjlm1yH/RIXBsBZwCCnCRQrcWHuB1J29ozZG7DAcxZZGY1NPI93KMLwxhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfpRc3jV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfpRc3jV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BFDC19424;
	Thu, 19 Feb 2026 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771499775;
	bh=hKW+A2twJwbGJtXTpMPZ1GvZ9Cz2FltYpqcssNnXmt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfpRc3jV+ya49TpQvR7zHOHAbWsKl7IsWjF8CE31RJ8MKsHx1AfYlFqYfMcVfxUSw
	 ePSYN+4K5yFP287eHVrKHhdvSUs0t5t2u9Q0Ht4ioiMZs5hcUHc3EZue8JL0pbPpFY
	 scC6wtUADKfQD57KbQO9CCE3s4aABpxMWcsMoecY=
Date: Thu, 19 Feb 2026 12:16:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: tomasz.unger@yahoo.pl
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with
 fsleep()
Message-ID: <2026021937-protector-provolone-9403@gregkh>
References: <20260219105628.43534-1-tomasz.unger.ref@yahoo.pl>
 <20260219105628.43534-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219105628.43534-1-tomasz.unger@yahoo.pl>

On Thu, Feb 19, 2026 at 11:56:28AM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> fsleep() is the preferred modern API for flexible sleeping as it
> automatically selects the best sleep mechanism based on the duration.
> Replace udelay() with fsleep() to improve power efficiency.
> 
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2c50..3fb15df31592 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
>  		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> -	udelay(250);
> +	fsleep(250);
>  	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
>  
>  	return 0;
> -- 
> 2.53.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

- You sent a patch that has been sent multiple times in the past, and is
  identical to ones that have been rejected.  Please always look at the
  mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

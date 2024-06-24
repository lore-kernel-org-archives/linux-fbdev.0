Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955161FF5;
	Mon, 24 Jun 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235018; cv=none; b=iFszls0j/OfkjqVK/aflpHP20A1uvnhBpgex0AwU8dURsnYJARKgtTtSZlPmYzD1DuUbWxb+qKqPGYRVfJcCm6o16iUc7u6TUgNssuf300QpbbzntTqmDN9SRLliokmMpJBaPimaorRmeGRX6SA4A2yEKNOU9UrwwhglysjYgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235018; c=relaxed/simple;
	bh=j3tSMrNeaGr/GDA1b1OfEDf0WMzQpAsWSoGQg7nQuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIjqszlsMiOGtbUulrORcwZafCDC9CkBlqUGvGYTszSIU4MdRHSlCGSUMpw03n1Sph7zP+LrnL4hmYDvLhkCb27CphLVblmtMA9EwXrGjHl0EzIkcSW0hCAiNPQvXySWPsHDM+RDv3IZg15qoQVvB2sENd/me2kUW2yWfrfXyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UVNZPOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UVNZPOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD099C2BBFC;
	Mon, 24 Jun 2024 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719235018;
	bh=j3tSMrNeaGr/GDA1b1OfEDf0WMzQpAsWSoGQg7nQuP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0UVNZPOCgNL3Z2mOu+qR47HGLZKP0+08/YM6rEFZ3lEL0EEFSSXSiOmO1UXek/4/F
	 qhC+gyxQn9Sr56P1iJ153yCcOyJSx9MRilZ5mN7bHYbzt0Psr0pG2bwhu7vV2+6qyj
	 FAphyBwKfczxSMMotk9p0+Zm4Kq/SoAt9fDW/XpU=
Date: Mon, 24 Jun 2024 15:16:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shiva Kiran K <shiva_kr@riseup.net>
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Remove unnecessary parentheses
Message-ID: <2024062443-udder-spotted-cc0d@gregkh>
References: <20240617142746.51885-2-shiva_kr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617142746.51885-2-shiva_kr@riseup.net>

On Mon, Jun 17, 2024 at 07:57:47PM +0530, Shiva Kiran K wrote:
> Remove unnecessary parentheses in `if` statements.
> Reported by checkpatch.pl
> 
> Signed-off-by: Shiva Kiran K <shiva_kr@riseup.net>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 2 +-
>  drivers/staging/fbtft/fb_ra8875.c  | 2 +-
>  drivers/staging/fbtft/fbtft-bus.c  | 2 +-
>  drivers/staging/fbtft/fbtft-core.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
> index 0be7c2d51..409b54cc5 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
>  	devcode = read_devicecode(par);
>  	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code: 0x%04X\n",
>  		      devcode);
> -	if ((devcode != 0x0000) && (devcode != 0x9320))
> +	if (devcode != 0x0000 && devcode != 0x9320)
>  		dev_warn(par->info->device,
>  			 "Unrecognized Device code: 0x%04X (expected 0x9320)\n",
>  			devcode);
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
> index 398bdbf53..ce305a0be 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -50,7 +50,7 @@ static int init_display(struct fbtft_par *par)
>  
>  	par->fbtftops.reset(par);
>  
> -	if ((par->info->var.xres == 320) && (par->info->var.yres == 240)) {
> +	if (par->info->var.xres == 320 && par->info->var.yres == 240) {
>  		/* PLL clock frequency */
>  		write_reg(par, 0x88, 0x0A);
>  		write_reg(par, 0x89, 0x02);
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 3d422bc11..ab903c938 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -85,7 +85,7 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  	if (len <= 0)
>  		return;
>  
> -	if (par->spi && (par->spi->bits_per_word == 8)) {
> +	if (par->spi && par->spi->bits_per_word == 8) {
>  		/* we're emulating 9-bit, pad start of buffer with no-ops
>  		 * (assuming here that zero is a no-op)
>  		 */
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index c8d52c63d..64babfe3a 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -666,7 +666,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  		txbuflen = 0;
>  
>  #ifdef __LITTLE_ENDIAN
> -	if ((!txbuflen) && (bpp > 8))
> +	if (!txbuflen && bpp > 8)
>  		txbuflen = PAGE_SIZE; /* need buffer for byteswapping */
>  #endif
>  
> -- 
> 2.45.2
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

- You sent a patch that has been sent multiple times in the past few
  days, and is identical to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

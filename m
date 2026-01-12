Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A62F3614;
	Mon, 12 Jan 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215237; cv=none; b=CRBWnXIvgDnW7Qo1/B07NxWfq7JzPJCdE0kZwKw5iITBm+z7KgXDTpNEZliKOIM9aoNyWpDaU6qvreZPQqWZ5cGiqJ7ungqT1j0NLBB/lWZEnaN2qNnFjAXtEjFi8o81pymjqoBBkzVRDXlc1G5y9JaDqqVEhhJhO4SNntcmdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215237; c=relaxed/simple;
	bh=TyGdFXl/GR1UCdAVTvqe+qyq1JYY9Pxkv8vNI0Gd1Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV2zdTzHp+uZ75XBfGu22LmgAPFKX48TacSHSkELFsP+GXFslDm3SJxVaYe1w3ShXE1qG06MgANopEbUii4bTWnAFakXMXNTzkhkrEvQiBPHeZIZeRT3+G87Yz9hZkBSKprqdAQAIW9ucw1vdhADxT5EgJHBCqakCMIA9vva3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oXaDc7S2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oXaDc7S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBFC19421;
	Mon, 12 Jan 2026 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768215236;
	bh=TyGdFXl/GR1UCdAVTvqe+qyq1JYY9Pxkv8vNI0Gd1Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXaDc7S2SYWgWE56VSiRut+EwphuhGFloBzRqyEe0m/oSqZRmenD4fc5/njmT4kqj
	 HSkOagZJD5Y8wQoHgTjqDqz3e8+go35fckO5OoP0gqWzboRewcHFa1Rv0eqMEIA2wJ
	 yf1q2IHOrbZfIq1vXhLrDCBAJ3VIlZavHzFpKDn4=
Date: Mon, 12 Jan 2026 11:49:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karthikey Kadati <karthikey3608@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: Convert sw_i2c_read_sda to return
 bool
Message-ID: <2026011205-radiator-coastal-db46@gregkh>
References: <20260112103838.22890-1-karthikey3608@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112103838.22890-1-karthikey3608@gmail.com>

On Mon, Jan 12, 2026 at 04:08:38PM +0530, Karthikey Kadati wrote:
> The sw_i2c_read_sda function currently returns unsigned char (1 or 0).
> 
> Standardize it to return bool (true or false) to match kernel standards.
> 
> Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2..9d48673d3 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
>   *  Return Value:
>   *      The SDA data bit sent by the Slave
>   */
> -static unsigned char sw_i2c_read_sda(void)
> +static bool sw_i2c_read_sda(void)
>  {
>  	unsigned long gpio_dir;
>  	unsigned long gpio_data;
> @@ -196,9 +196,9 @@ static unsigned char sw_i2c_read_sda(void)
>  	/* Now read the SDA line */
>  	gpio_data = peek32(sw_i2c_data_gpio_data_reg);
>  	if (gpio_data & (1 << sw_i2c_data_gpio))
> -		return 1;
> +		return true;
>  	else
> -		return 0;
> +		return false;
>  }
>  
>  /*
> -- 
> 2.43.0
> 
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

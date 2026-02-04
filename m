Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148919B5A3;
	Wed,  4 Feb 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210869; cv=none; b=ZVQDA9wMBmktIXkZiNp6O/6wEVi1PAQyO1csPO+xV3VaDU1IlgorG5c9VKMWzlmEya0ZRsTmDDunxkfzgCDvaJjHgkKoXSLnGc/L1Q0AhhC1SutDUvFc3zgizya0uqbpacQkux/hbZDjWEFQAJXAZod0WG9kr+s4cr5i9n3jX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210869; c=relaxed/simple;
	bh=ffcmAPQZo7uzBQT3kAXCcjTJAkFLQXZxnUkW8zdRS8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlRWj+3Vf0Buj8qAuWJjvB3eMJ3HAqwDABta1arAT0xTEvp0DmQihXsr1DVQD6LQc4ViqpwEpU4X8t6MI7lqlGztIrZxv9EwZNcVhCMJlPpHxpb1yqAEauscfDCbvv9T1LJVlkSgx97Y7cMKaGqLi/01A43jrQazs7p1pd5ZyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjkIEEYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjkIEEYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AEAC16AAE;
	Wed,  4 Feb 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770210868;
	bh=ffcmAPQZo7uzBQT3kAXCcjTJAkFLQXZxnUkW8zdRS8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjkIEEYz8SoeJow3y9gnoKu0HSNRkqDN4n3rDuLwyl3zuZsEF6CFFXkeCsp/LJ0Il
	 m+IIHEFjC1QKIxNtoF1L0igud4Hsp3Drjd5yDqFZNPh1iucCFzgh5E0cYskC7J1CWF
	 9j8TIGfSGc+lzS0iGM78f/I8Vee7KdafrtNdgnx4=
Date: Wed, 4 Feb 2026 14:14:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove unnecessary parentheses in
 ddk750_swi2c.c
Message-ID: <2026020416-talon-mousiness-1b08@gregkh>
References: <20260204125525.5498-1-zeeshanahmad022019@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204125525.5498-1-zeeshanahmad022019@gmail.com>

On Wed, Feb 04, 2026 at 05:55:25PM +0500, Zeeshan Ahmad wrote:
> Checkpatch reported "Unnecessary parentheses around 'clk_gpio > 31'"
> and 'data_gpio > 31'.
> 
> Remove the extra parentheses to clean up the code and satisfy the
> coding style guidelines.
> 
> Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..50e51d730d86 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
>  	 * Return 0 if the GPIO pins to be used is out of range. The
>  	 * range is only from [0..63]
>  	 */
> -	if ((clk_gpio > 31) || (data_gpio > 31))
> +	if (clk_gpio > 31 || data_gpio > 31)

Now I have to remember which is a higher priority in C, > or ||

Please don't make changes like this, I thought checkpatch turned these
off for staging code, as I keep complaining about it on a weekly (or
more than that) basis :(

If you look at the mailing list, I think I just complained about this a
few hours before you sent this change as well...

thanks,

greg k-h

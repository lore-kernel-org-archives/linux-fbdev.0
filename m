Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095F44374;
	Sun, 22 Sep 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727042391; cv=none; b=Drfb19CLj75dHF+VQzkb+YS5Fkr1uYMhNFgtk0afUWRnVpo7yQ8twUn6V5/WsxUwWogzR8y/pKijAvJ7OWNV52JU9cESlpNrCY5p0yIU2zyFyUuDsykDlWRZEGefLWsL0VcWePbZKeA+C5NYdI0oboBhCP6Ru4FYom2/yXe3tLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727042391; c=relaxed/simple;
	bh=pq5A2NDoeOt1YXcP9ftj1k+uxY8bnjvyqYKT6Ye6ov4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0GwdLuDttLWKCEHYF205tIz1WiYHWzaD//T34JxCW6/mug6KjOad/etnvilnAnVg6RkF8aW14BFWcz8JKEmzoLsJVbIaqIU5NRHLeEUXXo+5D5EYCdIrsLTxJMgIPO6W4z/5bLGq4jcGOvXj6RofKz3xB9cVKpAAzIko5LcZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCmkTmTM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krBTyNcL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCmkTmTM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krBTyNcL"
Date: Sun, 22 Sep 2024 23:59:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727042381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8CzBtSpmKY0LITH8CnwZJd9nllEbE1TmmkKW21npGE=;
	b=FCmkTmTMnJphEXNgPa0rAUar1zqXJXb/qg/w+BBklSYP5CIx5ISc0634MFHeSV4NVyb9gO
	JuPvPMEmvtZlya29Ugo1AHp5wjowBslJalGqGB+lE5hxCHHHpz/a7k7yqyTqQKkCS+sTFN
	avI+vuPjp38GnmS1ZoQmbcwCpKZZlxxDK4DAwZovd6WvCu28WP7sMxxgHNyZEY+0wUlRIm
	sF+QKR1FCTkIRyRlqfIt9WPyqLqmTmfwvhYtpIHK0c6Z03faFrSD3IKPHT5n3ZF0dSqNGJ
	jhWXSIRhChe5i6wiw1uzyMA1P3ZmRGKgVarFFKYQkoWLLErO3A7o0JFQWesDkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727042381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8CzBtSpmKY0LITH8CnwZJd9nllEbE1TmmkKW21npGE=;
	b=krBTyNcLkt7xieiSiS4soCD9ln6A6nCjQuYL2IZyhi3e5/0oNflcMyIZQLFQAK31fZYOMe
	MT9twMOwBDondnDw==
From: Nam Cao <namcao@linutronix.de>
To: Fabio <joakobar2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: fbtft: Changed calls to udelays() functions for
 usleep_range()
Message-ID: <20240922215914.uK2pDGCw@linutronix.de>
References: <20240922121213.4260-1-joakobar2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922121213.4260-1-joakobar2000@gmail.com>

On Sun, Sep 22, 2024 at 09:12:13AM -0300, Fabio wrote:
> Replaced two lines of calling  udelays by usleep_range() functions, adding
> more efficiency due to the need of long-lasting delays of more than 10us.
> 
> Signed-off-by: Fabio Bareiro <joakobar2000@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ra8875.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
> index 0ab1de6647d0..edd467c6bf1a 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  	}
>  	len--;
>  
> -	udelay(100);
> +	usleep_range(100, 150);
>  
>  	if (len) {
>  		buf = (u8 *)par->buf;
> @@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  
>  	/* restore user spi-speed */
>  	par->fbtftops.write = fbtft_write_spi;
> -	udelay(100);
> +	usleep_range(100, 150);
>  }

Are you sure that these changes are safe to make? If this write_reg8_bus8()
function is ever called in atomic context, this patch would break the
driver.

Unless it can be verified with hardware, I wouldn't make this kind of
changes.

Best regards,
Nam

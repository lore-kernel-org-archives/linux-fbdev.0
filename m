Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97582212FAD;
	Wed, 28 May 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463935; cv=none; b=U4uZ42vK7b0jam9JnFwPywFjjoQTYnnFxqNxiBiZRNe3Y6VrJsQbMq8NCEf/m7coBHyZVATIUA7muMRD5q+xJg1O9tGuDoa/vdbRp693dCIrnT8tTrJY7bw+hqh3NhYzeY+vJBj6O8Ss0SMNLVYJNAO3jhQzASJ4HyE5aFVgRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463935; c=relaxed/simple;
	bh=R8AjUu7sGxQQEaA5M26S3qZOPeUe7gB6plxu/BKRFME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm7fYjBGelUlQqjYwMAVuA09ysOXxfVEv3jqeeseYHuEun2SVZBqi6ESvxXNzUSeVmishkV0v+vbzs2JfwPMtMvkCADRTO/fwUchh0Z5TBns3IvvkkGp8OaJ5KuPFuYbfonDS7AUUUO6W9mh7sed/YFHCdtDHmCAOcUt4m4kau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HE/Xy65E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kVe8VJqg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HE/Xy65E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVe8VJqg"
Date: Wed, 28 May 2025 22:25:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748463926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjiMb4Q5y6Y1U24/A6lsu0hJaeOxplBCKBHXs1GFG/Y=;
	b=HE/Xy65ETPofJeCefcInmuueE1keY3WIh68k1jLkA2BIGad41C1sD91fp+/dkEcFO082HL
	61eAiOtxxz/pNhjPfQZYqvI/IQ6t8rJGziemzjJa4MlAMSkCNFBWBnkDHZtzn2tysrKTH0
	nFXz0VeteUaMmmy9S+FuehfYXCng3NurkzaszKw01gqfSFd5mje4qvNakNAUcWz2l5pnmG
	jFDayaNSBJPxWvZUT45RzjxOjOOsju4NS22Gp09UZ/igRvCbFZI9VqpPmWVNNAw5En6bGU
	vqfX3di5SXkGBf6LRfAS1ldBFqqT+SpoDql2Y+We5eJjgxxjmz3Xx99UiLF8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748463926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjiMb4Q5y6Y1U24/A6lsu0hJaeOxplBCKBHXs1GFG/Y=;
	b=kVe8VJqgmGMGy5sJq1ljbME2bF5bZhgirE2rR0i2XG7dO3meoX4TyAtch3qqVZer/RYCtr
	JtFOV0DFeRmC4vBQ==
From: Nam Cao <namcao@linutronix.de>
To: Bram Vlerick <bram.vlerick@openpixelsystems.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: add invert display parameter
Message-ID: <20250528202518.Kq5YuwFq@linutronix.de>
References: <20250528-ili9341-invert-dtb-v1-1-080202809332@openpixelsystems.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-ili9341-invert-dtb-v1-1-080202809332@openpixelsystems.org>

On Wed, May 28, 2025 at 05:42:30PM +0200, Bram Vlerick wrote:
> Add devicetree parameter to enable or disable the invert feature of the
> ili9341 display

Can't/shouldn't this be done by userspace application? Why would someone
want to invert the color by default.

Also, this driver is built on top of the deprecated framebuffer, it will
never get out of staging/. For new feature, you probably want to send it to
drivers/gpu/drm/panel/panel-ilitek-ili9341.c instead.

> Signed-off-by: Bram Vlerick <bram.vlerick@openpixelsystems.org>
> ---
>  drivers/staging/fbtft/fb_ili9341.c | 3 +++
>  drivers/staging/fbtft/fbtft-core.c | 2 ++
>  drivers/staging/fbtft/fbtft.h      | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
> index 47e72b87d76d996111aaadcf5e56dfdfc1c331ab..a184f57df12b5ad6612a2e83b664a8911c7c79be 100644
> --- a/drivers/staging/fbtft/fb_ili9341.c
> +++ b/drivers/staging/fbtft/fb_ili9341.c
> @@ -103,6 +103,9 @@ static int set_var(struct fbtft_par *par)
>  		break;
>  	}
>  
> +	if (par->invert)
> +		write_reg(par, 0x21);

Use MIPI_DCS_ENTER_INVERT_MODE instead of the magic number.

Best regards,
Nam

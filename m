Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39527A927;
	Wed, 25 Feb 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054088; cv=none; b=S3zHg7eN7LhT95fCyjd4wM1i9xqvXNctfUSpNPX0xdtB1LsbKtnhdZmEjqq/MU95FPZIlUgu/z98Kwlql/EwWxA/q7hmAqAW81O/IVg9FWHgfNx5gdgwlPMOxix1qqlGTNLj+A7ORr/Z5lVdtUjQErimoXpJXsl9RSvlE5rUyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054088; c=relaxed/simple;
	bh=PUoBZVgfuwFx/d9hsCkTUcluzbN4CiHzlV8C9lWXu1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3wvQvVWmL6VUJKRnzJNxgv1wvSCN5bBbU4DZqRJarVrVVRgosENl+ITRgIQGV3GnbGTQIRlBZ3mJiNkPfJrQjQ0WiGANI2uN/VN2cnsT2BGzGi9/h9msKzxfY2FlfNUxGF3KDJKjpy0iudri+nE10qH9umvzPum6onVeNx/ENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1ZyKoG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1ZyKoG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DABC116D0;
	Wed, 25 Feb 2026 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772054087;
	bh=PUoBZVgfuwFx/d9hsCkTUcluzbN4CiHzlV8C9lWXu1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1ZyKoG5P97u1DEn8HjWISR327pAe6dbNOyMmxdDcZZ3OauV2tNI2cINNUsgbe3/b
	 u7GInQWsBDRA2r4oZ+hHATSz4jg6GSHRyiCNzloECy0L0kwmxnfuAb7tNdl9+epLeN
	 mdMuhIlA+tBZFoR2b3J2CZLFhv5Vks00PIjKJqlA=
Date: Wed, 25 Feb 2026 13:14:38 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelays with
 usleep_range
Message-ID: <2026022515-booth-silent-f3bd@gregkh>
References: <20260225204602.134218-1-azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225204602.134218-1-azpijr@gmail.com>

On Wed, Feb 25, 2026 at 09:45:59PM +0100, Jose A. Perez de Azpillaga wrote:
> The write_reg8_bus8 function uses udelay(100) twice to wait for the
> display controller. For delays of this duration in non-atomic context,
> usleep_range() is preferred as it avoids busy-waiting.
> 
> Update both instances to use usleep_range(100, 120), allowing the
> scheduler to utilize the CPU during these wait periods.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ra8875.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
> index 0ab1de6647d0..6058934e2ca2 100644
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
> @@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  
>  	/* restore user spi-speed */
>  	par->fbtftops.write = fbtft_write_spi;
> -	udelay(100);
> +	usleep_range(100, 120);
>  }
>  
>  static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
> -- 
> 2.53.0
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

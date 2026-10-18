Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13F44F54D;
	Sun, 18 Oct 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317265; cv=none; b=D8sf8PoqIVah4BbjJrOkm8z/S6o1YqzDEDz61afm7dBmYRMzpu2dsyaSK1f8o/GtWe0XOKXdwfRf3JjJ7rdkyN0bW7ZEj/HGGG4Z0rs/o5lTtcSe1T4IuljMJH9ttLsNkHs9NyHe71vvOQDsFDYyBaQ4pyMGk3Kb2il8UXVBKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317265; c=relaxed/simple;
	bh=MLqth/e4rFIpzkL5FHtE8+XIOJfrTyehN/j8uYysZCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auzOROtGEPK2NbrN6Awl/TopOjdMjOaXtdAStNoVQDNIAIJTlGHhcozZCKnvVBbUxJI+5gJ5Rcqdylo6xwWWYK5m8L0L6osYDWij+cCvfJH8aNYe3ga3kbUhprKXmLXoImJ6XZ++7cNkfTqFEwkOOussjnl8+7lnPUqI2HhI3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lGcUpKDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lGcUpKDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D921F000C4;
	Sun, 18 Oct 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792317263;
	bh=RkARDx2vR9X8J4PDODQDscQy36I3hS0rn3lmtQ3+4Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGcUpKDRDTRLK3tPkJPtntkv4AHO5huGNvl8Wfv60RmU1/FoW/D2F8IZ6q6U2V7ya
	 07+3UpN7SiAGxFc5X5hRMLgVjrLrj4j4GUvEbMJ+05sHz/Vn853xl3zOxbzrpGLxd6
	 EO8axFUbGdJKFxv0lRGgfEL9N76VtFrpgqwLdz6A=
Date: Sun, 18 Oct 2026 11:54:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wrmfwv@163.com
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gtl-m <admin@micronull.cn>
Subject: Re: [PATCH] staging: fbtft: fix syntax errors in macros
Message-ID: <2026101807-trapped-removing-5494@gregkh>
References: <20261018085345.17619-1-wrmfwv@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018085345.17619-1-wrmfwv@163.com>

On Sun, Oct 18, 2026 at 04:53:45PM +0800, wrmfwv@163.com wrote:
> From: gtl-m <admin@micronull.cn>
> 
> checkpatch.pl reported errors regarding unnecessary commas and spaces
> before closing parentheses in the fbtft_write_reg macro definitions.
> Remove them to strictly comply with the kernel coding style guidelines.
> 
> Signed-off-by: gtl-m <admin@micronull.cn>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 30e436ff19e4..409770891c54 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.25.1
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65205383C81;
	Mon, 20 Apr 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677361; cv=none; b=BYw+n/+zuKsaNNFcHtj579jxQJa5nVh4XjY2rhUD3KeWJh5tl2PV5waJqDOfBhMG0zxulZ/XksxSVHWM92p2Q37Bw1duYefDyh6y0xky7ubr4yY7rJsfFlyN7mi54iBn61+t6uM9bpuqbr6SvJh7vJnd4kSJwP6AItiV/SYW0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677361; c=relaxed/simple;
	bh=2BfDlA6VY39y9tYQjOaTN6uHaUdWSfjiCwLjUz39juk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffWIJ0b0M1UsZq+3/r1iiQAVF7wobZAQzTSTuCn6gPOsXvqW6wvfkltsg7NWOoM5F2wjn9l3UY1GManIf32mJGlM7fjFlbcyiIoQjIYL01+E3nqiVXyUNk74bssdbT0hksneI8gZBmfy4WQVmjiSWNg9RBcAKxLvZzEJuB86IcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfqlAkhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfqlAkhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817DC19425;
	Mon, 20 Apr 2026 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776677361;
	bh=2BfDlA6VY39y9tYQjOaTN6uHaUdWSfjiCwLjUz39juk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfqlAkhRfz+KuAPhk5XXEvXxALNIoU9QbEQ2Jlf5L89nehJ1rQTz6snbHojbQbOS1
	 m5zqrzViNaKqUIwreAEsPNFC76T/YSlS1jQLRjrwdSELsgFSwYuaIs2zq8vRf75Azu
	 nAd7ro5VOj/qgJeixv0q1lOmT7KQUXNrQu11jwes=
Date: Mon, 20 Apr 2026 11:29:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baker <mzndmzn@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with
 identity converter
Message-ID: <2026042004-unblock-giblet-cbbc@gregkh>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412173317.3329-2-mzndmzn@gmail.com>

On Sun, Apr 12, 2026 at 12:33:17PM -0500, Baker wrote:
> The define_fbtft_write_reg macro calls 'modifier' as a function.
> Passing an empty token as modifier is undefined behavior in C for
> fixed-arity macros. Introduce fbtft_no_conv() as an identity
> function to replace the empty args in the no-conversion cases.
> 
> Signed-off-by: Baker <mzndmzn@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 30e436ff19e4..7f3fd30576ab 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -11,6 +11,8 @@
>   *
>   *****************************************************************************/
>  
> +#define fbtft_no_conv(x) (x)
> +
>  #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
>  void func(struct fbtft_par *par, int len, ...)                                \
>  {                                                                             \
> @@ -62,9 +64,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_no_conv)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_no_conv)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.47.3
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

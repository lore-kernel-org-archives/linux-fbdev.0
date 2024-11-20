Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871871A0AE9;
	Wed, 20 Nov 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104954; cv=none; b=jLDa7Uf/L0qGqJLeM1KyhTOzqtU330ToFkEhQeeSziOfxkNUyGXoU8VIHS/5H6EYl/Hf4zn18tMMP/JdBjvYIqzaWwfqnv/iakZ/scGG62dezd/91Lrr7LtE0CocaPAyKjNes6hUBIG8OXNbCzFPS+CEZfPkWTCNYOmv9iXX0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104954; c=relaxed/simple;
	bh=kVXKB5aLoD57P+eLktbLKXC4YFrRi7R7r32NgHrZYqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEA5yvhs4b0vvq3N59aQJ8/L4f6uQ7VSB/NuHR15cK1ZARHcRFqZf12CyHuRipXwbM1GksSwuNtnH7PJlQf7FF7AcO11KBLiZaOOSILFS/R56W7if3xqexPGqXpDdxAYWw+w8uahTXmKevse7S+2lOkINlRiGk3N5sheyGOUKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKQAb2m8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKQAb2m8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF7CC4CED1;
	Wed, 20 Nov 2024 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732104954;
	bh=kVXKB5aLoD57P+eLktbLKXC4YFrRi7R7r32NgHrZYqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKQAb2m87FdNFePvB39KeNKxRgG2lwz0yqq0rI0dHnDbBeE6d+s/mLOu8b5t3PLrc
	 6ExsD7qPRLBElbtoLZ8skKROX/nx/FWiqDQiPpojJ1kUMjXLzutmxHZaYKRKoHx03Y
	 XvqvNTopAsw8Ye6lbg9cJd0NcF1ssYMlX6OjvN60=
Date: Wed, 20 Nov 2024 13:15:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Perego <pperego@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: Re: [PATCH 1/1] Remove hard-coded strings by using the helper
 functions str_true_false()
Message-ID: <2024112010-occupancy-viper-7c80@gregkh>
References: <20241120093020.6409-1-pperego@suse.de>
 <20241120093020.6409-2-pperego@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120093020.6409-2-pperego@suse.de>

On Wed, Nov 20, 2024 at 10:30:20AM +0100, Paolo Perego wrote:
> Signed-off-by: Paolo Perego <pperego@suse.de>
> ---
>  drivers/staging/fbtft/fb_ssd1351.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
> index f6db2933ebba..6736b09b2f45 100644
> --- a/drivers/staging/fbtft/fb_ssd1351.c
> +++ b/drivers/staging/fbtft/fb_ssd1351.c
> @@ -6,6 +6,7 @@
>  #include <linux/init.h>
>  #include <linux/spi/spi.h>
>  #include <linux/delay.h>
> +#include <linux/string_choices.h>
>  
>  #include "fbtft.h"
>  
> @@ -162,7 +163,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
>  static int blank(struct fbtft_par *par, bool on)
>  {
>  	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
> -		      __func__, on ? "true" : "false");
> +		      __func__, str_true_false(on));
>  	if (on)
>  		write_reg(par, 0xAE);
>  	else
> -- 
> 2.47.0
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

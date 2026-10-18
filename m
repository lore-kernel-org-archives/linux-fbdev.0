Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEE4C1506;
	Sun, 18 Oct 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330267; cv=none; b=qKDVT9XwpJvdKbMAzseGcJteIpbzEbN5caW5Ej49h0TsbHzikYUyvcraf4sR/90QOeoS2Hx2zaTqf1K+09UVt7GBw+WYTIR/+WvbaGOTLhHqG5EuAZfk//J9ZBwj/A7cP1bJG1arsPCKtm+aT4rzbUKUs2tZJI/f4ZsJ5zhXEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330267; c=relaxed/simple;
	bh=KDZ+hyu6xuc/u17NzDeqMFngPZi/RlfYyQiHaBPdLzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiPsCcL/puGyEBEkpDYCn/CPHO1oFYeYpc9kM5WygogyRfA9oUqB7RJ45D6XvWQRqlYkagWiaubbDVbrxmvXXvX3+ob8npf1OnP6yI7WY5+h3+x4UtfGUv7Ix76ins/udNinM5GElwKxWKR12OId3YdQqKVqODjGrdH72BIYPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KliaDxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0KliaDxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750721F000C6;
	Sun, 18 Oct 2026 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792330266;
	bh=NxusC2ZkrRWNZg9kKmWEMlTgz182myS5LwkDwojrAfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0KliaDxRdXf8rn0xkZtximAv2Z5u780620LtuBd/6LseJzUguoPNPL6SL4Cy+BoWb
	 3if977qMG1Kx15HmC1qhnVKIKsRjrpnE/FDMVK0Uvzp4ynQb7uQ4nCqPIrv4VofBfS
	 nrrs4RvW6rWJZNX2XNEVlLo/cRi4kq1SOa/k4bZY=
Date: Sun, 18 Oct 2026 15:31:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
Message-ID: <2026101834-gizzard-evaluator-3c7a@gregkh>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>

On Sun, Oct 18, 2026 at 08:34:30AM -0400, Bashirah Lawal wrote:
> Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);


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


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

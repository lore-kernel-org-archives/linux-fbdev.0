Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD234DCDF;
	Wed, 28 Jan 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594283; cv=none; b=Depn4ztZKjNh40k96FCVQAn20Lgn2YFv2Bm3NXHxk6sFCbmeCJU4RnhFyKaW3kq6DTJXkSTySx26hfta+LK2AI8A5AbfOhnyjl7RJtboLsk7iTHHNypk2zzwWHVRVm+iIy/CRqvFJKcMX+L6M4GLcyuRTSWvhL6qboWIp1AILAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594283; c=relaxed/simple;
	bh=YBdgatfNyvQhHZDYc3SLYJhJFWnV+4AmYDAZ9R067f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQnDAuDRj+jzQZnKqph9waJ/wwZIs6bsSCQDYsP6vuXCBFSVeOgjo7QoicODWkpNriRFzoNx05/d57feCu2KP0YXYhrxApW4UZ+Tyt7Es42YyJIkNP93jbOJlM7yzhXeKJn5iQ9We6HjH627AAjjiyrECkgodfND+KTG68WvtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKJA6wDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKJA6wDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E4C4CEF1;
	Wed, 28 Jan 2026 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769594283;
	bh=YBdgatfNyvQhHZDYc3SLYJhJFWnV+4AmYDAZ9R067f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKJA6wDs9vz9vyZg71u4IZJXbFvoGHhlNqdyFzZGHCj4EPVxvrQWCGJQaPAAzcZsv
	 gRDi2943eMzb3QASx9oTs89KlmEGe9sTkaGy1iN8PhKnCcll6fD2cnM55q5R26l6AB
	 PlrBIP/ip5Ym3c5RTAtBv+EMA3bUlpcFiKDhWYz4=
Date: Wed, 28 Jan 2026 10:57:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Waffle0823 <csshin9928@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Improve damage_range to mark only changed rows
Message-ID: <2026012844-muster-lushness-def4@gregkh>
References: <20260128092210.864021-1-csshin9928@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128092210.864021-1-csshin9928@gmail.com>

On Wed, Jan 28, 2026 at 06:22:10PM +0900, Waffle0823 wrote:
> Instead of marking the entire display as dirty, calculate
> start_row and end_row based on off/len and mark only those rows.
> This improves performance for partial framebuffer updates.
> 
> Signed-off-by: Waffle0823 <csshin9928@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 8a5ccc8ae0a1..0fbdfdaaa94d 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -415,8 +415,11 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>  {
>  	struct fbtft_par *par = info->par;
>  
> -	/* TODO: only mark changed area update all for now */
> -	par->fbtftops.mkdirty(info, -1, 0);
> +	__u32 width = info->var.xres;
> +	__u32 start_row = off / width;
> +	__u32 end_row = (off + len - 1) / width;
> +
> +	par->fbtftops.mkdirty(info, start_row, end_row);
>  }
>  
>  static void fbtft_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
> -- 
> 2.52.0
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

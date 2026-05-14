Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C90387341;
	Thu, 14 May 2026 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755488; cv=none; b=hDyq9SX30EkwfVZB8cHbxj/n+c7t1bITT8PzD+8DchBG5X/GJLFEnw76dHOyYJA4srnWYC3eZKi7JTh4Vd5peUe92Nnr8OviIl7Iat5gNlrZwHPEiehmj4iW6HoVJ6HCyEBgLcAvJRPjdv+u8tOq+fi1cgPKUTg5f7KRdl5qpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755488; c=relaxed/simple;
	bh=avOfwKt2LMJVLn3RbLY7rvDIvc+6Q3HeKRHXucyZRVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVyjqwPWcEwWVmtoYQviziVr3k1ZgqnMsdF5qTNMN5xYRorI2FvJPWiHLIyEzLuTdx3yplbAyqjm5saDK6eSZGb50wHnxUvPDrH+98La5xogOEXjPp3mWijMVJniazl1iQh0en3UCH7IscFyEEFSJHFjlvZIyPHZrRuRFY00mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q1q8VVP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q1q8VVP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1DCC2BCB3;
	Thu, 14 May 2026 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778755488;
	bh=avOfwKt2LMJVLn3RbLY7rvDIvc+6Q3HeKRHXucyZRVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1q8VVP46kmGo9DRi2FU2+4vRsyK3WnP66507VLyl2vmT02eERVZyMJyGm1IhcasE
	 PuE93nNs6kfO+niTPJ7LB5RjpiRZK6W80E/FRUz0S5xUuFKBNQsaYRQI+WSZYaOytR
	 uEThlHP6BtepMDw5E3nXRQL37/aaAnCrcW4FLl6c=
Date: Thu, 14 May 2026 12:44:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add suspend checks to copyarea and
 imageblit
Message-ID: <2026051432-glider-lavish-71fc@gregkh>
References: <20260514103042.55313-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514103042.55313-1-yogeshdangal66@gmail.com>

On Thu, May 14, 2026 at 04:15:42PM +0545, Chhabilal Dangal wrote:
> lynxfb_ops_fillrect() already checks info->state before accessing
> the hardware 2D engine, but lynxfb_ops_copyarea() and
> lynxfb_ops_imageblit() do not.
> 
> The suspend path calls fb_set_suspend(), which sets the framebuffer
> state to FBINFO_STATE_SUSPENDED. Add matching state checks in the
> remaining accelerated callbacks for consistency with fillrect().
> 
> This patch was developed with AI assistance and is compile-tested only.
> ---
>  drivers/staging/sm750fb/sm750.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e..025ac8fe3 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -204,6 +204,9 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  	struct sm750_dev *sm750_dev;
>  	unsigned int base, pitch, bpp;
>  
> +	if (info->state != FBINFO_STATE_RUNNING)
> +		return;
> +
>  	par = info->par;
>  	sm750_dev = par->dev;
>  
> @@ -239,6 +242,9 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
>  	struct lynxfb_par *par;
>  	struct sm750_dev *sm750_dev;
>  
> +	if (info->state != FBINFO_STATE_RUNNING)
> +		return;
> +
>  	par = info->par;
>  	sm750_dev = par->dev;
>  	/*
> -- 
> 2.54.0
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

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

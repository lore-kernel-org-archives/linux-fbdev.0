Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D23E1D05;
	Tue, 31 Mar 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965015; cv=none; b=tf6lNjUHOb0OrqHDTc8P0wmjZI1/za4Ao/dZtU4dgiGtWyStRfn60KD4g/fhLFeR/3UiwWzZPKZDLSKkXDrW+3rQbhGTrH+8vlL1Oo+U3FFVh7TYw2do3GPRrZf6u0cSboPOr7euzTPwgZhoJS0wlGW60D9swowHx4Swq4LGGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965015; c=relaxed/simple;
	bh=srIVQYN/gf5lVSs+BLOc1DyORBLb5FgWob8Hu+J86u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwzUDlLbfhJXRMAUaUyQNHsEjivrBDcX0J9GEvYuZHIir38QvT6dBtyUPjOFjyAVwgINqgnCZSe6YAN3PGE5lg35UamI8mZC9lTtvz0s+bR8gs/t7jhK5S6T4htA5vY37fZhey7mTNUuHI6L3rfmW5BR28iMcrGENnS440FdQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PO8iFf1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PO8iFf1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1D4C19423;
	Tue, 31 Mar 2026 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774965014;
	bh=srIVQYN/gf5lVSs+BLOc1DyORBLb5FgWob8Hu+J86u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PO8iFf1rA16Rr/3BHLKNOBYRtEgV7tx8/oHYLxcuzsYCauMvxnghJH6vLibjS1zlz
	 XSEqWUhmqKiYheOhLDKw3CdY4dCDn9nLHDQzaeXYmIGhnE5KOnXMh9nvjrhkiYdc7F
	 wNzdKVNo7yrPgO83ufgoCO/p1WgLB5PvMBZqUD2E=
Date: Tue, 31 Mar 2026 15:50:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: constify fix_id array
Message-ID: <2026033157-comrade-silencer-a131@gregkh>
References: <20260331050738.1547-1-dennylin0707@gmail.com>
 <20260331134349.18998-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331134349.18998-1-dennylin0707@gmail.com>

On Tue, Mar 31, 2026 at 01:43:49PM +0000, Hungyu Lin wrote:
> Make the static fix_id array const-qualified so it can be placed
> in read-only memory.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 62f6e0cdf..795e9164b 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		"kernel HELPERS prepared vesa_modes",
>  	};
>  
> -	static const char *fix_id[2] = {
> +	static const char * const fix_id[2] = {
>  		"sm750_fb1", "sm750_fb2",
>  	};
>  
> -- 
> 2.34.1
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

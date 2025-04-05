Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271D15382E;
	Sat,  5 Apr 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743851192; cv=none; b=sOyAF1FZozeJqISnigGNtMAYk8KTAExsplp5yEoA2h9U2jJM0ICb/aJY7oqMPlfZYPpU93SSLXOe7IGUD6BUL3QvPXqUVeAU8o9HHuFTi+s1GOYZgypSVxi0ukX9sTQ6rmF97LM/mdYk26jGxGP7aL8NhzgfAKHtZyqS76B/WpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743851192; c=relaxed/simple;
	bh=NDoDqmj0nkSRARvUqq1PvqHAtQ7zZlocCC7l92vOIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhNpRgatgykVgtPvJImRSHR2tjpbZAacpX73S7hENwjDGF9V1Chtmuo7BTnIVgprzOhrhyuS2dyfO/As1lcFN/YBbJ+QHp8bngMxVZj1XQwYhRtlAc6i8QgYyDH9fpneEwRj11MZ6YIwbk5QBuaMd3GlkXBoosJSmrxIbnzt09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvmeP2GA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvmeP2GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD6C4CEE4;
	Sat,  5 Apr 2025 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743851191;
	bh=NDoDqmj0nkSRARvUqq1PvqHAtQ7zZlocCC7l92vOIIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vvmeP2GABShu5vj0Cn8wS2/yTXP8Q2iZHQSLzbLpJPCguQfmwNfVaIrWum4ODCxBe
	 b5VENOd4aV9nuhqQMoyb6SErLf7zJaWQ6vo2YeuFBP2qx2DN4uAS2Ao3vfAt76OlPD
	 c23eTkmjPivSJNwUkcuOdByq+ul758TOQjUAFozY=
Date: Sat, 5 Apr 2025 12:05:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	julia.lawall@inria.fr
Subject: Re: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to
 snake_case
Message-ID: <2025040550-alkalize-unproven-b99d@gregkh>
References: <67f10268.5d0a0220.18864.f8cf@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f10268.5d0a0220.18864.f8cf@mx.google.com>

On Sat, Apr 05, 2025 at 11:13:58AM +0100, Richard Akintola wrote:
> Change camelCase function name sii164GetDeviceID to sii164_get_device_id
> to conform to kernel code styles as reported by checkpatch.pl
> 
> CHECK: Avoid camelCase: <sii164GetDeviceID>
> 
> Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
>  drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
>  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index 8b81e8642f9e..3fb14eff2de1 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> @@ -16,7 +16,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
>  	{
>  		.init = sii164_init_chip,
>  		.get_vendor_id = sii164_get_vendor_id,
> -		.get_device_id = sii164GetDeviceID,
> +		.get_device_id = sii164_get_device_id,
>  #ifdef SII164_FULL_FUNCTIONS
>  		.reset_chip = sii164ResetChip,
>  		.get_chip_string = sii164GetChipString,
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index 2532b60245ac..223c181dc649 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -48,13 +48,13 @@ unsigned short sii164_get_vendor_id(void)
>  }
>  
>  /*
> - *  sii164GetDeviceID
> + *  sii164_get_device_id
>   *      This function gets the device ID of the DVI controller chip.
>   *
>   *  Output:
>   *      Device ID
>   */
> -unsigned short sii164GetDeviceID(void)
> +unsigned short sii164_get_device_id(void)
>  {
>  	unsigned short deviceID;
>  
> @@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
>  
>  	/* Check if SII164 Chip exists */
>  	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
> -	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
> +	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
>  		/*
>  		 *  Initialize SII164 controller chip.
>  		 */
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
> index 71a7c1cb42c4..a76091f6622b 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.h
> +++ b/drivers/staging/sm750fb/ddk750_sii164.h
> @@ -28,7 +28,7 @@ long sii164_init_chip(unsigned char edgeSelect,
>  		      unsigned char pllFilterValue);
>  
>  unsigned short sii164_get_vendor_id(void);
> -unsigned short sii164GetDeviceID(void);
> +unsigned short sii164_get_device_id(void);
>  
>  #ifdef SII164_FULL_FUNCTIONS
>  void sii164ResetChip(void);
> -- 
> 2.39.5
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

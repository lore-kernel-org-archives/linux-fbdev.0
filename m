Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75275223DFF;
	Tue, 12 May 2026 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566466; cv=none; b=T/73HMzIbJdM3K7B3ZRwPMDpPx4ST0DynKz4qwatZBdH3lbRofewR0nGVFAuq8ir+9tQtsyW5XoPYLGvRnx1ja8/9FVSGTmZuSFl8/OHgPSu4XyCzgmNSNdsgJxPWqFMJbcviVuU/iTrjJtpt3YfDW/13TS5mCHPJSsjW69dGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566466; c=relaxed/simple;
	bh=4s00vkLpxRQ8DRLw7NNMIEx1T+sD2+PJ3U8wsUFZBtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APAzG3SHmucEb47Kakatx8ymtsuC0OmZYgf+je6CQoUJyhYakQR71Nw91f+JvLtMyBs6S11dm+kSpKW1V3/BI1/F9in+8yXcfwPRKuzAhhDlAJnGvsfnlbvBluBlKHLtnQsGwRknq7hRIwXywR7sDf9Ufef2U2rjvSnemoATF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yb3+U1VZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yb3+U1VZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2F5C2BCB0;
	Tue, 12 May 2026 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778566465;
	bh=4s00vkLpxRQ8DRLw7NNMIEx1T+sD2+PJ3U8wsUFZBtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yb3+U1VZKj9al5H14UMNTVXT2XSa/8JJ78PntAun7FGoZuTcEj7CNi+DSJZgKqVH4
	 qpMPpPjD7Gn0HgoAbcwUluYq913hyGVJHkBUGaD9mGcuywtgQh78Ch9jE2Twgrcjp/
	 0mMFr2B0YeDVAU8Z/RTPhtDSdvhwMNCfRhvCiJbk=
Date: Tue, 12 May 2026 08:13:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: remove unused <asm/mtrr.h>
 include
Message-ID: <2026051229-chewy-slideshow-7095@gregkh>
References: <20260512061012.76252-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512061012.76252-1-yogeshdangal66@gmail.com>

On Tue, May 12, 2026 at 11:55:11AM +0545, Chhabilal Dangal wrote:
> sm750_hw.c includes <asm/mtrr.h> under CONFIG_MTRR but calls no
> mtrr_add() or mtrr_del() functions. The driver instead uses the
> architecture-independent arch_phys_wc_add/arch_phys_wc_del in sm750.c.
> 
> Remove the dead include.
> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index a2798d428663..f491d3aca468 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -13,10 +13,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
>  #include <linux/console.h>
> -#ifdef CONFIG_MTRR
> -#include <asm/mtrr.h>
> -#endif
> -#include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  
>  #include "sm750.h"
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

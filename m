Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777FE36E48B;
	Fri, 17 Apr 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407090; cv=none; b=e5HM8EmfWUltjSaU89pZROj+8vlMPZdDdKk+kciMFQAqYiy9G0Ou5GMUBgMAM5TqGcZhquOO9Wl9Xy7r/MWx5a/JcIrks2twYxySMuNqyBIY5c4u8XzzoZgxkf6aojxIA7GuBN8xUEtbBL8BDQfy2Z4r478w2V9RhOi7jsxEB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407090; c=relaxed/simple;
	bh=w9YZVmN4o9A4PhzzHubTS3D0Ox6bI3d2VBxxFZuFwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnZjNK/ANy2VHD4WvHxu7DFlQ65dS55p+t2KfiXJmZOIClN2FJqR8lq+Nzmp8kW0NiSmK+6w0wOFU99tD86JfLviC00JtU+d1bZtfpmjmCCwsw2RrAFFTszrv/T+xgCB5+kTP0tN4Nz5hZ2N/L1Q4WcscBQR93tIMNDAxXs/zgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o6eILmf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o6eILmf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC68C19425;
	Fri, 17 Apr 2026 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776407090;
	bh=w9YZVmN4o9A4PhzzHubTS3D0Ox6bI3d2VBxxFZuFwpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6eILmf4Qz7TgCWz0fv/vZF9XTCvH1d/408W0RZPo6Xr8PJZ/E9lCqvFoqRi/3r+E
	 rUfBM7CAxsIG7hXgXQBkXEUxaV7YZaHMDT7Un2fLihv28kwsU/eZu9WcSPp+jIK/k0
	 HJB+gKP68HvD9EA7+GwEJbHS/ASLLsnYGLju7POQ=
Date: Fri, 17 Apr 2026 08:24:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sachin Kumar <sachinkumar905846@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: clarify TODO comment in fbtft-core
Message-ID: <2026041707-climatic-sanded-8588@gregkh>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
 <20260416185438.273165-1-sachinkumar905846@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416185438.273165-1-sachinkumar905846@gmail.com>

On Fri, Apr 17, 2026 at 12:24:38AM +0530, Sachin Kumar wrote:
> Improve wording of a TODO comment to better describe the
> intended optimization. The comment now clearly states that
> only the changed display area should be updated instead of
> refreshing the entire screen.
> 
> Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index f427c0914..cff838955 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -414,7 +414,7 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>  {
>  	struct fbtft_par *par = info->par;
>  
> -	/* TODO: only mark changed area update all for now */
> +	/* TODO: update only changed area, not entire display */
>  	par->fbtftops.mkdirty(info, -1, 0);
>  }
>  
> -- 
> 2.43.0
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

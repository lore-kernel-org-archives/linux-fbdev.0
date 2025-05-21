Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98F1B4121;
	Wed, 21 May 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828045; cv=none; b=IgfzsG74Y7c9qA1JHhstQihq0orcaenJJKgUQknIcLuLHh7CKX04FaVeArB5g657eBhIa1CuEGHgaXdVhYIL1ucvOJYxPBqBu+fZC1RkvflBR5Y/Y+nEDpLw+8p61i935a7LCPAXjZWNKWfAfGVMQwr7soTQDrispyJK2BD4eRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828045; c=relaxed/simple;
	bh=5G04Xfr/Kzfqdh1BXarJNMA4XuLP6nfQz3H+cym9yXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI/FwFIub9giX1fWmHYT2H6IGo3GYXWGes3AJZDnuOWZz0WA4GUKIoLgV0e2XewRP9QSBCy9UId+2tbyKfaBVr5EM1AXV9y/FvECGCdCRKau21BqTOOKoASfT/d2XMz8eW9HPaOqenkmuJ9QkASJOnO/09wPwLUN5MnL2FF/iI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0ofAPH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0ofAPH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFE8C4CEE4;
	Wed, 21 May 2025 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747828044;
	bh=5G04Xfr/Kzfqdh1BXarJNMA4XuLP6nfQz3H+cym9yXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0ofAPH9L6eXj0DIV/GIgGJ552+D/csz3ckclq/g26Ppwrl0+OCKNlXdW8xo4qFFL
	 mciOHF7IUHBI9D7lnoC+F8XMxBp2sao6hpnVMZGA+AFsZh23tJnrZv1YvDCItzjhTA
	 iqgzZp4BQP/ssS+Plhk8AHbRGWrKqdPQV/syQvSE=
Date: Wed, 21 May 2025 13:47:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: rename dprBase to dpr_base
Message-ID: <2025052112-creole-brush-7038@gregkh>
References: <cover.1747605658.git.ericflorin@google.com>
 <d4b30e00ca64a233efc2a7dac4bc568186dafc71.1747605658.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b30e00ca64a233efc2a7dac4bc568186dafc71.1747605658.git.ericflorin@google.com>

On Sun, May 18, 2025 at 03:09:46PM -0700, Eric Florin wrote:
> Rename `dprBase` to `dpr_base` to conform with kernel style guidelines
> as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <dprBase>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750.h       | 2 +-
>  drivers/staging/sm750fb/sm750_accel.c | 4 ++--
>  drivers/staging/sm750fb/sm750_hw.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index aff69661c8e6..a2342c69a65a 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -50,7 +50,7 @@ struct init_status {
>  
>  struct lynx_accel {
>  	/* base virtual address of DPR registers */
> -	volatile unsigned char __iomem *dprBase;
> +	volatile unsigned char __iomem *dpr_base;

Are you sure this isn't coming directly from a hardware data sheet or
description somewhere?  Based on the type, it really looks like it is.
If not, please document it properly that you have researched this in the
changelog text when resending.

Don't change variable names that reflect external names, that just makes
for more confusion over time.

thanks,

greg k-h

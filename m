Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824E31AA9A;
	Thu, 18 Dec 2025 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038854; cv=none; b=OS+hQyC+78NyJrcsTOaBChudCfRh4jF2Vnn6YbeyPd7ArXc+Vh9w/FlpU2EzRRSZ8Ylh+rqlANA4YavSZFyjDvMSpTXUqcIPrYKexQwZRAAiFFOm3UTLRqlKvIQ1nqB9nsRrlXPwNO+Kfl8QWCK38gG1rmCKKFe+eU68Az/cweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038854; c=relaxed/simple;
	bh=gempZFFkfiQxbRmznm2F62NQjRfy6OMCLS3448x/nVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5MDucbAVqLRiP9C+PFV3El2rJq9MeellTPYP9zv1nURZvSmDgjb4uZqAY6GQ8U9cpT0YpoZIJYCLfLMIUTyvrCOGfMqW4dv49CMNLb+KwLkwKAnqqZk8a0RZjn1l7eqG7ubiyYT6xkNB3WKoyAsuRFMeIh9ks+eOxTdIv8FXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAYlR1Et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAYlR1Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748E0C4CEFB;
	Thu, 18 Dec 2025 06:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766038854;
	bh=gempZFFkfiQxbRmznm2F62NQjRfy6OMCLS3448x/nVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAYlR1EtIxsDN9a/LHxwXyr1cUTiQeQ5vkwOj5/gE5GG6RNJQ0SewL/2en9fyifkI
	 p/+NKfSuy3oUGOIXNS5Hc5R1Qnlc+bIHDHxnDlQgkMcVsT0w4vz4dUdfkUeKsiE1QM
	 k/cv4wIJSBQafpicJkEGUXfEfFtkKF0pr1BH3fLY=
Date: Thu, 18 Dec 2025 07:20:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arjun Changla <arjunchangla7@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
Message-ID: <2025121827-lubricant-salad-860c@gregkh>
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061406.8043-1-arjunchangla7@gmail.com>

On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:
> Fix checkpatch error "space prohibited before that close parenthesis"
> on line 65 by removing the extra space.
> 
> Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 30e436ff19e4..2f7c891177fb 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,7 +62,7 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)

But you just changed the function definition, does this still work now?
If so, how?

confused,

greg k-h

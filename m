Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED718FC83;
	Wed,  9 Oct 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467809; cv=none; b=pALKL2jQXIBAhzSaN8J4tTZbB8RzF/UkivOClFMkVgySathm861CujIzgDvLYL36+uaHzzrbhEcaDdpZENCQRb8/3MQ+1olNEhZRlIVfOF4TQrIrWwXZS/pW8rAaABlDkUryRyO4JWNgiRI1KPlEyX8UEh4N1AntLVsJzQpm124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467809; c=relaxed/simple;
	bh=j5fmnOTZrI6z6nGVKtHkqEcaFglJeVxTewMiVD15cj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK5l/BtwmFO09vMq2bgKBvWsM/nbjEasQXbIFjW0KGqqT3Xvdd/TBmhGZssog1CWDowduzIWXXucPgJdYUl6znLLgLAQhXEmhtEVfJ1VDb6eAlfH56TvidORk8qIUIggFAcyNpF0b8fD2OlUfJfW65CFEwI5Eln1g32ClSngtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrIfKxWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrIfKxWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25DDC4CEC5;
	Wed,  9 Oct 2024 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728467809;
	bh=j5fmnOTZrI6z6nGVKtHkqEcaFglJeVxTewMiVD15cj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrIfKxWZaA28ltDqdRHz5TLKKVxeB8BHOA4ZPFeZtn6PznvMx9SbA6zsnpfq12Spf
	 UXrG/rGcOH90F7cqujsRmT5f3S/SasX3uxmYzGAAT5tUfdSJsVXWeGiBonwHFiURxb
	 5NfI4Hz1IrmMlnPfMF4rRST5B6w7JzAZup2R68bQ=
Date: Wed, 9 Oct 2024 11:56:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fabricio Gasperin <fgasperin@lkcamp.dev>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750: Fix missing config in Kconfig
Message-ID: <2024100925-lend-aging-2ff3@gregkh>
References: <20240921180612.57657-1-fgasperin@lkcamp.dev>
 <20240921180612.57657-2-fgasperin@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921180612.57657-2-fgasperin@lkcamp.dev>

On Sat, Sep 21, 2024 at 03:06:09PM -0300, Fabricio Gasperin wrote:
> Fixes the following compilation error:
> 
> ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> 
> Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
> ---
>  drivers/staging/sm750fb/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
> index 08bcccdd0f1c..eca1aa43d725 100644
> --- a/drivers/staging/sm750fb/Kconfig
> +++ b/drivers/staging/sm750fb/Kconfig
> @@ -3,6 +3,7 @@ config FB_SM750
>  	tristate "Silicon Motion SM750 framebuffer support"
>  	depends on FB && PCI && HAS_IOPORT
>  	select FB_MODE_HELPERS
> +	select FB_IOMEM_FOPS
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 2.46.1
> 
> 

What is causing this error?  What commit created the problem, and why
has no one reported it yet?

confused,

greg k-h

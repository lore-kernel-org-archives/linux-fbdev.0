Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA424C10C5;
	Sun, 18 Oct 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333475; cv=none; b=HVXJeOwnOVu+cneTcmHxF1/R7sCQMt9S91e7qBUzpUYUbv56uIixhMAQ0Pvs/umpaXwy4Nm5/oyQYdJzfe17qTVxE8mOPY1xCaFs0zYd5L21FmPDNGUb6OTnv/EqL3yYgNQnOFU6huQEtH/K5hIJztr+hbOlDZmnS9XNV7F6iEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333475; c=relaxed/simple;
	bh=HdTlWCuN5mxA4kDV4+oAu0rp4stUqFqZbZ7iGah99N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBGnftZLNqPBZmUcaXIEOG+Fqh9W/TC+VTq8I8aVw1HsSZdtKN0ZIp+OXIO1ZwAPpSyXGuT46b+lvQuqZ8+KFjGFF6ZV6gNDaGu9pTh2H+FhbAznufDfqFqmxo0MFSc6zEWrJS9BWPalptn1aUoPVx5tF2HqLq/L0AnAnxaZ0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+ySQzJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+ySQzJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242AC1F000C4;
	Sun, 18 Oct 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792333473;
	bh=ZfYJa03d83SpS0hjPsK06z1KJODHj9vH3bty8zkM5cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z+ySQzJ7EyDJTQrrJKB4V0BAbbLJS57cC8iisAcE0zjNDkOPnR734Ik6UlFb1hO2I
	 cko5KBIVFDYyKcHbH4XBz2QrSEAvy1O4/+B7NMQx/iyqHlNs6x0HFBhBSsKdOyNowy
	 PcvDgOgokbmLzHslYXi2BFp5DspEvQi7W85YA5WQ=
Date: Sun, 18 Oct 2026 16:23:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Temitope obabi <obabitemitope765@gmail.com>
Cc: outreachy@lists.linux.dev, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Remove redundant zero assignments
Message-ID: <2026101838-oaf-bobcat-efa0@gregkh>
References: <20261018141519.10165-1-obabitemitope765@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018141519.10165-1-obabitemitope765@gmail.com>

On Sun, Oct 18, 2026 at 05:15:18PM +0300, Temitope obabi wrote:
> The sm750_dev structure is allocated with devm_kzalloc() before
> sm750fb_setup() is called, so the init_parm fields are already zero.
> Remove the four assignments that set them to zero again.
> 
> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8b93bfeb217b..21744a5a63fb 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -833,10 +833,6 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  
>  	swap = 0;
>  
> -	sm750_dev->init_parm.chip_clock = 0;
> -	sm750_dev->init_parm.mem_clock = 0;
> -	sm750_dev->init_parm.master_clock = 0;
> -	sm750_dev->init_parm.power_mode = 0;

This is good to keep as it is explict what is happening, right?

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BD38B;
	Tue, 30 Jul 2024 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323862; cv=none; b=Vl5BVeXqlm3gYv/Im9lf3x9aB+bDrwpqJI7VHc1CG6R7K+LM0PuKZjjIdJUyTxH5VULUHw7ZEJgy+j4epq3+FEwLmArXy8Yquse8fsZzI8vWfERLwF2EtTXbmvZMidw8g7nIgY5sxGaab79NDoDciKMXbFAnahVdLB9L7kpDKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323862; c=relaxed/simple;
	bh=VVI1imebOJVZF9QSxnCFZP3BleBHP121TLHTCjh66WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+5UOPWqpoH4UOWvlXLULa3gPCoj/Ux3gZdKo2jD1Emp+ouZGsHmFTqfK55JGE1a5Z5+8y7uZoNz8NaZDEwsFKE2yFlrEnt+begdz6PrWigpz4JvAbKySfag8powpo0OUhep559av89ldhXL0Top0DPJSQ8nHJrXGzXX1s2uUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IEZ5fsGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IEZ5fsGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6347EC4AF0F;
	Tue, 30 Jul 2024 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722323861;
	bh=VVI1imebOJVZF9QSxnCFZP3BleBHP121TLHTCjh66WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEZ5fsGOwu84wMRvOs2CcTyBXd/kUDc0zoJP0qAxBcuTP1uIeLCMyNd4QbZyrnn0S
	 txxwzOmm4o6VkwJMWLAE9Y3dvi8gBkBulrn8EI8QszSmR4BVfazjynysN76r6sSmxD
	 jPYFW1etK6uytPRZ3YZ213jqbpmeEJbv4ckRS/FA=
Date: Tue, 30 Jul 2024 09:17:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sakirnth Nagarasa <sakirnth@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH] staging: fbtft: Remove trailing semicolon in macro.
Message-ID: <2024073026-clubhouse-vividness-600d@gregkh>
References: <sakirnth@gmail.com>
 <20240730071455.37494-1-sakirnth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730071455.37494-1-sakirnth@gmail.com>

On Tue, Jul 30, 2024 at 07:14:55AM +0000, Sakirnth Nagarasa wrote:
> Fix checkpath warning: "WARNING: macros should not use a trailing semicolon
> in fbtft.h:356.
> 
> Signed-off-by: Sakirnth Nagarasa <sakirnth@gmail.com>
> 
> ---
> 
> Hello, this is my first patch to the kernel.
> ---
>  drivers/staging/fbtft/fbtft.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index f86ed9d47..45dfc92b8 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -365,7 +365,7 @@ MODULE_DEVICE_TABLE(spi, spi_ids);						\
>  										\
>  FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
>  										\
> -module_spi_driver(fbtft_driver_spi_driver);
> +module_spi_driver(fbtft_driver_spi_driver)

checkpatch is wrong here, the ';' is correct.

thanks,

greg k-h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197825F7A5;
	Tue,  7 Jul 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415333; cv=none; b=NYkvP4Y83KTJmRCwEt1TkkHuqqrD/+LbQvrA7+dr6p05sci94xu5ofMasq4+qlA5Yld89IBNdO6nVVK6xMmcxKD9249u2Nnp8B+PU0YORdWoFVbTteOy5gmh3BcSp0nd4aALrhl5CwvlH58aaHynDIJbzHibdfgTIV7r+0bD+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415333; c=relaxed/simple;
	bh=vQFlsVUpnwwQQ/tg3FXfczURlLxV6Gtvf4oMfGwwWkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4Pvxsfh35w+MZcLBSS0fBRUA+j5NgcKjQK3hZ44TfwLWDwNXqU3KWStoXmgIRMXb8J9jY/POrX2xiZ3tx6PrJAYAvWCQKtuNn/LRmK7I07lvnbPU4b16ReoXb2kwinQiYjTo1Rd9kJu0Ggiwy4hPhnx9pNx0mXPFeg62CrV7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QqBjjiwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QqBjjiwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2B1F000E9;
	Tue,  7 Jul 2026 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415330;
	bh=Pdx+BwDWnuWomTbS7AhqJEn8Qqhaf/GOs3vSDMIBJx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QqBjjiwlvVpt9iP1NcL6PrZqcd5wryWkV5+0i0ZAysijavcbwjpRYyh76VnatxR5e
	 Mh0HiS4xX/hoiqg6uYyhGTLkQTvgn+txNUohLFHZxiWtDzArwRAIXGxt92VkFm3fcx
	 A62N33+RfKYLukuFhpcYykNNJMSumGOcnj7ImFLY=
Date: Tue, 7 Jul 2026 11:08:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: rename setAllEngOff to
 set_all_eng_off
Message-ID: <2026070733-abstract-mascot-09c6@gregkh>
References: <cover.1779661132.git.michail.tatas@gmail.com>
 <438a9a516955be8cbd7144e95f494663c8c99e23.1779661132.git.michail.tatas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438a9a516955be8cbd7144e95f494663c8c99e23.1779661132.git.michail.tatas@gmail.com>

On Mon, May 25, 2026 at 02:15:37AM +0300, Michail Tatas wrote:
> Rename variable setAllEngOff to set_all_eng_off as
> per the Linux coding standards
> 
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  drivers/staging/sm750fb/sm750.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c..00c293430a7d 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  	sm750_dev->init_parm.mem_clk = 0;
>  	sm750_dev->init_parm.master_clk = 0;
>  	sm750_dev->init_parm.power_mode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
>  	sm750_dev->init_parm.reset_memory = 1;
>  
>  	/* defaultly turn g_hwcursor on for both view */
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index d2c522e67f26..589ae51444f8 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -44,7 +44,7 @@ struct init_status {
>  	ushort chip_clk;
>  	ushort mem_clk;
>  	ushort master_clk;
> -	ushort setAllEngOff;
> +	ushort set_all_eng_off;
>  	ushort reset_memory;
>  };

If this is only set and never read, why is it needed at all?

thanks,

greg k-h

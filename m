Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C394359F90;
	Tue, 27 Jan 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521274; cv=none; b=s1h3FwbwimHJzLV2HI8TP3cXVcShGx+gzsTUTESVmej6mMeAGlnEk5WX8a0g5339rfQUb51bTFLvK4RIRCMJD/UTskn0jkOxz3R124yK4P3uBB/UnX5GO4t2htqPWH+wgtLhu7jAWJDfBxSakrRnedcdxo7jgdZRo9TLoEbfmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521274; c=relaxed/simple;
	bh=x88xXYXXpPxOFmBiWuJjOMVpEC7YNt2zF42xEKzugjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYGLJxSQGXBgUclTm2u03Wh7w0GSPRDF8NaOBLBgAlUjnsi/ojgupj+6dmjkcmKuNeF8mtm9YbrS5IA+UdfJF8ShjapeuPujSXzC1W1eN5rIPHzo1WaFPUGzD5tPJkt5Ppr40CnDnB4codfVLde4qEmRM+iK6GNgcpDhv1jKYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vq5XfBCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vq5XfBCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14C4C116C6;
	Tue, 27 Jan 2026 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769521274;
	bh=x88xXYXXpPxOFmBiWuJjOMVpEC7YNt2zF42xEKzugjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vq5XfBCRywxIMcRGvs02jR85890e7H1M5Rq82OdeVy4wv2quldPAVoiuEacY7Rv1p
	 35LjGWbqXZyGydyzhg8upC7Mc3NhbSCHCEjWTgv+Un5xTSSPrNmTd0TuS5tLwMHC2p
	 ePWL5us+Jx75nWq9HT6vyeKdf3h9HPOOxlFVsZb0=
Date: Tue, 27 Jan 2026 14:32:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhumitha Sundar <madhuananda18@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: replace magic number with defined
 constant
Message-ID: <2026012705-flannels-directive-e15b@gregkh>
References: <20260127132758.49650-1-madhuananda18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127132758.49650-1-madhuananda18@gmail.com>

On Tue, Jan 27, 2026 at 01:27:58PM +0000, Madhumitha Sundar wrote:
> The hardware wait loop in hw_sm750_de_wait uses a hardcoded magic
> number (0x10000000) for the timeout counter.
> 
> Define a constant SM750_MAX_LOOP in sm750.h and use it to improve
> code readability and maintainability.
> 
> Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.h    | 2 ++
>  drivers/staging/sm750fb/sm750_hw.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index fcb7d586e..ae07ceec1 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -12,6 +12,8 @@
>  #define SM750LE_REVISION_ID ((unsigned char)0xfe)
>  #endif
>  
> +#define SM750_MAX_LOOP 0x10000000
> +
>  enum sm750_pnltype {
>  	sm750_24TFT = 0,	/* 24bit tft */
>  	sm750_dualTFT = 2,	/* dual 18 bit tft */
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index ce46f240c..f051bd75f 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -523,7 +523,7 @@ int hw_sm750le_de_wait(void)
>  
>  int hw_sm750_de_wait(void)
>  {
> -	int i = 0x10000000;
> +	int i = SM750_MAX_LOOP;
>  	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
>  			    SYSTEM_CTRL_DE_FIFO_EMPTY |
>  			    SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;

This type of "loop delay" does not work at all.  Can you try to fix this
up to use a proper timing check instead of just relying on how fast the
CPU can process instructions?

thanks,

greg k-h

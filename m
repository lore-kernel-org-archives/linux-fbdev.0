Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769577;
	b=Tdn409s7ibAbdyeslhHW4fRkC05/F9OKgdTin7UcNq8M+W20ugl13sRC862gkN1FAs7+
	 WyEINNg0pAc8YBxUoRuy/0YC5f0PB3RyXIXKTy3T/bd4oBeQSORffDxwDYlT72InptG/r
	 +TeME+BjpFg1UFccZ9yvKDaXU0hZQNvEBbNBgiVvQB311lrnYVosh5bwxy8eiM2msQTiy
	 DNrMr30/WPpRqMm3UJuLTzOSHXxsYXSO62nTFU27bIEy1rXZA9N1qKEFEoOX+ve9U8l35
	 e4QBzjl2Fxz6hWqrF8BdfeCnd90uom8vQUZmpmvICmEQfFgN3irM6ceE/RcmbIMXVYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fcMKTHoL8dxDwv3xwX21weZukB7/62Cej5Walq9QroA=;
	b=fKBcfnofn6l6PzDZA3jJD4QtIN3LZObv7roo7Pit2/pyHdgWrbHVq2+I/6425zcPsU+6
	 mt46jEStXavccXsBqJDXvO4Qh0ECW9LflgbPqRXTqyT7Uxu95fnXQVWldIiaAkk+JzO6v
	 WF0AKApWYJgeHl8UCur+UWry86bjfT3KDD7x7kdn7PyCW6TIsUxs1/nZvK7zl38u8IQn8
	 dCcmPn1rR9PEq9q7W0XV+/kgu1EFYDwPuQxULY6NB8c0Zi03TFSDisNg1YCrKRMPwa4BH
	 SvQVPunQ7UecUQ0Prgk+Xt1kGG26RQQkq90aIKCA19flfxGuW+OCU3Ox/lXAn42j2fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vfphiLYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFE606A31B;
	Fri, 23 Oct 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vfphiLYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF11F01828;
	Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792769576;
	bh=fcMKTHoL8dxDwv3xwX21weZukB7/62Cej5Walq9QroA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vfphiLYF4PmZ4uCL3RAcq7VK/4g8hyRiny1fSU678HdKI0plRqeTlv1qrgzDMDWjo
	 4qHuoc1GFN21cZLy9EM46bUVLYkK1fkKmvSz5j1XyzOQIF5Qdz1odaoYlp0ZS3j2fq
	 lAepqiIpjQmfwnZu+K6Zn1ZTGiJGayicQySwRyJM=
Date: Fri, 23 Oct 2026 15:36:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Simplify M2XCLK divisor encoding
Message-ID: <2026102332-siberian-escapist-cf1c@gregkh>
References: <20261018092651.49924-1-himanshu.bakshi478@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018092651.49924-1-himanshu.bakshi478@gmail.com>

On Sun, Oct 18, 2026 at 02:56:51PM +0530, himanshu bakshi wrote:
> Replace the switch statement with a macro to encode the M2XCLK
> divisor in the corresponding register bits.

Why?

> This is my first Linux kernel patch.

Great, but that doesn't need to be in the changelog :)

> Signed-off-by: himanshu bakshi <himanshu.bakshi478@gmail.com>

Capital letters please.

> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 18 +++---------------
>  drivers/staging/sm750fb/ddk750_reg.h  |  5 +----
>  2 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index aa78d0bc1..2cb849dea 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -109,21 +109,9 @@ static void set_memory_clock(unsigned int frequency)
>  
>  	/* Set the corresponding divisor in the register. */
>  	reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
> -	switch (divisor) {
> -	default:
> -	case 1:
> -		reg |= CURRENT_GATE_M2XCLK_DIV_1;
> -		break;
> -	case 2:
> -		reg |= CURRENT_GATE_M2XCLK_DIV_2;
> -		break;
> -	case 3:
> -		reg |= CURRENT_GATE_M2XCLK_DIV_3;
> -		break;
> -	case 4:
> -		reg |= CURRENT_GATE_M2XCLK_DIV_4;
> -		break;
> -	}
> +	if (divisor == 0 || divisor > 4)
> +		divisor = 1;
> +	reg |= CURRENT_GATE_M2XCLK_DIV(divisor);
>  
>  	sm750_set_current_gate(reg);
>  }
> diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
> index fe412ead7..b796e32ab 100644
> --- a/drivers/staging/sm750fb/ddk750_reg.h
> +++ b/drivers/staging/sm750fb/ddk750_reg.h
> @@ -312,10 +312,7 @@
>      #define CURRENT_GATE_M2XCLK_112MHZ                (0x2 << 12)
>      #define CURRENT_GATE_M2XCLK_84MHZ                 (0x3 << 12)
>  #else
> -    #define CURRENT_GATE_M2XCLK_DIV_1                 (0x0 << 12)
> -    #define CURRENT_GATE_M2XCLK_DIV_2                 (0x1 << 12)
> -    #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
> -    #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
> +    #define CURRENT_GATE_M2XCLK_DIV(divisor)          (((divisor) - 1) << 12)

The original is more descriptive of the hardware data sheet, right?

thanks,

greg k-h

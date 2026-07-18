Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96256F9E8;
	Sat, 18 Jul 2026 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355645; cv=none; b=g5yzXwGrrbxGw9aeL2uxCNe8xk5jQy2yLVzmYYTOtA85i1wsTuHcozWvV8s3LvGTtm8Vh/3cfvsfZGTQd2S/WkDCCH5p3J1iE7dhCyXuuyBBMfSYQcjR7AWgguZGa5HfmcgS5TXVgfBpvV66sfjlfsZ3QkDgdFGzCbfLrCN/13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355645; c=relaxed/simple;
	bh=8wsU4l1Brt/r6P++yT5idx5sLulTLbS4nz7WiruRGoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8PkBxvkl1WbHQoxal7jj8kBjf43fv3Vybo1phK+Z5q+fzBqJVWO2jiFqoKlBbPhFkDsDbkQ13ZCrlKkIC2MbYmQwkPPrGMvPFU9V4e+sZ1XDtqzkduHr2wTPxPemPuBXi7G/6n1cFm1a133plnPnyGEfZsC/cTv0FKpBncuf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyyGrOMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyyGrOMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294E1F000E9;
	Sat, 18 Jul 2026 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784355644;
	bh=ut0DdSaLJ+WkLoE3BjYJB+YmvuBF5y1/mfBhLlta9Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wyyGrOMAg1eNo4B6T4ufe3VTL1FFmOb5TAIXTFn9FLlR20+Dtx9MNr5l+4obaASFj
	 4GW2leWNxQkx0WARvPVzu3xQuDnJ2obhQl5ZTHNzwLeTnx6anAtD+jli5Yq2AgvpyP
	 gstuDpURChm02sPNhSUdRKE1yEGKf4bX4R5jseZ8=
Date: Sat, 18 Jul 2026 08:20:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: unindent defines left by
 conditional removal
Message-ID: <2026071810-reprogram-decade-7537@gregkh>
References: <20260718055132.441-1-nils.lehnen@proton.me>
 <20260718055709.466-1-nils.lehnen@proton.me>
 <20260718055709.466-2-nils.lehnen@proton.me>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718055709.466-2-nils.lehnen@proton.me>

On Sat, Jul 18, 2026 at 05:57:58AM +0000, Nils Lehnen wrote:
> The preceding removal of the VALIDATION_CHIP conditionals left the
> surviving define blocks and one comment indented by four spaces, and
> two double blank lines where conditional lines went away. Move the
> now-unconditional defines to column zero while keeping the aligned
> value column untouched, and collapse the blank lines.
> 
> No functional change: whitespace and preprocessor layout only; the
> disassembly of all ten sm750fb object files stays bit-identical.
> 
> All English text in this patch (commit message and code comments) was
> translated from a German draft with the assistance of Claude Fable 5.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>
> ---
>  drivers/staging/sm750fb/ddk750_reg.h | 50 +++++++++++++---------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
> index 4bcede37584a..2888ffe32fa2 100644
> --- a/drivers/staging/sm750fb/ddk750_reg.h
> +++ b/drivers/staging/sm750fb/ddk750_reg.h
> @@ -294,15 +294,15 @@
>  
>  #define CURRENT_GATE                                  0x000040
>  #define CURRENT_GATE_MCLK_MASK                        (0x3 << 14)
> -    #define CURRENT_GATE_MCLK_DIV_3                   (0x0 << 14)
> -    #define CURRENT_GATE_MCLK_DIV_4                   (0x1 << 14)
> -    #define CURRENT_GATE_MCLK_DIV_6                   (0x2 << 14)
> -    #define CURRENT_GATE_MCLK_DIV_8                   (0x3 << 14)
> +#define CURRENT_GATE_MCLK_DIV_3                       (0x0 << 14)
> +#define CURRENT_GATE_MCLK_DIV_4                       (0x1 << 14)
> +#define CURRENT_GATE_MCLK_DIV_6                       (0x2 << 14)
> +#define CURRENT_GATE_MCLK_DIV_8                       (0x3 << 14)
>  #define CURRENT_GATE_M2XCLK_MASK                      (0x3 << 12)

No, this is not correct, the indentation gives you context of what is
happening.

thanks,

greg k-h

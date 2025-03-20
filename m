Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9AAD5A;
	Thu, 20 Mar 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480049; cv=none; b=aQ2xWer3Xw7pCy0KY/Bv793TipdnraDdXAjDuKW6pQsZ53qSf09wtIsZILDTlaqLP3QkoLPnR+IboLpw4TiI75n9CltIopwHKd/F76aAncG/FkB0BCfmXkdl+BjomMSiuOS2MWzDTpi8OVHDco8gmZHD+qriIkzFFvCOV7rdZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480049; c=relaxed/simple;
	bh=EGUjts6cOJFS9FblualjsATD3QmejyxxxC7dFaW5/DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0XtaWZSxLvpGTwlw80jQiEOHrjP/yeFJ3fFMUNdx2EnECAmz7+/2GAN6OWW8/sL4+G2Jl6kwiahVcEt5YPM4VYwTjd7TfhJt71tcQzLnR/T7Z1KWHwQGx51YqKrs9V+FamgYLDGWqDETVarUiJWYZ1OM3EdYPdO31Ieo38Ly+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9e124WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9e124WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35C2C4CEDD;
	Thu, 20 Mar 2025 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742480048;
	bh=EGUjts6cOJFS9FblualjsATD3QmejyxxxC7dFaW5/DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y9e124WU5Fh/SrJ9jRKPyGicGkOuCrQjZTh+Lpbzf/FoXX02qzrsv3sYSeGUfPGie
	 Ge/DqI9O0KBgRx2SPYF6NyMj2ZOHrFzQ1+TE0ZyYmcYpiKxOsGhDcMTEChsyEAjXcv
	 DLiRw1gge+PCb89ckE2wp709AuIQtzIWkLApBDhM=
Date: Thu, 20 Mar 2025 07:12:49 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Replace architecture-specific defines
 with CONFIG_X86
Message-ID: <2025032040-yesterday-maturity-2f21@gregkh>
References: <20250222193242.14302-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222193242.14302-1-madhurkumar004@gmail.com>

On Sun, Feb 23, 2025 at 01:02:42AM +0530, Madhur Kumar wrote:
> Replace the use of __i386__ and __x86_64__ with CONFIG_X86 to adhere to
> kernel coding guideline, make the code more portable and integrates
> better with the Kconfig system.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 02860d3ec..67a2f6044 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -229,7 +229,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
>  		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
>  		poke32(VGA_CONFIGURATION, reg);
>  	} else {
> -#if defined(__i386__) || defined(__x86_64__)
> +#ifdef CONFIG_X86
>  		/* set graphic mode via IO method */
>  		outb_p(0x88, 0x3d4);
>  		outb_p(0x06, 0x3d5);
> -- 
> 2.48.1
> 
> 

Does not apply to my tree at all :(

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65170623;
	Wed,  7 May 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628630; cv=none; b=akUm6EktF5toSJxhduWPVsBm8KT2FpM1MCMw9dUn7uCtASjF+TIuHGj9Thzyxlxn9TX2xAMdurSnp+15uQsvWzg673iigkBSEhEBTt/FVhnzcGBRbW69bT7t5G35MGHP9Qh6W14iIUHYiw82VIZIHqNl6/reSRgTqjRGuHv8TkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628630; c=relaxed/simple;
	bh=gwt2GDMAIrKfWo57GOYZr6dM2JcjJ9Nb4BYd7VkaWoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8omWVyocrAiXjkDNgpRrSauEKui79oqPPo/NqHbJPa1xrSTcHGgCIsJtFMdMjfN9cI0O5x6UTl4F8lGJhXNDd7/oPwTI3RxDl5LKcQKrUXp+ROnwA8AH49dzaKIsy012sxbnOyfRjeCQUGiqwEoG42ikpYcGblBMFWOs/HOJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GwFKSzWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GwFKSzWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C655C4CEE2;
	Wed,  7 May 2025 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746628629;
	bh=gwt2GDMAIrKfWo57GOYZr6dM2JcjJ9Nb4BYd7VkaWoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwFKSzWWUk9E1iFJSc0cDv6y8mT045VEXWgwfKqM0c/D/eEEtiuD93XPQNCkqfyJJ
	 grXZ1MWmJjqfRMtKrJOpvUqKZwuGEU9NpgRvfYFP63vm7FsukQXJpW7NmgtgBCAhe4
	 z/Wy30YoN72qsIGAeirEl6rrXDdWCZJOtl3GbPRE=
Date: Wed, 7 May 2025 16:37:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rujra Bhatt <braker.noob.kernel@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [FIRST-PATCH] staging : sm750fb : ddk750_mode.c fixed codespell
 issue.
Message-ID: <2025050737-lunchtime-quake-6128@gregkh>
References: <aBtuviJ2FhJXNg7r@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtuviJ2FhJXNg7r@brak3rDesk>

On Wed, May 07, 2025 at 08:01:26PM +0530, Rujra Bhatt wrote:
> instead of "parm" structure variable, used "param" to ease the readability.
> 
> Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 3b25892af713..8f2708632c88 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -203,19 +203,19 @@ static void program_mode_registers(struct mode_parameter *mode_param,
>  	}
>  }
>  
> -int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> +int ddk750_set_mode_timing(struct mode_parameter *param, enum clock_type clock)
>  {
>  	struct pll_value pll;
>  
>  	pll.input_freq = DEFAULT_INPUT_CLOCK;
>  	pll.clock_type = clock;
>  
> -	sm750_calc_pll_value(parm->pixel_clock, &pll);
> +	sm750_calc_pll_value(param->pixel_clock, &pll);
>  	if (sm750_get_chip_type() == SM750LE) {
>  		/* set graphic mode via IO method */
>  		outb_p(0x88, 0x3d4);
>  		outb_p(0x06, 0x3d5);
>  	}
> -	program_mode_registers(parm, &pll);
> +	program_mode_registers(param, &pll);

This change is really not needed at all, sorry.  Adding one character
doesn't make it easier to understand in my opinion.

thanks,

greg k-h

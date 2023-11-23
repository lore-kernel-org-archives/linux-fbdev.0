Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0724B30;
	Thu, 23 Nov 2023 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PB81C+oE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF1C433C7;
	Thu, 23 Nov 2023 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700743980;
	bh=F7P1UrcrA7XXYERAlMWEnIMlgPNCzYeKlSXTkoC+Q5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PB81C+oEP4NslxZtrQVlx0Jb94L25vntk60abpyG1TQRbvYo8ZMR1FLYs4DbWZCf9
	 q310bWMtehDxFYYsr7zeqQFMowHy6oGAKPVKJUpo80QSdUMCdZ10SxNPBZRnESpEoI
	 MbZvrayzvPCT8oZ67f5qnT7iyZ9omLH48kbEvnrE=
Date: Thu, 23 Nov 2023 12:48:35 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc: outreachy@lists.linux.dev, julia.lawall@inria.fr,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Remove unused return value in
 display_control_adjust_sm750le()
Message-ID: <2023112329-daybed-elevate-88aa@gregkh>
References: <20231101152137.10664-2-anonolitunya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101152137.10664-2-anonolitunya@gmail.com>

On Wed, Nov 01, 2023 at 06:21:34PM +0300, Dorcas AnonoLitunya wrote:
> Modifies the return type of display_control_adjust_sm750le()
> to void from unsigned long as the return value is being ignored in
> all subsequent function calls.
> 
> This improves code readability and maintainability.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
> 
> Changes in v3:
> - Rebase patch to apply against latest branch
> 
>  drivers/staging/sm750fb/ddk750_mode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index e1f20379431c..4278f9a826ab 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -13,7 +13,7 @@
>   * HW only supports 7 predefined pixel clocks, and clock select is
>   * in bit 29:27 of Display Control register.
>   */
> -static unsigned long
> +static void
>  display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  			       unsigned long disp_control)
>  {
> @@ -70,8 +70,6 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
>  
>  	poke32(CRT_DISPLAY_CTRL, disp_control);
> -
> -	return disp_control;
>  }
>  
>  /* only timing related registers will be  programed */
> -- 
> 2.42.0.345.gaab89be2eb
> 
> 

Does not apply to my current tree :(

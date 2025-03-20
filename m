Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160E2222A4;
	Thu, 20 Mar 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480005; cv=none; b=U3jZcgH7+jf2naZ1Ka/+jggFCx5y1PqjnDjXM0jT9oglVriFYDMM2iGkZKmOQuWuQIdcT8/sR7pWGD5hPDEc4BZ1CVqGrOu90gyU5Rq74OWu7rrF836BL/teEt9vKdoyvvRxSV6CAsTAJC2SBR/8RZb5ljhjvqA1Ht45wljgwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480005; c=relaxed/simple;
	bh=VmrVG8FieIijI1auDatjqkTpLlmRqX77V2RzvuqmL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjkw5ybV98khNnpoa5GtN90VtgBlypjnofaz7QPWaft/n/ZLpFHPR5hOU+fGUWvjkPUbiGhLhjNp2svr8owqCFU7oA+zOsmokUqJqM6uqUtrQHA8AQ5ZS3RdRTMNmg+bdAnalZu3W4HVGBDZOGYpLR8SgvfG6vZEACS06QsiwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a1WKAn2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1WKAn2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232FBC4CEDD;
	Thu, 20 Mar 2025 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742480005;
	bh=VmrVG8FieIijI1auDatjqkTpLlmRqX77V2RzvuqmL+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1WKAn2Pgzgt7T6jqzr8wrp4fBcJt3aIfpJJRa63WZzHDJ3ga033g1vEvdaxUyaW4
	 zvc1PswMYlc+7G/czr8wY45H7y6bAQOFCCgTDhHXZkjNY09gifq299VRdbR279jrn1
	 rlzZotcQg7Hi+qwiDInRcOMxC74n12xTB1yWAKlg=
Date: Thu, 20 Mar 2025 07:12:05 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] staging: sm750fb: Remove unused enum dpms
Message-ID: <2025032045-rack-abreast-5055@gregkh>
References: <20250314173114.4476-1-lima.gabriel.luz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314173114.4476-1-lima.gabriel.luz@gmail.com>

On Fri, Mar 14, 2025 at 02:31:09PM -0300, Gabriel Lima Luz wrote:
> remove unused enum and replace its usage with
> a unsigned int.
> add comment to ddk750_set_dpms function for
> documenting state values
> 
> Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_power.c | 10 ++++++++--
>  drivers/staging/sm750fb/ddk750_power.h |  9 +--------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
> index 12834f78eef7..547a96ccba9b 100644
> --- a/drivers/staging/sm750fb/ddk750_power.c
> +++ b/drivers/staging/sm750fb/ddk750_power.c
> @@ -3,8 +3,14 @@
>  #include "ddk750_reg.h"
>  #include "ddk750_power.h"
>  
> -void ddk750_set_dpms(enum dpms state)
> -{
> +void ddk750_set_dpms(unsigned int state)
> +{	/*
> +	 *	state values documentation
> +	 *	crt_DPMS_ON = 0x0,
> +	 *	crt_DPMS_STANDBY = 0x1,
> +	 *	crt_DPMS_SUSPEND = 0x2,
> +	 *	crt_DPMS_OFF = 0x3,	unsigned int value;
> +	 */
>  	unsigned int value;

Why not just make this "enum dpms" instead?

thanks,

greg k-h

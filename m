Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828B144304;
	Wed, 21 May 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827955; cv=none; b=VPJ+NjfN/Whsn/hSGVV5Xr99pW5n8SDMDXplCbpxRYOM5ZIBmXj4eNPkd3zZIK1nGb1NirI9T9W4WPPD+pnEcLl/HLxFTZsdwsKeXIaYzPVe4jE8QiARmAvDZawZ3w32bB6tfHZmmNhyzm2Jqi8O3mrL/oOCtOwFNY2g5JyNnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827955; c=relaxed/simple;
	bh=JPQ6yJSkpKPy0/5o2YHVnemBY3bXyrjAfUeWpR6ZoB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDJDdMaG9ZlIcslR9IBl7Op3x1dU9gu39+nPLjoh/Jnu41NaqRMY6NvJDAA66/czdNoi7i8y38yqD9qR3b9SwL2UQ1LlVGlSMrl7u4VZGRe+YvZLFppi2kbslpNybUWd0RUDXLOC/6DiJF11zth1rCpmzf/+qo2cxCN1iVl09dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjPcswUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjPcswUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D9BC4CEE4;
	Wed, 21 May 2025 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747827953;
	bh=JPQ6yJSkpKPy0/5o2YHVnemBY3bXyrjAfUeWpR6ZoB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjPcswUvLmCkivCcVprl4jKJRTYzngdgTIwSryO2jJMjjr5SdHllFrbYvREkfiMzN
	 3ZinZvlGRcEVkmY2JtCtNPuTgUcX81VCfXsE06rturgVKlWCoNKV4AZxg/43GzYJV0
	 SaIebOvBlKVrVTPwEiAzSGRYpzYopeOv07YIrKv0=
Date: Wed, 21 May 2025 13:45:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename `regValue` to `reg_value`
Message-ID: <2025052130-verdict-limb-8b1a@gregkh>
References: <20250506033340.3689818-1-ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506033340.3689818-1-ericflorin@google.com>

On Mon, May 05, 2025 at 08:30:13PM -0700, Eric Florin wrote:
> Rename `regValue` to `reg_value` in `write_dpr` to conform with style
> guidelines as reported by checkpatch.pl
> 
> CHECK: Avoid CamelCase: <regValue>
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 44b9e3fe3a41..5648476a8f3c 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -17,9 +17,10 @@
>  
>  #include "sm750.h"
>  #include "sm750_accel.h"
> -static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
> +static inline void write_dpr(struct lynx_accel *accel, int offset,
> +			     u32 reg_value)

You also wrapped this line, why?  It should be fine as-is.

thanks,

greg k-h

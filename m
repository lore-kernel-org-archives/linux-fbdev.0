Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4143793A9;
	Mon, 27 Apr 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261837; cv=none; b=m5HKky0DulfUhdIlFfFBwuvNDVkaEr8RvSdoeisZR0TtyslAy95TGSc74kQghGM+B/0ilwsh0zI2S/zz0LC/g4Mq1TYyBpmlX63Q37rXncXTzYIHU+uXnh4hhmsceSRaTL4b5eQZeR0KIPZZYIu9QAxcQP60LFghVOTcYB/aDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261837; c=relaxed/simple;
	bh=7MNDyoS2bArCPBhm7dPsDnKoPjdd3BWuB9Ka1bO+nnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk4UY/xj3pbB7k6W/QIBiKBLcvPjku73ZBJRGFPH8lyaHN+/cD52ihHClLnOFXPSDjIyiYv5Yfv/qAcPsDaYEKXrDVPr6DUfCcynWYw02dhUp8j/3s5W8qc+ci5TsIdHzjd9BEWPQOcQCp8ICfUGhlIViek0mRb+QhhYoQe299U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJJh6gtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJJh6gtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF37C2BCB7;
	Mon, 27 Apr 2026 03:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777261836;
	bh=7MNDyoS2bArCPBhm7dPsDnKoPjdd3BWuB9Ka1bO+nnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zJJh6gtLHAVo28koO/GxYtq3ZudjEK2D51HzUgFn0tCR+JrvIpMyqlbZb6+soNN+S
	 H4zzCtJMs3MDnBUswuH3cxDnNppJ9IY5866RrVn7clTAl/kHBPEXiaIQmJUZbcfUwq
	 tHigBFsBbQcxtS7l8JNPQpvrn5YOxTBu/yqtOqW0=
Date: Sun, 26 Apr 2026 21:09:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: sm750fb: Rename init_status members to
 snake_case
Message-ID: <2026042629-dynamite-oxidation-480e@gregkh>
References: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
 <20260407074805.14505-3-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407074805.14505-3-chakrabortyshubham66@gmail.com>

On Tue, Apr 07, 2026 at 01:18:04PM +0530, Shubham Chakraborty wrote:
> Rename the init_status structure members powerMode, setAllEngOff, and
> resetMemory to snake_case to follow the kernel coding style.
> 
> Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 6 +++---
>  drivers/staging/sm750fb/sm750.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 729c34372a1e..c30ffab8a5f3 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -921,9 +921,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  	sm750_dev->init_parm.chip_clk = 0;
>  	sm750_dev->init_parm.mem_clk = 0;
>  	sm750_dev->init_parm.master_clk = 0;
> -	sm750_dev->init_parm.powerMode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> -	sm750_dev->init_parm.resetMemory = 1;
> +	sm750_dev->init_parm.power_mode = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
> +	sm750_dev->init_parm.reset_memory = 1;

If these are only set, and never read, why have them at all?  Why not
just remove them instead?

thanks,

greg k-h

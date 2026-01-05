Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B262DC328;
	Mon,  5 Jan 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600319; cv=none; b=flxOSCaJiOSCFCXuOQBhHgOlUHUZqu1gt+yAgPUr46kBNvL+7uZ7NvVq+vOLOyTopfs6lh8GfIswKlT+oN0Ej8k3OFcTaKwKw1zrYMvhBCBmzdr/1gT0XpLfRqJGPAWd7ex85Pkovc6j73Vo48ox0lJ36EnLHyvN3n/8pcEWklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600319; c=relaxed/simple;
	bh=xjs7rHJ5Ka7DXyXa+nQCF/THgo2Ozq3MGsC35iJ4clQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0gyzkcjmBy9IMCTfu50Nt69hRpiGZgM8lXvfFkz302bKjMFmEuxLpimldpbegNjDJolG3ME/8tTFz0zTbUa+7Cxjig4+lekYCCtNqat185FMimUPQoQH1ZY0i2+VP+u2n6KyOGACUAvBaCWrmwbPR+AZsF6Vpjt9i0jU29zdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGkpaEIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGkpaEIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597EC19422;
	Mon,  5 Jan 2026 08:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767600318;
	bh=xjs7rHJ5Ka7DXyXa+nQCF/THgo2Ozq3MGsC35iJ4clQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGkpaEIfVgfLLVCI+MT1QTUL8l6hjcMXNG98QIhDfj2grxCDxmJt8KQCg4R5601de
	 /Fvl17BVTd/9dmKYNE8Dbc47OcMLu++F63uUWoC3S/VJ1QJI1BH9/QGZEMAZOup3//
	 27dydehoOiHRm78KUSDFK5iZVxcLzAmmhreCOKu8=
Date: Mon, 5 Jan 2026 09:05:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: linux-staging@lists.linux.dev, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: fix unused tmp in sw_i2c_wait
Message-ID: <2026010505-surging-resurface-a7d3@gregkh>
References: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
 <20260105074917.607201-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105074917.607201-1-sun.jian.kdev@gmail.com>

On Mon, Jan 05, 2026 at 03:49:17PM +0800, Sun Jian wrote:
> clang W=1 warns that 'tmp' is set but not used in sw_i2c_wait().
> 
> sw_i2c_wait() provides the delay between bit-banged I2C GPIO transitions.
> Replace the loop-count delay with a time-based udelay(1) to avoid CPU-
> dependent timing and fix the warning.

Why is udelay(1) the same here?

> Compile-tested with clang W=1; no hardware available to validate timing.

That's going to prevent us from being able to take this, sorry :(


> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v2:
> - Replace cpu_relax() delay loop with time-based udelay(1) to avoid
>   CPU-dependent timing (per Greg's feedback).
> 
> v1:
> - Used cpu_relax() in the loop to silence -Wunused-but-set-variable.
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..d5843fa69bfa 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -11,6 +11,7 @@
>  #include "ddk750_reg.h"
>  #include "ddk750_swi2c.h"
>  #include "ddk750_power.h"
> +#include <linux/delay.h>

Shouldn't this be at the top of the include lines?

>  
>  /*
>   * I2C Software Master Driver:
> @@ -92,12 +93,7 @@ static void sw_i2c_wait(void)
>       * it's more reliable than counter loop ..
>       * write 0x61 to 0x3ce and read from 0x3cf
>       */
> -	int i, tmp;
> -
> -	for (i = 0; i < 600; i++) {
> -		tmp = i;
> -		tmp += i;
> -	}
> +	udelay(1);

You are ignoring the comments in this function.

Also, if you reduce this to a single call, shouldn't this whole function
be removed?

thanks,

greg k-h

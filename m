Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA4347FD7;
	Mon, 16 Mar 2026 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641494; cv=none; b=Gi+pIl2oUZrcYdq1CHHRPlsqcEV/bSZAl9vla4J1pygXE1/pUWNM64/N7maRnemTFQ/30SUrMwPl46lVMu5TmHlKqRjV8K+akTQajQCHMsM4OFwbuXVy/9lXu2tkfYxNETxWr6t964GmQwFE5C45FmJfD18BHi97OWOJg4tEMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641494; c=relaxed/simple;
	bh=4fDFdReKjZHE7imMWbmjE2Lt0Rcf6omqnezG581bYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJLv4Eyu6RsapDM448GI6q3Yg59lf+xIdQQlSAwhG3vmrrlQqBWDKeoxYmdNCjNCZIMQZ7I7Ce/4qKRJmJNvKHW2yMDSiyHPM7CKKyek7aQ63F00k4SrpqMbEn9esYXkD6Eh3x+MiRAJyM+kWH+EZjoV0Q5t6S+K/8scnD4gKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNLh7CAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNLh7CAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B18C19425;
	Mon, 16 Mar 2026 06:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773641494;
	bh=4fDFdReKjZHE7imMWbmjE2Lt0Rcf6omqnezG581bYiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNLh7CAI8P+TpTZYu71thMh8pb/YHsTsMu69/RIYIihwxBoY4Wih+rpLLWJh8BquL
	 psQcz81vP5x2jRnwuygp8mnMUid1fjfVwgBX8syixebsjxZenT1ieCUKGzy7AhOetB
	 nshzKWIV7tnm97c43YcSktIhF1sMdNHedk7scGoA=
Date: Mon, 16 Mar 2026 07:11:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oarora Etimis <oaroraetimis@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Replace busy-wait loop with
 udelay()
Message-ID: <2026031626-semisoft-attic-8b37@gregkh>
References: <20260315232042.231620-1-OaroraEtimis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315232042.231620-1-OaroraEtimis@gmail.com>

On Mon, Mar 16, 2026 at 07:20:42AM +0800, Oarora Etimis wrote:
> From: OaroraEtimis <OaroraEtimis@gmail.com>
> 
> The empty for-loop in sw_i2c_wait() triggers a -Wunused-but-set-variable
> warning and can be optimized away by modern compilers.
> 
> Fix this by replacing the unreliable loop with a standard udelay(2).
> This also cleans up the unused 'tmp' variable and outdated comments.
> Include <linux/delay.h> to resolve the implicit function declaration.
> 
> Signed-off-by: OaroraEtimis <OaroraEtimis@gmail.com>
> ---
> Changes in v2:
> - Rebased onto the latest staging-next branch to resolve merge conflicts.
> - No logical code changes.
> 
>  drivers/staging/sm750fb/ddk750_swi2c.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index e63f3b00ec4c..d579cb9da79e 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -11,6 +11,7 @@
>  #include "ddk750_reg.h"
>  #include "ddk750_swi2c.h"
>  #include "ddk750_power.h"
> +#include <linux/delay.h>
>  
>  /*
>   * I2C Software Master Driver:
> @@ -80,24 +81,7 @@ static unsigned long sw_i2c_data_gpio_data_dir_reg = GPIO_DATA_DIRECTION;
>   */
>  static void sw_i2c_wait(void)
>  {
> -	/* find a bug:
> -	 * peekIO method works well before suspend/resume
> -	 * but after suspend, peekIO(0x3ce,0x61) & 0x10
> -	 * always be non-zero,which makes the while loop
> -	 * never finish.
> -	 * use non-ultimate for loop below is safe
> -	 */
> -
> -    /* Change wait algorithm to use PCI bus clock,
> -     * it's more reliable than counter loop ..
> -     * write 0x61 to 0x3ce and read from 0x3cf
> -     */
> -	int i, tmp;
> -
> -	for (i = 0; i < 600; i++) {
> -		tmp = i;
> -		tmp += i;
> -	}
> +	udelay(2);

How is "2" the same as this busy loop?

And why not fix this properly, as the comment states?  You just removed
that information so no one knows how to do this in the future :(

thanks,

greg k-h

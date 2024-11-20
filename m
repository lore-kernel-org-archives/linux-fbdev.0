Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07177145335;
	Wed, 20 Nov 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128434; cv=none; b=lMDi6fP1iZd7HIAtiL0NsrUFnexZRWD67nxkUO6BAJChybEtgKcDCZkHDo4P7LxZWwk9trnDNpuShZ7piauGH5vgR8DVGhasNhiG2gK/IytzjCHOGSD2GVtlAJyzMjGVrAdVtqJwByPe99MgMu0kaPDAG1C3u+dmafqfj4gphZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128434; c=relaxed/simple;
	bh=VPZbRtB6R/qrw+dDwMBShyl1Ada0N3cTfH0MSJN7Ylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOexVUClY3CX5hdGaY3qCj67X5N5l1PIFkMnR9ikjYYmAhkuSQ5rksIuBLjFvlJV78zG+jUYIui7lMuQ2OzKpOAudSAKeJSCoDCASFFsmKY+s7qA2asWL1WNmT/a2lEHin+xgn/D38gIfqEtWfBQjqd6aLxjSzbU4tAfH5yNd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QQR9hfWF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QQR9hfWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEC0C4CECD;
	Wed, 20 Nov 2024 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732128433;
	bh=VPZbRtB6R/qrw+dDwMBShyl1Ada0N3cTfH0MSJN7Ylc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQR9hfWF+KoaMToJ4HaqXg8f4pVvevpJ6bl4FZl0RafZUFqpJMQusBTodl1zua0iO
	 sog4JRWmnyHPhbxdfRJHKzsZ643eHDDbOkAtvyyZo3d4GBCIJWTPrdoFRU0wOYxIZh
	 qKfFR19F4kKZF5gMy8XEm6YoyNlp/xYMay42z54g=
Date: Wed, 20 Nov 2024 19:46:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheolu Choi <ray@rasom.in>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Remove unnecessary parentheses
Message-ID: <2024112016-deepen-lethargy-626f@gregkh>
References: <Zz4R8L7493vTJmry@rasomin>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4R8L7493vTJmry@rasomin>

On Wed, Nov 20, 2024 at 04:44:39PM +0000, Cheolu Choi wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> CHECK: Unnecessary parentheses around 'clk_gpio > 31'
> CHECK: Unnecessary parentheses around 'data_gpio > 31'
> 
> Signed-off-by: Cheolu Choi <ray@rasom.in>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..50e51d730d86 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
>  	 * Return 0 if the GPIO pins to be used is out of range. The
>  	 * range is only from [0..63]
>  	 */
> -	if ((clk_gpio > 31) || (data_gpio > 31))
> +	if (clk_gpio > 31 || data_gpio > 31)
>  		return -1;
>  
>  	if (sm750_get_chip_type() == SM750LE)
> -- 
> 2.34.1
> 
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent a patch that has been sent multiple times in the past, days,
  and is almost identical to ones that have been rejected.  Please
  always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

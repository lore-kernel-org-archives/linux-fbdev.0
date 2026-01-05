Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C826AAAB;
	Mon,  5 Jan 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594494; cv=none; b=WF5yf3B9yux7xFxhBXoRbryv+2qyWTl4OLQOWlyElKMbyBN/EguHYWRzO4FkkE/7sMTQffr3/C1ZcuwZn+tUoUaQE2wFNi5d62oK6r/IPqS8h9yh0XqEPAbYcOcAF7z1W7qoDxuZGUueB5oPDsf6Kma5vqapB1GEgvBbjrZX7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594494; c=relaxed/simple;
	bh=SpwLhUlfzDdh7Q3vcVktYapuYFCWzS5cmJbZZrBLzyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4wvsiC/jD2WgNUaPABzgyQUaWimtYLaK+D3HIdxrQDHphVT3gP5+L3ahUnFEEdKUOrJMtyv3XuNyJR+IknpaKSl415h439AUZ4pxAiCOevYz2sksEa769bH1EUIJnGbs+p1gwF7jEQQmrwd0+GfgOzqDsaR3zpVBV7i63ofkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSpcjIxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSpcjIxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A8EC116D0;
	Mon,  5 Jan 2026 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767594494;
	bh=SpwLhUlfzDdh7Q3vcVktYapuYFCWzS5cmJbZZrBLzyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSpcjIxNCc2AfbebHb44lDhftaE2jFsb37AmJW6XoQ8os7oVs//nl0I0vJQartmaP
	 w6aoZ9mG8Dzn4uqGshrI1A1MgOPaQm5T0M16vDiJeZTK1Tkn7dLHbvVDAeEEbiuW55
	 WqtMBulpR841P1rJORxShXZTcOIbVYwhxGllqYO0=
Date: Mon, 5 Jan 2026 07:28:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: linux-staging@lists.linux.dev, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix unused tmp in sw_i2c_wait
Message-ID: <2026010521-crave-tattoo-9956@gregkh>
References: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105021026.556244-1-sun.jian.kdev@gmail.com>

On Mon, Jan 05, 2026 at 10:10:26AM +0800, Sun Jian wrote:
> clang W=1 warns that 'tmp' is set but not used in sw_i2c_wait().
> 
> Replace the dummy loop with cpu_relax() to keep the delay loop without
> triggering -Wunused-but-set-variable.
> 
> No functional change intended.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..279a1a10f132 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -92,12 +92,11 @@ static void sw_i2c_wait(void)
>       * it's more reliable than counter loop ..
>       * write 0x61 to 0x3ce and read from 0x3cf
>       */
> -	int i, tmp;
> +	int i;
> +
> +	for (i = 0; i < 600; i++)
> +		cpu_relax();
>  
> -	for (i = 0; i < 600; i++) {
> -		tmp = i;
> -		tmp += i;
> -	}

You just slowed down this loop a lot, are you sure it still works?  And
really, either way, this isn't the proper way to "sleep", as it will
be different speeds on different cpus/systems, and not work properly at
all.  Can you fix this correctly?

thanks,

greg k-h

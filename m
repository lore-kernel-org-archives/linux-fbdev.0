Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78220A5CA;
	Fri, 18 Apr 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972661; cv=none; b=k1airkDrjmwOT+dHoKjDTH2flkqJtApBIxglu2+fB/hxTtmLifgR252arkKZuVYwm4IoZmElXseJ/XE+0XzlsZAvqH/8dB5zm9Z2gTY7tqhkGEG5po8X0by8X9HXD8aj1mIqqobQUKiVc5nUrjU6lHT1fAw6qKdAMkvO90+e0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972661; c=relaxed/simple;
	bh=PEygGuptRCotvRMQ4g1F0jJVtfSkKPD3sgeUlmSiLuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0VnyZ3JhSaoMzS2wIZyz5tHeBhNhLcA79QLT3ZdXuCiRBTN2H0UcVYsXYLrenguv9LS8OxiEW+eUCSU5rFN3lQIRvgz0ObRbwsdpRl5TthDFz68h1G60XdtyjIAlYfBjItGYJOjJTHrIfskS5R+CxsW1PO6hmBWnq99rlGLxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YsPOYs2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsPOYs2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809C1C4CEE2;
	Fri, 18 Apr 2025 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972660;
	bh=PEygGuptRCotvRMQ4g1F0jJVtfSkKPD3sgeUlmSiLuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsPOYs2gc+CenTqOjw71GymcQbePo0NF2xQ7TUIkOdvbO3UJ505WcRZvcm+6oxC6V
	 zFzFHgxuA+eRHIRM6fSRml3b94X6z63Mvyj2tpM32rmN2lGP7p3UCNXWSmR7gq/5Cw
	 itB/JRuFIGWEaF1lp/smJg6DS/HH0GPdFqybtCIc=
Date: Fri, 18 Apr 2025 12:37:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: sm750fb: rename vendorID to vendor_id
Message-ID: <2025041819-kimono-wife-1f30@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-4-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417190302.13811-4-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 08:02:51PM +0100, Ruben Wauters wrote:
> Fixes camel case check reported by checkpatch.pl
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index d4309e0d807f..9f660a9be5d6 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -26,14 +26,14 @@ static char *dvi_controller_chip_name = "Silicon Image SiI 164";
>   */
>  unsigned short sii164_get_vendor_id(void)
>  {
> -	unsigned short vendorID;
> +	unsigned short vendor_id;
>  
> -	vendorID = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
> +	vendor_id = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
>  							  SII164_VENDOR_ID_HIGH) << 8) |
> -		   (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
> -							 SII164_VENDOR_ID_LOW);
> +		    (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
> +							  SII164_VENDOR_ID_LOW);
>  
> -	return vendorID;
> +	return vendor_id;

Why is the temporary variable needed at all?  Why not just return the
value directly?

thanks,

greg k-h

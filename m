Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6D1D5CF8;
	Thu, 17 Apr 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909110; cv=none; b=pFj1RKgF/9gGLCiR42+yYuyAorN9EolNvazGNMmxlxllKwxXDM2yml8uOK7vMjk6AmDJ5B+KwAnt0oxVcIO3GzC1YNqzSOpSkiN1h2VTLg/flOongjtqrDhyYhLkmvEp8Kv/vZjU0C+ZmoI6D5BZeMrnLRa8VqP52qQnLCiC+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909110; c=relaxed/simple;
	bh=oyecEjtFxSiSXV+JxcPsWM/y71I0VWC84UikDttwnUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cheI9rRoDfqqDdZcdzbxECwDK1m2lV7Tc1qRDraJcGzG/7dnrBoXAH8E+I1amz7TIAOqywP5+6IQKu2dvT3O3qQ6CpHtL7waPjYMJWfS7h9X2Q6350L4GpXHo10jBFggRqWt5t1kSsOOv/PuybPsJP6hNtTjjwOQH5JUlnqDnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDXrM9lR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDXrM9lR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5305DC4CEE4;
	Thu, 17 Apr 2025 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744909108;
	bh=oyecEjtFxSiSXV+JxcPsWM/y71I0VWC84UikDttwnUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDXrM9lR5SdztaQ2Gr3aY++/60X+JPQO/E8xO9Z86jtR0+Syp60N9pyaBW8JaiKif
	 p7VdNSv6ZzLs0NgZ/qOKswCmAtVYq5y1M51Ar4y+zIzWQrvUWourMl/vNxzC61XNke
	 5QUdgyXTzFJ7ByV6ZtMFD0x21NWDPQp/YuoJa2Y4=
Date: Thu, 17 Apr 2025 18:58:25 +0200
From: Greg Korah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix instances of camel case
Message-ID: <2025041758-mounting-populace-458f@gregkh>
References: <20250417153101.353645-1-rubenru09.ref@aol.com>
 <20250417153101.353645-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417153101.353645-1-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 04:27:47PM +0100, Ruben Wauters wrote:
> As per the kernel style guidelines, and as reported by checkpatch.pl,
> replaced instances of camel case with snake_case where appropriate and
> aligned names in the header with those in the c file.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 113 ++++++++++++------------
>  drivers/staging/sm750fb/ddk750_sii164.h |  26 +++---
>  2 files changed, 69 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index 89700fc5dd2e..20c2f386220c 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -12,11 +12,11 @@
>  #define USE_HW_I2C
>  
>  #ifdef USE_HW_I2C
> -    #define i2cWriteReg sm750_hw_i2c_write_reg
> -    #define i2cReadReg  sm750_hw_i2c_read_reg
> +    #define I2C_WRITE_REG sm750_hw_i2c_write_reg
> +    #define I2C_READ_REG  sm750_hw_i2c_read_reg

Close, but these are really a function name, not a macro, right?

And what sets this #define?  If it's always enabled, then unwrap this
indirection instead of keeping it around

>  #else
> -    #define i2cWriteReg sm750_sw_i2c_write_reg
> -    #define i2cReadReg  sm750_sw_i2c_read_reg
> +    #define I2C_WRITE_REG sm750_sw_i2c_write_reg
> +    #define I2C_READ_REG  sm750_sw_i2c_read_reg
>  #endif
>  
>  /* SII164 Vendor and Device ID */
> @@ -25,7 +25,7 @@
>  
>  #ifdef SII164_FULL_FUNCTIONS
>  /* Name of the DVI Controller chip */
> -static char *gDviCtrlChipName = "Silicon Image SiI 164";
> +static char *dvi_controller_chip_name = "Silicon Image SiI 164";

This is a totally different thing.

>  #endif
>  
>  /*
> @@ -37,14 +37,14 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
>   */
>  unsigned short sii164_get_vendor_id(void)
>  {
> -	unsigned short vendorID;
> +	unsigned short vendor;

Why change this?

This is a mix of lots of different changes, please break things up into
"one logical change per patch"

thanks,

greg k-h

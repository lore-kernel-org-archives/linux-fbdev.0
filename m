Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE342253EB
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Mar 2026 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689709; cv=none; b=tva+jjemk2cEKwRrt9Sz8t1mMB6XSEfKmi31apBeylriCK2006oNWLNJgh+kCndbAumcTiX7AFgwJkIOg+4UD8SQJ67wX0WZi1eRwpBHncg8UWSTtFYEwxCeQhmDd1V13BPJ4v60eAqrFQ9K6zOOjwzPG3rsssHThKmXdFE87H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689709; c=relaxed/simple;
	bh=hbtHb7uyJF1aXgsD8bxT0M0kmGebDw4L50Af1vw2008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo8dpqRJOdVQMpqtQJJ2odVcSUyQ7FLu8mmZKadDCqXO0oXLnB1WUNTJbMwx/AJ97lg7e+3chvenVIJLTgaTljjN1f0wtGttOQyHjyXrIW9lcxoAN77jTEaueyMcvcb0YHIBxpiL0wdAfc0YhwwEeDjvM0r31APbRd4+XGVDtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lOjuHKxy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOjuHKxy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b78b638eso4254003f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 21:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772689706; x=1773294506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tosFlEOKGj8XInQr/E0mYfY51v7I4YOwqCWi7kcZaGo=;
        b=lOjuHKxyZ0HCPI/c+EHvIWo+aKc+aegJODett1xzj/qpec/mFU93sR/qRBn7nDDH3y
         9djg4rioUCYBq4Wd0hxWkJGZ+cjuP/rldEbfsDI/1yJRajfjFsf5HinUKDAX/qAwyLde
         krltGojm2EorWQJocuz0dRbWflj+NtJfJKkfC+SNNZZ0CY/njvOdJsbPKDjpGXzn1frF
         UwTHDGg9Bjo0wZ4tVNJvbNsYLY6+kAZk1Fl3BvvcaW3E+BSTGw4WLmTi1OH2ypR0p5Tc
         STVH/eeXGDW3bh9pfqS75f6+Ca5rqs1OtU7BZpRrGjPP1wom0Qyjn1aVG52ZYKCGBLgh
         CtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772689706; x=1773294506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tosFlEOKGj8XInQr/E0mYfY51v7I4YOwqCWi7kcZaGo=;
        b=JQkuQB7TGrsW99XSMI0AJ5p2ovrq2HnxJ3jTnbG0phZMnGFMdMHkK8lDvaVRg5ei4z
         x12lXLzxomfl59560yYCoYLvkXErcHj/YhyHJnBV+/8VQNiuxmhzbdDvvFFK2Mh4PzbD
         k8LzecOMIfbgcQi5MW1WKh9kKMn440Yy+zl1dF3lwRylGWfY6C0inSUPxsgssi3ufo5K
         6aMTYcAj7zLVjtCtGEC3KNuBLqI75xrIWv0AvAzs32SAlQETdITOHt1ZB8yzavTr6fCs
         BrTXxPds+JmmAVDpQDCgSNNq/FO1Kc2mVbtQ2cuCi4SfU3qCgsHkSW97Qdj6Qx7QWui/
         2akQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+eQG94GFdzFOrAzj7uQYGshpP2v9VdCrV6r8HYV92YoOL9igmMY+y9HSD7wyuilm0tAKW10q4Ke0cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUY22BFkcZtETcsmhguy0Q2/CJwOGT8ZhuW1K1Q2v9Z5GlUco
	EJex7OX+TCZrNr4GlEIp3Vp/3n6glXw90JblGKYeda3ulvJ3O8L+iJpm8N7hBoggDHI=
X-Gm-Gg: ATEYQzwTsc4TpkueaALEkOcdeDhAlM66ltzNn6OFclU1JfS9rvksEg6otcm9teCV/gt
	WtwJs0rxiJl5mMwkCwEz8YGSloY3iEg4kQVrxy2JWdyuSTZ2CU/pKRGxQlEMbQlAIAz8Bo1BCsS
	RWIQ/TNGPw1sUcAinY3u13PuAmdLLJiDboMM/SyAJdUrAxQNVdVl5k5AUBoeb5lqyIi6G+/7SLL
	vAi5j1Iqb2nQtpKgaKJEoLTD+ZfOmwVAvAamYmuIXH4ocGDa4utli2Bu5tld5mtQhTuDPRgCvXZ
	701zxykEiJ/nCgfeqCxBaP0wzBkZ4+x7a/LZDbkDn4R8gO9P9NxW/cffgCB2d/1msGFrme6RnAh
	1X0+HU2D0Tv2XHxUfVc6x3usB3/wL47lVJ7vqe3vZZOefy8akzOmswdrDQ8b57C/7FdGz2Lin3e
	Tshr85mEeB/wGGQLXMR9/7R1IDqCsy
X-Received: by 2002:a05:6000:228a:b0:439:c69f:503a with SMTP id ffacd0b85a97d-439c7fd38c0mr8472479f8f.27.1772689705601;
        Wed, 04 Mar 2026 21:48:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm32639731f8f.18.2026.03.04.21.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 21:48:25 -0800 (PST)
Date: Thu, 5 Mar 2026 08:48:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: sm750fb: sm750_sw_i2c_init: return -EINVAL
 for invalid GPIO
Message-ID: <aakZJmbAfIvyW02e@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304173529.192067-1-officialsohamkute@gmail.com>
 <20260304173529.192067-6-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304173529.192067-6-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 11:05:29PM +0530, Soham Kute wrote:
> Return -EINVAL instead of -1 when the GPIO pin number is out of
> range. The caller ignores the return value.
> 
> Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index c73943341f66..46599be8d6b9 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -344,7 +344,7 @@ static unsigned char sw_i2c_read_byte(unsigned char ack)
>   *      data_gpio     - The GPIO pin to be used as i2c SDA
>   *
>   * Return Value:
> - *      -1   - Fail to initialize the i2c
> + *      -EINVAL - Fail to initialize the i2c
>   *       0   - Success
>   */
>  static long sm750le_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)

This part needs to be done in the patch that changes
sw_i2c_read_byte().

regards,
dan carpenter

> @@ -382,7 +382,7 @@ static long sm750le_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
>   *      data_gpio     - The GPIO pin to be used as i2c SDA
>   *
>   * Return Value:
> - *      -1   - Fail to initialize the i2c
> + *      -EINVAL - Fail to initialize the i2c
>   *       0   - Success
>   */
>  long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
> @@ -394,7 +394,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
>  	 * range is only from [0..63]
>  	 */
>  	if ((clk_gpio > 31) || (data_gpio > 31))
> -		return -1;
> +		return -EINVAL;
>  
>  	if (sm750_get_chip_type() == SM750LE)
>  		return sm750le_i2c_init(clk_gpio, data_gpio);
> -- 
> 2.34.1
> 

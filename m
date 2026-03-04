Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBF26D4DD
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634666; cv=none; b=HP6DtSDuQUQ3uihgYYDdfncPt12eZXcEXmUyhPOHhjQumqL8km3PvbWHZ/t5/uC6I+nSP7b49yH0y55Js8zJQHy6DQFt/ZFjjvadYZGIsCKu/Wmf5MbJGIp+t++c76xX+LY6Qp95btEiogKXrZPYD9Eba4VYKvTf+V0ba4eVJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634666; c=relaxed/simple;
	bh=49HstGghE6b9RLyZMCCzIFM2zryy+XzLsfNn9PHJj84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IymIC0g+eHZFYlRW4gRCN3y6Ftp7zeYnIXPsNePeZB9rMLKrXFPoZlPkNdmQdbmEZAmd6Z3uiWmp7x8RdAkjIYwfK9cdIbCFY0c5HeGaSnnPuqVxjfYpYRqss/+Grj4hbaWrU5r1NapQdplXeDFV+biqa4Cm5yMYUcx6MXjlkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmSE0LZy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmSE0LZy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3514258f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772634663; x=1773239463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e22QuF4Z77P320CkhRoj854rwaL3cGinuHQezA/B5ho=;
        b=UmSE0LZys4su8c5ZDtbopIZUKqiIc8EykWDFAVz/W5YSnkQvF+FmZspcFR5+jF8YCi
         Q8uDUQi4MjJ4MJB8o46sQk1dYMsrryA6AyyzW7FvYv4dXhQlP+Xl2bf7tDfrkidfqfhs
         Lt3A0PRQ9V4lob2rcLd2Gi3UjS/ncMmlSrUP3Scl9+6e35aTHBvYu2Qbj2Bs4JHK/LJW
         dab2g4lDmWSRHAw+ALqRd2E0tw6NB41VL8LuFYmo2tOrlEDusIUi8XzCbVgQ63Am8imm
         A/Hg4Vo5+pAXsvgs1bVyNa8AgXs7Ptqh4gWeEuPcumSDJAWHzRpPniWTG24XhxXgjqWB
         786g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634663; x=1773239463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e22QuF4Z77P320CkhRoj854rwaL3cGinuHQezA/B5ho=;
        b=dNm4GZQmT5rUveC32ERkYFRWBKniMNDdERyyUQdqTpr0/fpFxgVhBmrH21YjQBHvfV
         ry91qjmmWjbo+e6tSRJpq3gEGHkWMJVXjeOpunTxHEpwkcWFUmraeaYe1AW62hV7w3Nn
         YDz3pdOZ+SbqWBmcdnZbquhEQqYB2QHWvFcVBUwXBbW66H4CDav12C8o8AMKHpyOLBfF
         hrIWf0srqnC2bnU/ksoCe5tdLsnq1/4xoeZCKpCmOHyO/CvYyt/9B3GxhhpLJoZBWyYf
         5TC2DgNO657MOK3Awu7a0Mh7koqRHxzqd0kVfE5y4EMwjviBzJPo+4ukFSS6u2DY2KUq
         XPOA==
X-Forwarded-Encrypted: i=1; AJvYcCUWy26LSWI6EvXoOMQug/IAoZKRPG4pj+toisLKmMOYbsqAHF0XB3+H7p9tdIpONAuPKQXe6MqYY2Vo6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9W0+wO5pN+KNLDxBnKH3blICGeezevI1L/4uQFnKImUOelXNS
	qOtreBmV7KruvAybZleKbbpe52v49Fi6jSMiQsoZcfQIFUYDDpKIeA70VDi9RSdI+NA=
X-Gm-Gg: ATEYQzxVYi2/5vKIAqLdFgEnnLulNNVzLt8PYDvKOZAJwDak9rW/psMO3YK4AL4vf42
	ZNJ779/Hfis9kCOmmFOneEeKz7S9NaUJR+lJ1ZPNizcuanNB6eHLbvmKawJFBwjGAJD15yTwmXZ
	1ChjY81pGW2C77/nSb6x0a/p3weacUD4x971crSu3P4EenduFm1ExlAfd3O9SEYEJCQ0sRMpDZP
	uXzpoclicV8E7Raw9dPOcXPayCXEprV78JUb3wocJLTNnDwUzpakZtojn86q91qF07Ymb9Xi2F1
	v32IZ2tA69MvBiV/Ioa+QyPGkGdnf82G9e16pkouG9eoaY4Xe2uenOxyXBdwDQDe7c2OorYy0U5
	T5ELqtH1G3/RWIexJaagKk5IEmGAryg2vnhfL/0SvJxyOYtda+xv+E/mzFBxfpZ1/1vlWxBU3QZ
	JyGClhe6g6qO77hUmTvkxxMjd4udC+
X-Received: by 2002:a05:6000:2404:b0:439:ab3d:1c27 with SMTP id ffacd0b85a97d-439c7f6a523mr4415308f8f.2.1772634663326;
        Wed, 04 Mar 2026 06:31:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ac9f3e5bsm34010210f8f.37.2026.03.04.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:31:02 -0800 (PST)
Date: Wed, 4 Mar 2026 17:30:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: sm750fb: sm750_sw_i2c_init: return -EINVAL
 for invalid GPIO
Message-ID: <aahCI4E54NjUwT2m@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
 <20260304084545.156170-7-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304084545.156170-7-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 02:15:45PM +0530, Soham Kute wrote:
> Return -EINVAL instead of -1 when the GPIO pin number is out of
> range. The caller checks for non-zero return value as failure.
> 

The caller ignores errors.

> Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index a17f758dda6c..d90a93ab8fdc 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -394,7 +394,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
>  	 * range is only from [0..63]
>  	 */
>  	if ((clk_gpio > 31) || (data_gpio > 31))
> -		return -1;
> +		return -EINVAL;

Need to update the comments for the function.

regards,
dan carpenter

>  
>  	if (sm750_get_chip_type() == SM750LE)
>  		return sm750le_i2c_init(clk_gpio, data_gpio);
> -- 
> 2.34.1

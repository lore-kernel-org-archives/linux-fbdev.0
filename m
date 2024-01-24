Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B21272CF
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116798; cv=none; b=VFxQ4/iZPWwyhB/hPpBQ3KvjGphG8+hWsEa1ui8rY7ZT34utVzeUz8pplVces16rVcA3j/3BLTu/yQHSx1tzciVOh/KIA8Tkk7nQDLUKSXsU9TFMqsWDDlyiJO7NgbSm24VznYTTWQl1nZ8ZVqF4vIRVpS2qmXpnVTkwWGnMFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116798; c=relaxed/simple;
	bh=R6A7ukuw2BnIoPYwMMFegYFd5aofoPlUPz7xmyPKcKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txO779iyvuJai3H/Y566IzsUr2gRzQN+I329NUdFjnI6ECc3UfEYo+4arwjKS37yHdE8ktW/v7CvxjisipDy2UrPlAim4dg8P40bWQ4sYDVH8Wf9cEZ+iSL9uEN+VOtsMoclSmYq4UnjFaTaQw11BsG8qGhFX8UNAsEHVEWXq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IoD76UXl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoD76UXl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so5288689f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jan 2024 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706116795; x=1706721595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3a+DNtECmvubjsLdhByFOruS2nKP6Q4o/Q4YSoYzCk=;
        b=IoD76UXlrbbbbDmg9z990p1j/PZyGEts+W3nkLeT/qxbl134ukM9aVMcw0by6H3Pb2
         NrBzYEeLWIRB0aHHRC8R0en1KHMpaXXHNlsKjwYnDZH2+P7mzpF/sGTVliPZPLeQOCV3
         TykLOhqIX0jCe6cFl7TjBkBmw0paV4xmKPav+c9W0SR2ksPo6Bc7tERLFK7aih+C9n9X
         T/DrI6eC9IEaJ3ZJv86f+db8a5TfsVEoCkAkwqJzDT++vAT6iPRqlOBvOC2Fh3up/7T+
         WUPiacb+cTsPHyqqC0og/aqfvC12gLfAI/x8R2+7l0OyGP5sbeqliWfJ5d+0rAG+3r3+
         MfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116795; x=1706721595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3a+DNtECmvubjsLdhByFOruS2nKP6Q4o/Q4YSoYzCk=;
        b=F42ugVxu+IhB5hQmfYrOmV246iGZaLhy+NFypdl49NAROo1BFJm0XK9StPWP9Tt4LF
         k4ls0J697m+s/Nq5B22GPIzGPfgT0fojCm6ERY+HRHrCxRiRI78mYWo7DzDlC5GL/WgY
         Zhwd4DK+NEoXBMT2qFI725chq+eVYqyI0JO2OFndSek1HuCZOZIp3xkwnSk1bheTiQet
         K+Uf2U7AwKe/lnXwbog3iP6jlEkxZgRydpAhTRHfELRVd+zXDIweNKyRaSHmQLMgaNui
         Flin/mkQsTNzjVbCZX8T26Lf/q4bpvqHy9lGSJRyxVzCI1lGSs//frVli0i8zrU36fL+
         BJYA==
X-Gm-Message-State: AOJu0Yy1Pvey0T/1cO8RoakwIWwCKFZAXlLH9Nxsp15+sVmptjjHSedC
	Kvx+Mnj5SqzmjLvFOBup1ANtfH2EHl608zAeXgJg9wwRNIeEgv+EwbiE+aIzFNhWKzP6HU5tdHP
	ErUU=
X-Google-Smtp-Source: AGHT+IF2PLiH41Eqpuhe6kbhSpWxzeOappELX/qRauwkSGF7Z3O3gB6rW0/YAAZnyx7oHR8llwr4WQ==
X-Received: by 2002:adf:f345:0:b0:339:359c:3d3d with SMTP id e5-20020adff345000000b00339359c3d3dmr752932wrp.14.1706116795299;
        Wed, 24 Jan 2024 09:19:55 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d4904000000b0033928514699sm11805827wrq.2.2024.01.24.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:54 -0800 (PST)
Date: Wed, 24 Jan 2024 17:19:53 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Message-ID: <20240124171953.GA15539@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:08PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/hx8357.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index bf18337ff0c2..c7fd10d55c5d 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -8,9 +8,9 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/lcd.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>
>  #define HX8357_NUM_IM_PINS	3
> @@ -564,6 +564,8 @@ static struct lcd_ops hx8357_ops = {
>  	.get_power	= hx8357_get_power,
>  };
>
> +typedef int (*hx8357_init)(struct lcd_device *);
> +
>  static const struct of_device_id hx8357_dt_ids[] = {
>  	{
>  		.compatible = "himax,hx8357",
> @@ -582,7 +584,7 @@ static int hx8357_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	struct lcd_device *lcdev;
>  	struct hx8357_data *lcd;
> -	const struct of_device_id *match;
> +	hx8357_init init;

As somewhere else in this thread, I'd find this a lot more readable
as:
	hx8357_init_fn init_fn;

Other than that, LGTM.


Daniel.

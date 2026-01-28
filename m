Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F305332EA7
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597887; cv=none; b=Ca+Y3RD1krR4pistDYfRLaG27p6tUqW4yV8ifVcRRc7sPnyFR8JxxjSYKDmFO+R9Xs/IKJCBL66vOYpS+DGIi0L/dgejouWbL8erLr7ZlDtcBkYzneNsZQM0grVcXTRl7YnmXdAxVNFrEoaTejtVDKkhRq8uK73pUvje+EtWy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597887; c=relaxed/simple;
	bh=uFAzZ5CAPjtHAT6gvLI6Vg4+PXSvGLUnJQPv3sHGCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9RNfiSyfYcHM57RIgUgbTm0rGxLyDMPzjSy/OcOYHK3Ra3BAgjexK7jazpgjcUJDkVx2MAPxEwYVe673s+4/gxSiD7cM00a4FLv9POXoRMzmmRZg3qevLhAOtBVnU+RDAR8HKMuhOs/atzdWlIM/aycsaQRSe6XbtJoEZF+og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=k4qADME/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="k4qADME/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806bf03573so7222365e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1769597883; x=1770202683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePwSV9uQcaY+n4jv1Q2W+vhnTy8c0WhUgXTMl4Q9tqw=;
        b=k4qADME/LVM7ExuUtz1KHFmMvXX8q8HB1UzNLyWKhJdjPzOZLLL+xtXmVg7yINe6ZD
         YVE2xWMaiDndOl8jIuidkc0k8Yxg0Tnou29OaDFTqzSPG7s1GSeeKImmgk62cjP6uUtg
         auHd16eAq1Nff4vJdOHuW7vOQ7KfJlmfkwNeU4QhIY2oSLAsmq7tXacz7b2nipgc5haO
         /VxLF+PTLTXZsHqBLhXLEYuBq3tufOSJ/84d9xXp/LpFsXsnkEF3GUkALeOdFQc9+GUq
         LHiFIvH+7oQ3vxOs6r9Z01QiGFiVZhFEPqxIvv5N02rHeqZ0eFOCv9s7NtZE4g0PcC+F
         OctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597883; x=1770202683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePwSV9uQcaY+n4jv1Q2W+vhnTy8c0WhUgXTMl4Q9tqw=;
        b=vkp++CLNM36FvoQIgZ6WGi/p7akgawIxpvCh/EaBrswP85etlZ8b1RzmvT45Jxzgy/
         EWJ86extCCn4bhY7Lghuzah0Hequbu79gZWAgJ3l56QCbMTkyq6GdHENMJUvRl8/LPiY
         pURu6nxYptRR3LEmSmKeLOv+yx4kiACVmCrWv4xKPXmXD1yi8OlVuBTXzK9FLvBtlkHV
         ZxdSGgppmf2qhtSYxZW5iKYJvOvc69YkKcV5rsNZNKpMxkMAEMTgeP2NeCODLbIg1b/S
         GtOXhOvYlnlIHJc+9JD6qYBSKAq2t8lg3M08C8YdXtjHtfZrkJrSg7UJ8kTvUAFwQo0Z
         JMNw==
X-Forwarded-Encrypted: i=1; AJvYcCXqA7JA1bTawi9H1D2I02/pKH5Mk3nqm7U8ty8uiZ3XmcDvbVA1eKk+0hU/BZjGBwK0WVaxSPn0G07SEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/lOSfOiRoZ9MZ0XRgN99uVUhCHXBHjQWHPBBATWL8H1q6KKU
	lvfD+MoO7up4aipjjh4eZS+vCZ6bQkIeyMVUvF3BuKU7wwsZkGBj5Saedup+QbKo1n0=
X-Gm-Gg: AZuq6aJP1/AxSk84Fpjgn3sRZtkECJdMwqCtFxZH/p/JcWCwQ9BWVIrcxiCqBjOTIw9
	JRzSsJG3OofcFDsP/+Gek4Z1yEmRPxmL9uIi1wD2cVIyObJmQeJrQdshbaSbe3YHak/AdRUy0Yw
	qGELv0utqE57GLh4nEgru45AmzvuT8SCB6yo5GOqZDzxGjfppGA27FC9q2Ndy+AqByyPm1S9zBx
	nD9dFmcNbVAkiICkQreqDuiQcsBzoZE9UpdhSr8y/PgVY03p9VLJHwbi1AqwEDk+XFAr8g7+zrR
	ttxuMbiwqjSPGcksQqPC/W5SoJOaqRNf9C/swDWK+ls+sXweaGsQzEPXHSjP19AWE7R24vJTxC2
	wMDd7f1FTqykyDvzKVN0mp27/l6QSbCefcAPCjYKnZ4Zm3MECIu+KIrU/tQ1oLEpao0y0i/ZldG
	PvpEFct/eDtakopu/WuNk8u1C9LUo0XpeGA0EUiHngGLxOg56jG1Ti8kQ6GEN3ury6vNEmfVtLD
	ZpVK3w5UcvtZaa9mAzFtYOP/o4uSyg1yexM3KP5D3DlHG/H1H8H4RylgYhBbFZtQcJNADLI
X-Received: by 2002:a05:600c:450b:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-48069c788a3mr59622875e9.17.1769597882839;
        Wed, 28 Jan 2026 02:58:02 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd79c7sm54470645e9.2.2026.01.28.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:57:59 -0800 (PST)
Date: Wed, 28 Jan 2026 10:57:55 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: gpio: add support for multiple GPIOs
 for backlight control
Message-ID: <aXnrs-RWWYC2q4O_@aspen.lan>
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-3-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120125036.2203995-3-tessolveupstream@gmail.com>

On Tue, Jan 20, 2026 at 06:20:36PM +0530, Sudarshan Shetty wrote:
> The gpio-backlight driver currently supports only a single GPIO to
> enable or disable a backlight device. Some panels require multiple
> enable GPIOs to be asserted together.
>
> Extend the driver to support an array of GPIOs for a single backlight
> instance. All configured GPIOs are toggled together based on the
> backlight state.
>
> Existing single-GPIO Device Tree users remain unaffected.
>
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 66 ++++++++++++++++--------
>  1 file changed, 45 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 728a546904b0..11d21de82cf5 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -14,17 +14,29 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/bitmap.h>
>
>  struct gpio_backlight {
>  	struct device *dev;
> -	struct gpio_desc *gpiod;
> +	struct gpio_descs *gpiods;
> +	unsigned long *bitmap;
>  };
>
>  static int gpio_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct gpio_backlight *gbl = bl_get_data(bl);
> +	unsigned int n = gbl->gpiods->ndescs;
> +	int br = backlight_get_brightness(bl);
>
> -	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
> +	if (br)
> +		bitmap_fill(gbl->bitmap, n);
> +	else
> +		bitmap_zero(gbl->bitmap, n);
> +
> +	gpiod_set_array_value_cansleep(n,
> +				       gbl->gpiods->desc,
> +				       gbl->gpiods->info,
> +				       gbl->bitmap);
>
>  	return 0;
>  }
> @@ -48,26 +60,43 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
>  	struct device_node *of_node = dev->of_node;
> -	struct backlight_properties props;
> +	struct backlight_properties props = { };

This change is unrelated to the patch description. Do not "hide"
changes like this. It you want to replace the memset() it's better to
send a separate patch.


>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> -	int ret, init_brightness, def_value;
> +	bool def_value;
> +	enum gpiod_flags flags;
> +	unsigned int n;
> +	int words;
>
> -	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
> -	if (gbl == NULL)
> +	gbl = devm_kcalloc(dev, 1, sizeof(*gbl), GFP_KERNEL);
> +	if (!gbl)

Again, this change is unrelated to the patch description. Do not include
changes that are not described in the patch description.


>  		return -ENOMEM;
>
>  	if (pdata)
>  		gbl->dev = pdata->dev;
>
>  	def_value = device_property_read_bool(dev, "default-on");
> +	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +
> +	gbl->gpiods = devm_gpiod_get_array(dev, NULL, flags);

How is it safe to transition from GPIOD_ASIS to GPIOD_OUT_LOW
here?

Forcing the backlight off if the default-on property is not present
will prevent the backlight state being properly inherited from the
bootloader.


> +	if (IS_ERR(gbl->gpiods)) {
> +		if (PTR_ERR(gbl->gpiods) == -ENODEV)
> +			return dev_err_probe(dev, -EINVAL,
> +			"The gpios parameter is missing or invalid\n");
> +		return PTR_ERR(gbl->gpiods);
> +	}
>
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> -	if (IS_ERR(gbl->gpiod))
> -		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> -				     "The gpios parameter is missing or invalid\n");
> +	n = gbl->gpiods->ndescs;
> +	if (!n)
> +		return dev_err_probe(dev, -EINVAL,
> +			"No GPIOs provided\n");
> +
> +	words = BITS_TO_LONGS(n);
> +	gbl->bitmap = devm_kcalloc(dev, words, sizeof(unsigned long),
> +				   GFP_KERNEL);
> +	if (!gbl->bitmap)
> +		return -ENOMEM;
>
> -	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = 1;
>  	bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
> @@ -81,21 +110,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	if (!of_node || !of_node->phandle)
>  		/* Not booted with device tree or no phandle link to the node */
>  		bl->props.power = def_value ? BACKLIGHT_POWER_ON
> -					    : BACKLIGHT_POWER_OFF;
> -	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
> +						    : BACKLIGHT_POWER_OFF;
> +	else if (gpiod_get_value_cansleep(gbl->gpiods->desc[0]) == 0)

This logic is broken. This code path needs to be taken is *any* GPIO is
low (and, as mentioned, the initial GPIO state must be GPIOD_ASIS).


>  		bl->props.power = BACKLIGHT_POWER_OFF;
>  	else
>  		bl->props.power = BACKLIGHT_POWER_ON;
>
> -	bl->props.brightness = 1;
> -
> -	init_brightness = backlight_get_brightness(bl);
> -	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> -	if (ret) {
> -		dev_err(dev, "failed to set initial brightness\n");
> -		return ret;
> -	}
> +	bl->props.brightness = def_value ? 1 : 0;
>
> +	gpio_backlight_update_status(bl);
> +
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
>  }


Daniel.

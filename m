Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8722F3612
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607798; cv=none; b=tmDiwGrIF14MI5eXJDB9x0R2L2/JSOb5rUxRDLETiA3TP2M38sArAtRUluFLorC6DJhu3NcXnQ20d28K/S7InIqCuYrRDHp//fhTyybIgZSKUXuXJUibLvpQ8FN3TiWyBvpGiT864UZO16JgILRDxDZhgZUZXbn27/s/gi+Api0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607798; c=relaxed/simple;
	bh=ICOP+8Za83UzCsn5kdwRY8IkW7lPTMB1vK8m7RWky24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFs97xRRyx5I+Xz952wI6VNtYqar6saF5If5B+8LsUTqBHxe/vMzJf6eWOWKATMJuvpMUs+LbBqgszRv24UTrdqoTUmvA9RKhxoJEuXMOANjdSzS0qJrq5GkI0EvdHZo+6RSSUc2vGhkRMcB1y8qj+oFI5VJDXckDvNwYuy7bp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=c0+7lofq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="c0+7lofq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so90522495e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767607794; x=1768212594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvKDos4fJsou+PSfhxPxHl5xgEuLiCmh0jj1etHYyZs=;
        b=c0+7lofqKzRH+51D5Evl9eKmSFpCd46cftezD96WfH8SdDgCmLrINPBnEQjT0QZBGa
         PIwKg1fLMyOg53E8eyyo8PAHaGHQ40EsxeiIBklEQgIskhrZW39LwBuZ9xLNvBjzmulA
         sm9RzEv784pM5qg/4x9ImpOQWr20KBmr2C/bpFnCuDu5/QctFSbkaw8YNfJqhyPfCD64
         Jr17pGzx/+UdugnGEWim+7PM7qrOy5RCri1tTO38bPEJlsa3R8EE6Qe7VBF8ffDOUvrY
         PGTalnEob3gI5eVXWvs0ugNpApaX97fNfrvtlgDYYkMjgwLIe3Iz6uWfKMdfVK0fksfE
         zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607794; x=1768212594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvKDos4fJsou+PSfhxPxHl5xgEuLiCmh0jj1etHYyZs=;
        b=WbAbo41CUIa2+2GlxegnSf2LXxfuK1PvIj0FY0lnfirqT1AIXF8AlhAXhTEmVWm5TZ
         af+/rGRuZpjMzN+VdKPscz6sq1e3kf0WIZ0tPVAZD4uZHnksglgcFbf6xQZu3DDg5xzb
         upLhPsPLEAFBEFpBD4cvgNyCqiRefoIv2U6S4hVcNhZkNlQePyATWPmqJ7LMd0Q7STrp
         n0TAsNOdIJJFzySoJGyXWnU74LPnbs/PounYHEWgzBRRnmSAjzDfe2n3k04/nxAaJ79x
         2MrDC0PR768//MPAad9KXZ2zbU7yzmf/2nqT5KgIkLd3Kg5UNVNK23idmUd7JcrLRobr
         3CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW37jUomG7tm0AvS7vsYkReUPhADy9t+SWEaMa6x1xie1Q5qFrOcNjDZPMM9U0XszN0CTxR5CWQBVjgGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztiSWiZkhOkL5+Zs1Lx5w/QjRzhdWbGW+/VvZX58VoEPepqzOE
	DtgogMIV7RU/QlLy1K5H/Ubo0jdk8t0ntAJw9lw902N6TjBKLtm4TDJg5+ATIyALDlo=
X-Gm-Gg: AY/fxX5WZ+MU9qQakRokKvWYAGBuSgQix9g5f9GTzCTIfJgqgZesl33enAR1CEhpiJI
	V2Qw/r2sC0QkK2pyTE56GVefHqHb1hwT/43kA3iwqGNO6OXY00W6BFs96K/HaWUdGQkxFf1djS9
	fjdgoJgcI65y+zNpHKX1hUHsLEvbjMPD3PEV2fWCPTTtNGpJID8siJVirA7dSmnQ0QKMT7TtBKG
	QFiiSrV5UUxo4vIXCmKWO5ulB4G5z9OzK5cgdXDGJ8chVyoqsZsdCRzvAxW9OA7NIy7pi3lYd2h
	JpeSSfHG9oT82Nb7/Y/9Y8yBxMAXsIOGART02wfzS6ovneq9iWHw0E8AHVUD6raSK533h2cDKPb
	J6WhR103hmLJelJClRlIMb3hZWpvB4WOIFJRdTVTv+OhxAweqZmxrALqTD98NU3W3ln6mCPNqQO
	Y3hgO7jemm7YC3Y7Zr8oPCpTYdXmGNdt68qnIiCyBW17dHQZH/njG42opUyQ/46P4AJc/Ir320i
	NX8tgvNu2Ar6pXqym+BOIp0TPm/gcuhehkzDSpKoGpiMcjJS31J6eHKWsS0+zzaTse+CwNf
X-Google-Smtp-Source: AGHT+IGE2qcg6xcM7QfR3K1EbPQJ77qbf+cnZNCN9Ov6K1/H31yxXIcb9M1Xw2mnMf6vzDPPoCfzWA==
X-Received: by 2002:a05:600c:4e90:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d19557183mr677320615e9.15.1767607794105;
        Mon, 05 Jan 2026 02:09:54 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13e2e0sm176557595e9.1.2026.01.05.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:09:53 -0800 (PST)
Date: Mon, 5 Jan 2026 10:09:51 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] backlight: gpio: add support for multiple GPIOs
 for backlight control
Message-ID: <aVuN7zVUWJ1qsVh8@aspen.lan>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-3-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105085120.230862-3-tessolveupstream@gmail.com>

On Mon, Jan 05, 2026 at 02:21:20PM +0530, Sudarshan Shetty wrote:
> Extend the gpio-backlight driver to handle multiple GPIOs instead of a
> single one. This allows panels that require driving several enable pins
> to be controlled by the backlight framework.
>
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
>  1 file changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 728a546904b0..037e1c111e48 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -17,14 +17,18 @@
>
>  struct gpio_backlight {
>  	struct device *dev;
> -	struct gpio_desc *gpiod;
> +	struct gpio_desc **gpiods;
> +	unsigned int num_gpios;

Why not use struct gpio_descs for this?

Once you do that, then most of the gbl->num_gpios loops can be replaced with
calls to the array based accessors.


>  };
>
>  static int gpio_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct gpio_backlight *gbl = bl_get_data(bl);
> +	unsigned int i;
> +	int br = backlight_get_brightness(bl);
>
> -	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
> +	for (i = 0; i < gbl->num_gpios; i++)
> +		gpiod_set_value_cansleep(gbl->gpiods[i], br);
>
>  	return 0;
>  }
> @@ -52,6 +56,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	int ret, init_brightness, def_value;
> +	unsigned int i;
>
>  	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl == NULL)
> @@ -62,10 +67,22 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>
>  	def_value = device_property_read_bool(dev, "default-on");
>
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> -	if (IS_ERR(gbl->gpiod))
> -		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> -				     "The gpios parameter is missing or invalid\n");
> +	gbl->num_gpios = gpiod_count(dev, NULL);
> +	if (gbl->num_gpios == 0)
> +		return dev_err_probe(dev, -EINVAL,
> +			"The gpios parameter is missing or invalid\n");
> +	gbl->gpiods = devm_kcalloc(dev, gbl->num_gpios, sizeof(*gbl->gpiods),
> +				   GFP_KERNEL);
> +	if (!gbl->gpiods)
> +		return -ENOMEM;

This is definitely easier if you simply use devm_get_array().


> +
> +	for (i = 0; i < gbl->num_gpios; i++) {
> +		gbl->gpiods[i] =
> +			devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
> +		if (IS_ERR(gbl->gpiods[i]))
> +			return dev_err_probe(dev, PTR_ERR(gbl->gpiods[i]),
> +					"Failed to get GPIO at index %u\n", i);
> +	}
>
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
> @@ -78,22 +95,34 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	}
>
>  	/* Set the initial power state */
> -	if (!of_node || !of_node->phandle)
> +	if (!of_node || !of_node->phandle) {
>  		/* Not booted with device tree or no phandle link to the node */
>  		bl->props.power = def_value ? BACKLIGHT_POWER_ON
> -					    : BACKLIGHT_POWER_OFF;
> -	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
> -		bl->props.power = BACKLIGHT_POWER_OFF;
> -	else
> -		bl->props.power = BACKLIGHT_POWER_ON;
> +						    : BACKLIGHT_POWER_OFF;
> +	} else {
> +		bool all_high = true;
> +
> +		for (i = 0; i < gbl->num_gpios; i++) {
> +			if (gpiod_get_value_cansleep(gbl->gpiods[i]) != 0) {

Why is there a != here?


> +				all_high = false;
> +				break;
> +			}
> +		}
> +
> +		bl->props.power =
> +			all_high ? BACKLIGHT_POWER_ON :  BACKLIGHT_POWER_OFF;
> +	}
>
>  	bl->props.brightness = 1;
>
>  	init_brightness = backlight_get_brightness(bl);
> -	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> -	if (ret) {
> -		dev_err(dev, "failed to set initial brightness\n");
> -		return ret;
> +
> +	for (i = 0; i < gbl->num_gpios; i++) {
> +		ret = gpiod_direction_output(gbl->gpiods[i], init_brightness);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					"failed to set gpio %u direction\n",
> +					i);
>  	}
>
>  	platform_set_drvdata(pdev, bl);


Daniel.

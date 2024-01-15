Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F684BE5A
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9fKs8sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705306943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDvrcOFbZHCB3Od8Ma5mTsDvXWbMD7Yk0uFxpr0XBF8=;
	b=h9fKs8sb0uoDaBH8SsDymAr+3IrEEAnJw4WA+yOgoVgeGIkYj4tGVKfvXlSJaFVEei25YA
	LYmimmTmcoBT50Qcmand0ChvS9PWqN+yGnPTJL/muOG7RszEsLZH7Qf8KBYATtb9yTgrC8
	CYKZ0kYwnymAKMRXt9FA5V083NHJE34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-Pwa2z4_QO626CPTHV-sDyw-1; Mon, 15 Jan 2024 03:22:21 -0500
X-MC-Unique: Pwa2z4_QO626CPTHV-sDyw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e47b2f6b8so55164225e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 00:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306940; x=1705911740;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDvrcOFbZHCB3Od8Ma5mTsDvXWbMD7Yk0uFxpr0XBF8=;
        b=SfKhTsnbwwko2IW+lV8/SIeA6wnXF5IVO2JdKMdr8G+BVs/teCyXRVl5NN3676PRea
         1YkCaaG4msyc3DZiuQ4tAj3e8T31sShqPL4teECHBpUN+8AyZO2w5P24y8Hbsfg1JRhy
         Tb9tDBRiXP4RgM7uP19/ZVTmo3JkC7O1J4QmlFoDsXd5QlDWJud4sNKiOMe42WtoId+a
         pygfPaYlzXBkDQx9gKsQ2VV9RKy7zk8ZS4JWm9m1YTQZqQsD3AmXMbPnuK4v+hxUnlty
         xp6a54RI+vsjGyrT1Yp/E/JDgBb9hmXEj/oUyyJbkdIJUvo7dzJFoV7ubiM1SNJArSip
         OJmA==
X-Gm-Message-State: AOJu0YxW7ra+BbGFfBvh6HgssvJ3q+dAFzjIhcPU/ZntotwYUhUMItCv
	CvOX3SBv2hOee1k+Aqyhui0EoMHTwDFc7le52feGtzbNEBl20W+Cc3KZA73ZtpfPOQrcs6G/CC5
	923755qSGMH0mqTuf18qbC7dDeG8NneE=
X-Received: by 2002:a7b:c001:0:b0:40d:5f48:d1ed with SMTP id c1-20020a7bc001000000b0040d5f48d1edmr2597176wmb.66.1705306940690;
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ0NHyBcjOe6YwXt82/ItKtsQM+F0s2up4dWVDb/3J/Yk/w5sS+hxI8gjhqkvBzGwvSzZIiw==
X-Received: by 2002:a7b:c001:0:b0:40d:5f48:d1ed with SMTP id c1-20020a7bc001000000b0040d5f48d1edmr2597172wmb.66.1705306940369;
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600c475200b0040d2d33312csm15166041wmo.2.2024.01.15.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
In-Reply-To: <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:22:19 +0100
Message-ID: <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Move OF table near to the user.
>
> While at it, drop comma at terminator entry.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/hx8357.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index c7fd10d55c5d..8709d9141cfb 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -566,19 +566,6 @@ static struct lcd_ops hx8357_ops = {
>  
>  typedef int (*hx8357_init)(struct lcd_device *);
>  
> -static const struct of_device_id hx8357_dt_ids[] = {
> -	{
> -		.compatible = "himax,hx8357",
> -		.data = hx8357_lcd_init,
> -	},
> -	{
> -		.compatible = "himax,hx8369",
> -		.data = hx8369_lcd_init,
> -	},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
> -
>  static int hx8357_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -640,6 +627,19 @@ static int hx8357_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id hx8357_dt_ids[] = {
> +	{
> +		.compatible = "himax,hx8357",
> +		.data = hx8357_lcd_init,
> +	},
> +	{
> +		.compatible = "himax,hx8369",
> +		.data = hx8369_lcd_init,
> +	},
> +	{}

While at it, maybe add the { /* sentinel */ } convention to the last entry ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


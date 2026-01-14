Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8C3A1CED
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406598; cv=none; b=hbhlvwiGxaC/zPAVsRymJka6TEyHTcOPZAUp4XJ9St7vZAdRMlitD+lzl5cq2ausmTaPQUpLYK9nk2oxwEwe43bbc8AXmWXDE/83QmrLHHVMfJmUz1C0vWXVpUc2zJwjaYgdeU2Xk6+1svX4icVBbqH0hIMvbY8mjiIk6fTwRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406598; c=relaxed/simple;
	bh=o5FcL4aPnRYsLLw5/RhjnnSQ1rECANEIMSre11+u4Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik5d8XwCNoKSpdee+HoaSlpij61n6s0kmGDnfL3ut20APXBChB7EPGKQUvSWbJ544TYVcsaPCoWyGb02cr9zvKeaPoocRqnMKgooNLa2lQTMHXXJe0WxyGlzcI45Y9Bhng06chB6Z6ev5mEvfd/7CHT+LFDQuDuE1wR3CxiBXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nqoRhxI/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nqoRhxI/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so488129f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768406595; x=1769011395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ki1lLYztHBUL2cAjzv+IOytmx7cnlyYwYvN02RNUp4U=;
        b=nqoRhxI/sKfzGBd/9FB/QTKHbhmxAkbw5rNYCWcTY+ra7UJz0xg8Kc6kDQXoXSbTDD
         F36GhfIZ8codJe+IkNjVaHnr2ed9Ddz56JpzPW4cG5xW5jFmF/1DkiWFhTHS3BPCxOnI
         0/IDZd8e36aiug73oO/njFFCDImGYb6zhzgvWLlPKM+VdLhCma4BNCvkd8cgwi6bY7vf
         hrevjaC3GIcHR0XSNhJJe7ujB+hgmk+4sPx8UZsXM/r80dWAI2khZRO16/k/BPFGQT8H
         K0hdbl8UJvLZOHe1hDIIBzZNj1m1m1INeXs1eKXlQeDBN61SHTKrsjP5Bv2vQiU8tprJ
         Y3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406595; x=1769011395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki1lLYztHBUL2cAjzv+IOytmx7cnlyYwYvN02RNUp4U=;
        b=cnQ3vcNfDQs1Kqc1jbMINcXamhu313+cBUt/ltpjcgGpTovPqWXFL1BfKJ6cY4X/L7
         kp48ATujJg94M9MJhKRqsqb39ghBdNyhlN/2Cmj9c+b9fNQXyjAxaUwmWrdH1I84SVdU
         6jvgxRgai4hKHilYwRu2w9EYMa8UF7k0pMS84g8HgmEYJ7+OXvcXkYgQ1FfciEEDdr+g
         wz7Nqfv5c6OFD3O8zqKTqwLQ0eY+WWTjwMJd2XRcFvLlMuGa0sDE5JOfk+qGoshJuzaL
         /JZCel22ulXvlp1L00hhOTFy4tTpkmFirsag7/jyGAjuhdB9xFNxfB/gySLxN/0gdfeP
         JjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfPmS+RIKWq8bd/RjShiOY8IKKpf8pCKMNyENU2NdmJxjy+jZF6C6y0tSquuEkWPX7eqqDFEnRRPc9vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWf5N7ocdQTD7kHbS06tchhd6oF9KShtmcSVWtpCaeOTpy6stT
	IMHqsIq7CVZgDaJrHEv95PSRq55opJlwmDH542Av0ssfS6gu6jGVBlaHDgWvBZqqOF8=
X-Gm-Gg: AY/fxX6fCqImrwTfLDBuloAaSXt3oZulLgdX6iJV/qq5crI2I9YF2t1zk4AsMd83vCn
	3WdU8qisuYLO5EbTb8V2BMKvzgJr78V1+bQfl6MIWWUc649vE7SQnCml3udWUMj0KCCmIYUBjyN
	bqJwEXnKphaX5M/2EdQoSfE/9CkgSn83OOdrF7OnA8DoDYc6sEgI7SWf8WXHWT0IghDc2XJh+I+
	PM0gebS3yrl3q3hrz+zF5pTcgB+iReMLtnef6d9j0toZv3inaxpTf84oWV9jL7XuWbeHzfEUah2
	NdWj2zLJ9WzB/oCO8xGe+5McJiQaF4rDR+o5U9d2jgMudFpHlBNy2j1CLSqm0LoPFrl1R+3YZuG
	6jqkNY62WL+brNKb1brQiPWa7Flg0KpgNZsbpENjzM1EEl35ZRd5tpX9Vspws9rPScrfUOfssDj
	XInofxhUaZS7b/ku9YT5Rt7aUI6tQoY9Uc85l5ygsp+nPzFFM36GcxSF748FeOecfBeYPE2BIzv
	tZpe8xT/LMlfMhuqm92wnz7tPPuKc2oWSsXvnDI5ncvpSXGeAddJH6QLDmIMWyeK9w6Rdjt
X-Received: by 2002:a5d:5f47:0:b0:431:397:4c4f with SMTP id ffacd0b85a97d-4342c0ac6e4mr4353689f8f.7.1768406595260;
        Wed, 14 Jan 2026 08:03:15 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm40196f8f.29.2026.01.14.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:03:14 -0800 (PST)
Date: Wed, 14 Jan 2026 16:03:12 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: tessolveupstream@gmail.com
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] backlight: gpio: add support for multiple GPIOs
 for backlight control
Message-ID: <aWe-QA_grqNwnE4n@aspen.lan>
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-3-tessolveupstream@gmail.com>
 <aVuN7zVUWJ1qsVh8@aspen.lan>
 <1fedb7d7-3a30-4f0f-961f-09613f2a95d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fedb7d7-3a30-4f0f-961f-09613f2a95d0@gmail.com>

On Tue, Jan 13, 2026 at 12:47:26PM +0530, tessolveupstream@gmail.com wrote:
>
>
> On 05-01-2026 15:39, Daniel Thompson wrote:
> > On Mon, Jan 05, 2026 at 02:21:20PM +0530, Sudarshan Shetty wrote:
> >> Extend the gpio-backlight driver to handle multiple GPIOs instead of a
> >> single one. This allows panels that require driving several enable pins
> >> to be controlled by the backlight framework.
> >>
> >> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >> ---
> >>  drivers/video/backlight/gpio_backlight.c | 61 +++++++++++++++++-------
> >>  1 file changed, 45 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> >> index 728a546904b0..037e1c111e48 100644
> >> --- a/drivers/video/backlight/gpio_backlight.c
> >> +++ b/drivers/video/backlight/gpio_backlight.c
> >> @@ -17,14 +17,18 @@
> >>
> >>  struct gpio_backlight {
> >>  	struct device *dev;
> >> -	struct gpio_desc *gpiod;
> >> +	struct gpio_desc **gpiods;
> >> +	unsigned int num_gpios;
> >
> > Why not use struct gpio_descs for this?
> >
> > Once you do that, then most of the gbl->num_gpios loops can be replaced with
> > calls to the array based accessors.
> >
>
> Based on your feedback, I have updated the implementation to use
> struct gpio_descs and array-based accessors, as recommended like
> below:
>
> git diff drivers/video/backlight/gpio_backlight.c
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 037e1c111e48..e99d7a9dc670 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -14,22 +14,37 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/bitmap.h>
>
>  struct gpio_backlight {
>         struct device *dev;
> -       struct gpio_desc **gpiods;
> +       struct gpio_descs *gpiods;
>         unsigned int num_gpios;
>  };
>
>  static int gpio_backlight_update_status(struct backlight_device *bl)
>  {
>         struct gpio_backlight *gbl = bl_get_data(bl);
> -       unsigned int i;
> +       unsigned int n = gbl->num_gpios;
>         int br = backlight_get_brightness(bl);
> +       unsigned long *value_bitmap;
> +       int words = BITS_TO_LONGS(n);
> +
> +       value_bitmap = kcalloc(words, sizeof(unsigned long), GFP_KERNEL);

Not sure you need a kcalloc() here. If you want to support more than 32
GPIOs then you can pre-allocate space with a devm_kcalloc() in the probe
method rather than reallocate every time it is used.

To be honest I don't really mind putting a hard limit on the maximum
gpl->num_gpios (so you can just use a local variable) and having no
allocation at all.


> Could you please share your thoughts on whether this approach
> aligns with your expectations?

Looks like it is going in the right direction, yes.


Daniel.

Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048535957
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768744; cv=none; b=OnRzysfp9AfkTJldVW6B8oWyO5ADoP9sevkwbg0dCNzEQe5W3Gu3ssoLUGYI7RgmNki8rIQWyohFU5oU0VPP7Bznzx6aPHozC4O7CuktilKpkL76mK0V1hRpmSGg5ohREubTm0Fhz8culjV9eXPj7zkI6LCrrhFo2WzNjAK4vOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768744; c=relaxed/simple;
	bh=Ldxb3xiosslpoOJubQchwtbD2Q0t8Tiz2RiN7Ya71NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpV/j4d7qEij7fI406kbmP/wJ0Bdc04dJf4yPqEl8UYaqgjDEArGPzqez4JDcxBD3nwUb4ykWFv3kiUBSW03JnYXQQ3NsdjdFLyLzJ7TFzRgbjYHAXdYJUU8TCukifQ8u4FdVfx+yjYKyo6zWhqSFHbZ7NF/Dcw0CHZM1kUtYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CU4X2lut; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CU4X2lut"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31507ed8so1414174f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762768741; x=1763373541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKdtCn/XoTBMU0W91zbNyyVRdCbCwPGBIxEuE5k5q+8=;
        b=CU4X2lutMaoMp7050vNzWAMZ+EMXpJt11Kci27RsnTIl2yDssByHkBj8jMTgXdJ7dc
         Pi35qWLiOt36vrj4uZGBBRCDvasuLEpJqHQYRoGN+WkhCWagOO2/EvZc/TZy6zBEUOgU
         dOseGOeC5P200rjflSAm7dyWMNiR3jRjYfiiWLOcLf+KqSiURh+hOB8DP587ztAzqgxp
         WpJTeth0Ay0n7WnKSLb2/E9qPQYUEwlNgsGqcDlx4kfd5jfN7zcl212Is8Rz2OSvigRG
         zcAZwSUMNe/W4U8Mj/XLqoLjmUpYRk9LIfSLo9jagpd8NsIexgbap3qnq30iXiB0tUdu
         ZqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768741; x=1763373541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKdtCn/XoTBMU0W91zbNyyVRdCbCwPGBIxEuE5k5q+8=;
        b=Ip4i613S/2xhtzdmohHJIzpzp3zGEF9NPVJKU++VsyonTq7ze6ebyp1eyeKsZLTjfA
         lHHhE3TqOz5oK6QZSRuxtKByCzBRGsfaXYw95Zg1/Y+2ic0gVGnI7SBRJ6qOHFef22z4
         TpJCeg+iPaf7aVdTsZF+sxU6sIQGqxuqCo/Efd1pqjVECTXhRuaoNC/w6c/2/r0o4blJ
         LlcHprxc/3oUrucASZziDZabMLNkmQgB9H08ZfNzLF9bjqcWfoF6SrF428opIc3klDB0
         iz24SINj7LNeBgtarST6qp18w/pWmm0izWTe8ESecZXgccMXWvxQh0LwQxz0dxHpsxBq
         qvLA==
X-Forwarded-Encrypted: i=1; AJvYcCW2l6dRb5oJhEJk7pYi+pxvUk0iykH/Rie7Ws1aMIF3Vl/CGlzxxM4U4k03Y3PQpUjq4XMLlxVky6ql3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCducaiDFoZLbEgzn+WFiZmkGULQRitPFCMgeSX+FS/CyOht+1
	RV3JJoBPUTA8AzFcY0s+Y07FFpzrEDSt88Lu8TGaninIvtSy3GmUyXlYC9HpRb2uRxQ=
X-Gm-Gg: ASbGncvG1mmc8SzjHWdfN2J9I7QyJfuPG13VGZrrhLSgbSohld4H8OnQsH/+PbKpjKE
	NjKFdAy/TnBhOMVS463x8J981HjNW//chEPHxtEj4Rtm5HxE7hQp8Qkd+As45D0B5JqmpqiqBKF
	KotMZopGooOFY8G385kInJlMQ6+63FQp1scaAll155cE03Dbqq+LOvUf53XnsTceMZ78VW+HCu8
	NNcQ98Ht9EyHYCpUQ8cDkEiHKOl5r+pN0ZgLrNvKnQFPFFVmW0eZLIJML6Bv2FiagvraTCs918d
	GJR5I3EyVAR67srrvIdosCJaXwNMxuomzQVP/MFPBTix377TaWfFV+AYbPszq5kJjRXQ+DpJTHX
	dToP4ajSxDX2UpSXFpStYIznc4LrNi9PE9U9dlochoeiDavK5UB2vY3vHosqZV8jGJVA1pYekHX
	0Vh9NQAbQOgyMZFQXKigWNaHdSX3yHldWMMqrsGbr3NU4cM2tTYksDCtT2WyI=
X-Google-Smtp-Source: AGHT+IESDCHlcbXRXRa2TG5aApGtSH2moJB6JVIAkSw02ybwWPI2qmXCnmEZcdOIcRiKJ320ee1qvg==
X-Received: by 2002:a5d:5885:0:b0:429:d19f:d959 with SMTP id ffacd0b85a97d-42b2dc1ab24mr7071023f8f.15.1762768740534;
        Mon, 10 Nov 2025 01:59:00 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm9799000f8f.45.2025.11.10.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:58:59 -0800 (PST)
Date: Mon, 10 Nov 2025 10:01:11 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlight
Message-ID: <aRG359gIeP48V2ZZ@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
 <aQ4a2SBDldYgQb56@aspen.lan>
 <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>

On Mon, Nov 10, 2025 at 09:40:07AM +0100, Maud Spierings wrote:
> On 11/7/25 17:14, Daniel Thompson wrote:
> > On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> > > +/**
> > > + * @brief control the brightness with i2c registers
> > > + *
> > > + * @param regmap trivial
> > > + * @param brt brightness
> > > + * @return int
> > > + */
> > > +static int max25014_register_control(struct regmap *regmap, uint32_t brt)
> >
> > This isn't a good name for a function. It doesn't really say what it
> > does. Please find a more descriptive name.
>
> Having a lot of difficulties find a succinct name that fits better,
> max25014_register_brightness_control()?
> max25014_i2c_brightness_control()?

I'd focus on what it does rather than how it does it meaning something
like max25014_update_brightness() would work.

However, at present, this code is only called from
max25014_update_status() so the simplest thing to do is to move the
code into max25014_update_status() and remove this function entirely
(then it doesn't matter what it is called ;-) ).


> > > +/*
> > > + * 1. disable unused strings
> > > + * 2. set dim mode
> > > + * 3. set initial brightness
> >
> > How does this code set the initial brightness? It doens't set the
> > MAX25014_TON* registers.
>
> Yep forgot to remove that, I discovered the backlight core takes care of the
> default brightness, so I removed it from here.

What do you mean by this? Are you sure you aren't relying on another
driver to enable the backlight rather than the backlight core?

> > > + * 4. set setting register
> > > + * 5. enable the backlight
> > > + */
> > > +static int max25014_configure(struct max25014 *maxim)


> > > +static int max25014_probe(struct i2c_client *cl)
> > > <snip>
> > > +
> > > +	/* Enable can be tied to vin rail wait if either is available */
> > > +	if (maxim->enable || maxim->vin) {
> > > +		/* Datasheet Electrical Characteristics tSTARTUP 2ms */
> > > +		usleep_range(2000, 2500);
> > > +	}
> >
> > If you really want to keep the devm_regulator_get_optional() I guess
> > maybe you could persuade me it's need to avoid this sleep... although
> > I'd be fairly happy to remove the NULL checks here too!
>
> Just wait unconditionally?

If you think it will be unusual for the driver to be used without enable
or regulator then it's ok to wait unconditionally (all examples you
have added so far have an enable pin).


Daniel.

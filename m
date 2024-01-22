Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113440C02
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jan 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942288; cv=none; b=KZLo88yuscUGWslrfDKsGaKLuaZuSQqA8C9PMbVogsl8SkSNqz0WL3YKNXhlX8XoROx8XVAcmY9NaEzg1FMRGMUx4bUSdiPc1ng1tsDHCl9yjdD7n8UO+F4r6Vt7IQ1VNvBaBV98np+Czf322CHvVCJLP+5bgl7o2+WM1e1Pq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942288; c=relaxed/simple;
	bh=+b00yzntzNaMOB3fvEhCtmlXhPID8D+X7olNpK8KzM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkdyHrLWUfXcE8PCzS7/EeCq1EptGlzuvihX3iSKuEsRu+Wi7jtywrk76ju696RbDbpsA6CLKU+mJ4MFBx0u7a38/DZ/4ShVRmg4JeaaorxpwwvFJTGwiHrytEsu/fkJ2iH46qczWGv0E/L5v+0fCTrGS/A+tGb5unMq2pog4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5kwTiZ4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5kwTiZ4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so14716865e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jan 2024 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705942284; x=1706547084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Xb3P5uW0KtHlr1gJq8gbLgJiB2wQ8rCJWCXkjGJUtQ=;
        b=D5kwTiZ4WknU5u/XVuRikr5TCLZs5eeF4JPi3cVFBFoFsn5EkN2mtcEdJs6tJ79+ah
         rFFL+8RfHJCsQlpUlKSs8b8YjHYZHBZtWqdPxjBEHij2i2iwlFqTx8dCukYmKNh1mfKi
         ruOHbInznOWxkVx/kNH+QYTaetdQf8WSgf3tydOtfpu/4qC7SNDQHwJ5ErMnw6g9f2gV
         PfuXdE0qr5lEVl82kO5hPnn67VAyVMHRAlqpFkVqRW2/U+qXVGy1ZyH4VIA61nXav+iQ
         QwZMWFE1prBMzKu7A7pm1MDQi2QfHSxLUiI1MjF3l+WqZOtKyrkuGuXwtlbObvsBEtay
         UxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942284; x=1706547084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xb3P5uW0KtHlr1gJq8gbLgJiB2wQ8rCJWCXkjGJUtQ=;
        b=jq9ErzmenyiyFSJm8MjZxNL8iJ7aolYVvsENozcSDrUHQeOAq5zcvYACpHcGRv1qcO
         YDHtMbgbq99UP2A3HMHr4XmCXo7kuYZVvXsgYfedaUfE3QGWo3aoKhGLDI18iFaeYDKu
         6jRIEQ2CnSI0Ko877McNrpBhigcZNz2jo8eVfBBimyFgeVqP1y+DVim+wf88dHbilpL+
         2VCnANl8s49UOrSyQ40U3HHiD3/xckG1F6XalqyPLc76wRRWmpLBmMvtXt4O6KvFgWo2
         Lr0LUGnJ/5aKqkjmADt8s20yRn3c0hf9ST/fkp168pP9suzN7ZZPl6/xtznV82vuMit/
         Df0Q==
X-Gm-Message-State: AOJu0Yx+Uq4jkIV2DfjYDgwlVRo/Uk8dx97eFTXmnL2uLcjQrcxkGYzT
	irphsKTZwmRu1/ya5NNDZxGwY8ElI5qslSX2gARwnm18jXZNHRayvRbOg0tHMas=
X-Google-Smtp-Source: AGHT+IEe3ZCJOUFqqCaZfXUenFubOiJGjr88xxBaUX1UAuvcpYxGpx+soMDWnfmXjkm1SCbpuxpXaQ==
X-Received: by 2002:a05:600c:b9a:b0:40e:a9c0:31fe with SMTP id fl26-20020a05600c0b9a00b0040ea9c031femr1882939wmb.68.1705942284282;
        Mon, 22 Jan 2024 08:51:24 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm39802749wmb.7.2024.01.22.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:51:23 -0800 (PST)
Date: Mon, 22 Jan 2024 16:51:22 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 3/3] backlight: Add Kinetic KTD2801 backlight support
Message-ID: <20240122165122.GB8815@aspen.lan>
References: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr>
 <20240120-ktd2801-v3-3-fe2cbafffb21@skole.hr>
 <20240122102805.GB8596@aspen.lan>
 <1783156.VLH7GnMWUR@radijator>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1783156.VLH7GnMWUR@radijator>

On Mon, Jan 22, 2024 at 05:24:56PM +0100, Duje Mihanović wrote:
> On Monday, January 22, 2024 11:28:05 AM CET Daniel Thompson wrote:
> > On Sat, Jan 20, 2024 at 10:26:45PM +0100, Duje Mihanović wrote:
> > > diff --git a/drivers/video/backlight/ktd2801-backlight.c
> > > b/drivers/video/backlight/ktd2801-backlight.c new file mode 100644
> > > index 000000000000..7b9d1a93aa71
> > > --- /dev/null
> > > <snip>
> > > +/* These values have been extracted from Samsung's driver. */
> > > +#define KTD2801_EXPRESSWIRE_DETECT_DELAY_US	150
> > > +#define KTD2801_EXPRESSWIRE_DETECT_US		270
> > > +#define KTD2801_SHORT_BITSET_US			5
> > > +#define KTD2801_LONG_BITSET_US			(3 *
> KTD2801_SHORT_BITSET_US)
> > > +#define KTD2801_DATA_START_US			5
> > > +#define KTD2801_END_OF_DATA_LOW_US		10
> > > +#define KTD2801_END_OF_DATA_HIGH_US		350
> > > +#define KTD2801_PWR_DOWN_DELAY_US		2600
> >
> > These are a little pointless now. They are all single use constants
> > and have little documentary value.
> >
> > The lack of documentary value is because, for example,
> > KTD2801_EXPRESSWIRE_DETECT_DELAY_US, is assigned to a structure
> > field called detect_delay_us.
> >
> > Likewise I doubt that explicitly stating that long_bitset_us is 3x
> > bigger than short_bitset_us is important for future driver maintainance.
>
> Does this apply for ktd2692 as well?

I think so, yes... but I won't get in the way if you (or anyone else)
decides otherwise.


Daniel.

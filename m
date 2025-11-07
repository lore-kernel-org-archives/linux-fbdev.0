Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FA262FC7
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Nov 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532442; cv=none; b=s9x7ebIL5pRVA0Ffh16LBQaHn7+m2EYYdmOcsgnPd1OQrrLZQjQ7HsAB6eV+TrOQEXms//aOgZsY/t1uzVT5N1JBjgAouqAxXt7RBbKq7sKl1W7/ZWkaHMTFtyK7xhRfkNoCOIvvN5h9NUL2JNKEJD0RuxJS8pBXBYNYSM+4MuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532442; c=relaxed/simple;
	bh=Fqsv7T5UOZsDf8OyIMapY71LUPMEa73mHQs1iYV1MDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTPMi8yWvnC5w836h+Ac/NlgRYMaErA6jaNqKR39nlTuX0/joS67rjuBpgmVwvt/zSgVKBd+w8vrMuPUpj4hFywDp8erhxmC/j9Czdd5Q2cbRjSH22YlO91v7McZ2CI8NXYpws043a9nAqEoHDp5q3oj436RJyEheT7svAX5ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=GrSpfDG5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="GrSpfDG5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47728f914a4so5791485e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Nov 2025 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762532438; x=1763137238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDYDeeQ/vWAVkTVZ2tumPs2hnzhDw4b29aU1EHWCyII=;
        b=GrSpfDG5UEA62RszPCamiXBlJMTzRq/172nlAeJBrWsdesZzjS4yKwDk2uPZl2TAxD
         kovPJcpe3glAbYlq4vnnS1Xcq4eAfxVVjXer2YHuVUpnQlxdLDhGwrXECH32yG/ug1/R
         xvqGOpIfPF2NFGtE1jYgxQ+nUvPNthJTXKBCxGZ/rbivATdqQsKWCceJXObblp7IgqTK
         ucKfiisyTfcihb7quFaxVwbf3Ru0FEUwLkVf+y4DCD9NLNN8d60M/3xra+KJ1JtMnGdb
         YaTFnPIveiIpNv/+J+PE+soVDp6fM8gNFA8/D6lqyRDWVn2fdZA3jkR6L+CXomvE2QpK
         IKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532438; x=1763137238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDYDeeQ/vWAVkTVZ2tumPs2hnzhDw4b29aU1EHWCyII=;
        b=FVQL2b81d0s32Zmyd/kERIhEGjk/22hdrD7YM7sv7VGd1XFmpgM34xVRkxf5Ubr97r
         YWG/Afo5bFF8ArX+lwngEYTLkj7n5moqOhPmqceBu79C57B/WnG1T4P34ziR00YE+NpB
         +sz/9ElgnAt4tsJXA4Xc5C5duatGOau9p7DnA0ZBt9HuSdFICpy6lg4KCwKqkoZewOOO
         4e9yD+mIP/JRkkw4k9xIHucUGA/KM/S0cra66tJpphZzWU6vqv4C7W/97YKj1IxOn3J1
         jrUkwMs7Cv3hrzxvjQ41pXSFauZXuw4jjCPHfcZ0mZLxTKOiJpPQ0IGtX/v9Gjsl25Sm
         ctvA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ929EqSjav9rg5sP4RkZJX/4jbpO6GkByMOBzXQYwbHAEYheqb5ZMyVyflM08rVEKNb3QWHMpwxmtdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXO8EZ0rgMIQ0YZ09FnlUohRVpE0gF9d0ALda7hfqYaHzQDqx5
	/fba5ATrbDDvUCKsWJy6f5xf4EdB9wpcDtn2oT2ACqg73gQJIFbTObCWtK71OLq0hcU=
X-Gm-Gg: ASbGncuYFfvtC7lrqTfQ9LFcfncaODrZ5K8pBh1X3LEidcapRUk8sowkkSKrgqMEfdO
	HriQuo3tSJchp1NlJXmi3QsGGtIw6pizqHyCOAOt2azCYDrYJg49b4e51PQkwA/dnwP2/ojFigH
	iTF1gPeFGtaVblGiPhT4Ze9c+DqEiT7PRsXR0s8g3mwAXZv4293B5QbVACUqeoATRGX9lP28BAQ
	TDahXC89Si2RmL5tofwL71C8DtJ3YrHhj5xKuJrGGJBSmPgvWMhwfXy/18KH+LOXONZ4lYZi7rl
	IAH58ISArBGRdUQyZ88oX6ns8sNylNtuDOtoxmj4/7yhekdaYp88umBimqqCf/jTKB+o5r8K2c2
	xEa+rBfCwfPPb6+KDk5ZNvgC/0NYwxD37wmEnmcmfgrwNS7SfgSb6deRYXfEqgnYLUBb6ZKZmai
	FKW2/3KGzXfNPooy+pyfoQnPQecg/DvzdPCIAyoaooYmwHwTcOBX0nX+6wiy8=
X-Google-Smtp-Source: AGHT+IFcgdIpQe62FnRg4rVkke0TruBClBrbAABNqXTY7mPIIJ+cQeAzHNDnmh9vCKPrBQJ6NHkN0w==
X-Received: by 2002:a05:600c:1c8e:b0:475:ddf7:995e with SMTP id 5b1f17b1804b1-4776bca6415mr30487885e9.12.1762532438329;
        Fri, 07 Nov 2025 08:20:38 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477641fdbd8sm48938385e9.5.2025.11.07.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:20:37 -0800 (PST)
Date: Fri, 7 Nov 2025 16:22:33 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Frank Li <Frank.li@nxp.com>
Cc: maudspierings@gocontroll.com, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
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
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlighty
Message-ID: <aQ4cyVKzgBUfpsj9@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
 <aQ4Vb4eUmSX0Nj6+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4Vb4eUmSX0Nj6+@lizhi-Precision-Tower-5810>

On Fri, Nov 07, 2025 at 10:51:11AM -0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> > From: Maud Spierings <maudspierings@gocontroll.com>
> >
> > The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> > with integrated boost controller.
> >
> > Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

<snip>

> > +static int max25014_probe(struct i2c_client *cl)
> > +{
> > +	struct backlight_device *bl;
> > +	const struct i2c_device_id *id = i2c_client_get_device_id(cl);
> > +	struct max25014 *maxim;
> > +	struct backlight_properties props;
> > +	int ret;
> > +	uint32_t initial_brightness = 50;
>
> try keep reverise christmas order

I thought reverse christmas tree order only applied to code where the
maintainers called it out in Development/process (e.g. netdev and tip).


Daniel.

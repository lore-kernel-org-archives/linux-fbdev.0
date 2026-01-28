Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C609221DB5
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599262; cv=none; b=gJABV6K/GMRE+iNJnpQWw3Khqu8gJQkPBUUmOzoggsG7okEsJf1rdslCNTJwgldpN66Fcyr2nXzLqSVaaqy+Ud+yIS/vdeOtXotN7eymMrCXhBRpRvVoxIfWIkfspsdukPi4dKWnqcZiZvfCtTfx1lt1oJAY31lcX8TCnKlf3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599262; c=relaxed/simple;
	bh=wosS8gSZQwNatY59Tw5xbh3t7QOl2V3ezMLzg/qyqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDSgcPupOqEHkn4oIrTS7zx3Tp9b5NXb7KDPnksqFyaSXKKKcQCMoEzm4QrpxytkHVKOalsjDPNxkaKNBwgH/OwAAIGkg+LWh5ESycxupG3KjTh+q2c3Nc7LvsYfP2fv+K6eVGyyscea88RF6XSB6TjfbESuYo37mLBFRD5JVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3f7kyQJi; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3f7kyQJi"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48049955f7fso58135205e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1769599260; x=1770204060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wosS8gSZQwNatY59Tw5xbh3t7QOl2V3ezMLzg/qyqP0=;
        b=3f7kyQJiVxjHELXA4HQAbjkI5vTJ5Pwe5iijLrNLeOEP9tiquUiuL+cDN23L9fCiGa
         ljNkUR47Qv2FRTFvR3hGGXUhlKwiKMFGwukZaDO406Y5SAWegqU9M8hDIzKkiFVJNoKq
         w6sUtPZ9UtILnQ5sJeo3zsS4pGmN3x5CXxKlptOB3ea+16C5dESdRyylWRJPpnWUxPFn
         jfFwxTj4htTnIWuw6zWwPoCPfhCyp5eTH/mWMyJEXFzkxPwSN69j1o1iSeXu1WgKp8i6
         e9/hbvMEH1mB+210rf2PnZhxmt34F0Rl4vI+yxJNASGhkxfouPfhaOsIyshd/dLLTrRg
         D3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599260; x=1770204060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wosS8gSZQwNatY59Tw5xbh3t7QOl2V3ezMLzg/qyqP0=;
        b=nCX8OJTYO7L/UPfGxlQgTpFYPM1UyrRfrXJqNYGWTiPDA43SAEjixMxcP/oapsfgTm
         mVC9Jox0nCqDmQnNf7K5RrXKM4KQkAA6RasXreOFiUfOXA5DpxYS+d73DRbIK7F+FxZd
         wUih6gs7ScrGK/BYfRBZszX/g9EdAqrk0F08k+v+8dBi/aYV8MSNafFKDBFgySSsDn4n
         K7sF+T1Fx2BceNlZERnr7yFbwm7xFFrvRk3jHXrb1sRNn9d5KJafqv+dAyS5XCuCtprh
         xvfxDmXPw2pR7sEbuem/lJNx/eFZNejYELEgbbdMqN00EBuCPGhNMA/X/rTc6z+b2KOs
         y7VA==
X-Forwarded-Encrypted: i=1; AJvYcCWkaVXZGqPK9aI0oUy+GTzrR20nbNk2wsalBlDAIOcro623SHyIFH3IUDL/xbwQEtvm7RTdgWlgpNFxtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPv3S+bjXPYPNEKsGU7jcQhklO7nQcieoqEOUL5pDr9BQNlgjq
	h7v/F1DKCSzu7CYvyA2UiLPstA+d+LZZ+VUUdRVWgASKWZUwbpTGXaCmwgAHFmOaRzA=
X-Gm-Gg: AZuq6aKJ8dAawYV9H5BpuONnidlXwQYuDLsa2f5rg6++Hy0BjAuvT++qYWRiSDoxetp
	8YktSID9ID89ccsLbB2s9q9fLa4zxYJo4pqZQ0nqNd2MjmbUqc1HGUBqymHiI86H3Stu7UMF8d8
	tDyegpY6R8Y3xnBH1nGdS2xJEP0IbS0Gs3dP/n3vugrgRDjkSzDbtmwtERNngIFVYt6e0QLyVis
	GyRyTAX+NS9ghu6XoHO5KU+vZtDQ8mZmz9ewB+TiCoxHUxoJs/VJxpMfs9/4zpZ1eqbQ/F5eNbw
	aLblv5JeCwCR7P1ONecOAQFQ7167tCLNmqrfUEdQFJciWWDOMptJKLBgYxJTh5URPUZ4Q6lcOnm
	2Q6gYkJZkIp2TepL0/BY0kCc20wNtqiNC65dzkMniQGQBmF7TM3xLYQtOGvVBke9YFD3/7MK1uU
	VQASbHLOrDneqajFdmuL8WynUorXQcq79Nt5WdXPSfU+ft5M49IdGjzeEVcI619CT2HgMPHsBDv
	FBIPE6esLUuae/Qq+31j9TanlPD+cr7ma7uJ0qiA+TrzNaSaGXjEre+4lKzRH5su2V3bu0X
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-48069bfad7fmr63503125e9.7.1769599259657;
        Wed, 28 Jan 2026 03:20:59 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2e5ffcsm4307315e9.18.2026.01.28.03.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:20:59 -0800 (PST)
Date: Wed, 28 Jan 2026 11:20:56 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tessolveupstream@gmail.com, lee@kernel.org, danielt@kernel.org,
	jingoohan1@gmail.com, deller@gmx.de, pavel@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
Message-ID: <aXnxGPNtk5BwoJOu@aspen.lan>
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-2-tessolveupstream@gmail.com>
 <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
 <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
 <500b603d-5abc-4c45-8d56-bbc88fc85b83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500b603d-5abc-4c45-8d56-bbc88fc85b83@kernel.org>

On Wed, Jan 28, 2026 at 11:11:33AM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2026 12:11, tessolveupstream@gmail.com wrote:
> >
> >
> > On 20-01-2026 20:01, Krzysztof Kozlowski wrote:
> >> On 20/01/2026 13:50, Sudarshan Shetty wrote:
> >>> Update the gpio-backlight binding to support configurations that require
> >>> more than one GPIO for enabling/disabling the backlight.
> >>
> >>
> >> Why? Which devices need it? How a backlight would have three enable
> >> GPIOs? I really do not believe, so you need to write proper hardware
> >> justification.
> >>
> >
> > To clarify our hardware setup:
> > the panel requires one GPIO for the backlight enable signal, and it
> > also has a PWM input. Since the QCS615 does not provide a PWM controller
> > for this use case, the PWM input is connected to a GPIO that is driven
> > high to provide a constant 100% duty cycle, as explained in the link
> > below.
> > https://lore.kernel.org/all/20251028061636.724667-1-tessolveupstream@gmail.com/T/#m93ca4e5c7bf055715ed13316d91f0cd544244cf5
>
> That's not an enable gpio, but PWM.
>
> You write bindings for this device, not for something else - like your
> board.

Sudarshan: I believe at one point the intent was to model this hardware
as a pwm-backlight (using enables GPIOs to drive the enable pin)
attached to a pwm-gpio (to drive the PWM pin). Did this approach work?


Daniel.

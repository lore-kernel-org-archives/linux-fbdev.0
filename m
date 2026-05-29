Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F63CE096
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065425; cv=none; b=oIktPZ4IgB01KrImiFrqHUtKCpjJlw+Ly2sRxZl/G8Acud22mO0xBPp6TstepGzJV5H3bBJcqJicjOc5xfcQ2r+WLu8BTQVjuwJ9K4iQ8rpA9vtNKcrLNEq2dcOT+/Z41ZhZJNQwA7MBU/R9a6hSJwKX2a4HnvY9n16y1o7lrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065425; c=relaxed/simple;
	bh=RdKPo/J7jz8+PTZxfMlAGNH6ifidcVIKtGtDAneEbNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnsue/67mubTjty0Pm35hLb5qFcrN64iotYc2ViZ8KZqERjl5J7GTjPhfhdyyP+OFrYUNb/ICY7ONqAmwSPfkBahp76tLpUju80nzazIEdOdvedkO7gS0bcwaxURtBVpNA7dkOuO/+mfCnVKIOPKs4l9mBvwDsZYlYbifqOQDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=QzqIvUB/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QzqIvUB/"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso12822517e87.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780065421; x=1780670221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdKPo/J7jz8+PTZxfMlAGNH6ifidcVIKtGtDAneEbNI=;
        b=QzqIvUB/274GQphujXYx6e2K07fRwbUink7XyH1YfGDfEvGwGL8qOl4eMESOqKPZ3O
         h24KLu9U1BvgZDcv6tNDUgRgxGF16phqp/iXtByqZxwLMVoyhRJNPz5jc2XJIoBdNvgO
         p8yBZ5bT/HG+ku6r7xIWv+/XV1VZNOVLCzqgMqTYKcBkPYcXFjOudRhIBccq/cFYqDnU
         5JRAxTZjdSvU1s+0i1j/V/KpsD9lKYCF7MsBWRzZAjkjy6+1/aiIktNhrnjslL8qkB3q
         Bh7lyhfm1ZJmsHuZE6SO81Akel32SlJsWhOZhfMC44OZn2qR5yc1QIRfgSew2FG+N4Ta
         e9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065421; x=1780670221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdKPo/J7jz8+PTZxfMlAGNH6ifidcVIKtGtDAneEbNI=;
        b=Inh6JgMc8bBigHeB1Bdw5QN9cAvT1wPDxE33Xfp/q/Qb+5DKY2bb1ZjeLho2URTZvD
         bZCeCT6TOpo/HTlZsl9iPfT3ONrr2bawCluNOHolez3Ik58M4HndR36YWKZrgKX5FGta
         CPzjCx9iyoSfJfgMM4bhmyE7QM0TSjGPFBuxwTIZdntMINYbNjcBUQA0KI8wlqHSQyQ2
         gMokxOYjrbazTj+W7wfUjcPLAQH25/69AZQ1f0RpTUvHSXJY67cQjfuXl7cbrScnUT+o
         pH50c2e9zII8AcOQLnw31MP8CzFIejjAgJ7usHG+V4wGH5utZ49sqduzXNmD6YCgmP67
         vZ6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Q5ynqclhWRovJCiY1wpC+9eU9mRRru0JbduxFBBR+GFzdr/nE99TjBvSL7LdzbPJhGLO5z5pdWmlejA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcRYLP/FG21iJmHGwC2SSO4JRjAu+MZtRuLCDPlbYOKUz/HBU
	u0VNHrAn3hmDVDlLR7yihV39xuXC04O1UGuJR9Q9pkOUz/mlvqgdyiwoaTR2H7UBPRg=
X-Gm-Gg: Acq92OEAqhpkSCDgJnfUG3QQIAqx44suVjzKUHyh9WVlqbHVDHYjcU55Z4GJcV7RqeG
	3rz3dZ/EM9H/MJOhKjCyDFY2cml8SSx+NKprPXnM0cGCfm1rFGNQcyHyVGrIINaucvFE0sDY83o
	rzXi6WMjd0f5VBN8FSFb4q1O+iV/FJn9C+C7bbqfLwaTnZ8cjPshJXasFqm/zQ88WJREN7f2qH5
	Ti6JOV+MfKRJ2gVoARKQTLM4avZ7XR32/IUPsyqWeDwXFTeIpPzJ7zrn+4ioEDdHKOEsYa1gyvl
	LhP/+8HLEg01DrK7QV2KIdiu6yoRlKqCwS+foxpzj2J5SGlS6pFr0q6JG0hHxj5gfPL76eaXfBE
	pRBXqIEoZTNBiodxSgBMdQSBtYXOYAavIggMYQLo8KI/EuiJZZ7Pmw0UH2+RsisVv6ls1Crdt/O
	dSysGAkcQ4g89yqMAiitCTjFmZPsBb6inIepd4jujT/9DC4g08SjKK8q61GAEBuKQBdiHLR8SBK
	2Sxy6hUzrnr9w6IS/5ce9TYHhw93rfnJ7sQHZiPHK2VczBKiheEKHeBmtraDBZSltGPCv3O+QPB
	vEq8yv/rHhs16u0sI3I=
X-Received: by 2002:a05:6512:ac8:b0:5aa:5bae:e9eb with SMTP id 2adb3069b0e04-5aa607c49c7mr35920e87.9.1780065421236;
        Fri, 29 May 2026 07:37:01 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3556f51sm3888107f8f.25.2026.05.29.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:37:00 -0700 (PDT)
Date: Fri, 29 May 2026 15:36:58 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ahmkirIuOYhd1rkM@aspen.lan>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
 <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
 <ahmfZ0tdxbVfD_y4@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmfZ0tdxbVfD_y4@aspen.lan>

On Fri, May 29, 2026 at 03:15:03PM +0100, Daniel Thompson wrote:
> On Fri, May 29, 2026 at 02:50:43PM +0200, Neil Armstrong wrote:
> > On 5/29/26 12:35, Daniel Thompson wrote:
> > > On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
> > So it's not really 2 regulators, and having regulators means the enable
> > signal can be shared and would have regulator characteristics which it hasn't.
>
> Agreed. If the EN pin is merely use as an enable and voltage reference
> then it are not two regulators.
>
> However, it is also *not* vddio-supply and enable-gpios. We don't need
> the board design to check this. The pinout diagram in the datasheet
> should be sufficient!
>
> If you have to activate vddio-supply for the backlight to work on the
> board are you sure you don't just have a misnamed vdd-supply that needs
> to be taken care of? That would make much more sense given the datasheet.

After posting this I figured there is another possibility.

If the host GPIO pin is not capable of delivering the 1mA requires by
the chip then the board designer would have to add a buffer and that
buffer would need a power supply... and that power supply could, in
pinciple, be switchable.

However if that were the case then I don't think the power supply for
the buffer would belong in the bindings for the sy7758 so I'm afraid
whichever way I turn it I can't make vddio-supply make sense.


Daniel.

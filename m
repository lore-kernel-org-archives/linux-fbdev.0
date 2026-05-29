Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CF19D8AC
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051578; cv=none; b=S8BXAdrJeCm1e0kR11oKhsiKLYl10ZMWefcQTBvYI9lnO1yD8FF0QhZuZmrw4D4OYJ4a6RtIFMMzQlUJn+4skk9zrN/WupQkR45brj7G+NFP4/hQuNKSg8vCgSXtP9DFds/5quLOXU0ZxmjYa2Hi5XY+sw8d9bwUwYU4jBlACM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051578; c=relaxed/simple;
	bh=PC7iK9ghcLxujaYe1sBYImcNs1M2UD/XwoVRZxYo8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIEnA9HRbhmiAiF10UPloa6gjeHR//r0xqv1hqbkIKru6GBG6/oyujMfa3tbSTqPkP/DuKlpseJLF5sbqIN4MWe36QaYpoRkhA+2daPFmzZPv7pCFyBNJwAWIr6V07dtn+K2xVXGGOH/LQw2vFIK57n+dDl5GCD/Nxs2zt9o8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=zwU9yVft; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zwU9yVft"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso71596835e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780051575; x=1780656375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
        b=zwU9yVftHiw7UtVLWMcHYevsKEfqZYAWigwYheqPhdYZlvm8e4msra+RbQhd4mI+ol
         G78DepAsFnn//3X4TY0w6AmZJxVwiGdxDsB+nGPh7iYo08LgaO34zGp/B3hciSq8sfjd
         GHgT9hxe/ain3P82qfGvV91ElkJ4tShBbGV6fZVIv9SVORF9TPur7HVvLaBKOPTfLtjS
         VYbeAAN8NZ93SAm1LZbX4yniFkfxBqw19pGpeMcLdVtqCLcbl9RJvbnpfeCjO02kqWz4
         B9LEk0PlssblBjTypvJ1BCPNHxueCsdR+KpvgjAm9EpTdvWgQNibqiYjVIVZjoJwIh7I
         YnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051575; x=1780656375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
        b=U00PM8VPYFBbcXDSHRkoB5Xnh6P7AxRGv0etiNtv0ZqD1SRyBnoGsTujVh/HrdbSqD
         amQ8+zjg0qnAogXp/eKFLFTO37sDoqhKMu6of2qANgO4YVp1xMYD0cqrmgX1TL7KsBy0
         U0C66TtVAlQLHif63Y0sABaqZkqfPquuV0q/62jZMyvErW+s4Wq/+xh1I2u9/j2OSeqg
         BBtXKEWKwIvT8RFLD4rcu1A4jn2r8GQfcEzrUiOKNp7hsMtW/FukhvoVFwkohgOqOlTr
         WtKcFZY7E92j2QSecLofvCq0L+D1vPuquECaRe87XBI66vLJJyE/mhqsuidafsoKtBvr
         Ry2w==
X-Forwarded-Encrypted: i=1; AFNElJ9l2JWM5vWcvCHMaCY47dbmJwB7cQfRvx4fvGvlkKuXU/2hnkNMY5eQKyU2Pez4iZ63saObGj/jBeHenA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUwYvpG8LlPHIF9tnFWFzpeGuNWw8sfgnoSPIGgeFaAnCcjOo
	Kv/f2pT4ex2Tiu8fLawKlX3O0hjnlKYyxtBgrg/JfAVUkyODJCmeEapsDy5D91c56n0=
X-Gm-Gg: Acq92OFELdpBRsC429AUDgHkhCjEmpvRqnjAE6pbDYs1j2xvuIKnWDiAzqSIKO06ZyE
	4dac2lfUI1ZkU6WMMOjc+o4sC1s/ZmMmVg21hNjy1gu8AD0h4rbr0u7lhWThf3h0zhElAxjvOtU
	KNsuX0hE4MCo6TSU3nSofvQ96AKux9esEHlcFw5CTpibcrjbKMVXjEA0A+CvnYNvvoxUKaF2MXL
	j/L4yEu2UJAr/9hC9UkUU55DWsCZk/KMI2Ezyeap1dzNvC1KRiqZ9PXQKJYHFBdg7eieZX9xucu
	/sjWQZw/g9PIYiTbGK3WKyW9446d922JPtUSShSEH55ad3KRTtnQuhIIDz/MAuGdub1KA7aDUDw
	0WV5k5AHZqPWoJy6U3VxTtz/VWKJ1ZbpTqwCQGltD8JvxzZSw2a9EOwm5Znx9+1C6qEVfkgRTa2
	1Jh1FzI17CjKid0x/QSQvxNxPCP12ZL5YbK+1zDu9JBHg1IJxWzgXQm3/EGmkybjIDj0avggqtv
	xOL62E8ZeeRQCJluyeZ0KyazfcR2Zq5GPTgRf7C7teEdEP+Zy+4+rTXDPq9Deu/KNSzgNrBARpH
	NwzDsImTYzFCoVeAUbtGpbDMP2zG9A==
X-Received: by 2002:a05:600c:574d:b0:490:778:4fe8 with SMTP id 5b1f17b1804b1-4909c0ba8c9mr28839315e9.25.1780051575110;
        Fri, 29 May 2026 03:46:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm41024205e9.1.2026.05.29.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:46:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:46:12 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <ahludIZPMUlPDTG_@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
 <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>

On Fri, May 29, 2026 at 01:07:50PM +0300, Svyatoslav Ryhel wrote:
> пт, 29 трав. 2026 р. о 12:51 Daniel Thompson <daniel@riscstar.com> пише:
> >
> > On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > > Document the LM3533 - a complete power source for backlight, keypad and
> > > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > > converter provides the power for two series LED strings display backlight
> > > and keypad functions.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> > >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> > >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> > >  3 files changed, 304 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > new file mode 100644
> > > index 000000000000..866b0fb8ed04
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI LM3533 high voltage series LED strings
> > > +
> > > +description:
> > > +  This is part of the TI LM3533 MFD device. It represents two high voltage series
> > > +  LED strings for display backlight controlled by the TI LM3533.
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/leds/backlight/common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,lm3533-backlight
> > > +
> > > +  reg:
> > > +    description: Control bank selection (0 = bank A, 1 = bank B).
> > > +    maximum: 1
> > >    <snip>
> > > +  ti,pwm-config-mask:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Control Bank PWM Configuration Register mask that allows to configure
> > > +      PWM input in Zones 0-4
> > > +      BIT(0) - PWM Input is enabled
> > > +      BIT(1) - PWM Input is enabled in Zone 0
> > > +      BIT(2) - PWM Input is enabled in Zone 1
> > > +      BIT(3) - PWM Input is enabled in Zone 2
> > > +      BIT(4) - PWM Input is enabled in Zone 3
> > > +      BIT(5) - PWM Input is enabled in Zone 4
> >
> > This is optional and the drive implements a default (zero) that is not
> > documented here.
> >
> > Is zero a sane default from a DT binding point of view?
> >
>
> Yes, if property is missing then PWM input is disabled which is
> equivalent to setting all bits to 0.

So the default should be documented in the bindings?


Daniel.

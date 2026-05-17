Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C435DA41
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028045; cv=pass; b=eyVTPJOnEKPQiJeXGDifZBKWY0RLimoPBYTjRKeIrhlS0SPuUYvWfS3IZoH7iUFk9uy/P+mmAXQ2BYcUmXDUh7NEFomd4f+xBI34e+Sr8NPg63wCImHUh9jkMAt4QjmDjyw28b+tyDam9N0Ae/arhCtnxT6ES5iOOMRvsT25lOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028045; c=relaxed/simple;
	bh=IZHMWs+8Cp/KOe0MB2/iet7ivwJo1nP+BQO/cuxTsWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiXwVopFkPuJQ/gw6pyAXTArJxHS90aO97A/CBoAPF4+r6oml/jq64sUjCucwabzE9q0ICoKxfVe/+e5U9cwqrbOc7+qTzR7k9lMyJjI/wRHCmnYdtFK7U01EnZ4whvMptpTq2U87qwYQMLSqZWu8/rMJTdFzunQp6klLR90yjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFi8kcNN; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFi8kcNN"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ee990e8597so4361967eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 07:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779028029; cv=none;
        d=google.com; s=arc-20240605;
        b=fexP570ZfIozZQOaq4Vb599XbKKS3OW1SS4izdvYZHY5WCzlYierkoU+tkOzq9XHCn
         Cv+6mKyFrogn41T88a4yf6+bVokruAsk9rTdG/6PoMNjpSjYzrcBPlOfLD12m5zJfs+I
         IvpfZKA23ANrFapQZfLwVsx0jBgn+jQF2k4R6Jlggb91gqDFLQeronIx8q6vQBLqc83v
         w6+gU0slLEV5t8PyFCr+sS78f/x+EdWlajjnYStFWrvHZElqife7tN0OX7l3xDB+WFy5
         6JPCb5iUyCyfuJu+KNli0/ceMKptl1wwAg+VpdcxS9jU965bnzFY9w/gC2cXzbVe8Dp7
         3twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        fh=JEUVeHsN1BONTf5+yjto2b4wAry1zS7A8hAzD/xocdw=;
        b=SFHpHp7w6eiQ3t92tgM+3xsKDwsTPPUGn331mUvY59Iz8NLvoJllE55VIZh5k3zyGn
         wrFGAwhih6Kz47rptcNBbQb+12242ACHQbpA7CA9zdnUjxS6w7BdoWDWLf2+Iwet/E00
         fiJ31iYFXelk1rU5zA879/FDfFCP0akltePMLypSdpk/wmpWNBfMJFx8YmL/6qu9Ydal
         /y8uq5Dz7mwUhFcVxJUfbmDK+b0rtb0M0hd2XkIO4ft/yXFEOnhwFKMd5bKNlMIviTTj
         T2sxJXsu49Z27rAB/Jll2dDTjVkWk2qeTZUxLcRQEp1YnxRczQotjqGQ+WNbzUEY5yJO
         RsJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779028029; x=1779632829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        b=LFi8kcNN3DmGtdifJZsCdIXVMuz9BXu6AWo42tERT5aeZAQajuOZObh9y4TqR/I8EX
         AT/seDSYZr0I1pYQMHeN49IMfkGU6SzEdMNVep2hXD7/zUWvmdNAlUC/Sj+Fx24bkJzo
         MbVFCm8aiBsZ9y1otZ5s6ul5RtqaW5S8iFW4kLPFcdUJ0GaBqx1L7Siu79N1FB6SDlBi
         15YF7TI3oYyD9jBmbH+WxspMMvcU56xqagV17S0cK4XGnZIsPmPSzwmAnZhzGa1YMQBB
         HZh7yFZ3OMkOKwz5EUoG79Gz0FC1CcuvOuoLcmiQ5WrC0hWen/gJkWOjzgmjcP8hKdNs
         Xb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779028029; x=1779632829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        b=Jx0VhnO4NhXa9hG44GeStWalbVpEaGrCCbsXKi11l9mqP6/SOW0KHp8iyctJH4yJcz
         sOcFNVhUq7Lb+Qv59p7oPVgF1ffiJD+hSWGcXfl4muYYOfY8N+AjBW9GuI1rfgALZNX3
         PtGRS8nHS3xLhx8X8XRcNfOV+OBmb2ENiCHPRV0jWO+4PCgegVd/0qipiFaNrcqp9o6p
         uBXq3fjo/Mzhi0aMbUnN+Y8pseG4cSG9XXFWROtnBKiRE2i1fvyrzSh5DyJFCmHPlP8k
         Z4T+5nXBxuEgRjsMZGNSd46vQ1TISurNL0eMlSn5vUCVW2Okcd5x+Jd8r3eS25RAMuOs
         7eTA==
X-Forwarded-Encrypted: i=1; AFNElJ8AIwacIiOEstUzUCiXH8LFeyid97xwMCdE1Oxa7x550zNUOT9CxXy7l3E/KV6JRpLoh3bKCIS3jTG+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cP+pwtA0S1MDNSkgxBkuEm3HschijOuWZvBAVxyAfUSG8F4F
	8TYE9LpHwprtR6g5WjAmLWBgRCaVV2q6/RfyN/Bjf5QAg67YAjg16NWF8v2AVHT+fxz/id33mu0
	BA/2qB3YGtiSOMZw1tBUNT4tARmv+nxNsJA==
X-Gm-Gg: Acq92OFjrk/LZvW81KhrOn1wxCQ81AbhFii792ekkVwOjDZkLJn6Sr41duTkqrh1cn1
	ZxV8BQy+Qove6ald+IeZsq9etfFw7WGBPAMLmFo9loQloHUtmGujNosV4QLn/oqZ/pI/6YghtYD
	BslZsu494hDmgIcf7upto0Kv9SktjHv23Kllb0fX2fREpXCPw0BegxCGtYCaYU8MMl+MSC3/Liu
	sdwZl58t/VuhZQk6TXejjCn7i8Gpq2nBP9H7v90PhiHcWhWLssu/Gak7cCxJFIWrCiG9NzPKFq6
	SjENYrAL
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30398680c36mr5240683eec.22.1779028029014; Sun, 17 May 2026
 07:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-2-clamor95@gmail.com>
 <20260517144453.61cc210c@jic23-huawei>
In-Reply-To: <20260517144453.61cc210c@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 17:26:57 +0300
X-Gm-Features: AVHnY4IEMjYjQh2-EeqHWPNZxgaMpOfNHnP0k3ytWy1tFi4KeKl3gs6PRb7odls
Message-ID: <CAPVz0n10naSo_1n99orPGM4U8iDkOn1DW9Xe_RGE56CMpLm8kQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: leds: Document TI LM3533 LED controller
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:4=
5 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026 10:43:01 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Hi Svyatoslav,
>
> I focused on the ALS part.. A few comments.
>
> > +# see ti,lm3533.yaml for an example
> > diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Do=
cumentation/devicetree/bindings/leds/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..2e200f172400
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > @@ -0,0 +1,190 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: >
> > +  The LM3533 is a complete power source for backlight, keypad, and ind=
icator LEDs
> > +  in smartphone handsets. The high-voltage inductive boost converter p=
rovides the
> > +  power for two high voltage series LED strings for display backlight =
and four low
> > +  voltage control banks for individual LEDs. Additionally, LM3533 feat=
ures an ALS
> > +  sensor support.
> Mention it is an interface for an external ALS.
>

Noted, thank you!

> > +  light-sensor:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-als
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      ti,resistor-ohm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Internal configuration resister value when ALS is in Analog =
Sensor
> > +          mode and PWM mode is disabled.
>
> Good to note why this is a firmware thing rather than a userspace control=
led
> thing. I looked it up, it's because expectation is the input is a current=
 from
> the external analog ALS and these are used to convert it to a voltage wit=
h target
> range.
>

I will include your explanation.

> > +        minimum: 1575
> > +        maximum: 200000
> > +
> > +      ti,pwm-mode:
> > +        type: boolean
> > +        description:
> > +          Switch for mode in which ALS is running. If this property is=
 set
> > +          then ALS is running in PWM mode, internal resistor value is =
set to
> > +          high-impedance (0) and ti,resistor-ohm property is ignored.
> I'd mention the ALS is an external device - so this is saying what interf=
ace thing
> thing connected is using.
>

Noted

> > +
> > +    required:
> > +      - compatible
> > +
> > +    anyOf:
> > +      - required:
> > +          - ti,resistor-ohm
> > +      - required:
> > +          - ti,pwm-mode
> > +
> > +patternProperties:
> > +  "^backlight@[01]$":
> > +    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > +
> > +  "^led@[2-5]$":
> > +    $ref: /schemas/leds/ti,lm3533-leds.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - light-sensor
> > +  - backlight@0
> > +  - backlight@1
>
> Similar for the led nodes.
>
> > +  - led@2
> > +  - led@3
> > +  - led@4
> > +  - led@5
>
> Curious - why are all the led nodes required?  What if some aren't wired =
to anything?
>

This is limitations of mfd devices. If it has subnodes, all subnodes
must be present to reflect mfd composition. Unused nodes should be
disabled.

However, I have asked Lee if he is fine if I will program dynamic mfd
composition based on the device tree. If he is fine, "required"
props/nodes list will be reduced.

> > +
> > +additionalProperties: false
>

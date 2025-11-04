Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D52F0C6A
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Nov 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258251; cv=none; b=PdsQ4wXxatAMS6Qp+XfyvBeuxYftPUdoxOkeBBi7XP9f1dvbcCLZriPh4HNLsd8QgpUJHsKodCiGCLc7Y/ZPMbBsumMsw5ectTL9wphIbnu43FkNp4mcjMOLpIbWHu97i/lenvFu8dnmwUq7iyEFi7H6H8RHXZgTYsUIqMZBt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258251; c=relaxed/simple;
	bh=Dzj77OltBvkgDDn8952TkOFzMhRy0pNivm62rHqrknk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYc7EEbOW3rgv4FKzbkUiRd5/tNMwnMc9EwTjt7w0khMJOSIiDIcLdn/daajy1E2AFuGdUe3SREay75JWbp8k533RWgdgCa4fBsheCxgjNDN6NnmdeCaVU1b6WLVJ8aqBouFYKGxe4dqrlR8/LWuZ7Q4LnAkuCNEEAvFREyICdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kllIFGal; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kllIFGal"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b4f323cf89bso211723666b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Nov 2025 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762258245; x=1762863045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzUjjBieESWl/eKHRRME8VO1FyP4Xh2Gr78dnGWZR3M=;
        b=kllIFGal8Q4VzaPhV62Wo8vb1RCA1Tlz17GOkGw/P9pAOwOlZQehgqE9fvwNGIf1Gz
         kj3G7ArTvZwlclxlcAMAs+WOBDyZodPmB9YbunvvcRYOb9/4QOLVY3FyvoECCAH29zf8
         QiqH9r9ac0H39gb5SS37rXRQ8RJmokz3j7DsrZPazKXmk1IzhHJ1D+yJTvo/hcr69+cF
         KTWJnkNPdEpfBkozGuhC77XXGM/NQ5jEuj0ie7QtRvhfAxvtNw2VOfPz1/JA2yrDvU5K
         MOUpHFab+UOlg5Nwfcm7GYaGBNqGlELLSkwvk0ru3Kov/ndutsqZEAcDyim3QdEi/Agr
         iB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258245; x=1762863045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzUjjBieESWl/eKHRRME8VO1FyP4Xh2Gr78dnGWZR3M=;
        b=pBvJbtIDWE+Mf6VRDqYee1IAZ8tA2DzkCEF0CfKpnlrFkKmopzMLz8PnQYcFNPF4U5
         w7NIE4UnrkKiQwobc8/1mD7yLKhgcFcbMbeyHpTuAUMblgXT5rr4I2RM2dciA2l6s8Ou
         WNKH1NaNW7F6XlcbLEREcxayDD1CtfNvGittG+8G5qVQii3fmIypVeYc2qoruYYNq2G6
         3Af8ZsKOeMBXcTmOxy/DOhvwcd2MsUZQm76nKWy3AzoU1wUYLurl90zfeZ2KyoHny/+U
         EXVepBf56EehJE4bEZD3Ng6C1SC0b5Rm80kzW6iBMFIUdY551aEUG+Qmup542aH5cTGr
         HV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTpeUEN+Ql2WRUKYrIKqwUK8ieZIr6G7V1W151g04eXAxOM052PUHQoB5NPq1XaOQwJVtziHq9394dzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUd8KjAploaJvCBnln469bVmUgM+/S1C3Q/7x67wwpAp6NqKx
	jtQsE6jusiFI/gCbSb6W6M3Q0Yooh9NU100jh8lc7YINuafEpK11US9iZc7UVmxESbVqvPg+fg3
	WigQBI0vEEldM73dp7tHkW9DFn+gmfx4=
X-Gm-Gg: ASbGnctST2yFwhnvx4ElWWoGKSE9JegFrZ8nIsCIXkFMV4aUR6LqIRK5w5vXkHPmOST
	ulg+coQnTgBCvX/UOirxWZUAHOdADJrfuTCZIdWH9B9sfTQfB/a6orn95BcBWbVJalpyzAjQtYo
	VoFJj3zpBWeuJyISB3ArTFm0ftXaX3IVd87cu9/xJAylgjG2dMMGYqPHCWvU7vpMrXJSzStLGJv
	ZKVghQSgLr6MZ4uRfLg5vB+YdtgUHinwgyEYjS7KdJUyLUa2FpboAWkoQBZ
X-Google-Smtp-Source: AGHT+IFYNmK4p8ZzQreCCOl4PXO/MkzLrFaWoACxm/O8s2bicL/zOLsbm8jPi41+2YZ1Lhpc6tL1AcArgolgsFl++YU=
X-Received: by 2002:a17:907:3faa:b0:b72:5983:db09 with SMTP id
 a640c23a62f3a-b725983e06amr109317066b.32.1762258244771; Tue, 04 Nov 2025
 04:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103110648.878325-1-caojunjie650@gmail.com>
 <20251103110648.878325-2-caojunjie650@gmail.com> <20251104-dancing-panda-of-patience-49bcc7@kuoka>
In-Reply-To: <20251104-dancing-panda-of-patience-49bcc7@kuoka>
From: Junjie Cao <caojunjie650@gmail.com>
Date: Tue, 4 Nov 2025 20:09:05 +0800
X-Gm-Features: AWmQ_bkkyexGfBD5XHzrBd-xICWXFb2FCbbahEGY3fitC4E7OLdD5Bwvl1yJFfQ
Message-ID: <CAK6c68iy0vwgKJTgXr=YptyENTWC1MJrsJWsbsyp9KQkAtOYVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: Add Awinic AW99706 backlight
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 07:06:47PM +0800, Junjie Cao wrote:
> > From: Pengyu Luo <mitltlatltl@gmail.com>
> >
> > Add Awinic AW99706 backlight binding documentation.
> >
> > Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
>
> Messed DCO chain. This wasn't here, so you must have altered v1 to add
> some weird change.
>
> This is a blocker, please read carefully submitting patches and DCO.
>

Apologies for the DCO mess.

The tablet device is currently with Pengyu. He helped with testing and
tweaked the .c driver file (patch 2/2) after my change. The entire
series was then re-formatted on his machine, which caused his git
configuration to be incorrectly applied to the From: line of this
dt-binding patch (patch 1/2).

I am the actual author of this dt-binding file. I will correct the
authorship and DCO chain in v2.

> > ---
> > Changes in v2:
> > - use proper units for properties (Krzysztof)
> > - drop non-fixed properties (Krzysztof)
> > - add properties(max-brightness, default-brightness) (Krzysztof)
> > - Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727=
-2-caojunjie650@gmail.com
>
> ...
>
> > +  awinic,dim-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select dimming mode of the device.
> > +        0 =3D Bypass mode.
> > +        1 =3D DC mode.
> > +        2 =3D MIX mode(PWM at low brightness and DC at high brightness=
).
> > +        3 =3D MIX-26k mode(MIX mode with different PWM frequency).
> > +    enum: [ 0, 1, 2, 3 ]
> > +    default: 1
> > +
> > +  awinic,sw-freq-hz:
> > +    description: Boost switching frequency in Hz.
> > +    enum: [ 300000, 400000, 500000, 600000, 660000, 750000, 850000, 10=
00000, 1200000, 1330000, 1500000, 1700000 ]
>
> Please wrap code according to the preferred limit expressed in Kernel
> coding style (checkpatch is not a coding style description, but only a
> tool).
>

ACK.

> > +    default: 750000
> > +
> > +  awinic,sw-ilmt-microamp:
> > +    description: Switching current limitation in uA.
> > +    enum: [ 1500000, 2000000, 2500000, 3000000 ]
> > +    default: 3000000
> > +
> > +  awinic,iled-max-microamp:
> > +    description: Maximum LED current setting in uA.
> > +    minimum: 5000
> > +    maximum: 50000
> > +    multipleOf: 500
> > +    default: 20000
> > +
> > +  awinic,uvlo-thres-microvolt:
> > +    description: UVLO(Under Voltage Lock Out) in uV.
> > +    enum: [ 2200000, 5000000 ]
> > +    default: 2200000
> > +
> > +  awinic,ramp-ctl:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select ramp control and filter of the device.
> > +        0 =3D Fade in/fade out.
> > +        1 =3D Light filter.
> > +        2 =3D Medium filter.
> > +        3 =3D Heavy filter.
> > +    enum: [ 0, 1, 2, 3 ]
> > +    default: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - enable-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        aw99706@76 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
>

I see. backlight@76, thanks for your detailed explanation.

Regards,
Junjie

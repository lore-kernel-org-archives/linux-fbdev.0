Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4A33A9EB
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049285; cv=pass; b=moeryRk+vpO7Fx0XuFPLIxKyJDnpCxf+jMYcJrSM960faQQGp6BjHqnVfojvcxb7wr0pVd320BCTt/no0oEMc+dj/0ZZC2rPOwCFROg3825YDBU9UsDMfAomp/PBgnyUMQXD6ngwCHjiLUxBA0RAPhw+HkZ9PdUpLhwQyKI2RDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049285; c=relaxed/simple;
	bh=n8g9nbx/cd37EQYdG35MTeP1UwCovHHBH5OKJHp+X0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo6YeJMhY8sBHpMTGh6WTSJF0n5a6Q2EqSJwOnSAMuLbEwIqyVlE3/jiI0GA82FOZwsT5b4IPgfN2CDAxF7Kq6oMmr59pvuAbIxqu0OEcmIpwvci6BZcH8UrTmkuK5Tk+0SPQY5V52N8L0FXDOm22xOy2688LLoKnengBiWyZlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH4EWJZk; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH4EWJZk"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d8e3bb72so140205eec.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 03:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049282; cv=none;
        d=google.com; s=arc-20240605;
        b=W5cV7lbik1bOa5XopjFujAYO5pEAt2Z2/bVcrP8pvojbMtr2Ac4HCoO9K0mZp5dsIT
         NSbz1HrC4ZxQRvF0G+nNEB9fiXP3tWFJSy6oIu2ESPm0Go3l6SOt3bQpfNVs4ErfVjYt
         LEgibdPmaGdA4ZXUrCZhHT+Ql/7eW6EVJn/BFW/hQCvD6ZxGVw1NueoZRwAC8aVZQm6m
         fUQ0rFF+lX2s/6CBqcGqpa0V6M8BaQutxUMScjdcCzZlikMgRmg2fIHZNTJXFP2lpw9U
         Yp+d/MFBePU4ZQQYBh1BGg+QmXA6HgLNSqvaov7cZ6lTv5uMFtmdbW+DwKqoVVG5n8EY
         MJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        fh=my8eBbK0QkwmvWhEgs4iKPGYV6WrxHrJ9PRzU9onIaU=;
        b=RsNAmv5Q8ztQfEbeSWy6q8eueZLhWOM860gl2iVNDgwpmW2G3AGowCnq4Y+7CRWzYV
         o6UIhL5jIX34WOK7VM+j5F8IfImWw1yTqcVmfZEFaqFXNU2efk7F0X4K+9YrItVlCgp2
         8LbH7gTLj5BagPC4iuFzQIXfVdePYwLP6QYiSoi1s1NQLAbrChvemluNtPpfvZxyjT2f
         j41pf6LddEiEUbYid/5RzqP/wtWXtVuM1PA9wt+bTfygxxhSFxEr175G5M0TtHPnUeoY
         RCeUDAohs1x305so4SK3dXyu5g+iwkaXHpqFqev6H83pfB0ohhKDmx/oUWtlr8it8oSr
         bI2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049282; x=1780654082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        b=QH4EWJZkM2Bz2/Mg0D+E46mMWqXeiRUbecZwePs2Hf0Ke45z0GnQXgMLZrfAbndRM6
         /SLcdaAIjjw+clpICOIglgob62aMWcsLxyAakx+yykiy/WBwkKl+is6jGpCCxiubC6sf
         6rkBt+TeMUfXH6yKv5Szv9/D7Qt8G3qdkJDdI4SxxLSqcmGwHNRvrmS7ehAFuwPSLJAL
         5xz6RDmFcmTzK1U2kiMcPVwKzwN1zQWcxxqQdxUpBXyHuh6Vu60KN8Qe+jXabz2hPjkk
         +WPJ0oyCmIhv75bzm1Sl/LbRS8Z93q8f5yk1Sw8eIYDoavWhu1EiK0nOpKFBUx7RNk4q
         ihcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049282; x=1780654082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        b=aHfKvjfkPzHS0NsO0s6pGXdlNSrbg7Hjnx34yi7F7HqyeNFw+wKQlr7L2Kd5GzKe85
         4wkSzRAiIp+FW5A3PANdDKVeutoqijQ41gLhYlf203Tp883pawG/WbIfUhGDens3nY7O
         6JHF0ABH09tmfpz5dpB4+f5sALrjGkJthPEBgwfEeMPuj/sml7lCwwJ7aBv/T6J0DW3r
         bik4Qz+ITynmzNl42+EssB2Jsfw0ApOYETD05Pi0iNyllAdPAF2YJu0jjD/RCMV68Ejt
         YrPFRfREj2Iut9sJiqsezfBMmdhVSqPdRxQ4vlmoqckVG+5rlE94V5XnqAv4kGztxVdF
         yOEA==
X-Forwarded-Encrypted: i=1; AFNElJ8oS9T//LFyw20XUPuWhR4TesFofR04J1+GFR/xFZ0L21llc5R1IIuL9yr414r/+OteUi7+LeRJaeX32A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM3jMAkRoo5pqWwGQ8neHFjLPeqbNUySg/Dcao8gnAK/ioKxc
	npP4UmlfhsPDitmAEUKUbC7o6DEkrDsU5U9Lo8CGrk+4Y2+DJdw9J6rWLoiuXjZpcUO3Se7uV+z
	1RJ3+qME4IPMiwsXhoJiR9w4OSzck8LY=
X-Gm-Gg: Acq92OFvK3+LMb0VBqztQN33XE+0pe9J6+FVI4xkLSG97liSuqwVnMsh7hjFK/5k3JJ
	Oop4zm4WsuqVuWCy26jxyPSBJ0XNFO4p/nTmU/nE88CPvbnZq7c22RLo0yUs2DmTLkIw+LFSptc
	GPSZFGZ83UY3UKckP2H/uejWf8OxtV7fvkFxOsIHM6tKb5xOoLe+eckZxoEvz10yGRk8A4mPFjd
	vNevLPlIKINQzSOghAgx9Vtj0ahhVVyrFDI/IXFopiTTgSTgnSej0AqxqCX3HwBYSEx/eGcEyrj
	9w1G9r7p8Ya1P2o1jO4=
X-Received: by 2002:a05:7301:6093:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-304eb228f12mr937539eec.23.1780049281982; Fri, 29 May 2026
 03:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
In-Reply-To: <ahlhinOh3NxB7FY_@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 13:07:50 +0300
X-Gm-Features: AVHnY4Ju4apl_6PVevGT822qLIzQw2MECBwLZ58e2K1CK8Q_oHMtYlAD2TA9TPk
Message-ID: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED controller
To: Daniel Thompson <daniel@riscstar.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:5=
1 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti=
,lm3533-backlight.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-le=
ds.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.ya=
ml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533=
-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm353=
3-backlight.yaml
> > new file mode 100644
> > index 000000000000..866b0fb8ed04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backli=
ght.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 high voltage series LED strings
> > +
> > +description:
> > +  This is part of the TI LM3533 MFD device. It represents two high vol=
tage series
> > +  LED strings for display backlight controlled by the TI LM3533.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/leds/backlight/common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,lm3533-backlight
> > +
> > +  reg:
> > +    description: Control bank selection (0 =3D bank A, 1 =3D bank B).
> > +    maximum: 1
> >    <snip>
> > +  ti,pwm-config-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Control Bank PWM Configuration Register mask that allows to conf=
igure
> > +      PWM input in Zones 0-4
> > +      BIT(0) - PWM Input is enabled
> > +      BIT(1) - PWM Input is enabled in Zone 0
> > +      BIT(2) - PWM Input is enabled in Zone 1
> > +      BIT(3) - PWM Input is enabled in Zone 2
> > +      BIT(4) - PWM Input is enabled in Zone 3
> > +      BIT(5) - PWM Input is enabled in Zone 4
>
> This is optional and the drive implements a default (zero) that is not
> documented here.
>
> Is zero a sane default from a DT binding point of view?
>

Yes, if property is missing then PWM input is disabled which is
equivalent to setting all bits to 0.

>
> Daniel.

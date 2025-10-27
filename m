Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF22BE04B
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548350; cv=none; b=hda3uvx5avnL7bzLBiKjNC/ErPlX/8BBu2hFRLQnSTtzOHvjpKmh0HxPIOOJM8zqApYA80qY+67d64E0bO/nPDIgUQx2hJ+d7hstNF4AANNuRcPk1rl6nkzolbxlSIOqooBB1EjqOKexwr1TygB1l6PwaEvvLf26eCJ0R3E1968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548350; c=relaxed/simple;
	bh=yLiitsiaftwnng1FNqD31hBY5W7XwCrFjEgrC73eW6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGVzojBb6GkAODUeU6jx3j+9TsOGWlJxZWU4XZjSP1rj3QZa320GnsbqEQ2VVwPLWj9cLcwaIKw35FprX5uu6xkopRmbIjLTAw5E9A0EPC+Y8U8XIZ/DJkozurAU05OqlkVRGdgiMXzrH804aZsjjzbuUCBMpTKuQu0DDTj7hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7bwThEk; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7bwThEk"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso9325692a12.3
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Oct 2025 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761548344; x=1762153144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gORW6RzMgWR3pCXy5E9wgSn/fbVRWV9iD4rw/Tx62iw=;
        b=f7bwThEkW9kjmiTOYSGIJ71YsxMgBRGmTYslYhyophh2krXzvwXp8qHIKRkrkpkbLD
         7q9F5uxzBl4UQ7CUtSmqnniRTRYdT/9+EfU2X0mQTr81FJi0dtol+skzjwTlb4urZvdd
         M5ICewhXmhwOaOtpImVT695PADN6AycMZbVmzOoaBHKiJdyIgPU0+ziiMfZmXbpDgO58
         OxTL7+fxJtkaIWWF3oV2t5frp/gfN0rCaIIB5yFzx5Xm+GQ1QaIRAGVx5j40QeYvUjcK
         D+9n5DE06dB6NOdxtTUWtR0AuO9LRTLAS4Qq0J/QGJVxcQh25g/HuNkisdW5+ZhaHnJU
         1zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761548344; x=1762153144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gORW6RzMgWR3pCXy5E9wgSn/fbVRWV9iD4rw/Tx62iw=;
        b=NiB1XlZFZ+IUTqdb85/ibCbb9SoqPldZ79yboihJxHSRWF/fX3qcBPuZfDG+94mnUw
         BEHDGxcpMkOIcdaMKRrS60J+/PQTr2uD7eZHC30Xb9KU54/Or7+0GH/hAMMRbKQ98AVP
         1l+etLmWQgZbeo1rRI49jmhHyDRsoWug8XAQltXqPLULVcgeXmTMV2SXWChNfRR8hEuW
         9wtkx7iR5WAIaX0vLtgL1zCVk9VT4lRyifqYuucUT9QaUfc+IVMV2ysUvD86eXW8brfd
         DQnaFZpwOgHof1m5fQ7nLPQOhw8VUYtGULTgHFQtVGceRv9+EHwN6/3OHhzkIuxEXQ6W
         1W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtadRpjPol4LIrMrJKqnKdwIoqZkQVQPInNy+w+94ix7YeydwcP9V/MJANyRheHsThv1pFUPaGvu6Wog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuGRfd+PcVYf8Syecw9IvWgpEuCkwktWBkIVwpvprsurNbmCp
	5txySz+bIgweuqysA2r8Ix3xEIP1P77lfFrrIPrQ6ZVo2KeE9p6Jyvcd4jHEIhYjQ0lTmw9Duxb
	LB6gMPQb0nUyKxf75cOVT+Y5bQipPmkA=
X-Gm-Gg: ASbGncvx+7Bu4X1KxxbbhIMAojwcGY427f7l4FKSAhKYTmJNyiLHqGNp6Ah2fZWRJMA
	GyvCgQni7R5RLA+KHmI/Wc8+mSfqcXWPncwDKK1xfh9DJt0Q8OeIE9cdisGjejPg4NkUrmlEMeg
	+CPBTeZlG6EVyf4hU4Js5k+F4BasGsVfg03iJTxjUTq+wDoou7ey7YwGdTliilXp/ppkr76GxTb
	8Ko43WYmJuArAxgLuMmJeXwm0Ut1Z26pg8NmIlEij0Vl/Xf6Co9Ldfb8bnRp88nWZbITefrpGrG
	fxf8Fw==
X-Google-Smtp-Source: AGHT+IGj1lyRw0Om+NZfHG7wsV5wmbuah2URTGrz7PyOIc3h8h8uykLzVDyCv3r2N4k1sj1rNHO4xIqOF9SGnYYISNI=
X-Received: by 2002:a05:6402:1941:b0:634:cb54:810e with SMTP id
 4fb4d7f45d1cf-63e3e586b6cmr12920258a12.31.1761548343474; Sun, 26 Oct 2025
 23:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026123923.1531727-1-caojunjie650@gmail.com>
 <20251026123923.1531727-2-caojunjie650@gmail.com> <c17c10d4-cc1f-46fd-8719-e7bb9ffa91ba@kernel.org>
In-Reply-To: <c17c10d4-cc1f-46fd-8719-e7bb9ffa91ba@kernel.org>
From: Junjie Cao <caojunjie650@gmail.com>
Date: Mon, 27 Oct 2025 14:58:51 +0800
X-Gm-Features: AWmQ_bn4pyB-a8JGS6VOEXrwwtzP__Kqn7eL_CWe8p8AnY7T1FRYBRpGwHrdOZQ
Message-ID: <CAK6c68gqHMR-FpH3MY9E_9R+V0J75V9zOii=x81e+bRcnBYOig@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99706 backlight
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 9:48=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 26/10/2025 13:39, Junjie Cao wrote:
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable the backlight (HWEN pin=
).
> > +    maxItems: 1
> > +
> > +  awinic,dim-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select dimming mode of the device.
> > +        0 =3D Bypass mode.
> > +        1 =3D DC mode.
> > +        2 =3D MIX mode.
> > +        3 =3D MIX-26k.
> > +    enum: [0, 1, 2, 3]
> > +    default: 1
> > +
> > +  awinic,sw-freq:
>
> Please use proper units, see:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
> and other examples
>
> Same everywhere else.
>

ACK

>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Boost switching frequency in kHz.
> > +    enum: [300, 400, 500, 600, 660, 750, 850, 1000, 1200, 1330, 1500, =
1700]
> > +    default: 750
> > +
> > +  awinic,sw-ilmt:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Switching current limitation in mA.
> > +    enum: [1500, 2000, 2500, 3000]
> > +    default: 3000
> > +
> > +  awinic,iled-max:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Maximum LED current setting in uA.
> > +    minimum: 5000
> > +    maximum: 50000
> > +    multipleOf: 500
> > +    default: 20000
> > +
> > +  awinic,uvlo-thres:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: UVLO(Under Voltage Lock Out) in mV.
> > +    enum: [2200, 5000]
> > +    default: 2200
> > +
> > +  awinic,fade-time:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Fade In/Out Time(per step) in us.
> > +    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
>
> Why would this be fixed setting? This really looks like runtime, drop.
>

Yes, it is fixed. I am quoting this from the datasheet.
AW99706B provides Fade in/out mode to transform backlight from one brightne=
ss
to another or turn on/off backlight with a fixed slope. Writing 0b00 into
RAMP_CTR (CFG 0x06) to enter Fade in/out mode, and the the slope of current
transition can be set in FADE_TIME (CFG 0x06).

> > +    default: 16
> > +
> > +  awinic,slope-time:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Slope time in ms.
>
> Slope of what?
>

Ramp time in slope mode, it is retained from downstream drivers, it will
be more clear in the next version.

> > +    enum: [8, 24, 48, 96, 200, 300, 400, 500]
> > +    default: 300
> > +
> > +  awinic,ramp-ctl:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select ramp control and filter of the device.
> > +        0 =3D Fade in/fade out.
> > +        1 =3D Light filter.
> > +        2 =3D Medium filter.
> > +        3 =3D Heavy filter.
> > +    enum: [0, 1, 2, 3]
> > +    default: 2
> > +
> > +  awinic,brt-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: >
> > +      Select brightness control of the device.
> > +        0 =3D PWM.
> > +        1 =3D IIC.
> > +        2 =3D IIC x PWM.
> > +        3 =3D IIC x PWM(P-ramp).
> > +    enum: [0, 1, 2, 3]
> > +    default: 1
> > +
> > +  awinic,onoff-time:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Turn on/off time(per step) in ns.
> > +    enum: [250, 500, 1000, 2000, 4000, 8000, 16000]
>
> Not a DT property.
>

It is mandatory in the downstream driver, I keep it.

The following is the description about it,

If the value in ONOFF_CTR(CFG 0x08 [4:3]) is 0b00, the turning on/off ramp =
of
AW99706B is soft start and fast end. In this mode, the ramp time can be
programmed by ONOFF_TIME (CFG 0x08 [2:0]).

> > +    default: 2000
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
> > +            compatible =3D "awinic,aw99706";
> > +            reg =3D <0x76>;
> > +            enable-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
>
> Where are other properties from common.yaml? Looks like you re-invented
> some parts.
>

Sorry, I forgot it, when writing the bindings, I used ktz8866.yaml as a
template. I  should have dropped the common.yaml. This driver does
not require other properties in common.yaml.

Regards,
Junjie

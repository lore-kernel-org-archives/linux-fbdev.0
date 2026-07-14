Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455934CFCF
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035643; cv=pass; b=AKly7gQSFhNQJeO2FwBpCqsS2KNhAJ0kQ11iZXCWo+GcoetWq3CDEfxt1eGxwYoMRJS5vV1bWMMAHX5XLpDlqJc0JFpMhTmfC4F4XHIikP4vtTwezZq6KRabVFQh+wdQnDQJqC5ixZB4YW2DVp7livcZcjtaDKjk8ZCjpSbG/bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035643; c=relaxed/simple;
	bh=Hqx+/2gwUQf5oktWMVU1iaI86zBAPEpohyRmf9hMejs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDGmVzPsBx7VJwTYOzDd8viyav0gYsjfekBUToqayzdVwEKRTkvQHmcIEP4NGfxOPOvwcLCEyxWG6KKMNsW59Zw+9CORD3HIx9uSgyUKq+fU7R2RqHGRAi0ex6QGnja6b5KOkFA8I/nXIH+WwXER4mfKYcoK4iyrOlvQa5ixol8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egSKewjS; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egSKewjS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so594982a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 06:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035641; cv=none;
        d=google.com; s=arc-20260327;
        b=BJIExlE2YXbOqxKLoob74SiJIaxF7tWA2gyAG6oTE+yBqpbPwICJOrAKBDgGxI2z7n
         4A2hLSZK5rd7xV7Ms9aK69XiCGd+J/Z8YAYeJbM+RyzNnLMGbl3Map5YwzYnrVUzHDRK
         U4ZR/Hks/0fwjPz/AH+Dz2Whko0JhilgokqE37otz2kdyGR+8b7gE1l+lZuvgUMeYtgb
         IXWEuBUw2X1d2Fu2Ek9yzV3u0dYV/bwSpADGez1G6Fp7ul7EMs7W4t1+748vp9yY59pN
         sRgCahFVVd3IosP1zdpNVEitB9QeUQu5CuTdP//mtCkaaSVlv6BWcEfTL17XvvlXd6jj
         baBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        fh=fhksic2wzSW1jy/GThxSAI4PZtjGZLm2xYbc7Gemhiw=;
        b=i1H+FbZejG25ZdXGK2mCnQw0t3DaB/kdtHzkzLTnKOM/ajijTZgrJSJ4LZ14x7kRgy
         uBVYwNIp4et0pKX3itAMnohQqePeKhVauOabsysPpCY55mjhMBAzNm2z2pFjDv9Jt8Qq
         QiILLK0mE12LAxtWlu4sbh9Kps+DTVJ1LVDii543oFEnjnIux22nRww4TE00yaNtUVh0
         7p+U3tF8kGsu0JBnmgPRSA0OheGx835BDYGAnA3WbxOQsLayKCqECy8YNqzAIyq0jDzZ
         CFbchDqojvD1yPfFOtujhE0CCSno+MdHrCi3923LZnaBb1nUiL5aqhT1F+nN76UGhSH1
         pKZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035641; x=1784640441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        b=egSKewjSB9QKWsQQJRVJxdBUYM87L3b2NzHjTXY2e4Lyrhp2z86pdRrS8fcXMNTw3m
         EXgJDomP8VGJNhY6mFQX3GG4onLh2IeZQaS7sh1lgkvjgT2vWxMR/eICi0cUg8kz7xv2
         r5c9voSjZr145JyTG74rT2ZgPcvogC5asUowiQ+oum+MXEuQzsLme9xiAk28xOZruLIa
         +YMgud91p92rVOdeACWN8wzl7tVSMLbF2oYYaUdUrr/qqq88DJE4ZN5Ni1h7BTnQBNMM
         i2OG54H6DA//CUQ08xfVEiYxayqkjHU5Y+uzlQcbs9v61CbLoF8FD7MaKOJ9oij+Jcvp
         T+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035641; x=1784640441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        b=gbNf2Zf6D5OkT9CITrHCkfZk9FyzEqEn03sZvCOcJe1qpKL7vhrIXRPiaczNlxV9wA
         Weg4b3R5rGpec7raoK/V4TUPMP47OOUClXYhFLYvVxn+lq2FBaFtRF0HEXenIfWeL9pQ
         f66F0+v1bXJ4VMKc6drLfKsgVkoayVhvfsVO+PMbG/a9hjGMnWDmXeNL5p3bxKE1TJQI
         tuJY16f/Tj5Hw9D156N9XBIXahHBpyMKSzgPtR4TsbXtmtTDWMIZo0kvYhKweGkbmTx5
         ldxk9n4aD9tDJy2IBRFwBJ857UGu7mpGXkVMt/aPNPAqwOBz5V0zqS1LAW1DcG8dZVPm
         2Lmg==
X-Forwarded-Encrypted: i=1; AHgh+RpWw9Im0VUBoyaxv0N3qxhLCmmPfCZusmk+Y8li8ubKUlukjUFvvw4xKTC99Tp7NbDQeyiFC9s00A6EWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGEBVLq2KkfxjsjZ4ZS6GvzaTr21lRmJRksPu76VjgUAfUuHV
	nhrhCeWeOQ9BQQuRuXV2JV/NPDY2Nm38v4pSb/lqDonJPUKuPBhJ05dOd/oJcluvuprJKpJqJqH
	U8/mTw3EaLv9IbPe1ik8q/4tfx+DJ2ZU=
X-Gm-Gg: AfdE7clwdE3y59g/c9W++3bfR7D/c/W2FxzvxDpnZgjxyrldMggU++FrKtHVnQS0HN/
	xfLg60VLN8nEvE2B3s/li4hn6UueMyrcmJvXgHh7aXj4Wxi893Ei84MeHdGKD1xJZLEic/JT35G
	dX1+biZ9jP5852bdaZs9OiRsIXr5GqSEBh19FhYhVMZ1ETG9cC3kk5a8O4VTEfkkx4GGvltwXoy
	25BZVpo9ASlrvahTox9ZS6OaRJWUfeo7G377eRO8ZyuEn4Ousm4LidjA/EUgFNFhQ/AaU4pAgPX
	H1jSbeIr7sMv3f6NiVm/1ONq0/VtmQ==
X-Received: by 2002:a05:6a20:d70a:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c11063d595mr14450342637.24.1784035641387; Tue, 14 Jul 2026
 06:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-2-clamor95@gmail.com>
 <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
In-Reply-To: <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:27:08 +0300
X-Gm-Features: AUfX_myw9KUnmAWsWcXDIJL61TlrVu8UIEI1kefy-2iSBs3h-OI28TD8pRQoND4
Message-ID: <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED controller
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:49 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:18AM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backl=
ight
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        led-controller@36 {
> > +            compatible =3D "ti,lm3533";
> > +            reg =3D <0x36>;
> > +
> > +            enable-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > +            vin-supply =3D <&vdd_3v3_bat>;
> > +
> > +            ti,boost-ovp-microvolt =3D <24000000>;
> > +            ti,boost-freq-hz =3D <500000>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            backlight@0 {
> > +                compatible =3D "ti,lm3533-backlight";
> > +                reg =3D <0>;
> > +
> > +                default-brightness =3D <113>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@2 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <2>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@4 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <4>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <2>;
> > +            };
> > +
> > +            led@5 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <5>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <3 4>;
> > +            };
> > +
> > +            light-sensor {
>
> Doesn't the binding (or dts) checker complain about this node not having
> an address?
>

No it does not

> > +                compatible =3D "ti,lm3533-als";
> > +
> > +                interrupt-parent =3D <&gpio>;
> > +                interrupts =3D <80 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                ti,pwm-mode;
> > +            };
> > +        };
> > +    };
> > +...
>
> Johan

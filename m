Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD03375C5
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052809; cv=pass; b=KEl77PkASUS6c98zNoSsPm7KUUyurgvItYKbTxCyGVQkUztauSzNrFJAolM6nN7cX0KCHD8vlBvnhbayFOnZX4jANROUQKOb96v3vG6YTFOSCy/PUvaoxlqJPWfNFKhQvxr1UELKXqi28/XHjkn9rBarM7X3FyzwgmJKSGDoI2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052809; c=relaxed/simple;
	bh=RBtquzZL5rzrFMLe6YTrQtMK6vs2r+FZyGLbgsVlHPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/eGDbME/pF6HBuK1nYFSnDPawiI0LetVw7lDQsj/DkbQKkPyGuOhpKjfJNzPco8OEObWov2VRNWU3OSD6D/+GJduAsB0Ra9YSo+8fYfalJDNGMjlvCx3lbyfD9DFqoYznV2WYkuJHksaosGNl60LcdUEP2XEZPuRAIi2r9bfGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+zedHJx; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zedHJx"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ee990e8597so31797323eec.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052807; cv=none;
        d=google.com; s=arc-20240605;
        b=JeJvFkLjq7/xeoWTi6bU+0Xf5X9bxK5A0oXoPPUFlc+KwL68KdnF5ZLcu8VIR0a7+M
         3yp+WXpir8HssRdLmBkBYT38XVA9IxlxgKf1VvmD7CAgVPxyu4XgSCDj84lQUg7v4K4q
         rfR3XwCTvNJR6EWqU1LOvyNObkWb7w2pMNV6RsmcVxLpqnTsBbLbusT0hZ/AJA+2q8ot
         DSj5RgAaYoWYnsdEXyQENYApAze6F9ML4LfcTngDIgx9GnZZT5kix+tj4S2KDAA3+SW7
         23X4HvzQ1zV8EnYY5tNV7PnU5n+vfJDe76gzaIaWUHGjS3HWJPn5U41B2yBkrajWbBlF
         a/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        fh=lCqXEicFnIePHkZokdxGO6Rr3qslcygYzWns66Bzpbc=;
        b=dFIdM3PQVkRvQX/D0GtIZ8Z0BLfDkKBceufAxWQGiTqmY+1UTOcx6yj1kMJvP+38nz
         QH+HtKh7hOJIMlSeOEsmCOyYLsBVxqgR74Aumk274GrdzeQxFxs4nayhLn5dRvDfKZCE
         lRVJVziigwxnT6VqShVSQkxuJy/yLQKTaai75VJYJ5ShiPqIQZH/QkBbk8C0JcXoR5fg
         nZQEvA25s/BvjxQ9yicyX1wnFJQOQcKCZaZPX0lbDx9UCjfG76gIzJkdj/uGDYNEaGQV
         98cOBlgJRtiJ24VY4MQwEeEihYF9E4x5kTuDimyXM1qMJdH3xLroJWXYtMi2hLqFL7QL
         I5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780052807; x=1780657607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        b=k+zedHJxq/NiiL9G3gRXk9NZnIXIGulYd+YjajIahy5H2J5CWj1FRPPFe0f67pg5BJ
         NccfuGJpYlEOAQiCJ1UoX1hibZNAouQd1z5+nlDCSJRkrppSqDPE2LxIlSTpLIk1ti87
         LlJBeaJ0ebnO2QoewUhHTyE2MKO+fXPDhI++rjpRUHmZyQLtnFKzUUCJm+oBvu1Y636K
         80M1RdaIyr4nlwlZHkigcl6FfSmxUW64YAIxnub0ijDSEvVw6h86Dwv29Sfv1Bgz6y0c
         GClnfCJ96Iw4EIU7JaLIh88naUbRXEzLLcWPNdhbgQ8Rb8JR76T60xSFcdNfbJLkz1Ks
         rVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052807; x=1780657607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        b=VEPMS5y4ZsZyl20KDvQotiLzK/UXraJGmHBx7SIIP0nyC3hrHBhwy5AvpxthlqDUWJ
         ZSSCEEdloCGQVnDhwzBsDK+lHAhPpPIhKGdhRUHOY+LiCyXgN1/EewfjQiTUuKE8wHw9
         6loYFG4uS5m2nt9EU9CdSPEyIsofQl5pQDkObenGGYAc5uzi12X2yCY5yCB4OxYgQEvS
         a0b4RCJjRGmfMHjkQ+YtVF7u3kXMqJG0qGCq/3Xwk7u97yQAbazTz3UCJuNAZ5n5ggtl
         +FRTnKNincyReiQ+VSLV6r+zxHH10xlnFzjIh/st/nZQ0Sayw8S/SfQn/RIRq4VsFPpQ
         Ys/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+94uBlGd2bcUJH/ia/Fl15IVXW6H8S9j6l9m5qshngjBKPPBVx+36zZMxnsdNW7V2+C98huVqAofomAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlQCVpIn9DVAfrJn+URLwBdiUw0G2g/xiDejUYqc/dFFHbXTG
	ULi1nDlBEoVoEj2hfukRYpc8gn6oPlQZiXTq25cqH01kV3gorwCebjr+Pb/McuKFukg7+Q6tzDL
	FHc/KEPFa5aLyuYiX4YV6aLDk1h4suM8=
X-Gm-Gg: Acq92OECZn6FoWnu7k3LYtryY5HK+Uniq57yFdYlqOoq9wcFtiehf+Ao5Ay9fRYpMO3
	vPvZZbO60hLieroiRc+FjWU+9Yq8doBEIprP1kgX0fuB7T1vcHSPWJX9QGsSljrMS4j4sbN5zQQ
	ZnRpqhSOb+L5cZFd/oYNksUR4YY//08YFedmxY8PLefm4SdTDgGpspWQfQRT1hRmH4CcLSlUQ6g
	RafoQnD77OfobR6tprbaEEOCALC9tOg/+zZoEY9Vit2ozcC9q4RoOxVxo/22b9psayCTts7RDRN
	1FZnKy3NzHVQSBgJSj4=
X-Received: by 2002:a05:7300:230a:b0:304:c651:bdfe with SMTP id
 5a478bee46e88-304eb0e0873mr1128093eec.17.1780052807341; Fri, 29 May 2026
 04:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-3-clamor95@gmail.com>
 <ahlxvGRVFDFrTUN3@aspen.lan>
In-Reply-To: <ahlxvGRVFDFrTUN3@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:06:36 +0300
X-Gm-Features: AVHnY4KaFyk9CM74sBMVnXwM-QNoUHCxCc551JZM8S6RjnbIpb-ePbED6pxRxh8
Message-ID: <CAPVz0n0jXsd2CDhEPkr4bo+n59q3S=bEs5i4Hh4tur60aa2OZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:0=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:19PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> The last sentence is a little vague and makes us have to hunt for the
> changes in a relatively large patch. If it is referring to the change to
> common up the init and update code then it's would better to say that
> explicitly!
>

If I understood Jonathan properly, the last sentence will get its own patch=
.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> >  drivers/leds/leds-lm3533.c          |  51 ++++--
> >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
> >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> >  include/linux/mfd/lm3533.h          |  51 +-----
>
> Just one comment for backlight, below:
>
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index babfd3ceec86..42da652df58d 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
> >       bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
> >       bl->cb.dev =3D NULL;                      /* until registered */
> >
> > +     name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> > +                           pdev->name, pdev->id);
> > +     if (!name)
> > +             return -ENOMEM;
> > +
> >       memset(&props, 0, sizeof(props));
> >       props.type =3D BACKLIGHT_RAW;
> >       props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> > -     props.brightness =3D pdata->default_brightness;
>
> Given the big changes to the driver is there any chance of putting a
> good value in props.scale (BACKLIGHT_SCALE_LINEAR or
> BACKLIGHT_SCALE_NON_LINEAR)?
>
> If the difference between 50% and 100% *looks* like 50% then the scale is
> non-linear (since humn perception of brightness is not linear).
>

Yes! But not in  this patch. This patchset has a dedicated patch
implementing linear and non-linear configuration from tree which may
include this configuration as well. No guarantees though, but I will
keep in mind this request. Thanks!

>
> Daniel.

Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9473CA493
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395514; cv=pass; b=m4Gs0F10f919G4SskttsKlLGam5+ALHlys86yJdlxbaT9lUHjfm3rOf9GdM1m5jSG2ppy/xjya43NsqIp5Za22eJrUtbVqquQtdz9YlL9PLOqI4fIUfPmsyPZwe4Em+1sBqSaRNgIljRS9AAO++AsmgJMz+P72ndMH8VRj1pRbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395514; c=relaxed/simple;
	bh=tsb+ShdNHjPhqRT+1y1ob/npW7bqLOA6CccHz+MAA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+qvpnqwlfoxk/S4c9SgVuyqGPJ6J6xKd7/j2QmIUERmvi0mP1DdImESdRJhvoFttPtkv9Afn7Q0UeuvdA0EXrfkfctgHykS+3DeyTUc/u3xAYRYjcNNSSoguz38g8cFeeUbQ9lOO7HK8633Ck0YglPap1RjbTMlqorFKLwmT50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LylQJDHM; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LylQJDHM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304e6c6464dso419227eec.1
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 03:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780395512; cv=none;
        d=google.com; s=arc-20240605;
        b=b7MDUnUVUkT8znG+fcodf5uPGwQyDYpNiXP1rSujurH85/6sZttyi9iUoAlgW3Bhp1
         AfNWwPXW8IbeyhTKZdwEs71tOMBxf14WD9/C7Kg5/PmAMS/MamTHDhKEkOrn2fRBTxxS
         n0GpHX5eH0SOj01tbasl9X0QT4NrQaxUZYKU2jJ4KAKdS3TFT/cUjxBIJIDxtA6kmvJw
         qfiV0/47X9Xap4e2xrJ/TGgiP9tziVMN6wPFVweMYFg4AlOBh5X32qGpRttc3uiP/7z1
         z3g9PMtyZar1pTix10DBrXDOr5+LrLW50k2XglvOIByXgNKLjzHaTrAuDAvPYQu0GNdO
         Z/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
        fh=kaSe8adCorQnRm5IH7sGbUt0LzwFGyLvbGrE6I9XERQ=;
        b=g3SZQDdpommJCY7+oBuFktrb00/2D5KT5yV+jwWdKd+FpqQq9IIIi4L64VfOhzMTZX
         IdAo1tRiE2NDUPxelSOoF3u5/iPXcZK/5IKY5meW3PwGCLDqMkcY9EkoOcIOf7ixOmFp
         3ozKGb9D2jig39yBK0C0sp+HfTaQZENKQYut0P255tZLdUG4CV0ZUMOm5viIfx8Ii0lL
         d9jtcmyu3F2V8ZIZGChW/2XRnNY1l45U8Hxo5dMUv+wS1sUBDjhI2lvF+89RsYgUjdB7
         xgHiHTCZ+D/iGjbjtyr5qGG8bpmTKSSQILYUoQderyVz7hafvXjI8wDwb9Y3ikyGCRo/
         v9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780395512; x=1781000312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
        b=LylQJDHM7J3/c/sYuUUvJyKb0EF1e5Rl9EUfysxJVUAuGxlqlY7a+pI9K6pjiG4X6J
         q/3cWwz79o2Qxuir0eyyzKacKHOnNhh4k6bNnUrL1XZFRqgVAPYcuWDH9vw7Z2ZYFUms
         v62n8tEG782bboDoZdrAnJKQweTrNEgVMUyF7yo4ZQWk5Z3gtVUnFqYXQM+6bxci/yNw
         1riH9bioEJi/Vj3THhDWpzOkP06fmWgFm1tP6hV4hF/V2CDUofxrvycCfEX8sEZ05dBh
         zVHBYXWqsq7+r7CIW+5ZehlYiO+OLcqmHBWMKTKzB6NB8L5c5E1i3MzFm2ZSQLOSnMWa
         iwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395512; x=1781000312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
        b=PHRDtKPAzJIrHdcNyYhSlhwQ8FmdiFttqLbzb7zls8KOytP9R6wFZaL/1q5qp2QAjI
         OYEgsyvo/h1URP2+hchcHNubUkaYd16HNar8gPSdrbHuUVK7FXTylnn6Bma0q3sTM+DN
         HqW3xFX+Wifqp7DT8omVOzTNpHl10TwWPhN1aQqRAz0ocDdov6jtjNv2V/l+WWWyM1YB
         8FVrm7VGNh0b4mokUHzYM+RLlUtPZHpWFoY1AVvh7M9/Op2UUCTkXK9HKTSiXr42BIgZ
         fcu+VCnuxgQNXifnyzbbcZ4WoUK+TPs89Eq1fE0ybbIMB7y3w+1sPuO2WhNYQO1oh/Q/
         HFjA==
X-Forwarded-Encrypted: i=1; AFNElJ+2idugkoTXOYgDQ1zDWhKIYmacAPkbWNEHZPTUc4/q4BlAyLZ0k2C5Df3+BWkmZzxQTou6kEM+Fs0O5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL41nlL++xND14ZPWPnbhj7uR8pIrDlS/CQDZDICk0VnyeGx2
	l1iMuKtxbkQmdl36OBUXRg09u+rtUqC+aKfdt+6QRxU6KiCktq1W7jNCV02lwDpu62nZauGf6dP
	jLoak6kGCQJGkChGxPkBPV8m9bNcpRsg=
X-Gm-Gg: Acq92OHYP2x7Sy8Si2U4EbIKZ4XyKPVyDbPWgXQ0U1ZSUwbnFNmFwmdJ0tEWec9XKOs
	DjPqgE1oRjJ648Zkf9k7e6qNSZbtBhezBXoEoTsYh7vEU7/dlIwD+FFT3b4Oycm4lXSbnBwDCSi
	ybes899ncX5CCTTBOjqz53yFlBPTo9zlZIWwnQilbTN5qIxS7NXA/3OXPLhqY2UrNZ1BQ7ARsOn
	IPRBYxGmnBWXaxvbasbk1V+vQFwGWISmlewY9ruF+vk+IHBJEjOp2RUtj+68x8CaJJY8r2iRHUK
	+XD1q7Ffr/BlVEePgx8hjBaRb1BNlQ==
X-Received: by 2002:a05:7300:5726:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-304fa523d3amr7629148eec.3.1780395512175; Tue, 02 Jun 2026
 03:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-3-clamor95@gmail.com>
 <ah6O1h8SPwjf3rV1@ashevche-desk.local>
In-Reply-To: <ah6O1h8SPwjf3rV1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:18:20 +0300
X-Gm-Features: AVHnY4JHC1yQblwim_AIT-fQGP6xAd5YIyw3Q9PUntQ6X-j1sNWq1k3TeFJP-_c
Message-ID: <CAPVz0n2vRFMKagLP+Ssq7n0ECp4_4mT6k7Bo9z=rxrSNCfCRKg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] mfd: lm3533: Remove driver specific regmap wrappers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:05=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:22PM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly. The wrappers are mostly equivalent to the standard helpers, w=
ith
> > two exceptions: regmap_read requires an unsigned int pointer, and
> > regmap_update_bits has the mask and value arguments swapped. These
> > differences were accounted for and adjusted accordingly.
>
> We refer to functions as func(), exempli gratia, regmap_read().
>

Noted.

> ...
>
> > static int lm3533_als_get_current(struct iio_dev *indio_dev, unsigned c=
hannel,
> >                                                               int *val)
> >  {
> >       u8 zone;
> > -     u8 target;
> > +     u32 target;
> >       int ret;
>
> While at it, move towards reversed xmas tree order
>
>         u32 target;
>         u8 zone;
>         int ret;
>

Noted.

>
> ...
>
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val,=
 mask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZO=
NE_INFO,
> > +                              val, mask);
>
> It's better to replace this to use _set_bits()/_clear_bits() or even move=
 from
> the above conditional (not in this context) to _assign_bits().
>

I will take a look.

> ...
>
> >       else
> >               val =3D 0;        /* analog input */
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask=
);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, val);
>
> Ditto.
>
> >       if (ret) {
> >               dev_err(&als->pdev->dev, "failed to set input mode %d\n",
> >                                                               pwm_mode)=
;
>
> ...
>
> >       /* Make sure interrupts are disabled. */
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, 0, m=
ask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZO=
NE_INFO,
> > +                              mask, 0);
>
> _clear_bits().
>
> >       if (ret) {
> >               dev_err(&als->pdev->dev, "failed to disable interrupts\n"=
);
> >               return ret;
>
> ...
>
> >       u8 mask =3D LM3533_ALS_ENABLE_MASK;
> >       int ret;
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, mask, mas=
k);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, mask);
>
> _set_bits()
>
> >       if (ret)
> >               dev_err(&als->pdev->dev, "failed to enable ALS\n");
> >
>
> ...
>
> >       u8 mask =3D LM3533_ALS_ENABLE_MASK;
> >       int ret;
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, 0, mask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, 0);
>
> _clear_bits()
>
> >       if (ret)
> >               dev_err(&als->pdev->dev, "failed to disable ALS\n");
>
> ...
>
> >       else
> >               val =3D 0;
> >
> > -     ret =3D lm3533_update(led->lm3533, LM3533_REG_PATTERN_ENABLE, val=
, mask);
> > +     ret =3D regmap_update_bits(led->lm3533->regmap,
> > +                              LM3533_REG_PATTERN_ENABLE, mask, val);
>
> _assign_bits() and so on...
>
> >       if (ret) {
> >               dev_err(led->cdev.dev, "failed to enable pattern %d (%d)\=
n",
> >                                                       pattern, enable);
>
> ...
>
> >  extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, =
u8 val);
> > -extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, =
u8 *val);
> > +extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, =
u32 *val);
>
> We don't need to keep 'extern' for ages.
>

I will no inflate this patchset further

> >  extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
> >                                                               u16 imax)=
;
> >  extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)=
;
> > -extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val=
);
> > -
> > -extern int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val);
> > -extern int lm3533_write(struct lm3533 *lm3533, u8 reg, u8 val);
> > -extern int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 val, u8 mas=
k);
> > +extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *va=
l);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

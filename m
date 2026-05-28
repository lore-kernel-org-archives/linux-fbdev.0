Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629F28CF77
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980633; cv=pass; b=LZnDoDV/z5StGvvYx40ycyzYNK/062embf7zQPFln3CchTCChY+t4NeAjBjgx5Sw8uGZYhlEzK1S8LUaZGj0xbPThz0gHhnOTOXVj7X1HqqoxEfwhNwKhk5uz9eQ54JV8xAAECdl5Y26srCxgc0y/PKyxFe1Ul0ttSc7WjdkUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980633; c=relaxed/simple;
	bh=s3vC6wnoLZ1XKUWcUoScolE5ZeO4GGneFSy9sZNGveU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C07iEZPs76zMkTgcrdVrAmE87ulwg1vNvWccFAmDqxGaxx2AbSH6Of0l3OSIB0Y+Wx6+uKAzfimVrxSQQibXoLcZB3d4z5nxASI5Zdkr6jvuLQByiZn2z9fh52+VI3Vob6BNzJur3kMVEAW1MHTpcUeBTVm5+x0uE6MuSgFq3Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuVjPwSE; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuVjPwSE"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e58292d3so240948eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 08:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980623; cv=none;
        d=google.com; s=arc-20240605;
        b=lpiavKQPD9N8HuDY08xf+pMVSuZIT5cja4aX4svMUjvOFw515XsXLA7KZpZCD6pc4W
         kFvippoMEHDyecd8X7Oj6sxWvw40a1pGwuZlswMf7B4dWvoptVVzVFm0NXkyRXjPzSOK
         h0j6MsNVR9nZKGpq7MUV9NijJpJX/2r+k4k5Y+dMuOrMS7Ja9oFJ0pYo4y6s+4s9Jr4H
         wMdy3wjlbVDSBlfK6rrEmgIrT6X9ps5ZUs9Lf/o+VJfRnTzyFziaMcCzdR2uPWqxfkFb
         PB6HX3elU9BUYUZeyVGwAY7o1GaXaWCG42v38i8P2Y9z2S+kQk4/Af5Ie37GR2XZgGU2
         S4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
        fh=+ZI2FCyDizCBu8warw9KfYJFOtwN7gvRf7x9hTyf/qs=;
        b=jCsp75guSAtECUL5Xw9OZmKd+VgighhiQM5cRCK78pO/1nGtOJm0SVU2/q+bRZX3jM
         sAiugwmvbNNgfZ27MvIofA5wmNdtxhEWh71UkUmdAFnJeqG1ZyY5bQQ3jW0YpugvNxcj
         K7sBJ9e/6YDxky3cuJ6HRDZoO0nmQawldPhk2k6z4FAca8bO+7oy2BuUkLD+IGqyVTHg
         Od4xW34Er3r9cMv3O4TEwZ2PXXZtDLXD741QRjqQ+kQcpU/bTz7jGlKgH1ga67wBQYWu
         +AgI2/5Ihfwnp18EssE7meQrYgqLW/5WgCYojCBipzQjxc8JW84UOtBfoQVEa28AhS+6
         Bbdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779980623; x=1780585423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
        b=fuVjPwSEbktOykrRELN/cZftb6kIQsBcY83Isn0NjFaQGapKKFBb4rbpbh5I5mJINE
         eXUBy+gIboUF1wwiFdEt+D0YT0LG8KIdxdvcFAaC9sq+ocUwf55CUxujMo/CaDMLUWtX
         qnk+FpTobIjOFMk/Be7YvchW7TINllERCKZ2DZW1mnAWLP5qGz9b91lKyBrgYynd0KbT
         uQVwmTwGcNm4+v0qTce3bv7Bv97wUUCDJVvhvAHzOXPL3cQ64+zKGrvyuakLfl3Qw+6i
         SkqoBsLgUimHb81i1SeA3hsVIf40qYuN8z6moa1D7RGCjLc9ydxsME3fPLU17m9DWkjF
         ACHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980623; x=1780585423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
        b=L7p7wiuSTgTHzp1VEJEWadetLsJy/QOkYSvVddowRHz4aHDRiS6yfD9x9R4rCsNrWg
         r8HRdqHTgGMwKCFHcjKRnMkbnhOskE0zuxZv0695DFSg0v21zAOTU2i82GVr9j+aJTAg
         ae/IJ5wbu2AmOT1MI7lyhI421SKvN3qkT3MhjzBNUyKBXnEPc7ziTcjxJhzO/qxoty8v
         +cVM1Ye+sKjhGQoK/nwrfjG3iwCIIQtrLcV4Q44Viq8HjrBNkeXqRwrguW711n9HOB4p
         8ccdTWw8Mn2EqkodgCdpwQCqS4iTbPdS2R01Rk07T7C/wkjfxCPBb4evIBrjKEtc79h3
         r0kw==
X-Forwarded-Encrypted: i=1; AFNElJ/7WU/kmKGG23ZScSL+GeM0kJ81+dSJYoz0dE6q0ReslX9EyXPAU/eUqGVAvaQKY00JkCekGENMgMcEKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLR94tKSDhN4krflj3Pmsww/gavf6CEb5mtT2RS3u1Ps1vVEf
	YwjfBoVq/ujVMCjua7qTHp94GNlv1DD9trMUCPGuUYjNRF/CnJIkU+nUyUn7wrSULuVXgA1MsiY
	00eNZwGAjVhOME9QauYsltpCCGFAJ2NA=
X-Gm-Gg: Acq92OFdWVjYwqUnmYfX6IiIxAE8Camc/crTv8mnddyhmYLD+9bMcn2aqImw9J1A1Uk
	Bj8nSrY02DoEhyHMloe63/mT4i3iFugXwwbqf0XCo+e4n1YMoEKDmWB/vFgNHdulvUY8dGTx8Ht
	XVfL+rY0EnVjzwTnI6Uc6FJf3Q3cUaeLa2YKS2G/qGi2D2mgnUjNCQVHoUys+mQe4CtSQT1uquu
	mwsZpynAdPulhN1V/nMIi9+B76M7uouBwFRXxTt0++GtoX0sqH7xl1NoR1UMI0oY2n5hNorsPEi
	F7usl6kz4lISbTlJT6A=
X-Received: by 2002:a05:7301:fa04:b0:304:d82f:be10 with SMTP id
 5a478bee46e88-304d82fe55fmr1288739eec.11.1779980623129; Thu, 28 May 2026
 08:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
In-Reply-To: <20260528155001.2bcb7003@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 18:03:31 +0300
X-Gm-Features: AVHnY4JOZH_BBdJBd0wzIDDW2UO693Byl1wIIcPrxkbXcQMPI-6wgD9ANvHg0-o
Message-ID: <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
0 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 28 May 2026 16:51:19 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
>
> At least the IIO ones would have made much the same amount of sense for
> dt, just that they weren't having in the first place. I'd prefer that
> as a precursor patch to make the rest much more readable.
>

I can add you preferences into this commit, I don't mind.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> I only looked in detail at the iio bit. A few changes requested.
>
> > ---
> >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> >  drivers/leds/leds-lm3533.c          |  51 ++++--
> >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
> >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> >  include/linux/mfd/lm3533.h          |  51 +-----
> >  5 files changed, 212 insertions(+), 305 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index 99f0b903018c..cbd337b73bd9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> > @@ -714,59 +720,33 @@ static const struct attribute_group lm3533_als_at=
tribute_group =3D {
> >       .attrs =3D lm3533_als_attributes
> >  };
> >
> > -static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_=
mode)
> > +static int lm3533_als_setup(struct lm3533_als *als)
> >  {
> > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > -     u8 val;
> > +     struct device *dev =3D &als->pdev.dev;
> >       int ret;
> >
> > -     if (pwm_mode)
> > -             val =3D mask;     /* pwm input */
> > -     else
> > -             val =3D 0;        /* analog input */
> > -
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask=
);
> > -     if (ret) {
> > -             dev_err(&als->pdev->dev, "failed to set input mode %d\n",
> > -                                                             pwm_mode)=
;
> > -             return ret;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
> > -{
> > -     int ret;
> > -
> > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MA=
X) {
> > -             dev_err(&als->pdev->dev, "invalid resistor value\n");
> > -             return -EINVAL;
> > -     }
> > -
> > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT,=
 val);
> > -     if (ret) {
> > -             dev_err(&als->pdev->dev, "failed to set resistor\n");
> > -             return ret;
> > -     }
> > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > +                              &als->r_select);
> Does this have a default?  If so the pattern we've recently be setting on=
 for IIO
> is
>         if (device_property_present(dev, "ti,resistor-value-ohm"))
>                 ret =3D device_property_read_u32();
>                 if (ret) //corrupt property in some fashion
>                         return ret;
>         } else {
>                 //set default
>         }
> If there is no default then check it unconditionally.

default value is LM3533_ALS_RESISTOR_MIN and if no property is present
clamp will ensure that als->r_select will be set to
LM3533_ALS_RESISTOR_MIN

>
> >
> > -     return 0;
> > -}
> > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTOR_MIN,
> > +                           LM3533_ALS_RESISTOR_MAX);
> > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_select);
> >
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > -{
> > -     int ret;
> > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode");
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->pwm_mode =
?
> > +                         LM3533_ALS_INPUT_MODE_MASK : 0,
>
> That's ugly.  Better as
>
>         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
>                             als->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : =
0,
>

Yes sure, just followed 80 char limit.

> Though if there wasn't a layer hiding the regmap, it could just have been
>
>         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS_CONF,
>                                  LM3533_ALS_INPUT_MODE_MASK, als->pwm_mod=
e);;
>
> which would have been nicer.
>
> I'm not particularly keen on the swashing of the helpers being in a patch
> that is about switching the binding type as feels largely unrelated.
> Should really have been a precursor, easier to review patch.
>

Removing of lm3533_update layer is not the scope of this patchset.

>
> > +                         LM3533_ALS_INPUT_MODE_MASK);
> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  als->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +     if (!als->pwm_mode) {
> > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESISTOR_SELE=
CT,
> > +                                (u8)als->r_select);
>
> Same applies here. Mostly an unrelated change as the only thing switching=
 that
> is related to the patch is one parameter.
>

Removing of lm3533_write layer is not the scope of this patchset.

> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
> > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platform_devic=
e *pdev)
> >       indio_dev->channels =3D lm3533_als_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
> >       indio_dev->name =3D dev_name(&pdev->dev);
> > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
>
> I'm not sure why this was there in the first place.  Hence not sure if it
> is safe to remove.
>

This is directly related to OF conversion. The iio_device_set_parent
bound indio_dev to parent, and it causes problems with OF now since
als output has its own node and binding it to parent if wrong. Same
story for backlight and leds btw.

>
> > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> > index 45795f2a1042..d707d43d5526 100644
> > --- a/drivers/leds/leds-lm3533.c
> > +++ b/drivers/leds/leds-lm3533.c
>
> >
> >       led->cb.dev =3D led->cdev.dev;
> >
> > -     ret =3D lm3533_led_setup(led, pdata);
> > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > +                              &led->max_current);
>
> I'd prefer explicit setting of the default to be visible before this, or
> the property_present pattern I mention in the IIO review above.
>

clamp will ensure that led->max_current will be set to
LM3533_LED_MAX_CURRENT_MIN regardless if it it present

> > +     led->max_current =3D clamp(led->max_current, LM3533_LED_MAX_CURRE=
NT_MIN,
> > +                              LM3533_LED_MAX_CURRENT_MAX);
>
> I didn't look any further (busy day!)

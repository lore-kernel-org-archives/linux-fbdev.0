Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9725B08D
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407914; cv=pass; b=AQkZTrOf+HMr3O9ynh5tYIAtTk5h789b4o+cfsEF3zIV8WhU6f33sit8h0ITisAEMNgwmFz0yWi+Nu3al7/b+rDFpqXFuv5XgI9uL7fuqbTP0nBj832SvIOWIlbmyURwg5XSHuuGr340XkgjiYpRJlfBJcSVobZSTB/1ey73P6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407914; c=relaxed/simple;
	bh=mfRQt6zofjyY6ZTAQWLKGrBLLlNAa1/TidY6jbdB1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN7kn/r7AqPFTE0ziqAXnR8aO5/cOEaLgu14lTw4JesSggCg1lZRYfFVwRRREMJ9xStMrk/4CZVQhEp1GUH+gcaiIvcAth5m/52SSCKce4dwQiOzN0AmWDSIywu+uYcrZidj3GduKXriHtj3DqJ+UlKrvRn3aK3B90x2m6oBXHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e929EOfx; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e929EOfx"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d555293aso7995241eec.0
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 06:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407912; cv=none;
        d=google.com; s=arc-20240605;
        b=D6av5/ihL11PJ6jD57aP0FckUs2QuLJsoHtWYrCPYjx97x/PKmsehlx3taAotZ9acN
         HghZ9YwCZQwAOGMiBmedpujxJBMlzxoNUYFAcLhB6ICI7GHFnfovheHZt4dAvgskvDMZ
         WShq5luffqroBt5J5s7Gr/0kYDLUJx7o/G7jRMOyipJ8sM3vIXxkF65TGRRPhTydk3gq
         /T2+pcsBc3ujGA4SmZAEgPyZenlSkLDZsO1yM36OExqn3HOSLEPNn0EDMQ8oxycBumlk
         9lTCp2N34VbJ9p74eqVKQ0c6ludv437XGswjJUeF/UzuYgKjHDdI4eDCuMTa8D0JQe+g
         x6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        fh=sRRUprQ4P+8QAR5SmutmGyZA87/AGZt8fsWlbXBNxl8=;
        b=apl8/oOLYpHPQtd4F++rFLesDU+6/bmt8r9Q650yKxKZnDwLZslVsQgtxPPORZ0smv
         jdbwKE+0m7JW+2cY8Gkijfwc0Fi9n3WHEApYy+edHgZZSSRP+5Lm+IDYF+x/mDVRMTKL
         o5F7HWNQIelqIiPL8H0UXmltauul2clD0vvqjgSpE86NrNVOZBkShhWvI5mqR5btK6eu
         ldwgKOvPhUVQcL87GyX3YJ2xicNpAOli5lFHCIQgnPkvYW5Eghe+sBr2Pz9885hXyIYW
         7m8lwagB5wru8HWSRD/CrAjazUtiWVC6OvHIPS5JqqNR9sBGC4MMWLPHsYqNOiPyQXq0
         QD0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407912; x=1781012712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        b=e929EOfxmFLsq4hUlkHzE+NE/58yILxGFpn3fOd1gvdeurK8o0AzwY8aRvFicbE+ke
         fZp7+dZqrWslwv6YzhIu7Wytt1eLhXz02mTz9XvnCYGLW7Df5QjXvgBbqfDsvDE+X4OY
         5gUD7yR4J6ikvTwaJxWeQ1oqTAIWWEzw4IvmokTpxi3XjVWsnUGYek583gN5FJieF0oH
         6zkQleJmtJAP091wg/euGBxNKHNGl3FvczfyNLOux+xJwCER0y6aaRzorubzp7iHuIjK
         wlnHb3d2gtsYVsc1pienT4XNF1eCN3rRiLFSQhH3Q3WvBk3oRFhgjjuWwKK5Z278Bu0M
         m37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407912; x=1781012712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        b=VQr4hS2F5qSuo3ASZ/ZhGqZQA+MIMARwqIFEp9mbpLxJoLTEebLn6YzaVdGusyMoS2
         3q1Ybh7APZTNqgv2jCJ0JxnBBQDp/ZqWRd/t2twFXUbY+LWTWWO3aOqycGdN3+ad1CcQ
         PFzKkXzgPbFCW19QwsnAgW735c0yhgzTVg/VHANsps7TCZ2jQX2znyAeyKyy5Z+0MfWY
         jDjZlWQr6fQQ2KfWLJ0hCcC/G+fv5Rc7OzePj5+cKkijcGwVJxWjIn1I0rSkOlvbaRci
         oxuv7yS9tF6Ka6Rnh2FgUewBeB7PJNXHiigI8r6kEv9gscxcqFgNFbNbwhAMUyk2kN3N
         0mQw==
X-Forwarded-Encrypted: i=1; AFNElJ9OeaX9C9Xxg9PSvqfe146SYjRi+Ps0Ez2DKy4BwYFUlE6D1mlYct4aH7bNQiTXRMD/QcG+yxSZAhTXdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOoX6WpRNA5OZcYmeACyJtJSek553phJXZdP/riZU8zv4Cfqi
	RVv3SperR1F4p63TsD/YQXC7urdOAL9KqX2n2qzYWRkKI1FtFrdMPlRR+fbEDf8fnkwMDWqiiAW
	7E8nqDaTM0sI6o0Uy+vmQnTfPGLvz03w=
X-Gm-Gg: Acq92OFXHNgOfUCvyh6MX8LoXVsL0ndIZgbXkDzojFbwmEkN6sh5iVfnN0UMlRLiXAx
	l2Nk4hp20PuXOTrPHavyHytOjXZtp1F9CsjwRdnaYAS/B+AwtXr5D5/JqxH8Cd+GuKvVR8t0Sh0
	ge8HMsQuvm56OTqH5JxyFZt7KZC90dw2Uok8qI4UuVf8N41cuQNaAs+KfHj4AiLOmojgy1/fmS0
	cdKyvvPmt4es5bFSGiESCnWuQBlHMkqABbRVtW0oXF7NARRIybs5Yue3C1WFtcAH31PP9ey8kDi
	nmcPlSmukp/AU09u33k=
X-Received: by 2002:a05:7300:724d:b0:304:8366:7456 with SMTP id
 5a478bee46e88-304fa4a97f7mr7197710eec.3.1780407912080; Tue, 02 Jun 2026
 06:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-4-clamor95@gmail.com>
 <20260602144222.7a50a041@jic23-huawei>
In-Reply-To: <20260602144222.7a50a041@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:45:00 +0300
X-Gm-Features: AVHnY4LTNpiSYmDW8xnqHecCTvTzpdUFD5jDfC_0pqaKrNHhEcy0XqCOTlsLpZ4
Message-ID: <CAPVz0n3x7KaaoZQAmpX-NCz2QNrhWNQaYFvX3pwS8DLb56bFuA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata helpers
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:42=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
> Minor stuff inline.
>
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
> >  1 file changed, 16 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index fb61904f110f..52136ca1abc9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
>
> Maybe a local struct regmap pointer given dereferenced in a couple of pla=
ces.
>

sure, why not

> > +                              LM3533_ALS_INPUT_MODE_MASK,
> > +                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
>
> Andy raised this in previous patch but in the interests of being specific
> regmap_assign_bits() is going to be cleaner here.
>

I am currently adjusting accordingly.

> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> > +
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > +                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>

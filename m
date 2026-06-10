Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296F3C1086
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102133; cv=pass; b=REojVEyAzCIPITHNVv1eMY8Rj7v6nEGCHlLxC1SASTyR+9J7xzuZN9ahnocN5FPzBGzpZmfNaqlW4fRox7Ub67876CFDjD+cH38GOLyNpTPyTeKP5uCMFRcHV1Rk26vGmH7TLy7H+SCWkIiK56Sv8GHbYjHgyqgA0ougmOoilyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102133; c=relaxed/simple;
	bh=QQx6HdrZCLg1/bCUL3imDIU0SHjoIZfIndkzDKlCI1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IejwnMWEh3fU/ZfAW9MM/vhr5Igl+FEKOhoWdUWM/NLzf2xwUGGLvOFKsR1yBgN6tztKNrU1bt97WBYZC6tHGB+8wfNhP79M4V04UgLaD7zOK/IiKlglEqov8gdQ8KARlP3pR57nqku2X2H+BIhdbjKKAJgtmS8K6OMmeFdHViw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQm7/gRU; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQm7/gRU"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304f0039c02so12353229eec.1
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102132; cv=none;
        d=google.com; s=arc-20240605;
        b=J9ghIRHNMdYTet72NWurCDJ3mLBvHbDgtrUSEqpZrTreGzC0Qsre0Tl+iMVB0/g4O0
         AIP7c6oGBxGcd7hL+ge/yn8O+OwyCtKMGWR/QEtmkv8J1XLePRMnocDVbt+gUlBewHon
         xY9+P0A+645sB5qpUP/BVid/fkWsO1nws4inSRlMIgxr+KnjKDUgbRhVh4q1HFXlqdFZ
         kDdl/dB+dgjw7YazEZ9s+R6aav1rvgYeZr4ml2Q5OWiCxz0ZB8RW1ksxsiYFCWAvcBTv
         dINr60RLJ8j2j/A3yTYUWhNWHjzNY/m94Z71hXiEdfGDjsuRuvvA87CiG+Q4m8NVV8eP
         TSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        fh=HtyE1dV/fJuTYRAlMpWmB4TuR2AzNueF4xDyka68goI=;
        b=G6hENMWPenbrHk8z1jQ0SKAwv9YJYuQ3disZEvaK6RPzuy5ksd4My0PLoZ2/If0xB9
         ofKS2jUSlE59dLT81FYGROq/lI5xnGPaxsc2zd/Y2nyMn+D6BSbz9QQAkPMBNVgmpgDM
         CXOjpmI4y/Bowls4Bzxw1leeBzkjLlyWYQR+39m5hW5zDPSlmW/Cl/Bsg91s7o+R41Ur
         NyrgSvww86WBzDCGT4MGjytYDcmHermMOJENSXF1XvrwDttzoDwVKmx80CARX4lLuZai
         4kPPKxvGFY5R/4xIYLyFyp8l1LnLq25VzHhaJE98N5UWI4uUXxSrzOQJdi6B+D0syyVg
         aa1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102132; x=1781706932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        b=KQm7/gRUZfsFKZqtrRX/8Gv0F6bhmSvFCeIsHmKzg4zXiy5wml4L2DCsSYXvR9y6VT
         dakAcxRGvyiyeLEmi/m/zwtHybvTK2vGxqItzgALr+8oc4OGZyYciXirvN9GSOw2RLkK
         49Vn92bndAK2aGF8/CBb1krYV8XgERip/wUWOu/2gqfs+ZtfENmUS6MNzPv1lIc8FRIX
         sC8lAPSWJ2RzX3/CQeIgHwZpONkaUhzMNPtYIc1hOpnirAwqodCd4glpOxDEpUKLRR35
         ws/Yz+J9Dp50xOxLOKTmZ38zDkB6qSGaeeevLFcfTPWN5pVFpAZuUXlPzW8qBX5pAkNk
         eTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102132; x=1781706932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        b=pSoHjB0Ca2DImGRPlHPx4tscjPaq6oK5AJXUiv2JY9HkfLCkvYkDFlB87NBhe1+/K5
         aCM2LzPp7cb3OI5ulw0MabMx8KdVu+ABSXDCNu3H0l0/bLDXsDK+j7Qz2k4XHJ5UMcIL
         iztoGkK3VMbIdgD36sMpxJ3XdHusX/2H2WF+8Uvc63XkAOcxkpEa0YPIF/m4Dw+X3cxl
         8AgSrVjFBqBQFd4y3OyoNG1dC8BaU7XcR+1BH/M0lqDvXMGbzOEdXrLPMdAmCbzljA2o
         OebDypd3hJxEaLTNmBJTGt9EmrhU4UJtSigPMrchu4EXe7T6doFV5gNUPOdUO1huWafU
         07Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/MtmRzwQ3gcjdP9S2htUHilhYdoHdqF7jxWD+X6L0f2+yYtn04Ip3SqDaao1MaX7hVl6qob+GbQqAV4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTDRDNbPUoA9GzbQt8QwktPdJjvCBA06PK8sjwJqdfFP2PcLk
	tyrr8ND8Sp/+uX/RGEnYWRH2aBJDh7ah+ma74RJkAzCsZtmfTXEre9rWmXKkw6NDLO2cXUkWUPm
	c5GO6/d47YkoDnG9lMcn9miIp/5x89Mg=
X-Gm-Gg: Acq92OHWOSXbDjZGT84bpb7lT2bBvndmhYYyclCZjVIqzJQBDHjZ7aRRyodVAVemGi5
	PBplIrlaRpkpViqt95tUDpr0GajNr/Naoi9eK+LhahAU52NdJDsXEFJhyEdklb31PyI58jShDqH
	Zcs9vHBNzUsQRx5JCMfklWnTaOhIc/Y8c3f6aVEGUXYGPsH84dKYoIorgOpnHq+vCb0KxhtDGOv
	jAomV6DfJTbiNwySAjwH2Iv5OGuT5JWPh5Zng28XqFa6V3mcK8l54o94b29FFAsFUXPurZrDzlJ
	Y+Av3pq9vBbLzKF4gvo=
X-Received: by 2002:a05:7301:4186:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-307d62ddc77mr6085557eec.18.1781102131738; Wed, 10 Jun 2026
 07:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-6-clamor95@gmail.com>
 <aihlDGNZRuHI-vMR@ashevche-desk.local>
In-Reply-To: <aihlDGNZRuHI-vMR@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:35:20 +0300
X-Gm-Features: AVVi8CeF2WtE8NAfRo3Ry4_ONFpQ60FlY7Ry_ggOsna45f4Sc2pO4GqWSxBW8Fo
Message-ID: <CAPVz0n17uAvpyuF5_E1L49eoz8LvHULE0-SVjJpHvu4veWWjEQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:10=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:29AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
>
> Use func() when referring to a function in the commit message.
>

I must have missed, thanks.

> ...
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
> > +                              LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_m=
ode);
> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX)
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "invalid resistor value\n");
> > +
> > +             ret =3D regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR=
_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
> Wondering if it would be better to
>
>         /* Bail out when in PWM-mode */
>         if (pdata->pwm_mode)
>                 return 0;
>
>         /* ALS input is always high impedance in PWM-mode. */
>         ...
>
> as the above changes almost every line in that conditional.
>

This is a decent idea, thank you!

> --
> With Best Regards,
> Andy Shevchenko
>
>

Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAD3E1713
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Jul 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140558; cv=pass; b=J1twrktDxXiJE2EMipjZIz12peKMSqrNaJMRkVCLMZ+PWi73KjMNiaTRewIwgCmpHTEjt54KxJcE5jgboGVzcR2vh9+EvVE7mO53VtYJbW+DMvzTrubqrUXzGcmEZJefWIlBbu6G4spoCp3fstz17lcpyohqAaTf4BRoRPD7G7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140558; c=relaxed/simple;
	bh=mw92Hf/dQnuOO4mzXGCnNoSoSNZ4XLCDu5vbV5GvF2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugpKP0s572zWezfrqjGojQuPgyLAQXPJqareufOdRMdlLHjTbqGaL+MkYypyBVjRrO2lTuuxPGrJVps9Ucxym8rct4AY3GMGbbhwKTS0dvO7IfOc4E66CZw6m2upg0CTIadNSraZ8cLoAh9rXsqCqbrD0UD4nu5p4lfH22eDIes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WACiFu7z; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WACiFu7z"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1856463a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Jul 2026 01:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140556; cv=none;
        d=google.com; s=arc-20260327;
        b=IqupVxLFmv2anL+BtnR7Kl5XmAxaS0EMS5Si1Cec8Wbf2mc1J+UdbdbMdEsV7PyTAo
         ZJMbWmpTL/lwEADhgGFnx3nkReH/tFrD+LGwF09OlYWr43qBnP9Shz37NBSYezYIeRdv
         gd+YniyYfrzZmWZIF021eQ/WrauWDYd/OsRBrLDcoWgVXQyaoLJ6ExPXuzsnGIgrhDHJ
         +b4vgF2FsF5r3jt0nIA2Y8Jn8EzDQ6FGfRBlvPjzWUWx3eHUzjKwuOh1alxW80YOZmNr
         OcMq9T8lBwwbxNjJFrkoik/CvUmP66tbL8saWJBihAXvXh9aqILa1s3krldYvbbUxy8v
         ghuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        fh=2M585kseO9fSb5No48Xq44cU1veTlyJI8foPGsiyaW0=;
        b=ftOrssMpieMtFQEbaXaylWXYGcyCaGFPINK8qlGFiy8haXbzQzkOrU+Uqgx7UxdQfw
         2oggHUng4M3CnsxWWFkiwkOKPT4m+63pakK7grGaKsa5HyBi6G/Yk0NBHU0WmbHmdq7m
         pDs/M6ojGoG+oYTiEG+PHS0QfwlFa55ig+oIbJGikqcXFXVgL8dz4pKFA6iEKUZxYnMu
         1ApS3KR9Sp/YJuOMNIkiesm6WIamnFtwkoUibi3oOYj8/gnyXBi5Fk9+pMhP9a7EZq/F
         O3R8yDdZcdhxlExnLDW9D7YIeh3sfhaG0EYtCPF48YYAZzq19Z8D0XaLkNNDbYavIdbJ
         FL+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140556; x=1785745356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        b=WACiFu7zKLA7BiL2tpISJ0tGgW8Q7+/skiRVtyUHYBi1b43cDK4VZyHLREaMb22n+C
         qCJwpIvJFwIzFatu6RchWr++GLOFdvA6og0DgwtoCQ7TbK00pC/o9wlQRLf2vAHipe9L
         x5NQTLcPenfEXWOVPE/CXXmATcyuxKKLpBrwSlDMnQBZvr+MiSxbN7EFGsowUyn02eUz
         8fAenl2u1hS88bHRfmejE7cVjj58XkT6yLs/xSilKEvTVrbBkK1AUqdX+WPUpsg9+CDF
         WgNWQeMvk8GC7lsJbMiZdXV+KZUEIuTk8Zhfdom+YA44W2fT3A9ip4Y0hTlzBT8IeR5v
         IewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140556; x=1785745356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        b=rQlOOs4FgJMNRQRvn8z5yJTeNkAQmBuXCn7lAcmMIV186fVrRPMdMA+z35A3mi4abd
         Mu71Ilk4lHHKo6rI4XUIZX7HwjGMbLMWJ2gYYA2t16CzrD20TSzZenPORZdtsOQy5Z42
         tuMTkDIVvDfWGCsUQ2v7e1yk2OKQr6XQ9s8PQgWxm0teNKOneYgjNwch/YG99EYqK6yB
         5DkCYkfu0Zc/TtJZ1g69te2BwTtgwWt5SI3fjwzauVNlSDz0s5VoGYNTrP1suwkEG3/l
         o1wEsKkT+HJVth0UmbjuBbx8qFlhK8Q0CyebMlBtpUogVxE8SwcDw57XnCDgUDst1sO7
         Ir0w==
X-Forwarded-Encrypted: i=1; AHgh+Ro2N3dk0MN2xdm62riqio4aKXmXYMqTiLmf2ujYsukJIrkTQEFPZ9q2hA1qQvz8abs6yMfUas5kTngFkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJuDTRCHVGVMh2gbGv4BNJOYGK0H7Is0yN/S1GZ827mj1mtv4
	11H5zSKZ61a2nExQLqq84wnDvw3LkXtoiJK6g1r87j+ZrHzKWO4HLgLrNpC8ST1i9Kfc/w0y2vN
	qvmO0QuFGKExWuKpIiS7en6QHU/1ykjY=
X-Gm-Gg: AR+sD12zfTDgSjXn8yFpuqnTDAk9dPInbSB6pxU1HIL2/MZJLD4OoFHJGnuLDgvpjmg
	S3KVacdkxsmMM18qGe76qCIbYIW8o3b5cxtkNh2Q4ZGUlulw3B0xlUBZp5Yt9YfOPQsiIFouimm
	x+J+6qEXz8y2hzIXyMzJ/LnvRaI9M9aZBfwS3NXsKmWqjktMldRGJ09x4fUGzj4jorn4oxEYvc+
	/LeN9UYBI/D4vxaWimjvf+KqAaAAf2AnsYAiJKd6RQOUyqJL4eWuffXTN8Nsj4gugEzWYOzx9xn
	plezvBxl4A9KAgK6Ibs=
X-Received: by 2002:a05:6a20:7291:b0:3c3:a9ad:a747 with SMTP id
 adf61e73a8af0-3c67da6cbabmr7867709637.26.1785140555737; Mon, 27 Jul 2026
 01:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-7-clamor95@gmail.com>
 <20260722022519.3b1e4fd3@jic23-huawei>
In-Reply-To: <20260722022519.3b1e4fd3@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Jul 2026 11:22:22 +0300
X-Gm-Features: AUfX_myZ-uH2FsBg2M-NpEbqqEjSB6AkjRrQi_JMKQ0vOPgoMTtIwPKkN8lpkdE
Message-ID: <CAPVz0n2JBNRW3EP+b8Nk1C2MbJnszLiC3hSwEsV7r1ga8obX3g@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
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

=D1=81=D1=80, 22 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:25 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026 11:00:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are us=
ed
> > only in lm3533_device_setup(), which in turn is only called by
> > lm3533_device_init(). Incorporate their code directly into
> > lm3533_device_init() to simplify driver readability.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> >  static int lm3533_device_init(struct lm3533 *lm3533)
> >  {
> >       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > @@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm353=
3)
> >
> >       lm3533_enable(lm3533);
> >
> > -     ret =3D lm3533_device_setup(lm3533, pdata);
> > -     if (ret)
> > +     ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > +                              LM3533_BOOST_FREQ_MASK,
> > +                              pdata->boost_freq << LM3533_BOOST_FREQ_S=
HIFT);
>
> As you are touching this maybe get rid of the shifts and have one source
> of info on where the field lies in the register.
>
>                                  FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata=
->boost_freq));
>

Very decent suggestion, thanks!

> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to set boost frequency\n");
> >               goto err_disable;
> > +     }
> > +
> > +     ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > +                              LM3533_BOOST_OVP_MASK,
> > +                              pdata->boost_ovp << LM3533_BOOST_OVP_SHI=
FT);
> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to set boost ovp\n");
> > +             goto err_disable;
> > +     }
> >
> >       lm3533_device_als_init(lm3533);
> >       lm3533_device_bl_init(lm3533);
>

Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBB46AF17
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035882; cv=pass; b=mZ4vHyZqUfYTnwasPZsDfKTtXdzOCkxC2FY/PdPgJl0c2A5MQh5dmBmUxBp4Byh6QplZ2VbbsJQZv21Sp3qIztA36FLovwVz8f3ybRRRStiaxwHJxI2P1cqst89II+stsnTbU1x7WImX+kOdLm2COrv6LHL60DWrWQ1kRpEVHq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035882; c=relaxed/simple;
	bh=6DZv1K0DlUi+ti2Ixfzbo+SkZOzrPzgNcj+8JfhDZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwft9WiudHh+nBLEqdI/dJ4dLySqJfYnUV9MnMPLF5XZu+moWy3CRAGvJs5rz+Vc+9ZB5abdN/ERUt6VGVHFqTm2ePQVqGmA1PVp7ZdNHMAEfg3ZBHgHYwch6KYtY5LMazEiTfQGmKGOSmaTnfYOGaQW84PzTFbACAQ10Bo0Loc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adtRORoK; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adtRORoK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso718752a91.1
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 06:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035880; cv=none;
        d=google.com; s=arc-20260327;
        b=cLXSH1UN9AGE8fuM0VExvvVHvW7374q4w1DRI+3gWWBeDYEb3JfhJROMMRyOSpmMjg
         XWFeff+qbrUn0qg1kRKa5IKuWcTKspUPEjLv+ydAsiczeKUG8lR3DSOQHImSzx1/uUvW
         xcZE1SWsR22sXEVAE9OGvGg7vvvvbyOqDY3XjUKEcfHXvpx3VBMIwcHa0JZY1D3/h00/
         USxq9vXWmIs+AYTTRqVuk8idoNnka0zz49QLI/F7GmevYsBR3+RKRUuf2NeoSnWbHVjY
         pMGYOczBkvUAmpHzXVYwf3vK1BZ4sHkb8M5ANmiyC9Yt5CYTVH/zDiSq6fmOPAW5VT//
         xOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        fh=DejwU0vpO4AwQXq/Ra57OC7cDsPxHju/Jn/tLp6qHoI=;
        b=c6yZvJSViemQUNrMfSjATPdBUFFiRwGGL8VJWXjyVo3hGFBpPTFKDwSApVYcB2iDfF
         2nBuNfGWWUgeT4dngCydNEjdHmdf7HkStNPLmKQWbBDbfGGkcUcsGDJKVrQs35Qd2myM
         l5yy0jQmZBVw+YmUrZoZUJ993VdG5jDhqdAZdpB5lyGl8NeXVasFrjqO1AvtYki2iiWY
         zYRMFpiRTwkroW6JUQN9YkaPkV1H5Xrzndbk1oq172qXPO02yZr4TVd4x4gxD62LrJEu
         UOUVecdvY2Y8oCNz3jzKaXAq6I6fzChXJvZ8fSms84qNRKg+VnXneTM//IqUBHQKSLDa
         sJPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035880; x=1784640680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        b=adtRORoK6ykURV4MpPqfrnTXyFhgyraH2fPjJ0S7zI+Kwx7knp9zoE890+UYb+j00y
         bFiN9z5SSPD8qzVBXDWlV5SlrMQbkjEPvlDpqIz1kmHac6uHt49DQ93YNWJQfdi5EQHk
         475uVtuqDXE2WWrNE7/ik48QuATe0RyrQUbWMxyxEj9KdpndUMc9EO3fPKh/seREI0ql
         //DrLBaWIMGG0cjP3+D5fNXmM/AIXH05XyLQawLfUa820ELjaK2iJiPlBqzjJ35GHXmI
         D9sKHXvALthnn958hN4yPWlnY+H2pBMvmeGysDo4boFy80Y/Zwozmr8Tvp6DryTrOpwS
         AT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035880; x=1784640680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
        b=EGavRiugWkeUvkSdOEgiRNeOU8UpAQQOqxWg9vhweYrJq/VS+6MVkfbgNxeLHOp8AB
         xvPu0HGyU2a3mKNkHEOnDoblALReWdof6TZDCgM3MmJ8FfgfroGsL1pgQrxCas87Kl4z
         xm4EVq90d6H/ZZGpwICApKrqUxt341wofBIPzsHrOAl0OxiHFhBp7eAl+zWNB2ISipcN
         vvRC1Ghwf0zFgIk8HrkItHrnplPnSN5jZv/LY8bSwdyJKxea5MmwY+uzGSJO/pYOnYYo
         W0YPi9EG4jd+WloQPZ3VkgJhxdDfP6tLatvREiU5931hVWwumOJO+z7KG/sG8dPYIrjN
         iU5g==
X-Forwarded-Encrypted: i=1; AHgh+RqwVgtRnW/2fzbBRBsdbbMZV2h2AtDqPGW6vc96cxwSTc1d11bcqY3uKfy78NmHGoRoAHcpmcihpnVIvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPb7iSMtU4uCReKid5tABtaAFWFt0sqzJaXtbKZGAEJpfJQBr
	S+i/k8IlI7u/I4bpY9EsCKcv6QoffL+AYPSJiCec+jCr5I8LzadW5OKjSdpNzbeazctj1qh7oIc
	McCTjr1Ih7/6tBtE44f2e4q1IKajHRJ8=
X-Gm-Gg: AfdE7cnnwUIqfL5AMtFSlWkoiJJpOXzrKQXyrRaPl8PPUcKepWt2FVyZvkaYyy8PCoe
	h65X4s7XWhv0BTfgT4vKOWRwUfTrlTDgXtZNWAvqtkrd9rU+msv2tTpq6GrkrmN64xJY345YUff
	4fw3NhQGf2pu3w+82ANii2COJFJ7G4OwHo8FdpPRhOLdlDJ5k30qNmHIJ9hbK6UH7aM/IU87rKU
	HGdY1ovufZVqCcc0pnZuOmdnWtsmsp39qYfoNkFVLY4QGEh1eG0/NuD8+5Op9K8g4pqd/bfrAvk
	IzrNWVg94wsbnQKFfYsiwmfO3xDBJ5y758yoCaQW
X-Received: by 2002:a17:90b:5607:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38d13c60530mr18215292a91.5.1784035880304; Tue, 14 Jul 2026
 06:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-6-clamor95@gmail.com>
 <akeHC-OA8tqM941f@hovoldconsulting.com>
In-Reply-To: <akeHC-OA8tqM941f@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:31:08 +0300
X-Gm-Features: AUfX_mxzYxEuGLMctIZqZIdW8wmxIrFK1WcO0C4FctuVUcu9qYtJIaIs5OSxe4o
Message-ID: <CAPVz0n2DPia=nfvd3W-rHy91OvZNO6jdSczT7kyvH-G138KJyg@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:55 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:22AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> > are used only in lm3533_als_setup(). Incorporate their code into
> > lm3533_als_setup() directly to simplify driver readability.
>
> That's a debatable claim.
>

Adding helpers to wrap custom regmap wrappers seems redundant twice.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
> >  1 file changed, 16 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index a9af8e2b965f..69bac1b202f1 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > -{
> > -     int ret;
> > -
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +                        pdata->r_select);
> >       if (ret)
> > -             return ret;
> > -
> > -     /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +             return dev_err_probe(dev, ret, "failed to set resistor\n"=
);
> >       return 0;
> >  }
>
> There's nothing hard to read about the above. To the contrary the logic
> is more obvious this way.
>
> You also remove the high-impedance comment for no good reason.
>

Removing one level of indentations without obscuring readability is
always a good idea.

> Johan

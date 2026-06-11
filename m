Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE623F0763
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181238; cv=pass; b=nTmFRur5Psk9MZJJ0tz51PR4YdFPGzrRA3X7XyI9vJ9tEWry9+2HuBy8XLS3DQ3X7oHzxDFVF+np5vRQ9DaDxFH0kdQrhCa6XWW0bx5M7sjHyRvGZEES3Z6Cv6uSPvWqU27vqI4zWJd9Be1nuooW+F+pF4fFQ6IlEfGi3L/jnvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181238; c=relaxed/simple;
	bh=L22iIiqclocvOudTWkPISdls3zO04nkf5zEFM94Gfhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPdXLit3Z8RcXNBY+wKxmHeV4L2Bob6MR7z0DpN98JmIaDy9379J6uS2L2NDMBlRId/Ng6avEjsQ3sDBQsIN1WbGjv8k6NszUYWUQOGB0jtZmPddv2Jy4hDcHsFrCEcHgPVdCo0crpq/e13uzUxLtvMNhQ9CI9TMsrwDVmQY5HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDu0fAqG; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDu0fAqG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3074adb8fcaso3174449eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 05:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181237; cv=none;
        d=google.com; s=arc-20240605;
        b=VSWt4oC/7tRYbXZsOrvl2RlhlPVmnXcQN6C45mUeo9fxpngZNws0wVIV37gVK1ld9O
         XmPnMzw2IKuAmAeEHS6DpxrlPMynF/L/aBmgtjCWNAYGqtNigm8zp8vYmSqJUaXAkoF9
         v8Ib4wXb8T/EauwCQI5Ir6mLts9Mbe4EhRh3mpH6M1QRHz2umCVhoVUNiBUidxvWKvnD
         iXK/sF8M72izz6e0DCobtuAynMLz0fhqysa5YtuiPttdqeBcpbID84Qvp6rNptQriqW8
         sqqjcb2YbhKwEltLCFwjoWRUZG42grAI+a7U3Ywmv6yP8VUKHs1K+x+ZDmEqVO6OhB9A
         YgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        fh=1qYfcWUiv+V74lNVIVpukEeSj4q2rRlOnznfB+yCPoU=;
        b=FceU9aq8vzszFQlvF+rUAq4x5zNckPtC7mqrFfDFnPpw89G1nD7qd/KP4fCR+HpXeg
         Sw93V7jvH/URdFI9O9wmmlEKDfj6aSGw+3SZLVYgav0Ykdkv3FTS42H9+FBxuWmrf1xL
         fgtEd1bA5oyESPMDzQ9hoE/RO5N/nbS7lKPb3MUpg8wN2nYIgzbLk27ejAryDDhj1xq2
         7PhzY/YQGYwXfwKyVHhiD52iNOq1/YzukyhvM2LqyuTnS35M4tiETvTcdA2GObMVHLFM
         GjWvvRRRWYF5ZWZkXHGfzByqvHg8FSylkih0Kw+CpuE6Y6UDQExRnqjA7LXXaYSnAG3O
         9xUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181237; x=1781786037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        b=oDu0fAqGLc15HSViIqhHK3eGlstvY2ZUf7YvgQkx7b/q6iRWhSuUKkQCbTtle2QEZi
         PXF8UWXM1NossznlpNcC818lenPYJ/hop38uSGIfgqwgaz2nVZV4S/9MSY0bJjZDIfAx
         tqh9VLntTjcB/P3hgofxBOU1pTZxzmKlmPO8FTy6hu5Ag5QjfvN4gvMgwMR4Y+hxQgR3
         I15fpSg1BXU23WScjg3GstcfCVDmQDhTuR58SAuKtbgpwXx8hq2sA8IUaMHZcxL/d7Ul
         xUqYDvf6oRzMk6+F6MXcV10HGBz/0XmAYOLULZoC9i9Klcu6iQqBv+38kw5sx1bDT0FT
         0LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181237; x=1781786037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
        b=iGQrnF6PIHgqOLtr8TqekjR2BUK0Xi/nKCix+tI9gH+9Yra000Bn/Xu1ZoUjhBPlRw
         bJuu+gPfmcmeoAaR3bkY97AGR8bVQqiWKjtqsBkMCxZrRhnsdMuvumYOWVLlXZBFaIIw
         6hC1x/EjG/tEJ+5U6QfM3SI1LV5R1oxkes3/Q4xXtjtqC7HQTc/p0qRNoR13jLiaJtyv
         S6Bvq7O9uyPJndVjDfgTwNVFmZvlRJjC4rlaz/+uStkDjEzWsFluSV9i4ozJptB4BCMN
         mOmIv6vP4N/iJNLpe4cjIz9kmlR903ZxLgMeiQSS9vMDFDeKW+5zMTXtbF9aEgXcB+fe
         fIxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hJSdfsmywgl8Twve0cZhSdcHze6okSeZaVbuLtIWo4zQOIheN/d4r9ccTPOZTJBxS4jMF6Abv1Yd8AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEqy0jr4T5xrMUnCXf4WCgv7joVsx4k666Kgom6LqraTcUNbK
	6KxFauOyrjoyz6OvaGqijrzTPYePlV5381IeGQXRRal8rTYsP8bHw9cTceUMpzPXtf6t6gk1z80
	6xfrdMBVZ4xepqEUXyY2NZFQ/jKZj47o=
X-Gm-Gg: Acq92OGlbw3xLIMU0TSpEeWFbAx3EscVpxsBnUOdCAfMCkOnBfcLilUO61xLERKE9Gf
	ISIjLRbaoKs7SHfSlhc8SHTtbp8sBQ9QI8resPDtcAbIBHmI2IYlN3pJqRniQhkhFgm9yOhrUl8
	q0xRftAJyNK2s2+UxGbDKRukjuZXv6xBVPtQXho0RUbF+B5SNHymKt8XyZhT4PuEo6FpQGwZj07
	pfuIkTcbA2NGOaU4X/fveJN5guEh8F5iP2ERnQrWnTAhWxb+cwemV30CCqTg7B+d9E7P0N+sDjX
	JGsoslIhGQ1z51Qf0oU=
X-Received: by 2002:a05:7300:6da6:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-3080411cef8mr2308986eec.0.1781181236808; Thu, 11 Jun 2026
 05:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local> <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
 <aimy3BxBaXQ3Uigd@ashevche-desk.local>
In-Reply-To: <aimy3BxBaXQ3Uigd@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:33:42 +0300
X-Gm-Features: AVVi8CeX4OO_pI5sFq7qWhCQuBWbqnNi5DWXxYDyaE3k8yybACe4K7ODLE9J31I
Message-ID: <CAPVz0n0bpo6PAfdN+LGEgPYhEx8mqtu_SL=WnDxhWn-Cq4rQKA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
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

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:5=
4 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:45:28PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:23 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > Add Control Bank to HVLED/LVLED muxing support based on the led-sou=
rces
> > > > defined in the device tree.
>
> ...
>
> > > > +     int ret, i;
> > >
> > > No need to add 'i'.
> >
> > This is personal preference as well. There is no strict rule that
> > iteration variable must be defined strictly in the for loop.
>
> This is a preference by Linus who is the leader of the project.
> Also in IIO we have some set of maintainer preferences.
>

Well, this is not meant for IIO, though it seems that Lee is also in
favor if this approach.

> > > > +             for (i =3D 0; i < led->num_leds; i++) {
> > >
> > >                 for (unsigned int i =3D 0; i < led->num_leds; i++) {
> > >
> > > > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > > > +                             continue;
> > > > +
> > > > +                     output_cfg_shift =3D led->leds[i] * 2;
> > > > +                     output_cfg_val |=3D led->id << output_cfg_shi=
ft;
> > > > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << out=
put_cfg_shift;
> > > > +             }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

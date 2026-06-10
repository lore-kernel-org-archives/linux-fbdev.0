Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD341A6809
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101953; cv=pass; b=FIqwDhKqrR6pL66YVXtOcQw7oZEIBBa7i5NM4JsOfOxwjwcQEmFA9oTCs3tiT6iV5m19qmjcaPSaEZYELAlqFKJNOHNstv3YyN68+e/lxq/3+2KHOnFEQ1wFP0FVVRXd012kINvz2lbxjBLxiS8u/Z5XboSVePvhDdse4ewf91A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101953; c=relaxed/simple;
	bh=ES4Wwnm7LDTekDfxBkRjueXtU+JExOHrirYIoXL7mMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqoHqdCzT8k3seltqwwaNK+IJIjZgwwS1bXaDj/5QtPfgpi5Q+nQZlSRz1X5j+TYPFQpUVEmYxrMQHKUhfSrdGkqxEFL73syjE2AAOQ7fznjiLvN3j6YzFUbqxfxTtqiR65ZVv0KbnL3seZSxl2cS9j/TUi3aT/VsRWiULdyuRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFfICjz2; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFfICjz2"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304c520fe9aso2186795eec.0
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781101951; cv=none;
        d=google.com; s=arc-20240605;
        b=gjAm5/44YQ8idxBoAbEEmI1Cm8IBAOH3KEqp9cPlKrl/KBlIeFazDdB8XS5eizWNnA
         0DQOBkGIlEnE0T8gN6VhefcuR33TwsNJ3+KOMu/w1fFDeU5LeWKuhHaWVM5Dl+iolGzR
         1Fy+CBl9cKTHzfdFCo9VOS6sjopY7Pk7yHGqCeJ4GVmJdjfAwWuc7VyfLPInFkHDf7R3
         jQ96HC5P1l0zgxIEZVRVvXfHcmva4DkHV2uswQHIZi4iy1obPxdKIwQtqrG73kS3PN0U
         X5oc/by7aCVKx7/hrsvI/5e0/LXbmKCZjX+atEUH2gEOrDgBupQA77mRWW5gg6EwfAoN
         nmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        fh=v5nDB4UWEoMXE0A+yOZy6aZTeCsnv36iRAQPWcLvzL4=;
        b=IDEZSuHUEmq+JlBxvHOU7HJTKMUoSLGq9nyOnunPVHLGVQOx5JxXn0UgkJx+Y4pHkH
         53PkGhbYK46q87PCisdaZIdZwybGEbwYoeLRrQjGbtkc9exrg797VJY5cwwV66Q+5JBp
         jcDvBumq+D6TBXoKcr0vWa5jt2Q3TJKl+glSB2t+0W8X+qLZmvD7ZP8bDY0gr3uUzMV6
         CS1aBAHzA0kgLpGHpphSf2ndNiiCCsf4tDG4Chgie6ZveC0QpdlvmlMhM5xb4Nlvn69w
         953UFa15oZte7wN3OCSsVx7QlZvUv5Mlow8UlMxRgErkQ1x09eD0eTuC5+VEe6eV+j4f
         0CTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781101951; x=1781706751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        b=WFfICjz241T2kl0XBGu8welhc92Wlr0xtBHWITgpIxMHe5DxxLf3s5BWWcXF40Xct6
         DrvQRQNtctSuTLpSt0XKQtpeKOMV/lQcK/UvwFeXNjn58A0px0zqWy+yvwvzd5LMmEYX
         mgPRZFEgtH8pZsOaQdbUlGyeI/lmOxLN9cIAZLWnYPpLijeRi/9z+aVo5dChJ3yYHZWx
         TtiLfrcb3JcHBjf/RXCLb4KPIBxjVQ0LTSWoe9A9ENoedrCLZMrUGAR5UZPoW5xv1ta0
         LI5J7MH/UfQFJ2bFvddlrEMHUSicdIIpUCEsQ2tt4o2yFLWF7f3YdQP7G4W0Fa3Xbp2O
         V1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101951; x=1781706751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        b=bfF2GYFn/HFk8mvN0Wk7AWihofo1y7U6wbXjyhFdBar3OaO5LGLGgh3TkM0Dq/FFcb
         oA+ws1GHyb/gd2nzCkQA6ouT/a5/2Yz4KvUxcVvj6gY3SYFQejRF5qu06THCCgV7VBuc
         4WYEpQsdy4l2cmCDCsKm+5P52QiZbCdp06ynjq7y+55UZChdk/KaGM/WcjB9N62dqecG
         DJJkyotDpIVBP4OKwgRx14Rb+vRLGYxMbj1aDIXzPTw46YCK49PzIjxcwsxS0YJixphi
         HytEXxLqXN1pM5s40+HeFMpbsE93/ak7B0qfMt5Dkfd2m/NAVH/NaIGJMeumR/Kjbvmh
         UvYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s16HByZKirpeHzz8uHHqdV89Jzy3/Fv9PHc5qOas64FGXI8+nbmDsCg+TgfA54GJqdAIZ9Y1+vmE0dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQGSBbWHwut+WxIU+0AetDw7ZSnpKxm4wDL0F5WdwKutPHhg6
	GeiqRQzDAsrnuYyIVckIOzSfLEQE3tQ5TR86+ANlTpr53XVw9Y+PsPoesZpR9+Lr//TpXLcNBaE
	6Z5F56DgtX+Rvyi97nig5GMY6bytn1g97AzZNi6k=
X-Gm-Gg: Acq92OHV7pk8GjgGXCwi9tFWwmNxhb/x2anCmlInAvCbYTbKLhn57Mz6en3QiHjWTp/
	8uNxQvb9xK+tuTMGIr+DV4emiALzWkhvvWmAg+/KFkaCO+UWrlIG/gzDAkK/oRdgcjSKDv99PB6
	4wOP0TUII0jvQX+Jek75V1Qx18t4VfQl3I97XpmJ5D14HOBilQIhL1HA6+GLCUMRTZBfmLB/fxA
	p3UBw7iVSvTl7HlwX5/1g9VNvzkS76meGBvikLjL1KIGZFN49IRf82Bts9AHYfExio89EErji0U
	nF4HSLFtp3VjZl4/QwM=
X-Received: by 2002:a05:7300:7304:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-3077b3c7767mr18495535eec.11.1781101951047; Wed, 10 Jun 2026
 07:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-3-clamor95@gmail.com>
 <aiPDzdKuccdLIvlF@ashevche-desk.local> <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
 <aihjVZ9xvM2BRFu4@ashevche-desk.local>
In-Reply-To: <aihjVZ9xvM2BRFu4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:32:19 +0300
X-Gm-Features: AVVi8CeI8hlh1GbQ3AYGIMwG28HB2xx8su6lqiYAmfvLYDOtgithK37JF5bkrak
Message-ID: <CAPVz0n1fHWCpHN93v-dKfzGYhvB-dC1E3JgQmXpvfr6bGNLqcA@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap wrappers
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:02=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 10:22:43AM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 6 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 0=
9:53 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:
>
> ...
>
> > > > +     ret =3D regmap_assign_bits(als->lm3533->regmap, LM3533_REG_AL=
S_ZONE_INFO,
> > > > +                              LM3533_ALS_INT_ENABLE_MASK, enable);
> > >
> > > In cases like this perhaps leaving mask would be fine and together wi=
th
> >
> > I prefer to remove intermediate variables it the helper allows to
> > directly pass needed value.
> >
> > >         struct regmap *map =3D als->lm3533->regmap;
> >
> > next patch drops lm3533 so there will be als->regmap which IMHO is
> > more logical instead of passing entire lm3533 to child devices.
>
> Still it's longer than map. A local variable may help with making lines
> shorter.
>

Introducing and assigning a local variable for a single use regmap
operation seems excessive especially since next patch removes operator
chaining leaving only als->regmap.

> > > this be nice one-liner:
> > >
> > >         ret =3D regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mas=
k, enable);
> > >
> > > >       if (ret) {
> > > >               dev_err(&indio_dev->dev, "failed to set int mode %d\n=
",
> > > >                                                               enabl=
e);
> > >
> > > In many cases it won't increase LoC count.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

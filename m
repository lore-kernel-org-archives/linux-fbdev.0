Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15B34E774
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014695; cv=pass; b=PgD1rGManUvf2km+wD3CkDKKx5tx6HO2B0qXmtDy3uMjP4IJTw0ml+VO+bi2giaQ5Xj4VS8+5+QhBHZN3p/KTM16i/7qetNexNXCrKLEqtGYspCUKh0RZy6P4QeVmWzxLiUppZy6ZZq1aOiEMGUlwBXsaoFeqpIUVYjbm2RUA2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014695; c=relaxed/simple;
	bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfAr+JuRrqDNHfX9n8h4WC5lq/Fzf0aJRVuNijKBoeqZzEvwbsRUCw7VXFkB8Rv4kKNccKmVciRzcSCxeYpQHO6c+ANe2jN0BDyykPdigpDgTLBiOBTvqmjUGlkynuvSwWAG7t1s9NyCFmYBtbw/sSr2KXnT6aI1vVUlA8Ay0uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDWJ91Bb; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDWJ91Bb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1502720eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014694; cv=none;
        d=google.com; s=arc-20240605;
        b=B+Sujn9mmAApnnzXr+EpclnjR0MV0KMGyYKDeLfqyxIQwlVdFmqBoABdCVmL8Jk2u+
         g1Hx9As1mMDt2plE3IVwBac3LJlZEki9gTWiLfp7TghG9n19nCIbt+8C50R1IMp8ARgh
         LRPbysPMm1hU4m3g3gv7esNpA9/bsl3ns8GjI22GhylUQGsi0lHWrebTmu1MwFeryCpw
         R1Se545mCR7E4nSwUF6rI7ZTFs/3wdtL6QqinMff8xEWe3QvQMEtGaVOsLVT2zZlIQ2Y
         L0YTLYWtWy3PmqDZfsQekclHeHkg5+rssAnO0j3lfKL1Miu/bVr5j/ltfJiEhVF78GKm
         D9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        fh=o+bhE9fUmM2IykV8PY2yl0UcfGC7Py12gTjQpYgkNmI=;
        b=CXm1bvrOEPuic3gZu6kG0yFu5CBJSmwLyOewLnfp/dY3SsRLN/vQzJ6dRrKYrxrLcH
         qktlh5k1JFZuV0Wubo3FfgWRMJPvq4OuhN8fuKeYmMxcWjEJMWv9fxjb36DRe7Rmv8yM
         rqM/7MXmImWVK3OU3GRoH5G7iHJcTeofD4pdZRWygB5A9EhC225D5YyxlhdPhPOTOh4B
         SS7cCAs/u0xFQXF9quCtotWVtAhWGajXXiyBQuj8LSwcRoFUYPakg1fGsd4B2YpD8kia
         yzVO1i+tab8Nfbyeq0GBa7PXq2uVSjku5dzc10RD8R5OsgIjo22Sw5Ep6xC3O4gr2QTX
         vm8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014694; x=1779619494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        b=oDWJ91BbKlEmtbnEIPmaQuFMaf28jEa+z48mE6988VcnS+WHxZRsv35sS5Vb2HwRGX
         oP1mRwHV0q+aR8MRE83r111QZ5rsPh9b8RBpjZ6/hpq3mm8299Zym7OU0DuNsxOTuGvY
         gQWywgDBj0pCyv7ahPlQlQXMPMFnZP8MrngRDyw2jeg53erPwhSXBZF5RzMgg3SGtTCR
         hwRgEFuyZ8CcZ03Ycq1W6KSUhb78InX8gZSXIPl1JUNCQL5J64RR7gbTqpFrCXM3H2eC
         63LRFEj0uiTbpnipujDJBo250uVVpKXg3+vbFoSvroO48s/kak1BtTKrL2hiXLc4ZFeB
         DDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014694; x=1779619494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        b=LKxhn1PxYJIGAWz2Q3tvky60tugtKOlgYz04XJdmMJvwJC7E+WKX4HB8sHeCeamoQm
         5Xw3gMioqchwENBVm12a/SBXYHyKA5bmkxjOzCPuy4e3VSKe8guaNP/ZzP0UJBHu2tFz
         0VV2Yu5RVPypp1gKN8iG7+e41w1TwRN3wHOae96K1C3vEka0a2fcyM5M0D75M+VhfJfc
         v8zz7g7QI2J5tr78+TXtnjYKaP8qhjQKQZZSq/6WyZo+uPJf/hbTr7cMyH7dQ4aUW8qs
         1hn7Xjrp9Wm63jB76oZEz8r6keZt5ip1dTj6v/gEJQaZ3ldAcAouzZgLzMXc6MJyJQwz
         oRwg==
X-Forwarded-Encrypted: i=1; AFNElJ+XdIX8JeHZ2aqZM7cT7YbTjgXvIbSGcYKGELZz5mqXqsM5XSnJJOkq1YArEPK9nZTuXUplUdYVs5zYjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9q/6zbEeyGwZENjC/MIUDxqCvN9DYkRor+xJj9yrl/3P3dKB
	WlR0akr6qxQMHmUPu7z6KcWHVr4W5odvgMArlVInKNXiam/X/4x8uV/9tCTFIxaz0N/Ut78L+IB
	HxXiSiyIB1bE7/RUSzraXOCarnNPyauU=
X-Gm-Gg: Acq92OF7C8CE0gUOYWrOuuRrJHrZjUEx6QSxfwVkp5Yn/kmc4BFHr1sTWEOcCCORhtd
	8VtAi3ju7sRJR8P+ygzZ5jO++nJ44Z0D2OzIDQPPXZ9CsyoQuyYPYhDZYOdm31UAugKZq0BoBbC
	2oM1G7eumjuVsRp0mKiDM/SZ4K5kPMBDev0zKUUBe3EjIy4xXZ9o7HrtMJuGkmXnG+I4MrmHNFj
	oIDGLakNSrrNOHQBJ17iZauSvoK4E0s6+VGG+LidHu7fXTA7LcWa4TdRbYobMxh5Y9WKat8pLGc
	UVbnqXLKTwWZRoR4T3A=
X-Received: by 2002:a05:7300:641b:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-3039865213amr4762888eec.25.1779014693685; Sun, 17 May 2026
 03:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
 <agmWVdi3TkBb2cxV@ashevche-desk.local> <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
 <agmbFQHezUl5Nydn@ashevche-desk.local>
In-Reply-To: <agmbFQHezUl5Nydn@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:44:42 +0300
X-Gm-Features: AVHnY4JnKOSw1H09HcRgWGFJYaj6RZPBdJ63zUWme_H-q0TpGJTcjfCXnVmnBUA
Message-ID: <CAPVz0n2VAUBNJOLXiGEaRn-x1esd6qeheXa=Br69cZnqmZ1QGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:34:32PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
13:20 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > > > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > > > Convert LM3533 to OF bindings, add missing VIN supply, add supp=
ort for
> > > > > > setting mapping mode and LED sources based on device tree.
> > > > >
> > > > > How is this being different to
> > > > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gma=
il.com/
> > > > > ?
> > > >
> > > > I have decided to have a fresh look, this is continuation.
> > >
> > > Then it should be something like v4?
> >
> > That was more than a year ago, lets start fresh. Those patches are
> > gone, though I did add many of suggestions from there.
> >
> > > > > What about this comment
> > > > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.co=
m/
> > > > > ? Have you talked to Bjorn A and Johan?
> > > >
> > > > No, but since grep -r "lm3533_platform_data" * gives 0 results ther=
e
> > > > are no platform_data users of lm3533.
> > >
> > > Johan was against driver removal (while it sounds logical due to abov=
e) and
> > > referred to some other patches from somebody else. I think you need t=
o
> > > synchronise with the people to have a clear roadmap that all stakehol=
ders
> > > are agree with. With that, the split and other technical issues can b=
e solved
> > > during the normal process.
> >
> > And this discussion was 2 years ago, and
> >
> > "This device is used in a bunch of Sony phones and Bjorn A posted a
> > series adding devicetree bindings a few years ago"
> >
> > They have had more than enough time, don't you think? You would
> > definitely know if there were any activity since you are IIO reviewer
> > and would be included, were there any activity?
>
> At least it's polite to Cc them your version.
>

I assume yes, I have added Johan but there is no email for Bjorn A.

> --
> With Best Regards,
> Andy Shevchenko
>
>

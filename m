Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507520010A
	for <linux-fbdev@vger.kernel.org>; Sat,  1 Aug 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571687; cv=none; b=V3qh2cAYsfdmTRralhg5a6BYWXZl5Wbvd8dhRyZhsN6JsE/m4ovrC0ojb1nb1ic7lCxfoYMFOrhxQyNqi2sL8SFs3YqMu1+iApYT4MFrDXBLhRrwYbJpXuDqmc87PPJh/VuYXqvCJah8lIGYFo8nL3t1OgThJdYsdRA+XkGstgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571687; c=relaxed/simple;
	bh=aJERZKn9pUO/LyXiAcdkBQpZOBFw4wewj6Byjw4taMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5ccwIaefP8sAl/4KODXEUjf7+pG/4hXC1rC3q1UP2TNPQKfaLYmd/cU6oNjlXzb1LYcshROQwFPG8ZdRmaIDv8o+ginBrBpiWTKQ/Jw6Lp2ebveCuhLNMnapaUOjF7IrwQUBAwvFxOkMT+JqdEVCqP4nDAdFDSrI5Ik2zJwNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FMlt/0WA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FMlt/0WA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso2112355e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 01 Aug 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785571683; x=1786176483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhbXt57FHs7QvkLjuDbwFmPJXue3peGLZ2pH9/2qYXs=;
        b=FMlt/0WAXrF3pFQX8vPxYFdkC2rmhzmJGulCggX8iYc2mG+/Jei1V+HwS+J3werhvv
         eMPIhXewfF9KBQf5LHuii6h4WAZtzRuVVaUgAJJu1iwZ//wO8DsvL4AMkVRTcY/gROny
         bnQ1P5CWCE0W/jrKCz7rUWtLWOrf18wzWllHyZ+n8M2t/lJ0kE3U5BYEpvqbsYX8ikT5
         F5K87unJb2l+y5L5B1n9ddHIVGtHAs1N/BZi1BzNI0RtktqDKTS/6SfaibC9tGoA2f7E
         6jqWPM20B02Uv3q695HXD7izuYmuX/FvNMt8XgPrCiDQoEXzYiNjoACfxoorueVRsGVO
         tjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785571683; x=1786176483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhbXt57FHs7QvkLjuDbwFmPJXue3peGLZ2pH9/2qYXs=;
        b=YYoqGkBeT3uAoj2uKNLsUGmSnV9WJ8oPtqAk22EemEtpt/eII2WeEj/VDl4EedPBUU
         NVeKTvgyXTaX2VLuCjzdYI/CudJ1Av4HMOTlkjEa8oKRpTpZL3SJTfDSdR+sWy0r4lia
         rnVU6QMAV0JolWCYdOxvbnVFyc3GYDy3IPno3/2Jq4Vejc55AFcTrxS6FDCZEU4HNVhh
         Ur8Z33YZqfmA1dAUGpiUckx+ePlaZwOkNAgWpvzPym3LWE3u17wMX3IuXIg+ubTL9shv
         eCXivtYn5vHrV8qyn5lO86Iccb+6w6apPW364kL3qMATjMEdQLahF15X31rUb0KKJWF9
         bXOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rru3kWlmIC91YEck0Zy1kp/L0aKRcscJB60Tzh2MI2LS7hQzim7Ss5OuPhe/Noz4TReIjgk+gajUiaUDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HcKCCT/8RCsAA8pkgyzBvFo3Hu+dURH/guWDGm59DAJn0CfR
	flPjegu6+RweQMwcG1PoQJcMHkmZMZTeVqBg6ZJ4wlQnd19VSJOPXGTvyiwLYEuyES0=
X-Gm-Gg: AR+sD11gzFE0SECEpk+jgdSFfvJITW0EHY9B4pcvn/Me2zWASPKbIMCX+jYuw98wPBW
	wSZENWsDFYkMBCWhOKvZ3ttgJ8CNYmJN6MznYLVTNmLUbNX+p6IfG+2reT8rk6H2CA2bsxPZ1gL
	8VTD+9jB7jY3U6bn2/zZDcoUMocMpTVKrmEv1s+3hfgNgJJDZ2pCp3Z9eCoxDq+3m87nlwjR6te
	8wpgKg3f8Ka4d5/9DQbtgrZE75a9zklJUO4RV+k1HvrfHPn9FrkT/rTBwe6CmWgeQBhg66OUCy1
	LzHdeDKhQ6KugkwzTpcNS5jRaWb0BGjVLRGBOgKLZB/Dh30/yLz6Pt7gvvn7209KnrioXwRj1zc
	6kJ7aio/C4giLY4xTnClrDMVdP9Sye084xCr/bRw5y1Fgwu5Xl8IGHGs3M/H0/oiSIS1yxSMbxo
	xD/pmeZio7opdZjI/tBQ3MB+dUgyl41Zh3ECafx/SAgYX1P+BusQF1EPEk6lMLfuhk3A==
X-Received: by 2002:a05:600c:e48a:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4980c66b53bmr17150785e9.4.1785571682507;
        Sat, 01 Aug 2026 01:08:02 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49808191ef9sm37069725e9.1.2026.08.01.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:08:01 -0700 (PDT)
Date: Sat, 1 Aug 2026 10:08:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Max Pedraza <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <am2mvECnCcO9IxuI@monoceros>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7euzt5xlmsr2onq"
Content-Disposition: inline
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>


--y7euzt5xlmsr2onq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

Hello Max,

On Fri, Jul 31, 2026 at 11:50:37PM +0200, Max Pedraza wrote:
> Embedded products routinely need their own boot logo. Today the only way =
to
> get one is to replace one of the logo_*_clut224.ppm files in the kernel
> source tree, which bakes the image into the kernel image. Two products th=
at
> share a board support package but differ in branding therefore need two
> kernel builds, and rebranding an existing product means rebuilding and
> requalifying a kernel for what is purely a cosmetic change.
>=20
> This series lets the logo be described by the device tree instead: a node
> compatible with "linux,boot-logo-clut224" supplies the image in the same
> paletted format the built-in CLUT224 logos already use, and the kernel
> prefers it over the built-in ones when it is present and enabled. If the
> node is absent or disabled, nothing changes.
>=20
> The image can come from the node itself (patches 1-2) or from a reserved
> memory region the bootloader filled in (patches 4-5), because the image a=
nd
> its placement are independent axes of variation. One board sold to several
> customers wants several device trees differing in the logo. One customer
> with several products built on that board, with different panels, wants t=
he
> same logo placed differently on each: there the image belongs in a shared
> binary and only the placement belongs in the device tree. Patch 3 adds th=
at
> placement.
>=20
> We have been carrying a cruder version of this downstream on an AM335x
> product since 2020, across a handful of board revisions, and it has remov=
ed
> a real maintenance burden for us. This is an attempt to find out whether
> something along these lines is wanted upstream, and if so in what shape --
> hence RFC.
>=20
> I am aware of the contentious part: a bitmap is not hardware, and the dev=
ice
> tree is not an obvious place to put one. The argument for it is that the
> logo identifies the board in the same way the model property does, it is
> available before any filesystem is mounted, and it is per board rather th=
an
> per kernel. The argument against is presumably that this is policy and
> belongs in userspace or in the bootloader. I would rather hear that
> explicitly than keep the patch downstream on a guess, and if the concept =
is
> rejected I would still like to know whether a smaller subset -- say the
> placement properties driven from the fbcon command line, without any image
> in the device tree -- would be worth submitting separately.

My 0.02=E2=82=AC: Usually you want to use the display using drm and not fb =
once
the machine is fully booted. If you're using fb during boot to display a
logo, it's hardly possible to switch to drm later in the boot process
without flicker.

So my recommendation for your usecase is to not use the kernel boot logo
stuff, but something like https://github.com/pengutronix/platsch.  Then
all the configuration is in userspace and modifyable using kernel
parameters. Or you create your own application using libplatsch that
selects the image based on the actual product derived from the dt
compatible or some EEPROM's content.

Best regards
Uwe

--y7euzt5xlmsr2onq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmptqV0ACgkQj4D7WH0S
/k6bUwf/b3R5nKZ+dHyzlIKZ+XN6rpMjgW3Dl0H1qu406Hg4yhjBwvx8FmRpc3W2
O6jYub6BAi5oZj+FpvzdR63pWRetwzGpigOqsGlUeGjjIrHbCJWONwOCAu3Q8ynB
CfnK2Hg/gWfPSbnzglGMcvjMnOkkBEV9c07rG72C7qPJClOD5n4qPQhh2TwlVHuV
w2uooARlVezImhDjrexVlRSF8RfZ6tfpHG7Tvingt92i/AnRVb233p6a+8cb4nbY
VTJeBWgsBPTUYC3OQYjgqtHPA1ZE+G6ZZCukwZii7myk+Y7Xdf4EaYVnnI69vrGM
4yeJ1GaCsfsBHz5Himv00/m5LkZR0Q==
=xd2+
-----END PGP SIGNATURE-----

--y7euzt5xlmsr2onq--

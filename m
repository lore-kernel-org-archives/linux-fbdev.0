Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF247295
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387330; cv=none; b=WutIlKjvzlYdEJhPyAvJ52Tci0CiXIQ3HpV4aSt02qK1Ij0HEbaVb7MN0s+cA4uAP5BaNTBeMxdVHZRRaAZKL/s/IxTxMuiTvbtoAsqOwtxrQlZvzBaFmlgYAPnYloPoot6kKsQhSuJY8Whi3CvttWO3MRzfepdpFBnDRkYO0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387330; c=relaxed/simple;
	bh=bjyFGYhygp3KhWFix5ES6YgTS5OXgViNhj0NIrCYWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOfxxbuopp/JY2tChUmliHVDTGcYHRJssmiWeHL6Rt8h/LbHBe1DaRBZ+/891zeQBPfRGKasTexFyROHAEgrLkQLnWm8Y1wC/3T4RwReJ1lsUgvTi9BtAnO+4Wp/3HRx2Ej3RGtcgebu4n4OZ6uS3KFjXhdeRKUBBQ4PmTQqG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zs38618W; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zs38618W"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so19678085e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Feb 2026 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770387328; x=1770992128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjyFGYhygp3KhWFix5ES6YgTS5OXgViNhj0NIrCYWy8=;
        b=Zs38618WqpMs9lQyGcCj+RgiTexWIU86aUYPGwG6QbfgSUbTXPCZjHpmVGRcXRgZf1
         If9Xw5Qn2D0t2LfqrPLOB1k9nIbT0kBJfxGXlrsPTDoZrTh4YMfJ3j7/0JZriqW/UshS
         dw4qew84Gd1rxMwH6JMts6S4kDNWmqiA7XN1NJUtGJ4aSs78EWkvKci9w3ff56l52wsQ
         2Ko+2KUlPe5UHvMPY1q2Lmh0qafFKOCnJCFDXt4bn5ebA/99ksfCo6YRR110wRbygvgg
         ASbPn0ckJ/s4TuFDFPrzZiu2dxf2VoDsUs5iw/jk+16Qf2+0JGW0NORW6NbQxA6wUd5k
         tv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770387328; x=1770992128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjyFGYhygp3KhWFix5ES6YgTS5OXgViNhj0NIrCYWy8=;
        b=tjD27EIh9y60tqU5DRRYTBIf/JrdQjKm+eHLkHSO7sJYJvtPwc4lheh1+bergPJGrl
         0JjStQekdLrBvLxoccScboIZUrxZnxc49OKByrOt5oQcEYGQBzUERhX535Q1UwDncTsv
         9uytJkVdh3sA85ydfzWs5NIJyUDCDeC5+/hwP2f06ZVr7oJw8xOp9T5txjkxom/XCbb8
         7JcV7kDBuxYllkixu1y0XqH2y2GS5+F7mfm9inhtJaUfKgLJBHcgjnbdIloWTv29vzC3
         BguKC0AHcwjFH3GF25ZHmCr/FZp0RNfljveg0Fs37+DoGF5Z6u8xQmajhtIJEUn6n6gC
         hZsg==
X-Forwarded-Encrypted: i=1; AJvYcCXRLLeGUG4Cp7uN2w5o897SOHvIPZr//Q61L/iThe156j7xTpr9ATIF/wY9nzLR5gEdxyPlp9PpjS+7QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqpyDFCfSw6ovXQZirI6qXcHe5Li8IUG/CL3c6mZt+ehGCOZu
	5JbTgy2xrEBMJW74QPowZ4Ts8TM4BynTlUpQ1I/fv9wxp5iGHKEq4X9mLmcvZl1ZRYNkH3ATKNb
	tAqk3QvM=
X-Gm-Gg: AZuq6aISTHFCcNwZgsmL5izw0U+um1eNDHaG1AkbQ3sQ+tOk3fQhdiXZ0bLHKZv+52r
	nCSNz79xWXxKi+1iCX7DnApBxsQe4TXH0EzuErjoCbK/EYvJOnIQEwn3TNK6A7FWLpx5IzgQ2gD
	1wNNJPBW2luHke2qzSPSSsCSS5uXhQp6kWOcPrSW3gwWEitbVi6m5wwUMarfoxI+UWWFBQfFf6r
	W5Oj/9lUPlNIfXTzADDPUVlqfN55I2f3sfohorHaVCRYk4UPzuGSxZI9X58iBsLJQ45BviI7R0I
	2J/v110d08rfILU3IvCqQhjj78/SZ119F45ocosLBBmvOTo0HfgbnZS//LLs8YRtEtgZFNGNSVZ
	Xkc5c7K2a1fiEE8S2xiKgDwAXXhTm0d3g5lHx2sWSzMdMZpAVuUTvjOdLAV2OOFWlYS7NhHPVaL
	RP7jkL7IEvNxBQ2egwqUiu5GN4T93HdVJgOpWUdoh4MixbpFVLnGeE2imhJ/CUckn9Y5NU9XG4m
	wk=
X-Received: by 2002:a05:600c:c4a7:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-48320231161mr38699525e9.23.1770387327777;
        Fri, 06 Feb 2026 06:15:27 -0800 (PST)
Received: from localhost (p200300f65f20eb04dd2029d872c27e4b.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:dd20:29d8:72c2:7e4b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48320410b78sm32854755e9.2.2026.02.06.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:15:26 -0800 (PST)
Date: Fri, 6 Feb 2026 15:15:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 1/3] fbdev: au1100fb: Mark several local functions as
 static
Message-ID: <aYX3KYbdSUPTSHG-@monoceros>
References: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
 <ceb08e29f6a07075b5ca63e4ed30c5051fddcdfd.1770196161.git.u.kleine-koenig@baylibre.com>
 <cf0433eb-e22d-498b-93a2-04b461aaa6e2@gmx.de>
 <28affc45-7f41-40a5-82bf-308a6e34d956@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbcs3jm2xyvoo2ch"
Content-Disposition: inline
In-Reply-To: <28affc45-7f41-40a5-82bf-308a6e34d956@gmx.de>


--tbcs3jm2xyvoo2ch
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/3] fbdev: au1100fb: Mark several local functions as
 static
MIME-Version: 1.0

Hello Helge,

On Fri, Feb 06, 2026 at 12:22:39PM +0100, Helge Deller wrote:
> On 2/6/26 12:06, Helge Deller wrote:
> > On 2/4/26 10:15, Uwe Kleine-K=C3=B6nig wrote:
> > > This fixes several (fatal) compiler warnings =C3=A0 la
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/video/fbdev/au1100fb.c:530:6: error: =
no previous prototype for =E2=80=98au1100fb_drv_remove=E2=80=99 [-Werror=3D=
missing-prototypes]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 523 | void au1100fb_drv_remove(struct =
platform_device *dev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> >=20
> > I've applied patches #1 and #3 of this series to the fbdev git tree.
> >=20
> > Patch #2 needs fixing, as it breaks build on s390x.
>=20
> I fixed up patch #2 manually for now by excluding s390x as test platform.
> If you have a better patch, I'm happy to take it.

I didn't look at that yet, but I suspect that the failure isn't s390x
specific and I think it's better to not relax the dependencies yet.

Best regards
Uwe

--tbcs3jm2xyvoo2ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmF93MACgkQj4D7WH0S
/k7T9wf/QGC6mWJuNMU2J2OQf+ThcYYgLqXINFepVUdYoRPW92brCm7x2TiVdKLO
BYf3ynkCUoPbNLKPYedawSQvGGeC5utCZfZn/LqaAzaS40uGlAPrxJvLw0B3S54N
kzLDMXf6sarX6/QwqgFz9MbHE53rO4bBl3qXnQzXWqt1NYKnusmky9zrP6K3w4DJ
6zJNRxbNNCCD5Doc5ZMVAgRfiH8E8gGGyrrPg5jo7dCHm0b2Be8msMBRVu3pJEn9
2VNGn3c5bMhfKxzfXPLf+S1Kzcv+ZVI0yHg/qu7tzGxlHGrDmorjjbwRR1+d7wk8
Csc5smqEn+67u9awy+L22Xv518hHEw==
=Lbvd
-----END PGP SIGNATURE-----

--tbcs3jm2xyvoo2ch--

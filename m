Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B42D3ECF
	for <linux-fbdev@vger.kernel.org>; Thu, 21 Aug 2025 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745513; cv=none; b=ZPW7LyDk0AKw8HAjD7g5CKIDtx0RY/v+Myx3epzb3jXp0tkiZD5x13DVe7j9B2bTp1k5YyGAdHHn/uzdx/v3rQHiFqWQPntsZN0Sl5yetsaMYHK+CpDAdbx1zu99l1EECfJBcQmis5qasML+wyJfWitie6KlDP+hjyn6JBpvoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745513; c=relaxed/simple;
	bh=42mJUxzBaGOIdxnlspI6xaxDFGvGJa4t6GnVoBdW22c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=VjxL8DaM0moi6Xhf5IAoJ8HPEXheJg5bThf81S5L81bBAN2LHUMH3+2uHrZ+oCv1av+tBf11rVuWOOBYXZ09ZsRA6B6AWTsqYWzegeHsHWzB69sGbjZEkZ9f4sbiVxKzxdkJTwMAgLBzRdfJ3JgvdhPEpG7A87aZXo+6QIaDyVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.1.73] (4F7A343C.dsl.pool.telekom.hu [79.122.52.60])
	by c64.rulez.org (Postfix) with ESMTPSA id 137441020F;
	Thu, 21 Aug 2025 05:05:08 +0200 (CEST)
Message-ID: <9473ef5b-c298-56b1-0051-e10bb3b4dd67@c64.rulez.org>
Date: Thu, 21 Aug 2025 05:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: Erhard Furtner <erhard_f@mailbox.org>, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <1fda26b1-f988-449d-834d-b185d3ebf5c6@mailbox.org>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: UBSAN: shift-out-of-bounds in
 drivers/video/fbdev/core/fb_fillrect.h:100:21 (v6.17-rc2)
In-Reply-To: <1fda26b1-f988-449d-834d-b185d3ebf5c6@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------465X0dp0dcCFUbYFICqAZu59"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------465X0dp0dcCFUbYFICqAZu59
Content-Type: multipart/mixed; boundary="------------bY0FFrD4MbwWZx0CYx98LZ0G";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: Erhard Furtner <erhard_f@mailbox.org>, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Message-ID: <9473ef5b-c298-56b1-0051-e10bb3b4dd67@c64.rulez.org>
Subject: Re: UBSAN: shift-out-of-bounds in
 drivers/video/fbdev/core/fb_fillrect.h:100:21 (v6.17-rc2)
References: <1fda26b1-f988-449d-834d-b185d3ebf5c6@mailbox.org>
In-Reply-To: <1fda26b1-f988-449d-834d-b185d3ebf5c6@mailbox.org>

--------------bY0FFrD4MbwWZx0CYx98LZ0G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Greetings!
>=20
> Getting this UBSAN hit on my PowerMac G4 DP with kernel 6.17-rc2:
>=20
> [...]
> Console: switching to colour frame buffer device 240x67
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/video/fbdev/core/fb_fillrect.h:10=
0:21
> shift exponent 32 is too large for 32-bit type 'unsigned long'

Thanks for reporting!

> I guess this would be a problem on other 32bit arches too?

It's only on 32 bit big endian. I don't have UBSAN for MIPS on my setup
so haven't noticed it.

#ifndef __LITTLE_ENDIAN
        pattern <<=3D (BITS_PER_LONG % bpp);
        pattern |=3D pattern >> bpp;          <-
#endif

In the 32 BPP case the result is identical in both the no shift and zero
result implementations.

I've patched it by skipping this realignment as it's only needed if the
BPP is smaller than the word length.

--=20
						    -soci-

--------------bY0FFrD4MbwWZx0CYx98LZ0G--

--------------465X0dp0dcCFUbYFICqAZu59
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmimjNkFAwAAAAAACgkQWOeEu4KftGv7
bgf+NaPv0Y8aB946BhEzP2K6F5FMVuSdCRFFOABPx7zxh3RrJRki+Sb0g2sT8U0Ku9BTnw1DUPzC
wBi6O7iXZzdRCxrnbjQyo68lQOIQ2iJhHUieT6M2fyyX1Qqv+1FB2aSVpfi1Lb/xlS7ndUsxwD1A
RJGGddTsQzc6OoRZn1KgCUf3JdWylU86c7Oe5zhLBo5hRW2qCAjjt4dCfBqNLH8brw4oJU5uAa3s
xi8rgqbfi8yBuGDz88oHlwzonDRjsV71Xxy8WdV2RzqsGM2BgK0bBvIudg5FQihM2ZNqoW1YIjhj
Wl3NSwYM6bv8dZ//S6hDzNsB0BNYCBi4SpwLLQCV+Q==
=v2Nq
-----END PGP SIGNATURE-----

--------------465X0dp0dcCFUbYFICqAZu59--

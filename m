Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC7223DEC
	for <linux-fbdev@vger.kernel.org>; Sat,  2 Aug 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754155546; cv=none; b=hh7zhIJL8X42dNhw98OIXoQSamB/fNk7A/cgJhBdKXtmNQ9l41PYMc4Ky6yCH71RWxnNFwgRfdGbdJ5YUcrDv3LhYUD+q5Py2EaYjRk7jZEav9i4btCEj+XBRtw+ZIPgxMGd0z8GETof/95Y5iEARlTxwoxTq60K9xi8naKaQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754155546; c=relaxed/simple;
	bh=TWHwDQpXps2jKLg3UU4OEI/pcgARKjMLaRssFoct8Cw=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=E1wSh2IZVsA+qlyfBq9+BkqeTx71A/Ih8Ss7ZTDmN4CiovXghEjOHDLFm0lAC5Mo4UjNDf48T0pP4+rXyHITFXFxLCmq7P3Ss0xkbuN+2XzxZJBrbDl2lQAmLQQbxdcrt0a/X+sTJowISb42U65F5z1sTQQv6qUCvLvVrWk6T70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.1.11] (91EC17D6.dsl.pool.telekom.hu [145.236.23.214])
	by c64.rulez.org (Postfix) with ESMTPSA id AE07610134;
	Sat,  2 Aug 2025 19:25:27 +0200 (CEST)
Message-ID: <e483d221-fc09-2ca6-b65a-e2d10146f7b7@c64.rulez.org>
Date: Sat, 2 Aug 2025 19:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
References: <20250731171552.33585-1-soci@c64.rulez.org>
 <59be2951-79a2-45c4-b59d-6b7fc500b4cc@gmx.de>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: [PATCH] fbdev: core: Add checks for vc_resize failures
In-Reply-To: <59be2951-79a2-45c4-b59d-6b7fc500b4cc@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dYbQ4cyopQFMVJbndk2IfQUB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dYbQ4cyopQFMVJbndk2IfQUB
Content-Type: multipart/mixed; boundary="------------zhvPEBEjTfJz0Xd3CJfdaFJr";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Message-ID: <e483d221-fc09-2ca6-b65a-e2d10146f7b7@c64.rulez.org>
Subject: Re: [PATCH] fbdev: core: Add checks for vc_resize failures
References: <20250731171552.33585-1-soci@c64.rulez.org>
 <59be2951-79a2-45c4-b59d-6b7fc500b4cc@gmx.de>
In-Reply-To: <59be2951-79a2-45c4-b59d-6b7fc500b4cc@gmx.de>

--------------zhvPEBEjTfJz0Xd3CJfdaFJr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Helge!

>> But in very rare cases vc_resize() can fail. If one follows the syzbot=

>> monthly reports then this isn't all that rare because allocation
>> fault injection can do that reliably. Usually the one in
>> fbcon_set_disp.
>=20
> Can you point to one such example?

https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D11742d63980000

>> Handling these failures gracefully and rolling back the resize isn't
>> trivial effort, at least for me. So the next best thing is to add
>> BUG_ON() checks.
>=20
> I understand that BUG_ON() seems handy, but it is not acceptable.
> Having BUG_ON() makes it possible to trigger a complete kernel crash,
> which we really need to avoid.

Yes, suspected that it's not the right approach (checkpatch.pl warned)
but haven't got a reply when I mentioned the idea a month ago and so
thought it's still better than the other alternative.

However I've just realized that there was a better solution only 20
minutes earlier by Sravan Kumar Gundu for the same problem.

Could have avoided sending mine, it was so close :( Please disregard my
patch.

--=20
						    -soci-

--------------zhvPEBEjTfJz0Xd3CJfdaFJr--

--------------dYbQ4cyopQFMVJbndk2IfQUB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmiOScUFAwAAAAAACgkQWOeEu4KftGuG
gAf/bvUaibwU9hqk7lQAIdLENUWjxXtdzG+QGG388zzrfrlorkMQ4LAsnLP+OSHPwmZQfdP0go/c
+CtbdJFNvC3P3qAasVQIqnsD/a1FOFU7eGDzEnTIxd2rLfT9Z67tqgewAu9TzFpKqDpa3oXrHeNH
muFcT5FLJSDmqyatK1f46obEtdM7jIYuxzevEUdrhQMPnLKafkPI6xjNtmeo9pZe7m8jvMq1SpFU
3celiO5qzv5mSmLT76bEdJDTk4mly8hn7sdWzQfBLB6S46q1R4jZQX9JXYDdv/45QX5kien6eLzM
c5a1BP/EGUwneYCwfbtCefJNPaD3c4um7MImPvOX1g==
=FszX
-----END PGP SIGNATURE-----

--------------dYbQ4cyopQFMVJbndk2IfQUB--

Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F09EBE
	for <linux-fbdev@vger.kernel.org>; Sat,  8 Feb 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975905; cv=none; b=uLTnwvIuJZ0XsPpfp5ZlSe6K+HdKH455dZjGNXJZojsWQcSE3cCiLbKtCtUTFJQJe7EH1lgN/Y3UbODUGWUULXy6Kgfg8IPMna7dmCwpVuip2HYy6CEZWsPwvCaP0M/GzW3n5GcnWn7skWhITUVcAbg50596y2kl9RbevNtAng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975905; c=relaxed/simple;
	bh=ONTasIcvrwbSEasDG5jKQixpyUIKoMFuJKkYY688BNk=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=HIB5ruOOsTadLjwIZcLCuJxkvZd5v3I6zEHI8lO7Da+BJVyCHGGpw4IqHGsKs+k52B1GLiC+ynrCRClZuroe8yF6Q5xbviXn2ybv+V0p00qizuh4W0vAd5vAJQ1CkOEpsiu1UWeXTd1DB4G3ua7cKWpAcwA6tseTrRZRv0zBvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.115] (unknown [89.134.11.189])
	by c64.rulez.org (Postfix) with ESMTPSA id 4C69B100F6;
	Sat,  8 Feb 2025 01:51:31 +0100 (CET)
Message-ID: <8c0aa1f0-27f8-befa-2b27-76e9faf7fc6d@c64.rulez.org>
Date: Sat, 8 Feb 2025 01:51:30 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250207041818.4031-1-soci@c64.rulez.org>
 <c4db73a2-12a7-41f4-a175-332c44f51bc4@suse.de>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: [PATCH RESEND 00/13] fbdev: core: Deduplicate cfb/sys drawing
 fbops
In-Reply-To: <c4db73a2-12a7-41f4-a175-332c44f51bc4@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zrCE9RTpZfdjfCQwIrX4E8p1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zrCE9RTpZfdjfCQwIrX4E8p1
Content-Type: multipart/mixed; boundary="------------P5ZohRz3iLDhhg8Q65q191HU";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Message-ID: <8c0aa1f0-27f8-befa-2b27-76e9faf7fc6d@c64.rulez.org>
Subject: Re: [PATCH RESEND 00/13] fbdev: core: Deduplicate cfb/sys drawing
 fbops
References: <20250207041818.4031-1-soci@c64.rulez.org>
 <c4db73a2-12a7-41f4-a175-332c44f51bc4@suse.de>
In-Reply-To: <c4db73a2-12a7-41f4-a175-332c44f51bc4@suse.de>

--------------P5ZohRz3iLDhhg8Q65q191HU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Thomas!

> No it's not. Major code abstractions behind preprocessor tokens are=20
> terrible to maintain.

Hmm, don't get me wrong but I'm not sure if the changes were really
checked in detail. At first sight it might look like I'm adding tons of
new macro ridden code in those header files replacing cleaner code.

While actually that's just how the I/O version currently is, copied and
white space cleaned (as it was requested) plus comment style matched
with sys.

The only new thing which hides the mentioned abstraction a little more
is FB_MEM, which replaced __iomem. But that's a tradeoff to be able to
use the same source for system as well.

Or the concern is that now system memory specific code might get mixed
in there by mistake?

It was not planned as the final version, the current maintainer asked
for addressing some pre-existing quality issues with further patches but
otherwise accepted the taken approach.

> It's also technically not possible to switch between system and I/O=20
> memory at will. These are very different things.

Yes, there are architectures where these two don't mix at all, I'm aware
of that. I need that on x86 only (for old hw), and there it seems
doable. Depending on the resolution either the aperture or the defio
memory is mapped. If the framebuffer is not remapped after a mode change
that's an application bug. Otherwise it's harmless as both are always
there and don't change.

I'd better like to find out problems sooner than later, so if you or
anyone else could share any concerns that'd be really helpful!

> If you want that pixel-reversing feature in sys_ helpers, please=20
> implement it there.

Actually that's what I did first. Then did it once more by adapting the
I/O version as that gave me more confidence that it'll work exactly the
same and there's less room for error.

--------------P5ZohRz3iLDhhg8Q65q191HU--

--------------zrCE9RTpZfdjfCQwIrX4E8p1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmemqpIFAwAAAAAACgkQWOeEu4KftGth
1wgAkeHUwzAtvRl+xA+zG/saL4inUubQsNEu3Kdn7YGaiZuNcP7TTNCEdHhk7XfDvbT/M4ZQyc0x
jkmcoM2ABey1XQAl5LWnwL5lQMX5/ghDokLwTOnByiuxtWiptL6RfspDY79zr6tKoxE1LgSOOQKu
Idb+Md+pifxPdArgVpcUwb7hoSJf+ohMQ9wJO3I3J3n7FvM0sP6bawloxX8A30AtN8zktCZkOIGy
Sbipo+1iXQ1ls1rHEm6oYfS5TRikNrUxeI7U2aYjCs6k4+ukQw9byDBos0em5oXu1edcZRhjYnGV
S1+m2KTGsJWLVzRjES9dygAMESQOAFFxPQ6rdH3f5Q==
=Conf
-----END PGP SIGNATURE-----

--------------zrCE9RTpZfdjfCQwIrX4E8p1--

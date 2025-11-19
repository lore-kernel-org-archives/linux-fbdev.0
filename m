Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9402D7D59;
	Wed, 19 Nov 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586849; cv=none; b=NsAFSh6QvtYm+rBhzJFK6iTWyIqm+4d2ZgxQ02F2wvDQfiKsdi4Yg6mJV3Ui7lw6wepZhYCqoXjqY/CRo/jOdruignRWICU9o9Ha68f/7tLsfhuD8SzXuwdRwFtE53qlHBuVxIflAAX2ZJVvIXCM2wgFxH+SprihDWc5B76A0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586849; c=relaxed/simple;
	bh=5G2MKVz2Y9rzTCPA0oiKRe2k1yeJziZ9CZNWJ9CF2Bk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hHGeQhlaAQ7jx8bx650Dd1CUrAZJk/0ZGUjlryeMGOn0WDWJnGUA60tDdgAX+sRPaqjnDcOwQCbUfd1Tkjz66SMkG5TyZe8mJqGA28vKXaNoL61Gh7Tw4Feu/gEj2iDDdmVb4dOj5h09HVRpbWAlGoIib+Py6+DryXM6hHD4lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.66] (catv-89-134-15-182.catv.fixed.one.hu [89.134.15.182])
	by c64.rulez.org (Postfix) with ESMTPSA id B8E6A10035;
	Wed, 19 Nov 2025 22:05:16 +0100 (CET)
Message-ID: <03796e70-edd9-a6b5-525f-db6f9431aafe@c64.rulez.org>
Date: Wed, 19 Nov 2025 22:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: ssrane_b23@ee.vjti.ac.in, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
References: <20251119133821.89998-1-ssranevjti@gmail.com>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
In-Reply-To: <20251119133821.89998-1-ssranevjti@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WJxmulm40VN55lgQyh9DPoVg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WJxmulm40VN55lgQyh9DPoVg
Content-Type: multipart/mixed; boundary="------------0te3fv09PAuezi1F1iKIFdtQ";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: ssrane_b23@ee.vjti.ac.in, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Message-ID: <03796e70-edd9-a6b5-525f-db6f9431aafe@c64.rulez.org>
Subject: Re: [PATCH] fbdev: core: Fix vmalloc-out-of-bounds in fb_imageblit
References: <20251119133821.89998-1-ssranevjti@gmail.com>
In-Reply-To: <20251119133821.89998-1-ssranevjti@gmail.com>

--------------0te3fv09PAuezi1F1iKIFdtQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello!

> This patch replaces the insufficient check with a more precise one. It
> calculates the effective width in bytes of the image (accounting for
> clipping against xres_virtual) and ensures that the last byte of the
> operation falls within the screen buffer. Specifically, it checks if
> '(dy + height - 1) * line_length + effective_width_bytes' exceeds
> screen_size. If it does, the drawing height max_y is reduced to
> prevent the out-of-bounds access.
I know my opinion doesn't count much but would like make a note.

Any bound checks which are applied here or at the entry of the other 2
low level drawing routines are just masking an issue somewhere in the
console code. The text area should be entirely within bounds of the
screen memory. If that's always the case then there shouldn't be any
drawing request outside of the framebuffer either.

Please consider at least to add a warning instead of silent clipping, as
every time such clipping was done it was a result of a bug.

--=20
						    -soci-

--------------0te3fv09PAuezi1F1iKIFdtQ--

--------------WJxmulm40VN55lgQyh9DPoVg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmkeMQwFAwAAAAAACgkQWOeEu4KftGsN
Ngf/R3WSkZ/NqLnkoDaG/U3o/KY7IofEoC+D499XmqTtb8scpAxKiDGZv+P69uTdfbjF3MnrBWVE
yZXbqS8DEUq+MS/AFP9Rfjxk9ysUKJJMT69NWwvQZoKaFN4p/Yyb02Ey5X3IP7mICyQmK9uNjphD
M/Abipc3uWDPgLqco7Vpf3S8qTDAR+BiiSdoRdl+s3350vMiijh2CMiDqpKW3E91ltTyK7yDtocU
tXV+K6NShxKiGulLQChEv5u755bXWNfffcbWyeAqR4Gn2iOR0jaRcLu1x5V0+paJAHzqrPrv0HNJ
e+a63bozv6QAz73rrIf367qgB20l1CYg+y41pI760g==
=mBm3
-----END PGP SIGNATURE-----

--------------WJxmulm40VN55lgQyh9DPoVg--

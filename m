Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501A1DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738499987; cv=none; b=g557WJBu5nSBaDDKEZSRDTNh1z8tJu/1vVW5dWFzrdwHflHvZgYhzUKe9PiK80mw05pQ/UW454+qcUxe+kNlllN/enfD6izA5ZynLj8eeyFFU/0O7dYpFmkCLTyn9Y2BGnfxfCDORG4dfbVbtJr7XThvev0dxHYIDR3Zzqknc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738499987; c=relaxed/simple;
	bh=jCKGudXaPET+vTIDKwHvjIEjPDXpk2kb3jayjLY1uFM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KCNgNfMmKmntN/NVoNNd8DR7y3kuE9LPrXMNA4gyRwNmApSVo9HthHQfltFF6+0aikRAQoTAkqkhkynCzlQFbis70LZH3zOWtxqmSOk7Kaw2qInbMB/Dzsl6xuiM+4GDYfTFmJMgLPnXFEs0ab1ik1lqYPHQyWSPkV7dNDWLCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 73684100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:39:34 +0100 (CET)
Message-ID: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 00/12] Deduplicate cfb/sys drawing fbops
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d6FaGztmFPOD8TgZbFLVI9sO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d6FaGztmFPOD8TgZbFLVI9sO
Content-Type: multipart/mixed; boundary="------------bJFyDLoFWEmffT695C2sn9PE";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
Subject: [RFC PATCH 00/12] Deduplicate cfb/sys drawing fbops

--------------bJFyDLoFWEmffT695C2sn9PE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everyone!

A series on de-duplicating the common cfb and sys drawing routines will
follow.

Some background:

It happens that I need to use both cfb and sys drawing routines.

At low resolution where the aperture is large enough the framebuffer
memory is directly mapped. As usual the cfb routines are used.

In the high resolution scenario defio is used to make banking
transparent, there the sys drawing routines are used.

There are packed pixels, of course in the wrong order. So that needs
CFB_REV_PIXELS_IN_BYTE, fine. Or almost.

While the sys routines are based on cfb for some reason the former lacks
pixel order reversing support. The result is that at low resolution the
console is fine, but it's unreadable at high resolution due to the wrong
pixel ordering.

First I added the pixel reversal support to sys, console looks fine.
Still I might have made mistakes when doing so, that might need
further testing just to be sure. Hacked fillrect to run in userspace,
wasn't easy and now I have to come up with edge cases...

Had another look at the cfb routines and sys is basically a straight
copy. Minus the pixel reversing, FB_READ/WRITE macro inlining by hand,
comment style updates and a few changes here and there for I/O vs.
system memory. The memory access differences could have been easily
covered with a few small macros, strange.

Cfb has a working pixel reversal as far as I know. Now all it needs is a
few changes for the memory access differences and then I have the sys
routines with pixel reversal. And can also be reasonably confident that
it actually does what it needs to in special drawing scenarios.

So the patches below take a copy of the cfb routines as header files,
and add macros for the access, text and other differences. The comment
style changes were taken from sys so that it's less different when
compared. Then the cfb and sys files were cut down to just an include
of the common code in the header plus a few defines for the macros used
in the headers.

I was thinking what to do with copyright/credits now. On the new headers
it's clear as it's basically cfb, but the new cfb and sys suffered
significant changes and not much remained. I kept the original authors
but it might be questionable on sys, it just an includes cfb code now.

I know at the moment there are no users for the pixel reversal function
in sys and could have sent such changes later when truly required.

However there are some maintainability benefits as it removes lots of
duplicate code which might be worth to have meanwhile. The pixel
reversal gets optimized out when not in use so I don't worry about that
much.

Zsolt Kajtar (12):
  fbdev: core: Copy cfbcopyarea to fb_copyarea
  fbdev: core: Make fb_copyarea generic
  fbdev: core: Use generic copyarea for as cfb_copyarea
  fbdev: core: Use generic copyarea for as sys_copyarea
  fbdev: core: Copy cfbfillrect to fb_fillrect
  fbdev: core: Make fb_fillrect generic
  fbdev: core: Use generic fillrect for as cfb_fillrect
  fbdev: core: Use generic fillrect for as sys_fillrect
  fbdev: core: Copy cfbimgblt to fb_imageblit
  fbdev: core: Make fb_imageblit generic
  fbdev: core: Use generic imageblit for as cfb_imageblit
  fbdev: core: Use generic imageblit for as sys_imageblit

 drivers/video/fbdev/core/cfbcopyarea.c  | 425 +-----------------------
 drivers/video/fbdev/core/cfbfillrect.c  | 362 +-------------------
 drivers/video/fbdev/core/cfbimgblt.c    | 356 +-------------------
 drivers/video/fbdev/core/fb_copyarea.h  | 421 +++++++++++++++++++++++
 drivers/video/fbdev/core/fb_fillrect.h  | 359 ++++++++++++++++++++
 drivers/video/fbdev/core/fb_imageblit.h | 356 ++++++++++++++++++++
 drivers/video/fbdev/core/syscopyarea.c  | 356 +-------------------
 drivers/video/fbdev/core/sysfillrect.c  | 314 +----------------
 drivers/video/fbdev/core/sysimgblt.c    | 324 +-----------------
 9 files changed, 1190 insertions(+), 2083 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_copyarea.h
 create mode 100644 drivers/video/fbdev/core/fb_fillrect.h
 create mode 100644 drivers/video/fbdev/core/fb_imageblit.h

--=20
2.30.2



--------------bJFyDLoFWEmffT695C2sn9PE--

--------------d6FaGztmFPOD8TgZbFLVI9sO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefZ4UFAwAAAAAACgkQWOeEu4KftGuk
dwf9FVu7CS8h65OyVCHnQaAKf83fQj2xna9RtsfzP9HOEtfuE1Q6YqM1Tgag0mKrVdeseQXJr+Wk
flA2GQy9I0U2sWK+fsjOl03TJRzHaqpBExcxeOaL5iwlZHiXA/vUn6uaZmn2MK8R9uQ4pi0idEyd
wFpgS7tdDYs2M5lIzcvUueHMSBAiHTtduotduiLnid1wz/9i5zwL1v8NCs8oa9k2ezMmFVruuqO1
7z+y+aSCFJIOdpUxvq/9CvWf8o/YqWpbge+uVq/w61CyrT6EN9hk5ca5gOssEXIb+A0bHWqurmeL
1vQp4465uFOZY2JU1oNUZN+YIZyS7z+QVgoxHg06Ew==
=DkOW
-----END PGP SIGNATURE-----

--------------d6FaGztmFPOD8TgZbFLVI9sO--

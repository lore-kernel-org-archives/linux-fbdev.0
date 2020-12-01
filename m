Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB3C64E8A
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7242087D
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 08:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgLAIDQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:03:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLAIDQ (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Dec 2020 03:03:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B06C5AC2F;
        Tue,  1 Dec 2020 08:02:33 +0000 (UTC)
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     daniel.vetter@ffwll.ch, sam@ravnborg.org, geert+renesas@glider.be,
        bernie@plugable.com, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201130125200.10416-1-tzimmermann@suse.de>
 <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] fbdev: Remove udlfb driver
Message-ID: <336a41ef-1e49-6799-1bfd-06fb42419fb8@suse.de>
Date:   Tue, 1 Dec 2020 09:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jETQjiqHPQ4ssdDqzOpb6mlFH3OMj7CrU"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jETQjiqHPQ4ssdDqzOpb6mlFH3OMj7CrU
Content-Type: multipart/mixed; boundary="MZI83QV9cxoq5fqjHDyDJ9hsnk2pJTnp6";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: daniel.vetter@ffwll.ch, sam@ravnborg.org, geert+renesas@glider.be,
 bernie@plugable.com, corbet@lwn.net, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org
Message-ID: <336a41ef-1e49-6799-1bfd-06fb42419fb8@suse.de>
Subject: Re: [PATCH] fbdev: Remove udlfb driver
References: <20201130125200.10416-1-tzimmermann@suse.de>
 <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>

--MZI83QV9cxoq5fqjHDyDJ9hsnk2pJTnp6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 30.11.20 um 15:31 schrieb Mikulas Patocka:
>=20
>=20
> On Mon, 30 Nov 2020, Thomas Zimmermann wrote:
>=20
>> Udlfb has been superseded by DRM's udl. The DRM driver is better by
>> any means and actively maintained. Remove udlfb.
>=20
> Hi
>=20
> I am using udlfb and it's definitely better than the DRM driver. The DR=
M
> driver will crash the kernel if you unplug the device while Xorg is
> running. The framebuffer driver doesn't crash in this case. (I have a c=
at
> and the cat sometimes unplugs cables and I don't want to reboot the sys=
tem
> because of it :-)

What's the exact STR here? Just open the /dev/fb* and pull the cable.

Do I need a cat? :)

> The framebuffer driver is faster, it keeps back buffer and updates only=

> data that differ between the front and back buffer. The DRM driver does=
n't
> have such optimization, it will update everything in a given rectangle =
-
> this increases USB traffic and makes video playback more jerky.

That's not quite true, but not false either. I think we could optimize=20
what we have.

>=20
> The framebuffer driver supports programs running full-screen directly o=
n
> the framebuffer console, such as web browser "links -g", image viewer
> "fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl",
> movie player "mplayer -vo fbdev". The DRM driver doesn't run them.

I would expect that most programs have an SDL2 backend. (?) IIRC SDL2=20
has support for DRI interfaces.

>=20
> If you seach for someone to maintain the framebuffer driver, I can do i=
t.

I'm looking for reasons why udlfb is still around. What I got from this=20
thread is the possible crash and a lack of DRM's fbdev performance.=20
Thanks for the feedback.

Best regards
Thomas

>=20
> Mikulas
>=20
>=20
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   CREDITS                      |    5 +
>>   Documentation/fb/index.rst   |    1 -
>>   Documentation/fb/udlfb.rst   |  162 ---
>>   MAINTAINERS                  |    9 -
>>   drivers/video/fbdev/Kconfig  |   17 +-
>>   drivers/video/fbdev/Makefile |    1 -
>>   drivers/video/fbdev/udlfb.c  | 1994 --------------------------------=
--
>>   7 files changed, 6 insertions(+), 2183 deletions(-)
>>   delete mode 100644 Documentation/fb/udlfb.rst
>>   delete mode 100644 drivers/video/fbdev/udlfb.c
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--MZI83QV9cxoq5fqjHDyDJ9hsnk2pJTnp6--

--jETQjiqHPQ4ssdDqzOpb6mlFH3OMj7CrU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/F+JgFAwAAAAAACgkQlh/E3EQov+BM
LQ//Vg6mZxBQkKGfk81NgT+i4Xu2RchOn+gnnNMFhpIvLKmvbOtIntaqSJu0Iqy7xWTqarZW3Qrr
pzGxGfnBvIb6YcrEXLY+pwnJsVHy8sTSMYjX2sFCcBjsur9IT1mXyNOUyI6KY/4RvdSSFXZkiBBX
HWUuFwCqfdKh314jzLKMO/yy7THc0SwX5JUGzm7KSqg+wZjelDMUu1ztO5QfQ5HpoSxgHX93MkNI
LarMTG53CD3F7fV8pJpDWit2LOxhGOwHHUCNOPGyKMpO5Fr1p1grrqc9D6w/IDdyyLonaRNCJoHt
BZc/aKRUIJ17yJsBU1N63Tm9Qwcps8lT3OmOw9qXCzVZf/AQSj3nKpV6iMVlErHtRc8n5CaTmUB9
2uulKUxYyaGS9mOpNJhF4g6CdmJc0DrUIaIRtdr9cdspC0oufYtAdSnDQhB5mVD+dGZSvHjMurNA
Fiy9KnWAWiJWT2vHgVv8YE1JRGrt4DxTtL9TjWhxKcS6WCHzPBKW26p86jrPamw91ub/PsK3/Xzs
juQAmNdYZpwg/1r1dwmWztORHgiqyl+SHjAo4s9RBT7dCCz2N9pb4EGIj0XNjYTeyifYyhrHMIxc
rxkEotDoYh28s8MvB2zaEgY5QEDguGNt1kZkImsy2WCQCRG68rc42SUkzSpj7dBX68287w2gQfrQ
kKo=
=42KM
-----END PGP SIGNATURE-----

--jETQjiqHPQ4ssdDqzOpb6mlFH3OMj7CrU--

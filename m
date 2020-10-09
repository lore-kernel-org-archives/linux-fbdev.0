From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 09 Oct 2020 11:59:24 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JURA3xtcP0EYmRfuLZ0TwQyRNkOJdomBF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
In-Reply-To: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JURA3xtcP0EYmRfuLZ0TwQyRNkOJdomBF
Content-Type: multipart/mixed; boundary="r4Zq18ekkqdRrrSmLiYBaFEdMmZyzJwyK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org,
 Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
Subject: Re: drmfb console switching problems/questions
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
In-Reply-To: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>

--r4Zq18ekkqdRrrSmLiYBaFEdMmZyzJwyK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 09.10.20 um 12:50 schrieb stsp:
> Hi!
>=20
> I am trying to run my sdl1-based app
> under linux kms framebuffer (amdgpudrmfb
> in my case).
> The app itself works perfectly, but
> console switching is not.
>=20
> If I switch the console while the app
> is drawing, then it will corrupt the
> VC I switched to. It will just draw on
> top of the VC's content.
> Question: is this expected? Is drm
> framebuffer global, rather than per-vc?
> If so, should I somehow freeze my
> app when it is switched away? And
> why would it be the case, with the
> modern video cards that have multi
> gigas of RAM on board?
>=20
> If my app crashes without a clean
> shutdown, then the framebuffer kinda
> hangs. I can switch to other VCs but
> I don't see their content. All I see is
> the last drawing of my app. If I happen
> to have an X server on some other VC,
> then switching to it immediately unhangs
> everything, and I can switch back.
> In fact, even if I hit Ctrl-Alt-Del, then
> fb immediately unhangs (by systemd
> or plymouth or whoever else). But for
> example SAK combo doesn't unhang.
> So it seems to be very simple to hang
> the framebuffer, and is quite difficult
> to recover.
> Question: is this an expected behaviour
> or a drmfb bug?

Fbdev exposes the video ram (or a shadow buffer of it) to all
applications. Only one can draw at the same time. It's a limitation of
the design. To fix this, your application has to stop drawing when you
switch consoles.

Best regards
Thomas

>=20
> Thanks!
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--r4Zq18ekkqdRrrSmLiYBaFEdMmZyzJwyK--

--JURA3xtcP0EYmRfuLZ0TwQyRNkOJdomBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl+AUJ0UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPbdQf/QDlWQY6YM/uMGqvFJmh1L9lEv5OS
f75bd6w4iwMFgYyOdC3isCRrEZOO4vymqpInN3sUTFymOKXx5V+ng4+rHEAltCnk
KFJine41W84o+aRfIxeA+IQa44BXfrh8H3zlRnyonjifwZ3ujEQOfi3vJ7nNIovy
AMXrScHSAIxPFavpKnEB1erE90ij67ufoIgv0ifVTBQPTBrujgpD1kuH5moGg38w
mFXyEjshh8n8WwUmnB3VeEWZV1NHGVvMiXvnMhQIW7WutdPYEprIG/5BuC0HJNTK
fKo8zRrEuLR8hdufxCKQUzsB1HGYsgUCAoMqIeQNSenpRuc47J4C5Q6lEA==
=pZ/y
-----END PGP SIGNATURE-----

--JURA3xtcP0EYmRfuLZ0TwQyRNkOJdomBF--

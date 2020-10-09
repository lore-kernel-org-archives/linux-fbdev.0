From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 09 Oct 2020 12:58:59 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M5HWfsROMBtVeEnVUOr9Di9KQ5NWpqinj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
In-Reply-To: <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M5HWfsROMBtVeEnVUOr9Di9KQ5NWpqinj
Content-Type: multipart/mixed; boundary="D2o1fIkniFuo7qM01ZekkWlhSq1xQYKyK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org,
 Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
Subject: Re: drmfb console switching problems/questions
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
In-Reply-To: <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>

--D2o1fIkniFuo7qM01ZekkWlhSq1xQYKyK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 09.10.20 um 14:16 schrieb stsp:
> 09.10.2020 14:59, Thomas Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Fbdev exposes the video ram (or a shadow buffer of it) to all
>> applications. Only one can draw at the same time. It's a limitation of=

>> the design. To fix this, your application has to stop drawing when you=

>> switch consoles.
> OK, thanks for info.
> Quite a sad news, if you ask me.
> Is there any ongoing work at solving that?

I don't think so. Both, SDL1 and fbdev, are pretty much dead these days.
The solution to fbdev is DRM, which does not have these problems.

You could your application under X11 to use SDL's X backend. X would do
all the VC handling then. For SDL advice you should ask on the SDL
mailing list.

>=20
> Anyway, the fact that fb can
> permanently hang, is, I suppose,
> another problem - the one that
> can't be worked around in an app.
> I suspect it is the result of sdl doing
> ioctl(console_fd, KDSETMODE, KD_GRAPHICS);
> After which, I think, redrawing on a
> VC switch became disabled.
> Would it make sense to improve SAK
> to unfreeze from that? Otherwise its
> too easy to hang the screen permanently,
> and no way to recover.

That 'hung-up' problem you described sounds like the fbdev console does
not correctly redraw itself. But I don't know where the related code is
located.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--D2o1fIkniFuo7qM01ZekkWlhSq1xQYKyK--

--M5HWfsROMBtVeEnVUOr9Di9KQ5NWpqinj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl+AXpMUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNWdAf/Y5A3n2fl8B4PiBhTsI2gOaA4SHmk
ld8C+gKmkAdTLXSDXXqvIuGFLYow4Q4wDpJI1VMsj2d5fWWcfSBGv/QOMFnsduBt
rDVRFn8XTiFmAErCrhbUC1wlGQRLThWzmPft8vKUVtWm2EyP/nL6fF8qT9V13vm0
yhVqSqH7zrI0T7bDOUkPNsHeDvKp/aHrRmi2cU1paYTWuY95S8vUNU3J52kdcpLy
76rFzTBOIgB0vBtyMnVa/L3s+99D/xPHJbUe7NzjIwDSBOsXMgYYc+qRSLCaB0TS
zQwGXUAzxX/s2Q8akUsAw9vyR/BxIageZWpQ+oVLZFhHnssEFi2iaWelLQ==
=7cbK
-----END PGP SIGNATURE-----

--M5HWfsROMBtVeEnVUOr9Di9KQ5NWpqinj--

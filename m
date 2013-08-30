From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 10:52:03 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52207953.309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1GruPtrs6nq4e0triuhR6Lldws6FWEWJt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
To: linux-fbdev@vger.kernel.org

--1GruPtrs6nq4e0triuhR6Lldws6FWEWJt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/08/13 13:41, Chen Gang wrote:
> On 08/30/2013 06:19 PM, Tomi Valkeinen wrote:

>> Here's some old discussion about BUG:
>>
>> http://yarchive.net/comp/linux/BUG.html
>>
>=20
> Yeah, if it is not a real bug (can handle it), we should not use BUG(),=

> but when we are sure it is a kernel bug, and the kernel will continue
> blindly, we need use BUG() to stop it.
>=20
> Just like the Linus Torvalds said in the link which you provide:
>=20
> "Rule of thumb: BUG() is only good for something that never happens and=

> that we really have no other option for (ie state is so corrupt that
> continuing is deadly)".

I guess this is where we disagree. I don't see having a corrupt bpp
value in a fb driver's internal function as "so corrupt that continuing
is deadly".

Anyway, if you insist on the BUG(), I'll leave this patch to
Jean-Christophe. I'm only taking small-ish patches that have no open
issues or disagreements.

 Tomi



--1GruPtrs6nq4e0triuhR6Lldws6FWEWJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIHlTAAoJEPo9qoy8lh718R4P/Rz2bZ1x3NwvQKAlKOHsXrQO
/Mb1NW9utErrWeS90gk+k0i2FpRRjghTjdZaTPOiiegi/+ya79/8zYZJ1OHAFhmc
fQZRc9gYeIRK20rH5jymiV2oh0WjTZK4frUJs22eVc9saVCxQ2s++1PYica9pllx
dnv0FEJI4PditFrztiJN9QbzhLqy6o6queN+W+crqwL+0+rZyOYCPZFDxtTKmu7z
Ryf1y4xgzdAY3R1wt4V1Mqll0cboGknHzxIUSjD+Ao2cxu4hhkYDmhE6Rzd2zK+W
G9DwCZeSwAtbggeg0Rbq9bjy+f7mxIlw6WRb2Uv6o+DiMvDs/1ebcQCpvr1vVyJu
3dpJYTDpAXiegjj/1Ur/H5QiRalFrCSivw/OEJWlyCizk1+CHSDry/DhMUNkSYYs
k2GFRDyHWyV28eDgiKSx4VLVdAJiYSQNk6qW0+p5vnYmqwd5/D0DjrdHKWAwX84r
hxAoWHpM5CAWhFCviL3c8Nknpw4iTFeTJxcB0NAWnj21jRpBA48xCiKvVnRy53rP
5fv+fsz+F5wqxzEywh6A/uIs20oI+G9FHtB05cfAMxntzA2LcOa1/ZwGD6L4/C8l
2g6umVKzF5oas0Yo7c2n/3p9VfW0UqlW8VOgFfdKhNyU+Z58Lyp9dldBLVVHKDit
QE3ULoYbIH2L6p9Se9KV
=EKa1
-----END PGP SIGNATURE-----

--1GruPtrs6nq4e0triuhR6Lldws6FWEWJt--

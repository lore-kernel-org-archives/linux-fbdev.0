From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 09:53:18 +0000
Subject: Re: [PATCH] video/ps3fb: Fix section mismatch warning
Message-Id: <5236D50E.7090602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C4J41Xnaqmrh4POdqHt5wqIQ2D0iB7rXB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369141302.3652.14.camel@clam>
In-Reply-To: <1369141302.3652.14.camel@clam>
To: linux-fbdev@vger.kernel.org

--C4J41Xnaqmrh4POdqHt5wqIQ2D0iB7rXB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/09/13 12:28, Geert Uytterhoeven wrote:
> On Mon, Sep 16, 2013 at 11:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> On 21/05/13 16:01, Geoff Levand wrote:
>>> Remove the __initdata attribute from the ps3fb_fix variable.  This is=
 in
>>> follow up to the removal of the __devinit attribute on the ps3fb_prob=
e()
>>> routine in commit 48c68c4f1b542444f175a9e136febcecf3e704d8 (Drivers:
>>> video: remove __dev* attributes).
>>>
>>> Fixes build warnings like these:
>>>
>>>   WARNING: vmlinux.o Section mismatch in reference from the function =
=2Eps3fb_probe() to the variable .init.data:ps3fb_fix
>>>   The function .ps3fb_probe() references the variable __initdata ps3f=
b_fix.
>>>   This is often because .ps3fb_probe lacks a __initdata annotation or=
 the annotation of ps3fb_fix is wrong.
>>>
>>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>>
>> Thanks, applied for 3.13.
>=20
> Too late. It already got in last week through Cell and PS3 supporter Be=
nH ;-)

Ok, thanks for informing. Maybe I'll be faster next time, shouldn't be
difficult to achieve ;).

 Tomi



--C4J41Xnaqmrh4POdqHt5wqIQ2D0iB7rXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNtUOAAoJEPo9qoy8lh71PvMP+wbI5sq7aj41qi+Gtn3hFrYd
EHWqrxvZgZasTmHrVLO0Mt7MfFzX7/xK7SPT4+OWddl/XsanH60+5geAhU+NFZkB
RVvtWqGCw/zx5hbroZ4velhDhsuSHqYI+L9z0vvWeXVt9b2T/dgF6oHjZps4Sw0V
x32xsU8QSsRkMk38v09kr3b0tpTYcBG1DpvMZnCXBdze1bejHQOz6m43m62bv1sa
4tGmnTFQA6oq4+zdOoZx1OresyeC0lOSxvGvmVak/YrB+z/ySElE76zJ9sxbcYsy
0hr7bR+5tHpj691B1b74uTD/e1JpIS+tkpvPAODjpKZxaLcnjtQ5IhAISxAvD20N
tPR6C28E3WJN2oEnECmBL0yGvAq/oOOIUn+9Xjmz2ZjDvxXghPuvI7JG5zW2od2I
gxFDqxt7iUflRKxVgLXAQ6UX76d5gs1A6Q0ldSZ43sdrJW9bzf9UFAqz3Zf7LPI7
aExhpXOpqslMKBBti4zEG/4aJeSJZIcCeHfog9djR0gB+00JPenpL4ikShaxLNzq
Y+Kaq7hw6+2jIBNyDZP4rSM0IF81TG0DgKdLxjdqTYS96e2VKJ45BNFPG4gdHgEQ
USwhH18JJDftegFETEYlquEcNEBKmABAuDatLYQZN9frwhoVDvo0z2ndnjw539nw
bJ9QhVT98NglspWCILNI
=qqdK
-----END PGP SIGNATURE-----

--C4J41Xnaqmrh4POdqHt5wqIQ2D0iB7rXB--

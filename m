From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Feb 2016 11:35:56 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CD959C.9050007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1jk1tWFO7HDKwK3C8w4nKVOGQ23cfcSwH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com> <20160224105304.GM19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160224105304.GM19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--1jk1tWFO7HDKwK3C8w4nKVOGQ23cfcSwH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/02/16 12:53, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 03:38:12PM +0200, Tomi Valkeinen wrote:
>> Ok. I feel everyone is trying to push the ugly part out of their domai=
n.
>> I want the board specific hacks out of fbdev. Bootloader people don't
>> want it there. arch/arm/ people don't want it there. =3D)
>=20
> I think that is really really unfair.  No one is trying to push ugly
> bits out of their domain - this is being driven by Linus, who is
> trying to convert Versatile to DT.  There is no other agenda here.
>=20
> Remember, I was the one who wrote the CLCD driver, and it was written
> to support the boards at the time using the best methods at the time.
> Things change, people's ideas of what's acceptable change.  What was
> acceptable when classes of boards were separate is no longer acceptable=

> with single zImage.

That's fine. I've done the same. The point here is where should we aim
for with today's kernel? What's the good solution for the future boards?

> The board specific parts of CLCD were in arch/arm for a very long time,=

> but that gets in the way of single zImage, and the solution adopted by
> the newly interested parties has been to move them to drivers/video
> to keep things working.

And I'm fine with having board specific parts in drivers/video when
needed. That's the only option when we really need a driver for the
board specific parts, i.e. we need to do something with the board
specific HW at runtime.

But that's not really the case with Versatile. Correct me if I'm wrong,
but there's just one panel connected to the board at a time and the
panel cannot be changed at runtime. We need to do the board specific
panel probing once at boot time, but other than that, there's no
difference to a single on-board panel.

To me it sounds that the cleanest solution to this is that the
bootloader does the detection (it's a trivial detection, isn't it? no
complex busses need to be used?), and just passes the kernel the correct
HW setup with DT.

Again, I understand there are lots of board out there without bootloader
doing that, so we may not get there with Versatile. But if someone comes
with patches for a new board, I'd like to have a good suggestion how to
handle similar cases the best way.

> That's how we're here: there isn't a conspiracy as you seem to be
> thinking.

I wasn't exactly serious there, as the smiley tried to imply...

 Tomi


--1jk1tWFO7HDKwK3C8w4nKVOGQ23cfcSwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzZWdAAoJEPo9qoy8lh71VmwP/j2Ws4dpKBfsSBwH5HCZ11yV
OvZ40mloC/vdU5fLsmsmd/6Gq8MKRXDfPUwf/pPQ4jS7MPjVsgT1VBAnPucEA7IM
VvmL7d79XRaKG5+i3LyUmG+NZqWRiGCnHhpcCYkl7uo7sTiIFfP0WW2qbYpfre67
YA2dtOSu92hs8HP1p56RHU8a+3O2FRKgRzsm17QyemeydkBqIMyCI5sgubBKZskJ
L/nIAfI3msm8lMijPnU2lGfikUA2YEKIG5W3ZUF6kuT1eCNJbCxzgBCsKV8pwIqz
rc3glQKq0t1VnVOWmujYP6Q2iSbhyyJjCewhzbrv/lNfbZTRLyDHzWRvVz/xLnx9
U0EYZiz/Dx394u2hkwszOs4kppvUWEDJ4FtP27gVvPu70LaC/g5GHdgM+Wz/8pQD
MS3T2VrefyNixogC5pUW0wmiIeA3qDdyldNuT20yEuLmOk0esr+fGjWVWFzaKUcw
kXpLHRNBK1/341aaFZGUP5gO3jolhdomiJxu6j0NXZmVm/f/vYbY4KH0dRg9hi2K
iZMxhrVAxlomw5Y4bENyWA8xQY9GRiLjBT7fjiyb48ybiMR/E20N4OlC+A038wXh
mhnXeKyGG2/iECMJAYtUWg9EUMkzgajQ26DAdMpTgx2hAGern+3eI0Vvc9iaNKko
tZn6eVYXVurrPpkedJp1
=2rq0
-----END PGP SIGNATURE-----

--1jk1tWFO7HDKwK3C8w4nKVOGQ23cfcSwH--

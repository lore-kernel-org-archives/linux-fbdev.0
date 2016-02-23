From: Tom Rini <trini@konsulko.com>
Date: Tue, 23 Feb 2016 13:45:20 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160223134520.GJ23166@bill-the-cat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3fX2G+AJpfl5sqva"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <20160223120101.GJ19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160223120101.GJ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org


--3fX2G+AJpfl5sqva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 12:01:01PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 11:56:34AM +0000, Peter Maydell wrote:
> > On 23 February 2016 at 09:58, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > > I'm not quite sure how it works if, as in versatile display case, the=
re
> > > are multiple DT overlays of which one has to be enabled. I hope there=
's
> > > support to choose which one to use via kernel cmdline or similar.
> > >
> > > I would personally like it much more if the bootloader would either
> > > compose a final dtb from DT fragments and pass it to the kernel, or
> > > alternatively the bootloader would pass the base dtb image and a bunch
> > > of DT overlays to the kernel, and the kernel would deal with the DT
> > > overlays.
> >=20
> > Speaking as somebody who's written the "bootloader" code that's
> > used for what I guess are the majority of versatile kernel boots,
> > i.e. the one in QEMU, I think that requiring the bootloader to do this
> > would be a significant worsening from the current state.
> >=20
> > Right now the bootloader doesn't need to do much at all with device
> > trees, except pass the kernel the DT that the user gave us, which
> > is just the kernel's own data structures in a separate file for
> > convenience. You need to do some very minor tweaks to the /chosen
> > node, but these can be handled the same way for any board and aren't
> > hardware specific. There's no need to worry about dt fragments
> > either for the bootloader or for the user. Imposing a new requirement
> > for the bootloader to have to probe hardware which it otherwise
> > has no need to even care about, and then edit and update the DT
> > in a board-specific manner, or have board-specific DT fragments,
> > seems like a totally unnecessary imposition on both bootloader
> > authors and end-users, and of course it would break booting newer
> > kernels on the great mass of already existing boot loaders and
> > QEMU installs.
> >=20
> > The kernel is in a position to probe the display hardware and determine
> > what is there, and do the right thing, and that's exactly what it
> > does today. The kernel should continue to do this.
> > The advantage of DT is that it allows moving information about
> > non-probeable hardware that was previously hardwired in the kernel
> > C sources into a separate data structure, but the versatile displays
> > are not non-probeable. I can see no benefit at all from hardwiring into
> > the dt something which the kernel has previously been successfully
> > dynamically getting right without any bootloader intervention -- it just
> > makes the kernel less flexible and less user-friendly.
>=20
> +1.

+1 from me too.

--=20
Tom

--3fX2G+AJpfl5sqva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJWzGJvAAoJEIf59jXTHXZSiNAQAKkAVpu1C0rkFIdWaC+bAK7N
6Tyyko/fDXJHmMAekl7bNNWtBoJ8PyIbBmRgCWlz2FI/NyF3USBWS/O66j7gG7me
JMO8JRM4CUZKsg9hNaORqkkuk5hQ7mDm/sbILEq79U+/17Mx8qluoSiaTQSlkdzG
+7qZ0QpZLVbEsBXimPvCA6wNyzHtpw5eyk/zpJ00ip8n4YK1rriLhmLcPVjbtFxd
2o7G20g8QRwmqeDRM/H3UuZ4Od3ZfFedX4v9ru5vW5e1hickZCsmpL/FG7xg2fOh
YIyMUKDewOEAtFVudmGBujJyIk6QBFPwcDRlkWtGdke0LT0T58tNkF6m4r1jO1Je
5H8MK/KNBCZStPsoyoZ76p3jDdUJ7C6hafJ9mQWM9l1V8ZwaaFGH1RaFza55JOlo
ffHc4f71HGw5yP2EN4fg0Mk3/wLmVE+fKg99WG0vdU/HbEuNmDGszcNpTUE3ydiH
5OlD/u8/uxfLFXkza4fKdK9IBE/1S3Lxi4ZZiilknLJ+wOwSzG8+ErP9gVNpyrpY
z0/r67wKzWMAN+19gjPbhvye1MB2JTolBVvS/Lgvl51h6LVo212LEIswvwcNS6QJ
FZqThtaI/Fia7ksNOj0ZXi2NGSPUronbJ7RRqLBG/iVq9iSIT6dfxHJveZ/OGTy3
aJQeFcz/1sD5snL6Uwn7
=N7bG
-----END PGP SIGNATURE-----

--3fX2G+AJpfl5sqva--

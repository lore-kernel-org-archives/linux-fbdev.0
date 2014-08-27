From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 10:32:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827103250.GT15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1vbNym9KGxCl/IZ3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <20140827085538.GS15297@lukather>
 <CAMuHMdURvJaM7qge+Po5e=F45k9-NeHsTiQykCjCmwr6_ud08A@mail.gmail.com>
In-Reply-To: <CAMuHMdURvJaM7qge+Po5e=F45k9-NeHsTiQykCjCmwr6_ud08A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--1vbNym9KGxCl/IZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 11:05:29AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 27, 2014 at 10:55 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> >> >> Is simplefb something that should be in the device tree distinctly =
in
> >> >> the first place - shouldn't it be a subset of the functionality of =
the
> >> >> video nodes?  It's the same hardware being driven differently.
> >> >
> >> > Therorically, yes, but that would mean knowing beforehand what the
> >> > final binding will look like, even before submitting the driver. Sin=
ce
> >> > the bindings are always reviewed, and most of the time changed
> >> > slightly, that wouldn't work very well with the DT as a stable ABI
> >> > policy I guess.
> >>
> >> If you don't know how the bindings for a device will look like at the =
time of
> >> writing your DTS, you're always screwed, whether you add a simpefb
> >> node or not.
> >>
> >> If you know how the bindings look like, just add the device, with an e=
xtra
> >> "linux,simplefb" compatibility value.
> >> If you don't know how the bindings look like, do your utter best in
> >> guessing. Your DTS must be amended later anyway, either because
> >> you guessed wrong[*] (in case you added a node to have simplefb
> >> working), or because you have to add a real device node (in case you
> >> didn't add one for simplefb).
> >
> > Let's be conservative and consider the case where we would guess
> > wrong.
> >
> > If we just rely on a simplefb node, when reviewing and integrating the
> > "new" bindings to describe accureately the various IPs involved in the
> > display path, we would obviously create new compatibles for
> > them. Since it's new compatibles, we can come up with any binding we'd
> > like, without have to consider the backward compatibility, since it's
> > a new binding.
> >
> > Then, we just remove the simplefb, all is good.
>=20
> I would keep the simplefb compatible value. Else you break compatibility
> with old kernels that don't have your new driver.

Yes, true. Since the simplefb will be injected by u-boot, it will be
there anyway.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1vbNym9KGxCl/IZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/bPSAAoJEBx+YmzsjxAg9sUQAIlAF1CkJohNdnwKiKl+C0Ap
mLeSSBMteG8orWjtGmReky3JlTFqmCNFt5WB9sqwUl3TN76bJRUka08G+faq1JNg
sJ1e/pidXDrOpw4616t0SPNbAfTJg8LmZdpUlfIdy7h5WcNHDmz+0/abBNfVt1iz
cCAshixCvyhu+ddV2GApKoPAQK7ImkXyoCYf1y/kv68GKSVsietsIUVxwK+InNeG
0GoY2k5SI8jrHDUypWExxlqq5BBJ3XDsI6gpXSuw+9WoNra1MgZEeqfY93oDO9YZ
AJsu1DCabW5xADqX/AEjHwpnAZOuVYYqmWtHWDa7b6suzqB4YZ1P8AJL4stYJ9Bs
3oi+iRFS+9HO80mlTkJves2wjPWg+iSg3rkI+ZrUw1KXb8yw/+K+SwVLUDIFF2rd
G50HFtk80uLIlW2cGSlGsCpLf9EP66Yovy+JNDjS3+DejBBYHW8Ak/LUkoeOCuwW
G+PgO++dHXxVJjP/J4uPOiK4OUG3jtgMGK/b/+D9ufMuVw+lt6msG9DyjP3XIOrj
8fQ2lZLrNa9SFACl9n1fFkli4SEE/lyn0jH/yEpxnXJnSLb7ZOHJY9vC44n/2wWu
a+B47AGXacPOzEHKvFj0dl5pTCAs0Slok9nrNzkAN15IL98WZpOCxliK7Glm2HTU
GC19zYC93ZGb7rfUv4Dk
=NkmR
-----END PGP SIGNATURE-----

--1vbNym9KGxCl/IZ3--

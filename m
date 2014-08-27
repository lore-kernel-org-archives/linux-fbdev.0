From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 10:07:47 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827100744.GD23186@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="u65IjBhB3TIa72Vp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <20140827085538.GS15297@lukather>
In-Reply-To: <20140827085538.GS15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 10:55:38AM +0200, Maxime Ripard wrote:
> Hi!
>=20
> On Wed, Aug 27, 2014 at 10:37:36AM +0200, Geert Uytterhoeven wrote:
> > Hi Maxime,
> >=20
> > On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> > >> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=C3=B6m wrot=
e:
> > >>
> > >> > It is not clear to me where the hardware resources should be liste=
d in
> > >> > DT, being it a simplefb node or part of the actual hardware device=
 node
> > >> > properly marked as dynamic boot defaults or something else? It's
> > >> > somewhere inbetween hardware and virtual device, and somewhat vola=
tile.
> > >> > As far as simplefb is concerned it is a hardware desription of the
> > >> > framebuffer, but for a kms driver it's no more than firmware hando=
ver of
> > >> > boottime settings and ceases to exists once the kms driver have
> > >> > reconfigured the hardware.
> > >>
> > >> Is simplefb something that should be in the device tree distinctly in
> > >> the first place - shouldn't it be a subset of the functionality of t=
he
> > >> video nodes?  It's the same hardware being driven differently.
> > >
> > > Therorically, yes, but that would mean knowing beforehand what the
> > > final binding will look like, even before submitting the driver. Since
> > > the bindings are always reviewed, and most of the time changed
> > > slightly, that wouldn't work very well with the DT as a stable ABI
> > > policy I guess.
> >=20
> > If you don't know how the bindings for a device will look like at the t=
ime of
> > writing your DTS, you're always screwed, whether you add a simpefb
> > node or not.
> >=20
> > If you know how the bindings look like, just add the device, with an ex=
tra
> > "linux,simplefb" compatibility value.
> > If you don't know how the bindings look like, do your utter best in
> > guessing. Your DTS must be amended later anyway, either because
> > you guessed wrong[*] (in case you added a node to have simplefb
> > working), or because you have to add a real device node (in case you
> > didn't add one for simplefb).
>=20
> Let's be conservative and consider the case where we would guess
> wrong.
>=20
> If we just rely on a simplefb node, when reviewing and integrating the
> "new" bindings to describe accureately the various IPs involved in the
> display path, we would obviously create new compatibles for
> them. Since it's new compatibles, we can come up with any binding we'd
> like, without have to consider the backward compatibility, since it's
> a new binding.
>=20
> Then, we just remove the simplefb, all is good.
>=20
> If we were to try to create our bindings for all the IPs involved, and
> were not pleased with the binding anymore when merging the driver,
> then we would have to break the bindings, since we don't introduce a
> new compatible anymore, but modifying an existing one.

It's usually a bad idea to merge a binding without an appropriate
implementation thereof in a driver. It's been done in the past and very
often has resulted in bindings that turned out unusable.

You could start out small and only describe the various individual IP
blocks that exist in the hardware with reg, interrupts, clock, etc.
properties, most of which should be known up front. Then you could try
to find out where simplefb fits best.

Thierry

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/a3wAAoJEN0jrNd/PrOhAUIQAIHiluDvXJ6BNr0lKPPJpdUW
YTCKvfttionca9QKWnx0UotS+0etcLtimr9Lzube5q9lYgBaub/sdZszJiZq19H1
tV8A//2mE0795tiuFRMQGEBt+9VNNuBHp8u7uiWwkx7NseF3phrWQ5VUFqGWMl7G
mGfgTpc1cgmLVHY4BGftYIOl3kC0w7+cJgNmwrsiA5QAHMVqwweU8Pjo4cZFyzYv
UtMIoF/ZEs9u0f4WU2TuyG8YkgWEJ4JK/jUFh8IEIOhl0JJJNecKnanVlU75drH+
92M6c+tr5Q+bXo5PGZqGhHSd9v0LS2ZQfICGxwdST/Tdi9ar6v3c6FpBgQ9a+ekm
jxcBJV/HS/g02CG94P/ZgXUFXGw5lzNSp3QHqtsgpzVMpfQXqwLa8RkbzkYEiS74
DWzEHKXVVcMHz7hkJZSr95Z03qpXco73WDCGwo89OPoFH4PqWjYfXz2ISOQR2rGQ
8l5+Q4sqysR7kvWBCM1HdUtpXmV/df2TEagAGoadj/55ObjE/awQKZ+fUXnJzvtx
G4vIb4oX3UJW5nAXx02Zzkq9hyi/WeXMAC7IWJyCc9Lhx3N2k1V5qOgnKVM4sIWG
z/QQtwcCmhg3btDMC+iEpLWHZMgr5HVELKRusWLtcWBiSY6UdZ/WeZNY0BEMCAwb
T6WDraW05+Kr6yCb2V4f
=2OWr
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

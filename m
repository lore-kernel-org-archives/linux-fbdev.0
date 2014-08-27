From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 13:24:59 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827132459.GU15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jY7L9IIxIW/y3gad"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <CAGRGNgWy=ijkakoKtXiEnFuVQpQT6WXW45-nL4x9DvfTKoA1OA@mail.gmail.com>
In-Reply-To: <CAGRGNgWy=ijkakoKtXiEnFuVQpQT6WXW45-nL4x9DvfTKoA1OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--jY7L9IIxIW/y3gad
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julian,

On Wed, Aug 27, 2014 at 10:45:14PM +1000, Julian Calaby wrote:
> Hi All,
>=20
> On Wed, Aug 27, 2014 at 6:37 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Maxime,
> >
> > On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> >>> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=F6m wrote:
> >>>
> >>> > It is not clear to me where the hardware resources should be listed=
 in
> >>> > DT, being it a simplefb node or part of the actual hardware device =
node
> >>> > properly marked as dynamic boot defaults or something else? It's
> >>> > somewhere inbetween hardware and virtual device, and somewhat volat=
ile.
> >>> > As far as simplefb is concerned it is a hardware desription of the
> >>> > framebuffer, but for a kms driver it's no more than firmware handov=
er of
> >>> > boottime settings and ceases to exists once the kms driver have
> >>> > reconfigured the hardware.
> >>>
> >>> Is simplefb something that should be in the device tree distinctly in
> >>> the first place - shouldn't it be a subset of the functionality of the
> >>> video nodes?  It's the same hardware being driven differently.
> >>
> >> Therorically, yes, but that would mean knowing beforehand what the
> >> final binding will look like, even before submitting the driver. Since
> >> the bindings are always reviewed, and most of the time changed
> >> slightly, that wouldn't work very well with the DT as a stable ABI
> >> policy I guess.
> >
> > If you don't know how the bindings for a device will look like at the t=
ime of
> > writing your DTS, you're always screwed, whether you add a simpefb
> > node or not.
> >
> > If you know how the bindings look like, just add the device, with an ex=
tra
> > "linux,simplefb" compatibility value.
> > If you don't know how the bindings look like, do your utter best in
> > guessing. Your DTS must be amended later anyway, either because
> > you guessed wrong[*] (in case you added a node to have simplefb
> > working), or because you have to add a real device node (in case you
> > didn't add one for simplefb).
> >
> > [*] Actually you may have guessed right, in which case it'll continue
> >     working as-is, and everybody will be happy.
> >     Whether you want to keep backwards-compatibility in your future dri=
ver
> >     with the "guessed wrong" node is up to you.
>=20
> I apologise if I'm stepping on anyone's toes or horribly
> misrepresenting device tree's capabilities, but couldn't we start out
> with something like:
>=20
> disp@whatever {
>     compatible =3D "sunxi,sun4i-disp";
>     clocks =3D <&stuff 1>, <&stuff 2>, <&stuff 3>;

Unfortunately, it's slightly more complicated than that, since there
is several clocks involved, that feed several different IPs that need
to stay on.

In this patch, and given the current code we have, we need to have the
gates for the HDMI controller, the LCD controller and the display
backend, which are three different IPs, with one clock each, that
would be described by three different nodes.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--jY7L9IIxIW/y3gad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/dwrAAoJEBx+YmzsjxAgj3MP/iqhdOEpbZivaLzN9rvBgQlL
T6JSTXwnXUfD2yDoafoXhykDZpQicSdOG8Cv9ZjiyYqUgg/jkg33k8MC9y1EDkEI
7LHWzYCRbnVDbn+CKVWaZkEUXoozobkBscpkGQqqTWOS8LsiNG/MVwBoIbnraGLR
aqAqQ9FrHIl0TrKqk1cXIDHPJrMOf4N7ukGeKK+0ck9cMauNydTIVw5jE578wkmf
9+mosg1lcdmkYfQfM1zeS7gUBoh+PY8VXncyrrPuLrrXFj4n+HvS7Sj3BzieUWOk
PlYvMdP1yZVGZKRn36U8x11l3Se0+rcfKybEH9tpKkG/SmerP/Rh/XrPJgA7GJSt
yI8daHAigrNgA1kDruibuUjx5Mpd6DZSR7kY+tDuTaGFaiTM0NqX/yl73rPGE/80
yV0NgRELW2534Zrnn80MlDemTJuqkq/6TKyD6OEougy0jN4W7ZTRiVc/U+ARxXwr
4pAxcyJ9Xp0bX9Xi3kbfLZ6V7dn1jN5xfqd7qHWXNQiIJYuyXUjVub+q/ZQ7GSHI
kJ0tLrNGPffhQi6cGnWDGZEASm4O7f09k7rSigcvZZM16PgkZxHWg/gp/0AhqFbz
ppYvUNxEZtwZS1CTX+SHHeYyeXdC2B9hZSfF8B8QETjsJ4r1aa23SXl/JkPvC1Iv
Qw1K34WZ3teRikpj5RP1
=3G86
-----END PGP SIGNATURE-----

--jY7L9IIxIW/y3gad--

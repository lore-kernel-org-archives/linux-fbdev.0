From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 25 Aug 2014 15:22:32 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825152232.GE15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1n5KrmHTzI9lYhsK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
In-Reply-To: <20140825150501.GE14763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--1n5KrmHTzI9lYhsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 04:58:54PM +0200, Maxime Ripard wrote:
> > On Mon, Aug 25, 2014 at 04:16:29PM +0200, Thierry Reding wrote:
> > > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> > > > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > > > > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> > > > >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > > > >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > > > >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > > > >>> [...]
> > > > >>>>> If not, perhaps the clock driver should force the clock to be
> > > > >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > > > >>>>
> > > > >>>> I'm sorry, but I'm not going to take any code that will do tha=
t in our
> > > > >>>> clock driver.
> > > > >>>>
> > > > >>>> I'm not going to have a huge list of ifdef depending on config=
uration
> > > > >>>> options to know which clock to enable, especially when clk_get=
 should
> > > > >>>> have the consumer device as an argument.
> > > > >>>
> > > > >>> Are you saying is that you want to solve a platform-specific pr=
oblem by
> > > > >>> pushing code into simple, generic drivers so that your platform=
 code can
> > > > >>> stay "clean"?
> > > > >>
> > > > >> Are you saying that this driver would become "dirty" with such a=
 patch?
> > > > >=20
> > > > > Yes. Others have said the same and even provided alternative solu=
tions
> > > > > on how to solve what's seemingly a platform-specific problem in a
> > > > > platform-specific way.
> > > >=20
> > > > This is not platform specific, any platform with a complete clock d=
river
> > > > will suffer from the same problem (the clock driver disabling uncla=
imed
> > > > ahb gates, and thus killing the video output) if it wants to use si=
mplefb
> > > > for early console support.
> > >=20
> > > It is platform specific in that your platform may require certain clo=
cks
> > > to remain on.
> >=20
> > The platform doesn't. simplefb does. simplefb is the obvious consumer
> > for these clocks, and given the current API and abstraction we have,
> > it should be the one claiming the clocks too.
>=20
> No. simplefb just wants to write to some memory that hardware has been
> set up to scan out. The platform requires that the clocks be on. Other
> platforms may not even allow turning off the clocks.

Like what? the rpi? Come on. Just because the videocore is some black
box we know nothing about doesn't mean we should use it as an example.

Any decent enough SoC, with a decent support in the kernel will have
clocks for this, and I really wonder how simplefb will behave once its
clocks will be turned off...

> > > The next platform may require power domains to remain on during boot
> > > and yet another one may rely on regulators to stay on during
> > > boot. By your argument simplefb will need to be taught to handle
> > > pretty much every type of resource that the kernel has.
> >=20
> > And I wouldn't find anything wrong with that. We're already doing so
> > for any generic driver in the kernel (AHCI, EHCI comes to my mind
> > first, there's probably a lot of others). Why wouldn't we do as such
> > for this one?
>=20
> Yes, and we've had similar discussions in those subsystems too.

Similar discussion, with different outcomes it seems.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1n5KrmHTzI9lYhsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+1S4AAoJEBx+YmzsjxAgJnMP/2FUK5CCRQV5j5nQ0ZScSmuy
lvGyUIMjuqluLqxCW47WzovTGOhNDTPYRqsrRQ1Dnwu9QDNznDDh+WE2+4sDp6qe
fckKmMYvA+KDf+CH3CnLHWnvikexi8h2VWNroiMxy/wnua+mbIwQBdx+f0ZjQZRo
b+IVOHVlab0tNDhTYobRQmKiPB55iP5N7gucS8nbWJSekuRIAzrYVXAcmVG33SAt
+VdNcNLRgWERNlerHvtt9TdMbkYbUKJB4NwY1juNmXHvRCW13qjf4bar7ANDwc3C
x7cKBSPcb64KwdyNLb8cTqNYRX7ZpnPkqQum4wnl01IUGHjoV8DQxTvn0P6f8vs2
XwO5z78Tfs8O+VEtJFBSubtJIn2D13pnxPu5pEr20Df8mMG8xnAFeHEIOC1/rIBN
bOazoflKol7P4WmBEfyzO7W8NXUaDzZgOUwFrFkyjDjruS8VqF3FfGuHdjx7h85j
yzAGltJnysyEeE8jBUWRisBbAyKz2grhzgicP7hBJdzDmGTMNFjhmM7OGTwRJor9
B8a96taRp+bGFqhCxNxGp5BNvXl2v/o3+GFr79Vw5YwDAA2l63kWmGwlKBVjPGSa
rvhhHkDS+CsUFp2etOXY6XA0dvjloACGvKLYOriWtQBJLNW+C21dIduq4vn0iZrx
f/E49wRSGdIVDCrPAUVQ
=2RL/
-----END PGP SIGNATURE-----

--1n5KrmHTzI9lYhsK--

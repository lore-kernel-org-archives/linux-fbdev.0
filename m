From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 10:48:57 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017104856.GA10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1381947912-11741-3-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
 <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com>
 <525FA4B0.8060504@ti.com>
 <20131017091614.GC2502@ulmo.nvidia.com>
 <525FB368.6020003@ti.com>
In-Reply-To: <525FB368.6020003-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 12:52:40PM +0300, Tomi Valkeinen wrote:
> On 17/10/13 12:16, Thierry Reding wrote:
> > On Thu, Oct 17, 2013 at 11:49:52AM +0300, Tomi Valkeinen wrote:
>=20
> >> Just my opinion, but yes, DT is that inflexible. DT bindings are like a
> >> syscall. Once they are there, you need to support them forever. That
> >> support can, of course, include some kind of DT data converters or suc=
h,
> >> that try to convert old bindings to new bindings at kernel boot.
> >=20
> > That's not entirely true. DT bindings are allowed to change, the only
> > restriction being that they don't break backwards compatibility. So if
>=20
> True, but afaik the same goes for syscalls. But yes, it's probably
> easier to add, say, new properties to DT bindings than adding new flags
> to a syscall.
>=20
> > Am I the only one refusing to accept that we can't provide even the most
> > basic functionality simply because we haven't been able to come up with
> > the ultimately "perfect" DT binding yet? By definition it's not very
> > likely that any binding will ever be perfect.
>=20
> With "perfect" I meant without any obvious features missing. I agree
> that DT bindings will never be perfect, but I at least would like them
> to be good enough to cover all the cases we know of.

As far as the simple panel device tree binding is concerned, it covers
all the cases I know of. I can't seriously be expected to do any better
than that. These panels are dumb. They only come with a power supply
that needs to be switched on and an additional GPIO to enable it once
powered up. All three panels just work with that set of properties. So
anything that doesn't can arguably be covered by some other, not-so-
simple binding.

> > I don't think we're doing ourselves any good by letting DT actively
> > hinder us in merging any of these features. I would personally prefer
> > having to support several bindings rather than not be able to provide
> > the functionality at all.
>=20
> I'd say the driver writer is of course free to create basic bindings for
> the device in question as long as the bindings are sane, and he agrees
> to later create any needed converters. I don't see any problem with
> having a driver supporting several versions of the bindings.
>=20
> But I don't think it's fair to push a driver with basic bindings,
> knowing that the bindings won't be enough in the future, and leave all
> the converter-mess to other people (not saying that's the case here).
>=20
> As a fbdev maintainer, I'm ok with adding DT bindings to device specific
> fb drivers, as those can be just left as they are. Even when CDF is
> merged, the specific fb drivers just work with the old bindings. If the
> driver maintainer wants to use CDF, it's up to him to create any needed
> binding-converters.
>=20
> But a generic driver for panels is more problematic, as that one should
> be maintained and refreshed to new features like CDF. If such was
> proposed to be merged to fbdev, I'd be very reluctant to merge it if
> there were any concerns about it.

I'm still missing the point here. For one, I don't see any reason that
this driver would ever need to gain CDF support. At the same time, CDF
could easily be supported by just adding a few required properties and
it should be easy to support any non-CDF cases just as well to remain
backwards-compatible.

> I guess one option there would be to implement a new driver for the same
> panel devices, one that supports CDF, and leave the old one as is. Not
> so nice option, though.

As I said, anything that really needs a CDF binding to work likely isn't
"simple" anymore, therefore a separate driver can easily be justified.

> > For crying out loud, we can use the 3D engine to render to a framebuffer
> > but we can't look at the result because we can't make the bloody panel
> > light up! Seriously!?
>=20
> Ah, but do you have DT bindings for the 3D engine yet, which represent
> how different internal blocks in the 3D engine are connected? If not,
> better start designing it! Then the problem is solved, you won't even
> have working 3D engine. ;)
>=20
> But seriously speaking, I'm with you. I don't get this DT stuff.
>=20
> And the funny thing is, DT should just represent the hardware, it
> doesn't matter what kind of SW drivers there are, so in a sense talking
> about DT problems with a SW framework like CDF is a bit silly. How hard
> can it be to describe the hardware properly?
>=20
> Very, obviously =3D).

Indeed. The fundamental point here seems to be that we don't represent
things in DT which we don't need. In the same way that we don't add
device nodes for enumerable devices, why would we need to explicitly add
information about connections between devices that cannot be controlled
anyway. If the board connects an RGB/LVDS output to a panel directly, it
is only required that the output knows what it is connected to because
there is no other way besides DT to obtain any information about the
panel. Therefore a unidirectional connection is more than enough. Using
that the output can access the panel and query it for information such
as the mode timings as well as switch it on or off as required.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX8CYAAoJEN0jrNd/PrOhvEEP/3a8D2hEBTpPn5Ekgvf7oDCc
fgHcKZbrRAYZ4Hrbnucw4/XTPhE6m4zvvRF479FLFIJn/iu/7BnT/DB/kZz5SbEu
7AtUhBevZU67lj2mE+x9URHBuvbvXjDg1Ah0M6Y3SkGrVnADsrMppQzS75Nxb9nU
U8f1tezAXUGnqNWNfTxuDclgXZqSuQ9b9Ivx7AwbZI3QRW7Mi/nlfnyHHd5pR+j5
5gUtOWYUacNVVXCDzxcGU9JaiMA22fnbBS/fuswl9M9levVr6mXGQ/E+kpFGJX4q
guXMc87dcAeinFEet8YiSdISFO0agPXRohgKZqEJx+u0PvxTO613TSCTvFRCqTu2
NmDzL4mGI06jJf+NBGPwf+xPIoiFC4QgeB/eETx+CnN4iFhhwmYOZIvnWjA0/H/3
kRpOTKJDmxkAjTa3oEY0HZuUvjh7C0QzqrzDeGXlRyPhaQ5C9rm1S2TgTm8miT0E
g2JStlhWsbxDjBzTlKz8LK27+q71TopgnnUoLpbl7jjuZC1lOxXfYRgdd0jNzYbK
jppmJ/S8fYxMxSh63fmXIFGiKqUUkswURnE6S0499zBFh8o7Jju3DN6L7Md1YHWT
StvzcA5/HlWgej/7Rp1YgSemhI8mMUW9QH3HAK5c7Iww6W6IG43VGTy32Otr4/j1
qtu5IvDvZYs9Skf2+rCV
=yNef
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

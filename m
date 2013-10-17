From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 09:16:15 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017091614.GC2502@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6zdv2QT/q3FMhpsV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1381947912-11741-3-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
 <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com>
 <525FA4B0.8060504@ti.com>
In-Reply-To: <525FA4B0.8060504-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 11:49:52AM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 17/10/13 11:28, Dave Airlie wrote:
> >>
> >> My biggest concern here is that this will not be compatible with the C=
DF DT
> >> bindings. They're not complete yet, but they will require connections =
between
> >> entities to be described in DT, in a way very similar (or actually ide=
ntical)
> >> to the V4L2 DT bindings, documented in
> >> Documentation/devicetree/bindings/media/video-interfaces.txt. Could yo=
u have a
> >> look at that ? Please ignore all optional properties beside remote-end=
point,
> >> as they're V4L2 specific.
> >>
> >> I also plan to specify video bus parameters in DT for CDF, but this ha=
sn't
> >> been finalized yet.
> >>
> >=20
> > While I understand this, I don't see why CDF can't enhance these
> > bindings if it has
> > requirements > than they have without disturbing the panel ones,
> >=20
> > is DT really that inflexible?
> >=20
> > It seems that have a simple description for basic panels like Thierry w=
ants
> > to support, that can be enhanced for the other cases in the future shou=
ld
> > suffice, I really don't like blocking stuff that makes things work on t=
he chance
> > of something that isn't upstream yet, its sets a bad precedent, its als=
o breaks
> > the perfect is the enemy of good rule
>=20
> Just my opinion, but yes, DT is that inflexible. DT bindings are like a
> syscall. Once they are there, you need to support them forever. That
> support can, of course, include some kind of DT data converters or such,
> that try to convert old bindings to new bindings at kernel boot.

That's not entirely true. DT bindings are allowed to change, the only
restriction being that they don't break backwards compatibility. So if
there's ever a need to support new functionality, be it in the form of
new nodes or properties to support something like CDF, that's not a
problem as long as the code continues to work with existing bindings.

> In practice even such converter may be enough, if some important piece
> of data in the new bindings is missing, and this data was implicit in a
> driver. In that case the conversion, or parts of it, must be done later,
> in that specific driver.
>=20
> Even that may be difficult, if the piece of data should actually be
> handled by some other driver. In that case there's probably need for
> some kind of global look-up table or such, so that the drivers can work
> around the problem of missing information.
>=20
> I've been working with DT bindings for OMAP display subsystem for
> something like 1.5 years. Still not merged, as they are not perfect, and
> I'm scared to push them in non-perfect form, as that could result in
> some kind of DT-binding-converter-hell described above.

Am I the only one refusing to accept that we can't provide even the most
basic functionality simply because we haven't been able to come up with
the ultimately "perfect" DT binding yet? By definition it's not very
likely that any binding will ever be perfect.

I don't think we're doing ourselves any good by letting DT actively
hinder us in merging any of these features. I would personally prefer
having to support several bindings rather than not be able to provide
the functionality at all.

For crying out loud, we can use the 3D engine to render to a framebuffer
but we can't look at the result because we can't make the bloody panel
light up! Seriously!?

Thierry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX6reAAoJEN0jrNd/PrOhyUEP+wUIhaqhSv5aVwhaV76AmKPN
wUkgGlXc33VNSqeMYl4LOcIMTP+CKpMElCiUyReEL5eEQN81MCt3y3Pg88kJuy01
sDmYGY92QcziR48LzndSzXdBGW5Z+r8EkZUzU8DnmJ7wYf+MfZUdmDvYcP+RWDHW
ABGZG72pPDo8MQlriy21+4BNTifX4Cg1aNt8tOi1XdlHSkRvBmVDnF+tooKJPj7w
V67AaqTWuVQzC/TImYUw/dapmKva8xpBY7z4XnbvmZfe1rQyBqu1Ww9ItnYejp2Q
UEKNm5AT1XQifV5YWb/0QUqPqgNtmvLKc59rD7BlqKY/7sH6HhXJsONk+TwAGoal
daSPJ78gdesO24wTKeVIsfF3GgA0YZoVcU1OQ6pWopMbsjh2dPPsoIWEJSS/rALO
foZVybheEIfCBxKFtKCL21IJSxRDckIb6CGm0dNB3L1bn8LkAY9aKo5UhR6WbWG5
l3VbksuJeVnE2Eed1Zk3WabDrLRfo9Hjoc3fdkpH41JTBG8XpDqeBxpW0Y/MB7eE
G5X4c4OziLIq8hKJD33IEsePL52GHUjXHT1h9a8WFiDct1aInQe8StZOuSNKy1Z3
smhaAd9gaymZYIG90ckNaPYKLyPwAhsISx1A+u52SQHTfmhJhgk2ClYgygHX1CCh
R0+ySQBAi+reHME/C319
=ZFhn
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--

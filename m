From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 09:52:40 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FB368.6020003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vSpEU07192KRa2oSUXF2rDnVJMbJ00EWW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1381947912-11741-3-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com> <525FA4B0.8060504@ti.com> <20131017091614.GC2502@ulmo.nvidia.com>
In-Reply-To: <20131017091614.GC2502-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--vSpEU07192KRa2oSUXF2rDnVJMbJ00EWW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 12:16, Thierry Reding wrote:
> On Thu, Oct 17, 2013 at 11:49:52AM +0300, Tomi Valkeinen wrote:

>> Just my opinion, but yes, DT is that inflexible. DT bindings are like =
a
>> syscall. Once they are there, you need to support them forever. That
>> support can, of course, include some kind of DT data converters or suc=
h,
>> that try to convert old bindings to new bindings at kernel boot.
>=20
> That's not entirely true. DT bindings are allowed to change, the only
> restriction being that they don't break backwards compatibility. So if

True, but afaik the same goes for syscalls. But yes, it's probably
easier to add, say, new properties to DT bindings than adding new flags
to a syscall.

> Am I the only one refusing to accept that we can't provide even the mos=
t
> basic functionality simply because we haven't been able to come up with=

> the ultimately "perfect" DT binding yet? By definition it's not very
> likely that any binding will ever be perfect.

With "perfect" I meant without any obvious features missing. I agree
that DT bindings will never be perfect, but I at least would like them
to be good enough to cover all the cases we know of.

> I don't think we're doing ourselves any good by letting DT actively
> hinder us in merging any of these features. I would personally prefer
> having to support several bindings rather than not be able to provide
> the functionality at all.

I'd say the driver writer is of course free to create basic bindings for
the device in question as long as the bindings are sane, and he agrees
to later create any needed converters. I don't see any problem with
having a driver supporting several versions of the bindings.

But I don't think it's fair to push a driver with basic bindings,
knowing that the bindings won't be enough in the future, and leave all
the converter-mess to other people (not saying that's the case here).

As a fbdev maintainer, I'm ok with adding DT bindings to device specific
fb drivers, as those can be just left as they are. Even when CDF is
merged, the specific fb drivers just work with the old bindings. If the
driver maintainer wants to use CDF, it's up to him to create any needed
binding-converters.

But a generic driver for panels is more problematic, as that one should
be maintained and refreshed to new features like CDF. If such was
proposed to be merged to fbdev, I'd be very reluctant to merge it if
there were any concerns about it.

I guess one option there would be to implement a new driver for the same
panel devices, one that supports CDF, and leave the old one as is. Not
so nice option, though.

> For crying out loud, we can use the 3D engine to render to a framebuffe=
r
> but we can't look at the result because we can't make the bloody panel
> light up! Seriously!?

Ah, but do you have DT bindings for the 3D engine yet, which represent
how different internal blocks in the 3D engine are connected? If not,
better start designing it! Then the problem is solved, you won't even
have working 3D engine. ;)

But seriously speaking, I'm with you. I don't get this DT stuff.

And the funny thing is, DT should just represent the hardware, it
doesn't matter what kind of SW drivers there are, so in a sense talking
about DT problems with a SW framework like CDF is a bit silly. How hard
can it be to describe the hardware properly?

Very, obviously =3D).

 Tomi



--vSpEU07192KRa2oSUXF2rDnVJMbJ00EWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX7NoAAoJEPo9qoy8lh71BT0QAKI8o/SQr2gXmN2KdqeJXi4F
ZLloNE36K9aScScFbNmbxgCiDe6oU1CEAK7obLb8+lGf9OER74Gz4FhpD60RxsIX
m4+4iynTvkqanUXUops/CTuXeGMXI+KqC1jmxOuCHWZmw75bHVWQWfMO76XUOgyl
ZWfIjLMiSJ78p7pW/sVkf6/oTjeYkwZD0XcPtV7PVwOuVETS+hBweo8TooWO6jwP
7Gj6oQjBhmFQxM94ug596lCXKifO7oPSPHOa2XfObRryywYnrZ/PgsqPKE7A56Sx
ZftpS+xu7MgyzAj2B5w3QYKHPM0/Yoy95KUW1kxTNECmxf0EGNDrTsc015B7XL+v
yW+ZZ6VF86TUVAJieHu2mctFrQodNNHxm6CxZ8XCtK8+BDqHRMP5T9w7hyYBoape
52o2P2cDsdNx5S/nbi7mE6WDETl/x5KdhBHtNGVeRfLRjK3WHOTrTCCTo76Ivh5E
Y52nHyrHaWdzzpWLhojP1ldP4SLOfpi1O/fqeM+FiD483RJ5RYw+MtG1wssfyy1c
sxpQWzWpZsQg5CjkkdKsK7uLoZEms3r4LmMIFMHeYCWiOGkPZscBzxebu7tRL4p5
5XOulcL26khcvcHoizuAEn6KOmC46/z10nTXLgHcBR8DJIUwqygnkr6kS1tS7k5H
f/A8boJj5EzCCUxDIUyM
=cm1t
-----END PGP SIGNATURE-----

--vSpEU07192KRa2oSUXF2rDnVJMbJ00EWW--

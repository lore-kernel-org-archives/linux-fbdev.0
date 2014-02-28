From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 16:48:35 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <5310BDE3.60603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="roAwPuOUc7NHFDP6snGqEM0QWwjUfuwwn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <20140228162752.GU21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228162752.GU21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--roAwPuOUc7NHFDP6snGqEM0QWwjUfuwwn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:27, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 02:20:07PM +0200, Tomi Valkeinen wrote:
>> Shortly about the display components in the series, in the order of pr=
obable
>> public interest:
>>
>> * Analog TV, DVI and HDMI Connectors represent a respective connector =
on the
>>   board. They don't do much, but they do mark the end of the video pip=
eline (from
>>   the board's pov), and they should also in the future offer ways to h=
andle
>>   things like the +5V pin on DVI and HDMI connector and HPD pin.
>=20
> The big thing which concerns me is that we're using very generic
> compatible strings here - has anyone done any searches to see whether
> there are any existing standards for this kind of stuff already?

I did look for any display related DT bindings when I started the work
on OMAP DSS DT bindings. I didn't really find any. If I recall right,
the only thing I found was an example of basically:

fb@1234567 {
	compatible=3D"asd";
	reg=3D<1234567>;
};

So just a node for "framebuffer", with the register addresses. And maybe
video timings in some form.

Maybe I didn't know where to look.

> Even if none can be found, if we're going to create something like
> this, it should probably become a public standard not just for Linux.

This is totally unclear to me. How does it become a public standard?
What's the forum for this?

> If we're not willing to do that, I'd suggest prefixing the compatible
> strings with "linux," as a "company" identifier so that there's no
> chance that we may hit some major problem caused by a conflicting
> implementation in the future.

I don't have an issue with "linux," either. We could always later remove
the prefix (but keep drivers compatible with it). So it sounds quite a
safe approach to me, if we're not quite clear if these bindings are
acceptable, or how to get "public approval" for them.

 Tomi



--roAwPuOUc7NHFDP6snGqEM0QWwjUfuwwn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEL3jAAoJEPo9qoy8lh71SbgP/RJoHYeVutprOHcRm69CgPC7
H9j6p5WiqsN6lUuEBc9ZVkByRSnsaMTcfduM1pAo9GPBAFTQJ1IOE+QiepAREBeF
U1e3DocLmVXqXK/TsjUetTVsHKag/wveW7Ni/TR2S89jRACRoHd4L7LkbQosyRAC
Oai0wHLvpMtlfq/q8uP5AAaPdxHIheCRjMz4uQYfRx7/udQ/9z2NVTJTXzCv+b5M
abI00jFBaTQ8VqiilVq6i0y9uEpNXpcJwq+9EayQ5xpF6YxsDxdqUX6Xz7hathss
MWC8paLkYPWyLyrgHI7kveJKkohrqQahC8beafDNsb/8HvxevPPc8KuWWShZ1cED
ajDJK7/qr2tKerUUIIEfj8AJHKcoP3UNPp6sg7OYBIiDOwAP1c3o4fNk9akO/HvX
d/bExfGsAd2d6Qix/iW7XDwShLpCecdCHfQV3X2ZX9HVrymGFPg95Xqah8vhvAqC
mvdqVfssD4Y4SkIRLWh57Kl5hU0shrn/lcni1qq2vzP+sD3rxBheCq+/o6gyTrwq
A7fnhak6BQ7E12Q9wDMQYCrwyhKq7NoevOFSIvxnTa9OA/if5gPAGHwgCo89t978
J2nwE9aAVZb4twXNYZpPy9c7GDwrHFs3B+F8JY7epfpevpjviAbHRJTNHxA+Pqjl
CkpOKPYPY8Ks/IdBMuvK
=dFZQ
-----END PGP SIGNATURE-----

--roAwPuOUc7NHFDP6snGqEM0QWwjUfuwwn--

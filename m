From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 11:21:58 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FC856.8060804@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5K2c5jK7Kx3tar0AmPS0u0To1GirMBexA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1381947912-11741-3-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com> <525FA4B0.8060504@ti.com> <20131017091614.GC2502@ulmo.nvidia.com> <525FB368.6020003@ti.com> <20131017104856.GA10993@ulmo.nvidia.com>
In-Reply-To: <20131017104856.GA10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--5K2c5jK7Kx3tar0AmPS0u0To1GirMBexA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 13:48, Thierry Reding wrote:

> As far as the simple panel device tree binding is concerned, it covers
> all the cases I know of. I can't seriously be expected to do any better=

> than that. These panels are dumb. They only come with a power supply
> that needs to be switched on and an additional GPIO to enable it once
> powered up. All three panels just work with that set of properties. So
> anything that doesn't can arguably be covered by some other, not-so-
> simple binding.

Agreed. I thought the DT bindings were missing information about the
video path, but I didn't realize you have a reference from the video
output to the panel.

However, I think there's usually a bit more information needed than what
you describe above. All the dump panels I know have requirements on the
sequences related to the video signal, powers and gpios, and delays
between those.

I guess the most common enable scenario is something like:

- enable video signal
- enable power
- wait n msecs
- set GPIO

For some panels, the enable GPIO might actually be a reset GPIO, not
enable. Some could want the video signal only be enabled after the
enable/reset is done.

Anyway, I think what you describe fits most of the panels, so no need to
worry about the possible ones I described. I just wanted to point out
that there may be very dump panels that are still different.

> I'm still missing the point here. For one, I don't see any reason that
> this driver would ever need to gain CDF support. At the same time, CDF
> could easily be supported by just adding a few required properties and
> it should be easy to support any non-CDF cases just as well to remain
> backwards-compatible.

Well, I guess the point here is that if you have a SoC display
controller driver and panel drivers, and you want to support complex
panels using CDF, you need to implement CDF support into your SoC
display controller driver in addition to adding CDF support to the panel
driver.

And, you still want to be able to use the simple panels. So either you
support both CDF panels and non-CDF panels with your SoC dispc, which
could be a bit messy, or you add CDF support to all panel drivers you use=
=2E

>> I guess one option there would be to implement a new driver for the sa=
me
>> panel devices, one that supports CDF, and leave the old one as is. Not=

>> so nice option, though.
>=20
> As I said, anything that really needs a CDF binding to work likely isn'=
t
> "simple" anymore, therefore a separate driver can easily be justified.

I think it's rarely the case that a panel specifically needs CDF. It's
more that CDF offers a common framework for display components, making
it easy to make them independent of the platform used. And if you make
your SoC support CDF, you are able to use all the CDF drivers already
implemented.

That said, I don't see anything technically preventing from having
support for both CDF and non-CDF panels. It's just more complex, and
they cannot be mixed freely. For example, if I have CDF support in my
SoC driver and a panel driver, I can easily add a CDF encoder driver in
between. But if the panel driver is a custom one, then I need a custom
encoder driver there also.

> Indeed. The fundamental point here seems to be that we don't represent
> things in DT which we don't need. In the same way that we don't add

Surely we should represent the things about the HW we don't need now, if
we know they might be needed in the future? (But that's not the case
here, see below)

> device nodes for enumerable devices, why would we need to explicitly ad=
d
> information about connections between devices that cannot be controlled=

> anyway. If the board connects an RGB/LVDS output to a panel directly, i=
t
> is only required that the output knows what it is connected to because
> there is no other way besides DT to obtain any information about the
> panel. Therefore a unidirectional connection is more than enough. Using=

> that the output can access the panel and query it for information such
> as the mode timings as well as switch it on or off as required.

Right, in that case, you do have all the necessary information in the
DT. I don't think it really matters if the link in DT is from the SoC to
the panel, vice versa, or both ways. It still describes the same thing.
Even with unidirectional link you can always find the reverse link, you
just need to do more work going throught the DT data.

 Tomi



--5K2c5jK7Kx3tar0AmPS0u0To1GirMBexA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX8hWAAoJEPo9qoy8lh711zUQAJywsDynJSo59aywR11QVQnn
UZSTLQ2kM4EP08dlxP/tufgJokAF9Bg9eA/gXZYE6/Z/NoTY68UsPMWoG8aJOKEk
5AyHF7yKpB7r8V1p0LZowrYzaf9pq0DQT/+mGoNdXDb4km6KvwFxYuhiQC/PEZ+e
OpP68X9DKC4jV1adJQxHZ8OgzwuRnNdlBCWMWMbi/x1EcdYPZfrsFuEYoAUzyPKj
wRDhBxpxIf14nQLHDWbJ+fxNOPYvuHF7akm6VQPXvwey72FUV8q7P7M5RifpzZq7
+gyCTV3rP/FZZSIlF3D2prU+wp0dB4lAaxEYRkfVA5F/SK6br+e5iud+hl5PYyuR
DskxpmDjlCWL4OD6k8vEhW+zjOaEQuPEqCXBuw95Z0YXSaJPJVziNkKm+TJTX4a+
35atBiki9BfNUVSMes5LYJlCS0na6h699cx0w2J5pofHfgiYpAR4/k9r55+SN4uy
K+slhGrGFbR9ZbSGrV/MgQICuODUpvSyIBkK97bgUd00FU2w1964mWeUN2UZ6wh3
uGqPWZpXmwxXMpV7zV8Gxbd0RUJ7Ugh1avLEzGMm6KfS8Y9Qm7fJIln7609Vl6Wi
slK6JQXUnEgnPfEB/9uCa6z8QJpRbVWsxCbqmF2yRMZ++S4N5aK6uPJmJdDl79xd
wS1BB5khdnptsA1190+K
=6KvH
-----END PGP SIGNATURE-----

--5K2c5jK7Kx3tar0AmPS0u0To1GirMBexA--

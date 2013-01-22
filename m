From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 22 Jan 2013 07:17:26 +0000
Subject: Re: [PATCH 0/3] pwm-backlight: add subdrivers & Tegra support
Message-Id: <20130122071726.GB14728@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s2ZSL+KKDSLx8OML"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com>
 <20130121074928.GE15508@avionic-0098.adnet.avionic-design.de>
 <6871054.sK10m5bePf@percival>
In-Reply-To: <6871054.sK10m5bePf@percival>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2013 at 05:18:11PM +0900, Alex Courbot wrote:
> Hi Thierry,
>=20
> On Monday 21 January 2013 15:49:28 Thierry Reding wrote:
> > Eventually this should all be covered by the CDF, but since that's not
> > ready yet we want something ad-hoc to get the hardware supported. As
> > such I would like to see this go into some sort of minimalistic, Tegra-
> > specific display/panel framework. I'd prefer to keep the pwm-backlight
> > driver as simple and generic as possible, that is, a driver for a PWM-
> > controlled backlight.
> >=20
> > Another advantage of moving this into a sort of display framework is
> > that it may help in defining the requirements for a CDF and that moving
> > the code to the CDF should be easier once it is done.
> >=20
> > Last but not least, abstracting away the panel allows other things such
> > as physical dimensions and display modes to be properly encapsulated. I
> > think that power-on/off timing requirements for panels also belong to
> > this set since they are usually specific to a given panel.
> >=20
> > Maybe adding these drivers to tegra-drm for now would be a good option.
> > That way the corresponding glue can be added without a need for inter-
> > tree dependencies.
>=20
> IIRC (because that was a while ago already) having a Tegra-only display=
=20
> framework is exactly what we wanted to avoid in the first place. This ser=
ies=20
> does nothing but leverage the callbacks mechanism that already exists in =
pwm-
> backlight and make it available to DT systems. If we start making a Tegra-
> specific solution, then other architectures will have to reinvent the whe=
el=20
> again. I really don't think we want to go that way.
>=20
> These patches only makes slight changes to pwm_bl.c and do not extend its=
=20
> capabilities. I agree that a suitable solution will require the CDF, but =
by=20
> the meantime, let's go for the practical route instead of repeating the s=
ame=20
> mistakes (i.e. architecture-specific frameworks) again.
>=20
> There are certainly better ways to do this, but I'm not convinced at all =
that=20
> a Tegra-only solution is one of them.

Well, your proposal is a Tegra-only solution as well. Anything we come
up with now will be Tegra-only because it will eventually be integrated
with the CDF.

Trying to come up with something generic would be counter-productive.
CDF *is* the generic solution. All we would be doing is add a competing
framework.

Thierry

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ/j0GAAoJEN0jrNd/PrOhOuQQAK5hPcg/D4s2hP5Sltz9NBlr
1QypTElCABBHL3nBwsZodzdav7ohF0yOEO8g7XoI0IZWGNnTjwhgYcUMtcA3CU8Q
7eU4LbBxvC42jBTV+V2/6BpwAvp4nmwV7L0N1r1uaWo52tHvu3SD1WLoa5flAfcm
Pjn2EBEt7Xt4RNsZTfo+nHi0QdnFAYHmSzuDEQVAytnLN8A/5l/eIg/d3wErneHf
fBosH42LdlpI6Y/Um5BWssaHnYSkEDCEkPp/UImzScDOrmVzlig+t4i3oii9o/kC
aHDVcbN7i9MbvG+3Xmrv0MLJuSgfrGZ7pGVbPtzlSIVkR1w2PLcZIrZCnwo3DV90
wVOtBE6os7+MvHufnit2r9qQOK7fM5PsW2YxRPh1JZsKF87r6wtCwtbjkMHMNXcX
bkAY9tQ9OMPl67wQw9WQS1TRO6ahX9/jY9TBzaFKeMoLN0FpZHNOs30I0ZItNREo
8atYe5TyUEn4RMSVDtK4cdWVjL+lE85huwRB3dI0A/7ODSCVgA5yqfYjhwK3cQ5y
KeQ/gCCD9nCiI3FzZ1HO8S4ga5b68FQDTF/Rme39/VOh5bVy/NBaz4bFKoelQ5G8
JD8H/754TEy3vPEQktEorXBqzoeP3M+AFwhdnYwYdu/ukgeUZxgxhlhCfajEz6V0
z3GE3hxLn9NwCZQVfvXS
=y55v
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 01 Nov 2013 09:12:17 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <20131101091217.GB27864@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
	<20131030120229.GF24559@pengutronix.de>
	<CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
In-Reply-To: <CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 10:10:41AM +1000, Dave Airlie wrote:
> >> After looking at some of the ordering issues we've had with x86 GPUs
> >> (which are really just a tightly coupled SoC) I don't want separate
> >> drivers all having their own init, suspend/resume paths in them as I
> >> know we'll have to start making special vtable entry points etc to
> >> solve some random ordering issues that crop up.
> >
> > The DRM device has to be initialized/suspended/resumed as a whole, no
> > doubt about that. If that's not the case you indeed open up the door for
> > all kinds of ordering issues.
> >
> > Still the different components can be multiple devices, just initialize
> > the drm device once all components are probed. Remove it again once a
> > component is removed. Handle suspend in the DRM device, not in
> > the individual component drivers. The suspend in the component drivers
> > would only be called after the DRM device is completely quiesced.
> > Similarly the resume in the component drivers would not reenable the
> > components, this instead would be done in the DRM device when all
> > components are there again.
>=20
> But why? why should we have separate drivers for each component of a
> tightly coupled SoC?
>=20
> it makes no sense, having a driver node per every block in the chip
> isn't an advantage, it complicates
> things for no advantage at all. If we don't have hotplug hw removing
> one device shouldn't be possible
> this idea that removing a sub-driver should teardown the drm is crazy as =
well.

In my opinion separating things out into separate drivers makes it less
complicated. For instance it makes it very easy to manage the various
resources used by each driver (registers, interrupts, ...).

The only added complexity lies in the fact that we need some code to
synchronize the DRM device setup and teardown (and suspend and resume
for that matter). It's been discussed elsewhere that most SoCs are very
similar in their requirements, so I think we should be able to come up
with a piece of code that can be shared between drivers. Perhaps it
would even be possible to share that code between subsystems, since ALSA
and V4L2 may have similar requirements.

That's effectively not very different from what you're proposing. As far
as I can tell the only difference would be that this works in sort of a
"bottom-up" fashion, whereas your proposal would be "top-down".

Thierry

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc3BxAAoJEN0jrNd/PrOhqbcQALZGhtXzlFGmvSqmtd2oXWfx
9IPq7koxUVtyUVehdzufxEQ6/EBcZa+4j9m5iPoButT2Zb6682V74pjjFqVmN19O
Qu2+8BeXhCWRtB+J1mgHcBeaoW19Tb3krI/Z1fsM5zofESd4BAZa0HXsqXez1+aL
3BUxsU+CZSA+fvVFP0SzGvPOR7MwnqpNGVl03k8JvrEoJDIVsVK9R3RkaW0jUzTH
SoR90meU4JaXB5tHZluKz5E3XO9Z46v7akR1kFYV4eiE4v1VxH3C/iTkYjEDf35K
JfY9uHcl6bM4SJmRj0kR9+8Q0BjNE7n1FBSeB6Prp/f8yCyM7kuhJ/ZKOQG5K5SV
ogj+E+Ra7N+7306IChEChRfM0y8+rWNkQX45/BCGSDAIeSEdgF9Ko99AibyguJob
uCXIGJdRLN7GW/kL+w8e61eCHmsvdlLvDUQLRnp3JD/Ubaho9PvhtnVKuhyBfzK0
1dYU9nZWJbeamAR3x8NSerXffNZboJtwfmOz5bXdlHnByad5lNTBqQlUXzBXvZAW
fI5jn4LLYVR+wQsgZ8G3qYNxDyDGAn9v9k4Bvr1WnmjLPek/UY/yU1SvkQ0j3ibz
Z4hLB5+u9geI11N+A2q4xHfCnDTJdqtzSOiBqtAhEfF8LjF7hXccsY1ZHgc2Fb+q
kG9hDzQ7ZLq9DOBWRxKm
=tmlp
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

From: Mark Brown <broonie@kernel.org>
Date: Fri, 01 Nov 2013 00:32:28 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <20131101003228.GM2493@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="deSP9Bnrq3taYiYM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
	<20131030120229.GF24559@pengutronix.de>
	<CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
In-Reply-To: <CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>


--deSP9Bnrq3taYiYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 10:10:41AM +1000, Dave Airlie wrote:

> > Still the different components can be multiple devices, just initialize
> > the drm device once all components are probed. Remove it again once a

> But why? why should we have separate drivers for each component of a
> tightly coupled SoC?

> it makes no sense, having a driver node per every block in the chip
> isn't an advantage, it complicates
> things for no advantage at all. If we don't have hotplug hw removing
> one device shouldn't be possible
> this idea that removing a sub-driver should teardown the drm is crazy as well.

One case where this may be required is for integration with SoC power
domains where the DRM components are split between multiple domains (and
it may be more idiomatic even if they aren't).  If the SoC is using
power domains then it will expect to see at least one device within each
domain that gets used to reference count the activity for the domain.

This could just be a composite device per domain though.

--deSP9Bnrq3taYiYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScvaTAAoJELSic+t+oim9KqIP/3IsTcq8aj9P9FTnoczU7iDt
JV01Z77gn7WUyuglhXUVlkcrFerUpnGuQjK+SVZFkKo5QTjk5x5Rq//mhQh5lmOo
Nm3WmmYREc8ICqgSJvK+EmaIUAKDuPvEvGcqkgK7ZOzhXDsjDq5ftr75etKJ2wBF
1xlC94W6PmVegZIwawU3HzKuVPYK7sRfXeRlaQG4wpmyubSq9H6IYgVC/db0R04c
wlcNcMGGuKii7/mcBlHesnk/bS1aNUEtm9s1rm4jvUhTYGUawM0w1bSN4WHlte9W
+CmRqetSu+er6A5nvXYksfT14gC2akF5+JyHi7GqpFpWIzC2Ku4cqW3vMBjvfiev
FEukUxmlhEDG4E9rg4mDwTNX1tkHG6wuo0rJnTeuhy/TMrGUHxHMruSSxPvcxGZl
nMD/n5mcJMxomNB9VneNjcWES/SmO0Jb2L+lZm4i1WGEnZ9FoCPeaVOeF/yR09JW
MrrrdCd/6XdDkTk9Y+2O8y78E8gP/Pq0PriZG5RdxOp2JTaQcLTr+w9KucezVMuE
M6qGeKuubBlVPgY5MrFWAgdFodYkZqXXIi6ZeooxJ3RmsblOhSAUdjKyY658xsH3
i60DAqRY0hb42DCKQVV+u+slMIq6PmgmbDdCML219N4tBIDktStCb28TvlcaGYkP
kDO4AdB0Q6nq26TzjPiE
=0F1I
-----END PGP SIGNATURE-----

--deSP9Bnrq3taYiYM--

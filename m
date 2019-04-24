From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 24 Apr 2019 14:24:15 +0000
Subject: Re: [PATCH v6 3/3] backlight: lm3630a: add firmware node support
Message-Id: <20190424142415.GB20237@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oLBj+sq0vYjzfsbl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-4-masneyb@onstation.org>
In-Reply-To: <20190424092505.6578-4-masneyb@onstation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 05:25:05, Brian Masney wrote:
> Add fwnode support to the lm3630a driver and optionally allow
> configuring the label, default brightness level, and maximum brightness
> level. The two outputs can be controlled by bank A and B independently
> or bank A can control both outputs.
>=20
> If the platform data was not configured, then the driver defaults to
> enabling both banks. This patch changes the default value to disable
> both banks before parsing the firmware node so that just a single bank
> can be enabled if desired. There are no in-tree users of this driver.
>=20
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAcY8ACgkQMOfwapXb+vKHZQCfZ7wxHT3lFTEQnSgosEPjRAN9
PWkAniD///EKrdym1kbPKR1X8qxmD136
=BW+m
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

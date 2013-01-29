From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 29 Jan 2013 10:00:48 +0000
Subject: Re: [PATCH 4/4] pwm_backlight: Add support for the whole range of the PWM in DT mode
Message-Id: <20130129100048.GB16746@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
 <1358861996-27194-5-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1358861996-27194-5-git-send-email-peter.ujfalusi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2013 at 02:39:56PM +0100, Peter Ujfalusi wrote:
> When booting with DT make it possible to use the whole range of the PWM w=
hen
> controlling the backlight in a same way it is possible when the kernel is
> booted in non DT mode.
> A new property "max-brightness-level" can be used to specify the maximum
> value the PWM can handle (time slots).
> DTS files can use either the "brightness-levels" or the "max-brightness-l=
evel"
> to configure the PWM.
> In case both of these properties exist the driver will prefer the
> "brightness-levels" over the "max-brightness-level".
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I don't think this is a good idea. The brightness-levels property was
specifically introduced in order to have a more reasonable interface to
specify brightness levels.

As such, all uses of the non-DT max_brightness to be deprecated. It is
only kept for backwards compatibility with non-DT boards.

Thierry

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRB53PAAoJEN0jrNd/PrOhK6QP/36pZHyxxK8EP60C61b4fQ2D
DiIGJ4FY++Bveqc92sjV0bhTsKd/XO6u8aRZOBZZDIu+VjATupPfE+7SMEgSMXa3
7ZoYwdm0t1enfMY776vTKLNAXK6EEuGZJ/CNAE0sJCYUKhP0kwLBtJUzmt/fSZ7Y
yOH41X4mt3083vhbPphep/YBO4q4lesZl53KNLbGmPw2SB/I8uBbtupl4y59lzfd
PLmJb6Kby8eRKFdeCxatbDTbbHILFFOjKlWCtfUgUh+VmkGS73e3klWfhsmrgstU
5SlmUg5OxTWGc9+I6cBEsjx5E9TMcJk3rhuCdwJlYJ06S6bRNFftulhFLU6nMuWB
qrUZOyfh/AdzEiUMWPPqgvJh7SYbYp6mJHdi7dwzJHLTITaR6UDKtS+oJVH0jhvu
vvB9qOY1zsw6Vzovy9CQzqCw0iLCtpcRd1DFiz+krWl9VXw8pk0rXVdW/TbOJI5+
xXz3wXuqhx77ipOXx5a/V3bKBAaei7pPrOQDANOBCzJE8gPY6EtTyhD5uUZt3ilp
YqZfXsGeG5aUjpwFuuHk0YJitFTwHZZ19W2XY/tq0Pj+YQK3CcqzJFWoCFiLU1Kh
nYLxO8KGj7L0OZf2XlTMlEnAyppDURg+SNTaNL61QKv16fIXmYb6vh/nK1YppP3R
y/X1ohi/tnzCuSBkO+ng
=EerR
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

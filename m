From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 23 Aug 2012 19:04:02 +0000
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Message-Id: <20120823190402.GA8127@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de> <50366628.5020007@metafoo.de>
In-Reply-To: <50366628.5020007@metafoo.de>
To: linux-arm-kernel@lists.infradead.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 07:19:36PM +0200, Lars-Peter Clausen wrote:
> On 08/23/2012 07:12 PM, Lars-Peter Clausen wrote:
> >[...]
> > Or maybe just use the runtime pm API for this. This probably makes even=
 more
> > sense and grab a reference to the pm context when the enable() is calle=
d,
> > release it when disable() is called and also grab it before calling the
> > device's config callback and release it afterward.
>=20
> Btw. this seems to be exactly what the pwm-tiecap and pwm-tiehrpwm drivers
> already do today. I'd just make that a core PWM framework feature.

Using runtime PM for this sounds indeed like the most generic approach.
I'm not very familiar with the API, but I thought it required explicit
architecture or bus support (or the driver itself can provide hooks via
pm_ops), so it might be difficult to implement for platforms that don't
have working runtime PM support. I'll have to look into this some more.

Anyway, if we add this kind of support to the PWM core we should take it
through next first. For drivers that are currently broken, they should
be, as you said, fixed by enabling the clock before reconfiguring and
disable it after (unless the PWM is enabled) like Tegra does.

Thierry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQNn6hAAoJEN0jrNd/PrOhbZUQALCCmw0uie9t60hTMAAFNJBK
phFnATVrHoXdW5pnG7G7b2sAc6zFIYgK29rDyS//uB0Fv8JNUp0+01QsZf/mSvh5
aUr+FYR0QoUuMSvdJyq3H2oDc3HRnCHNBnv4lAVS7AwbJyzJMw4YwqO+sTaS0E8S
+eKz8BDK3L3IAvUkn3XiUHYGBlaTCEuQBF+pohcARplHksTOmzA0KR4EMrJG7vOC
iUAH3BPD1BuZl/wXZgGVG4PUCU26wXi9brBp/0JXvIFq412Z5VbWhlTu0sNml1pN
+a5gD+PgspwMURaQHsMv8m647yfV+6/QMya5gPMTCAq1dqFIc7mUQFnG6qmpAE6C
t0hYU8ymZURPDrlS8o3V9fcOaiRdIMZNND7RSSIg+4QNA4m9jb94hS4/vnDLA3Gh
uIQVBQwMD6Tp+wLKq2pn7KgBDPeeZ2NLd9AbYlgK2yP7zB5p5uZbTe3fjxG3dIod
+8O0nzgQGpxJQxLaWnKA7Ue1SB2pRwawA3LV7q8c8r1vcuu1kWYSYZeaugSs/v0N
oLRCsmYvrFV/bpsa+OhaC+03NsVuSpIU/+NhrEjnGVxHGj9GJFt5IZbSLX6EMEij
H0a1htgwZBv0GPjCEXgqLOWV3ibsWo5mnzzomJLZZ5WEGyuvDdxon+XdbnxQ7LQI
X3XJBYlIat8vaM3SEYML
=81uJ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

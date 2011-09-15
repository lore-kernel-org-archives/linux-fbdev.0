From: Keith Packard <keithp@keithp.com>
Date: Thu, 15 Sep 2011 14:59:32 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <yunboul7sx7.fsf@aiko.keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
In-Reply-To: <1316088425.11294.78.camel@lappyti>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org
Cc: "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Sep 2011 15:07:05 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:

> This was a very rough and quite short proposal, but I'm happy to improve
> and extend it if it's not totally shot down.

Jesse Barnes has put together a proposal much like this to work within
the existing DRM environment. This is pretty much the last piece of
missing mode-setting functionality that we know of, making DRM capable
of fully supporting existing (and planned) devices.

Here's a link to some older discussion on the issue, things have changed
a bit since then and we had a long talk about this during the X
Developers' Conference this week in Chicago. Expect an update to his
proposal in the coming weeks.

http://lists.freedesktop.org/archives/dri-devel/2011-April/010559.html

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOchLUQp8BWwlsTdMRAm8uAJ9sgDb5o2PVt4z7BF94byaVY4P8jACgpvFP
8CNUnoiylJ9Phg6SI0fLegU=
=aRky
-----END PGP SIGNATURE-----
--=-=-=--

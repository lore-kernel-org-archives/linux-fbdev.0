From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 30 Jul 2017 09:47:26 +0000
Subject: Re: [PATCH] fbcon: Use background color for margins
Message-Id: <20170730094726.GB18381@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TRYliJ5NKNqkz5bu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501273590-3237-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501273590-3237-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Screens that don't have a black border around the active area will have
> ugly black bars for the margin when the text background color is not blac=
k.
> This is especially noticeable on an LCD screen (not the backlit kind) when
> the terminal colors are inverted.

Are you sure? It is quite common to have different backgrounds in
different parts of the screen, how it is supposed to work there?

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll9qy4ACgkQMOfwapXb+vKKpACffuof4ce9nqRhKz5KPF6iu+8N
7zcAoJyiWz7iWlEM17aEY2CNYCgwWZgV
=LEcP
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 30 Jul 2017 21:51:08 +0000
Subject: Re: [PATCH] fbcon: Use background color for margins
Message-Id: <20170730215108.GA806@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501273590-3237-1-git-send-email-david@lechnology.com>
 <20170730094726.GB18381@amd>
 <2cafbde9-6b31-9586-e3eb-0b80355eab3c@lechnology.com>
In-Reply-To: <2cafbde9-6b31-9586-e3eb-0b80355eab3c@lechnology.com>
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>Screens that don't have a black border around the active area will have
> >>ugly black bars for the margin when the text background color is not bl=
ack.
> >>This is especially noticeable on an LCD screen (not the backlit kind) w=
hen
> >>the terminal colors are inverted.
> >
> >Are you sure?
>=20
> Of course I am sure. Otherwise I would not send a patch. ;-)
>=20
> I have attached some pictures to explain it better. The default-console.j=
pg
> picture shows what it looks like using just defaults. I think it is hard =
to
> read the white text with the black background.
>=20
> So, the solution is to invert the terminal colors. But when you do this, =
the
> margins are not inverted, so you are left with black bars on the bottom a=
nd
> the right as seen in inverted-without-patch.jpg.
>=20
> With this patch applied, the margins are also inverted, so you don't have
> the black bars as seen in inverted-with-patch.jpg. I think this is much
> nicer.
>=20
>  It is quite common to have different backgrounds in
> >different parts of the screen, how it is supposed to work there?
>=20
> There will be nothing different in this regard. Only the margins (non-text
> area) are changed.

So you have something like midnight commander, which uses colors.

Lets say top half of screen is normal, bottom one is inverted. What
color will borders be?

Will not they do something stupid (such as changing) when the
curses-based application refreshes?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAll+VMwACgkQMOfwapXb+vLjmQCdFfHQkvSBaxsawhlMKulCiYJu
ZRcAl0Ne5eSvqtz3eBEndpJ6IeDJ2As=
=jXvE
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

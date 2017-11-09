From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 09 Nov 2017 18:45:23 +0000
Subject: Re: [RFC 00/14] Kernel based bootsplash
Message-Id: <20171109184523.GA32246@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
 <1510230976.2975.10.camel@suse.com>
In-Reply-To: <1510230976.2975.10.camel@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: Max Staudt <mstaudt@suse.de>, michal@markovi.net, b.zolnierkie@samsung.com, Michal Srb <MSrb@suse.com>, Stefan Dirsch <sndirsch@suse.com>, Takashi Iwai <tiwai@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-11-09 13:36:16, Oliver Neukum wrote:
> Am Donnerstag, den 09.11.2017, 12:56 +0100 schrieb Pavel Machek:
> >=20
> > "More reliable bootsplash" seems like an anti-goal. More reliable boot
> > should be the goal...
> >=20
> > You should be able to display nice splash screen from initrd...
> >=20
> > We may want to fix the blinking cursor.
> >=20
> > But if there are warnings, it is better to see the warnings then to
> > hide them. If root filesystem can't be mounted (for example) it is
> > good to know the reason, not to stare at the blank screen (or at boot s=
plash).
>=20
> Hi,
>=20
> well you are not required to use a boot splash. Though I note that
> many people want a boot splash. However, if you use a boot splash
> at all, you will not see the messages, so how does it matter to you
> if it comes out of the initrd?

Of course I'm not required to use it.

OTOH you don't need to patch kernel to get nice bootsplash. If it
means improving "quiet" option to hide the cursor, so be it. You
should be able to do the rest, already.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloEokMACgkQMOfwapXb+vJmYQCgiKkIWb5cR+X2PLklq3Yii4Tu
iI4AnR7L3r3fwOPtrciPqjD+UGvgwfaz
=3NbB
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

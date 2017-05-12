From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 12 May 2017 09:47:12 +0000
Subject: Re: setting brightness as privileged operation?
Message-Id: <20170512094712.GA29780@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170105092307.GD21618@dhcp22.suse.cz>
 <20170511210755.GA1360@xo-6d-61-c0.localdomain>
 <20170512062003.GB6803@dhcp22.suse.cz>
In-Reply-To: <20170512062003.GB6803@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-05-12 08:20:04, Michal Hocko wrote:
> On Thu 11-05-17 23:07:55, Pavel Machek wrote:
> > On Thu 2017-01-05 10:23:07, Michal Hocko wrote:
> > > Hi,
> > > I have just learned that my Xfce Power Manager cannot manipulate
> > > brightness because I do not have policykit installed on my computer.
> > > There is a reason for that (yeah it depends on systemd which I prefer
> > > not have).
> > >=20
> > > While this is clearly a problem of the Xfce applet I am wondering why
> > > setting the brightness has to be a privileged operation at all. Is th=
ere
> > > any strong reason for it or just a general policy that we do not give
> > > world writable files into sysfs?
> >=20
> > Well, if you have another user logged in using ssh, and changing _your_
> > brightness, that will be somehow annoying, right?
>=20
> I am pretty sure that such a user can do much larger harm than playing
> with brigtness of my LCD. Anyway I went with my own rc.local hack.

Can he? Those are bugs to be fixed. We don't want them in kernel...
=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkVhKAACgkQMOfwapXb+vKd7ACdFWP6iqrXw4NSWv4g+GI3y6YR
xgwAnRBA77pNstMnPbmXP/T3GdCXO54X
=xH/j
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 24 Aug 2011 14:33:53 +0000
Subject: Re: linux-next tree addition request (fbdev)
Message-Id: <20110825003353.e930fc7a664dd99c953b555c@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__25_Aug_2011_00_33_53_+1000_=xgTexAEta=XP+=p"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E54FF5E.5050308@gmx.de>
In-Reply-To: <4E54FF5E.5050308@gmx.de>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-next@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

--Signature=_Thu__25_Aug_2011_00_33_53_+1000_=xgTexAEta=XP+=p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, 24 Aug 2011 13:40:46 +0000 Florian Tobias Schandinat <FlorianSchand=
inat@gmx.de> wrote:
>
> can you please add
>=20
>     git://github.com/schandinat/linux-2.6.git fbdev-next
>=20
> to linux-next. It collects patches for the frame buffer subsystem.
> Can you please add the linux-fbdev@vger.kernel.org mailing list as additi=
onal
> contact for warnings/errors/problems?
>=20
> You probably want to drop Paul's fbdev branches as they contain some outd=
ated
> patches that will conflict with the newer versions.

OK, Paul is still listed as the frame buffer subsystem maintainer, so I
will need an Ack from him.  When I get that, I will replace his tree with
yours.  I assume someone will update the MAINTAINERS file.

I also have another tree from Paul (called fbdev-current) that contained
fixes for Linus' current release.  I also assume that that tree will be
dropped (unless you have a new version of that as well).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__25_Aug_2011_00_33_53_+1000_=xgTexAEta=XP+=p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOVQvRAAoJEDMEi1NhKgbsEOcH/3wCn0iMaNZAAasPjX8aXF36
SDlt4fGzveRm5mIfXlg1GPzIE5P/o1y3BPFCwgTJo7o8LQN14JJ4JMkT6bx+M2SD
ha9wTwSF1Y01Y8piXQX4Sa00xl1zgsyKtdQIjqmuXalJQ8BQbkZ3XYSk/mCaBZje
i0ZtT/DtHCN79iAv7zYQDoq1+Zp/7+uDJIodXwSnHMxPZOIWNEC+k8IpaAREFRab
M3XbhtzoqX0bqOMCYiW5yW50Bk73DhoOGz/hGDPWCU0PN45loS9HfiuFg/fvirNk
lmFj9Z0pdngxyyV9pTqgwGkTSn9HT0p1FTTjaixGdbIRKZvwKd3GorplVgXphjA=
=XQdJ
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Aug_2011_00_33_53_+1000_=xgTexAEta=XP+=p--

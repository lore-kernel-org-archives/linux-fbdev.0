From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 28 Aug 2011 16:19:30 +0000
Subject: Re: linux-next tree addition request (fbdev)
Message-Id: <20110829021930.0112cf98fbafd7380e09e164@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__29_Aug_2011_02_19_30_+1000_IE=WWgzYn0Exr8eh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E54FF5E.5050308@gmx.de>
	<20110825003353.e930fc7a664dd99c953b555c@canb.auug.org.au>
In-Reply-To: <20110825003353.e930fc7a664dd99c953b555c@canb.auug.org.au>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-next@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

--Signature=_Mon__29_Aug_2011_02_19_30_+1000_IE=WWgzYn0Exr8eh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Thu, 25 Aug 2011 00:33:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 24 Aug 2011 13:40:46 +0000 Florian Tobias Schandinat <FlorianScha=
ndinat@gmx.de> wrote:
> >
> > can you please add
> >=20
> >     git://github.com/schandinat/linux-2.6.git fbdev-next
> >=20
> > to linux-next. It collects patches for the frame buffer subsystem.
> > Can you please add the linux-fbdev@vger.kernel.org mailing list as addi=
tional
> > contact for warnings/errors/problems?
> >=20
> > You probably want to drop Paul's fbdev branches as they contain some ou=
tdated
> > patches that will conflict with the newer versions.
>=20
> OK, Paul is still listed as the frame buffer subsystem maintainer, so I
> will need an Ack from him.  When I get that, I will replace his tree with
> yours.  I assume someone will update the MAINTAINERS file.
>=20
> I also have another tree from Paul (called fbdev-current) that contained
> fixes for Linus' current release.  I also assume that that tree will be
> dropped (unless you have a new version of that as well).

Ping?  Anyone?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__29_Aug_2011_02_19_30_+1000_IE=WWgzYn0Exr8eh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOWmqSAAoJEDMEi1NhKgbsm3wH/3Gr1mwmr9v02MFM9canOJRW
3QDvUqTGO4BV+04oDScE3t6GlA2xQhVwy68e58fRX4H+yMLjSMu/eobMIU/FooM4
amIjc1szHYPMcU5Rtc+7/3Ct2PfhtyeyYHraKbFlSqhQL3Qgc7+Eki3WxPop6QR2
5I/WU1sLyWNmT7oA4yal9GuVg9CdklHSxktOZvnuTYHudj1sno/imrvj/X1zaMnu
UAwur18Uoc82/aC1Uutp9QfJ50hSFHtMi4Csk6Jruz00cHPLmHYvddDP+RxjaR8c
7SCk8byiUfcY8lgxANeoeof2/MenmgRswYHp5cnOl+9fnCCgWCjxDBfi8zNL8TA=
=hXHm
-----END PGP SIGNATURE-----

--Signature=_Mon__29_Aug_2011_02_19_30_+1000_IE=WWgzYn0Exr8eh--
